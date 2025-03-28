import 'package:careme24/pages/notifications/notfi_state.dart';
import 'package:careme24/pages/notifications/notifi_cubit.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NotificationsScreen extends StatefulWidget {
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationsCubit>().fetchNotifications(
      lastActiveIcons: ['icon1', 'icon2'],
    );
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
              margin: getMargin(left: 15, right: 15, top: 15, bottom: 15),
              onTap: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
          title: AppbarTitle(text: "Уведомления"),
          styleType: Style.bgFillBlue60001),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NotificationsLoaded) {
            final notifications = state.notifications as List;
            return ListView(
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
                        Icon(Icons.notifications, color: Colors.blue, size: 40),
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
            );
          } else if (state is NotificationsError) {
            return Center(child: Text('Ошибка: ${state.message}'));
          }
          return Center(child: Text('Нет уведомлений'));
        },
      ),
    );
  }
}
