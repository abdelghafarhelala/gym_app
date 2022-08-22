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

String? gender = 'A';
var emailController = TextEditingController();
var hightController = TextEditingController();
var illController = TextEditingController();
var detailsController = TextEditingController();
var wightController = TextEditingController();
var nameController = TextEditingController();
var phoneController = TextEditingController();
var passwordController = TextEditingController();
var confirmPasswordController = TextEditingController();
var formKeyRegister = GlobalKey<FormState>();

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
              CacheHelper.saveData(
                      key: "token", value: state.model?.success?.token)
                  .then((value) {
                token = state.model?.success?.token;
                AppCubit.get(context).getUserData();
                showToast(
                    text: state.model?.errorMessage,
                    state: ToastStates.success);
                navigateAndFinish(context, const LoginScreen());
                // print(state.model?.user!.name);
              });
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
            resizeToAvoidBottomInset: false,
            // appBar: AppBar(
            //   centerTitle: true,
            //   backgroundColor: Colors.white,
            //   elevation: 0,
            //   iconTheme: IconThemeData(color: Colors.black),
            //   systemOverlayStyle: const SystemUiOverlayStyle(
            //     statusBarIconBrightness: Brightness.dark,
            //     statusBarColor: Colors.white,
            //   ),
            //   title: const Text(
            //     'حساب جديد ',
            //     style: TextStyle(color: Colors.black),
            //   ),
            // ),
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
                    key: formKeyRegister,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset(
                              'assets/images/register.jpg',
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
                                    controller: nameController,
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
                                    controller: phoneController,
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
                                    controller: emailController,
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
                              Card(
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                elevation: 1.5,
                                child: defaultTextFieldWithCustomIconImage(
                                    lable: 'الطول',
                                    controller: hightController,
                                    prefix: const ImageIcon(
                                        AssetImage("assets/images/height.png")),
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'يجب أن تدخل الطول';
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
                                child: defaultTextFieldWithCustomIconImage(
                                    lable: 'الوزن',
                                    controller: wightController,
                                    prefix: const ImageIcon(
                                        AssetImage("assets/images/height.png")),
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'يجب أن تدخل الوزن';
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
                                child: defaultTextFieldWithCustomIconImage(
                                    lable: 'الأمراض',
                                    controller: illController,
                                    prefix: const ImageIcon(
                                        AssetImage("assets/images/sick.png")),
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'يجب أن تدخل الأمراض';
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
                                child: defaultTextFieldWithCustomIconImage(
                                    lable: 'الملاحظات',
                                    controller: detailsController,
                                    prefix: const ImageIcon(
                                        AssetImage("assets/images/height.png")),
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'يجب أن تدخل الملاحظات';
                                      }
                                    },
                                    context: context,
                                    type: TextInputType.text),
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
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      title: Text("انثي"),
                                      value: "B",
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value.toString();
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
                                    controller: passwordController,
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
                                height: 15,
                              ),
                              ConditionalBuilder(
                                condition: state is! RegisterLoadingState,
                                builder: (context) => defaultButton(
                                    height: screenHeight / 16,
                                    onPress: () {
                                      if (formKeyRegister.currentState!
                                          .validate()) {
                                        RegisterCubit.get(context).userRegister(
                                            email: emailController.text,
                                            phone: phoneController.text,
                                            name: nameController.text,
                                            password: passwordController.text,
                                            hight: hightController.text,
                                            illnesses: illController.text,
                                            notes: detailsController.text,
                                            sex: gender ?? 'A',
                                            weight: wightController.text);
                                      } else {}
                                    },
                                    text: 'Register'),
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
