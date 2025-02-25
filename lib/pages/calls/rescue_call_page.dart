import 'dart:async';

import 'package:careme24/pages/calls/rescue_call_button.dart';
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
import 'package:careme24/widgets/reason_mes.dart';
import 'package:flutter/material.dart';


final _controller = ValueNotifier<bool>(false);
bool _checked = false;
bool select_reason = false;
Color select_color = const Color.fromRGBO(254, 246, 225, 100);

final List<String> reasonText = <String>[
  "3.13. Пожар в лесу",
  "3.12. Пожар в квартире",
  "3.18. Застряла голова в проеме",
  "3.29. Запах газа в квартире",
  "3.11. Домашнее насилие",
  "3.15. Пожар в здании",
  "3.12. Реагирования в чрезвычайных ситуациях",
  "3.28. Тепловой удар",
  "3.12. Приступ астмы, проблемы с дыханием",
  "C7",
  "C8"
];

final List<bool> reasonDisable = <bool>[
  false,
  false,
  true,
  true,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];

class RescueCallPage extends StatefulWidget {
  const RescueCallPage({super.key});

  @override
  State<RescueCallPage> createState() =>
      _RescueCallPageState();
}

class _RescueCallPageState extends State<RescueCallPage> {
  bool isSelectedSwitch = false;
  bool _show = false;

  TextEditingController componentfortyController = TextEditingController();

  TextEditingController frame7304Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startTimer();
    _controller.addListener(() {
      setState(() {
        if (_controller.value) {
          _checked = true;
        } else {
          _checked = false;
        }
      });
    });
  }

  _startTimer(){
    Timer(
      const Duration(seconds: 3),
      (){
        setState(() {
          _show = !_show;
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _show ? ColorConstant.gray100 : ColorConstant.orangeMCHS,
      resizeToAvoidBottomInset: false,
      appBar: _show
      ? CustomAppBar(
          height: getVerticalSize(48),
          leadingWidth: 43,
          leading: AppbarImage(
              height: getVerticalSize(16),
              width: getHorizontalSize(11),
              svgPath: ImageConstant.imgArrowleft,
              margin: getMargin(left: 32, top: 12, bottom: 20),
              onTap: () {
                onTapArrowleft19(context);
              }),
          centerTitle: true,
          title: AppbarTitle(text: "Вызов МЧС"),
          styleType: Style.bgFillBlue60001)
      : null,
      body: _show
      ? Container(
          width: double.maxFinite,
          padding: getPadding(left: 20, right: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: getPadding(left: 1, top: 17),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ForWhom(name: 'Мне',),
                          const PaySwitcher(),
                        ])),
                Expanded(
                  child: Container(
                    padding: getPadding(top: 14),
                    width: MediaQuery.of(context).size.width - 40,
                    height: MediaQuery.of(context).size.height - 180,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10)),
                              color: Color.fromRGBO(178, 218, 255, 100),
                            ),
                            width: MediaQuery.of(context).size.width - 40,
                            height: 80,
                            child: Padding(
                              padding: getPadding(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Причина вызова",
                                    style: AppStyle.txtMontserratSemiBold19,
                                  ),
                                  CustomImageView(
                                    svgPath: ImageConstant
                                        .imgSettingsLightBlue900,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              child: ListView.separated(
                                itemCount: reasonText.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ReasonMES(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => RescueCallButton(text: reasonText[index],)));
                                    },
                                    text: reasonText[index],
                                    disable: reasonDisable[index],
                                    backgroundColor: Colors.white,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                const Divider(indent: 0, height: 1),
                              ))
                        ]),
                  ),
                )
              ]))
            : SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
    child: CustomImageView(
      svgPath: ImageConstant.imgMCHSScreen,
      alignment:Alignment.center
    )
      ));
  }

  onTapArrowleft19(BuildContext context) {
    Navigator.pop(context);
  }
}

class AdvancedSwitch extends StatefulWidget {
  const AdvancedSwitch({
    super.key,
    this.controller,
    this.activeColor = const Color(0xFF4CAF50),
    this.inactiveColor = const Color(0xFF9E9E9E),
    this.activeChild,
    this.inactiveChild,
    this.activeImage,
    this.inactiveImage,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.width = 50.0,
    this.height = 30.0,
    this.enabled = true,
    this.disabledOpacity = 0.5,
    this.thumb,
  });

  /// Determines if widget is enabled
  final bool enabled;

  /// Determines current state.
  final ValueNotifier<bool>? controller;

  /// Determines background color for the active state.
  final Color activeColor;

  /// Determines background color for the inactive state.
  final Color inactiveColor;

  /// Determines label for the active state.
  final Widget? activeChild;

  /// Determines label for the inactive state.
  final Widget? inactiveChild;

  /// Determines background image for the active state.
  final ImageProvider? activeImage;

  /// Determines background image for the inactive state.
  final ImageProvider? inactiveImage;

  /// Determines border radius.
  final BorderRadius borderRadius;

  /// Determines width.
  final double width;

  /// Determines height.
  final double height;

  /// Determines opacity of disabled control.
  final double disabledOpacity;

  /// Thumb widget.
  final Widget? thumb;

  @override
  _AdvancedSwitchState createState() => _AdvancedSwitchState();
}

class _AdvancedSwitchState extends State<AdvancedSwitch>
    with SingleTickerProviderStateMixin {
  static const _duration = Duration(milliseconds: 250);
  late ValueNotifier<bool> _controller;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<Color?> _colorAnimation;
  late double _thumbSize;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? ValueNotifier<bool>(false);
    _controller.addListener(_handleControllerValueChanged);

    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
      value: _controller.value ? 1.0 : 0.0,
    );

    _initAnimation();
  }

  @override
  void didUpdateWidget(covariant AdvancedSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final labelSize = widget.width - _thumbSize;
    final containerSize = labelSize * 2 + _thumbSize;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _handlePressed,
        child: Opacity(
          opacity: widget.enabled ? 1 : widget.disabledOpacity,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (_, child) {
              return ClipRRect(
                borderRadius: widget.borderRadius,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  color: _colorAnimation.value,
                  child: child,
                ),
              );
            },
            child: Stack(
              children: [
                if (widget.activeImage != null || widget.inactiveImage != null)
                  ValueListenableBuilder<bool>(
                    valueListenable: _controller,
                    builder: (_, __, ___) {
                      return AnimatedCrossFade(
                        crossFadeState: _controller.value
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: _duration,
                        firstChild: Image(
                          width: widget.width,
                          height: widget.height,
                          image: widget.inactiveImage ?? widget.activeImage!,
                          fit: BoxFit.cover,
                        ),
                        secondChild: Image(
                          width: widget.width,
                          height: widget.height,
                          image: widget.activeImage ?? widget.inactiveImage!,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: _slideAnimation.value,
                      child: child,
                    );
                  },
                  child: OverflowBox(
                    minWidth: containerSize,
                    maxWidth: containerSize,
                    minHeight: widget.height,
                    maxHeight: widget.height,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconTheme(
                          data: const IconThemeData(
                            color: Color(0xFFFFFFFF),
                            size: 20,
                          ),
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            child: Container(
                              width: labelSize,
                              height: widget.height,
                              alignment: Alignment.center,
                              child: widget.activeChild,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(2),
                          width: _thumbSize - 4,
                          height: _thumbSize - 4,
                          child: widget.thumb ??
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorConstant.gray50001,
                                  borderRadius: widget.borderRadius
                                      .subtract(BorderRadius.circular(1)),
                                ),
                              ),
                        ),
                        IconTheme(
                          data: const IconThemeData(
                            color: Color(0xFFFFFFFF),
                            size: 20,
                          ),
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            child: Container(
                              width: labelSize,
                              height: widget.height,
                              alignment: Alignment.center,
                              child: widget.inactiveChild,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _initAnimation() {
    _thumbSize = widget.height;
    final offset = widget.width / 2 - _thumbSize / 2;

    final animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(-offset, 0),
      end: Offset(offset, 0),
    ).animate(animation);

    _colorAnimation = ColorTween(
      begin: widget.inactiveColor,
      end: widget.activeColor,
    ).animate(animation);
  }

  void _handleControllerValueChanged() {
    if (_controller.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _handlePressed() {
    if (widget.controller != null && widget.enabled) {
      _controller.value = !_controller.value;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerValueChanged);

    if (widget.controller == null) {
      _controller.dispose();
    }

    _animationController.dispose();

    super.dispose();
  }
}

