import 'dart:developer';
import 'dart:io';

import 'package:careme24/blocs/app_bloc.dart';
import 'package:careme24/router/app_router.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/app_bar/custom_app_bar.dart';
import 'package:dio/dio.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class MainCallPage extends StatefulWidget {
  const MainCallPage({
    super.key,
    required this.text,
    required this.requestId,
    required this.show,
    required this.type
  });

  final String text;
  final String requestId;
  final bool show;
  final String type;

  @override
  State<MainCallPage> createState() => _MainCallPageState();
}
bool show = false;
bool sos = false;



final ImagePicker _imagePicker = ImagePicker();
File? videoFile;

class _MainCallPageState extends State<MainCallPage> {

  Future uploadVideo() async {
    try {
      final pickedFile = await _imagePicker.pickVideo(source: ImageSource.camera);
      if (pickedFile == null) {
        return;
      }
      videoFile = File(pickedFile.path);
      
    } catch (e) {
      log('Ошибка при выборе видео: $e');
    }
  }

  @override
  void initState() {
    show = widget.show;
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
            margin: getMargin(left: 32, top: 12, bottom: 20),
            onTap: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        title: AppbarTitle(text: widget.text),
        styleType: Style.bgFillBlue60001
      ),
      body: Column(
        children: [
          if(show)
          Padding(
            padding: EdgeInsets.only(top: 10, left: 24, right: 24),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/info.svg'),
                  SizedBox(width: 12,),
                  Text('Родственники оповещены', style: TextStyle(color: Color.fromRGBO(44, 62, 79, 1), fontSize: 15, fontWeight: FontWeight.w500)),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        show = false;
                      });
                    },
                    child: SvgPicture.asset('assets/icons/close.svg')),
              ],
              ),
            ),
          ),
          SizedBox(height: 11),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(getText(widget.type),style: TextStyle(color: Color.fromRGBO(51, 132, 226, 1), fontSize: 15, fontWeight: FontWeight.w600),),
                ),
                Divider(
                  height: 1,
                  color: Color.fromRGBO(221, 222, 226, 1),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text('Время ожидания 10 минут',style: TextStyle(color: Color.fromRGBO(44, 62, 79, 1), fontSize: 15, fontWeight: FontWeight.w600),),
                ),
                GestureDetector(
                  onTap: ()async{
                      log('erro');
                      final response = await AppBloc.requestCubit.updateRequest(
                        widget.requestId,
                        {
                          "important" : !sos,
                          "creation_date_user": DateTime.now(),
                        } 
                      );
                      if (response.isSuccess) {
                        setState(() {
                          sos = !sos;
                        });
                      }
                  },
                  child: SvgPicture.asset(
                    sos
                    ? 'assets/icons/sos_on.svg'
                    : 'assets/icons/sos_off.svg'
                  )
                ),
                SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.only(bottom: 33,),
                  child: Text('Нажмите для срочной помощи\nподготовленных людей',style: TextStyle(color: Color.fromRGBO(219, 19, 91, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                ),
                Divider(
                  height: 1,
                  color: Color.fromRGBO(221, 222, 226, 1),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: GestureDetector(
                    onTap: ()async{
                      final response = await AppBloc.requestCubit.deleteRequest(widget.requestId);
                      if (response.isSuccess) {
                        ElegantNotification.success(
                          description: Text('Заявка отменена')
                        ).show(context);
                        Navigator.pushReplacementNamed(context, AppRouter.appContainer);
                        
                      }else{
                        
                      }
                    },
                    child: Text('Отмена вызова',style: TextStyle(color: Color.fromRGBO(179, 184, 188, 1), fontSize: 15, fontWeight: FontWeight.w600),)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 50, left: 50, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/taxi.svg',
                    ),
                    SizedBox(height: 5),
                    Text('Такси',style: TextStyle(color: Color.fromRGBO(142, 150, 155, 1), fontSize: 12, fontWeight: FontWeight.w500),)
                  ],
                ),
                GestureDetector(
                  onTap: ()async{
                    await uploadVideo();
                    if (videoFile != null) {
                      final response = await AppBloc.requestCubit.updateRequest(
                        widget.requestId,
                        {
                          "video" : await MultipartFile.fromFile(videoFile!.path),
                          "creation_date_user": DateTime.now(),
                        } 
                      );
                      if (response.isSuccess) {
                        ElegantNotification.success(
                          description: Text('Видео отправлено на сервер')
                        ).show(context);
                      }else{
                      ElegantNotification.error(
                          description: Text('неудалось отправить видео на сервер')
                        ).show(context);
                      }
                    }
                  },
                  child:  Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/video.svg',
                      ),
                      SizedBox(height: 5),
                      Text('Видео',style: TextStyle(color: Color.fromRGBO(142, 150, 155, 1), fontSize: 12, fontWeight: FontWeight.w500),)
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
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            padding: EdgeInsets.symmetric(vertical: 20,),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(255, 168, 0, 1),
                  Color.fromRGBO(255, 213, 89, 1),
                ]
              )
            ),
            child: Center(
              child: Text('Что делать', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
            ),
          )
        ],
      ),
    );
  }

  String getText(String service){
    switch (service) {
      case 'med':
        return 'Скорая помощь вызвана';
      case 'pol':
        return 'Полиция вызвана';
      case 'mch':
        return 'МЧС вызвана';
      default:
        return 'Неизвестная служба';
    }
  }

}

