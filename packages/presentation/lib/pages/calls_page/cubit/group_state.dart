// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'group_cubit.dart';

@immutable
abstract class GroupState {}

class GroupInitial extends GroupState {}

class GroupLoading extends GroupState {}

class GroupLoaded extends GroupState {
  final List<GroupEntity> groups;
  GroupLoaded({
    required this.groups,
  });
}

class GroupFailture extends GroupState {}

class GroupImageUpdate extends GroupState {
  final String image;
  GroupImageUpdate({
    required this.image,
  });
}
