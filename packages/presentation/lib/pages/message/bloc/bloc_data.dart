class UserChatListData {
  int limit;
  final int limitIncrement;

  UserChatListData(this.limit, this.limitIncrement);

  factory UserChatListData.init() => UserChatListData(0, 20);

  UserChatListData copy() => UserChatListData(limit, limitIncrement);
}
