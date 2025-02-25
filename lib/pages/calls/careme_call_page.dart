import 'dart:developer';
import 'dart:io';
import 'package:careme24/blocs/app_bloc.dart';
import 'package:careme24/pages/calls/careme_reason_page.dart';
import 'package:careme24/router/app_router.dart';
import 'package:careme24/service/url_service.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sensors_plus/sensors_plus.dart';

class CaremeCallPage extends StatefulWidget {
  const CaremeCallPage({super.key});

  @override
  State<CaremeCallPage> createState() => _CaremeCallPageState();
}

bool isCall = false;
bool isSos = false;
bool isSend = false;

final ImagePicker _imagePicker = ImagePicker();
File? videoFile;
int? selectedResoneIndex;
String? selectedResone;
String id = '';


class _CaremeCallPageState extends State<CaremeCallPage> {
  double shakeThreshold = 10.0;
  
  @override
  void initState() {
    _initializeShakeListener();
    super.initState();
  }

  void _initializeShakeListener() {
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      double acceleration = event.x.abs() + event.y.abs() + event.z.abs();
      if (acceleration > shakeThreshold) {
        setState(() {
          isCall = true;
        });
      }
    });
  }
  void uploadVideo() async {
    try {
      final pickedFile = await _imagePicker.pickVideo(source: ImageSource.camera);
      if (pickedFile == null) {
        return;
      }
      setState(() {
          videoFile = File(pickedFile.path);
      });      
    } catch (e) {
      log('Ошибка при выборе видео: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(25, 154, 139, 1),
    ));

    return !isCall
    ? Material(
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/icons/careme24.svg',
            fit: BoxFit.cover,
            width: double.maxFinite,
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.17),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    height: 60,
                  'assets/icons/red_phone.png',
                  ),
                  Text('Встряхните телефон!',style: TextStyle(color: Colors.red, fontSize: 22, fontWeight: FontWeight.w700),),
                ],
              ),
            )),
        ],
      ),
    )
    : WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(67, 211, 194, 1),
        body: !isCall
            ?  null
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                        onTap: (){
                          UrlService.launchPhoneDialer('112');
                        },
                        child: Row(
                          children: [
                            SizedBox(width: 17),
                            SvgPicture.asset('assets/icons/r_phone.svg'),
                            SizedBox(width: 56),
                            Text(
                            'Вызов 112',
                            style: TextStyle(
                              color: Color.fromRGBO(235, 50, 35, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                  ),
                  SizedBox(height: 20),
                  Divider(color: Colors.white),
                  Expanded(
                    child: GestureDetector(
                    onTap: (){
                      uploadVideo();
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 17),
                        SvgPicture.asset(
                          'assets/icons/bcamera.svg',
                          color: Color.fromRGBO(15, 159, 142, 1),
                        ),
                        SizedBox(width: 40,),
                        Center(
                          child: Text(
                          'Записать видео',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          ),
                        ),
                        Spacer(),
                        if(videoFile != null)
                          Align(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              'assets/icons/selected.png',
                            ),
                          )
                      ],
                    ),
                  ),
                  ),
                  Divider(color: Colors.white),
                  Expanded(
                    child: GestureDetector(
                    onTap: ()async{
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CaremeReasonPage(important: isSos, selectedReasonIndex: selectedResoneIndex,)))
                        .then((response){
                          setState(() {
                            selectedResoneIndex = response[0];
                            selectedResone = response[1];
                            isSos = !response[2];
                          });
                        });
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              'Выберите причину ',
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        if(selectedResone != null)
                          Align(
                            alignment: Alignment.topRight,
                            child: Image.asset(
                            'assets/icons/selected.png',
                          ),
                        )
                      ],
                    ),
                  ),
                  ),
                  Divider(color: Colors.white),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                    onTap: ()async{
                      setState(() {
                        isSos = !isSos;
                      });
                    },
                    child:  SvgPicture.asset(
                      isSos ? 'assets/icons/sos_on.svg' : 'assets/icons/sos_off.svg',
                    ),
                  ),
                  SizedBox(height: 50,),
                  GestureDetector(
                    onTap: ()async{
                      final response = await AppBloc.requestCubit.createRequest112(selectedResone!,videoFile!);
                      if (response.isSuccess) {
                        ElegantNotification.success(
                          description: Text('Заявка отправлена')
                        ).show(context);
                        setState(() {
                          id = response.requestId;
                          isSend = true;
                        });
                      }else{
                        ElegantNotification.error(
                          description: Text('Неудалось отправить заявку')
                        ).show(context);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      padding: EdgeInsets.symmetric(vertical: 9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isSend ?null : Color.fromRGBO(142, 150, 155, 1),
                        gradient: LinearGradient(
                          colors: !isSend
                              ? [
                                  Color.fromRGBO(65, 73, 255, 1),
                                  Color.fromRGBO(41, 142, 235, 1),
                                ]
                              : [],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Отправить',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 26),
                  GestureDetector(
                    onTap: ()async{
                      if (isSend) {
                        final response = await AppBloc.requestCubit.deleteRequest112(id);
                        if (response.isSuccess) {
                          ElegantNotification.success(
                            description: Text('Заявка отменена')
                          ).show(context);
                          Navigator.pushReplacementNamed(context, AppRouter.appContainer);
                          setState(() {
                            isSend = false;
                          });
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      padding: EdgeInsets.symmetric(vertical: 9),
                      decoration: BoxDecoration(
                        color: isSend ? null : Color.fromRGBO(142, 150, 155, 1),
                        borderRadius: BorderRadius.circular(10),
                        gradient: isSend 
                          ? LinearGradient(
                          colors: [
                            Color.fromRGBO(255, 89, 99, 1),
                            Color.fromRGBO(224, 14, 102, 1),
                          ],
                        ) : null,
                      ),
                      child: Center(
                        child: Text(
                          'Отменить',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                      ],
                    )
                  ),
                ],
              ),
      ),
    );
  }

  String getCodeByText(String text) {
    if (text == '0') {
      return 'pol';
    } else if (text == '1') {
      return 'mch'; 
    } else if (text == '2') {
      return 'med'; 
    } else {
      return 'unknown';  
    }
  }

  Future<bool> _onWillPop() async {
      setState(() {
        isCall = !isCall;
      });
      return true;
    }
  }

