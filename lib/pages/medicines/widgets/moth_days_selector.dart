import 'package:careme24/pages/medical_bag/widgets/custom_gradient_button.dart';
import 'package:careme24/pages/medical_bag/widgets/custom_text_field_dialog.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class MonthDaysSelector extends StatefulWidget {
  @override
  _MonthDaysSelectorState createState() => _MonthDaysSelectorState();
}

class _MonthDaysSelectorState extends State<MonthDaysSelector> {
  int? selectedIndex;
  List<DateTime> dates = [];
  String currentMonth = "";

  @override
  void initState() {
    super.initState();
    generateDaysList();
  }

  void generateDaysList() {
    DateTime now = DateTime.now();
    for (int i = 0; i < 365; i++) {
      dates.add(now.add(Duration(days: i)));
    }
    currentMonth = DateFormat('MMMM', 'ru').format(dates.first);
  }

  void updateMonth(int index) {
    String newMonth = DateFormat('MMMM', 'ru').format(dates[index]);
    if (newMonth != currentMonth) {
      setState(() {
        currentMonth = newMonth;
      });
    }
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
            }),
        centerTitle: true,
        title: AppbarTitle(
          text: "Прием лекарств",
        ),
        styleType: Style.bgFillBlue60001,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    currentMonth,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 10),
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dates.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        updateMonth(index);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: selectedIndex == index
                              ? Colors.blue
                              : Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            DateFormat('d').format(dates[index]),
                            style: TextStyle(
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Лекарства',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            color: Colors.blue),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset("assets/icons/time.svg"),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  '8:30',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      fontFamily: "Montserrat",
                                      color: Colors.black),
                                ),
                              ),
                            ]),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 0),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      AddMedicineMedicinesDialogEdit(
                                    medicineName: "Феназепам",
                                    dosage: "0.3мг/3",
                                  ),
                                );
                              },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    index == 0 ? 'Феназепам' : "Эргоферон",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        fontFamily: "Montserrat",
                                        color: Colors.black),
                                  ),
                                  Text(
                                    index == 0 ? '0.3мг/3' : "1 т./2",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        fontFamily: "Montserrat",
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.add,
                              size: 24,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddMedicineMedicinesDialog();
                                  },
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  'Добавить',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      fontFamily: "Montserrat",
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset("assets/icons/time.svg"),
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '12:00',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontFamily: "Montserrat",
                                    color: Colors.black),
                              ),
                            ),
                          ]),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 0),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      AddMedicineMedicinesDialogEdit(
                                    medicineName: "Феназепам",
                                    dosage: "0.3мг/3",
                                  ),
                                );
                              },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    index == 0 ? 'Феназепам' : "Эргоферон",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        fontFamily: "Montserrat",
                                        color: Colors.black),
                                  ),
                                  Text(
                                    index == 0 ? '0.3мг/3' : "1 т./2",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        fontFamily: "Montserrat",
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.add,
                              size: 24,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddMedicineMedicinesDialog();
                                  },
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  'Добавить',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      fontFamily: "Montserrat",
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddMedicineMedicinesDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: SizedBox(
        height: 260,
        width: MediaQuery.of(context).size.width - 20,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        size: 34,
                      )),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Введите лекарства',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        fontFamily: "Montserrat",
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: CustomTextFieldDialog(
                hintText: 'Наименование',
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: CustomTextFieldDialog(
                hintText: 'Дозировка',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: CustomGradientButton(
                text: 'Добавить',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddMedicineMedicinesDialogEdit extends StatelessWidget {
  final String medicineName;
  final String dosage;

  AddMedicineMedicinesDialogEdit(
      {required this.medicineName, required this.dosage});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: medicineName);
    TextEditingController dosageController =
        TextEditingController(text: dosage);

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: SizedBox(
        height: 310,
        width: MediaQuery.of(context).size.width - 20,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        size: 34,
                      )),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Редактировать лекарства',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        fontFamily: "Montserrat",
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: CustomTextFieldDialog(
                 controller: nameController,
                hintText: 'Наименование',
              ),
               
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child:CustomTextFieldDialog(
                  controller: dosageController,
                hintText: 'Дозировка',
              ),
              
            
            ),
           Padding(
              padding: const EdgeInsets.only(top: 15),
              child: CustomGradientButton(
                text: 'Изменить',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: CustomGradientRedButton(
                text: 'Удалить',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
