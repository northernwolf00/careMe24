import 'dart:developer';
import 'package:careme24/api/http_manager.dart';
import 'package:careme24/blocs/service/model_chat.dart';
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
import 'package:careme24/models/reviews_model.dart';
import 'package:careme24/models/service_model.dart';
import 'package:careme24/models/status_model.dart';
import 'package:careme24/models/user_model.dart';
import 'package:careme24/models/dangerous_models/weather_forecast_model.dart';
import 'package:careme24/pages/medical_bag/models/aid_kit_model.dart';
import 'package:careme24/pages/medicines/model/aid_kit_item_mode.dart';
import 'package:careme24/pages/medicines/model/intake_model.dart';
import 'package:careme24/pages/medicines/model/owner_id_model.dart';
import 'package:careme24/service/env_service.dart';
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
  static const String sent_fcm_token = '/api/users/send_notification/token';

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
  static const String average_rating ='/api/reviews/';

  // medicines
  static const String medicines = '/api/medicines/medicine';
  static const String medicines_intake_time = '/api/medicines/intake_time';
  static const String medicines_intake_time_user = '/api/medicines/intake_time/user/';

  // medical bag
  static const String medical_bag = '/api/medicines/aid_kit';
  static const String medical_bag_get_id = '/api/medicines/aid_kit/get/';
  static const String medical_bag_request = '/api/medicines/aid_kit/request';
  static const String medical_bag_user = '/api/medicines/aid_kit/user/';

  







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
      log('Register resetPhoneResponse: $e');
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
      log('Register resetEmailResponse: $e');
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
      log('Verification error verifiedResetPhoneRes: $e');
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
      log('Verification error verifiedResetEmailRes: $e');
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
      log('Register error resetPasswordP: $e');
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
      log('Register error resetPasswordE: $e');
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
      log('Verification error verifiedResetPasswordP: $e');
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
      log('Verification error verifiedResetPasswordE: $e');
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
      log('Verification error verified: $e');
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
      log('Refresh token error refresh: $e');
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
      log(' loadContactsUnverified :$result');
    } catch (e) {
      log('Load unverified contacts error loadContactsUnverified: $e');
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
      log(' loadContactsInvited: $result');
    } catch (e) {
      log('Load invited contacts error loadContactsInvited: $e');
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
      log(' loadContactsAll: $result');
    } catch (e) {
      log('Load invited contacts error loadContactsAll: $e');
    }
    return contacts;
  }

  static Future<StatusModel> deleteContact(String id) async {
    try {
      var result = await httpManager.delete('$contactDelete/$id');
      log(' deleteContact: $result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Delete contact error deleteContact: $e');
      return StatusModel(status: 'error', detail: 'error', isSuccess: false);
    }
  }

  static Future<StatusModel> shareCard(
      String cardId, Map<String, dynamic> params) async {
    log('$params');
    try {
      var result =
          await httpManager.post('$shareMedCard/$cardId', params: params);
      log('shareCard: $result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Share card error shareCard: $e');
      return StatusModel(status: 'error', detail: 'error', isSuccess: false);
    }
  }

  static Future<StatusModel> cardVerifyRequest(
      String id, String requestType) async {
    try {
      var result = await httpManager.post('$verifyRequest/$id/$requestType');
      log(' cardVerifyRequest: $result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Card verify request error cardVerifyRequest: $e');
      return StatusModel(status: 'error', detail: 'error', isSuccess: false);
    }
  }

  static Future<StatusModel> verifyContact(String id) async {
    try {
      var result = await httpManager.patch('$contactVerify/$id/verify');
      log('verifyContact: $result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Verify contact error verifyContact: $e');
      return StatusModel(
          status: 'error',
          detail: 'error',
          isSuccess: false); // Возврат значения по умолчанию
    }
  }

  static Future<StatusModel> updateContact(
      String id, Map<String, dynamic> data) async {
    log(' updateContact: $data');
    try {
      var result = await httpManager.patch('$contactUpdate/$id',
          data: FormData.fromMap(data));
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Update contact error updateContact: $e');
      return StatusModel(status: 'error', detail: 'error', isSuccess: false);
    }
  }

  static Future<StatusModel> addContact(Map<String, dynamic> data) async {
    log('  addContact: $data');
    try {
      var result =
          await httpManager.post(contactAdd, data: FormData.fromMap(data));
      log('  addContact: $result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Add contact error addContact: $e');
      return StatusModel(status: 'error', detail: 'error', isSuccess: false);
    }
  }

  // MedCard
  static Future<UserModel> loadMyInfo() async {
    try {
      var result = await httpManager.get(getMyInfo);
      log(' loadMyInfo: $result');
      return UserModel.fromJson(result);
    } catch (e) {
      log('Load my info error loadMyInfo: $e');
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
      log('Change balance error changeBalance: $e');
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
      log('deletAccount:  $result');
      return result;
    } catch (e) {
      log(' error deletAccount: $e');
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
      log( ' loadMyCard: $result');
      return MedcardModel.fromJson(result);
    } catch (e) {
      log('Load my card error loadMyCard: $e');
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
      log(' loadOtherCards : $result');
      if (result is List) {
        for (var card in result) {
          medCardModels.add(MedcardModel.fromJson(card));
        }
      }
    } catch (e) {
      log('Load other cards error loadOtherCards: $e');
    }
    return medCardModels;
  }

  static Future<List<MedcardModel>> loadUnverifiedCards() async {
    List<MedcardModel> medcardsModels = [];
    try {
      var result = await httpManager.get(unverifiedCards);
      log('loadUnverifiedCards: $result');
      if (result is List) {
        for (var card in result) {
          medcardsModels.add(MedcardModel.fromJson(card));
        }
      }
    } catch (e) {
      log('Load unverified cards error loadUnverifiedCards: $e');
    }
    return medcardsModels;
  }

  static Future<List<MedcardModel>> loadRequestsToMe() async {
    List<MedcardModel> medcardsModels = [];
    try {
      var result = await httpManager.get(cardRequestsToMe);
      log('loadRequestsToMe: $result');
      if (result is List) {
        for (var card in result) {
          medcardsModels.add(MedcardModel.fromJson(card));
        }
      }
    } catch (e) {
      log('Load requests to me error loadRequestsToMe: $e');
    }
    return medcardsModels;
  }

  static Future<StatusModel> acceptCardRequest(String id) async {
    try {
      var result =
          await httpManager.post("$sendCardRequest/$id/accept_request");
      log('acceptCardRequest: $result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Accept card request error acceptCardRequest: $e');
      return StatusModel(status: 'error', isSuccess: false, detail: '');
    }
  }

  static Future<MedcardIdModel> addMedCard(Map<String, dynamic> data) async {
    log('data : $data');
    try {
      var result =
          await httpManager.post(medcardAdd, data: FormData.fromMap(data));
      log('addMedCard: $result');
      return MedcardIdModel.fromJson(result);
    } catch (e) {
      log('Add med card error addMedCard: $e');
      return MedcardIdModel(id: '');
    }
  }

  static Future<List<UserModel>> searchUser(Map<String, dynamic> params) async {
    List<UserModel> users = [];
    try {
      var result = await httpManager.get(userSearch, params: params);
      log(' searchUser: ${result['users']}');

      if (result['users'] is List) {
        for (var user in result['users']) {
          users.add(UserModel.fromJson(user));
        }
      }
    } catch (e) {
      log('Search user error searchUser: $e');
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
      log('Update card personal info error updateCardPersonalInfo: $e');
      return StatusModel(status: 'error', isSuccess: false, detail: '');
    }
  }

    static Future<StatusModel> updateCardPersonalInfoPhoto(
      FormData data, String id) async {
        final formData = data.toString();
    log('updateCardPersonalInfoPhoto data : $formData');
    try {
      var result = await httpManager.patch('/api/cards/$id/passport',
          data: data);
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Update card personal info error updateCardPersonalInfoPhoto: $e');
      return StatusModel(status: 'error', isSuccess: false, detail: '');
    }
  }

  static Future<StatusModel> deleteCardVerifyRequest(String id) async {
    try {
      var result = await httpManager.delete('$deleteVerifyRequest/$id/');
      // log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Delete card verify request error deleteCardVerifyRequest: $e');
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
      log('Update med insurance error updateMedInsurance: $e');
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
      log('Update med insurance error addMedInfo: $e');
      return StatusModel(status: 'error', isSuccess: false, detail: '');
    }
  }

  static Future<StatusModel> deleteCard(String id) async {
    try {
      var result = await httpManager.delete('$updateCard/$id');
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Delete card error deleteCard: $e');
      return StatusModel(status: 'error', isSuccess: false, detail: '');
    }
  }

  static Future<StatusModel> doMedCardMine(String id) async {
    try {
      var result = await httpManager.post('$getMyCard/$id');
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Do med card mine error doMedCardMine: $e');
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
      log('Send request error sendRequest: $e');
      return StatusModel(status: 'error', isSuccess: false, detail: '');
    }
  }

  // User info
  static Future loadUserInfo(int phoneNumber) async {
    try {
      var result = await httpManager.get(getUserInfo);
      log('$result');
    } catch (e) {
      log('Load user info error loadUserInfo: $e');
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
      log('Air pollution load error loadAirPollution: $e');
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
      log('Weather load error loadWeather: $e');
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
      log('Pressure load error WindData loadPressure: $e');
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
      FormData data) async {
    log(' createRequest data : $data');
    try {
      var result = await httpManager.post('/api/requests/create',
          data: data);

          log('API Response: $result');

    if (result == null) {
      throw Exception('API response is null');
    }
      log('$result');
      return RequestStatusModel.fromJson(result);
    } catch (e) {
      log('Pressure load error RequestStatusModel createRequest: $e');
      return RequestStatusModel(
          status: 'error', detail: 'error', isSuccess: false, requestId: '');
    }
  }

  static Future<StatusModel> deleteRequest(Map<String, dynamic> params) async {
    log('$params');
    try {
      var result = await httpManager.delete('/api/requests/delete', params: params);
      log('$result');
      return StatusModel.fromJson(result);
    } catch (e) {
      log('Pressure load error deleteRequest deleteRequest: $e');
      return StatusModel(status: 'error', detail: 'error', isSuccess: false);
    }
  }

  static Future<StatusModel> updateRequest(
      Map<String, dynamic> params, data) async {
    log('$params');
    log('$data');
    try {
      var result = await httpManager.put('/api/requests/update',
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
      var result = await httpManager.get('/api/requests/get_contacts_requests');
      log('get getContactsRequests: $result');
      for (var request in result) {
        requestsList.add(RequestModel.fromJson(request));
      }
      return requestsList;
    } catch (e) {
      log('Pressure load error getContactsRequests: $e');
      return [];
    }
  }

  static Future<List<ServiceResponse>> getServicesChat() async {
     List<ServiceResponse> serviceList = [];
    try {
      var result =
          await httpManager.get('/api/services/chat/list');
      log('getServicesChat \n :  \n  $result');
      for (var service in result) {
        serviceList.add(ServiceResponse.fromJson(service));
      }
      return serviceList;
    } catch (e) {
      log('Pressure load error getServicesChat: $e');
      return [];
    }
  }


  static Future<List<ServiceResponse>> getServicesChatUsers(String userId) async {
     List<ServiceResponse> serviceList = [];
    try {
      var result =
          await httpManager.get('/api/services/chat/$userId');

      log('getServicesUsersChat \n :  $result');
      for (var service in result) {
        serviceList.add(ServiceResponse.fromJson(service));
      }
      return serviceList;
    } catch (e) {
      log('Pressure load error getServicesChatUsers: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>> postChatService( FormData data) async {
     try {
      final result = await httpManager.post('/api/services/chat/send',
          data: data);
      log('Result from deleteAidKitRequest API: $result');

      // Ensure response is properly formatted
      if (result is Map<String, dynamic>) {
        return result;
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      log('Error in deleteAidKitRequest API: $e');
      throw Exception("Failed to delete deleteAidKitRequest"+e.toString());
    }
 
  }

 

  static Future<void> seenContactRequest(Map<String, dynamic> params) async {
    try {
      var result = await httpManager.post('/api/requests/seen_contact_request',
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
      var result = await httpManager.post('/api/requests/112/create',
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
          await httpManager.delete('/api/requests/112/delete', params: params);
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
      var result = await httpManager.put('/api/requests/112/update',
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
      var result = await httpManager.get('/api/requests/112/get_contacts_requests');
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

  static Future<Map<String, dynamic>> getNotficationIcons(
      Map<String, dynamic> params) async {
    // List<DangerModel> dangerIcons = [];
    try {
      var result = await httpManager.get('/api/users/notifications', params: params);
      log('getNotficationIcons $result');

      // if (result != null && result['icons'] is List) {
      //   for (var icon in result['icons']) {
      //     dangerIcons.add(DangerModel.fromJson(icon));
      //   }
      // }
      return result;
    } catch (e) {
      log('Danger icons load error: $e');
      return {

      };
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
    log('getInstitutions: $params');
    try {
      var result =
          await httpManager.get('/api/requests/get_institutions', params: params);
          log('getInstitutions: $result');
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



static Future<Map<String, dynamic>> getAverageRating(String id) async {
    
    try {
      var result = await httpManager.get('$average_rating/$id/average_rating');
      log('log getAverageRating $result');
      
      return result;
    } catch (e) {
      log('Pressure load error getAverageRating: $e');
      return  {
        "status": "error",
        "message": "Request failed",
        "isSuccess": false,
      };
    }
  }

  static Future<List<Review>> getReviews(String id) async {
    List<Review> reviewList = [];
    try {
      var result = await httpManager.get('$reviews/$id');
      log('log getReviews $result');
      for (var review in result) {
        reviewList.add(Review.fromJson(review));
      }
      return reviewList;
    } catch (e) {
      log('Pressure load error getReviews: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>> postReviews(Map<String, dynamic> data) async {
    try {
      var result = await httpManager.post(reviews, data: FormData.fromMap(data));
       log('$data');
      log('result postReviews $result');
      return result;
    } catch (e) {
      log('Pressure load error postFavorites: $e');
      return {
        "status": "error",
        "message": "Request failed",
        "isSuccess": false,
      };
      
    }
  }

  static Future<Map<String, dynamic>> deleteReviews(String id) async {
    try {
      final result = await httpManager.delete('$reviews/$id',);
      log('Result from deleteReviews API: $result');

      // Ensure response is properly formatted
      if (result is Map<String, dynamic>) {
        return result;
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      log('Error in deleteReviews API: $e');
      throw Exception("Failed to delete favorite"+e.toString());
    }
  }


  static Future<List<AidKitItem>> getMedicinesById(String id) async {
    List<AidKitItem> aidKitItemList = [];
    try {
      var result = await httpManager.get('$medical_bag_get_id/$id');
      log('log getMedicinesById $result');
      for (var medicines in result['medicines']) {
        aidKitItemList.add(AidKitItem.fromJson(medicines));
      }
      return aidKitItemList;
    } catch (e) {
      log('Pressure load error getMedicinesById: $e');
      return [];
    }
  }
   static Future<List<MedicineItem>> getMedicines() async {
    List<MedicineItem> aidKitItemList = [];
    try {
      var result = await httpManager.get(medicines);
      log('log getMedicines $result');
      for (var medicines in result) {
        aidKitItemList.add(MedicineItem.fromJson(medicines));
      }
      return aidKitItemList;
    } catch (e) {
      log('Pressure load error getMedicines: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>> postMedicines(FormData data) async {
    try {
      var result = await httpManager.post(medicines, data:data);
       log('$data');
      log('result postMedicines $result');
      return result;
    } catch (e) {
      log('Pressure load error postFavorites: $e');
      return {
        "status": "error",
        "message": "Request failed",
        "isSuccess": false,
      };
      
    }
  }

  static Future<Map<String, dynamic>> deleteMedicines(String id) async {
    try {
      final result = await httpManager.delete('$medicines/$id',);
      log('Result from deleteReviews API: $result');

      // Ensure response is properly formatted
      if (result is Map<String, dynamic>) {
        return result;
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      log('Error in deleteReviews API: $e');
      throw Exception("Failed to delete favorite"+e.toString());
    }
  }

    static Future<Map<String, dynamic>> putMedicines(FormData data) async {

    try {
      var result = await httpManager.put(medicines, data: data);
       log('$data');
      log('result putAidKit $result');
      return result;
    } catch (e) {
      log('Pressure load error putAidKit: $e');
      return {
        "status": "error",
        "message": "Request failed",
        "isSuccess": false,
      };
      
    }
    
  }

  static Future<List<AidKitModel>> getAidKit() async {
    List<AidKitModel> aidKitList = [];
    try {
      var result = await httpManager.get(medical_bag);
      log('log getAidKit $result');
      for (var review in result) {
        aidKitList.add(AidKitModel.fromJson(review));
      }
      return aidKitList;
    } catch (e) {
      log('Pressure load error getAidKit: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>> postAidKit(FormData data) async {
    try {
      var result = await httpManager.post(medical_bag, data: data);
       log('$data');
      log('result postAidKit $result');
      return result;
    } catch (e) {
      log('Pressure load error postAidKit: $e');
      return {
        "status": "error",
        "message": "Request failed",
        "isSuccess": false,
      };
      
    }
  }

  static Future<Map<String, dynamic>> deleteAidKit(String id) async {
    try {
      final result = await httpManager.delete('$medical_bag/$id',);
      log('Result from deleteAidKit API: $result');

      // Ensure response is properly formatted
      if (result is Map<String, dynamic>) {
        return result;
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      log('Error in deleteAidKit API: $e');
      throw Exception("Failed to delete favorite"+e.toString());
    }
  }

  static Future<Map<String, dynamic>> putAidKit(FormData data) async {

    try {
      var result = await httpManager.put(medical_bag, data: data);
       log('$data');
      log('result putAidKit $result');
      return result;
    } catch (e) {
      log('Pressure load error putAidKit: $e');
      return {
        "status": "error",
        "message": "Request failed",
        "isSuccess": false,
      }; 
    }
  }


  static Future<Map<String, dynamic>> postFCMToken(FormData data) async {
    try {
      var result = await httpManager.post(sent_fcm_token, data: data);
       log('$data');
      log('result postFCMToken $result');
      return result;
    } catch (e) {
      log('Pressure load error postFCMToken: $e');
      return {
        "status": "error",
        "message": "Request failed",
        "isSuccess": false,
      };
      
    }
  }



static Future<List<AidKitModel>> getIntakeTimeUser(String day) async {
    List<AidKitModel> aidIntakeTime = [];
    try {
      var result = await httpManager.get(medicines_intake_time, params: day);
      log('log getIntakeTimeUser $result');
      for (var review in result) {
        aidIntakeTime.add(AidKitModel.fromJson(review));
      }
      return aidIntakeTime;
    } catch (e) {
      log('Pressure load error getIntakeTimeUser: $e');
      return [];
    }
  }

   static Future<List<MedicineIntakeTime>> getIntakeTime(String day) async {
    List<MedicineIntakeTime> aidIntakeTime = [];
    try {
      var result = await httpManager.get(medicines_intake_time, params: {'day': day});
      log('log getIntakeTime $result');
      for (var review in result) {
        aidIntakeTime.add(MedicineIntakeTime.fromJson(review));
      }
      return aidIntakeTime;
    } catch (e) {
      log('Pressure load error getIntakeTime: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>> postIntakeTime(FormData data) async {
    try {
      var result = await httpManager.post(medicines_intake_time, data: data);
       log('$data');
      log('result postIntakeTime $result');
      return result;
    } catch (e) {
      log('Pressure load error postIntakeTime: $e');
      return {
        "status": "error",
        "message": "Request failed",
        "isSuccess": false,
      };
      
    }
  }

  static Future<Map<String, dynamic>> deleteIntakeTime(String id) async {
    try {
      final result = await httpManager.delete('$medicines_intake_time/$id',);
      log('Result from deleteIntakeTime API: $result');

      // Ensure response is properly formatted
      if (result is Map<String, dynamic>) {
        return result;
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      log('Error in deleteIntakeTime API: $e');
      throw Exception("Failed to delete deleteIntakeTime"+e.toString());
    }
  }

  static Future<Map<String, dynamic>> putIntakeTime(FormData data) async {
    try {
      var result = await httpManager.put(medicines_intake_time, data: data);
       log('$data');
      log('result putIntakeTime $result');
      return result;
    } catch (e) {
      log('Pressure load error putIntakeTime: $e');
      return {
        "status": "error",
        "message": "Request failed",
        "isSuccess": false,
      }; 
    }
  }



  static Future<List<AidKitModel>> getAidKitUser(String user_id) async {
    List<AidKitModel> aidIntakeTime = [];
    try {
      var result = await httpManager.get('$medical_bag_user/$user_id');
      log('log getAidKitUser $result');
      for (var review in result) {
        aidIntakeTime.add(AidKitModel.fromJson(review));
      }
      return aidIntakeTime;
    } catch (e) {
      log('Pressure load error getAidKitUser: $e');
      return [];
    }
  }

   static Future<List<AidKitModel>> getAidKitRequest() async {
    List<AidKitModel> aidIntakeTime = [];
    try {
      var result = await httpManager.get('/api/medicines/aid_kit/request', );
      log('log getAidKitRequest $result');
      for (var review in result) {
        aidIntakeTime.add(AidKitModel.fromJson(review));
      }
      return aidIntakeTime;
    } catch (e) {
      log('Pressure load error getAidKitRequest: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>> postAidKitRequest(String data) async {
    try {
      var result = await httpManager.post("/api/medicines/aid_kit/request/", params: data);
       log('$data');
      log('result postAidKitRequest $result');
      return result;
    } catch (e) {
      log('Pressure load error postAidKitRequest: $e');
      return {
        "status": "error",
        "message": "Request failed",
        "isSuccess": false,
      };
      
    }
  }

  static Future<Map<String, dynamic>> deleteAidKitRequest(String id) async {
    try {
      final result = await httpManager.delete('$medicines_intake_time/$id',);
      log('Result from deleteAidKitRequest API: $result');

      // Ensure response is properly formatted
      if (result is Map<String, dynamic>) {
        return result;
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      log('Error in deleteAidKitRequest API: $e');
      throw Exception("Failed to delete deleteAidKitRequest"+e.toString());
    }
  }

  static Future<Map<String, dynamic>> putAidKitRequest(FormData data) async {
    try {
      var result = await httpManager.put(medicines_intake_time, data: data);
       log('$data');
      log('result putAidKitRequest $result');
      return result;
    } catch (e) {
      log('Pressure load error putAidKitRequest: $e');
      return {
        "status": "error",
        "message": "Request failed",
        "isSuccess": false,
      }; 
    }
  }


  



}
