import 'dart:developer';

import 'package:careme24/blocs/blocs.dart';
import 'package:careme24/blocs/drawer/drawer_cubit.dart';
import 'package:careme24/router/app_router.dart';
import 'package:careme24/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    AppBloc.applicationCubit.onSetup();
  
    super.initState();
  }

  // Initialize Firebase and FCM


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: AppBloc.providers,
        child: BlocBuilder<ApplicationCubit, ApplicationState>(
          builder: (context, state) {
            if (state is ApplicationCompleted) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                supportedLocales: const [
                  Locale('ru'), // Russian
                ],
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                theme: AppTheme.theme,
                // initialRoute:
                //      state.isAuthorized
                //         ? AppRouter.appContainer
                //         : AppRouter.startPage,

                initialRoute: state.error
                    ? AppRouter.errorScreen
                    : state.isAuthorized
                        ? AppRouter.appContainer
                        : AppRouter.startPage,
                routes: AppRouter.routes,
              );
            } else {
              return Container(
                  color: Colors.white,
                  child: const Center(
                      child: CircularProgressIndicator.adaptive()));
            }
          },
        ));
  }
}
