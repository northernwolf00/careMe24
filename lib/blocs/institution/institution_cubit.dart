import 'package:careme24/blocs/institution/institution_state.dart';
import 'package:careme24/repositories/requests_respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstitutionCubit extends Cubit<InstitutionState> {
  InstitutionCubit() : super(InstitutionLoading());

  Future<void> fetchData(String type)async{
    Map<String, dynamic> params = {
      "institution_type" : type
    };
    emit(InstitutionLoading());
    final response = await RequestsRespository.getInstitutions(params);

    emit(InstitutionLoaded(institutionList: response));
  }
}