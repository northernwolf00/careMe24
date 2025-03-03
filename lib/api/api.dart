import 'dart:developer';
import 'package:careme24/api/http_manager.dart';
import 'package:careme24/models/auth/code_send_result.dart';
import 'package:careme24/models/auth/verified_model.dart';
import 'package:careme24/models/contacts/contacts_model.dart';
import 'package:careme24/models/danger_model.dart';
import 'package:careme24/models/dangerous_models/air_pollution_model.dart';
import 'package:careme24/models/dangerous_models/pressure_wind_model.dart';
import 'package:careme24/models/favorite_model.dart';
import 'package:careme24/models/institution_model.dart';
import 'package:careme24/models/medcard/medcard_id_model.dart';
import 'package:careme24/models/medcard/medcard_model.dart';
import 'package:careme24/models/request_model.dart';
import 'package:careme24/models/request_status_model.dart';
import 'package:careme24/models/service_model.dart';
import 'package:careme24/models/status_model.dart';
import 'package:careme24/models/user_model.dart';
import 'package:careme24/models/dangerous_models/weather_forecast_model.dart';
import 'package:careme24/service/env_service.dart';
import 'package:careme24/service/token_storage.dart';
import 'package:dio/dio.dart';

class Api {
  static final HttpManager httpManager = HttpManager.instance;

  static const String loginEndpoint = '/api/auth/login';
  static const String registerEndpoint = '/api/auth/register';
  static const String verifiedEndpoint = '/api/auth/verified';
  static const String refreshEndpoint = '/api/auth/refresh';
  static const String resetPasswordPhone = '/api/auth/reset_password/phone';
  static const String resetPasswordEmail = '/api/auth/reset_password/email';
  static const String verifiedResetPasswordPhone =
      '/api/auth/reset_password_confirm/phone';
  static const String verifiedResetPasswordEmail =
      '/api/auth/reset_password_confirm/email/';
  static const String resetPhone = '/api/users/change_phone';
  static const String resetEmail = '/api/users/change_email';
  static const String verifiedResetPhone = '/api/users/change_phone_confirm';
  static const String verifiedResetEmail = '/api/users/change_email_confirm';

  // users
  static const String getMyInfo = '/api/users/me';
  static const String getIcons = '/api/users/get_danger_icons';
  static const String getAllIcons = '/api/users/get_all_danger_icons';
  static const String delet_account = '/api/users/delete_account';

  // contacts
  static const String contactDelete = '/api/contacts';
  static const String contactsUnverified = '/api/contacts/unverified';
  static const String contactsInvited = '/api/contacts/invited';
  static const String contactsAll = '/api/contacts/all';
  static const String contactVerify = '/api/contacts';
  static const String contactUpdate = '/api/contacts';
  static const String contactAdd = '/api/contacts/add';

  // medcard
  static const String medcardAdd = '/api/cards/add';
  static const String updateCard = '/api/cards';
  static const String getMyCard = '/api/cards/mine';
  static const String getOtherCards = '/api/cards/other';
  static const String getUserInfo = '/api/users/users';
  static const String unverifiedCards = '/api/cards/all_given_unverified';
  static const String deleteVerifyRequest = '/api/cards/administration';
  static const String verifyRequest = '/api/cards/verify';
  static const String userSearch = '/api/users/users';
  static const String shareMedCard = '/api/cards/give_away';
  static const String sendCardRequest = '/api/card_requests';
  static const String cardRequestsToMe = '/api/card_requests/to_me';

  // OpenWeather service routes
  static const String getAirPollution = '/air_pollution';
  static const String getWeather = '/forecast';

  // OpenMeteo
  static const String getPressure = '/forecast';

  //Requests
  static const String requests = '/api/services';

  //Wallet
  static const String change_balance = '/api/users/change_balance';

  //favorites
  static const String favorites_services = '/api/favorites/service';
  static const String favorites = '/api/favorites/';

  //reviews
  static const String add_review = '/api/reviews/create_review';
  static const String add_review_service = '/api/reviews/create_service_review';
  static const String reviewes_service = '/api/reviews/service/';
  static const String reviews = '/api/reviews/';
  static const String average_rating =
      'api/reviews/service/';

//http://v2290783.hosted-by-vdsina.ru/api/users/change_balance?balance=100

  static Future<CodeSendResult> login(Map<String, dynamic> data) async {
    log('$data');
    try {
      var result = await httpManager.post(loginEndpoint, data: data);
      log('$result');
      return CodeSendResult.fromJson(result);
    } catch (e) {
      log('Login error: $e');
      return CodeSendResult(status: 'error', isSuccess: false, detail: 'error');
    }
  }

  static Future<CodeSendResult> register(Map<String, dynamic> data) async {
    log('$data');
    try {
      log('$data');
      var result = await httpManager.post(registerEndpoint, data: data);
      log('$result');
      return CodeSendResult.fromJson(result);
    } catch (e) {
      log('Register error: $e');
      return CodeSendResult(status: 'error', isSuccess: false, detail: 'error');
    }
  }

  static Future<Map<String, dynamic>> resetPhoneResponse() async {
    // log('$data');
    try {
      // log('$data');
      var result = await httpManager.post(resetPhone);
      log('$result');
      return result;
    } catch (e) {
      log('Register error: $e');
      return {
        "status": "error",
        "message": "Request failed",
        "isSuccess": false,
      };
    }
  }

  static Future<Map<String, dynamic>> resetEmailResponse() async {
    // log('$data');
    try {
      // log('$data');
      var result = await httpManager.post(resetEmail);
      log('$result');
      return result;
    } catch (e) {
      log('Register error: $e');
      return {
        "status": "error",
        "message": "Request failed",
        "isSuccess": false,
      };
    }
  }

  static Future<VerifiedResetPasswordModel> verifiedResetPhoneRes(
      Map<String, dynamic> params) async {
    log('$params');
    try {
      log('$params');
      var result = await httpManager.post(verifiedResetPhone, params: params);
      log('$result');
      return VerifiedResetPasswordModel.fromJson(result);
    } catch (e) {
      log('Verification error: $e');
      return VerifiedResetPasswordModel(
        status: 'error',
        isSuccess: false,
      );
    }
  }

  static Future<VerifiedResetPasswordModel> verifiedResetEmailRes(
      Map<String, dynamic> params) async {
    log('$params');
    try {
      log('$params');
      var result = await httpManager.post(verifiedResetEmail, params: params);
      log('$result');
      return VerifiedResetPasswordModel.fromJson(result);
    } catch (e) {
      log('Verification error: $e');
      return VerifiedResetPasswordModel(
        status: 'error',
        isSuccess: false,
      );
    }
  }

  static Future<CodeSendResetResult> resetPasswordP(
      Map<String, dynamic> data) async {
    log('$data');
    try {
      log('$data');
      var result = await httpManager.post(resetPasswordPhone, data: data);
      log('$result');
      return CodeSendResetResult.fromJson(result);
    } catch (e) {
      log('Register error: $e');
      return CodeSendResetResult(
        status: 'error',
        isSuccess: false,
      );
    }
  }

  static Future<CodeSendResetResult> resetPasswordE(
      Map<String, dynamic> data) async {
    log('$data');
    try {
      log('$data');
      var result = await httpManager.post(resetPasswordEmail, params: data);
      log('$result');
      return CodeSendResetResult.fromJson(result);
    } catch (e) {
      log('Register error: $e');
      return CodeSendResetResult(
        status: 'error',
        isSuccess: false,
      );
    }
  }

  static Future<VerifiedResetPasswordModel> verifiedResetPasswordP(
      Map<String, dynamic> params) async {
    log('$params');
    try {
      log('$params');
      var result =
          await httpManager.post(verifiedResetPasswordPhone, params: params);
      log('$result');
      return VerifiedResetPasswordModel.fromJson(result);
    } catch (e) {
      log('Verification error: $e');
      return VerifiedResetPasswordModel(
        status: 'error',
        isSuccess: false,
      );
    }
  }

  static Future<VerifiedResetPasswordModel> verifiedResetPasswordE(
      Map<String, dynamic> params) async {
    log('$params');
    try {
      log('$params');
      var result =
          await httpManager.post(verifiedResetPasswordEmail, params: params);
      log('$result');
      return VerifiedResetPasswordModel.fromJson(result);
    } catch (e) {
      log('Verification error: $e');
      return VerifiedResetPasswordModel(
        status: 'error',
        isSuccess: false,
      );
    }
  }

  static Future<VerifiedModel> verified(Map<String, dynamic> params) async {
    log('$params');
    try {
      log('$params');
      var result = await httpManager.post(verifiedEndpoint, params: params);
      log('$result');
      return VerifiedModel.fromJson(result);
    } catch (e) {
      log('Verification error: $e');
      return VerifiedModel(
          status: 'error',
          detail: 'error',
          isSuccess: false,
          token: '',
          rToken: '');
    }
  }

  static Future<String?> refresh() async {
    try {
      var result = await httpManager.post(refreshEndpoint);
      log('ssssssaa ${result['access_token']}');
      return result['access_token'];
    } catch (e) {
      log('Refresh token error: $e');
      return null;
    }
  }

  static Future<List<ContactModel>> loadContactsUnverified() async {
    List<ContactModel> contacts = [];
    try {
      var result = await httpManager.get(contactsUnverified);
      for (var contact in result) {
        contacts.add(ContactModel.fromJson(contact));
      }
      log('$result');
    } catch (e) {
      log('Load unverified contacts error: $e');
    }
    return contacts;
  }

  static Future<List<ContactModel>> loadContactsInvited() async {
    List<ContactModel> contacts = [];
    try {
      var result = await httpManager.get(contactsInvited);
      for (var contact in result) {
        contacts.add(ContactModel.fromJson(contact));
      }
      log('$result');
    } catch (e) {
      log('Load invited contacts error: $e');
    }
    return contacts;
  }

  static Future<List<ContactModel>> loadContactsAll() async {
    List<ContactModel> contacts = [];
    try {
      var result = await httpManager.get(contactsAll);
      for (var contact in result) {
        contacts.add(ContactModel.fromJson(contact));
      }
      log('$result');
    } catch (e) {
      log('Load invited contacts error: $e');
    }
    return contacts;
  }

  static Future<StatusModel> deleteContact(String id) async {
    try {
      var result = await httpManager.delete('$contactDelete/$id');
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Delete contact error: $e');
      return StatusModel(status: 'error', detail: 'error', isSuccess: false);
    }
  }

  static Future<StatusModel> shareCard(
      String cardId, Map<String, dynamic> params) async {
    log('$params');
    try {
      var result =
          await httpManager.post('$shareMedCard/$cardId', params: params);
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Share card error: $e');
      return StatusModel(status: 'error', detail: 'error', isSuccess: false);
    }
  }

  static Future<StatusModel> cardVerifyRequest(
      String id, String requestType) async {
    try {
      var result = await httpManager.post('$verifyRequest/$id/$requestType');
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Card verify request error: $e');
      return StatusModel(status: 'error', detail: 'error', isSuccess: false);
    }
  }

  static Future<StatusModel> verifyContact(String id) async {
    try {
      var result = await httpManager.patch('$contactVerify/$id/verify');
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Verify contact error: $e');
      return StatusModel(
          status: 'error',
          detail: 'error',
          isSuccess: false); // Возврат значения по умолчанию
    }
  }

  static Future<StatusModel> updateContact(
      String id, Map<String, dynamic> data) async {
    log('$data');
    try {
      var result = await httpManager.patch('$contactUpdate/$id',
          data: FormData.fromMap(data));
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Update contact error: $e');
      return StatusModel(status: 'error', detail: 'error', isSuccess: false);
    }
  }

  static Future<StatusModel> addContact(Map<String, dynamic> data) async {
    log('$data');
    try {
      var result =
          await httpManager.post(contactAdd, data: FormData.fromMap(data));
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Add contact error: $e');
      return StatusModel(status: 'error', detail: 'error', isSuccess: false);
    }
  }

  // MedCard
  static Future<UserModel> loadMyInfo() async {
    try {
      var result = await httpManager.get(getMyInfo);
      log('$result');
      return UserModel.fromJson(result);
    } catch (e) {
      log('Load my info error: $e');
      return UserModel(
          id: '0',
          medCardID: '',
          phone: 0,
          personalInfo: PersonalInfo(
            avatar: '',
            full_name: '',
            phone: 0,
            dob: '',
            address: '',
            temporaryAddress: '',
            passport:
                Passport(serial: 0, number: 0, place: '', date: '', photos: []),
          ),
          balance: 0);
    }
  }

  static Future<Map<String, dynamic>> changeBalance(
      Map<String, dynamic> data) async {
    log('$data');
    try {
      log('$data');
      var result = await httpManager.post(change_balance, params: data);
      log('$result');
      return result;
    } catch (e) {
      log('Change balance error: $e');
      return {
        "status": "error",
        "isSuccess": false,
        "message": "Request failed"
      };
    }
  }

  static Future<Map<String, dynamic>> deletAccount() async {
    try {
      var result = await httpManager.post(delet_account);
      log('$result');
      return result;
    } catch (e) {
      log(' error: $e');
      return {
        "status": "error",
        "isSuccess": false,
        "message": "Request failed"
      };
    }
  }

  static Future<MedcardModel> loadMyCard() async {
    try {
      var result = await httpManager.get(getMyCard);
      log('$result');
      return MedcardModel.fromJson(result);
    } catch (e) {
      log('Load my card error: $e');
      return MedcardModel(
          id: '',
          personalInfo: PersonalInfo(
              avatar: '',
              full_name: '',
              phone: 0,
              dob: '',
              address: '',
              temporaryAddress: '',
              passport: Passport(
                  serial: 0, number: 0, place: '', date: '', photos: [])),
          medInfo: MedInfo(
              bloodType: '',
              policy: 0,
              medicalInsurance:
                  Insurance(number: '', validity: '', name: '', photo: ''),
              drugIntolerance: '',
              allergy: '',
              diagnoses: '',
              vaccinations: '',
              medicationsTaken: []),
          doctorReports: [],
          testsResults: [],
          status: 'error',
          detail: 'error',
          haveCard: false,
          cerificates: []);
    }
  }

  static Future<List<MedcardModel>> loadOtherCards() async {
    List<MedcardModel> medCardModels = [];
    try {
      var result = await httpManager.get(getOtherCards);
      log('$result');
      if (result is List) {
        for (var card in result) {
          medCardModels.add(MedcardModel.fromJson(card));
        }
      }
    } catch (e) {
      log('Load other cards error: $e');
    }
    return medCardModels;
  }

  static Future<List<MedcardModel>> loadUnverifiedCards() async {
    List<MedcardModel> medcardsModels = [];
    try {
      var result = await httpManager.get(unverifiedCards);
      log('$result');
      if (result is List) {
        for (var card in result) {
          medcardsModels.add(MedcardModel.fromJson(card));
        }
      }
    } catch (e) {
      log('Load unverified cards error: $e');
    }
    return medcardsModels;
  }

  static Future<List<MedcardModel>> loadRequestsToMe() async {
    List<MedcardModel> medcardsModels = [];
    try {
      var result = await httpManager.get(cardRequestsToMe);
      log('$result');
      if (result is List) {
        for (var card in result) {
          medcardsModels.add(MedcardModel.fromJson(card));
        }
      }
    } catch (e) {
      log('Load requests to me error: $e');
    }
    return medcardsModels;
  }

  static Future<StatusModel> acceptCardRequest(String id) async {
    try {
      var result =
          await httpManager.post("$sendCardRequest/$id/accept_request");
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Accept card request error: $e');
      return StatusModel(status: 'error', isSuccess: false, detail: '');
    }
  }

  static Future<MedcardIdModel> addMedCard(Map<String, dynamic> data) async {
    log('data : $data');
    try {
      var result =
          await httpManager.post(medcardAdd, data: FormData.fromMap(data));
      log('$result');
      return MedcardIdModel.fromJson(result);
    } catch (e) {
      log('Add med card error: $e');
      return MedcardIdModel(id: '');
    }
  }

  static Future<List<UserModel>> searchUser(Map<String, dynamic> params) async {
    List<UserModel> users = [];
    try {
      var result = await httpManager.get(userSearch, params: params);
      log('${result['users']}');

      if (result['users'] is List) {
        for (var user in result['users']) {
          users.add(UserModel.fromJson(user));
        }
      }
    } catch (e) {
      log('Search user error: $e');
    }
    return users;
  }

  static Future<StatusModel> updateCardPersonalInfo(
      Map<String, dynamic> data, String id) async {
    log('data : $data');
    try {
      var result = await httpManager.patch('$updateCard/$id',
          data: FormData.fromMap(data));
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Update card personal info error: $e');
      return StatusModel(status: 'error', isSuccess: false, detail: '');
    }
  }

  static Future<StatusModel> deleteCardVerifyRequest(String id) async {
    try {
      var result = await httpManager.delete('$deleteVerifyRequest/$id/');
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Delete card verify request error: $e');
      return StatusModel(status: 'error', isSuccess: false, detail: '');
    }
  }

  static Future<StatusModel> updateMedInsurance(
      Map<String, dynamic> data, String id) async {
    log('data : $data');
    try {
      var result = await httpManager.patch('$updateCard/$id/med_insurance',
          data: FormData.fromMap(data));
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Update med insurance error: $e');
      return StatusModel(status: 'error', isSuccess: false, detail: '');
    }
  }

  static Future<StatusModel> addMedInfo(
      Map<String, dynamic> params, Map<String, dynamic> data, String id) async {
    log('params : $params');
    log('data : $data');
    log('id : $id');

    try {
      var result = await httpManager.patch(
        '$updateCard/$id/card_item',
        params: params,
        data: FormData.fromMap(data),
      );
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Update med insurance error: $e');
      return StatusModel(status: 'error', isSuccess: false, detail: '');
    }
  }

  static Future<StatusModel> deleteCard(String id) async {
    try {
      var result = await httpManager.delete('$updateCard/$id');
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Delete card error: $e');
      return StatusModel(status: 'error', isSuccess: false, detail: '');
    }
  }

  static Future<StatusModel> doMedCardMine(String id) async {
    try {
      var result = await httpManager.post('$getMyCard/$id');
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Do med card mine error: $e');
      return StatusModel(status: 'error', isSuccess: false, detail: '');
    }
  }

  // Card request
  static Future<StatusModel> sendRequest(String id) async {
    try {
      var result =
          await httpManager.post('$sendCardRequest/$id/create_request');
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Send request error: $e');
      return StatusModel(status: 'error', isSuccess: false, detail: '');
    }
  }

  // User info
  static Future loadUserInfo(int phoneNumber) async {
    try {
      var result = await httpManager.get(getUserInfo);
      log('$result');
    } catch (e) {
      log('Load user info error: $e');
    }
  }

  // Other API requests

  // Get air pollution (OpenWeather)
  static Future<AirQualityResponse> loadAirPollution(
      Map<String, dynamic> params) async {
    try {
      var result = await httpManager.get(getAirPollution,
          params: params, customBaseUrl: EnvService().openWeatherUrl);
      log('$result');
      return AirQualityResponse.fromJson(result);
    } catch (e) {
      log('Air pollution load error: $e');
      return AirQualityResponse(haveData: false, list: []);
    }
  }

  // Get weather (OpenWeather)
  static Future<WeatherForecast> loadWeather(
      Map<String, dynamic> params) async {
    try {
      var result = await httpManager.get(getWeather,
          params: params, customBaseUrl: EnvService().openWeatherUrl);
      log('$result');
      return WeatherForecast.fromJson(result);
    } catch (e) {
      log('Weather load error: $e');
      return WeatherForecast(
          haveData: false, currentTemperature: 0, forecast: []);
    }
  }

  // Get pressure (OpenMeteo)
  static Future<PressureAndWindData> loadPressure(
      Map<String, dynamic> params) async {
    try {
      var result = await httpManager.get(getPressure,
          params: params, customBaseUrl: EnvService().openMeteoUrl);
      log('$result');
      return PressureAndWindData.fromJson(result);
    } catch (e) {
      log('Pressure load error WindData: $e');
      return PressureAndWindData(
          haveData: false,
          currentPressure: 0,
          currentWindDirection: 0,
          pressureList: [],
          currentWindSpeed: 0,
          date: [],
          windDirectionList: [],
          windSpeedList: []);
    }
  }

  // request
  static Future<RequestStatusModel> createRequest(
      Map<String, dynamic> data) async {
    log('$data');
    try {
      var result = await httpManager.post('$requests/create',
          data: FormData.fromMap(data));
      log('$result');
      return RequestStatusModel.fromJson(result);
    } catch (e) {
      log('Pressure load error RequestStatusModel: $e');
      return RequestStatusModel(
          status: 'error', detail: 'error', isSuccess: false, requestId: '');
    }
  }

  static Future<StatusModel> deleteRequest(Map<String, dynamic> params) async {
    log('$params');
    try {
      var result = await httpManager.delete('$requests/delete', params: params);
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Pressure load error deleteRequest: $e');
      return StatusModel(status: 'error', detail: 'error', isSuccess: false);
    }
  }

  static Future<StatusModel> updateRequest(
      Map<String, dynamic> params, data) async {
    log('$params');
    log('$data');
    try {
      var result = await httpManager.put('$requests/update',
          params: params, data: FormData.fromMap(data));
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Pressure load error updateRequest: $e');
      return StatusModel(status: 'error', detail: 'error', isSuccess: false);
    }
  }

  static Future<List<RequestModel>> getContactsRequests() async {
    List<RequestModel> requestsList = [];
    try {
      var result = await httpManager.get('$requests/get_contacts_requests');
      log('get req $result');
      for (var request in result) {
        requestsList.add(RequestModel.fromJson(request));
      }
      return requestsList;
    } catch (e) {
      log('Pressure load error getContactsRequests: $e');
      return [];
    }
  }

  static Future<void> seenContactRequest(Map<String, dynamic> params) async {
    try {
      var result = await httpManager.post('$requests/seen_contact_request',
          params: params);
      log('get req $result');
    } catch (e) {
      log('Pressure load error seenContactRequest: $e');
    }
  }

  static Future<void> seenContactRequest112(Map<String, dynamic> params) async {
    try {
      var result = await httpManager.post('$requests/112/seen_contact_request',
          params: params);
      log('get req $result');
    } catch (e) {
      log('Pressure load error seenContactRequest112: $e');
    }
  }

  // request 112
  static Future<RequestStatusModel> createRequest112(
      Map<String, dynamic> data) async {
    log('$data');
    try {
      var result = await httpManager.post('$requests/112/create',
          data: FormData.fromMap(data));
      log('$result');
      return RequestStatusModel.fromJson(result);
    } catch (e) {
      log('Pressure load error createRequest112: $e');
      return RequestStatusModel(
          status: 'error', detail: 'error', isSuccess: false, requestId: '');
    }
  }

  static Future<StatusModel> deleteRequest112(
      Map<String, dynamic> params) async {
    log('$params');
    try {
      var result =
          await httpManager.delete('$requests/112/delete', params: params);
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Pressure load error deleteRequest112: $e');
      return StatusModel(status: 'error', detail: 'error', isSuccess: false);
    }
  }

  static Future<StatusModel> updateRequest112(
      Map<String, dynamic> params, data) async {
    log('$params');
    log('$data');
    try {
      var result = await httpManager.put('$requests/112/update',
          params: params, data: FormData.fromMap(data));
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Pressure load error updateRequest112: $e');
      return StatusModel(status: 'error', detail: 'error', isSuccess: false);
    }
  }

  static Future<List<RequestModel>> getContactsRequests112() async {
    List<RequestModel> requestsList = [];
    try {
      var result = await httpManager.get('$requests/112/get_contacts_requests');
      for (var request in result) {
        requestsList.add(RequestModel.fromJson(request));
      }
      return requestsList;
    } catch (e) {
      log('Pressure load error getContactsRequests112: $e');
      return [];
    }
  }

  static Future<List<ServiceModel>> getServices(
      Map<String, dynamic> params) async {
    List<ServiceModel> serviceList = [];
    try {
      var result =
          await httpManager.get('$requests/get_services', params: params);
      log('log $result');
      for (var service in result) {
        serviceList.add(ServiceModel.fromJson(service));
      }
      return serviceList;
    } catch (e) {
      log('Pressure load error getServices: $e');
      return [];
    }
  }

  static Future<List<DangerModel>> getDangerIcons(
      Map<String, dynamic> params) async {
    List<DangerModel> dangerIcons = [];
    try {
      var result = await httpManager.get(getIcons, params: params);
      log('icons $result');

      if (result != null && result['icons'] is List) {
        for (var icon in result['icons']) {
          dangerIcons.add(DangerModel.fromJson(icon));
        }
      }
      return dangerIcons;
    } catch (e) {
      log('Danger icons load error: $e');
      return [];
    }
  }

  static Future<List<DangerModel>> getAllDangerIcons() async {
    List<DangerModel> dangerIcons = [];
    try {
      var result = await httpManager.get(getAllIcons);
      log('icons $result');

      if (result != null && result['icons'] is List) {
        for (var icon in result['icons']) {
          dangerIcons.add(DangerModel.fromJson(icon));
        }
      }
      return dangerIcons;
    } catch (e) {
      log('Danger icons load error: $e');
      return [];
    }
  }

  static Future<List<InstitutionModel>> getInstitutions(
      Map<String, dynamic> params) async {
    List<InstitutionModel> institutionList = [];
    try {
      var result =
          await httpManager.get('$requests/get_institutions', params: params);
      for (var service in result) {
        institutionList.add(InstitutionModel.fromJson(service));
      }
      return institutionList;
    } catch (e) {
      log('Pressure load error getInstitutions: $e');
      return [];
    }
  }

  static Future<RequestStatusModel> createCall(
      Map<String, dynamic> data) async {
    log('$data');
    try {
      var result = await httpManager.post('$requests/create_call',
          data: FormData.fromMap(data));
      log('log $result');
      return RequestStatusModel.fromJson(result);
    } catch (e) {
      log('Pressure load error createCall: $e');
      return RequestStatusModel(
          status: '', detail: '', isSuccess: false, requestId: '');
    }
  }

  static Future<RequestStatusModel> createStatement(
      Map<String, dynamic> data) async {
    log('$data');
    try {
      var result = await httpManager.post('$requests/create_statement',
          data: FormData.fromMap(data));
      return RequestStatusModel.fromJson(result);
    } catch (e) {
      log('Pressure load error createStatement: $e');
      return RequestStatusModel(
          status: '', detail: '', isSuccess: false, requestId: '');
    }
  }

  static Future<RequestStatusModel> createAppointment(
      Map<String, dynamic> data) async {
    try {
      var result = await httpManager.post('$requests/book_appointment',
          data: FormData.fromMap(data));
      return RequestStatusModel.fromJson(result);
    } catch (e) {
      log('Pressure load error createAppointment: $e');
      return RequestStatusModel(
          status: '', detail: '', isSuccess: false, requestId: '');
    }
  }

  static Future<List<ServiceModel2>> getFavorites() async {
    List<ServiceModel2> serviceList = [];
    try {
      var result = await httpManager.get(favorites);
      log('log favg $result');
      for (var service in result) {
        serviceList.add(ServiceModel2.fromJson(service));
      }
      return serviceList;
    } catch (e) {
      log('Pressure load error getFavorites: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>> postFavorites(String id) async {
    try {
      var result = await httpManager.post('$favorites/$id');
      log('result favp $result');
      return result;
    } catch (e) {
      log('Pressure load error postFavorites: $e');
      return {
        "status": "error",
        "message": "Request failed",
        "isSuccess": false,
      };
      ;
    }
  }

  static Future<Map<String, dynamic>> deleteFavorite(String id) async {
    try {
      final result = await httpManager.delete('/api/favorites/$id',);
      log('Result from deleteFavorite API: $result');

      // Ensure response is properly formatted
      if (result is Map<String, dynamic>) {
        return result;
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      log('Error in deleteFavorite API: $e');
      throw Exception("Failed to delete favorite"+e.toString());
    }
  }



static Future<List<ServiceModel2>> getAverageRating(String id) async {
    List<ServiceModel2> serviceList = [];
    try {
      var result = await httpManager.get('$average_rating/$id/average_rating');
      log('log favg $result');
      for (var service in result) {
        serviceList.add(ServiceModel2.fromJson(service));
      }
      return serviceList;
    } catch (e) {
      log('Pressure load error getFavorites: $e');
      return [];
    }
  }

  static Future<List<ServiceModel2>> getReviews(String id) async {
    List<ServiceModel2> serviceList = [];
    try {
      var result = await httpManager.get('$reviews/$id');
      log('log favg $result');
      for (var service in result) {
        serviceList.add(ServiceModel2.fromJson(service));
      }
      return serviceList;
    } catch (e) {
      log('Pressure load error getFavorites: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>> postReviews(Map<String, dynamic> data) async {
    try {
      var result = await httpManager.post(reviews, data: data);
      log('result favp $result');
      return result;
    } catch (e) {
      log('Pressure load error postFavorites: $e');
      return {
        "status": "error",
        "message": "Request failed",
        "isSuccess": false,
      };
      ;
    }
  }

  static Future<Map<String, dynamic>> deleteReviews(String id) async {
    try {
      final result = await httpManager.delete('$reviews/$id',);
      log('Result from deleteFavorite API: $result');

      // Ensure response is properly formatted
      if (result is Map<String, dynamic>) {
        return result;
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      log('Error in deleteFavorite API: $e');
      throw Exception("Failed to delete favorite"+e.toString());
    }
  }
}
