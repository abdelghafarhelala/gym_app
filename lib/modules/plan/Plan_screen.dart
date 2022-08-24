import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/modules/advice_details/advice_details.dart';
import 'package:gym_app/shared/appCubit/app_cubit.dart';
import 'package:gym_app/shared/appCubit/app_states.dart';
import 'package:gym_app/shared/colors.dart';
import 'package:gym_app/shared/components/components.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! AppGetFoodPlanLoadingState &&
              state is! AppGetTrainingPlanLoadingState,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) => DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(
                    height: 50,
                    child: Material(
                      color: primaryColor,
                      child: TabBar(
                        indicatorColor: Colors.white,
                        labelColor: Colors.white,
                        tabs: [
                          Tab(
                            text: 'خطط غذائيه',
                          ),
                          Tab(
                            text: 'خطط تدريبيه',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 90,
                    width: double.infinity,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    height: 110,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              'الخطط',
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
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TabBarView(
                        children: [
                          Container(
                            // color: Colors.grey[300],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          navigateTo(
                                              context,
                                              AdviceDetails(
                                                image: AppCubit.get(context)
                                                    .foodPlanModel
                                                    ?.data?[index]
                                                    .img,
                                                title: AppCubit.get(context)
                                                        .foodPlanModel
                                                        ?.data?[index]
                                                        .name ??
                                                    '',
                                                details: AppCubit.get(context)
                                                        .foodPlanModel
                                                        ?.data?[index]
                                                        .details ??
                                                    '',
                                                isRequest: true,
                                                appBarTitle: 'خطط غذائية',
                                                id: AppCubit.get(context)
                                                    .foodPlanModel
                                                    ?.data?[index]
                                                    .id,
                                                type: 'food plans',
                                              ));
                                        },
                                        child: buildPlanItem(
                                          context: context,
                                          name: AppCubit.get(context)
                                                  .foodPlanModel
                                                  ?.data?[index]
                                                  .name ??
                                              '',
                                          details: AppCubit.get(context)
                                                  .foodPlanModel
                                                  ?.data?[index]
                                                  .details ??
                                              '',
                                          image: AppCubit.get(context)
                                              .foodPlanModel
                                              ?.data?[index]
                                              .img,
                                        ),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        width: 5,
                                      ),
                                  itemCount: AppCubit.get(context)
                                          .foodPlanModel
                                          ?.data
                                          ?.length ??
                                      0),
                            ),
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      navigateTo(
                                          context,
                                          AdviceDetails(
                                            image: AppCubit.get(context)
                                                .trainPlanModel
                                                ?.data?[index]
                                                .img,
                                            title: AppCubit.get(context)
                                                    .trainPlanModel
                                                    ?.data?[index]
                                                    .name ??
                                                '',
                                            details: AppCubit.get(context)
                                                    .trainPlanModel
                                                    ?.data?[index]
                                                    .details ??
                                                '',
                                            isRequest: true,
                                            appBarTitle: 'خطط تدربيه',
                                            id: AppCubit.get(context)
                                                .trainPlanModel
                                                ?.data?[index]
                                                .id,
                                            type: 'training plans',
                                          ));
                                    },
                                    child: buildPlanItem(
                                        context: context,
                                        name: AppCubit.get(context)
                                                .trainPlanModel
                                                ?.data?[index]
                                                .name ??
                                            '',
                                        details: AppCubit.get(context)
                                                .trainPlanModel
                                                ?.data?[index]
                                                .details ??
                                            '',
                                        image: AppCubit.get(context)
                                                .trainPlanModel
                                                ?.data?[index]
                                                .img ??
                                            ''),
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    width: 5,
                                  ),
                              itemCount: AppCubit.get(context)
                                      .trainPlanModel
                                      ?.data
                                      ?.length ??
                                  0),
                        ],
                      ),
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 55),
                  child: buildSliderItem(180, 5),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
