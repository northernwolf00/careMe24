import 'package:careme24/models/danger_model.dart';
import 'package:careme24/pages/dangerous/dang_info_screen.dart';
import 'package:careme24/theme/app_style.dart';
import 'package:careme24/theme/dangerous_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/size_utils.dart';

class Infoicon extends StatelessWidget {
  final DangerModel icon;
  final String city;

  const Infoicon({
    super.key, 
    required this.icon,
    required this.city
  });

  String getIcon(String value) {
    switch (value) {
      case 'Электромагнитное излучение'://!
        return 'assets/images/img_electromagnetic_radiation.svg';
      case 'Радиактивный фон'://!
        return 'assets/images/img_radiation.svg';
      case 'Торнадо смерч'://!
        return 'assets/images/img_tornado.svg';
      case 'Солнечная радиация': //!
        return 'assets/images/img_solar_radiation.svg';
      case 'Пожар'://!
        return 'assets/images/forestFire.svg';
      case 'Террористическая опасность'://!
        return 'assets/images/img_terrorist_danger.svg';
      case 'Воздушная тревога'://!
        return 'assets/images/img_air_warning.svg';
      case 'Землятрясение': //!
        return 'assets/images/img_earthquake.svg';
      case 'Наводнение': //!
        return 'assets/images/img_flood.svg';
      case 'Цунами'://!
        return 'assets/images/img_tsunami.svg';
      
      case 'Химическое заражение'://!
        return 'assets/images/1.svg';
      case 'Вирусное заражение': //!
        return 'assets/images/1.svg';
      case 'Гололёд':
        return 'assets/images/2.svg';
      case 'Сильный туман'://!
        return 'assets/images/img_fog.svg';
      case 'Снежная лавина'://!
        return 'assets/images/img_snow_avalanche.svg';
      case 'Камнепад'://!
        return 'assets/images/img_rockfall.svg';
      case 'Извержение вулкана'://!
        return 'assets/images/img_volcano.svg';
      case 'Крупный град'://!
        return 'assets/images/2.svg';
      
      default:
        return 'assets/images/default_icon.svg';
    }
  }

  LinearGradient getColor(String text) {
    switch (text) {
      case 'очень опасно':
        return DangerousColors.red;
      case 'опасно':
        return DangerousColors.darkYellow;
      case 'в норме':
        return DangerousColors.green;
      case 'средний':
        return DangerousColors.yellow;
      default:
        return DangerousColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool haveData = icon.dangerLevel.isNotEmpty;

    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DangerInfoScreen(model: icon, city: city,)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                icon.incidentType,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppStyle.txtInterExtraBold12.copyWith(
                  fontSize: 10, 
                  color: Colors.black, 
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              height: 79,
              width: 79,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: haveData ? getColor(icon.dangerLevel) : DangerousColors.grey,
              ),
              child: SvgPicture.asset(
                getIcon(icon.incidentType),
                color: Colors.black
              ),
            ),
            Padding(
              padding: getPadding(top: 7),
              child: Text(
                icon.dangerLevel,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtMontserratF14W600Gray2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
