

import 'package:careme24/pages/medicines/cubit/medicines_repository.dart';
import 'package:careme24/pages/medicines/cubit/medicines_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MedicineCubit extends Cubit<MedicinesState> {
  MedicineCubit() : super(MedicinesInitial());

  Future<void> getMedicines(String id) async {
    emit(MedicinesLoading());
    try {
      final response = await MedicinesRepository.getMedicinesRepository(id);
       emit(MedicinesInitial());
      if (response.isNotEmpty) {
        emit(MedicinesLoaded(response));
      }
    } catch (e) {
      emit(MedicinesError(e.toString()));
    }
  }

  Future<void> updateMedicines(
    String id,
    String title,
    String date,
    String dosage,
    String aidKitId,

  ) async {
    emit(MedicinesUpdating());
    try {

       final formattedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.parse(date));
      FormData formData = FormData.fromMap({
       'id': id,
        'title': title,
        'expiration_date': formattedDate,
        'count': dosage,
        'aid_kit_id': aidKitId,
      });
      final response = await MedicinesRepository.updateMedicinesRepository(formData);

      if (response['status'] == 'success') {
        getMedicines(aidKitId);
        emit(MedicinesUpdated(response['status'], response['detail']));
      } else {
        emit(MedicinesError("Ошибка при обновлении аптечки"));
      }
    } catch (e) {
      emit(MedicinesError(e.toString()));
    }
  }

  Future<void> createMedicines(String title, String expirationDate,
     String count,
     String aidKitId) async {
    emit(MedicinesCreating());
    try {

          final formattedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.parse(expirationDate));

      final formData = FormData.fromMap({
        'title': title,
          'expiration_date': formattedDate,
          'count': count,
          'aid_kit_id': aidKitId,
            
      });

      final response = await MedicinesRepository.createMedicinesRepository(formData);
      if (response['status'] == 'success') {
        getMedicines(aidKitId);
        emit(MedicinesCreated(response['status'], response['detail']));
      }
      emit(MedicinesCreated(response['status'], response['detail']));
    } catch (e) {
      emit(MedicinesError(e.toString()));
    }
  }

  Future<void> deletMedicines(String id) async {
    final currentState = state;

    if (currentState is MedicinesLoaded) {
      try {
        Map<String, dynamic> response =
            await MedicinesRepository.deleteMedicinesRepository(id);

        if (response["status"] == 'success') {
          
          final updatedList =
              currentState.aidKits.where((item) => item.id != id).toList();

          // Emit new state with updated list
          emit(MedicinesLoaded(
            updatedList,
          ));
        } else {
          emit(MedicinesError("Failed to delete favorite"));
        }
      } catch (e) {
        emit(MedicinesError(e.toString()));
      }
    }
  }
}
