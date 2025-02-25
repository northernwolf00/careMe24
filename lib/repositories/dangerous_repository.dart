import 'package:careme24/api/api.dart';
import 'package:careme24/models/dangerous_models/air_pollution_model.dart';
import 'package:careme24/models/dangerous_models/pressure_wind_model.dart';
import 'package:careme24/models/dangerous_models/weather_forecast_model.dart';

class DangerousInfoRepository {
  static Future<AirQualityResponse> fetchAirPollution(Map<String, dynamic> params)async{
    final response = await Api.loadAirPollution(params);
    return response;
  }

  static Future<WeatherForecast> fetchWeather(Map<String, dynamic> params)async{
    final response = await Api.loadWeather(params);
    return response;
  }
  static Future<PressureAndWindData>fetchPressure(Map<String, dynamic> params)async{
    final response = await Api.loadPressure(params);
    return response;
  }
}