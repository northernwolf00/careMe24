import 'package:careme24/theme/app_style.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:flutter/material.dart';

class InfoLabel extends StatelessWidget {
  final bool wind;
  final int windDirection;
  final String date;
  final String value;

  const InfoLabel({super.key, 
    this.wind = false,
    this.windDirection = 0,
    required this.date,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
          mainAxisAlignment:
          MainAxisAlignment.start,
          children: [
            Text(date,
                overflow:
                TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle
                    .txtMontserratMedium12Gray50001),
            wind 
              ? Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Color.fromRGBO(142, 150, 155, 1)),
                  ),
                  child: Column(
                    children: [
                      Transform.rotate(
                        angle: windDirection * (3.1415926535897932 / 180), 
                        child: Icon(
                          Icons.arrow_upward,
                          color: Color.fromRGBO(77, 147, 230, 1),
                        ),
                      ),
                      Text(
                        getWindDirection(windDirection), 
                        style: AppStyle.txtMontserratBold14.copyWith(
                          color: Color.fromRGBO(142, 150, 155, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                        ),
                      ), 
                      Text(
                        value, 
                        style: AppStyle.txtMontserratBold14.copyWith(
                          color: Color.fromRGBO(44, 62, 79, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.w500
                        ),
                      ) 
                    ],
                  ),
                ),                
              )


              : Padding(
                padding:
                getPadding(top: 10),
                child: RichText(
                    text:
                    TextSpan(children: [
                      TextSpan(
                          text: value,
                          style: AppStyle.txtMontserratSemiBold15Bluegray800),
                    ]),
                    textAlign:
                    TextAlign.left))
          ]),
    );
  }
}

String getWindDirection(int degrees) {
  if (degrees >= 338 || degrees < 23) {
    return "С"; // Север
  } else if (degrees >= 23 && degrees < 68) {
    return "С-В"; // Северо-восток
  } else if (degrees >= 68 && degrees < 113) {
    return "В"; // Восток
  } else if (degrees >= 113 && degrees < 158) {
    return "Ю-В"; // Юго-восток
  } else if (degrees >= 158 && degrees < 203) {
    return "Ю"; // Юг
  } else if (degrees >= 203 && degrees < 248) {
    return "Ю-З"; // Юго-запад
  } else if (degrees >= 248 && degrees < 293) {
    return "З"; // Запад
  } else if (degrees >= 293 && degrees < 338) {
    return "С-З"; // Северо-запад
  } else {
    return "Неизвестное направление"; // На случай неправильного значения
  }
}

