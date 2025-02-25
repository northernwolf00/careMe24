import 'package:careme24/theme/app_style.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CaremeReasonPage extends StatefulWidget {
  const CaremeReasonPage({
    super.key,
    required this.important,
    this.selectedReasonIndex,
  });

  final bool important;
  final int? selectedReasonIndex;

  @override
  State<CaremeReasonPage> createState() => _CaremeReasonPageState();
}

class _CaremeReasonPageState extends State<CaremeReasonPage> {
  bool important = false;
  int? selectedReasonIndex;

  @override
  void initState() {
    important = widget.important;
    selectedReasonIndex = widget.selectedReasonIndex;
    super.initState();
  }

  final List<String> reasonText = <String>[
    'Совершается преступление / террорист',
    "Стихийное бедствие / пожар",
    "Вызов мед. помощи",
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(25, 154, 139, 1),
    ));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(67, 211, 194, 1),
              Color.fromRGBO(42, 194, 176, 1),
              Color.fromRGBO(25, 154, 139, 1),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 23),
              padding: getPadding(top: 14),
              width: double.infinity,
              height: 80, 
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                color: Color.fromRGBO(178, 218, 255, 1),
              ),
              child: Padding(
                padding: getPadding(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Причина вызова",
                      style: AppStyle.txtMontserratSemiBold19,
                    ),
                  ],
                ),
              ),
            ),
            ...List.generate(reasonText.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedReasonIndex = index;  
                  });
                },
                child: Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(horizontal: 23),
                  padding: EdgeInsets.all(19),
                  decoration: BoxDecoration(
                    color: selectedReasonIndex == index
                        ? Color.fromRGBO(254, 246, 225, 1) 
                        : Colors.white,  
                  ),
                  child: Text(
                    reasonText[index],
                    style: TextStyle(
                      color: Color.fromRGBO(44, 62, 79, 1),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 23),
              padding: EdgeInsets.all(19),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Важно',
                    style: TextStyle(
                      color: Color.fromRGBO(44, 62, 79, 1),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Checkbox(
                    value: important, 
                    onChanged: (s) {
                      setState(() {
                        important = !important;
                      });
                    }, 
                    activeColor: Color.fromRGBO(25, 154, 139, 1),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                if (selectedReasonIndex != null) {
                  Navigator.pop(context, [selectedReasonIndex, reasonText[selectedReasonIndex!] ,important]); 
                }else{
                  Navigator.pop(context);
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                padding: EdgeInsets.symmetric(vertical: 9),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(65, 73, 255, 1),
                      Color.fromRGBO(41, 142, 235, 1),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    'Сохранить',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),  
          ],
        ),
      ),
    );
  }
}
