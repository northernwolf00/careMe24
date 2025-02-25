import 'package:careme24/theme/theme.dart';
import 'package:careme24/utils/utils.dart';
import 'package:careme24/widgets/custom_icon_button.dart';
import 'package:careme24/widgets/widgets.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
/*
MapController controller = MapController(
  initPosition: GeoPoint(latitude: 59.939099, longitude: 30.315877),
);*/

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  void initState(){
/*
    MapController controller = MapController(
      initPosition: GeoPoint(latitude: 59.939099, longitude: 30.315877),
    );
*/

    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(48),
                leadingWidth: 43,
                leading: AppbarImage(
                    height: getVerticalSize(16),
                    width: getHorizontalSize(11),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 32, top: 12, bottom: 20),
                    onTap: () {
                      onTapArrowleft16(context);
                    }),
                centerTitle: true,
                title: AppbarTitle(text: "Отследить"),
                styleType: Style.bgFillBlue60001),
            body: SizedBox(
                width: size.width,

                    child: SizedBox(
                        height: getVerticalSize(727),
                        width: double.maxFinite,
                        child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                      decoration: AppDecoration
                                          .outlineBlack90011
                                          .copyWith(
                                              ),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: double.maxFinite,
                                                child: Container(
                                                    width: double.maxFinite,
                                                    padding: getPadding(
                                                        left: 20,
                                                        top: 13,
                                                        right: 20,
                                                        bottom: 13),
                                                    decoration: AppDecoration
                                                        .outlineBlack90014
                                                        .copyWith(
                                                            borderRadius:
                                                                BorderRadiusStyle
                                                                    .customBorderBL10),
                                                    child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "Карла маркаса 20/2а",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: AppStyle
                                                                  .txtMontserratMedium15),
                                                          Padding(
                                                              padding:
                                                                  getPadding(
                                                                      left: 2,
                                                                      top: 10,
                                                                      right:
                                                                          52),
                                                              child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Padding(
                                                                        padding: getPadding(
                                                                            top:
                                                                                3),
                                                                        child: Text(
                                                                            "Путь",
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            textAlign: TextAlign.left,
                                                                            style: AppStyle.txtMontserratMedium15Bluegray800)),
                                                                    Padding(
                                                                        padding: getPadding(
                                                                            top:
                                                                                11,
                                                                            bottom:
                                                                                9),
                                                                        child: SizedBox(
                                                                            width: getHorizontalSize(
                                                                                183),
                                                                            child: Divider(
                                                                                height: getVerticalSize(1),
                                                                                thickness: getVerticalSize(1),
                                                                                color: ColorConstant.gray300,
                                                                                indent: getHorizontalSize(6)))),
                                                                    Padding(
                                                                        padding: getPadding(
                                                                            left:
                                                                                6),
                                                                        child: Text(
                                                                            "200 м",
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            textAlign: TextAlign.left,
                                                                            style: AppStyle.txtH1))
                                                                  ])),
                                                          Padding(
                                                              padding:
                                                                  getPadding(
                                                                      left: 2,
                                                                      top: 7,
                                                                      right: 8,
                                                                      bottom:
                                                                          5),
                                                              child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Padding(
                                                                        padding: getPadding(
                                                                            top:
                                                                                3),
                                                                        child: Text(
                                                                            "Время ожидания",
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            textAlign: TextAlign.left,
                                                                            style: AppStyle.txtMontserratMedium15Bluegray800)),
                                                                    Padding(
                                                                        padding: getPadding(
                                                                            top:
                                                                                11,
                                                                            bottom:
                                                                                9),
                                                                        child: SizedBox(
                                                                            width: getHorizontalSize(
                                                                                82),
                                                                            child: Divider(
                                                                                height: getVerticalSize(1),
                                                                                thickness: getVerticalSize(1),
                                                                                color: ColorConstant.gray300,
                                                                                indent: getHorizontalSize(7)))),
                                                                    Padding(
                                                                        padding: getPadding(
                                                                            left:
                                                                                6),
                                                                        child: Text(
                                                                            "7 мин 30 с",
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            textAlign: TextAlign.left,
                                                                            style: AppStyle.txtH1))
                                                                  ]))
                                                        ]))),
                                         Expanded( child: Container(

                                          /*  child:  OSMFlutter(
                                              controller: controller,
                                              //markerOption: MarkerOption(defaultMarker: MarkerIcon(icon: ,)),

                                              onMapIsReady: (_ready) async{
                                                controller.addMarker(
                                                  GeoPoint(
                                                      latitude: 59.853845,  longitude: 30.179760),
                                                  markerIcon: MarkerIcon(
                                                      icon: Icon(

                                                        CarCustom.mchs__1_,
                                                        size: 100,

                                                      )),
                                                );
                                                //_route();
                                                RoadInfo roadInfo = await controller.drawRoad(
                                                    GeoPoint(latitude: 59.853845,  longitude: 30.179760),
                                                    GeoPoint(latitude: 59.949474, longitude:  30.264044),
                                                    roadType: RoadType.car,
                                                    //intersectPoint : [ GeoPoint(latitude: 47.4361, longitude: 8.6156), GeoPoint(latitude: 47.4481, longitude: 8.6266)],
                                                    roadOption: RoadOption(
                                                    roadWidth: 10,
                                                    roadColor: Colors.red,

                                                ),
                                                );
                                              }, osmOption: OSMOption(),

                                            ),*/))
                                          ]))),
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                      padding: getPadding(
                                          left: 101,
                                          top: 16,
                                          right: 101,
                                          bottom: 16),
                                      decoration: AppDecoration.fillWhiteA700,
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Связь с бригадой",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style:
                                                    AppStyle.txtUbuntuMedium18),
                                            Padding(
                                                padding: getPadding(
                                                    top: 15, bottom: 23),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                          padding: getPadding(
                                                              top: 20),
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CustomIconButton(
                                                                    height: 58,
                                                                    width: 58,
                                                                    padding:
                                                                        IconButtonPadding
                                                                            .PaddingAll15,
                                                                    child: CustomImageView(
                                                                        svgPath:
                                                                            ImageConstant.imgCall)),
                                                                Padding(
                                                                    padding:
                                                                        getPadding(
                                                                            top:
                                                                                5),
                                                                    child: Text(
                                                                        "Телефон",
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .left,
                                                                        style: AppStyle
                                                                            .txtUbuntuMedium12))
                                                              ])),
                                                      Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Card(
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                elevation: 0,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(0),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadiusStyle
                                                                            .roundedBorder39),
                                                                child:
                                                                    Container(
                                                                        height: getSize(
                                                                            78),
                                                                        width: getSize(
                                                                            78),
                                                                        padding: getPadding(
                                                                            all:
                                                                                24),
                                                                        decoration: AppDecoration
                                                                            .outlineGreen40049
                                                                            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder39),
                                                                        child: Stack(children: [
                                                                          CustomImageView(
                                                                              svgPath: ImageConstant.imgFrame8067,
                                                                              height: getSize(29),
                                                                              width: getSize(29),
                                                                              alignment: Alignment.topCenter)
                                                                        ]))),
                                                            Padding(
                                                                padding:
                                                                    getPadding(
                                                                        top: 5),
                                                                child: Text(
                                                                    "WhatsApp",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: AppStyle
                                                                        .txtUbuntuMedium12))
                                                          ])
                                                    ]))
                                          ])))
                            ])))));
  }

  onTapArrowleft16(BuildContext context) {
    Navigator.pop(context);
  }
}
