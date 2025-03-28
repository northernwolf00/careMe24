import 'package:careme24/blocs/app_bloc.dart';
import 'package:careme24/models/service_model.dart';
import 'package:careme24/service/url_service.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/app_bar/custom_app_bar.dart';
import 'package:careme24/widgets/custom_image_view.dart';
import 'package:careme24/widgets/file_piceker.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorCallScreen extends StatelessWidget {
  const DoctorCallScreen({
    super.key,
    required this.reason,
    required this.serviceModel,
    required this.cardId
  });

  final String reason;
  final ServiceModel serviceModel;
  final String cardId;

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
          }
        ),
        centerTitle: true,
        title: AppbarTitle(text: 'Вызов'),
        styleType: Style.bgFillBlue60001
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 32, left: 23, right: 23),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Color.fromRGBO(0, 0, 0, 0.24)
                )
              ]
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 67,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30)),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomImageView(
                            url: serviceModel.photo,
                            height: 80,
                            width: 67,
                            radius: BorderRadius.only(bottomRight: Radius.circular(30)),
                            fit: BoxFit.cover
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(serviceModel.name, style: TextStyle(color: Color.fromRGBO(51, 132, 226, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                          Text(serviceModel.workPlace, style: TextStyle(color: Color.fromRGBO(142, 150, 155, 1), fontSize: 12, fontWeight: FontWeight.w500),)
                        ],
                      )
                    )
                  ],
                ),
                Divider(
                  color: Color.fromRGBO(221, 222, 226, 1),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14, top: 15),
                  child: Row(
                    children: [
                      Text('', style: TextStyle(color: Color.fromRGBO(44, 62, 79, 1), fontSize: 16, fontWeight: FontWeight.w500),),
                      Text('', style: TextStyle(color: Color.fromRGBO(44, 62, 79, 1), fontSize: 16, fontWeight: FontWeight.w500),)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14, bottom: 14, top: 15),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 3),
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Color.fromRGBO(95, 178, 255, 1))
                        ),
                      ),
                      Text('Оставить по умолчанию',style: TextStyle(color: Color.fromRGBO(95, 178, 255, 1), fontSize: 10, fontWeight: FontWeight.w500),)
                    ],
                ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              _launchURL(serviceModel.license);
            },
            child: Container(
              margin: EdgeInsets.only(left: 21, right: 25, top: 23),
              padding: EdgeInsets.all(17),
              width: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(41, 142, 235, 1),),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Лицензия', style: TextStyle(color: Color.fromRGBO(41, 142, 235, 1), fontSize: 18, fontWeight: FontWeight.w500)
                    ),
                  SvgPicture.asset('assets/icons/doc.svg')
                  ]
                ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 21, right: 25, top: 23),
            padding: EdgeInsets.all(17),
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(41, 142, 235, 1),),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Стаж работ', style: TextStyle(color: Color.fromRGBO(41, 142, 235, 1), fontSize: 18, fontWeight: FontWeight.w500)
                  ),
                Text(
                  getYearsWord(serviceModel.experience.toInt()), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)
                  ),
                ]
              ),
          ),
          GestureDetector(
            onTap: (){
              _launchURL(serviceModel.diplomas[0]);
            },
            child: Container(
              margin: EdgeInsets.only(left: 21, right: 25, top: 23),
              padding: EdgeInsets.all(17),
              width: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(41, 142, 235, 1),),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Дипломы/курсы/практики ', style: TextStyle(color: Color.fromRGBO(41, 142, 235, 1), fontSize: 18, fontWeight: FontWeight.w500)
                    ),
                  SvgPicture.asset('assets/icons/doc.svg')
                  ]
                ),
            ),
          ),
          GestureDetector(
            onTap: ()async{
              if (cardId != '') {
                final response = await AppBloc.requestCubit.createCall(reason, serviceModel.id, cardId);
              if (response.isSuccess) {
                ElegantNotification.success(
                  description: Text('Вызов успешно создан')
                ).show(context);
              }else{
                ElegantNotification.error(
                  description: Text('Неудалось сделать вызов')
                ).show(context);
              }
              }else{
                ElegantNotification.error(
                    description: Text('У вас нет мед карты')
                  ).show(context);
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 21, right: 25, top: 95),
              padding: EdgeInsets.symmetric(vertical: 19.5),
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(41, 142, 235, 1),
                    Color.fromRGBO(65, 73, 255, 1),
                  ]
                )
              ),
              child: Center(child: Text('Вызвать', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600))),
            ),
          )
        ],
      ),
    );
  }
}
 String getYearsWord(int years) {
  if (years % 10 == 1 && years % 100 != 11) {
    return '$years год';  // 1 год
  } else if ((years % 10 >= 2 && years % 10 <= 4) && (years % 100 < 10 || years % 100 >= 20)) {
    return '$years года';  // 2-4 года
  } else {
    return '$years лет';  // 5 и более лет
  }
}