import 'package:careme24/app.dart';
import 'package:careme24/firebase_options.dart';
import 'package:careme24/service/env_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  await initializeDateFormatting('ru', null);
  await EnvService().loadEnv();
  runApp(const App());
}