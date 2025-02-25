import 'package:careme24/theme/theme.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:flutter/material.dart';



class TimeContainer extends StatefulWidget {
  late int timeCount;
  late Function callback;
  TimeContainer({super.key, 
    required this.timeCount,
    required this.callback,
});


  @override
  State<TimeContainer> createState() => _TimeContainerState();
}

class _TimeContainerState extends State<TimeContainer> {
  int isSelectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(top: 22, left: 14, right: 14, bottom: 22),
      width: MediaQuery.of(context).size.width-40,
      decoration: AppDecoration.smallOutBlackLine.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10, color: Colors.white),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 96,
              childAspectRatio: 96 / 26,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18),
          itemCount: widget.timeCount,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelectedIndex == index){
                    isSelectedIndex = -1;
                    widget.callback(false);
                  } else {
                    isSelectedIndex = index;
                    widget.callback(true);
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstant.gray300),
                  borderRadius: BorderRadius.circular(10),
                  color: isSelectedIndex == index
                      ? ColorConstant.bluebg
                      : Colors.white,
                ),
                child: Center(
                    child: Text(
                  "9:30",
                  style: isSelectedIndex == index
                      ? AppStyle.txtMontserratSemiBold12WhiteA700
                      : AppStyle.txtMontserratSemiBold12Black900,
                )),
              ),
            );
          }),
    );
  }
}
