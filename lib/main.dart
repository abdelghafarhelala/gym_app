import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gym_app/modules/layoutScreen/layoutScreen.dart';
import 'package:gym_app/modules/login/login.dart';
import 'package:gym_app/modules/on_boarding/onBoardingScreen.dart';
import 'package:gym_app/network/local/cache_Helper.dart';
import 'package:gym_app/network/remote/dio_helper.dart';
import 'package:gym_app/shared/appCubit/app_cubit.dart';
import 'package:gym_app/shared/appCubit/app_states.dart';
import 'package:gym_app/shared/blocObserver/blocObserver.dart';
import 'package:gym_app/shared/const.dart';
import 'package:gym_app/shared/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await DioHelper.init();
  Widget startWidget;
  bool isDark = false;
  token = CacheHelper.getData(key: 'token');
  bool? onboarding = CacheHelper.getData(key: 'onBoarding');
  if (CacheHelper.getData(key: 'isDark') != null) {
    isDark = CacheHelper.getData(key: 'isDark');
  } else {
    isDark = isDark;
  }
  print(token);
  if (onboarding != null) {
    if (token != null) {
      startWidget = LayoutScreen();
    } else {
      startWidget = LayoutScreen();
    }
  } else {
    startWidget = OnBoardingScreen();
  }
  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(MyApp(
        isDark: isDark,
        startWidget: startWidget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  MyApp({required this.isDark, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getFoodAdvicesData()
        ..getTrainAdvicesData()
        ..getUserData()
        ..getTrainingData()
        ..getTrainAndOffersData(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ar', ''), // arabic, no country code
              ],
              debugShowCheckedModeBanner: false,
              locale: const Locale('ar'),
              title: 'home',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              // home: TrainingScreen(),
              home: startWidget,
            );
          }),
    );
  }
}
