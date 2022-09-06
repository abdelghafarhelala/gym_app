import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/models/profile/profileModel.dart';
import 'package:gym_app/modules/advice_details/advice_details.dart';
import 'package:gym_app/shared/appCubit/app_cubit.dart';
import 'package:gym_app/shared/appCubit/app_states.dart';
import 'package:gym_app/shared/colors.dart';
import 'package:gym_app/shared/components/components.dart';

class MyTrainingScreen extends StatelessWidget {
  const MyTrainingScreen(
      {Key? key,
      required this.trainings,
      required this.packages,
      required this.trainingPlan,
      required this.foodPlan})
      : super(key: key);
  final List<Training>? trainings;
  final List<Package>? packages;
  final List<TrainingPlane>? trainingPlan;
  final List<FoodPlane>? foodPlan;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          initialIndex: AppCubit.get(context).myTrainingIndex,
          length: 4,
          child: Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light),
              elevation: 0,
              title: const Text(
                "اشتركاتي",
                style: TextStyle(color: primaryColor),
              ),
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 50,
                child: Material(
                  color: Colors.white,
                  child: TabBar(
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                        text: 'التدريبات',

                        // child: Text('data'),
                      ),
                      Tab(
                        text: 'الباقات',
                      ),
                      Tab(
                        text: 'خطط تدريب',
                      ),
                      Tab(
                        text: 'خطط غذاء',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              buildSliderItem(160, 5),
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
                  ],
                ),
              ),

              Expanded(
                child: TabBarView(
                  children: [
                    if ((trainings?.length ?? 0) > 0)
                      Container(
                        // color: Colors.grey[300],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) => buildTrainItem(
                                    context,
                                    train: trainings?[index],
                                    trainings?[index].trainings?.name,
                                    trainings?[index].trainings?.img,
                                    false,
                                    false,
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    width: 5,
                                  ),
                              itemCount: trainings?.length ?? 0),
                        ),
                      ),
                    if ((trainings?.length ?? 0) == 0) buildNoItem(),
                    //package tap
                    if ((packages?.length ?? 0) > 0)
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {},
                                child: buildTrainItem(
                                  context,
                                  train: packages?[index],
                                  packages?[index].packageData?.name,
                                  packages?[index].packageData?.img,
                                  false,
                                  false,
                                ),
                              ),
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 5,
                              ),
                          itemCount: packages?.length ?? 0),
                    if ((packages?.length ?? 0) == 0) buildNoItem(),
                    //train plan tap
                    if ((trainingPlan?.length ?? 0) > 0)
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  navigateTo(
                                      context,
                                      AdviceDetails(
                                          image: trainingPlan?[index]
                                              .traininPlaneData
                                              ?.img,
                                          title: trainingPlan?[index]
                                                  .traininPlaneData
                                                  ?.name ??
                                              '',
                                          details: trainingPlan?[index]
                                                  .traininPlaneData
                                                  ?.details ??
                                              '',
                                          isRequest: false,
                                          appBarTitle: 'خطط تدريبية'));
                                },
                                child: buildTrainItem(
                                  context,
                                  train: trainingPlan?[index],
                                  trainingPlan?[index].traininPlaneData?.name,
                                  trainingPlan?[index].traininPlaneData?.img,
                                  false,
                                  false,
                                ),
                              ),
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 5,
                              ),
                          itemCount: trainingPlan?.length ?? 0),
                    if ((trainingPlan?.length ?? 0) == 0) buildNoItem(),
//food plan tap
                    if ((foodPlan?.length ?? 0) > 0)
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  navigateTo(
                                      context,
                                      AdviceDetails(
                                          image: foodPlan?[index]
                                              .foodPlaneData
                                              ?.img,
                                          title: foodPlan?[index]
                                                  .foodPlaneData
                                                  ?.name ??
                                              '',
                                          details: foodPlan?[index]
                                                  .foodPlaneData
                                                  ?.details ??
                                              '',
                                          isRequest: false,
                                          appBarTitle: 'خطط غذائيه'));
                                },
                                child: buildTrainItem(
                                  context,
                                  train: foodPlan?[index],
                                  foodPlan?[index].foodPlaneData?.name,
                                  foodPlan?[index].foodPlaneData?.img,
                                  false,
                                  false,
                                ),
                              ),
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 5,
                              ),
                          itemCount: foodPlan?.length ?? 0),
                    if ((foodPlan?.length ?? 0) == 0) buildNoItem(),
                  ],
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
