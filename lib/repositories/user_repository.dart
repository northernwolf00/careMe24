import 'package:careme24/api/api.dart';
import 'package:careme24/models/auth/code_send_result.dart';
import 'package:careme24/models/user_model.dart';

class UserRepository {
  static Future<UserModel> fetchMyInfo()async{
    final response = Api.loadMyInfo();
    return response;
  }
static Future<dynamic> changeBalanceRepository(Map<String, dynamic> data) async {
  return await Api.changeBalance(data);
}

static Future<dynamic> deletAccountRepository() async {
  return await Api.deletAccount();
}




}