class PressureAndWindData {
  final bool haveData;
  final num currentPressure;
  final num currentWindSpeed;
  final num currentWindDirection;
  final List<String> date;
  final List<num> pressureList;
  final List<num> windSpeedList;
  final List<num> windDirectionList;

  PressureAndWindData({
    required this.haveData,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentWindDirection,
    required this.date,
    required this.pressureList,
    required this.windSpeedList,
    required this.windDirectionList,
  });

  factory PressureAndWindData.fromJson(Map<String, dynamic>? json) {
    // Extracting data with null safety
    final date = (json?['hourly']?['time'] as List<dynamic>? ?? []).map((e) => e.toString()).toList();
    final pressureList = (json?['hourly']?['pressure_msl'] as List<dynamic>? ?? []).map((e) => e as num).toList();
    final windSpeedList = (json?['hourly']?['wind_speed_10m'] as List<dynamic>? ?? []).map((e) => e as num).toList();
    final windDirectionList = (json?['hourly']?['wind_direction_10m'] as List<dynamic>? ?? []).map((e) => e as num).toList();

    if (pressureList.isEmpty || windSpeedList.isEmpty || windDirectionList.isEmpty) {
      throw Exception('Missing pressure, wind speed, or direction data');
    }

    final currentHour = DateTime.now().hour;

    // Safely extracting current values
    final currentPressure = (currentHour < pressureList.length) 
        ? pressureList[currentHour].toDouble() 
        : pressureList.last.toDouble();

    final currentWindSpeed = (currentHour < windSpeedList.length) 
        ? windSpeedList[currentHour].toDouble() / 3.6 
        : windSpeedList.last.toDouble() / 3.6;
 
    final currentWindDirection = (currentHour < windDirectionList.length) 
        ? windDirectionList[currentHour] 
        : windDirectionList.last;

    return PressureAndWindData(
      haveData: true,
      currentPressure: currentPressure,
      currentWindSpeed: currentWindSpeed,
      currentWindDirection: currentWindDirection,
      date: date,
      pressureList: pressureList,
      windSpeedList: windSpeedList,
      windDirectionList: windDirectionList,
    );
  }
}
