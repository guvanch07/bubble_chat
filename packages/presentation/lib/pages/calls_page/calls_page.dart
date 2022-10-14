import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/group_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:presentation/core/heplers/random.dart';
import 'package:presentation/pages/calls_page/cubit/group_cubit.dart';
import 'package:presentation/pages/calls_page/msg_group_screen.dart';

class GroupListUsers extends StatelessWidget {
  const GroupListUsers({required this.uid, Key? key}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<GroupCubit, GroupState>(builder: (context, state) {
          if (state is GroupLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is GroupLoaded) {
            return Expanded(
              child: ListView.builder(
                itemCount: state.groups.length,
                itemBuilder: (context, index) {
                  final groups = state.groups[index];
                  return ListTile(
                    onTap: () => Navigator.push(
                      context,
                      GroupChatScreen.route(
                        uid: uid,
                        groupEntity: state.groups[index],
                      ),
                    ),
                    subtitle: Text(
                      groups.lastMessage,
                      style: const TextStyle(color: Colors.amber),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        groups.groupProfileImage ?? Helpers.randomPictureUrl(),
                      ),
                    ),
                    title: Text(
                      groups.groupName,
                      style: const TextStyle(color: Colors.amber),
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox();
        }),
        RawMaterialButton(
          onPressed: () => showDialog(
              context: context,
              builder: (context) => AddGroupeWidget(uid: uid)),
          shape: const CircleBorder(),
          fillColor: Colors.red,
          child: const Icon(Icons.add),
        )
      ],
    );
  }
}

class AddGroupeWidget extends HookWidget {
  const AddGroupeWidget({required this.uid, Key? key}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    final groupName = useTextEditingController();
    final limitUsers = useTextEditingController();
    return Dialog(
      child: Column(
        children: [
          TextField(controller: groupName),
          TextField(controller: limitUsers),
          CupertinoButton.filled(
            child: const Text("add"),
            onPressed: () => context.read<GroupCubit>().createGroupe(
                  groupEntity: GroupEntity(
                    lastMessage: '',
                    uid: uid,
                    groupName: groupName.text,
                    groupProfileImage:
                        BlocProvider.of<GroupCubit>(context, listen: false)
                                .profileImage ??
                            Helpers.randomPictureUrl(),
                    creationTime: Timestamp.now(),
                    limitUsers: limitUsers.text,
                    joinUsers: "0",
                  ),
                ),
          ),
          CupertinoButton.filled(
            child: const Text("add image"),
            onPressed: () => context.read<GroupCubit>().uploadImage(),
          )
        ],
      ),
    );
  }
}
