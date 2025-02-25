import 'dart:developer';
import 'package:careme24/service/pref_service.dart';
import 'package:careme24/widgets/paid_service_swither.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExtrenalCallsWidget extends StatelessWidget {
  const ExtrenalCallsWidget({
    super.key,
    required this.fromMe,
  });

  final bool fromMe;

  Future<bool> _getNotificationSetting() async {
    // Возвращаем результат на основе fromMe
    return fromMe ? await PrefService.isNotifContact() : await PrefService.isNotifMe();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _getNotificationSetting(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // Если все прошло успешно, используем результат для отображения
        bool isEnable = snapshot.data ?? false;

        return Container(
          margin: const EdgeInsets.only(top: 14),
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 18, top: 18),
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 26),
                  child: Text(
                    'Экстренные службы',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff2c3e4f),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Image.asset('assets/images/Frame 8002.png'),
                    Container(
                      height: 57,
                      width: 57,
                      margin: const EdgeInsets.only(
                        left: 6,
                        right: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color(0xff92a3ff),
                      ),
                      child: Image.asset('assets/images/Frame.png'),
                    ),
                    SvgPicture.asset('assets/icons/mch.svg'),
                    const Spacer(),
                    PaySwitcher(
                      onChanged: (value) {
                        log('$value');
                        if (fromMe) {
                          PrefService.setNotifContact(value);
                        } else {
                          PrefService.setNotifMe(value);
                        }
                      },
                      on: isEnable,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
