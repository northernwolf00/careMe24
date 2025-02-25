import 'package:careme24/blocs/app_bloc.dart';
import 'package:careme24/blocs/auth/cubit.dart';
import 'package:careme24/router/app_router.dart';
import 'package:careme24/theme/app_style.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationEmailPage extends StatefulWidget {
  const RegistrationEmailPage({super.key});

  @override
  State<RegistrationEmailPage> createState() => _RegistrationEmailPageState();
}

class _RegistrationEmailPageState extends State<RegistrationEmailPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String countryCode = '+7';
  bool isContinue = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthCodeState) {
          state.data.isSuccess
              ? Navigator.pushNamed(context, AppRouter.verificationPage)
              : null;
        }
      },
      child: Scaffold(
        body: Container(
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
                      'Регистрация',
                      style: Theme.of(context).textTheme.headlineSmall!.merge(
                          const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 26.0),
                    child: Text(
                      'Введите ваш email и придумайте пароль',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Text('Email',
                      style: TextStyle(
                          color: Color.fromRGBO(164, 165, 165, 1),
                          fontSize: 17,
                          fontWeight: FontWeight.w700)),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: 'Введите email',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(164, 165, 165, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
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
                          hintText: 'Придумайте пароль',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(164, 165, 165, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        'Пароль должен состоять минимум из 6 символов',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(173, 173, 173, 1)),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          if (_passwordController.text.length < 6) {
                            ElegantNotification.error(
                                    description: Text(
                                        'Пароль должен состоять минимум из 6 символов'))
                                .show(context);
                          } else if (!EmailValidator.validate(
                              _emailController.text)) {
                            ElegantNotification.error(
                                    description:
                                        Text('Введите корректный email'))
                                .show(context);
                          } else {
                            AppBloc.authCubit.setEmailPassword(
                                _emailController.text,
                                _passwordController.text);
                            Navigator.pushNamed(
                                context, AppRouter.registerPage);
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
                              'Продолжить',
                              style: AppStyle.txtMontserratf18w600,
                            ),
                          ),
                        ),
                      )),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text(
                            'Уже есть аккаунт?',
                            style: TextStyle(
                              color: Color.fromRGBO(28, 29, 30, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                              context, AppRouter.loginPage),
                          style: TextButton.styleFrom(
                            // Add padding to increase clickable area
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            // Ensure minimum touch target size
                            minimumSize: const Size(48, 36),
                            // Align the text properly within the button
                            alignment: Alignment.center,
                          ),
                          child: Text(
                            'Войти',
                            style:
                                Theme.of(context).textTheme.bodyMedium!.merge(
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
