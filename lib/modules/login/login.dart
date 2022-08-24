import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/modules/forget_password/forget_password.dart';
import 'package:gym_app/modules/layoutScreen/layoutScreen.dart';
import 'package:gym_app/modules/login/loginCubit/loginCubit.dart';
import 'package:gym_app/modules/login/loginCubit/loginStates.dart';
import 'package:gym_app/modules/register/register.dart';
import 'package:gym_app/network/local/cache_Helper.dart';
import 'package:gym_app/shared/appCubit/app_cubit.dart';
import 'package:gym_app/shared/colors.dart';
import 'package:gym_app/shared/components/components.dart';
import 'package:gym_app/shared/const.dart';
import 'package:hexcolor/hexcolor.dart';

var phoneController = TextEditingController();
var passwordController = TextEditingController();
RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
bool validatePassword(String pass) {
  String _password = pass.trim();
  if (pass_valid.hasMatch(_password)) {
    return true;
  } else {
    return false;
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.model?.result == true) {
              CacheHelper.saveData(
                      key: "token", value: state.model?.success?.token)
                  .then((value) {
                token = state.model?.success?.token;

                AppCubit.get(context).getFoodAdvicesData();
                AppCubit.get(context).getTrainAdvicesData();
                AppCubit.get(context).getUserData();
                AppCubit.get(context).getTrainAndOffersData();
                AppCubit.get(context).currentIndex = 2;
                navigateAndFinish(context, LayoutScreen());

                showToast(
                    text: 'تم تسجيل الدخول بنجاح', state: ToastStates.success);
                // print(state.model?.data!.name);
              });
            } else {
              showToast(
                  text: state.model?.errorMessage, state: ToastStates.error);
            }
          }
        },
        builder: (context, state) {
          double screenHeight = MediaQuery.of(context).size.height;
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                // For Android.
                // Use [light] for white status bar and [dark] for black status bar.
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white,
                // For iOS.
                // Use [dark] for white status bar and [light] for black status bar.
                statusBarBrightness: Brightness.dark,
              ),
              child: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: AppCubit.get(context).formKeyLogin,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              SizedBox(height: screenHeight / 22),
                              Stack(
                                alignment: Alignment.topLeft,
                                children: [
                                  Image.asset(
                                    'assets/images/login.png',
                                    height: screenHeight / 4,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        AppCubit.get(context).currentIndex = 2;
                                        navigateTo(context, LayoutScreen());
                                      },
                                      child: const Text(
                                        'الصفحه الرئيسيه',
                                        style: TextStyle(fontSize: 18),
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: screenHeight / 40,
                              ),
                              const Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w700),
                              ),

                              // Text('تسجيل الدخول ',
                              //     style: Theme.of(context).textTheme.bodyText1),
                              SizedBox(
                                height: screenHeight / 57,
                              ),
                              Card(
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                elevation: 1.5,
                                child: defaultTextField(
                                    lable: 'البريد الإلكتروني',
                                    controller: phoneController,
                                    prefix: Icons.email_outlined,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'البريد الإلكتروني مطلوب';
                                      }
                                    },
                                    context: context,
                                    type: TextInputType.emailAddress),
                              ),
                              SizedBox(
                                height: screenHeight / 68,
                              ),
                              Card(
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                elevation: 1.5,
                                child: defaultTextField(
                                    controller: passwordController,
                                    lable: 'كلمه السر ',
                                    prefix: Icons.lock_outline,
                                    suffix: LoginCubit.get(context).suffix,
                                    suffixPressed: () {
                                      LoginCubit.get(context)
                                          .changePasswordVisibility();
                                    },
                                    isSecure: LoginCubit.get(context).isPass,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return ' كلمة السر مطلوبة ';
                                      } else {
                                        bool result = validatePassword(value);
                                        // if (result) {
                                        //   if (value.length < 8) {
                                        //     return " Password should at least 8 character";
                                        //   }
                                        // } else {
                                        //   return "Password should contain Capital,small letter ,\n Number & Special character";
                                        // }
                                      }
                                    },
                                    context: context,
                                    type: TextInputType.visiblePassword),
                              ),
                              SizedBox(
                                height: screenHeight / 68,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        navigateTo(
                                            context, ForgetPasswordScreen());
                                      },
                                      child: Text(
                                        'نسيت كلمة السر ؟',
                                        style: TextStyle(
                                          color: HexColor('#707070'),
                                          fontSize: 16,
                                        ),
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: screenHeight / 70,
                              ),
                              ConditionalBuilder(
                                condition: state is! LoginLoadingState,
                                builder: (context) => defaultButton(
                                    fontSize: 22,
                                    height: screenHeight / 18,
                                    onPress: () {
                                      if (AppCubit.get(context)
                                          .formKeyLogin
                                          .currentState!
                                          .validate()) {
                                        LoginCubit.get(context).userLogin(
                                            phone: phoneController.text,
                                            password: passwordController.text,
                                            context: context);
                                      } else {}
                                    },
                                    text: 'تسجيل الدخول'),
                                fallback: (context) => const Center(
                                    child: CircularProgressIndicator()),
                              ),

                              SizedBox(
                                height: screenHeight / 35,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 40,
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    child: Text(
                                      'أو',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 40,
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight / 30),
                              MaterialButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                hoverColor: primaryColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(27.0)),
                                    side: BorderSide(color: primaryColor)),
                                color: Colors.white,
                                minWidth: double.infinity,
                                height: screenHeight / 18,
                                textColor: Colors.black,
                                child: const Text(
                                  ' حساب جديد',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
