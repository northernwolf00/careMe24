import 'dart:io';

import 'package:careme24/theme/app_style.dart';
import 'package:careme24/widgets/custom_text_field.dart';
import 'package:careme24/widgets/files_zone.dart';
import 'package:careme24/widgets/med_card_widget/personal_info_about_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PersonalInfoWidget extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController numberController;
  final TextEditingController countryAndAddresController;
  final TextEditingController dateController;
  final TextEditingController passportNumberController;
  final TextEditingController passportSerialController;
  final TextEditingController passportPlaceController;
  final TextEditingController passportDataController;
  final List<String> files;
  final bool createMode;
  final Function(List<File>?) onChange;
  final Function() onTap;

  const PersonalInfoWidget({
    required this.nameController,
    required this.numberController,
    required this.countryAndAddresController,
    required this.dateController,
    required this.passportNumberController,
    required this.passportSerialController,
    required this.passportPlaceController,
    required this.passportDataController,
    required this.onChange,
    required this.files,
    required this.onTap,
    this.createMode = false,
    super.key,
  });

  @override
  State<PersonalInfoWidget> createState() => _PersonalInfoWidgetState();
}

class _PersonalInfoWidgetState extends State<PersonalInfoWidget> {
  bool isVisibality = false;
  List<File> selectedFiles = [];

  final maskFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####', // Adjust mask as needed
    filter: {"#": RegExp(r'[А-Яа-яA-Za-z]')}, // Allows only letters
    type: MaskAutoCompletionType.lazy,
  );
  String countryCode = '+7';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(29, 15, 17, 17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xffB3B3B3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Личные данные',
            style: TextStyle(
              color: Color(0xff5CA2C8),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: [
              //Expanded(flex: 1, child: Image.asset('assets/images/person.png')),
              //const SizedBox(width: 20),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: widget.nameController,
                      cursorColor: Colors.black,
                      inputFormatters: [maskFormatter],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: 'ФИО',
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isVisibality = !isVisibality;
                        });
                      },
                      child: isVisibality
                          ? Image.asset(
                              'assets/images/Vector 177.png',
                              width: 24,
                              height: 15,
                            )
                          : Image.asset(
                              'assets/images/arrow_down.png',
                            ))),
            ],
          ),
          TextFormField(
            controller: widget.numberController,
            inputFormatters: [
              MaskTextInputFormatter(
                mask: '### ### ## ##',
                filter: {"#": RegExp(r'[0-9]')},
                type: MaskAutoCompletionType.lazy,
              ),
            ],
            decoration: InputDecoration(
              hintText: 'Номер телефона',
              isDense: true, // Ensures compact spacing
              contentPadding: EdgeInsets.symmetric(
                  vertical: 12.0), // Adjust vertical padding
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              prefixIcon: IntrinsicWidth(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CountryCodePicker(
                      onChanged: (code) => setState(() {
                        countryCode = code.dialCode!;
                      }),
                      padding: EdgeInsets.zero,
                      showFlag: false, // Hide the flag
                      showFlagDialog: false,
                      initialSelection: 'RU',
                      favorite: const ['+39', 'FR'],
                      textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black), // Ensure uniform text size
                    ),
                  
                  ],
                ),
              ),
            ),
          ),

          // CustomTextField(
          //   controller: widget.numberController,
          //   hintText: 'Номер телефона',
          //   color: Colors.black,
          //   keyboardType: TextInputType.number,
          // ),
          if (isVisibality)
            PersonalInfoAboutWidget(
              countryAndAddres: widget.countryAndAddresController,
              date: widget.dateController,
              serial: widget.passportSerialController,
              number: widget.passportNumberController,
              place: widget.passportPlaceController,
              data: widget.passportDataController,
            ),
          if (isVisibality)
            FilesZone(
                files: widget.files,
                onChange: (files) {
                  setState(() {
                    selectedFiles = files;
                  });

                  widget.onChange(selectedFiles);
                }),
          if (isVisibality && !widget.createMode)
            Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 24),
                child: GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(colors: [
                          Color.fromRGBO(65, 73, 255, 1),
                          Color.fromRGBO(41, 142, 235, 1),
                        ])),
                    child: Center(
                      child: Text(
                        'Обновить данные',
                        style: AppStyle.txtMontserratf18w600,
                      ),
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
