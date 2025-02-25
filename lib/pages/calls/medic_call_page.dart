import 'dart:async';
import 'package:careme24/pages/calls/medical_call_button.dart';
import 'package:careme24/reason_ambulance.dart';
import 'package:careme24/theme/app_style.dart';
import 'package:careme24/utils/utils.dart';
import 'package:careme24/widgets/for_whom.dart';
import 'package:careme24/widgets/paid_service_swither.dart';
import 'package:careme24/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MedicCallPage extends StatefulWidget {
  const MedicCallPage({super.key});

  @override
  State<MedicCallPage> createState() => _MedicCallPageState();
}
bool _show = false;

final List<String> reasonText = <String>[
  'M1.8B11 Нарушение речи, слабость в конечеостях',
  "M1.BA41 Сильная боль в груди",
  "M1.NE81 Опасная травма, ранение, ДТП",
  "3.29. Цунами",
  "M1.MD11 Асфиксия всех видов, острое нарушение дыхания",
  "M1.5. Кровотечение сильное или внутреннее",
  "M1.6. Схватки, роды (скрыто,  добавить)",
  "C5",
  "C6",
  "C7",
  "C8"
];

final List<bool> reasonDisable = <bool>[
  false,
  false,
  true,
  true,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];

class _MedicCallPageState extends State<MedicCallPage> {

  @override
  void initState() {
    _show = false;
    _startTimer(); 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _show ? ColorConstant.gray100 : ColorConstant.pinkHelp,
      resizeToAvoidBottomInset: false,
        appBar: _show 
        ? CustomAppBar(
          height: getVerticalSize(48),
          leadingWidth: 43,
          leading: AppbarImage(
            height: getVerticalSize(16),
            width: getHorizontalSize(11),
            svgPath: ImageConstant.imgArrowleft,
            margin: getMargin(left: 32, top: 12, bottom: 20),
            onTap: () {
              Navigator.pop(context);
            }
          ),
          centerTitle: true,
          title: AppbarTitle(text: "Вызов скорой"),
          styleType: Style.bgFillBlue60001
        )
        : null,
        body: _show 
        ? Container(
          width: double.maxFinite,
          padding: getPadding(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: getPadding(left: 1, top: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ForWhom(name: 'Мне',),
                    const PaySwitcher(),
                  ]
                )
              ),
              Expanded(
                child: Container(
                  padding: getPadding(top: 14),
                  width: MediaQuery.of(context).size.width - 40,
                  height: MediaQuery.of(context).size.height - 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10)),
                          color: Color.fromRGBO(178, 218, 255, 100),
                        ),
                        width: MediaQuery.of(context).size.width - 40,
                        height: 80,
                        child: Padding(
                          padding: getPadding(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Причина вызова",
                                style: AppStyle.txtMontserratSemiBold19,
                              ),
                              GestureDetector(
                                onTap: (){
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => ListReasonSettingPage()));
                                },
                                child: CustomImageView(
                                  svgPath: ImageConstant
                                      .imgSettingsLightBlue900,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                        Expanded(
                            child: ListView.separated(
                          itemCount: reasonText.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Reason(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MedicalCallButton(text: reasonText[index],)));
                              },
                              text: reasonText[index],
                              disable: reasonDisable[index],
                              backgroundColor: Colors.white,
                            );
                          },
                      separatorBuilder:
                              (BuildContext context, int index) =>
                                  const Divider(indent: 0, height: 1),
                      )
                    )
                  ]
                ),
                            ),
              )
          ]
        )
      )
    : SizedBox(
        child: CustomImageView(
          svgPath: ImageConstant.imgHelpScreen,
          alignment:Alignment.center,
        )
      )
    );
  }

  _startTimer(){
    Timer(
      const Duration(seconds: 3),
      (){
        setState(() {
          _show = !_show;
        });
      }
    );
  }
}

