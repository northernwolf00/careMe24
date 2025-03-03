import 'dart:developer';
import 'package:careme24/blocs/drawer/drawer_state.dart';
import 'package:careme24/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawerStateLoading());

  Future<void> fetchMyData()async{
    emit(DrawerStateLoading());
    final userInfo = await UserRepository.fetchMyInfo();    
    emit(DrawerStateLoaded(
      userInfo: userInfo
    ));

   Future<void> deletAccount()async{

    final delete = await UserRepository.deletAccountRepository();

   } 



  }

  


}
