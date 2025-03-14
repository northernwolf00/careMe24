import 'package:careme24/pages/medical_bag/widgets/custom_gradient_button.dart';
import 'package:careme24/pages/medical_bag/widgets/custom_text_field_dialog.dart';
import 'package:careme24/pages/medicines/cubit/medicines_cubit.dart';
import 'package:careme24/pages/medicines/cubit/medicines_state.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/app_bar/custom_app_bar.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MedicineListScreen extends StatefulWidget {
  final String title;
  final String id;
  MedicineListScreen({
    required this.title,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<MedicineListScreen> createState() => _MedicineListScreenState();
}

class _MedicineListScreenState extends State<MedicineListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MedicineCubit>().getMedicines(widget.id);
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
                              child: Text(widget.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ))),
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
                      BlocBuilder<MedicineCubit, MedicinesState>(
                          builder: (context, state) {
                        if (state is MedicinesLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is MedicinesError) {
                          return Center(child: Text(state.message));
                        } else if (state is MedicinesLoaded) {
                          final medicineList = state.aidKits;
                          return ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 15),
                            itemCount: medicineList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AidKitMedicinesDialogEdit(
                                      title: medicineList[index].title,
                                       expiration : medicineList[index]
                                                    .expirationDate!,
                                      id: medicineList[index].id,
                                      quantity: medicineList[index].count,
                                      aidKitId: widget.id
                                    );
                                  },
                                );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        medicineList[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            fontFamily: "Montserrat",
                                            color: Colors.black),
                                      ),
                                      Text(
                                        medicineList[index].expirationDate != null
                                            ? DateFormat('yyyy-MM-dd').format(
                                                medicineList[index]
                                                    .expirationDate!)
                                            : 'N/A',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          fontFamily: "Montserrat",
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(child: Text('Нет доступных данных'));
                        }
                      }),
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
                                    return AddMedicineDialog(id: widget.id);
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
          )),
    );
  }
}

class AddMedicineDialog extends StatefulWidget {
  final String id;

  const AddMedicineDialog({required this.id, Key? key}) : super(key: key);

  @override
  State<AddMedicineDialog> createState() => _AddMedicineDialogState();
}

class _AddMedicineDialogState extends State<AddMedicineDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController expirationController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    expirationController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Default to today
      firstDate: DateTime(2000), // Start year
      lastDate: DateTime(2100), // End year
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        expirationController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: SizedBox(
        height: 300,
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
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: CustomTextFieldDialog(
                hintText: 'Наименование',
                controller: nameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: () => _selectDate(context), // Open date picker on tap
                child: AbsorbPointer(
                  child: CustomTextFieldDialog(
                    hintText: 'Срок годности',
                    controller: expirationController,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CustomTextFieldDialog(
                hintText: 'Количество',
                controller: quantityController,
              ),
            ),
            BlocConsumer<MedicineCubit, MedicinesState>(
              listener: (context, state) {
                if (state is MedicinesCreated) {
                  ElegantNotification.success(description: Text(state.detail))
                      .show(context);
                 
                } else if (state is MedicinesError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return CustomGradientButton(
                  text:
                      state is MedicinesLoading ? 'Добавление...' : 'Добавить',
                  onPressed: () {
                    context.read<MedicineCubit>().createMedicines(
                          nameController.text,
                          expirationController.text,
                          quantityController.text,
                          widget.id,
                        );
                        Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AidKitMedicinesDialogEdit extends StatefulWidget {
  final String title;
  final DateTime expiration;
  final String quantity;
  final String id;
  final String aidKitId;

  AidKitMedicinesDialogEdit(
      {required this.title, required this.expiration, required this.quantity, 
      required this.id, required this.aidKitId});

  @override
  State<AidKitMedicinesDialogEdit> createState() => _AidKitMedicinesDialogEditState();
}

class _AidKitMedicinesDialogEditState extends State<AidKitMedicinesDialogEdit> {


 late TextEditingController nameController;
  late TextEditingController dosageController;
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.title);
    dosageController = TextEditingController(text: widget.quantity);
    dateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(widget.expiration)); // Format date
  }

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();
    dosageController.dispose();
    super.dispose();
  }

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Default to today
      firstDate: DateTime(2000), // Start year
      lastDate: DateTime(2100), // End year
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        dateController.text = formattedDate;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: SizedBox(
        height: 350,
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
              padding: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: () => _selectDate(context), // Open date picker on tap
                child: AbsorbPointer(
                  child: CustomTextFieldDialog(
                    hintText: 'Срок годности',
                    controller: dateController,
                  ),
                ),
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
              child:  BlocConsumer<MedicineCubit, MedicinesState>(
              listener: (context, state) {
                if (state is MedicinesUpdated) {
                  ElegantNotification.success(description: Text(state.detail))
                      .show(context);
                  Navigator.pop(context);
                } else if (state is MedicinesError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return CustomGradientButton(
                    text: 'Изменить',
                    onPressed: () {
                       context.read<MedicineCubit>().updateMedicines(
                               widget.id,
                              nameController.text,
                              dateController.text,
                              dosageController.text,
                              widget.aidKitId
                              
                            );
                      Navigator.pop(context);
                    },
                  );
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child:  BlocConsumer<MedicineCubit, MedicinesState>(
              listener: (context, state) {
                if (state is MedicinesDeleted) {
                  ElegantNotification.success(description: Text(state.detail))
                      .show(context);
                  // 
                } else if (state is MedicinesError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return CustomGradientRedButton(
                    text: 'Удалить',
                    onPressed: () {
                      context.read<MedicineCubit>().deletMedicines(
                              widget.id
                             
                            );
Navigator.pop(context);
                    },
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
