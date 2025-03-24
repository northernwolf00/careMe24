import 'package:careme24/blocs/app_bloc.dart';
import 'package:careme24/models/institution_model.dart';
import 'package:careme24/models/medcard/medcard_model.dart';
import 'package:careme24/models/request_status_model.dart';
import 'package:careme24/pages/calls/dialog_select_contact_med.dart';
import 'package:careme24/pages/calls/main_call_page.dart';
import 'package:careme24/pages/calls/select_instituts.dart';
import 'package:careme24/service/pref_service.dart';
import 'package:careme24/theme/app_style.dart';
import 'package:careme24/theme/color_constant.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/app_bar/custom_app_bar.dart';
import 'package:careme24/widgets/custom_image_view.dart';
import 'package:careme24/widgets/for_whom.dart';
import 'package:careme24/widgets/paid_service_swither.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedicalCallButton extends StatefulWidget {
  const MedicalCallButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  State<MedicalCallButton> createState() => _MedicalCallButtonState();
}

class _MedicalCallButtonState extends State<MedicalCallButton> {

  bool on = false;
  bool isNotifContact = false;
  InstitutionModel? institutionModel;

  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setValue();
    });
    super.initState();
  }

  void setValue()async{
    isNotifContact = await PrefService.isNotifContact();
  }
    MedcardModel? _selectedContact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  ColorConstant.gray100,
      resizeToAvoidBottomInset: false,
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
          title: AppbarTitle(text: "Вызвать скорую"),
          styleType: Style.bgFillBlue60001),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: getPadding(left: 24, top: 17, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                                  onTap: () async {
                                    final selectedContact =
                                        await showDialog<MedcardModel>(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ContactSelectDialogMed();
                                      },
                                    );

                                    if (selectedContact != null) {
                                      setState(() {
                                        _selectedContact = selectedContact;
                                      });
                                    }
                                  },
                                  child: ForWhom(
                                    name: _selectedContact
                                            ?.personalInfo.full_name ??
                                        'Мне',
                                  ),
                                ),
               
                  const PaySwitcher(),
                ]
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 14, bottom: 24),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                top: Radius.circular(10)),
                color: Color.fromRGBO(178, 218, 255, 100),
              ),
              width: MediaQuery.of(context).size.width - 40,
              height: 80,
              child: Padding(
                padding: getPadding(left: 20, right: 20, top: 20 ,bottom: 20),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: 
                        Text(
                          overflow: TextOverflow.ellipsis,
                          widget.text,
                          style: AppStyle.txtMontserratSemiBold19,
                        ),
                    ),
                  ],
                ),
              ),
            ),
            
        Container(
          height: MediaQuery.sizeOf(context).height * 0.3,
          margin: EdgeInsets.symmetric(horizontal: 33.5),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), 
                  offset: Offset(0, 0),                 
                  blurRadius: 14.0,                      
                  spreadRadius: 0.0,                   
                ),
              ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                 onTap: ()async{
                  setState(() {
                    on = !on;
                  });
                  if (on){
                    
                    RequestStatusModel resopnse = await AppBloc.requestCubit.createRequest(widget.text, 'med', false, institutionModel?.id ?? '');
                    if (resopnse.isSuccess) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainCallPage(text: 'Вызов скорой', requestId: resopnse.requestId, show: isNotifContact, type: 'med',)));
                    }else{
                      ElegantNotification.error(
                        description: Text('Неудалось вызвать скорой')
                      ).show(context);
                      setState(() {
                        on = false;
                      });
                      
                    }
                  }
                },
                child: SvgPicture.asset(on ?'assets/images/m_on.svg' : 'assets/images/m_off.svg')),
              Text('Вызвать скорую',style: TextStyle(color: Color.fromRGBO(219, 19, 91, 1), fontSize: 18, fontWeight: FontWeight.w600)),
              
            ],
          ),
        ),
        SizedBox(height: 20),
        institutionModel == null 
        ? GestureDetector(
          onTap: ()async{
            Navigator.push(context, MaterialPageRoute(builder: (context) => SelectInstituts(type: 'med')))
            .then((institution){
              setState(() {
                institutionModel = institution;
              });
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 9),
            margin: EdgeInsets.symmetric(horizontal: 23),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(41, 142, 235, 1),
                  Color.fromRGBO(65, 73, 255, 1),
                ]
              )
            ),
            child: Center(
              child: Text('Выбрать учреждение', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
            ),
          ),
        )
        : Container(
            margin: EdgeInsets.only(top: 16, left: 23, right: 23, bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Color.fromRGBO(0, 0, 0, 0.24),
                ),
              ],
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
                            width: 30,
                            svgPath: 'assets/icons/medInst.svg',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            institutionModel?.name ?? '',
                            style: TextStyle(
                              color: Color.fromRGBO(51, 132, 226, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            institutionModel?.address ?? '',
                            style: TextStyle(
                              color: Color.fromRGBO(142, 150, 155, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color.fromRGBO(221, 222, 226, 1),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14, top: 15),
                  child: Row(
                    children: [
                      Text(
                        '1102м',
                        style: TextStyle(
                          color: Color.fromRGBO(44, 62, 79, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '40 мин',
                        style: TextStyle(
                          color: Color.fromRGBO(44, 62, 79, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
                          border: Border.all(color: Color.fromRGBO(95, 178, 255, 1)),
                        ),
                      ),
                      Text(
                        'Оставить по умолчанию',
                        style: TextStyle(
                          color: Color.fromRGBO(95, 178, 255, 1),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ]
    )
    );
  }
}
