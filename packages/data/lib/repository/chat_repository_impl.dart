import 'dart:developer';

import 'package:data/models/group_model.dart';
import 'package:data/models/my_chat_model.dart';
import 'package:data/models/text_message_model.dart';
import 'package:data/models/user_model.dart';
import 'package:domain/entities/engage_user_entity.dart';
import 'package:domain/entities/group_entity.dart';
import 'package:domain/entities/my_chat_entity.dart';
import 'package:domain/entities/text_messsage_entity.dart';
import 'package:domain/entities/user_entity.dart';
import 'package:domain/repository/chat_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepository implements IChatRepository {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  String _verificationId = "";

  ChatRepository(this.fireStore, this.auth, this.googleSignIn);

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollection = fireStore.collection("users");
    final uid = await getCurrentUId();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        name: user.name,
        uid: uid,
        phoneNumber: user.phoneNumber,
        email: user.email,
        profileUrl: user.profileUrl ?? "",
        isOnline: user.isOnline,
        status: user.status,
        dob: user.dob,
        gender: user.gender,
      ).toDocument();
      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
        return;
      } else {
        userCollection.doc(uid).update(newUser);
        Future.value(null);
        return;
      }
    }).catchError((error) {
      log(error);
    });
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signInWithPhoneNumber(String pinCode) async {
    final AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: pinCode);
    await auth.signInWithCredential(authCredential);
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    phoneVerificationCompleted(AuthCredential authCredential) {
      log("phone is verified : token ${authCredential.token}");
    }

    phoneVerificationFailed(FirebaseAuthException authCredential) {
      log("phone failed ${authCredential.message},${authCredential.code}");
    }

    phoneCodeAutoRetrievalTimeout(String verificationId) {
      _verificationId = verificationId;
      log("time out $verificationId");
    }

    phoneCodeSent(String verificationID, [int? forceResendingToken]) {
      _verificationId = verificationID;
      log("sendPhoneCode $verificationID");
    }

    auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
  }

  @override
  Future<String> getChannelId(EngageUserEntity engageUserEntity) {
    final userCollectionRef = fireStore.collection("users");
    log("uid ${engageUserEntity.uid} - otherUid ${engageUserEntity.otherUid}");
    return userCollectionRef
        .doc(engageUserEntity.uid)
        .collection('chatChannel')
        .doc(engageUserEntity.otherUid)
        .get()
        .then((chatChannelId) {
      if (chatChannelId.exists) {
        return chatChannelId.get('channelId');
      } else {
        return "not exists";
      }
    });
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    final userCollection = fireStore.collection("users");
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<String> createOneToOneChatChannel(
      EngageUserEntity engageUserEntity) async {
    //User Collection Reference
    final userCollectionRef = fireStore.collection("users");

    final oneToOneChatChannelRef = fireStore.collection("OneToOneChatChannel");
    //ChatChannelMap
    userCollectionRef
        .doc(engageUserEntity.uid)
        .collection("chatChannel")
        .doc(engageUserEntity.otherUid)
        .get()
        .then((chatChannelDoc) {
      //Chat Channel exists
      if (chatChannelDoc.exists) {
        return chatChannelDoc.get('channelId');
      }

      final chatChannelId = oneToOneChatChannelRef.doc().id;

      var channel = {'channelId': chatChannelId};
      var channel1 = {
        'channelId': chatChannelId,
      };

      oneToOneChatChannelRef.doc(chatChannelId).set(channel);

      //currentUser
      userCollectionRef
          .doc(engageUserEntity.uid)
          .collection('chatChannel')
          .doc(engageUserEntity.otherUid)
          .set(channel);

      //otherUser
      userCollectionRef
          .doc(engageUserEntity.otherUid)
          .collection('chatChannel')
          .doc(engageUserEntity.uid)
          .set(channel);

      return chatChannelId;
    });
    return Future.value("");
  }

  @override
  Future<void> sendTextMessage(
      TextMessageEntity textMessageEntity, String channelId) async {
    final messagesRef = fireStore
        .collection("groupChatChannel")
        .doc(channelId)
        .collection("messages");

    //MessageId
    final messageId = messagesRef.doc().id;

    final newMessage = TextMessageModel(
      content: textMessageEntity.content,
      messageId: messageId,
      receiverName: textMessageEntity.receiverName,
      recipientId: textMessageEntity.recipientId,
      senderId: textMessageEntity.senderId,
      senderName: textMessageEntity.senderName,
      time: textMessageEntity.time,
      type: textMessageEntity.type,
    ).toDocument();

    messagesRef.doc(messageId).set(newMessage);
  }

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelId) {
    final oneToOneChatChannelRef = fireStore.collection("groupChatChannel");
    final messagesRef =
        oneToOneChatChannelRef.doc(channelId).collection("messages");

    return messagesRef.orderBy('time').snapshots().map((querySnap) => querySnap
        .docs
        .map((queryDoc) => TextMessageModel.fromSnapshot(queryDoc))
        .toList());
  }

  @override
  Future<void> addToMyChat(MyChatEntity myChatEntity) async {
    final myChatRef = fireStore
        .collection("users")
        .doc(myChatEntity.senderUID)
        .collection("myChat");
    final otherChatRef = fireStore
        .collection("users")
        .doc(myChatEntity.recipientUID)
        .collection("myChat");

    final myNewChatCurrentUser = MyChatModel(
      channelId: myChatEntity.channelId,
      senderName: myChatEntity.senderName,
      time: myChatEntity.time,
      recipientName: myChatEntity.recipientName,
      recipientPhoneNumber: myChatEntity.recipientPhoneNumber,
      recipientUID: myChatEntity.recipientUID,
      senderPhoneNumber: myChatEntity.senderPhoneNumber,
      senderUID: myChatEntity.senderUID,
      profileUrl: myChatEntity.profileUrl,
      isArchived: myChatEntity.isArchived,
      isRead: myChatEntity.isRead,
      recentTextMessage: myChatEntity.recentTextMessage,
      subjectName: myChatEntity.subjectName,
    ).toDocument();
    final myNewChatOtherUser = MyChatModel(
      channelId: myChatEntity.channelId,
      senderName: myChatEntity.recipientName,
      time: myChatEntity.time,
      recipientName: myChatEntity.senderName,
      recipientPhoneNumber: myChatEntity.senderPhoneNumber,
      recipientUID: myChatEntity.senderUID,
      senderPhoneNumber: myChatEntity.recipientPhoneNumber,
      senderUID: myChatEntity.recipientUID,
      profileUrl: myChatEntity.profileUrl,
      isArchived: myChatEntity.isArchived,
      isRead: myChatEntity.isRead,
      recentTextMessage: myChatEntity.recentTextMessage,
      subjectName: myChatEntity.subjectName,
    ).toDocument();
    myChatRef.doc(myChatEntity.recipientUID).get().then((myChatDoc) {
      if (!myChatDoc.exists) {
        myChatRef.doc(myChatEntity.recipientUID).set(myNewChatCurrentUser);
        otherChatRef.doc(myChatEntity.senderUID).set(myNewChatOtherUser);
        return;
      } else {
        if (kDebugMode) {
          print("update");
        }
        myChatRef.doc(myChatEntity.recipientUID).update(myNewChatCurrentUser);
        otherChatRef.doc(myChatEntity.senderUID).set(myNewChatOtherUser);

        return;
      }
    });
  }

  @override
  Stream<List<MyChatEntity>> getMyChat(String uid) {
    final myChatRef =
        fireStore.collection("users").doc(uid).collection("myChat");

    return myChatRef.orderBy('time', descending: true).snapshots().map(
      (querySnapshot) {
        return querySnapshot.docs.map((queryDocumentSnapshot) {
          return MyChatModel.fromSnapshot(queryDocumentSnapshot);
        }).toList();
      },
    );
  }

  @override
  Future<void> createNewGroup(
      MyChatEntity myChatEntity, List<String> selectUserList) async {
    log("createNewGroup ${myChatEntity.channelId}");
    if (kDebugMode) {
      print(myChatEntity.senderUID);
    }
    await _createGroup(myChatEntity, selectUserList);
    // final myChatRef = fireStore
    //     .collection("users")
    //     .doc(myChatEntity.senderUID)
    //     .collection("myChat");
    //
    // final groupChatRef = fireStore.collection("groupChatChannel");
    // var channel = {'channelId': myChatEntity.channelId};
    //
    //
    // await groupChatRef.doc(myChatEntity.channelId).set(channel).then((value)async {
    //
    //
    //
    //   // myChatRef.doc(myChatEntity.channelId).set(myNewChatCurrentUser).catchError((error) {
    //   //   print(error);
    //   // });
    // });
    /*
        user -> uid -> myChatCollection ->  xyzGroup
        */
    // selectUserList.forEach((otherUid) {
    //   otherChatRef.doc(otherUid)
    //       .collection("myChat")
    //       .doc(myChatEntity.channelId)
    //       .set(myNewChatCurrentUser);
    // });
    return;
  }

  _createGroup(MyChatEntity myChatEntity, List<String> selectUserList) async {
    final myNewChatCurrentUser = MyChatModel(
      channelId: myChatEntity.channelId,
      senderName: myChatEntity.senderName,
      time: myChatEntity.time,
      recipientName: myChatEntity.recipientName,
      recipientPhoneNumber: myChatEntity.recipientPhoneNumber,
      recipientUID: myChatEntity.recipientUID,
      senderPhoneNumber: myChatEntity.senderPhoneNumber,
      senderUID: myChatEntity.senderUID,
      profileUrl: myChatEntity.profileUrl,
      isArchived: myChatEntity.isArchived,
      isRead: myChatEntity.isRead,
      recentTextMessage: myChatEntity.recentTextMessage,
      subjectName: myChatEntity.subjectName,
    ).toDocument();
    log("sender Id ${myChatEntity.senderUID}");
    await fireStore
        .collection("users")
        .doc(myChatEntity.senderUID)
        .collection("myChat")
        .doc(myChatEntity.channelId)
        .set(myNewChatCurrentUser)
        .then((value) {
      log("data created");
    }).catchError((error) {
      log("dataError $error");
    });
  }

  @override
  Future<void> googleAuth() async {
    final usersCollection = fireStore.collection("users");

    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await account!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final information = (await auth.signInWithCredential(credential)).user;
      usersCollection.doc(auth.currentUser!.uid).get().then((user) async {
        if (!user.exists) {
          var uid = auth.currentUser!.uid;
          //TODO Initialize currentUser if not exist record
          var newUser = UserModel(
                  name: information!.displayName!,
                  email: information.email!,
                  phoneNumber: information.phoneNumber == null
                      ? ""
                      : information.phoneNumber!,
                  profileUrl:
                      information.photoURL == null ? "" : information.photoURL!,
                  isOnline: false,
                  status: "",
                  dob: "",
                  gender: "",
                  uid: information.uid)
              .toDocument();

          usersCollection.doc(uid).set(newUser);
        }
      }).whenComplete(() {
        log("New User Created Successfully");
      }).catchError((e) {
        log("getInitializeCreateCurrentUser ${e.toString()}");
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signIn(UserEntity user) async {
    await auth.signInWithEmailAndPassword(
        email: user.email, password: user.password);
  }

  @override
  Future<void> signUp(UserEntity user) async {
    await auth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
  }

  @override
  Future<void> getUpdateUser(UserEntity user) async {
    Map<String, dynamic> userInformation = {};
    log(user.name);
    final userCollection = fireStore.collection("users");

    if (user.profileUrl != "") {
      userInformation['profileUrl'] = user.profileUrl;
    }
    if (user.status != "") {
      userInformation['status'] = user.status;
    }
    if (user.phoneNumber != "") {
      userInformation["phoneNumber"] = user.phoneNumber;
    }
    if (user.name != "") {
      userInformation["name"] = user.name;
    }

    userCollection.doc(user.uid).update(userInformation);
  }

  @override
  Future<void> getCreateGroup(GroupEntity groupEntity) async {
    final groupCollection = fireStore.collection("groups");

    final groupId = groupCollection.doc().id;

    groupCollection.doc(groupId).get().then((groupDoc) {
      final newGroup = GroupModel(
        groupId: groupId,
        limitUsers: groupEntity.limitUsers,
        joinUsers: groupEntity.joinUsers,
        groupProfileImage: groupEntity.groupProfileImage,
        creationTime: groupEntity.creationTime,
        groupName: groupEntity.groupName,
        lastMessage: groupEntity.lastMessage,
      ).toDocument();

      if (!groupDoc.exists) {
        groupCollection.doc(groupId).set(newGroup);

        return;
      }
      return;
    }).catchError((error) {
      log(error);
    });
  }

  @override
  Stream<List<GroupEntity>> getGroups() {
    final groupCollection = fireStore.collection("groups");
    return groupCollection
        .orderBy("creationTime", descending: true)
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((e) => GroupModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> joinGroup(GroupEntity groupEntity) async {
    final groupChatChannelCollection = fireStore.collection("groupChatChannel");

    groupChatChannelCollection
        .doc(groupEntity.groupId)
        .get()
        .then((groupChannel) {
      Map<String, dynamic> groupMap = {"groupChannelId": groupEntity.groupId};
      if (!groupChannel.exists) {
        groupChatChannelCollection.doc(groupEntity.groupId).set(groupMap);
        return;
      }
      return;
    });
  }

  @override
  Future<void> updateGroup(GroupEntity groupEntity) async {
    Map<String, dynamic> groupInformation = {};

    final userCollection = fireStore.collection("groups");

    if (groupEntity.groupProfileImage != "") {
      groupInformation['groupProfileImage'] = groupEntity.groupProfileImage;
    }
    if (groupEntity.groupName != "") {
      groupInformation["groupName"] = groupEntity.groupName;
    }
    if (groupEntity.lastMessage != "") {
      groupInformation["lastMessage"] = groupEntity.lastMessage;
    }
    if (groupEntity.creationTime != null) {
      groupInformation["creationTime"] = groupEntity.creationTime;
    }

    userCollection.doc(groupEntity.groupId).update(groupInformation);
  }

  @override
  void dispose() {}
}
