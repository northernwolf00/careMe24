import 'package:careme24/api/http_manager.dart';
import 'package:careme24/blocs/app_bloc.dart';
import 'package:careme24/blocs/drawer/drawer_cubit.dart';
import 'package:careme24/blocs/drawer/drawer_state.dart';
import 'package:careme24/router/app_router.dart';
import 'package:careme24/service/pref_service.dart';
import 'package:careme24/service/token_storage.dart';
import 'package:careme24/theme/app_style.dart';
import 'package:careme24/utils/utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


// ignore: must_be_immutable
class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});
  
  String avatarPath = '';
  String phoneNumber = '';
  String userName = '';

  @override
  Widget build(BuildContext context) {
    AppBloc.drawerCubit.fetchMyData();
    return Container(
      padding: const EdgeInsets.only(left: 23, top: 55),
      color: Colors.blue,
      child: Column(
        children: [
          Row(
            children: [
              AppbarImage(
                  height: getVerticalSize(16),
                  width: getHorizontalSize(11),
                  svgPath: ImageConstant.imgArrowleft,
                  margin: getMargin(top: 15, bottom: 15),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              const SizedBox(
                width: 20,
              ),
              const Text(
                'CareMe 24',
                style: TextStyle(
                  fontSize: 22.3,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<DrawerCubit, DrawerState>(
            builder: (context, state){
              if (state is DrawerStateLoaded) {
                phoneNumber = state.userInfo.phone.toString();
                avatarPath = state.userInfo.personalInfo.avatar;
                userName = state.userInfo.personalInfo.full_name;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: avatarPath == ''
                      ? Container(
                          height: 76,
                          width: 76,
                          color: Colors.grey[300],
                        child: Icon(
                        Icons.person,
                          size: 50,
                        ),
                      )
                      : Image.network(
                        height: 76,
                        width: 76,
                        avatarPath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          phoneNumber,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRouter.medCardList),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/text-box.svg'),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Медкарты',
                    style: AppStyle.txtInterExtraBold12.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRouter.calls),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/phone1.svg'),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Вызовы',
                    style: AppStyle.txtInterExtraBold12.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRouter.medicalBag),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/medical-bag.svg'),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Моя Аптечка',
                    style: AppStyle.txtInterExtraBold12.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRouter.medicines),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/pill-icon.svg'),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Прием лекарств',
                    style: AppStyle.txtInterExtraBold12.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRouter.doctors),
              child: Row(
                children: [
                  SvgPicture.asset(
                      'assets/images/doctor.svg'),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Врачи',
                    style: AppStyle.txtInterExtraBold12.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRouter.wallet),
              child: Row(
                children: [
                  SvgPicture.asset(
                      'assets/images/wallet.svg'),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Кошелек',
                    style: AppStyle.txtInterExtraBold12.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              // Api.refresh();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, AppRouter.settings),
                child: Row(
                  children: [
                    SvgPicture.asset(
                        'assets/images/settings.svg'),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Настройки',
                      style: AppStyle.txtInterExtraBold12.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 46, top: 20),
            height: 1,
            width: double.maxFinite,
            color: Colors.white,
          ),
          GestureDetector(
            onTap: ()async{
              await TokenManager.deleteToken();
              await PrefService.delete();
              HttpManager.instance.resetToken();
              Navigator.pushReplacementNamed(context, AppRouter.startPage);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Row(
                children: [
                  SvgPicture.asset(
                      'assets/images/exit.svg'),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Выход',
                    style: AppStyle.txtInterExtraBold12.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
