import 'package:bloc/bloc.dart';
import 'package:careme24/repositories/review_repository.dart';
import 'package:dio/dio.dart';

import 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());



  Future<void> submitReview({
    required String text,
    required int rating,
    required String serviceId,
   
  }) async {
    emit(ReviewLoading());
    try {
    final data = {
          'text': text,
          'rating': rating.toString(),
          'service_id': serviceId,
        };

      final response = await ReviewResponse.postReviewRepository(data);
      if (response.statusCode == 200) {
        emit(ReviewSuccess("Review submitted successfully!"));
      } else {
        emit(ReviewFailure("Failed to submit review"));
      }
    } catch (e) {
      emit(ReviewFailure("Error: ${e.toString()}"));
    }
  }
}
