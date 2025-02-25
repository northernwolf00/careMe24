import 'package:careme24/blocs/app_bloc.dart';
import 'package:careme24/constants.dart';
import 'package:careme24/pages/services_call/select_reason_screen.dart';
import 'package:careme24/theme/app_style.dart';
import 'package:careme24/theme/color_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/custom_image_view.dart';
import 'package:careme24/widgets/drawer_widget.dart';
import 'package:careme24/widgets/for_whom.dart';
import 'package:careme24/widgets/paid_service_swither.dart';
import 'package:careme24/widgets/what_do_police_card.dart';
import 'package:flutter/material.dart';

import '../../utils/image_constant.dart';


final _controller = ValueNotifier<bool>(VersionConstant.isPaidSubscription);

class PoliceMainPage extends StatelessWidget {
  PoliceMainPage({super.key});

  String? seletedReason;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(41, 142, 235, 1),
              centerTitle: true,
              title: AppbarTitle(text: "Полиция")
            ),
            drawer: Drawer(
              child: DrawerWidget()
            ),
            body: SingleChildScrollView(
              child: Container(
                  width: double.maxFinite,
                  padding: getPadding(left: 20, top: 21, right: 20, bottom: 21),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                            padding: getPadding(left: 2, right: 3),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ForWhom(name: 'Мне',),
                                  const PaySwitcher(),
                                ])),
                        GestureDetector(
                          onTap: ()async{
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SelectReasonScreen(type: 'pol')))
                            .then((reason){
                              seletedReason = reason;
                            });
                          },
                          child: Padding(
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                          'Проблема',
                                          style: AppStyle.txtMontserratSemiBold19,
                                          overflow: TextOverflow.ellipsis
                                      ),
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
                        ),
                        Padding(
                            padding:
                            getPadding(left: 3, top: 30, right: 3, bottom: 5),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  WhatDoPoliceCard(
                                    color_icon: ColorConstant.redA200,
                                    icon_path: ImageConstant.policeIcon,
                                    action_text: "Сообщить",
                                  ),WhatDoPoliceCard(
                                    color_icon: ColorConstant.blueA200,
                                    icon_path: ImageConstant.hammerIcon,
                                    action_text: "Юрист онлайн",
                                  ),WhatDoPoliceCard(
                                    color_icon: ColorConstant.pinkA200,
                                    icon_path: ImageConstant.noteIcon,
                                    action_text: "Заявление",
                                  ), WhatDoPoliceCard(
                                    color_icon: ColorConstant.greenA70002,
                                    icon_path: ImageConstant.starNotificationIcon,
                                    action_text: "Рекомендации",
                                  ),
                                ]))
                      ])),
            )));
  }
}