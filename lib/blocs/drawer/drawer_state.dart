import 'package:careme24/models/user_model.dart';

abstract class DrawerState {}

class DrawerStateLoading extends DrawerState{}

class DrawerStateLoaded extends DrawerState {
  final UserModel userInfo;

  DrawerStateLoaded({
    required this.userInfo
  });

}

// New States for Delete Account Process
class DrawerStateDeletingAccount extends DrawerState {} // Shows loading while deleting
class DrawerStateDeleteSuccess extends DrawerState {} // Indicates successful deletion
class DrawerStateDeleteFailure extends DrawerState {
  final String errorMessage;
  
  DrawerStateDeleteFailure({required this.errorMessage});
}

