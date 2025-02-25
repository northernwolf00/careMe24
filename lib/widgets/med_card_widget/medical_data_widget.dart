import 'dart:io';

import 'package:careme24/theme/app_style.dart';
import 'package:careme24/widgets/custom_text_field.dart';
import 'package:careme24/widgets/file_piceker.dart';
import 'package:flutter/material.dart';

class MedicalDataWidget extends StatefulWidget {
  final TextEditingController bloodTypeController;
  final TextEditingController numberPoliceController;
  final TextEditingController insuranceNumberController;
  final TextEditingController validityPeriodController;
  final TextEditingController insuranceNameController;
  final String file;
  final Function() onTap;
  final Function(File) onChange;
  final bool showInsurance;
  
  const MedicalDataWidget({
    super.key,
    required this.bloodTypeController,
    required this.numberPoliceController,
    required this.insuranceNumberController,
    required this.validityPeriodController,
    required this.file,
    required this.insuranceNameController,
    required this.onTap,
    required this.onChange,
    this.showInsurance = true,
  });

  @override
  State<MedicalDataWidget> createState() => _MedicalDataWidgetState();
}

class _MedicalDataWidgetState extends State<MedicalDataWidget> {
  bool isVisibality = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(29, 15, 17, 17),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: const Color(0xffB3B3B3))),
      child: Column(
        children: <Widget>[
          const Text(
            'Медицинские данные',
            style: TextStyle(
              color: Color(0xff5CA2C8),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          if(!widget.showInsurance)
            Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 27),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isVisibality = !isVisibality;
                    print(isVisibality);
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
                      )),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  const Text(
                      'Группа крови',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const SizedBox(width: 20),
                  Expanded(
                      child: CustomTextField(
                      controller: widget.bloodTypeController, 
                      hintText: 'Группа крови', 
                      color: Colors.black
                    )
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                      'Номер полиса',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const SizedBox(width: 20),
                  Expanded(
                      child: CustomTextField(
                      controller: widget.numberPoliceController, 
                      hintText: 'Номер полиса', 
                      color: Colors.black
                    )
                  ),
                ],
              ),
            ],
          ),
          if (isVisibality && !widget.showInsurance)
            Column(
              children: [
                const Text(
                  'Медицинская страховка',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(36, 0, 0, 1)
                  ),
                ),
                Row(
                children: [
                  const Text(
                    'Номер',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomTextField(
                      controller: widget.insuranceNumberController, 
                      hintText: 'Номер', 
                      color: Colors.black
                    )
                  )
                ],
              ),
                Row(
                children: [
                  const Text(
                    'Срок действия',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomTextField(
                      controller: widget.validityPeriodController, 
                      hintText: 'Срок действия', 
                      color: Colors.black
                    )
                  )
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Наименование\nстраховой\nкомпании',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomTextField(
                      controller: widget.insuranceNameController, 
                      hintText: 'Наименование страховой компании', 
                      color: Colors.black
                    )
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Фото',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 20),
                  FileZone(
                    file: widget.file, 
                    onChange: (file){
                      widget.onChange(file);
                  },)
                ],
              ),
              if(isVisibality && !widget.showInsurance)
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 24),
                  child: GestureDetector(
                    onTap: widget.onTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(65, 73, 255, 1),
                            Color.fromRGBO(41, 142, 235, 1),
                          ]
                        )
                      ),
                      child: Center(
                        child: Text(
                          'Обновить данные',
                          style: AppStyle.txtMontserratf18w600,
                        ),
                      ),
                    ),
                  )  
                ),  
            ],
          )
        ],
      ),
    );
  }
}