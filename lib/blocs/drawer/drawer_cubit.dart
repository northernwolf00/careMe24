import 'dart:developer';
import 'package:careme24/blocs/drawer/drawer_state.dart';
import 'package:careme24/repositories/user_repository.dart';
import 'package:careme24/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawerStateLoading());

  Future<void> fetchMyData()async{
    emit(DrawerStateLoading());
    final userInfo = await UserRepository.fetchMyInfo();    
    emit(DrawerStateLoaded(
      userInfo: userInfo
    ));

  }

   Future<void> deletAccount(BuildContext context) async {
    emit(DrawerStateDeletingAccount()); // Emit loading state before deleting

    final response = await UserRepository.deletAccountRepository();
    
    if (response["status"] == 'success') {
      emit(DrawerStateDeleteSuccess()); // Emit success state
      Navigator.pushNamedAndRemoveUntil(
          context, AppRouter.startPage, (route) => false);
    } else {
      emit(DrawerStateDeleteFailure(errorMessage: response["message"])); 
    }
  }


}
