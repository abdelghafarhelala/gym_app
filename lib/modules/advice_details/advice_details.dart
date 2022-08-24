import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/network/endpoints.dart';
import 'package:gym_app/shared/appCubit/app_cubit.dart';
import 'package:gym_app/shared/appCubit/app_states.dart';
import 'package:gym_app/shared/colors.dart';
import 'package:gym_app/shared/components/components.dart';
import 'package:gym_app/shared/const.dart';

class AdviceDetails extends StatelessWidget {
  final String? image;
  final String title;
  final String details;
  final String appBarTitle;
  final bool isRequest;
  final int? id;
  final String? type;
  const AdviceDetails(
      {Key? key,
      required this.image,
      required this.title,
      required this.details,
      required this.isRequest,
      required this.appBarTitle,
      this.id,
      this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppMakeRequestSuccessState) {
          if (state.model!.result!) {
            showToast(
                text: state.model!.errorMessage, state: ToastStates.success);
          } else {
            showToast(
                text: state.model!.errorMessage, state: ToastStates.error);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.dark),
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(
              appBarTitle,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (image != null)
                  Container(
                    height: 270,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage('$imageLink$image'),
                            fit: BoxFit.cover)),
                  ),
                if (image == null)
                  Container(
                    height: 270,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                            image: NetworkImage(
                                'https://img.freepik.com/free-photo/athletic-man-woman-with-dumbbells_155003-11801.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357'),
                            fit: BoxFit.cover)),
                  ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: primaryColor),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  details,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                if (isRequest)
                  const SizedBox(
                    height: 100,
                  ),
                if (isRequest && token != null)
                  ConditionalBuilder(
                    condition: state is! AppMakeRequestLoadingState,
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                    builder: (context) => defaultButton(
                        height: 50,
                        onPress: () {
                          AppCubit.get(context)
                              .makeRequest(type: type ?? '', id: id.toString());
                        },
                        text: 'تقديم طلب'),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
