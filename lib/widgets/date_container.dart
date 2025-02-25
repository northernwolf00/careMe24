import 'package:careme24/theme/app_decoration.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:flutter/material.dart';


class DateContainer extends StatelessWidget {
  late Color background;
  late TextStyle dayColor;
  late TextStyle weekDayColor;

  DateContainer({super.key, 
    required this.background,
    required this.dayColor,
    required this.weekDayColor,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 66,
      decoration: AppDecoration.smallOutBlackLine.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10, color: background),
      child: Column(
        children: [Padding(
          padding: getPadding(top: 8, bottom: 8),
          child: Text("ПН", style: weekDayColor),
        ),
        Text("25", style: dayColor,)],
      ),
    );
  }
}
