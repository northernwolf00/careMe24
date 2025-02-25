import 'package:careme24/models/service_model.dart';

abstract class ServiceState{}

class ServiceLoading extends ServiceState{}

class ServiceLoaded extends ServiceState{
  final List<ServiceModel> serviceList;
  final String medCardId;
  ServiceLoaded({
    required this.serviceList,
    required this.medCardId
  });
}