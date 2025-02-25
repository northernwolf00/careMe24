import 'package:careme24/pages/medical_bag/widgets/custom_gradient_button.dart';
import 'package:careme24/pages/medical_bag/widgets/custom_text_field_dialog.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class MedicineListScreen extends StatelessWidget {
  final String title;
   final TextEditingController titleController;


  MedicineListScreen({required this.title,Key? key}): titleController = TextEditingController(text: title),
        super(key: key);

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
          text: "Домашняя аптечка",
        ),
        styleType: Style.bgFillBlue60001,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 45,
                  child: Row(
                    children: [
                     const Icon(Icons.medical_services, color: Colors.blue),
                      Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: "Введите название",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            
        
                          ),
                          style:const TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ],
                  ),
                )),
            // SizedBox(
            //   height: 45,
            //   child: Card(
            //     color: Colors.white,
            //     child: ListTile(
            //       leading: Icon(Icons.medical_services),
            //       title: Text(title),
            //     ),
            //   ),
            // ),
            SizedBox(height: 16),
            Container(
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
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 15),
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Феназепам',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontFamily: "Montserrat",
                                    color: Colors.black),
                              ),
                              Text(
                                'Годен до 04.2024',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: "Montserrat",
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 20),
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
                                  return AddMedicineDialog();
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
            )
          ],
        ),
      ),
    );
  }
}

class AddMedicineDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width -20,
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
                hintText: 'Срок  годности',
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: CustomTextFieldDialog(
                hintText: 'Количество',
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
