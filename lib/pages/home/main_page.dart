import 'dart:async';

import 'package:careme24/blocs/app_bloc.dart';
import 'package:careme24/blocs/dangerous/dangerous_cubti.dart';
import 'package:careme24/blocs/dangerous/dangerous_state.dart';
import 'package:careme24/models/dangerous_models/air_pollution_model.dart';
import 'package:careme24/models/dangerous_models/pressure_wind_model.dart';
import 'package:careme24/models/dangerous_models/weather_forecast_model.dart';
import 'package:careme24/pages/contact_help_info.dart';
import 'package:careme24/pages/notifications/notifications_screen.dart';
import 'package:careme24/router/app_router.dart';
import 'package:careme24/theme/app_decoration.dart';
import 'package:careme24/theme/app_style.dart';
import 'package:careme24/theme/color_constant.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/custom_image_view.dart';
import 'package:careme24/widgets/dangerous_icons/widgets/dangerous_icons_list.dart';
import 'package:careme24/widgets/drawer_widget.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _HomeScreenState();
}

bool isGeolocationEnable = false;
String addres = '';

class _HomeScreenState extends State<MainPage> {
  bool showContactNotif = true;
   late Timer _timer;

  @override
  void initState() {
    AppBloc.dangerousCubit.getLocation();
    super.initState();
     _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      AppBloc.dangerousCubit.fetchData();
    });
  }

   @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(41, 142, 235, 1),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(children: [
          Expanded(
            child: Container(
                height: 34,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorConstant.whiteA700),
                child: Center(
                  child: Row(children: [
                    Image.asset(
                      'assets/images/location_on.png',
                    ),
                    Expanded(
                      child: Text(
                        addres,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Color(0xffB8BBC3),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ]),
                )),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationsScreen()));
            },
            child: Image.asset('assets/images/notification.png')),
        ]),
      ),
      backgroundColor: ColorConstant.whiteA700,
      drawer: Drawer(child: DrawerWidget()),
      body: BlocConsumer<DangerousCubit, DangerousState>(
        listener:(context, state) => {
          if(state is DangerousLoaded){
            setState(() {
              isGeolocationEnable = state.isGeoEnable;
              addres = state.address;
            })
          }
        },
        builder: (context, state){
          if (state is DangerousLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          }else{
            return Stack(
              children: [Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                padding: getPadding(top: 10, bottom: 0),
                decoration: AppDecoration.outlineBlack90026,
                child: DangerousIconsList(
                  icons: state is DangerousLoaded ? state.icons : [],
                  city: state is DangerousLoaded ? state.city :'',
                  isGeoEnable: state is DangerousLoaded ? state.isGeoEnable : false,
                  airQuality: state is DangerousLoaded ? state.airQuality : AirQualityResponse(list: [], haveData: false),
                  weatherForecast: state is DangerousLoaded ? state.weatherForecast : WeatherForecast(currentTemperature: 0, forecast:[], haveData: false),
                  pressureAndWind: state is DangerousLoaded ? state.pressureAndWind : PressureAndWindData(currentPressure: 0, currentWindSpeed: 0, currentWindDirection: 0, pressureList: [], date: [], windDirectionList: [], windSpeedList: [], haveData: false)
                ),
              ),
              SizedBox(height: 24),
              Expanded(
                  flex: 1,
                  child: ListView(children: [
                    Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 0,
                        margin: getMargin(top: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusStyle.roundedBorder10),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadiusStyle.roundedBorder10),
                            child: GestureDetector(
                                onTap: (){
                                  if (isGeolocationEnable) {
                                    if (state is DangerousLoaded && state.myMedCard.haveCard) {
                                      AppBloc.requestCubit.setMedCardID(state.myMedCard.id);
                                      Navigator.pushNamed(context,AppRouter.careMeScreen);
                                    }else{
                                      ElegantNotification.error(
                                        description: Text('У вас нет мед. карты')
                                      ).show(context);
                                    }
                                  } else {
                                    AppBloc.dangerousCubit.getLocation();
                                  }
                                },
                                child: Container(
                                    margin: getMargin(
                                        left: 20, top: 10, right: 20, bottom: 10),
                                    decoration: isGeolocationEnable
                                        ? AppDecoration.fillcyan300.copyWith(
                                            borderRadius:
                                                BorderRadiusStyle.roundedBorder10)
                                        : AppDecoration.fillgrey.copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder10),
                                    child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: CustomImageView(
                                                color: isGeolocationEnable
                                                    ? null
                                                    : ColorConstant.gray1001,
                                                svgPath: ImageConstant.imgCamera,
                                                margin: getMargin(
                                                  right: 15,
                                                  bottom: 0,
                                                  top: 60,
                                                )),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Column(children: [
                                              Text("CareMe 24",
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtMontserratF28W800),
                                              Text("Экстренное оповещение",
                                                  maxLines: null,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtMontserratBold20)
                                            ]),
                                          ),
                                        ]))))),
                    Padding(
                        padding: getPadding(left: 20, right: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 3.5,
                                  width:
                                      MediaQuery.of(context).size.width / 2 - 30,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: GestureDetector(
                                                onTap: () {
                                                  if (isGeolocationEnable) {
                                                    if (state is DangerousLoaded && state.myMedCard.haveCard) {
                                                      AppBloc.requestCubit.setMedCardID(state.myMedCard.id);
                                                      Navigator.pushNamed(context, AppRouter.policeCall);
                                                    }else{
                                                      ElegantNotification.error(
                                                        description: Text('У вас нет мед. карты')
                                                      ).show(context);
                                                    }
                                                    
                                                  } else {
                                                    AppBloc.dangerousCubit
                                                        .getLocation();
                                                  }
                                                },
                                                child: Container(
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: isGeolocationEnable
                                                        ? AppDecoration
                                                            .fillIndigoA100
                                                            .copyWith(
                                                                borderRadius:
                                                                    BorderRadiusStyle
                                                                        .roundedBorder10)
                                                        : AppDecoration.fillgrey
                                                            .copyWith(
                                                                borderRadius:
                                                                    BorderRadiusStyle
                                                                        .roundedBorder10),
                                                    child: Stack(children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: CustomImageView(
                                                            color:
                                                                isGeolocationEnable
                                                                    ? null
                                                                    : ColorConstant
                                                                        .gray1001,
                                                            height: (MediaQuery.of(
                                                                                context)
                                                                            .size
                                                                            .height /
                                                                        4) /
                                                                    2 -
                                                                20,
                                                            svgPath: ImageConstant
                                                                .imgFrameHalf,
                                                          )),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                                padding:
                                                                    getPadding(
                                                                  left: 15,
                                                                ),
                                                                child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                          "Охрана\nправопорядка",
                                                                          softWrap:
                                                                              true,
                                                                          textAlign:
                                                                              TextAlign
                                                                                  .left,
                                                                          style: AppStyle
                                                                              .txtMontserratSemiBold15),
                                                                      Container(
                                                                          margin: getMargin(
                                                                              top:
                                                                                  4),
                                                                          child: Text(
                                                                              "Совершается\nпреступление ",
                                                                              maxLines:
                                                                                  null,
                                                                              textAlign:
                                                                                  TextAlign.left,
                                                                              style: AppStyle.txtMontserratMedium12WhiteA700))
                                                                    ])),
                                                          ]),
                                                    ])))),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: GestureDetector(
                                                onTap: () {
                                                if (isGeolocationEnable) {
                                                  if (state is DangerousLoaded && state.myMedCard.haveCard) {
                                                      AppBloc.requestCubit.setMedCardID(state.myMedCard.id);
                                                      Navigator.pushNamed(context, AppRouter.rescueCall);
                                                      }else{
                                                        ElegantNotification.error(
                                                          description: Text('У вас нет мед. карты')
                                                        ).show(context);
                                                      }
                                              }else{
                                                AppBloc.dangerousCubit.fetchData();
                                              }
                                            }, 
                                                child: Container(
                                                    decoration: isGeolocationEnable
                                                        ? AppDecoration
                                                            .fillYellow700
                                                            .copyWith(
                                                                borderRadius:
                                                                    BorderRadiusStyle
                                                                        .roundedBorder10)
                                                        : AppDecoration.fillgrey
                                                            .copyWith(
                                                                borderRadius:
                                                                    BorderRadiusStyle
                                                                        .roundedBorder10),
                                                    child: Stack(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: CustomImageView(
                                                            color:
                                                                isGeolocationEnable
                                                                    ? null
                                                                    : ColorConstant
                                                                        .gray1001,
                                                            margin: getMargin(
                                                                right: 3,
                                                                bottom: 3),
                                                            height: (MediaQuery.of(
                                                                                context)
                                                                            .size
                                                                            .height /
                                                                        4) /
                                                                    2 -
                                                                5,
                                                            svgPath: ImageConstant
                                                                .imgFire,
                                                          ),
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                  padding:
                                                                      getPadding(
                                                                    left: 15,
                                                                  ),
                                                                  child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width /
                                                                                  3,
                                                                          child: Text(
                                                                              "Служба спасения",
                                                                              maxLines:
                                                                                  null,
                                                                              textAlign:
                                                                                  TextAlign.left,
                                                                              style: AppStyle.txtMontserratSemiBold15),
                                                                        ),
                                                                        Container(
                                                                            width: MediaQuery.of(context).size.width /
                                                                                5,
                                                                            margin: getMargin(
                                                                                top:
                                                                                    4),
                                                                            child: Text(
                                                                                "Стихийное бедствие",
                                                                                maxLines: null,
                                                                                textAlign: TextAlign.left,
                                                                                style: AppStyle.txtMontserratMedium12WhiteA700))
                                                                      ])),
                                                            ]),
                                                      ],
                                                    ))))
                                      ])),
                              GestureDetector(
                                  onTap: () {
                                    if (isGeolocationEnable) {
                                       if (state is DangerousLoaded && state.myMedCard.haveCard) {
                                        AppBloc.requestCubit.setMedCardID(state.myMedCard.id);
                                          Navigator.pushNamed(context, AppRouter.medicCall);
                                        }else{
                                          ElegantNotification.error(
                                            description: Text('У вас нет мед. карты')
                                          ).show(context);
                                        }
                                    } else {
                                      AppBloc.dangerousCubit.getLocation();
                                    }
                                  },
                                  child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 0,
                                      margin: getMargin(left: 10),
                                      color: ColorConstant.pink300,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadiusStyle.roundedBorder10),
                                      child: Container(
                                          height:
                                              MediaQuery.of(context).size.height /
                                                  3.5,
                                          width:
                                              MediaQuery.of(context).size.width /
                                                      2 -
                                                  30,
                                          decoration: isGeolocationEnable
                                              ? AppDecoration.fillPink300
                                                  .copyWith(
                                                      borderRadius:
                                                          BorderRadiusStyle
                                                              .roundedBorder10)
                                              : AppDecoration.fillgrey.copyWith(
                                                  borderRadius: BorderRadiusStyle
                                                      .roundedBorder10),
                                          child: Stack(
                                              alignment: Alignment.centerRight,
                                              children: [
                                                CustomImageView(
                                                    color: isGeolocationEnable
                                                        ? null
                                                        : ColorConstant.gray1001,
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        3,
                                                    imagePath: ImageConstant
                                                        .imgGroup7335,
                                                    alignment:
                                                        Alignment.bottomRight),
                                                Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Padding(
                                                        padding: getPadding(
                                                            left: 14, top: 14),
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  "Медицинская помощь ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: AppStyle
                                                                      .txtMontserratSemiBold15),
                                                              Container(
                                                                  width:
                                                                      getHorizontalSize(
                                                                          94),
                                                                  margin:
                                                                      getMargin(
                                                                          top: 3),
                                                                  child: Text(
                                                                      "Экстренный вызов",
                                                                      maxLines:
                                                                          null,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: AppStyle
                                                                          .txtMontserratMedium12WhiteA700))
                                                            ]))),
                                              ]))))
                            ])),
                  ]))
                        ]),
                if(state is DangerousLoaded && state.showcontactNotif && showContactNotif)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(right: 20, left: 20, bottom: 24),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(120, 120, 120, 0.24),
                          blurRadius: 13
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showContactNotif = false;
                              });
                            },
                            child: const Icon(Icons.close),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Вам пришел запрос на\nдобавление из контактов',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              showContactNotif = false;
                            });
                            Navigator.pushNamed(context, AppRouter.calls);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 9),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(65, 73, 255, 1),
                                  Color.fromRGBO(41, 142, 235, 1),
                                ] 
                              ),
                            ),
                            child: Center(
                              child: const Text(
                              'Перейти',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),  
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ),
                if(state is DangerousLoaded)
                  for (var request in state.requests)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(120, 120, 120, 0.24),
                            blurRadius: 13
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  state.requests.remove(request);
                                });
                              },
                              child: const Icon(Icons.close),
                            ),
                          ),
                          Text(
                            request.fullName,
                            style: TextStyle(
                              color: Color.fromRGBO(44, 62, 79, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${request.phone}',
                            style: TextStyle(
                              color: Color.fromRGBO(51, 132, 226, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 26),
                          Text(
                            'Был осуществлен вызов',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20,),
                          SvgPicture.asset('assets/icons/${request.type}.svg'),
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ContactHelpInfo(request: request)));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 9),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(41, 142, 235, 1),
                                    Color.fromRGBO(65, 73, 255, 1)
                                  ] 
                                ),
                              ),
                              child: Center(
                                child: const Text(
                                'Перейти',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),  
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
            ]);
          }
        },
      ),
    );
  }
}
/*  */

/* /*         showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context, 
          builder: (context) {
            return 
          },
        );  */
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context, 
          builder: (context) {
            return 
          },
        );
      } */
