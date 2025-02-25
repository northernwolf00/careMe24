import 'package:careme24/blocs/app_bloc.dart';
import 'package:careme24/blocs/institution/institution_cubit.dart';
import 'package:careme24/blocs/institution/institution_state.dart';
import 'package:careme24/theme/color_constant.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/app_bar/custom_app_bar.dart';
import 'package:careme24/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectInstituts extends StatelessWidget {
  const SelectInstituts({
    super.key,
    required this.type
  });

  final String type;

  @override
  Widget build(BuildContext context) {
    AppBloc.institutionCubit.fetchData(type);
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
        title: AppbarTitle(text: "Выбрать учреждение"),
        styleType: Style.bgFillBlue60001
      ),
      body: BlocBuilder<InstitutionCubit, InstitutionState>(
        builder: (context, state){
          if(state is InstitutionLoaded){
            return SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(state.institutionList.length, (index){
                    final item = state.institutionList[0];
                    return  GestureDetector(
                      onTap: (){
                        Navigator.pop(context, state.institutionList[index]);
                      },
                      child: Container(
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
                                      color: getColor(item.type),
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30)),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CustomImageView(
                                          svgPath: getImage(item.type),
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
                                          item.name,
                                          style: TextStyle(
                                            color: Color.fromRGBO(51, 132, 226, 1),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          item.address,
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
                    );
                  }),
                ],
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator.adaptive());
          }
        }
      ),
    );
  }
}

getImage(String type){
  switch(type){
    case 'pol':
      return ImageConstant.policehat;
    case 'mch':
      return 'assets/icons/fire.svg';
    case 'med':
      return 'assets/icons/medInst.svg'; 
  }
}

getColor(String type){
  switch(type){
    case 'pol':
      return ColorConstant.indigoA100;
    case 'mch':
      return Color.fromRGBO(255, 187, 38, 1);
    case 'med':
      return Colors.white; 
  }
}