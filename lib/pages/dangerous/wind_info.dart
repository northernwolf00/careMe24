import 'package:careme24/models/dangerous_models/pressure_wind_model.dart';
import 'package:careme24/pages/dangerous/recomendation_page.dart';
import 'package:careme24/theme/app_decoration.dart';
import 'package:careme24/theme/app_style.dart';
import 'package:careme24/theme/dangerous_colors.dart';
import 'package:careme24/widgets/info/info_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class WindInfo extends StatelessWidget {
  const WindInfo({
    super.key,
    required this.city,
    required this.wind,
  });

  final String city;
  final PressureAndWindData wind;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 43,
        centerTitle: true,
        title: Text("Фактор опасности", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(24, 14, 24, 14),
            child: Row(
              children: [
                Container(
                  height: 79,
                  width: 79,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: getColor(getValue(wind.currentWindSpeed))
                  ),
                  child: SvgPicture.asset(getIcon(getValue(2)))
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ветер',style: AppStyle.txtMontserratBold18,),
                    Text(city, style: TextStyle(color: Color.fromRGBO(51, 132, 226, 1), fontSize: 15, fontWeight: FontWeight.w500)),
                    Container(
                      margin: EdgeInsets.only(top: 9),
                      decoration: BoxDecoration(
                        gradient: getColor(getValue(2)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 8),
                      child: Text(getWindSpeedDescription(getValue(wind.currentWindSpeed)),style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 26.5),
            margin: EdgeInsets.only(top: 18, bottom: 18, left: 23, right: 23),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Скорость ветра',style: TextStyle(color: Color.fromRGBO(44, 62, 79, 1), fontSize: 15, fontWeight: FontWeight.w500)),
                    Text(city, style: TextStyle(color: Color.fromRGBO(51, 132, 226, 1), fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
                Column(
                  children: [
                  Transform.rotate(
                    angle: wind.currentWindDirection * (3.1415926535897932 / 180), 
                    child: Icon(
                      Icons.arrow_upward,
                      size: 35,
                      color: Color.fromRGBO(77, 147, 230, 1),
                    ),
                  ),
                  Text(
                    getWindDirection(wind.currentWindDirection.toInt()), 
                    style: AppStyle.txtMontserratBold14.copyWith(
                      color: Color.fromRGBO(77, 147, 230, 1),
                      fontSize: 22,
                      fontWeight: FontWeight.w600
                    ),
                  ), 
                ],
              ),
                Column(
                  children: [
                    Text(wind.currentWindSpeed.toStringAsFixed(2),style: TextStyle(color: Color.fromRGBO(51, 132, 226, 1), fontSize: 32, fontWeight: FontWeight.w600)),
                    Text('м/с',style: TextStyle(color: Color.fromRGBO(51, 132, 226, 1), fontSize: 32, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: true,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: AppDecoration.outlineGray3004.copyWith(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Прогноз",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtH1
                  ),
                  SizedBox(height: 18,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(wind.windSpeedList.length, (index){
                          return InfoLabel(
                            wind: true,
                            windDirection: wind.windDirectionList[index].toInt(),
                            date: DateFormat("MM dd HH:mm").format(DateTime.parse(wind.date[index].toString())), 
                            value: (wind.windSpeedList[index] / 3.6).toStringAsFixed(2),
                          );
                        })
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Скорость ветра м/с",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtMontserratBold14.copyWith(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600)
                  ),
                ],
              )
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => RecomendationPage(
                      recomendations: [
                        Recomendation(imagePath: 'assets/rec/w2.svg', text: 'Пакройте все форточки и окна, проверьте надёжность их закрытия'),
                        Recomendation(imagePath: 'assets/rec/e.svg', text: 'Отключите электричество, газ и перекройте водопровод'),
                        Recomendation(imagePath: 'assets/rec/l.svg', text: 'Не пользуйтесь лифтом'),
                        Recomendation(imagePath: 'assets/rec/tree.svg', text: 'Не следует прятаться около стен домов, на остановках общественного транспорта, около рекламных щитов, под деревьями (особенно старыми и гнилыми), около недостроенных зданий'),
                      ],
                    )
                  )
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 23, vertical: 30),
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Color.fromRGBO(65, 73, 255, 1)
                  )
                ),
                child: Center(
                  child: Text(
                    'Рекомендации',
                    style: AppStyle.txtMontserratf18w600.copyWith(color: Color.fromRGBO(51, 132, 226, 1)),
                  ),
                ),
              ),
            ),
          )
        ],
      ), 
    );  
  }
} 

  int getValue(num speed) {
  if (speed > 36) {
      return 3; 
    } else if (speed > 18 && speed <= 35) {
      return 2; 
    } else{
      return 1;
    }
  }

  String getWindSpeedDescription(int value) {
    switch (value) {
      case 3:
        return "Сильный";
      case 2:
        return "Повышенный";
      case 1:
        return "В норме";
      default:
        return "Неизвестный уровень ветра.";
    }
  }

  String getIcon(int value){
    switch(value){
      case 1:
      return 'assets/icons/wind/1.svg';
      case 2:
      return 'assets/icons/wind/2.svg';
      case 3:
      return 'assets/icons/wind/3.svg';
    }
    return '';
  }

  LinearGradient getColor(int value){
    switch(value){
      case 1:
      return DangerousColors.green;
      case 2:
      return DangerousColors.yellow;
      case 3:
      return DangerousColors.red;
      case 4:
      return DangerousColors.blue;
      case 5:
      return DangerousColors.darkBlue;
    }
    return DangerousColors.grey;
  }
 