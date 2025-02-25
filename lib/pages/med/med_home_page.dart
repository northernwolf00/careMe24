import 'package:careme24/constants.dart';
import 'package:careme24/pages/med/what_do_med_card.dart';
import 'package:careme24/pages/med_card/medical_card_page_list.dart';
import 'package:careme24/theme/theme.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/custom_image_view.dart';
import 'package:careme24/widgets/drawer_widget.dart';
import 'package:careme24/widgets/for_whom.dart';
import 'package:careme24/widgets/paid_service_swither.dart';
import 'package:flutter/material.dart';

final _controller = ValueNotifier<bool>(false);

class HoneyMainPage extends StatelessWidget {
  final bool isSelectedSwitch = false;

  const HoneyMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    TipyHelp.changeHelp("Передите в чат с врачем");
    WhoCall.changeWho("ВРАЧ ВЫЗВАН");
    AfterPay.changeAfterSmile();
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(41, 142, 235, 1),
              title: AppbarTitle(text: "Медицинская помощь")
            ),
            drawer: Drawer(
              child: DrawerWidget()
            ),
            body: SingleChildScrollView(
              child: Container(
                  width: double.maxFinite,
                  padding: getPadding(left: 20, top: 21, right: 20, bottom: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MedicalCardListPage()));
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: 40,
                            width: 150,
                            color: Colors.red,
                            child: Center(child: const Text('Медкарта', style: TextStyle(color: Colors.white),)),
                          ),
                        ),
                        Padding(
                            padding: getPadding(left: 2, right: 3, top: 5),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ForWhom(
                                    name: 'Мне',
                                  ),
                                  const PaySwitcher(),
                                ])),
                        Padding(
                          padding: getPadding(top: 14),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(178, 218, 255, 100),
                            ),
                            width: MediaQuery.of(context).size.width - 40,
                            height: 80,
                            child: Padding(
                              padding: getPadding(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text('Проблема',
                                        style: AppStyle.txtMontserratSemiBold19,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  CustomImageView(
                                    svgPath:
                                        ImageConstant.imgArrowdownLightBlue900,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: getPadding(
                                left: 3, top: 30, right: 3, bottom: 5),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  WhatDoMedCard(
                                    color_icon: ColorConstant.blueicon,
                                    icon_path: ImageConstant.doctorIcon,
                                    action_text: "Вызов врача",
                                  ),
                                  WhatDoMedCard(
                                    color_icon: ColorConstant.violet,
                                    icon_path: ImageConstant.notePenIcon,
                                    action_text: "Запись к врачу",
                                  ),
                                  WhatDoMedCard(
                                    color_icon: ColorConstant.yellow700,
                                    icon_path: ImageConstant.medPhoneIcon,
                                    action_text: "Помощь онлайн",
                                  ),
                                  WhatDoMedCard(
                                    color_icon: ColorConstant.green400,
                                    icon_path: ImageConstant.twoArmPlusIcon,
                                    action_text: "Самопомощь",
                                  ),
                                ]))
                      ])),
            )));
  }
}
