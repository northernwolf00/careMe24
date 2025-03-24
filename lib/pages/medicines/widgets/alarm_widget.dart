import 'dart:developer';
import 'dart:io';
import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:careme24/pages/medicines/cubit/intake_cubit.dart';
import 'package:careme24/pages/medicines/model/owner_id_model.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AlarmScreen extends StatefulWidget {
  final List<MedicineItem> medicine;
  final String day;
  final String time;
  final String id;

  const AlarmScreen(
      {Key? key, required this.medicine, required this.day, required this.time, required this.id})
      : super(key: key);
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  String selectTime = '';

  // @override
  // void initState() {
  //   super.initState();
  //   // Listen for alarm events
  //   Alarm.ringStream.stream.listen((alarmId) {
  //     _showAlarmDialog();
  //   });
  // }

  void _pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        final now = DateTime.now();
        final selectedDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          _selectedTime.hour,
          _selectedTime.minute,
        );
        if (widget.time != '0 : 0') {
          context.read<InTakeTimeCubit>().updateMedicines(
            widget.id,
              widget.day,
              DateFormat('HH:mm').format(selectedDateTime),
              widget.medicine[0].aidKit.medicines[0].id);
                ElegantNotification.success(description: Text("Время приема обновлено"))
                      .show(context);
               Navigator.pop(context);
        } else {
          context.read<InTakeTimeCubit>().createMedicines(
              widget.day,
              DateFormat('HH:mm').format(selectedDateTime),
              widget.medicine[0].aidKit.medicines[0].id);
               ElegantNotification.success(description: Text("Время приема создано"))
                      .show(context);
               Navigator.pop(context);
        }
      });
      _scheduleAlarm();
    }
  }

  void _scheduleAlarm() {
    final now = DateTime.now();
    final selectedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    
    final alarmSettings = AlarmSettings(
      id: 42,
      dateTime: selectedDateTime,
      assetAudioPath: 'assets/alarm_sound.mp3',
      loopAudio: true,
      vibrate: true,
      warningNotificationOnKill: Platform.isIOS,
      androidFullScreenIntent: true,
      notificationSettings: const NotificationSettings(
        title: 'Прием лекарств',
        body: 'Время принять лекарство',
        stopButton: 'СТОП',
        icon: 'notification_icon',
      ),
    );

    Alarm.set(alarmSettings: alarmSettings);
    // Navigator.pop(context);
  log( 'Alarm scheduled');
  }

  void _stopAlarm() {
    Alarm.stop(42);
    Navigator.pop(context);
  }

  void _snoozeAlarm(Duration duration) {
    Alarm.stop(42);
    _scheduleAlarm();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: SizedBox(
        height: 480,
        width: MediaQuery.of(context).size.width - 20,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _pickTime(context),
                child: Text(
               widget.time == '0 : 0' ? '0:0' : widget.time,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              ...List.generate(
                1,
                (index) {
                  return Text(widget.medicine.map((e) => e.title).join(', '),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black));
                },
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: _stopAlarm,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(50),
                  backgroundColor: Colors.redAccent,
                ),
                child: Center(
                  child: Text('СТОП',
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () => _snoozeAlarm(Duration(minutes: 30)),
                child: Text('Отложить на 30 минут',
                    style: TextStyle(fontSize: 18, color: Colors.blueAccent)),
              ),
              SizedBox(height: 10),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () => _snoozeAlarm(Duration(minutes: 60)),
                child: Text('Отложить на час',
                    style: TextStyle(fontSize: 18, color: Colors.blueAccent)),
              ),
              SizedBox(height: 10),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              // ElevatedButton(
              //   onPressed: _scheduleAlarm,
              //   child: Text('СТОП',
              //       style: TextStyle(fontSize: 18, color: Colors.white)),
              //   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              // ),
              TextButton(
                onPressed: () {
                  _stopAlarm();
                  context.read<InTakeTimeCubit>().deletMedicines(widget.id, widget.day);
                   ElegantNotification.success(description: Text('Время приема удалено'))
                      .show(context);
                  },
                child: Text('Отменить прием',
                    style: TextStyle(fontSize: 18, color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
