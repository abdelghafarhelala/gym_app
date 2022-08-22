import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/shared/appCubit/app_cubit.dart';
import 'package:gym_app/shared/appCubit/app_states.dart';
import 'package:gym_app/shared/colors.dart';
import 'package:gym_app/shared/components/components.dart';

class TrainingAndOffersScreen extends StatelessWidget {
  const TrainingAndOffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context).trainingOffersModel?.data;
        return ConditionalBuilder(
          condition:
              (AppCubit.get(context).trainingOffersModel?.data?.length ?? 0) >
                  0,
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
                            'التدريبات',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' المتاحه',
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
                  condition: State is! AppGetTrainAndOffersLoadingState,
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                  builder: (context) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildOfferItem(
                              cubit?[index].img,
                              cubit?[index].name ?? '',
                              context,
                              cubit?[index].offers?[0].sessionNum ?? 0,
                              cubit?[index].offers?[0].price ?? 0),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 1,
                              ),
                          itemCount: cubit?.length ?? 0),
                    ),
                  ),
                )
              ]),
              buildSliderItem(220, 5),
            ],
          ),
        );
      },
    );
  }
}
