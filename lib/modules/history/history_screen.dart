import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/models/profile/profileModel.dart';
import 'package:gym_app/shared/appCubit/app_cubit.dart';
import 'package:gym_app/shared/appCubit/app_states.dart';
import 'package:gym_app/shared/colors.dart';
import 'package:gym_app/shared/components/components.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({
    Key? key,
    required this.trainings,
    required this.packages,
  }) : super(key: key);
  final List<TrainingHistory>? trainings;
  final List<PackageHistory>? packages;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          initialIndex: AppCubit.get(context).myTrainingIndex,
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light),
              elevation: 0,
              title: const Text(
                " سجل اشتركاتي",
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
                        text: 'سجل التدريبات',

                        // child: Text('data'),
                      ),
                      Tab(
                        text: 'سجل الباقات',
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
                          'السجلات',
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
                                    trainings?[index].trainingHistoryData?.name,
                                    trainings?[index].trainingHistoryData?.img,
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
                          itemBuilder: (context, index) => buildTrainItem(
                                context,
                                train: packages?[index],
                                packages?[index].packageHistoryData?.name,
                                packages?[index].packageHistoryData?.img,
                                false,
                                false,
                              ),
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 5,
                              ),
                          itemCount: packages?.length ?? 0),
                    if ((packages?.length ?? 0) == 0) buildNoItem(),
                    //train plan tap
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
