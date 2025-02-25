import 'package:careme24/blocs/app_bloc.dart';
import 'package:flutter/material.dart';

class AuthError extends StatelessWidget {
  const AuthError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              'Не удалось авторизоваться. Пожалуйста, попробуйте снова.', 
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: (){
                AppBloc.applicationCubit.onSetup();
              },
              child: Container(
                margin: EdgeInsets.only(left: 21, right: 25, top: 95),
                padding: EdgeInsets.symmetric(vertical: 19.5),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(41, 142, 235, 1),
                      Color.fromRGBO(65, 73, 255, 1),
                    ]
                  )
                ),
                child: Center(child: Text('Авторизоваться', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}