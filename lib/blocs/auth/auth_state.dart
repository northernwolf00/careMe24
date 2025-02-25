import 'package:careme24/models/auth/code_send_result.dart';
import 'package:careme24/models/auth/verified_model.dart';

abstract class AuthState{}

class AuthInitState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthCodeState extends AuthState {
  CodeSendResult data;

  AuthCodeState({
    required this.data
  });
}

class AuthCodeResetState extends AuthState {
  CodeSendResetResult data;

  AuthCodeResetState({
    required this.data
  });
}



class AuthVerifyState extends AuthState {
  VerifiedModel data;

  AuthVerifyState({
    required this.data
  });
}

class AuthVerifyResetPasswordState extends AuthState {
  VerifiedResetPasswordModel data;

  AuthVerifyResetPasswordState({
    required this.data
  });
}