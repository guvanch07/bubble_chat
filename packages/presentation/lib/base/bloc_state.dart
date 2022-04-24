import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/base/base_bloc.dart';

abstract class BlocState<S extends StatefulWidget, B extends BaseBloc>
    extends State<S> {
  @protected
  final B bloc = GetIt.I.get<B>();
}
