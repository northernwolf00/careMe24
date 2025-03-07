import 'package:careme24/app_container.dart';
import 'package:careme24/pages/auth/auth_error.dart';
import 'package:careme24/pages/auth/reset_email.dart';
import 'package:careme24/pages/auth/reset_passwords.dart';
import 'package:careme24/pages/auth/registration_email_page.dart';
import 'package:careme24/pages/auth/verify_code_reset_page.dart';
import 'package:careme24/pages/calls/careme_call_page.dart';
import 'package:careme24/pages/calls/police_call_page.dart';
import 'package:careme24/pages/calls/rescue_call_page.dart';
import 'package:careme24/pages/doctors/doctors_page.dart';
import 'package:careme24/pages/med/reviews_list_screen.dart';
import 'package:careme24/pages/med_card/medical_card_page_list.dart';
import 'package:careme24/pages/medical_bag/medical_bag_page.dart';
import 'package:careme24/pages/medicines/medicines_page.dart';
import 'package:careme24/pages/medicines/widgets/moth_days_selector.dart';
import 'package:careme24/pages/pages.dart';
import 'package:careme24/pages/settings/settings_page.dart';
import 'package:careme24/pages/wallet/wallet_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String startPage = '/start';
  static const String registerPage = '/register';
  static const String registerEmailPage = '/registerEmail';
  static const String loginPage = '/login';
  static const String verificationPage = '/verification';
  static const String verificationPageEdit = '/verification_edit';
  static const String editEmail = '/editEmail';
  static const String appContainer = '/app_container';
  static const String medicCall = '/medic_call';
  static const String rescueCall = '/rescue_call';
  static const String policeCall = '/police_call';
  static const String medCardList = '/med_card_list';
  static const String calls = '/calls';
  static const String paymentFailedScreen = '/calls';
  static const String trackingScreen = '/tracking_screen';
  static const String careMeScreen = '/careme_screen';
  static const String errorScreen = '/error';
  static const String medicalBag = '/medicalBag';
  static const String medicines = '/medicines';
  static const String doctors = '/doctors';
  static const String wallet = '/wallet';
  static const String settings = '/settings';
  static const String resetEmailPhone = '/resetEmailPhone';
  static const String monthDaySelector = '/monthDaySelector';



  



  static final Map<String, WidgetBuilder> routes = {
    startPage : (context) => const StartPage(),
    registerEmailPage : (context) => const RegistrationEmailPage(),
    registerPage : (context) => const RegistrationPage(),
    loginPage : (context) => const LoginPage(),
    verificationPage : (context) => const VerifyCodePage(),
    editEmail : (context) => const EditEmailPage(),
    resetEmailPhone : (context) => const ResetEmailPhonePage(),
    appContainer: (context) =>  AppContainer(0),
    medicCall: (context) => const MedicCallPage(),
    rescueCall: (context) => const RescueCallPage(),
    policeCall: (context) => PoliceCallPage(),
    medCardList: (context) => const MedicalCardListPage(),
    calls: (context) => const CallsPage(),
    careMeScreen: (context) => CaremeCallPage(),
    errorScreen: (context) => AuthError(),
    medicalBag: (context) =>const MedicalBagPage(),
    medicines: (context) => const MedicinesPage(),
    doctors: (context) => const DoctorsPage(),
    wallet: (context) => const WalletPage(),
    settings: (context) => const SettingsPage(),
    monthDaySelector: (context) =>  MonthDaysSelector(),
   



  };
}