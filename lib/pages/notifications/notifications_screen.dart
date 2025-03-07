import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Мамулечка',
      'phone': '+7 952 934 91 24',
      'message': 'Был осуществлен вызов',
      'icon': Icons.local_fire_department,
      'iconColor': Colors.orange,
    },
    {
      'title': 'Мамулечка',
      'phone': '+7 952 934 91 24',
      'message': 'Был осуществлен вызов',
      'icon': Icons.favorite,
      'iconColor': Colors.pink,
    },
    {
      'title': 'Мамулечка',
      'phone': '+7 952 934 91 24',
      'message': 'Был осуществлен вызов',
      'icon': Icons.security,
      'iconColor': Colors.blue,
    },
    {
      'title': 'Атмосферное давление',
      'location': 'Москва',
      'danger': 'Очень опасно',
      'icon': Icons.speed,
      'iconColor': Colors.red,
      'comment': 'КомментарийКомментарийКомментарийКомментарий...',
    },
  ];

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
              margin: getMargin(left: 15, right: 15, top: 15, bottom: 15),
              onTap: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
          title: AppbarTitle(text: "Уведомления"),
          styleType: Style.bgFillBlue60001),
      
      body: ListView(
        padding: EdgeInsets.all(10),
        children: notifications.map((notification) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification['title'],
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.close, color: Colors.grey),
                    ],
                  ),
                  if (notification.containsKey('phone'))
                    Text(notification['phone'], style: TextStyle(color: Colors.blue)),
                  SizedBox(height: 8),
                  if (notification.containsKey('message'))
                    Text(notification['message']),
                  SizedBox(height: 10),
                  Icon(notification['icon'], color: notification['iconColor'], size: 40),
                  SizedBox(height: 10),
                  if (notification.containsKey('danger')) ...[
                    Text(notification['location'], style: TextStyle(color: Colors.blue)),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text(notification['danger']),
                    ),
                  ] else ...[
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                      child: Text('Перейти'),
                    ),
                  ],
                  if (notification.containsKey('comment')) ...[
                    SizedBox(height: 10),
                    Text(
                      'Комментарий:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(notification['comment']),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}