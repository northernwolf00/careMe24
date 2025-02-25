

import 'dart:developer';

import 'package:careme24/models/auth/code_send_result.dart';
import 'package:careme24/pages/wallet/change_balance_state.dart';
import 'package:careme24/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ChageBalanceCubit extends Cubit<ChangeBalanceState> {
  ChageBalanceCubit() : super(ChangeBalanceInitial());

  Future<CodeSendResetResult> changeBalanceWallet(String data,) async {
  
  final requestData = {

      "balance": data,
  };

  try {
    CodeSendResetResult response;
     response = await UserRepository.changeBalanceRepository(requestData);

    if (response.isSuccess) {
      log(' successful');
   
      emit(ChangeBalanceSuccess(response.status));
      return response;
    } else {
      log(' failed');
      
    }
  } catch (e) {
    log(' error: $e');
    emit(ChangeBalanceError(e.toString()));
  }
  return CodeSendResetResult(status: '', isSuccess: false);
}

}

