import 'package:flutter/material.dart';
import 'package:presentation/base/base_bloc.dart';
import 'package:presentation/base/impl_base_bloc.dart';

import 'package:presentation/pages/message/bloc/bloc_data.dart';

abstract class UserChatListBloc extends BaseBloc {
  factory UserChatListBloc() => _UserChatListBloc();

  ScrollController get listScrollController;
}

class _UserChatListBloc extends BlocImpl implements UserChatListBloc {
  _UserChatListBloc();

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  final _screenData = UserChatListData.init();

  void scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      _screenData.limit += _screenData.limitIncrement;
      _updateData();
    }
  }

  @override
  ScrollController get listScrollController => ScrollController();

  void _updateData() {
    super.handleData(
      isLoading: isLoading,
      data: _screenData.copy(),
    );
  }
}
