import 'dart:developer';

import 'package:careme24/blocs/service/service_state.dart';
import 'package:careme24/models/service_model.dart';
import 'package:careme24/repositories/favorites_response.dart';
import 'package:careme24/repositories/requests_respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/medcard_repository.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit() : super(ServiceLoading());

  Future<void> fetchData(String type) async {
    emit(ServiceLoading());
    Map<String, dynamic> params = {"institution_type": type};
    final response = await RequestsRespository.getServices(params);
    final myCard = await MedcardRepository.fetchMyCard();
    log('${response.length}');
     final responseChat = await RequestsRespository.getServicesChat();

    emit(ServiceLoaded(serviceList: response, medCardId: myCard.id));
  }

  Future<void> postFavorites(String id) async {
    // emit(FavoriteLoading());

    final currentState = state;

    if (currentState is ServiceLoaded) {
      try {
        Map<String, dynamic> response =
            await FavoritesResponse.postFavoritesRepository(id);

        if (response["status"] == 'success') {
          List<ServiceModel> updatedList =
              currentState.serviceList.map((service) {
            if (service.id == id) {
              return service.copyWith(isFavourite: !service.isFavourite);
            }
            return service;
          }).toList();

          emit(ServiceLoaded(
            serviceList: updatedList,
            medCardId: currentState.medCardId,
          ));

          emit(ServiceLoaded(
            serviceList: updatedList,
            medCardId: currentState.medCardId,
          ));
        } else {}
      } catch (e) {}
    }
  }

  Future<void> deletFavorites(String id) async {
    final currentState = state;

    if (currentState is ServiceLoaded) {
      try {
        Map<String, dynamic> response =
            await FavoritesResponse.deleteFavoriteRepository(id);

        if (response["status"] == 'success') {
          List<ServiceModel> updatedList =
              currentState.serviceList.map((service) {
            if (service.id == id) {
              return service.copyWith(isFavourite: !service.isFavourite);
            }
            return service;
          }).toList();

          emit(ServiceLoaded(
            serviceList: updatedList,
            medCardId: currentState.medCardId,
          ));
        } else {
          // emit(FavoriteError("Failed to delete favorite"));
        }
      } catch (e) {
        // emit(FavoriteError(e.toString()));
      }
    }
  }
}
