import 'package:careme24/theme/theme.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/custom_text_form_field.dart';
import 'package:careme24/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatClosedScreen extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();

  ChatClosedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
                height: getVerticalSize(69),
                leadingWidth: 39,
                leading: AppbarImage(
                    height: getVerticalSize(18),
                    width: getHorizontalSize(11),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 28, top: 23, bottom: 27),
                    onTap: () {
                      onTapArrowleft4(context);
                    }),
                title: Padding(
                    padding: getPadding(left: 27),
                    child: Row(children: [
                      Container(
                        height:200,
                        width: 200,
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(100)
                          //more than 50% of width makes circle
                        ),
                        child:  ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CircleAvatar(

                            child: CustomImageView(imagePath: ImageConstant.imgRectangle2626),
                          ),
                        ),
                      ),

                      Padding(
                          padding: getPadding(left: 10, top: 3, bottom: 1),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AppbarSubtitle2(
                                    text: "Лор", margin: getMargin(right: 105)),
                                const AppbarSubtitle2(text: "Иванов Алексей"),
                                Padding(
                                    padding: getPadding(top: 1, right: 67),
                                    child: Row(children: [
                                      const AppbarSubtitle2(text: "Не в сети"),
                                      Container(
                                          height: getSize(8),
                                          width: getSize(8),
                                          margin: getMargin(
                                              left: 5, top: 3, bottom: 3),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  getHorizontalSize(4)),
                                              border: Border.all(
                                                  color:
                                                  ColorConstant.whiteA700,
                                                  width: getHorizontalSize(1))))
                                    ]))
                              ]))
                    ])),
                styleType: Style.bgFillBlue60001),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(top: 12, bottom: 12),
                child:
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                      padding: getPadding(top: 143),
                      child: Text("Чат откроется через:",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtMontserratSemiBold22)),
                  Padding(
                      padding: getPadding(top: 16),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: getPadding(top: 1),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("День",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style:
                                          AppStyle.txtMontserratMedium18),
                                      Container(
                                          width: getHorizontalSize(61),
                                          margin: getMargin(top: 5),
                                          padding: getPadding(
                                              left: 26,
                                              top: 20,
                                              right: 26,
                                              bottom: 20),
                                          decoration: AppDecoration
                                              .txtOutlineBlue30001
                                              .copyWith(
                                              borderRadius:
                                              BorderRadiusStyle
                                                  .txtRoundedBorder10),
                                          child: Text("1",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtMontserratSemiBold15Bluegray800))
                                    ])),
                            CustomImageView(
                                svgPath: ImageConstant.imgGroup7371,
                                height: getVerticalSize(17),
                                width: getHorizontalSize(3),
                                margin:
                                getMargin(left: 9, top: 55, bottom: 26)),
                            Padding(
                                padding: getPadding(left: 8),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Час",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style:
                                          AppStyle.txtMontserratMedium18),
                                      Container(
                                          width: getHorizontalSize(61),
                                          margin: getMargin(top: 7),
                                          padding: getPadding(
                                              left: 17,
                                              top: 20,
                                              right: 17,
                                              bottom: 20),
                                          decoration: AppDecoration
                                              .txtOutlineBlue30001
                                              .copyWith(
                                              borderRadius:
                                              BorderRadiusStyle
                                                  .txtRoundedBorder10),
                                          child: Text("23",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtMontserratSemiBold15Bluegray800))
                                    ])),
                            CustomImageView(
                                svgPath: ImageConstant.imgGroup7371,
                                height: getVerticalSize(17),
                                width: getHorizontalSize(3),
                                margin:
                                getMargin(left: 9, top: 55, bottom: 26)),
                            Padding(
                                padding: getPadding(left: 9),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Мин",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style:
                                          AppStyle.txtMontserratMedium18),
                                      Container(
                                          width: getHorizontalSize(61),
                                          margin: getMargin(top: 7),
                                          padding: getPadding(
                                              left: 15,
                                              top: 20,
                                              right: 15,
                                              bottom: 20),
                                          decoration: AppDecoration
                                              .txtOutlineBlue30001
                                              .copyWith(
                                              borderRadius:
                                              BorderRadiusStyle
                                                  .txtRoundedBorder10),
                                          child: Text("40",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtMontserratSemiBold15Bluegray800))
                                    ]))
                          ])),
                  Container(
                      width: getHorizontalSize(200),
                      margin: getMargin(top: 32),
                      child: Text(
                          "После окончания таймера вы сможете писать в чате",
                          maxLines: null,
                          textAlign: TextAlign.center,
                          style: AppStyle.txtMontserratMedium15Blue600)),
                  const Spacer(),
                  Container(
                      width: double.maxFinite,
                      padding:
                      getPadding(left: 22, top: 23, right: 22, bottom: 23),
                      decoration: AppDecoration.fillBlue60001,
                      child: Row(children: [
                        Text("Вы записаны на:",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtMontserratSemiBold15Bluegray800),
                        Padding(
                            padding: getPadding(left: 17),
                            child: Text("24.07.2022",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style:
                                AppStyle.txtMontserratMedium15Blue600)),
                        Padding(
                            padding: getPadding(left: 27),
                            child: Text("14:30",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtMontserratMedium15Blue600))
                      ]))
                ])),
            bottomNavigationBar: Container(
                margin: getMargin(left: 23, right: 23, bottom: 46),
                decoration: AppDecoration.outlineBlack90054,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          decoration: AppDecoration.outlineBlack90054,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                    focusNode: FocusNode(),
                                    controller: messageController,
                                    hintText: "Сообщение",
                                    textInputAction: TextInputAction.done,
                                    suffix: Container(
                                        margin: getMargin(
                                            left: 30,
                                            top: 11,
                                            right: 15,
                                            bottom: 10),
                                        child: CustomImageView(
                                            svgPath:
                                            ImageConstant.imgTrashBlue300)),
                                    suffixConstraints: BoxConstraints(
                                        maxHeight: getVerticalSize(44))),
                                CustomImageView(
                                    svgPath: ImageConstant.imgMicrophone,
                                    height: getSize(27),
                                    width: getSize(27),
                                    margin:
                                    getMargin(left: 10, top: 8, bottom: 9))
                              ]))
                    ]))));
  }

  onTapArrowleft4(BuildContext context) {
    Navigator.pop(context);
  }
}