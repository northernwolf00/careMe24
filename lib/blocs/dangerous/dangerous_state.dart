
import 'package:careme24/models/danger_model.dart';
import 'package:careme24/models/dangerous_models/air_pollution_model.dart';
import 'package:careme24/models/dangerous_models/pressure_wind_model.dart';
import 'package:careme24/models/dangerous_models/weather_forecast_model.dart';
import 'package:careme24/models/medcard/medcard_model.dart';
import 'package:careme24/models/request_model.dart';

abstract class DangerousState {}

class DangerousInit extends DangerousState{}
class DangerousLoading extends DangerousState{}
class DangerousLoaded extends DangerousState {

  final bool isGeoEnable;
  final AirQualityResponse airQuality;
  final WeatherForecast weatherForecast;
  final PressureAndWindData pressureAndWind;
  final String city;
  final List<RequestModel> requests;
  final String address;
  final bool showcontactNotif;
  final MedcardModel myMedCard;
  final List<DangerModel> icons;

  DangerousLoaded({
    required this.isGeoEnable,
    required this.airQuality,
    required this.weatherForecast,
    required this.pressureAndWind,
    required this.city,
    required this.requests,
    required this.address,
    required this.showcontactNotif,
    required this.myMedCard,
    required this.icons,
  });
}
