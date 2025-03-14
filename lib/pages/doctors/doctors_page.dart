import 'package:careme24/pages/doctors/favorites_cubit.dart';
import 'package:careme24/pages/doctors/favorites_state.dart';
import 'package:careme24/pages/services_call/doctor_call_page_fav.dart';
import 'package:careme24/pages/services_call/select_reason_screen.dart';
import 'package:careme24/theme/app_style.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/app_bar/custom_app_bar.dart';
import 'package:careme24/widgets/custom_image_view.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  String? selectedReason;

  void _callNumber(String phone) async {
    final url = Uri.parse('tel:$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().fetchFavorites();
    selectedReason = null;
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
          margin: getMargin(left: 15, top: 15, bottom: 15),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: AppbarTitle(text: "Закладки"),
        styleType: Style.bgFillBlue60001,
      ),
      body: SafeArea(
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
          buildWhen: (previous, current) {
            return current is FavoriteLoadedGet || current is FavoriteLoading;
          },
          builder: (context, state) {
            if (state is FavoriteLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FavoriteLoadedGet) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<FavoriteCubit>().fetchFavorites();
                },
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // Pass the reason back when selecting a reason
                        final reason = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectReasonScreen(type: 'med'),
                          ),
                        );
                        // Check if the reason is not null, then update the state
                        if (reason != null) {
                          setState(() {
                            selectedReason = reason;
                          });
                        }
                      },
                      child: Padding(
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
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    selectedReason ?? 'Проблема',
                                    style: AppStyle.txtMontserratSemiBold19,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                CustomImageView(
                                  svgPath: ImageConstant.imgArrowdownLightBlue900,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        color: Colors.white,
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(16),
                          itemCount: state.serviceList.length,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 24),
                          itemBuilder: (context, index) {
                            final item = state.serviceList[index];
                            return GestureDetector(
                              onTap: () {
                                if (selectedReason == null) {
                                  ElegantNotification.error(
                                          description:
                                              Text('Выберете причину вызова'))
                                      .show(context);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorCallScreenFav(
                                                reason: selectedReason ?? '',
                                                serviceModel:
                                                    state.serviceList[index],
                                                cardId: item.serviceId,
                                              )));
                                }
                              },
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 26,
                                        backgroundImage:
                                            NetworkImage(item.service.photo),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.service.name,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            context
                                                .read<FavoriteCubit>()
                                                .deletFavorites(item.serviceId);
                                          },
                                          child: CustomImageView(
                                            svgPath: ImageConstant.heart_fav,
                                            height: 24,
                                            width: 24,
                                            color: Colors.red,
                                            margin: getMargin(
                                                left: 15, top: 5, bottom: 2),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

