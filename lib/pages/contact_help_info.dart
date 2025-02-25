import 'package:careme24/models/request_model.dart';
import 'package:careme24/service/url_service.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';

class ContactHelpInfo extends StatelessWidget {
  const ContactHelpInfo({
    super.key,
    required this.request
  });

  final RequestModel request;

  Future<String> _getAddress(double lat, double lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      String city = placemarks.first.locality ?? '';
      String street = placemarks.first.street ?? '';
      return '$city $street';
    } catch (e) {
      return 'Адрес не найден';
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
          margin: getMargin(left: 32, top: 12, bottom: 20),
          onTap: () {
            Navigator.pop(context);
          }),
        centerTitle: true,
        title: AppbarTitle(text: "Оповещение"),
        styleType: Style.bgFillBlue60001
      ),
      body: FutureBuilder<String>(
        future: _getAddress(request.lat, request.lon), // Запрос геокодирования
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка при получении адреса'));
          } else {
            String address = snapshot.data ?? 'Неизвестный адрес';

            return Column(
              children: [
                SizedBox(height: 20),
                SvgPicture.asset('assets/icons/w.svg'),
                Text('Вашему родственнику\nпонадобилась помощь', style: TextStyle(color: Color.fromRGBO(44, 62, 79, 1), fontSize: 20, fontWeight: FontWeight.w700),),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(120, 120, 120, 0.23),
                        blurRadius: 13
                      )
                    ]
                  ), child: Column(
                    children: [
                      Text(
                            request.fullName,style: TextStyle(color: Color.fromRGBO(44, 62, 79, 1), fontSize: 18, fontWeight: FontWeight.w600)),
                      Divider(
                        color: Color.fromRGBO(221, 222, 226, 1),
                      ),
                      Row(
                        children: [
                          Text('Причина\nвызова:', style: TextStyle(color: Color.fromRGBO(44, 62, 79, 1), fontSize: 12, fontWeight: FontWeight.w500),),
                          SizedBox(width: 8),
                          Spacer(),
                          Expanded(child: Text(request.detail,style: TextStyle(color: Color.fromRGBO(51, 132, 226, 1), fontSize: 15, fontWeight: FontWeight.w600),))
                        ],
                      ),
                      Divider(
                        color: Color.fromRGBO(221, 222, 226, 1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Место\nвызова:', style: TextStyle(color: Color.fromRGBO(44, 62, 79, 1), fontSize: 12, fontWeight: FontWeight.w500),),
                          SizedBox(width: 8),
                          Spacer(),
                          Expanded(child: Text(address, style: TextStyle(color: Color.fromRGBO(51, 132, 226, 1), fontSize: 15, fontWeight: FontWeight.w600),))
                        ],
                      ),
                      Divider(
                        color: Color.fromRGBO(221, 222, 226, 1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Место куда\nповезут:', style: TextStyle(color: Color.fromRGBO(44, 62, 79, 1), fontSize: 12, fontWeight: FontWeight.w500),),
                          Text('Нет данных',style: TextStyle(color: Color.fromRGBO(51, 132, 226, 1), fontSize: 15, fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 50, left: 50, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          UrlService.launchPhoneDialer(request.phone.toString());
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/call1.svg',
                            ),
                            SizedBox(height: 5),
                            Text('Телефон',style: TextStyle(color: Color.fromRGBO(142, 150, 155, 1), fontSize: 12, fontWeight: FontWeight.w500),)
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          UrlService.openWhatsApp(request.phone.toString());
                        },
                        child:  Column(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/cw.svg',
                            ),
                            SizedBox(height: 5),
                            Text('WhatsApp',style: TextStyle(color: Color.fromRGBO(142, 150, 155, 1), fontSize: 12, fontWeight: FontWeight.w500),)
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/map.svg',
                          ),
                          SizedBox(height: 5),
                          Text('Отследить',style: TextStyle(color: Color.fromRGBO(142, 150, 155, 1), fontSize: 12, fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
