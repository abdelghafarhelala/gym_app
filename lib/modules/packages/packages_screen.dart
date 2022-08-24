import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gym_app/modules/home/home_screen.dart';
import 'package:gym_app/modules/package_details/package_details_screen.dart';
import 'package:gym_app/shared/appCubit/app_cubit.dart';
import 'package:gym_app/shared/appCubit/app_states.dart';
import 'package:gym_app/shared/colors.dart';
import 'package:gym_app/shared/components/components.dart';

class PackagesScreen extends StatelessWidget {
  const PackagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context).packagesModel;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        double screenHight = MediaQuery.of(context).size.height;

        return ConditionalBuilder(
          condition: state is! AppGetPackagesLoadingState,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) => Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  height: 140,
                  color: primaryColor,
                ),
                const SizedBox(
                  height: 95,
                ),

                // const SizedBox(
                //   height: 10,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: const [
                          Text(
                            'الباقات',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' التدريبيه',
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
                    ],
                  ),
                ),
                ConditionalBuilder(
                  condition: State is! AppGetPackagesLoadingState,
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                  builder: (context) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  AppCubit.get(context).getUserRateData(
                                      id: cubit?.data?[index].id);
                                  print(AppCubit.get(context).isRated);
                                  navigateTo(
                                      context,
                                      PackageDetailsScreen(
                                        packageModel: cubit?.data?[index],
                                      ));
                                },
                                child: buildTrainItem(
                                    context,
                                    model: cubit?.data?[index],
                                    price: cubit?.data?[index].price,
                                    rate: double.parse(AppCubit.get(context)
                                            .packagesModel
                                            ?.data?[index]
                                            .ratesAvgRate ??
                                        '1'),
                                    AppCubit.get(context)
                                        .packagesModel
                                        ?.data?[index]
                                        .name,
                                    AppCubit.get(context)
                                        .packagesModel
                                        ?.data?[index]
                                        .img,
                                    true,
                                    false),
                              ),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 1,
                              ),
                          itemCount: AppCubit.get(context)
                                  .packagesModel
                                  ?.data
                                  ?.length ??
                              0),
                    ),
                  ),
                )
              ]),
              buildSliderItem(screenHight > 780 ? 220 : 170, 5),
            ],
          ),
        );
      },
    );
  }
}
