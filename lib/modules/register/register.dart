import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/modules/login/login.dart';
import 'package:gym_app/modules/register/registerCubit/registerCubit.dart';
import 'package:gym_app/network/local/cache_Helper.dart';
import 'package:gym_app/shared/appCubit/app_cubit.dart';
import 'package:gym_app/shared/components/components.dart';
import 'package:gym_app/shared/const.dart';

import 'registerCubit/registerStates.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.model?.result == true) {
              showToast(
                  text: state.model?.errorMessage, state: ToastStates.success);
              navigateAndFinish(context, const LoginScreen());
              // print(state.model?.user!.name);

            } else {
              showToast(
                  text: state.model?.errorMessage, state: ToastStates.error);
            }
          } else if (state is RegisterErrorState) {
            showToast(text: 'This data is invalid', state: ToastStates.error);
          }
        },
        builder: (context, state) {
          double screenHeight = MediaQuery.of(context).size.height;
          return Scaffold(
            // resizeToAvoidBottomInset: false,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white,
                statusBarBrightness: Brightness.dark,
              ),
              child: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: AppCubit.get(context).formKeyRegister,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.network(
                              'https://img.freepik.com/free-vector/businessman-holding-pencil-big-complete-checklist-with-tick-marks_1150-35019.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357',
                              height: 170,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back))
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'انشاء حساب جديد ',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontSize: 24),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight / 34),
                          child: Column(
                            children: [
                              Card(
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                elevation: 1.5,
                                child: defaultTextField(
                                    lable: 'الإسم',
                                    controller: AppCubit.get(context)
                                        .registerNameController,
                                    prefix: Icons.person_outline,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'يجب أن تدخل الإسم';
                                      }
                                    },
                                    context: context,
                                    type: TextInputType.text),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Card(
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                elevation: 1.5,
                                child: defaultTextField(
                                    formats: [
                                      LengthLimitingTextInputFormatter(11),
                                    ],
                                    lable: 'رقم الهاتف',
                                    controller: AppCubit.get(context)
                                        .registerPhoneController,
                                    prefix: Icons.phone_iphone,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'يجب أن تدخل رقم الهاتف';
                                      }
                                    },
                                    context: context,
                                    type: TextInputType.phone),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Card(
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                elevation: 1.5,
                                child: defaultTextField(
                                    lable: 'البريد الإلكتروني',
                                    controller: AppCubit.get(context)
                                        .registerEmailController,
                                    prefix: Icons.email_outlined,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'يجب أن تدخل البريد الإلكتروني';
                                      }
                                    },
                                    context: context,
                                    type: TextInputType.emailAddress),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: RadioListTile(
                                      title: Text("ذكر"),
                                      value: "A",
                                      groupValue:
                                          AppCubit.get(context).registerGender,
                                      onChanged: (value) {
                                        setState(() {
                                          AppCubit.get(context).registerGender =
                                              value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      title: Text("انثي"),
                                      value: "B",
                                      groupValue:
                                          AppCubit.get(context).registerGender,
                                      onChanged: (value) {
                                        setState(() {
                                          AppCubit.get(context).registerGender =
                                              value.toString();
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Card(
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                elevation: 1.5,
                                child: defaultTextField(
                                    controller: AppCubit.get(context)
                                        .registerPasswordController,
                                    lable: 'كلمة السر ',
                                    prefix: Icons.lock_outline,
                                    suffix: RegisterCubit.get(context).suffix,
                                    suffixPressed: () {
                                      RegisterCubit.get(context)
                                          .changePasswordVisibility();
                                    },
                                    isSecure: RegisterCubit.get(context).isPass,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'يجب أن تدخل كلمة السر';
                                      }
                                    },
                                    context: context,
                                    type: TextInputType.visiblePassword),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              ConditionalBuilder(
                                condition: state is! RegisterLoadingState,
                                builder: (context) => defaultButton(
                                    height: screenHeight / 16,
                                    onPress: () {
                                      if (AppCubit.get(context)
                                          .formKeyRegister
                                          .currentState!
                                          .validate()) {
                                        RegisterCubit.get(context).userRegister(
                                          email: AppCubit.get(context)
                                              .registerEmailController
                                              .text,
                                          phone: AppCubit.get(context)
                                              .registerPhoneController
                                              .text,
                                          name: AppCubit.get(context)
                                              .registerNameController
                                              .text,
                                          password: AppCubit.get(context)
                                              .registerPasswordController
                                              .text,
                                          sex: AppCubit.get(context)
                                                  .registerGender ??
                                              'A',
                                        );
                                      } else {}
                                    },
                                    text: 'انشاء حساب'),
                                fallback: (context) => const Center(
                                    child: CircularProgressIndicator()),
                              ),
                              const SizedBox(
                                height: 50,
                              )
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
