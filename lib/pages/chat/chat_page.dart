import 'package:careme24/blocs/service/service_cubit.dart';
import 'package:careme24/blocs/service/service_state.dart';
import 'package:careme24/pages/chat/chat_close_page.dart';
import 'package:careme24/utils/utils.dart';
import 'package:careme24/widgets/chatcorresponde_item_widget.dart';
import 'package:careme24/widgets/custom_bottom_bar.dart';
import 'package:careme24/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

int _isSelected = -1;

bool _isEmpty = false;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ServiceCubit>().fetchDataChat();
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
                    margin: getMargin(left: 15, right: 15, top: 15, bottom: 15),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                centerTitle: true,
                title: AppbarTitle(text: "Сообщения"),
                actions: [
                  // AppbarImage(height: getSize(28),
                  //     width: getSize(28),
                  //     svgPath: ImageConstant.imgFavorite,
                  //     margin: getMargin(left: 18, top: 10, right:32,bottom: 5)),
                ],
                styleType: Style.bgFillBlue60001),
            body: BlocBuilder<ServiceCubit, ServiceState>(
                builder: (context, state) {
              if (state is ServiceChatGet) {
                return SizedBox(
                    width: double.maxFinite,
                    /* padding: getPadding(left: 88, top: 112, right: 88),*/
                    child: _isEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                CustomImageView(
                                    svgPath: ImageConstant.imgFrameBlue60001,
                                    height: getVerticalSize(60),
                                    width: getHorizontalSize(66),
                                    alignment: Alignment.center),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    margin: getMargin(
                                      left: 3,
                                      top: 17,
                                      right: 12,
                                    ),
                                    child: Text(
                                        "Пока новых сообщений от врачей нет",
                                        maxLines: null,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: ColorConstant.blue500,
                                          fontSize: getFontSize(
                                            15,
                                          ),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                        )))
                              ])
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Padding(
                                    padding: getPadding(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10),
                                    child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                              height: getVerticalSize(12));
                                        },
                                        itemCount: state.chatMessage.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatClosedScreen(
                                                              index: index,
                                                              message: state
                                                                  .chatMessage[
                                                                      index]
                                                                  .messages,
                                                              id: state
                                                                  .chatMessage[
                                                                      index]
                                                                  .id
                                                            ,
                                                              photo: state
                                                                  .chatMessage[
                                                                      index]
                                                                  .service
                                                                  .photo,
                                                              name: state
                                                                  .chatMessage[
                                                                      index]
                                                                  .service
                                                                  .name,
                                                              lastMessage: state
                                                                  .chatMessage[
                                                                      index]
                                                                  .countOfUnreadMessages,
                                                              specialization: state
                                                                  .chatMessage[
                                                                      index]
                                                                  .service
                                                                  .specialization,
                                                            )));
                                              },
                                              // onLongPress: () {
                                              //   setState(() {
                                              //     _isSelected = index;
                                              //   });
                                              // },
                                              child: ChatcorrespondeItemWidget(
                                                // isSelectedVisibler:
                                                //     _isSelected == index
                                                //         ? true
                                                //         : false,
                                                photo: state.chatMessage[index]
                                                    .service.photo,
                                                name: state.chatMessage[index]
                                                    .service.name,
                                                lastMessage: state
                                                    .chatMessage[index]
                                                    .countOfUnreadMessages,
                                                specialization: state
                                                    .chatMessage[index]
                                                    .service
                                                    .specialization,
                                              ));
                                        }))
                              ]));
              } else {
                return Center(child: CircularProgressIndicator.adaptive());
              }
            }),
            bottomNavigationBar:
                CustomBottomBar(onChanged: (BottomBarEnum type) {})));
  }

  ///Handling route based on bottom click actions
/*  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.tf:
        return AppRoutes.chatCorrespondencePage;
      default:
        return "/";
    }
  }*/

  ///Handling page based on route
/*  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.chatCorrespondencePage:
        return ChatCorrespondencePage();
      default:
        return DefaultWidget();
    }
  }*/

  onTapArrowleft1(BuildContext context) {
    Navigator.pop(context);
  }
}
