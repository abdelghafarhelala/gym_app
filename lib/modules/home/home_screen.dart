import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/network/endpoints.dart';
import 'package:gym_app/shared/appCubit/app_cubit.dart';
import 'package:gym_app/shared/appCubit/app_states.dart';
import 'package:gym_app/shared/colors.dart';
import 'package:gym_app/shared/components/components.dart';

final List<String> imgList = [
  'https://img.freepik.com/free-photo/topless-young-athletic-man-working-out-with-heavy-dumbbell_171337-7584.jpg?size=626&ext=jpg&ga=GA1.2.1634405249.1648830357',
  'https://img.freepik.com/premium-photo/sport-fitness-lifestyle-technology-people-concept-men-exercising-treadmill-gym_380164-75430.jpg?size=626&ext=jpg&ga=GA1.2.1634405249.1648830357',
  'https://img.freepik.com/free-photo/ropes-caucasian-professional-sportsman-training-white-studio_155003-30091.jpg?size=626&ext=jpg&ga=GA1.2.1634405249.1648830357'
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: (AppCubit.get(context).foodAdvices?.data?.length ?? 0) >
                  0 &&
              (AppCubit.get(context).trainAdvicesModel?.data?.length ?? 0) > 0,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      height: 95,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          // Icon(Iconsax.user),
                          Row(
                            children: const [
                              Text(
                                'نصائح ',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'غذائيه ',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 220,
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => buildAdviceItem(
                                    '${AppCubit.get(context).foodAdvices?.data?[index].img}',
                                    AppCubit.get(context)
                                            .foodAdvices
                                            ?.data?[index]
                                            .name ??
                                        '',
                                    context,
                                    AppCubit.get(context)
                                            .foodAdvices
                                            ?.data?[index]
                                            .details ??
                                        '',
                                    false),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      width: 5,
                                    ),
                                itemCount: AppCubit.get(context)
                                        .foodAdvices
                                        ?.data
                                        ?.length ??
                                    0),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: const [
                              Text(
                                ' نصائح',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                ' تدريبيه',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor),
                              ),
                              const Spacer(),
                              // TextButton(
                              //     onPressed: () {
                              //       navigateTo(context, TrainingScreen());
                              //     },
                              //     child: const Text(
                              //       'عرض الكل',
                              //       style: TextStyle(color: Colors.grey),
                              //     ))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) => buildAdviceItem(
                                  '${AppCubit.get(context).trainAdvicesModel?.data?[index].img}',
                                  AppCubit.get(context)
                                          .trainAdvicesModel
                                          ?.data?[index]
                                          .name ??
                                      '',
                                  context,
                                  AppCubit.get(context)
                                          .trainAdvicesModel
                                          ?.data?[index]
                                          .details ??
                                      '',
                                  false),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    width: 5,
                                  ),
                              itemCount: AppCubit.get(context)
                                      .trainAdvicesModel
                                      ?.data
                                      ?.length ??
                                  0),
                        ],
                      ),
                    ),
                  ],
                ),
                buildSliderItem(220, 12)
              ],
            ),
          ),
        );
      },
    );
  }
}
