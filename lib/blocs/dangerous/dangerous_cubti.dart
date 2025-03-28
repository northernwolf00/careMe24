import 'dart:developer';
import 'package:careme24/api/api.dart';
import 'package:careme24/blocs/app_bloc.dart';
import 'package:careme24/blocs/dangerous/dangerous_state.dart';
import 'package:careme24/models/contacts/contacts_model.dart';
import 'package:careme24/models/dangerous_models/air_pollution_model.dart';
import 'package:careme24/models/dangerous_models/pressure_wind_model.dart';
import 'package:careme24/models/dangerous_models/weather_forecast_model.dart';
import 'package:careme24/models/medcard/medcard_model.dart';
import 'package:careme24/models/request_model.dart';
import 'package:careme24/repositories/contacts_repository.dart';
import 'package:careme24/repositories/dangerous_repository.dart';
import 'package:careme24/repositories/medcard_repository.dart';
import 'package:careme24/repositories/requests_respository.dart';
import 'package:careme24/service/pref_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class DangerousCubit extends Cubit<DangerousState> {
  DangerousCubit() : super(DangerousInit());

  bool isGeolocationEnable = false;
  double lat = 0.0;
  double lon = 0.0;
  String addres = '';
  String city = '';
  List<RequestModel> requests = [];
  List<ContactModel>  contactsUnverified = [];
  MedcardModel myCard = MedcardModel(id: '', personalInfo: PersonalInfo(avatar: '', full_name: '', phone: 0, dob: '', address: '', temporaryAddress: '', passport: Passport(serial: 0, number: 0, place: '', date: '', photos: [])), medInfo: MedInfo(bloodType: '', policy: 0, 
  medicalInsurance: Insurance(number: '', validity: '', name: '', photo: ''), 
  drugIntolerance: '', allergy: '', diagnoses: '', vaccinations: '', medicationsTaken: []), 
  doctorReports: [], testsResults: [], cerificates: [], status: '', detail: '', haveCard: false,);

  getLocation() async {
    emit(DangerousLoading());

    /* final token

    if () {
        await TokenManager.deleteToken();
        await PrefService.delete();
        Navigator.pushReplacementNamed(context, AppRouter.startPage);
    } */
          
    bool notifMe = await PrefService.isNotifMe();
    if (notifMe) {
      contactsUnverified = await ContactsRepository.loadContactsUnverified();
    }
    myCard = await MedcardRepository.fetchMyCard();
    
    final status = await Permission.location.request();

    if (status.isGranted) {
      if (lat == 0) {
        Position location = await Geolocator.getCurrentPosition();
        log("latitude "'${location.latitude}" longitude "+ ${location.longitude}');
        lat = location.latitude;
        lon = location.longitude;

        List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
        city = placemarks.first.locality ?? '';
        String street = placemarks.first.street ?? '';
        addres = '$city $street';
      }

      AppBloc.requestCubit.getLocation();
      fetchData();
    } else if (status.isPermanentlyDenied) {
      isGeolocationEnable = false;
      openAppSettings();

      emit(DangerousLoaded(
        myMedCard: myCard,
        showcontactNotif: contactsUnverified.isNotEmpty,
        requests: [],
        city: '',
        address: 'Нет данных',
        isGeoEnable: isGeolocationEnable,
        airQuality: AirQualityResponse(list: [], haveData: false),
        weatherForecast: WeatherForecast(currentTemperature: 0, forecast: [], haveData: false),
        pressureAndWind: PressureAndWindData(currentPressure: 0, currentWindDirection: 0, currentWindSpeed: 0, pressureList: [], windDirectionList: [], windSpeedList: [], date: [], haveData: false),
        icons: []
      ));
    } else {
      emit(DangerousLoaded(
        myMedCard: myCard,
        showcontactNotif: contactsUnverified.isNotEmpty,
        requests: [],
        city: '',
        address: 'Нет данных',
        isGeoEnable: isGeolocationEnable,
        airQuality: AirQualityResponse(list: [], haveData: false),
        weatherForecast: WeatherForecast(currentTemperature: 0, forecast: [], haveData: false),
        pressureAndWind: PressureAndWindData(currentPressure: 0, currentWindDirection: 0, currentWindSpeed: 0, pressureList: [], windDirectionList: [], windSpeedList: [], date: [], haveData: false),
        icons: []
      ));
    }
  }

  Future<void> fetchData() async {

    final icons = await Api.getDangerIcons({'lat': lat, 'lon': lon});
     List response = [];
  //  response = await RequestsRespository.getContactRequests();
    //  final icons = await Api.getAllDangerIcons();


    try {
      final airPollution = await DangerousInfoRepository.fetchAirPollution({
        'lat': lat,
        'lon': lon,
        'appid': 'bc8da4c6dae7528e50d211256438d6fd',
      });

      final weatherForecast = await DangerousInfoRepository.fetchWeather({
        'lat': lat,
        'lon': lon,
        'appid': 'bc8da4c6dae7528e50d211256438d6fd',
        'units': 'metric',
      });

      final pressureAndWind = await DangerousInfoRepository.fetchPressure({
        'latitude': lat,
        'longitude': lon,
        'hourly': 'pressure_msl,wind_speed_10m,wind_direction_10m',
        'forecast_days': 7,
      });
     
      List response112 = [];

      bool notifMe = await PrefService.isNotifMe();
      if (notifMe) {
        response = await RequestsRespository.getContactRequests();
        response112 = await RequestsRespository.getContactRequests112();
      }

      for (var r in response) {
        await RequestsRespository.seenContactRequests({"contact_request_id" : r.id});
      }

      for (var r in response112) {
        await RequestsRespository.seenContactRequests112({"contact_request_id" : r.id});
      }

      if (notifMe) {
        contactsUnverified = await ContactsRepository.loadContactsUnverified();
        
      }
      log('$response');
      log('$response112');
      for (var r in response) {
        if (r.seen == false) {
          requests.add(r);
        }
      }
      for (var r in response112) {
        if (r.seen == false) {
          requests.add(r);
        }
      }
      log('${requests.length}');

      emit(DangerousLoaded(
        myMedCard: myCard,
        showcontactNotif: contactsUnverified.isNotEmpty,
        requests: requests,
        address: addres,
        city: city,
        isGeoEnable: true,
        airQuality: airPollution,
        weatherForecast: weatherForecast,
        pressureAndWind: pressureAndWind,
        icons: icons
      ));
    } catch (e) {
      log(e.toString());

      // Обработчик ошибок
      emit(DangerousLoaded(
        myMedCard: MedcardModel(id: '', personalInfo: PersonalInfo(avatar: '', full_name: '', phone: 0, dob: '', address: '', temporaryAddress: '', passport: Passport(serial: 0, number: 0, place: '', date: '', photos: [])), medInfo: MedInfo(bloodType: '', policy: 0, medicalInsurance: Insurance(number: '', validity: '', name: '', photo: ''), drugIntolerance: '', allergy: '', diagnoses: '', vaccinations: '', medicationsTaken: []), doctorReports: [], testsResults: [], cerificates: [], status: '', detail: '', haveCard: false),
        showcontactNotif: false,
        requests: [],
        city: '',
        address: 'Нет данных',
        isGeoEnable: isGeolocationEnable,
        airQuality: AirQualityResponse(list: [], haveData: false),
        weatherForecast: WeatherForecast(currentTemperature: 0, forecast: [], haveData: false),
        pressureAndWind: PressureAndWindData(currentPressure: 0, currentWindDirection: 0, currentWindSpeed: 0, pressureList: [], windDirectionList: [], windSpeedList: [], date: [], haveData: false),
        icons: []
      ));
    }
  }
}
