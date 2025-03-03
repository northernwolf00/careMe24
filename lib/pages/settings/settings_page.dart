import 'dart:math';

import 'package:careme24/blocs/drawer/drawer_cubit.dart';
import 'package:careme24/blocs/drawer/drawer_state.dart';
import 'package:careme24/pages/medical_bag/medical_bag_page.dart';
import 'package:careme24/pages/medical_bag/widgets/custom_gradient_button.dart';
import 'package:careme24/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  String lat = '';
  String long = '';


  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

   Future<void> _determinePosition() async { 
  Position location = await Geolocator.getCurrentPosition();
  setState(() {
    lat = location.latitude.toString();
    long = location.longitude.toString();
  });
}

   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: getVerticalSize(48),
        leadingWidth: 43,
        leading: AppbarImage(
            height: getVerticalSize(16),
            width: getHorizontalSize(11),
            svgPath: ImageConstant.imgArrowleft,
            margin: getMargin(left: 15, top: 15, bottom: 15),
            onTap: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        title: AppbarTitle(
          text: "Настройки",
        ),
        styleType: Style.bgFillBlue60001,
        actions: const [],
      ),
      body: SafeArea(
        child: BlocBuilder<DrawerCubit, DrawerState>(builder: (context, state) {
          if (state is DrawerStateLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(title: ' МОЙ АККАУНТ'),
                  GestureDetector(
                    onTap: () {},
                    child:  Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundImage: state.userInfo.personalInfo.avatar.isNotEmpty
                                  ? NetworkImage(state.userInfo.personalInfo.avatar,scale: 1):
                                  const AssetImage('assets/images/profil.png',),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    state.userInfo.personalInfo.full_name,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    state.userInfo.phone.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const SectionTitle(title: 'МОЯ ГЕОЛОКАЦИЯ'),
                  const SizedBox(height: 8),
                  AddButtonSettings(
                    title: '[$lat, $long]',
                    onTap: () {
                      //       Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => MedicineListScreen(title: "")),
                      // );
                      // Handle "Добавить запрос" button
                    },
                  ),
                  const SizedBox(height: 15),
                  AddButtonSettings(
                    title: 'Удалить аккаунт',
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AddMedicineDialogSettings();
                        },
                      );
                      //       Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => MedicineListScreen(title: "title")),
                      // );
                      // Handle "Добавить" button
                    },
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRouter.resetEmailPhone);
                          },
                          child: Text(
                            'Изменить email или номер телефона',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium!.merge(
                                  TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          } 
            return Container();
          }
        )
      ),
    );
  }
}

class AddButtonSettings extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const AddButtonSettings({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddMedicineDialogSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: SizedBox(
        height: 230,
        width: MediaQuery.of(context).size.width - 20,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        size: 34,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: const Text(
                      'Вы уверены, что хотите удалить учетную запись CareMe24?',
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          fontFamily: "Montserrat",
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: CustomGradientButton(
                      text: 'Да',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: CustomGradientRedButton(
                      text: 'Нет',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
