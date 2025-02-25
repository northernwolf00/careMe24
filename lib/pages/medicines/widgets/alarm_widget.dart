// import 'package:alarm/alarm.dart';
// import 'package:alarm/model/alarm_settings.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import 'package:flutter/material.dart';
// import 'package:alarm/alarm.dart';
// import 'package:intl/intl.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Alarm.init();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Alarm Demo',
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Alarm Demo')),
//         body: const AlarmPage(),
//       ),
//     );
//   }
// }

// class AlarmPage extends StatelessWidget {
//   const AlarmPage({super.key});

//   Future<void> _setAlarm(BuildContext context) async {
//     final now = DateTime.now();
//     DateTime scheduledTime = DateTime(now.year, now.month, now.day, 8, 30);
//     if (scheduledTime.isBefore(now)) {
//       scheduledTime = scheduledTime.add(const Duration(days: 1));
//     }

//     final int alarmId = DateTime.now().millisecondsSinceEpoch; // Unique ID

//     final alarmSettings = AlarmSettings(
//       id: alarmId,
//       dateTime: scheduledTime,
//       assetAudioPath: 'assets/alarm_sound.mp3',
//       loopAudio: true,
//       vibrate: true,
//       fadeDuration: 3.0,
//       notificationTitle: 'Medicine Alarm',
//       notificationBody: 'Time to take your medicine',
//       enableNotificationOnKill: true,
//     );

//     await Alarm.set(
//       alarmSettings: alarmSettings,
      
//       onRing: () {
//         if (context.mounted) {
//           showMedicineAlarmDialog(
//             context,
//             time: DateFormat('HH:mm').format(scheduledTime),
//             medicines: 'Феназепам, эргоферон',
//             onStop: () => Alarm.stop(alarmId),
//             onSnooze30: () => _snoozeAlarm(context, alarmSettings, 30),
//             onSnooze60: () => _snoozeAlarm(context, alarmSettings, 60),
//             onCancel: () => Alarm.stop(alarmId),
//           );
//         }
//       },
//     );
//   }

//   Future<void> _snoozeAlarm(BuildContext context, AlarmSettings settings, int minutes) async {
//     final newTime = DateTime.now().add(Duration(minutes: minutes));
//     final int newAlarmId = DateTime.now().millisecondsSinceEpoch;

//     final snoozeSettings = settings.copyWith(
//       id: newAlarmId,
//       dateTime: newTime,
//     );

//     await Alarm.set(
//       alarmSettings: snoozeSettings,
//       onRing: () {
//         if (context.mounted) {
//           showMedicineAlarmDialog(
//             context,
//             time: DateFormat('HH:mm').format(newTime),
//             medicines: 'Феназепам, эргоферон',
//             onStop: () => Alarm.stop(newAlarmId),
//             onSnooze30: () => _snoozeAlarm(context, snoozeSettings, 30),
//             onSnooze60: () => _snoozeAlarm(context, snoozeSettings, 60),
//             onCancel: () => Alarm.stop(newAlarmId),
//           );
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: GestureDetector(
//         onTap: () => _setAlarm(context),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.access_time),
//             const SizedBox(width: 10),
//             const Text(
//               '8:30',
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void showMedicineAlarmDialog(
//   BuildContext context, {
//   required String time,
//   required String medicines,
//   required VoidCallback onStop,
//   required VoidCallback onSnooze30,
//   required VoidCallback onSnooze60,
//   required VoidCallback onCancel,
// }) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(time, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             Text(medicines, style: TextStyle(fontSize: 16, color: Colors.grey[800]), textAlign: TextAlign.center),
//             const SizedBox(height: 16),

//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//                 onStop();
//               },
//               child: Container(
//                 width: 80,
//                 height: 80,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: LinearGradient(colors: [Color(0xFFFF3A44), Color(0xFFFF8086)]),
//                 ),
//                 child: const Center(
//                   child: Text('СТОП', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Divider(height: 1),

//             InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//                 onSnooze30();
//               },
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 8.0),
//                 child: Text('Отложить на 30 минут', style: TextStyle(color: Colors.blue, fontSize: 16)),
//               ),
//             ),
//             const Divider(height: 1),

//             InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//                 onSnooze60();
//               },
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 8.0),
//                 child: Text('Отложить на час', style: TextStyle(color: Colors.blue, fontSize: 16)),
//               ),
//             ),
//             const Divider(height: 1),

//             InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//                 onCancel();
//               },
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 8.0),
//                 child: Text('Отменить прием', style: TextStyle(color: Colors.blue, fontSize: 16)),
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
