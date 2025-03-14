import 'dart:developer';

import 'package:careme24/blocs/app_bloc.dart';
import 'package:careme24/blocs/auth/cubit.dart';
import 'package:careme24/router/app_router.dart';
import 'package:careme24/theme/app_style.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  String countryCode = '+7';
  bool isContinue = true;
  bool isPhoneNumber = false;

  final phoneMaskFormatter = MaskTextInputFormatter(
    mask: '### ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

void _onInputChanged(String value) {
  bool isNowPhoneNumber = RegExp(r'^\d').hasMatch(value);

  if (isNowPhoneNumber != isPhoneNumber) {
    setState(() {
      isPhoneNumber = isNowPhoneNumber;
      _controller.clear(); 
    });
  }
}




  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthCodeState) {
            log('do');
            state.data.isSuccess
                ? Navigator.pushNamed(context, AppRouter.verificationPage)
                : null;
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
                          'Вход',
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
                          'Мы отправим на номер SMS-сообщение с кодом подтверждения.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Text('Почта или номер телефона',
                          style: TextStyle(
                              color: Color.fromRGBO(164, 165, 165, 1),
                              fontSize: 17,
                              fontWeight: FontWeight.w700)),
                      Container(
                          padding: const EdgeInsets.only(bottom: 16.0, top: 8),
                          child: TextFormField(
                            controller: _controller,
                            keyboardType: TextInputType.text,
                            inputFormatters:
                                isPhoneNumber ? [phoneMaskFormatter] : [],
                            onChanged: _onInputChanged,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(164, 165, 165, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              hintText: isPhoneNumber
                                  ? '000 000 00 00'
                                  : 'Почта или номер телефона',
                              prefixIcon: isPhoneNumber
                                  ? CountryCodePicker(
                                      onChanged: (code) => setState(() {
                                        countryCode = code.dialCode!;
                                      }),
                                      flagWidth: 29,
                                      padding: EdgeInsets.zero,
                                      initialSelection: 'RU',
                                      favorite: const ['+39', 'FR'],
                                    )
                                  : null,
                            ),
                          )

                         
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
                              hintText: 'Пароль',
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
                              String inputText = _controller.text.trim();
                              String phoneNumber =
                                  '$countryCode $inputText'.replaceAll(" ", "");

                              final response = await AppBloc.authCubit.login(
                                  isPhoneNumber ? phoneNumber : inputText,
                                  _passwordController.text);

                              if (!response.isSuccess) {
                                ElegantNotification.error(
                                        description: Text('Неверные данные'))
                                    .show(context);
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
                                  'Получить код',
                                  style: AppStyle.txtMontserratf18w600,
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 6.5),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text('Нет аккаунта?',
                                  style: TextStyle(
                                      color: Color.fromRGBO(28, 29, 30, 1),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600)),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRouter.registerEmailPage);
                              },
                              child: Text(
                                'Зарегистрироваться',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .merge(
                                      TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //     Navigator.pushNamed(context, AppRouter.resetEmailPhone);
                      //   },
                      //   child: Text(
                      //     'Изменить email или номер телефона',
                      //     style: Theme.of(context).textTheme.bodyMedium!.merge(
                      //           TextStyle(
                      //             fontSize: 15,
                      //             fontWeight: FontWeight.w700,
                      //             color: Theme.of(context).primaryColor,
                      //           ),
                      //         ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
