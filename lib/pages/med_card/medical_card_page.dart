import 'dart:developer';
import 'dart:io';
import 'package:careme24/blocs/app_bloc.dart';
import 'package:careme24/blocs/blocs.dart';
import 'package:careme24/models/medcard/medcard_model.dart';
import 'package:careme24/models/user_model.dart';
import 'package:careme24/theme/app_style.dart';
import 'package:careme24/utils/utils.dart';
import 'package:careme24/widgets/avatar_picker.dart';
import 'package:careme24/widgets/file_piceker.dart';
import 'package:careme24/widgets/med_card_widget/certificates_and_sick_widget.dart';
import 'package:careme24/widgets/med_card_widget/doctor_report_widget.dart';
import 'package:careme24/widgets/med_card_widget/personal_info_widget.dart';
import 'package:careme24/widgets/med_card_widget/test_results.dart';
import 'package:careme24/widgets/request_send_widget.dart';
import 'package:careme24/widgets/search.dart';
import 'package:careme24/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/med_card_widget/medical_data_widget.dart';

class MedicalCardPage extends StatefulWidget {
  const MedicalCardPage({
    super.key,
    required this.medcardModel,
    this.createMode = false,
    this.myCard = false,
  });

  final MedcardModel medcardModel;
  final bool createMode;
  final bool myCard;

  @override
  State<MedicalCardPage> createState() => _MedicalCardPageState();
}

class _MedicalCardPageState extends State<MedicalCardPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController countryAndAddresController =
      TextEditingController();
  final TextEditingController dataController = TextEditingController();
  final TextEditingController passportNumberController =
      TextEditingController();
  final TextEditingController passportSerialController =
      TextEditingController();
  final TextEditingController passportPlaceController = TextEditingController();
  final TextEditingController passportDataController = TextEditingController();
  final TextEditingController bloodTypeController = TextEditingController();
  final TextEditingController numberPoliceController = TextEditingController();
  final TextEditingController insuranceController = TextEditingController();
  final TextEditingController validityPeriodController =
      TextEditingController();
  final TextEditingController insuranceNameController = TextEditingController();
  String imagePath = '';
  File? avatar;
  File? insuranceFile;
  List<File>? photos;

  bool showSearch = false;
  bool showRequest = false;
  UserModel? selectedUser;

  List<ResponseModel> doctorReports = [];
  List<ResponseModel> testsResults = [];
  List<ResponseModel> certificates = [];

  void setValue() {
    imagePath = widget.medcardModel.personalInfo.avatar;
    nameController.text = widget.medcardModel.personalInfo.full_name;
    numberController.text = widget.medcardModel.personalInfo.phone.toString();
    countryAndAddresController.text = widget.medcardModel.personalInfo.address;
    dataController.text = widget.medcardModel.personalInfo.dob;

    passportNumberController.text =
        widget.medcardModel.personalInfo.passport.number.toString();
    passportSerialController.text =
        widget.medcardModel.personalInfo.passport.serial.toString();
    passportPlaceController.text =
        widget.medcardModel.personalInfo.passport.place;
    passportDataController.text =
        widget.medcardModel.personalInfo.passport.date;

    bloodTypeController.text = widget.medcardModel.medInfo.bloodType;
    numberPoliceController.text = widget.medcardModel.medInfo.policy.toString();
    insuranceNameController.text =
        widget.medcardModel.medInfo.medicalInsurance.name;
    insuranceController.text =
        widget.medcardModel.medInfo.medicalInsurance.number;
    validityPeriodController.text =
        widget.medcardModel.medInfo.medicalInsurance.validity;

    doctorReports = widget.medcardModel.doctorReports;
    testsResults = widget.medcardModel.testsResults;
    certificates = widget.medcardModel.cerificates;
  }

  @override
  void initState() {
    !widget.createMode ? setValue() : null;
    super.initState();
  }

  String countryCode = '+7';

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
            text: "Мед карта",
          ),
          styleType: Style.bgFillBlue60001,
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(23, 20, 23, 0),
          height: double.maxFinite,
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Stack(alignment: AlignmentDirectional.center, children: [
              Column(
                children: [
                  AvatarPicker(
                    imagePath: imagePath,
                    onChange: (image) {
                      log('$image');
                      avatar = image;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (!widget.createMode)
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showSearch = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: Color.fromRGBO(65, 73, 255, 1))),
                            child: Center(
                              child: Text(
                                'Передать профиль',
                                style: AppStyle.txtMontserratf18w600.copyWith(
                                    color: Color.fromRGBO(65, 73, 255, 1)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final response = await AppBloc.medCardCubit
                                .deleteCard(widget.medcardModel.id);
                            if (response.isSuccess) {
                              ElegantNotification.success(
                                      description: Text('Медкарта удалена'))
                                  .show(context);
                              await AppBloc.medCardCubit.fetchData();
                              await AppBloc.dangerousCubit.fetchData();
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: Color.fromRGBO(145, 0, 18, 1))),
                            child: Center(
                              child: Text(
                                'Удалить профиль',
                                style: AppStyle.txtMontserratf18w600.copyWith(
                                    color: Color.fromRGBO(145, 0, 18, 1)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 20),
                  PersonalInfoWidget(
                      createMode: widget.createMode,
                      onChange: (files) {
                        log('$files');
                        photos = files;
                      },
                      onTap: () async {
                        List<MultipartFile> photoFiles = [];
                        for (var file in photos!) {
                          photoFiles
                              .add(await MultipartFile.fromFile(file.path));
                        }

                        String phoneNumber =
                            '$countryCode ${numberController.text}'
                                .replaceAll(" ", "");

                        final data = {
                          "avatar": avatar != null
                              ? await MultipartFile.fromFile(avatar!.path)
                              : null,
                          "full_name": nameController.text,
                          "phone": phoneNumber,
                          "dob": dataController.text,
                          "address": countryAndAddresController.text,
                          "serial": int.parse(passportSerialController.text),
                          "number": int.parse(passportNumberController.text),
                          "place": passportPlaceController.text,
                          "date": passportDataController.text,
                          "photos": photoFiles,
                        };
                        log(widget.medcardModel.id);
                        final response = await AppBloc.medCardCubit
                            .updatePersonalInfo(data, widget.medcardModel.id);
                        if (response.isSuccess) {
                          ElegantNotification.success(
                                  description: Text('Медкарта обновлена'))
                              .show(context);
                          AppBloc.medCardCubit.fetchData();
                        }
                      },
                      nameController: nameController,
                      numberController: numberController,
                      countryAndAddresController: countryAndAddresController,
                      dateController: dataController,
                      passportNumberController: passportNumberController,
                      passportSerialController: passportSerialController,
                      passportDataController: passportDataController,
                      passportPlaceController: passportPlaceController,
                      files: widget.medcardModel.personalInfo.passport.photos),
                  const SizedBox(
                    height: 23,
                  ),
                  MedicalDataWidget(
                    file: widget.medcardModel.medInfo.medicalInsurance.photo,
                    showInsurance: widget.createMode,
                    bloodTypeController: bloodTypeController,
                    numberPoliceController: numberPoliceController,
                    insuranceNumberController: insuranceController,
                    validityPeriodController: validityPeriodController,
                    insuranceNameController: insuranceNameController,
                    onChange: (file) {
                      insuranceFile = file;
                    },
                    onTap: () async {
                      final data = {
                        "number": insuranceController.text,
                        "validity": validityPeriodController.text,
                        "name": insuranceNameController.text,
                        "photo": insuranceFile != null
                            ? await MultipartFile.fromFile(insuranceFile!.path)
                            : null,
                      };

                      final response = await AppBloc.medCardCubit
                          .updateMedInsurance(data, widget.medcardModel.id);
                      if (response.isSuccess) {
                        ElegantNotification.success(
                                description: Text('Медкарта обновлена'))
                            .show(context);
                        AppBloc.medCardCubit.fetchData();
                      }
                    },
                  ),
                  if (!widget.createMode)
                    Column(
                      children: [
                        const SizedBox(
                          height: 23,
                        ),
                        DoctorReportWidget(
                            response: doctorReports,
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialog(
                                        title: 'Введите заключение врача',
                                        requestType: 'doctor_reports',
                                        medcardId: widget.medcardModel.id,
                                        onChange: (r) {
                                          setState(() {
                                            doctorReports.add(r);
                                          });
                                        });
                                  });
                            }),
                        const SizedBox(
                          height: 23,
                        ),
                        TestResultWidget(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                      title: 'Введите анализ',
                                      requestType: 'tests_results',
                                      medcardId: widget.medcardModel.id,
                                      onChange: (r) {
                                        setState(() {
                                          testsResults.add(r);
                                        });
                                      });
                                });
                          },
                          response: testsResults,
                        ),
                        const SizedBox(
                          height: 23,
                        ),
                        CerificatesAnfSickWidget(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                      title: 'Введите справку',
                                      requestType: 'certificates',
                                      medcardId: widget.medcardModel.id,
                                      onChange: (r) {
                                        setState(() {
                                          certificates.add(r);
                                        });
                                      });
                                });
                          },
                          response: certificates,
                        ),
                        SizedBox(
                          height: 24,
                        )
                      ],
                    ),
                  if (widget.createMode)
                    Padding(
                        padding: const EdgeInsets.only(top: 24.0, bottom: 24),
                        child: GestureDetector(
                          onTap: () async {
                            String phoneNumber =
                                '$countryCode ${numberController.text}'
                                    .replaceAll(" ", "");
                            if (nameController.text.isEmpty ||
                                numberController.text.isEmpty ||
                                dataController.text.isEmpty ||
                                countryAndAddresController.text.isEmpty ||
                                passportSerialController.text.isEmpty ||
                                passportNumberController.text.isEmpty ||
                                passportPlaceController.text.isEmpty ||
                                passportDataController.text.isEmpty ||
                                bloodTypeController.text.isEmpty ||
                                numberPoliceController.text.isEmpty) {
                              ElegantNotification.error(
                                title: const Text("Ошибка"),
                                description: const Text(
                                    "Пожалуйста, заполните все поля."),
                              ).show(context);

                              return;
                            }

                            List<MultipartFile> photoFiles = [];
                            if (photos != null) {
                              for (var file in photos!) {
                                photoFiles.add(
                                    await MultipartFile.fromFile(file.path));
                              }
                            }

                            final data = {
                              "avatar": avatar != null
                                  ? await MultipartFile.fromFile(avatar!.path)
                                  : null,
                              "full_name": nameController.text,
                              "phone": phoneNumber,
                              "dob": dataController.text,
                              "address": countryAndAddresController.text,
                              "serial": passportSerialController.text,
                              "number": passportNumberController.text,
                              "place": passportPlaceController.text,
                              "date": passportDataController.text,
                              "photos": photoFiles,
                              "blood_type": bloodTypeController.text,
                              "policy": numberPoliceController.text,
                            };

                            final response =
                                await AppBloc.medCardCubit.addMedCard(data);
                            log('$response');

                            if (widget.myCard && response.id != '') {
                              final doMineResponse = await AppBloc.medCardCubit
                                  .doMedCardMine(response.id);
                              if (doMineResponse.isSuccess) {
                                ElegantNotification.success(
                                        description:
                                            Text('Медкарта удачно создана'))
                                    .show(context);
                                await AppBloc.medCardCubit.fetchData();
                                await AppBloc.dangerousCubit.fetchData();
                                Navigator.pop(context);
                              }
                            } else if (response.id != '') {
                              ElegantNotification.success(
                                      description:
                                          Text('Медкарта удачно создана'))
                                  .show(context);
                              await AppBloc.medCardCubit.fetchData();
                              await AppBloc.dangerousCubit.fetchData();
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: const LinearGradient(colors: [
                                  Color.fromRGBO(65, 73, 255, 1),
                                  Color.fromRGBO(41, 142, 235, 1),
                                ])),
                            child: Center(
                              child: Text(
                                'Создать',
                                style: AppStyle.txtMontserratf18w600,
                              ),
                            ),
                          ),
                        )),
                ],
              ),
              /* if(showDialog)
                Positioned(
                  top: topPosition,
                  child: CustomDialog(
                    onTap: (){
                      setState(() {
                        showDialog = false;
                      });
                    },
                    title: title, 
                    requestType: requestType, 
                    medcardId: medcardId, 
                    onChange: (response){
                      log('$response');
                      if (requestType == 'certificates') {
                        setState(() {
                          showDialog = false;
                        });
                      } else if(requestType == 'tests_results'){
                        
                      }else if(requestType == "doctor_reports"){
                        setState(() {

                          showDialog = false;
                        });
                      }
                    }
                  )
                ), */
              if (showRequest)
                SendRequest(
                  onYesTap: () async {
                    log(widget.medcardModel.id);
                    final response = await AppBloc.medCardCubit.shareCard(
                        widget.medcardModel.id, {"user_id": selectedUser!.id});
                    if (response.isSuccess) {
                      ElegantNotification.success(
                              description: Text(
                                  'Успешно поделились медицинской картой!'))
                          .show(context);
                      setState(() {
                        showRequest = false;
                        selectedUser = null;
                      });
                    }
                  },
                  onNoTap: () {
                    setState(() {
                      showRequest = false;
                      selectedUser = null;
                    });
                  },
                  myProfileName: widget.medcardModel.personalInfo.full_name,
                  sendToProfileName: selectedUser!.personalInfo.full_name,
                ),
              if (showSearch)
                Search(
                  onUserSelect: (user) {
                    setState(() {
                      selectedUser = user;
                      showSearch = false;
                      showRequest = true;
                    });
                  },
                  onCloseTap: () {
                    setState(() {
                      showSearch = false;
                    });
                  },
                ),
            ]),
          ),
        ));
  }
}

class CustomDialog extends StatefulWidget {
  final String title;
  final String requestType;
  final String medcardId;
  final bool docMode;
  final Function(ResponseModel) onChange;

  const CustomDialog({
    super.key,
    required this.title,
    required this.requestType,
    required this.medcardId,
    required this.onChange,
    this.docMode = false,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      // Russian language
    );

    if (pickedDate != null) {
    setState(() {
      dateController.text = 
          Intl.withLocale('ru', () => DateFormat('dd.MM.yyyy').format(pickedDate));
    });
  }
  }

  @override
  Widget build(BuildContext context) {
    File? file;

    return Dialog(
      shadowColor: Colors.white,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close),
                ),
              ),
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(221, 222, 226, 1),
                  filled: true,
                  hintText: widget.docMode ? 'Врач' : 'Наименование',
                  contentPadding: const EdgeInsets.all(16),
                  hintStyle: const TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: dateController,
                readOnly: true, // Prevent manual input
                onTap: () => _selectDate(context), // Show date picker on tap
                decoration: InputDecoration(
                  fillColor: const Color.fromRGBO(221, 222, 226, 1),
                  filled: true,
                  hintText: 'Дата',
                  contentPadding: const EdgeInsets.all(16),
                  hintStyle: const TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 12),
              Center(
                child: FileZone(
                  file: '',
                  onChange: (newFile) {
                    file = newFile;
                  },
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  final response = await AppBloc.medCardCubit.addMedInfo(
                    {
                      "item": widget.requestType,
                    },
                    {
                      "name": nameController.text,
                      "date": dateController.text,
                      "file": file != null
                          ? await MultipartFile.fromFile(file!.path)
                          : null
                    },
                    widget.medcardId,
                  );
                  log('${response.isSuccess}');
                  if (response.isSuccess) {
                    widget.onChange(
                      ResponseModel(
                        name: nameController.text,
                        date: dateController.text,
                        file: file?.path ?? '',
                      ),
                    );
                  }
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(41, 142, 235, 1),
                        Color.fromRGBO(65, 73, 255, 1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      'Добавить',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
