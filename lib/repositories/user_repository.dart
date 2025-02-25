import 'package:careme24/api/api.dart';
import 'package:careme24/models/auth/code_send_result.dart';
import 'package:careme24/models/user_model.dart';

class UserRepository {
  static Future<UserModel> fetchMyInfo()async{
    final response = Api.loadMyInfo();
    return response;
  }

   static Future<CodeSendResetResult> changeBalanceRepository(Map<String,dynamic> data)async{
    final CodeSendResetResult response = await Api.changeBalance(data);
    return response;
  }
}