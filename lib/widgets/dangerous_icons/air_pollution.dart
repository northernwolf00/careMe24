import 'package:careme24/theme/app_style.dart';
import 'package:careme24/theme/dangerous_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/size_utils.dart';

class AirPollutionIcon extends StatelessWidget {
  final int aqi;
  final bool haveData;
  final VoidCallback onTap;

  const AirPollutionIcon({
    super.key, 
    required this.onTap,
    required this.haveData,
    required this.aqi,
  });

  String getValue(int value){
    switch(value){
      case 1:
        return 'Низкий';
      case 2:
        return 'Средний';
      case 3:
        return 'Повышенный';
      case 4:
        return 'Высокий';
      case 5:
        return 'Очень высокий';
    }
    return 'Нет данных';
  }

  String getIcon(int value){
    switch(value){
      case 1:
      return 'assets/icons/air_pollution/1.svg';
      case 2:
      return 'assets/icons/air_pollution/2.svg';
      case 3:
      return 'assets/icons/air_pollution/3.svg';
      case 4:
      return 'assets/icons/air_pollution/4.svg';
      case 5:
      return 'assets/icons/air_pollution/5.svg';
    }
    return 'assets/icons/air_pollution/1.svg';
  }

  LinearGradient getColor(int value){
    switch(value){
      case 1:
      return DangerousColors.green;
      case 2:
      return DangerousColors.yellow;
      case 3:
      return DangerousColors.darkYellow;
      case 4:
      return DangerousColors.red;
      case 5:
      return DangerousColors.darkRed;
    }
    return DangerousColors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        width: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                'Загрязнение воздуха',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppStyle.txtInterExtraBold12.copyWith(fontSize: 10, color: Colors.black, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: 79,
              width: 79,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: haveData ? getColor(aqi) : DangerousColors.grey
              ),
              child: SvgPicture.asset(
                getIcon(aqi),
                color: haveData ? null : Colors.white,
              )
            ),
            Padding(
              padding: getPadding(top: 7),
              child: Text(
                haveData ? getValue(aqi) : 'Нет данных',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtMontserratF14W600Gray2
              )
            )
          ],
        ),
      ),
    );
  }
}
