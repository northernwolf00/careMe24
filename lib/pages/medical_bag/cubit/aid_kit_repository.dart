import 'package:careme24/api/api.dart';
import 'package:careme24/pages/medical_bag/models/aid_kit_model.dart';
import 'package:dio/dio.dart';

class AidKitRepository {



    static Future<List<AidKitModel>> getAidKitRepository() async {
  return await Api.getAidKit();
}

static Future<Map<String, dynamic>> updateAidKitRepository(FormData data) async {
    final result = await Api.putAidKit(data);
    return result; 
  }

  static Future<Map<String, dynamic>> createAidKitRepository(FormData data) async {
    final result = await Api.postAidKit(data);
    return result; 
  }
  static Future<Map<String, dynamic>> deleteAidKitRepository(String id) async {
    return await Api.deleteAidKit(id);
  }


}