import 'package:careme24/models/service_model.dart';
import 'package:careme24/theme/theme.dart';
import 'package:careme24/utils/utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/app_bar/custom_app_bar.dart';
import 'package:careme24/widgets/custom_image_view.dart';
import 'package:careme24/widgets/doctor_card.dart';
import 'package:careme24/widgets/for_whom.dart';
import 'package:careme24/widgets/mes_card.dart';
import 'package:careme24/widgets/paid_service_swither.dart';
import 'package:careme24/widgets/police_card.dart';
import 'package:flutter/material.dart';

class CallMESScreen extends StatefulWidget {
  final String appbartitle;
  final String type;

  const CallMESScreen(
    this.appbartitle, 
    this.type,
    {super.key});

  @override
  State<CallMESScreen> createState() => _CallMESScreenState();
}

class _CallMESScreenState extends State<CallMESScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controllertimestart = TextEditingController();
  final TextEditingController _controllertimeend = TextEditingController();
  final TextEditingController _controllerestimationstart = TextEditingController();
  final TextEditingController _controllerestimationend = TextEditingController();
  final TextEditingController _controllercoststart = TextEditingController();
  final TextEditingController _controllercostend = TextEditingController();
  final TextEditingController _controllerdistancestart = TextEditingController();
  final TextEditingController _controllerdistanceend = TextEditingController();

  bool isEmptyFiltres() {
    if (_controllertimestart.text.isNotEmpty &&
        _controllertimeend.text.isNotEmpty) {
      return true;
    } else if (_controllerestimationstart.text.isNotEmpty &&
        _controllerestimationend.text.isNotEmpty) {
      return true;
    } else if (_controllercoststart.text.isNotEmpty &&
        _controllercostend.text.isNotEmpty) {
      return true;
    } else if (_controllerdistancestart.text.isNotEmpty &&
        _controllerdistanceend.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool _wait = true;
  bool _finish = false;
  bool _undo = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: ColorConstant.whiteA700,
            endDrawer: Drawer(
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 100,
                    padding: getPadding(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Фильтры',
                          style: AppStyle.txtMontserratBold20Blue600,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CustomImageView(
                            svgPath: ImageConstant.imgArrowright,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: getPadding(left: 24, right: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: getPadding(bottom: 12),
                          child: Text(
                            "Время",
                            style: AppStyle.txtMontserratSemiBold17,
                          ),
                        ),
                        Padding(
                          padding: getPadding(bottom: 12),
                          child: TextField(
                            controller: _controllertimestart,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: 'От',
                            ),
                          ),
                        ),
                        TextField(
                          controller: _controllertimeend,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'До',
                          ),
                        ),
                        Padding(
                          padding: getPadding(bottom: 12, top: 24),
                          child: Text(
                            "Оценка",
                            style: AppStyle.txtMontserratSemiBold17,
                          ),
                        ),
                        Padding(
                          padding: getPadding(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 90,
                                child: TextField(
                                  controller: _controllerestimationstart,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    labelText: 'От',
                                  ),
                                ),
                              ),
                              Container(
                                width: 24,
                                height: 2,
                                color: ColorConstant.gray500,
                              ),
                              SizedBox(
                                width: 90,
                                child: TextField(
                                  controller: _controllerestimationend,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    labelText: 'До',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: getPadding(bottom: 12, top: 24),
                          child: Text(
                            "Стоимость",
                            style: AppStyle.txtMontserratSemiBold17,
                          ),
                        ),
                        Padding(
                          padding: getPadding(bottom: 12),
                          child: TextField(
                            controller: _controllercoststart,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: 'От',
                            ),
                          ),
                        ),
                        TextField(
                          controller: _controllercostend,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'До',
                          ),
                        ),
                        Padding(
                          padding: getPadding(bottom: 12, top: 24),
                          child: Text(
                            "Расстояние",
                            style: AppStyle.txtMontserratSemiBold17,
                          ),
                        ),
                        Padding(
                          padding: getPadding(bottom: 12),
                          child: TextField(
                            controller: _controllerdistancestart,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: 'От',
                            ),
                          ),
                        ),
                        TextField(
                          controller: _controllerdistanceend,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'До',
                          ),
                        ),
                        Container(
                          margin: getMargin(top: 24, bottom: 24),
                          width: MediaQuery.of(context).size.width - 40,
                          height: 56,
                          decoration: BoxDecoration(
                              gradient: isEmptyFiltres() ? LinearGradient(
                                colors: [
                                  ColorConstant.indigoA400,
                                  ColorConstant.bluegradient,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ) : LinearGradient(
                                colors: [
                                  ColorConstant.gray500,
                                  ColorConstant.gray500,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                                "Отменить",
                                style: AppStyle.txtMontserratSemiBold18WhiteA700,
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                title: AppbarTitle(text: widget.appbartitle),
                actions: [
                  Builder(builder: (context) {
                    return AppbarImage(
                        onTap: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        height: getSize(22),
                        width: getSize(22),
                        svgPath: ImageConstant.imgFilter,
                        margin:
                        getMargin(left: 26, top: 9, right: 26, bottom: 17));
                  })
                ],
                styleType: Style.bgFillBlue60001),
            body: SizedBox(
                width: size.width,
                child: SingleChildScrollView(
                    padding: getPadding(top: 20),
                    child: Padding(
                        padding: getPadding(left: 20, right: 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: getPadding(left: 2),
                                  child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        ForWhom(name: 'Степанов Илья',),
                                        const PaySwitcher(),
                                      ])),
                              Padding(
                                padding: getPadding(top: 14),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromRGBO(178, 218, 255, 100),
                                  ),
                                  width: MediaQuery.of(context).size.width - 40,
                                  height: 80,
                                  child: Padding(
                                    padding: getPadding(left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                              'Проблема',
                                              style: AppStyle.txtMontserratSemiBold19,
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                        CustomImageView(
                                          svgPath:
                                          ImageConstant.imgArrowdownLightBlue900,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: getPadding(top: 18),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            _finish = false;
                                            _undo = false;
                                            _wait = true;
                                            setState(() {});
                                          },
                                          child: Container(
                                              width: getHorizontalSize(109),
                                              padding: getPadding(
                                                  left: 9,
                                                  top: 10,
                                                  right: 9,
                                                  bottom: 10),
                                              decoration: _wait
                                                  ? AppDecoration
                                                  .txtFillBlue30001
                                                  .copyWith(
                                                  borderRadius:
                                                  BorderRadiusStyle
                                                      .txtCustomBorderTL10)
                                                  : BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: ColorConstant
                                                          .gray50002,
                                                      width: 1),
                                                ),
                                              ),
                                              child: Text("Путь",
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: _wait
                                                      ? AppStyle
                                                      .txtMontserratSemiBold15
                                                      : TextStyle(
                                                    color: ColorConstant
                                                        .black900,
                                                    fontSize: getFontSize(
                                                      15,
                                                    ),
                                                    fontFamily:
                                                    'Montserrat',
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  )))),
                                      GestureDetector(
                                          onTap: () {
                                            _finish = true;
                                            _undo = false;
                                            _wait = false;
                                            setState(() {});
                                          },
                                          child: Container(
                                              width: getHorizontalSize(109),
                                              padding: getPadding(
                                                  left: 9,
                                                  top: 10,
                                                  right: 9,
                                                  bottom: 10),
                                              // decoration:  AppDecoration.outlineGray50001,
                                              decoration: _finish
                                                  ? AppDecoration
                                                  .txtFillBlue30001
                                                  .copyWith(
                                                  borderRadius:
                                                  BorderRadiusStyle
                                                      .txtCustomBorderTL10)
                                                  : BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: ColorConstant
                                                          .gray50002,
                                                      width: 1),
                                                ),
                                              ),
                                              child: Text("Оценка",
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: _finish
                                                      ? AppStyle
                                                      .txtMontserratSemiBold15
                                                      : TextStyle(
                                                    color: ColorConstant
                                                        .black900,
                                                    fontSize: getFontSize(
                                                      15,
                                                    ),
                                                    fontFamily:
                                                    'Montserrat',
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  )))),
                                      GestureDetector(
                                          onTap: () {
                                            _finish = false;
                                            _undo = true;
                                            _wait = false;
                                            setState(() {});
                                          },
                                          child: Container(
                                              decoration: _undo
                                                  ? AppDecoration
                                                  .txtFillBlue30001
                                                  .copyWith(
                                                  borderRadius:
                                                  BorderRadiusStyle
                                                      .txtCustomBorderTL10)
                                                  : BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: ColorConstant
                                                          .gray50002,
                                                      width: 1),
                                                ),
                                              ),
                                              width: getHorizontalSize(109),
                                              padding: getPadding(
                                                  left: 9,
                                                  top: 10,
                                                  right: 9,
                                                  bottom: 10),
                                              child: Text("Стоимость",
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: _undo
                                                      ? AppStyle
                                                      .txtMontserratSemiBold15
                                                      : TextStyle(
                                                    color: ColorConstant
                                                        .black900,
                                                    fontSize: getFontSize(
                                                      15,
                                                    ),
                                                    fontFamily:
                                                    'Montserrat',
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  )))),
                                    ]),
                              ),
                              Padding(
                                  padding: getPadding(left: 2, top: 18),
                                  child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        if (widget.type == 'mch')
                                          ...List.generate(9, (index) {
                                            return MESCard(
                                              medCardId: '',
                                              mes_image: ImageConstant.doctorImage,
                                              mes_name: "Пожарная Часть N 1 Гпс МЧС",
                                              mes_qualification: "Участковый врач",
                                              cost: "1500 ₽",
                                              meters: "1200 м",
                                              minute: "9 мин",
                                              estimation: "4.8",
                                              where_call: widget.appbartitle,
                                              reason: 'd', 
                                              serviceModel: ServiceModel(
                                                id: '', 
                                                type: '', 
                                                verified: false, 
                                                price: 0, 
                                                name: '', 
                                                specialization: '', 
                                                experience: 0, 
                                                diplomas: [], 
                                                reviews: [], 
                                                workPlace: '', 
                                                goHome: false, 
                                                institutionName: '', 
                                                institutionCommercial: false, 
                                                institutionType: '', 
                                                institutionAge: '', 
                                                license: '', 
                                                photo: '', 
                                                calls: [], 
                                                appointments: [], 
                                                statements: []
                                              ),
                                              work: false,
                                            );
                                          })

                                        else if (widget.type == 'med')
                                          ...List.generate(9, (index) {
                                            return DoctorCard(
                                            cardId: '',
                                            reason: '',
                                            doctor_image: ImageConstant.doctorImage,
                                            doctor_name: '',
                                            doctor_qualification: '',
                                            cost: "1200 ₽",
                                            meters: "1200 м",
                                            minute: "9 мин",
                                            estimation: "4.8",
                                            where_call: widget.appbartitle,
                                            work: false,
                                            serviceModel: ServiceModel(
                                                id: '', 
                                                type: '', 
                                                verified: false, 
                                                price: 0, 
                                                name: '', 
                                                specialization: '', 
                                                experience: 0, 
                                                diplomas: [], 
                                                reviews: [], 
                                                workPlace: '', 
                                                goHome: false, 
                                                institutionName: '', 
                                                institutionCommercial: false, 
                                                institutionType: '', 
                                                institutionAge: '', 
                                                license: '', 
                                                photo: '', 
                                                calls: [], 
                                                appointments: [], 
                                                statements: []
                                              ),
                                          );
                                          })

                                        else if (widget.type == 'pol')
                                          ...List.generate(9, (index) {
                                            return PoliceCard(
                                            medCardId: '',
                                            doctor_image:ImageConstant.doctorImage,
                                            doctor_name: '',
                                            doctor_qualification: 'Врач',
                                            cost: "1500 ₽",
                                            meters: "1200 м",
                                            minute: "9 мин",
                                            estimation: "4.8",
                                            where_call: widget.appbartitle,
                                            reason: '',
                                            work: false,
                                            serviceModel: ServiceModel(
                                                id: '', 
                                                type: '', 
                                                verified: false, 
                                                price: 0, 
                                                name: '', 
                                                specialization: '', 
                                                experience: 0, 
                                                diplomas: [], 
                                                reviews: [], 
                                                workPlace: '', 
                                                goHome: false, 
                                                institutionName: '', 
                                                institutionCommercial: false, 
                                                institutionType: '', 
                                                institutionAge: '', 
                                                license: '', 
                                                photo: '', 
                                                calls: [], 
                                                appointments: [], 
                                                statements: []
                                              ),
                                          );
                                          })
                                      ]
                                )
                              )
                            ]
                          )
                        )
                      )
                    )
                  )
                );
  }
}