import 'dart:developer';

import 'package:careme24/blocs/service/service_state.dart';
import 'package:careme24/repositories/requests_respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/medcard_repository.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit() : super(ServiceLoading());

  Future<void> fetchData(String type)async{
    emit(ServiceLoading());
    Map<String, dynamic> params = {
      "institution_type" : type
    };
    final response = await RequestsRespository.getServices(params);
    final myCard = await MedcardRepository.fetchMyCard();
    log('${response.length}');

    emit(ServiceLoaded(
      serviceList: response,
      medCardId: myCard.id
    ));
  }
}