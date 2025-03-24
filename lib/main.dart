import 'package:alarm/alarm.dart';
import 'package:careme24/app.dart';
import 'package:careme24/firebase_options.dart';
import 'package:careme24/service/env_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

// Notification Plugin Instance
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Background Message Handler
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  showNotification(message);
}


void showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'high_importance_channel', // Channel ID
    'High Importance Notifications', // Channel Name
    channelDescription: 'This channel is used for important notifications.',
    importance: Importance.high,
    priority: Priority.high,
    sound: RawResourceAndroidNotificationSound(
        'alarm_sound'), // Custom MP3 for Android
    playSound: true,
  );

  const DarwinNotificationDetails iOSPlatformChannelSpecifics =
      DarwinNotificationDetails(
    sound: 'alarm_sound.wav', // Custom MP3/WAV for iOS (must be in "Resources")
  );

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title ?? "No Title",
    message.notification?.body ?? "No Body",
    platformChannelSpecifics,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, 
  );
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // iOS Notification Permission
  FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  // Initialize Notification Settings
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestAlertPermission: true, // Ask for alert permission
    requestSoundPermission: true, // Ask for sound permission
    requestBadgePermission: true, // Ask for badge permission
  );

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await initializeDateFormatting('ru', null);
   await Alarm.init();
  Intl.defaultLocale = 'ru';
  await EnvService().loadEnv();
  FlutterNativeSplash.remove();
  runApp(const App());
}
