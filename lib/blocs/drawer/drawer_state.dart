import 'package:careme24/models/user_model.dart';

abstract class DrawerState {}

class DrawerStateLoading extends DrawerState{}

class DrawerStateLoaded extends DrawerState {
  final UserModel userInfo;

  DrawerStateLoaded({
    required this.userInfo
  });
}


