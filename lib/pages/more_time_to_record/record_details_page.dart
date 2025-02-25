import 'package:careme24/pages/payment/payment_defoult_screen.dart';
import 'package:careme24/utils/utils.dart';
import 'package:careme24/widgets/time_container.dart';
import 'package:flutter/material.dart';
import '../../theme/app_style.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/date_container.dart';

class RecordDetailsOneScreen extends StatefulWidget {
  const RecordDetailsOneScreen({super.key});


  @override
  State<RecordDetailsOneScreen> createState() => _RecordDetailsOneScreenState();
}

class _RecordDetailsOneScreenState extends State<RecordDetailsOneScreen> {
  bool isSelectedIndexTime = false;
  int isSelectedIndex1 = -1;
  int isSelectedIndex2 = -1;

  callBackTime(varTime){
    setState(() {
      isSelectedIndexTime = varTime;
    });
  }


  bool isRecordSelected(){
    return isSelectedIndexTime == true && (isSelectedIndex1 != -1 || isSelectedIndex2 != -1) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(48),
                leadingWidth: 43,
                leading: AppbarImage(
                    height: getVerticalSize(16),
                    width: getHorizontalSize(11),
                    svgPath: ImageConstant.imgArrowleft,

                    margin: getMargin(left: 15, right: 15,top: 15, bottom: 15),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                centerTitle: true,
                title: AppbarTitle(text: 'Запись к врачу'),

                styleType: Style.bgFillBlue60001),
            body: SizedBox(
                width: size.width,
                child: SingleChildScrollView(
                    padding: getPadding(top: 18),
                    child: Padding(
                        padding: getPadding(left: 22, right: 36, bottom: 5),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("На этой неделе",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtH1),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: getPadding(
                                          left: 19, top: 13, right: 4),
                                      child: GridView.builder(
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  mainAxisExtent:
                                                      getVerticalSize(67),
                                                  crossAxisCount: 4,
                                                  mainAxisSpacing:
                                                      getHorizontalSize(18),
                                                  crossAxisSpacing:
                                                      getHorizontalSize(18)),
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: 6,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (isSelectedIndex1 == index){
                                                      isSelectedIndex1 = -1;
                                                    } else {
                                                      isSelectedIndex1 = index;
                                                    }
                                                    isSelectedIndex2 = -1;
                                                  });
                                                },
                                                child: DateContainer(
                                                  background: isSelectedIndex1 == index
                                                      ? ColorConstant.bluebg
                                                      : Colors.white,
                                                  dayColor: isSelectedIndex1 == index
                                                      ? AppStyle.txtMontserratSemiBold18WhiteA700
                                                      : AppStyle.txtMontserratSemiBold18Black900,
                                                  weekDayColor: isSelectedIndex1 == index
                                                      ? AppStyle.txtMontserratMedium15WhiteA700
                                                      : AppStyle.txtMontserratMedium15Blue600,
                                                ));
                                          }))),
                              Padding(
                                  padding: getPadding(left: 2, top: 31),
                                  child: Text("На следущей неделе",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtH1)),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: getPadding(
                                          left: 19, top: 12, right: 4),
                                      child: GridView.builder(
                                          shrinkWrap: true,
                                          gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisExtent:
                                              getVerticalSize(67),
                                              crossAxisCount: 4,
                                              mainAxisSpacing:
                                              getHorizontalSize(18),
                                              crossAxisSpacing:
                                              getHorizontalSize(18)),
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          itemCount: 4,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (isSelectedIndex2 == index){
                                                      isSelectedIndex2 = -1;
                                                    } else {
                                                      isSelectedIndex2 = index;
                                                    }
                                                    isSelectedIndex1 = -1;
                                                  });
                                                },
                                                child: DateContainer(
                                                  background: isSelectedIndex2 == index
                                                      ? ColorConstant.bluebg
                                                      : Colors.white,
                                                  dayColor: isSelectedIndex2 == index
                                                      ? AppStyle.txtMontserratSemiBold18WhiteA700
                                                      : AppStyle.txtMontserratSemiBold18Black900,
                                                  weekDayColor: isSelectedIndex2 == index
                                                      ? AppStyle.txtMontserratMedium15WhiteA700
                                                      : AppStyle.txtMontserratMedium15Blue600,
                                                ));
                                          }))),
                              Padding(
                                  padding: getPadding(left: 1, top: 36, bottom: 12),
                                  child: Text("Время записи",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtH1)),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: getPadding(
                                      left: 12, top: 12,),
                                    child: Center(child: TimeContainer(timeCount: 17, callback: callBackTime,)),
                                  )),
                            ])))),
            bottomNavigationBar: CustomButton(
                height: getVerticalSize(56),
                text: "Записаться",
                margin: getMargin(left: 24, right: 22, bottom: 20, top: 10),
                variant: isRecordSelected() ? ButtonVariant.GradientBlue60001IndigoA400 : ButtonVariant.FillGray50001,
                fontStyle: isRecordSelected() ? ButtonFontStyle.MontserratRomanSemiBold18White: ButtonFontStyle.MontserratRomanSemiBold18Gray300,
                onTap: () {
                    if (isRecordSelected()){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentDefoultScreen()));
                    }
                })));
  }



  onTapArrowleft26(BuildContext context) {
    Navigator.pop(context);
  }
}
