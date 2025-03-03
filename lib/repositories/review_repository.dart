import 'package:careme24/api/api.dart';
import 'package:careme24/models/favorite_model.dart';

class ReviewResponse {

  static Future<List<ServiceModel2>> getReviewRepository() async {
  return await Api.getReviews('');
}

  static Future<dynamic> postReviewRepository(Map<String,dynamic> data) async {
  return await Api.postReviews(data);
}
static Future<Map<String, dynamic>> deleteReviewRepository(String id) async {
    return await Api.deleteReviews(id);
  }

}