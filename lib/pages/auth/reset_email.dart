import 'dart:developer';

import 'package:careme24/blocs/app_bloc.dart';
import 'package:careme24/blocs/auth/cubit.dart';
import 'package:careme24/pages/auth/verify_code_reset_email_page.dart';
import 'package:careme24/pages/auth/verify_code_reset_page.dart';
import 'package:careme24/router/app_router.dart';
import 'package:careme24/theme/app_style.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ResetEmailPhonePage extends StatefulWidget {
  const ResetEmailPhonePage({super.key});

  @override
  State<ResetEmailPhonePage> createState() => _ResetEmailPhonePageState();
}

class _ResetEmailPhonePageState extends State<ResetEmailPhonePage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller_phone = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  String countryCode = '+7';
  bool isContinue = true;
  String controller= "";

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthResetSuccessState) {
            log('do');
             
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VerifyCodeResetMailPage(
                          phone: _controller_phone.text,
                          email: _controller.text,
                        )));
              
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 32, bottom: 8.0),
                        child: Text(
                          'Редактирование ',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .merge(const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.w700)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 26.0),
                        child: Text(
                          'Введите ваш новый email или номер телефона и действуйющий пароль',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      // Text('Email', style: TextStyle(color: Color.fromRGBO(164, 165, 165, 1), fontSize: 17, fontWeight: FontWeight.w700)),

                      // Container(
                      //   padding: const EdgeInsets.only(bottom: 16.0, top: 8),
                      //   child: TextFormField(
                      //     controller: _controllerEmail,
                      //     /* inputFormatters: [
                      //       MaskTextInputFormatter(
                      //           mask: '### ### ## ##',
                      //           filter: {"#": RegExp(r'[0-9]')},
                      //           type: MaskAutoCompletionType.lazy),
                      //     ], */
                      //     decoration: InputDecoration(
                      //       hintText: 'Введите email',
                      //       hintStyle: TextStyle(color: Color.fromRGBO(164, 165, 165, 1), fontSize: 16, fontWeight: FontWeight.w500),
                      //       contentPadding: EdgeInsets.all(8)
                      //      /*  prefixIcon: CountryCodePicker(
                      //         onChanged: (code) => setState(() {
                      //           countryCode = code.dialCode!;
                      //         }),
                      //         flagWidth: 29,
                      //         padding: EdgeInsets.zero,
                      //         initialSelection: 'RU',
                      //         favorite: const ['+39', 'FR'],
                      //       ), */
                      //     ),
                      //   ),
                      // ),

                      Text('Email',
                          style: TextStyle(
                              color: Color.fromRGBO(164, 165, 165, 1),
                              fontSize: 17,
                              fontWeight: FontWeight.w700)),

                      Container(
                        padding: const EdgeInsets.only(bottom: 16.0, top: 8),
                        child: TextFormField(
                          controller: _controller,
                          /* inputFormatters: [
                            MaskTextInputFormatter(
                                mask: '### ### ## ##',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy),
                          ], */
                          decoration: InputDecoration(
                              hintText: 'Введите email',
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(164, 165, 165, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              contentPadding: EdgeInsets.all(8)
                              /*  prefixIcon: CountryCodePicker(
                              onChanged: (code) => setState(() {
                                countryCode = code.dialCode!;
                              }),
                              flagWidth: 29,
                              padding: EdgeInsets.zero,
                              initialSelection: 'RU',
                              favorite: const ['+39', 'FR'],
                            ), */
                              ),
                        ),
                      ),
                      Text('Номер телефона',
                          style: TextStyle(
                              color: Color.fromRGBO(164, 165, 165, 1),
                              fontSize: 17,
                              fontWeight: FontWeight.w700)),

                      Container(
                        padding: const EdgeInsets.only(bottom: 16.0, top: 8),
                        child: TextFormField(
                          controller: _controller_phone,
                          inputFormatters: [
                            MaskTextInputFormatter(
                                mask: '### ### ## ##',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy),
                          ], 
                          decoration: InputDecoration(
                              hintText: 'Введите телефон',
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(164, 165, 165, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              contentPadding: EdgeInsets.all(8),
                               prefixIcon: CountryCodePicker(
                              onChanged: (code) => setState(() {
                                countryCode = code.dialCode!;
                              }),
                              flagWidth: 29,
                              padding: EdgeInsets.zero,
                              initialSelection: 'RU',
                              favorite: const ['+39', 'FR'],
                            ), 
                              ),
                        ),
                      ),
                      Text('Пароль',
                          style: TextStyle(
                              color: Color.fromRGBO(164, 165, 165, 1),
                              fontSize: 17,
                              fontWeight: FontWeight.w700)),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              hintText: 'Введите ваш действуйщий пароль',
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(164, 165, 165, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                      Padding(
  padding: const EdgeInsets.only(top: 62.0),
  child: GestureDetector(
    onTap: () async {
      // Construct the phone number with the country code
      String phoneNumber = '$countryCode ${_controller_phone.text}'.replaceAll(" ", "");
      
      // Check if both fields are empty and show an error
      if (_controller.text.isEmpty && _controller_phone.text.isEmpty) {
        ElegantNotification.error(
          description: Text('Введите Email или номер телефона')).show(context);
        return;
      }

      // Proceed to reset email or phone
      dynamic response;

      if (_controller.text.isNotEmpty) {
        // If email is entered
        context.read<AuthCubit>().resetEmailOrPhone(_controller.text.trim());
      } else {
        // If phone number is entered
         context.read<AuthCubit>().resetEmailOrPhone(phoneNumber);
      }

      // Handle the response (you can replace the code below based on your requirements)
      if (response != null && response['status'] == 'success') {
        // Handle successful response here
      } else {
        ElegantNotification.error(
          description: Text('Неверные данные')).show(context);
      }
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(65, 73, 255, 1),
          Color.fromRGBO(41, 142, 235, 1),
        ]),
      ),
      child: Center(
        child: Text(
          'Продолжить',
          style: AppStyle.txtMontserratf18w600,
        ),
      ),
    ),
  ),
),

                      SizedBox(height: MediaQuery.of(context).size.height /10),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRouter.editEmail);
                        },
                        child: Text(
                          'Изменить пароль',
                          style: Theme.of(context).textTheme.bodyMedium!.merge(
                                TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
