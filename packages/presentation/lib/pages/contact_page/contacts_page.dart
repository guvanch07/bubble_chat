// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/entities/user_entity.dart';
import 'package:domain/models/message_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/pages/contact_page/cubit/user_cubit.dart';
import 'package:presentation/screens/chat/ui/main_chat_screen.dart';
import 'package:domain/entities/my_chat_entity.dart';

class ContactsPage extends StatelessWidget {
  final String uid;
  final String? query;

  const ContactsPage({
    Key? key,
    required this.uid,
    this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          final users =
              state.users.where((element) => element.uid != uid).toList();

          // final filteredUsers = users.where((user) {
          //   if (query != null) {
          //     return user.name.startsWith(query!) ||
          //         user.name.startsWith(query!.toLowerCase());
          //   }
          //   return false;
          // }).toList();

          return Column(
            children: [
              Expanded(
                  child: users.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.contact_page,
                                size: 40,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "No Users Found yet",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (_, index) {
                            return SingleItemStoriesStatusWidget(
                              uid: uid,
                              user: users[index],
                            );
                          },
                        ))
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class SingleItemStoriesStatusWidget extends StatelessWidget {
  final UserEntity user;
  final String? uid;

  const SingleItemStoriesStatusWidget({
    Key? key,
    required this.user,
    this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        ChatScreen.route(
          uid: uid,
          otherUid: user.uid,
          messageData: const MyChatEntity(),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        child: profileWidget(imageUrl: user.profileUrl),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          user.status == ""
                              ? "Hi! I'm using this app"
                              : user.status,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 60, right: 10),
              child: Divider(
                thickness: 1.50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileWidget({String? imageUrl, File? image}) {
    log("image value $image");
    if (image == null) {
      if (imageUrl == null) {
        return Image.asset(
          'assets/profile_default.png',
          fit: BoxFit.cover,
        );
      } else {
        return CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              SizedBox(
                  height: 50,
                  width: 50,
                  child: Container(
                      margin: const EdgeInsets.all(20),
                      child: const CircularProgressIndicator())),
          errorWidget: (context, url, error) => const Icon(Icons.person),
        );
      }
    } else {
      return Image.file(
        image,
        fit: BoxFit.cover,
      );
    }
  }
}
