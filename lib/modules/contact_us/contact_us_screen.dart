import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/modules/login/login.dart';
import 'package:gym_app/modules/register/registerCubit/registerCubit.dart';
import 'package:gym_app/network/local/cache_Helper.dart';
import 'package:gym_app/shared/appCubit/app_cubit.dart';
import 'package:gym_app/shared/appCubit/app_states.dart';
import 'package:gym_app/shared/components/components.dart';
import 'package:gym_app/shared/const.dart';

var emailController = TextEditingController();
var messageController = TextEditingController();
var nameController = TextEditingController();
var phoneController = TextEditingController();

var formKeyRegister = GlobalKey<FormState>();

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppMakeContactSuccessState) {
          if (state.model?.result == true) {
            showToast(
                text: state.model?.errorMessage, state: ToastStates.success);
          } else {
            showToast(
                text: state.model?.errorMessage, state: ToastStates.error);
          }
        } else if (state is AppMakeContactErrorState) {
          showToast(text: 'This data is invalid', state: ToastStates.error);
        }
      },
      builder: (context, state) {
        double screenHeight = MediaQuery.of(context).size.height;
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.dark),
            title: const Text(
              '?????????? ????????',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          ),
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
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.network(
                            'https://img.freepik.com/free-vector/contact-us-concept-landing-page_52683-18637.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357',
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          // IconButton(
                          //     onPressed: () {
                          //       Navigator.pop(context);
                          //     },
                          //     icon: Icon(Icons.arrow_back))
                        ],
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      // Text(
                      //   '?????????? ????????',
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .subtitle2!
                      //       .copyWith(fontSize: 24),
                      // ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenHeight / 34),
                        child: Column(
                          children: [
                            Card(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              elevation: 1.5,
                              child: defaultTextField(
                                  lable: '??????????',
                                  controller: nameController,
                                  prefix: Icons.person_outline,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return '?????? ???? ???????? ??????????';
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
                                  lable: '?????? ????????????',
                                  controller: phoneController,
                                  prefix: Icons.phone_iphone,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return '?????? ???? ???????? ?????? ????????????';
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
                                  lable: '???????????? ????????????????????',
                                  controller: emailController,
                                  prefix: Icons.email_outlined,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return '?????? ???? ???????? ???????????? ????????????????????';
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
                                  maxLines: 3,
                                  hint: '????????????',
                                  controller: messageController,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return '?????? ???? ???????? ????????????';
                                    }
                                  },
                                  context: context,
                                  type: TextInputType.text),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ConditionalBuilder(
                              condition: state is! AppMakeContactLoadingState,
                              builder: (context) => defaultButton(
                                  height: screenHeight / 16,
                                  onPress: () {
                                    if (formKeyRegister.currentState!
                                        .validate()) {
                                      AppCubit.get(context).makeContact(
                                          email: emailController.text,
                                          phone: phoneController.text,
                                          name: nameController.text,
                                          message: messageController.text);
                                    } else {}
                                  },
                                  text: '??????????'),
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
    );
  }
}
