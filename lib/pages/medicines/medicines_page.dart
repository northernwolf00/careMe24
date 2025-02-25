import 'package:careme24/pages/medical_bag/medical_bag_page.dart';
import 'package:careme24/pages/medicines/widgets/moth_days_selector.dart';
import 'package:careme24/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MedicinesPage extends StatefulWidget {
  const MedicinesPage({super.key});

  @override
  State<MedicinesPage> createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
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
          text: "Прием лекарств",
        ),
        styleType: Style.bgFillBlue60001,
        actions: [
          GestureDetector(
            onTap: () {
               Navigator.pushNamed(context, AppRouter.monthDaySelector);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: SizedBox(
                height: 24,
                width: 24,
                child: Image.asset(
                  'assets/images/add_image.png',
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: ' МОИ ЛЕКАРСТВА'),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRouter.monthDaySelector);
              },
              child: const Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundImage: AssetImage('assets/images/profil.png'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Пономаренко Ольга',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '+7-952-943-43-88',
                              style: const TextStyle(
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
            // const SectionTitle(title: 'ЗАПРОСЫ'),
            // const SizedBox(height: 8),
            // AddButton(
            //   title: 'Добавить запрос',
            //   onTap: () {
                //       Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => MedicineListScreen(title: "")),
                // );
                // Handle "Добавить запрос" button
            //   },
            // ),
            // const SizedBox(height: 24),
            // const SectionTitle(title: 'ДОПОЛНИТЕЛЬНО'),
            // const SizedBox(height: 8),
            // AddButton(
            //   title: 'Добавить',
            //   onTap: () {
                //       Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => MedicineListScreen(title: "title")),
                // );
                // Handle "Добавить" button
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
