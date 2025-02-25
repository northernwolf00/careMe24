// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:careme24/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PersonalInfoAboutWidget extends StatefulWidget {
  final TextEditingController date;
  final TextEditingController countryAndAddres;
  final TextEditingController serial;
  final TextEditingController number;
  final TextEditingController place;
  final TextEditingController data;

  const PersonalInfoAboutWidget({
    super.key,
    required this.date,
    required this.countryAndAddres,
    required this.number,
    required this.serial,
    required this.place,
    required this.data,
  });

  @override
  State<PersonalInfoAboutWidget> createState() =>
      _PersonalInfoAboutWidgetState();
}

class _PersonalInfoAboutWidgetState extends State<PersonalInfoAboutWidget> {

  final dateFormatter = MaskTextInputFormatter(
    mask: '##.##.####', // Format: DD.MM.YYYY
    filter: {"#": RegExp(r'[0-9]')},
  );

  final passportSerialFormatter = MaskTextInputFormatter(
    mask: 'AA #######', // Adjust for your passport format
    filter: {
      "A": RegExp(r'[A-Za-z]'),
      "#": RegExp(r'[0-9]')
    },
  );

  final passportNumberFormatter = MaskTextInputFormatter(
    mask: '#########', // Adjust according to passport format
    filter: {"#": RegExp(r'[0-9]')},
  );

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      String formattedDate = "${pickedDate.day.toString().padLeft(2, '0')}"
          ".${pickedDate.month.toString().padLeft(2, '0')}"
          ".${pickedDate.year}";
      setState(() {
        controller.text = formattedDate;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

             GestureDetector(
            onTap: () => _selectDate(context, widget.date),
            child: AbsorbPointer(
              child: CustomTextField(
                keyboardType: TextInputType.number,
                controller: widget.date,
                hintText: 'Дата рождения',
                color: Colors.black,
                inputFormatters: [dateFormatter],
              ),
            ),
          ),
          CustomTextField(
            controller: widget.countryAndAddres,
            hintText: 'Адрес',
            color: Colors.black,
          ),
          CustomTextField(
            keyboardType: TextInputType.text,
            controller: widget.serial,
            hintText: 'Серия паспорта',
            color: const Color(0xff2C3E4F),
            // inputFormatters: [passportSerialFormatter],
          ),
          CustomTextField(
            keyboardType: TextInputType.number,
            controller: widget.number,
            hintText: 'Номер паспорта',
            color: const Color(0xff2C3E4F),
            inputFormatters: [passportNumberFormatter],
          ),
          CustomTextField(
            controller: widget.place,
            hintText: 'Место выдачи',
            color: const Color(0xff2C3E4F),
          ),
          GestureDetector(
            onTap: () => _selectDate(context, widget.data),
            child: AbsorbPointer(
              child: CustomTextField(
                keyboardType: TextInputType.number,
                controller: widget.data,
                hintText: 'Дата выдачи',
                color: const Color(0xff2C3E4F),
                inputFormatters: [dateFormatter],
              ),
            ),
          ),
            // CustomTextField(
            //   keyboardType: TextInputType.number,
            //   controller: widget.date, hintText: 'Дата рождения', color: Colors.black),
            // CustomTextField(
            //   controller: widget.countryAndAddres,
            //   hintText: 'Адрес', 
            //   color: Colors.black
            // ),
            // CustomTextField(
            //   keyboardType: TextInputType.number,
            //   controller: widget.serial, 
            //   hintText: 'Cерия паспорта', 
            //   color: const Color(0xff2C3E4F)
            // ),
            // CustomTextField(
            //   keyboardType: TextInputType.number,
            //   controller: widget.number, 
            //   hintText: 'Номер паспорта', 
            //   color: const Color(0xff2C3E4F)
            // ),
            // CustomTextField(
            //   controller: widget.place, 
            //   hintText: 'Место выдачи', 
            //   color: const Color(0xff2C3E4F)
            // ),
            // CustomTextField(
            //   keyboardType: TextInputType.number,
            //   controller: widget.data, 
            //   hintText: 'Дата выдачи', 
            //   color: const Color(0xff2C3E4F)
            // ),
        /*    Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/icon-plus.png',
                  width: 12,
                  height: 12,
                  color: const Color(0xff2C3E4F),
                ),
                const SizedBox(width: 5,),
                const Text(
                  'Добавить файл',
                  style: TextStyle(
                    color: Color(0xff2C3E4F),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'документы',
              style: TextStyle(
                color: Color(0xff2C3E4F),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/icon-plus.png',
                  color: const Color(0xff2C3E4F),
                  width: 12,
                  height: 12,
                ),
                const SizedBox(width: 5,),
                const Text(
                  'Добавить файл',
                  style: TextStyle(
                    color: Color(0xff2C3E4F),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ), */
          ],
        ));
  }
}
