import 'dart:developer';

import 'package:careme24/models/danger_model.dart';
import 'package:careme24/models/dangerous_models/air_pollution_model.dart';
import 'package:careme24/models/dangerous_models/pressure_wind_model.dart';
import 'package:careme24/models/dangerous_models/weather_forecast_model.dart';
import 'package:careme24/pages/dangerous/air_pollution.dart';
import 'package:careme24/pages/dangerous/pressure_info.dart';
import 'package:careme24/pages/dangerous/temp_info.dart';
import 'package:careme24/pages/dangerous/wind_info.dart';
import 'package:careme24/widgets/dangerous_icons/air_pollution.dart';
import 'package:careme24/widgets/dangerous_icons/pressure.dart';
import 'package:careme24/widgets/dangerous_icons/temperature.dart';
import 'package:careme24/widgets/dangerous_icons/widgets/infoIcon.dart';
import 'package:careme24/widgets/dangerous_icons/wind.dart';
import 'package:flutter/material.dart';

class DangerousIconsList extends StatefulWidget {
  const DangerousIconsList({
    super.key,
    required this.isGeoEnable,
    required this.airQuality,
    required this.weatherForecast,
    required this.pressureAndWind,
    required this.icons,
    required this.city,
  });

  final bool isGeoEnable;
  final AirQualityResponse airQuality;
  final WeatherForecast weatherForecast;
  final PressureAndWindData pressureAndWind;
  final List<DangerModel> icons;
  final String city;

  @override
  _DangerousIconsListState createState() => _DangerousIconsListState();
}

class _DangerousIconsListState extends State<DangerousIconsList> {
  List<Map<String, dynamic>> iconsData = [];
  List<DangerModel> infoIconData = [];

  @override
  void initState() {
    super.initState();
    infoIconData = widget.icons;

    
    

    int airPollutionIndex = widget.airQuality.list.isNotEmpty ? widget.airQuality.list[0].aqi : 0;
    int temperatureIndex = getTempIndex(widget.weatherForecast.currentTemperature.toInt());
    int pressureIndex = getPressureIndex(widget.pressureAndWind.currentPressure.toInt());
    int windIndex = getSpeedIndex(widget.pressureAndWind.currentWindSpeed);

    iconsData = [
      
      {
        'widget': AirPollutionIcon(
          haveData: widget.airQuality.haveData,
          aqi: airPollutionIndex,
          onTap: () {
            if (widget.airQuality.haveData) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AirPollutionInfo(city: widget.city, airQuality: widget.airQuality.list[0])),
              );
            }
          },
        ),
        'index': airPollutionIndex,
        'isActive': true,
      },
      {
        'widget': TemperatureIcon(
          haveData: widget.weatherForecast.haveData,
          temp: widget.weatherForecast.currentTemperature.toInt(),
          onTap: () {
            if (widget.weatherForecast.haveData) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TempInfo(temp: widget.weatherForecast.currentTemperature.toInt(), city: widget.city, forecast: widget.weatherForecast)),
              );
            }
          },
        ),
        'index': temperatureIndex,
        'isActive': true,
      },
      {
        'widget': PressureIcon(
          haveData: widget.pressureAndWind.haveData,
          onTap: () {
            if (widget.pressureAndWind.haveData) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PressureInfo(city: widget.city, pressure: widget.pressureAndWind)),
              );
            }
          },
          pressure: widget.pressureAndWind.currentPressure.toInt(),
        ),
        'index': pressureIndex,
        'isActive': true,
      },
      {
        'widget': WindIcon(
          haveData: widget.pressureAndWind.haveData,
          onTap: () {
            if (widget.pressureAndWind.haveData) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WindInfo(city: widget.city, wind: widget.pressureAndWind)),
              );
            }
          },
          speed: widget.pressureAndWind.currentWindSpeed,
          windDirector: widget.pressureAndWind.currentWindDirection,
        ),
        'index': windIndex,
        'isActive': true,
      },

...infoIconData.map((icon) {
      return {
        'widget': Infoicon(icon: icon, city: widget.city),
        'index': getValue(icon.dangerLevel),
        'isActive': icon.isActive,
      };
    }).toList(),
  ];

  // Sorting: Active icons first, then by index in descending order
  iconsData.sort((a, b) {
  if (a['isActive'] == b['isActive']) {
    return b['index'].compareTo(a['index']); // Sort by index if isActive is the same
  }
  return a['isActive'] ? -1 : 1; // isActive = true comes first
});



    //   ...List.generate(infoIconData.length, (index){
    //     return {
    //       'widget' : Infoicon(icon: infoIconData[index], city: widget.city,),
    //       'index' : getValue(infoIconData[index].dangerLevel),
          
    //     };
    //   })
    // ];

    // iconsData.sort((a, b) => b['index'].compareTo(a['index'])); 
  }

  int getValue (String text){
    switch (text) {
      case 'очень опасно':
        return 5;
      case 'опасно':
        return 4;
      case 'в норме':
        return 1;
      case 'средний':
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...iconsData.map((iconData) {
            return iconData['widget']; 
          }),
        ],
      ),
    );
  }
}

int getTempIndex(int value) {
  if (value >= 25) {
    return 3;   
  } else if (value >= 5 && value < 25) {
    return 2;  // Средне высокая температура
  } else if (value >= -10 && value <= 4) {
    return 1;  // Средняя температура
  } else if (value >= -25 && value <= -11) {
    return 4;  // Низкая температура
  } else if (value <= -26) {
    return 5;  // Низкая температура
  } else {
    return 0;
  }
}

int getPressureIndex(int pressure) {
  if (pressure >= 1040) {
    return 5;
  } else if (pressure >= 1020 && pressure < 1040) {
    return 3;
  } else if (pressure >= 1000 && pressure < 1020) {
    return 1;//
  } else if (pressure >= 950 && pressure < 1000) {
    return 3;
  } else {
    return 5;
  }
}

int getSpeedIndex(num speed) {
  if (speed > 36) {
    return 5;
  } else if (speed > 18 && speed <= 35) {
    return 3;
  } else {
    return 1;
  }
}
