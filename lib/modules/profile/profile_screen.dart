import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/modules/history/history_screen.dart';
import 'package:gym_app/modules/my_tranning/my_trainning_screen.dart';
import 'package:gym_app/modules/qr_code/creat_qr_screen.dart';
import 'package:gym_app/network/endpoints.dart';
import 'package:gym_app/shared/appCubit/app_cubit.dart';
import 'package:gym_app/shared/appCubit/app_states.dart';
import 'package:gym_app/shared/colors.dart';
import 'package:gym_app/shared/components/components.dart';
import 'package:gym_app/shared/const.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var nameController = TextEditingController();
        var emailController = TextEditingController();
        var mobileController = TextEditingController();
        var wightController = TextEditingController();
        var hightController = TextEditingController();
        var genderController = TextEditingController();
        var illnessController = TextEditingController();
        var bioController = TextEditingController();
        var profileModel = AppCubit.get(context).profile?.data;
        nameController.text = profileModel?.name ?? '';
        emailController.text = profileModel?.email ?? '';
        mobileController.text = profileModel?.mobile ?? '';
        wightController.text = profileModel?.weight.toString() ?? '';
        hightController.text = profileModel?.length.toString() ?? '';
        profileModel?.sex == 'A'
            ? genderController.text = 'ذكر'
            : genderController.text = 'انثي';
        illnessController.text = profileModel?.illnesses ?? 'لايوجد امراض';
        bioController.text = profileModel?.notes ?? 'لا توجد معلومات اضافية';
        // startDateController.text = profileModel?. ?? '';
        return token != null
            ? ConditionalBuilder(
                condition: state is! AppGetUserDataLoadingState,
                fallback: (context) => const CircularProgressIndicator(),
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (AppCubit.get(context)
                                    .profile
                                    ?.data
                                    ?.profilePhotoPath ==
                                null)
                              const CircleAvatar(
                                radius: 55,
                                backgroundImage: NetworkImage(
                                    'https://img.freepik.com/free-photo/young-muscular-athlete-practicing-gym-posing-confident-with-weights_155003-35490.jpg?size=338&ext=jpg&ga=GA1.2.1634405249.1648830357'),
                              ),
                            if (AppCubit.get(context)
                                    .profile
                                    ?.data
                                    ?.profilePhotoPath !=
                                null)
                              CircleAvatar(
                                radius: 55,
                                backgroundImage: NetworkImage(
                                    '$imageLink${AppCubit.get(context).profile?.data?.profilePhotoPath}'),
                              ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            '${profileModel?.name}',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            '${profileModel?.email}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black87),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          print(profileModel?.qrCode);
                                          navigateTo(
                                              context,
                                              CreateQRScreen(
                                                  qrStringCode:
                                                      profileModel?.qrCode ??
                                                          ''));
                                        },
                                        icon: const Icon(Icons.qr_code),
                                        iconSize: 40,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${profileModel?.mobile}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Icon(
                                            Icons.balance_outlined,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'كيلو جرام',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              '${profileModel?.weight}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Icon(
                                            Icons.height,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'سنتيمتر',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              '${profileModel?.length}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Icon(
                                            profileModel?.sex == 'A'
                                                ? Icons.male
                                                : Icons.female,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'النوع',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              profileModel?.sex == 'A'
                                                  ? 'ذكر'
                                                  : 'انثي',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              //######################
                              if (profileModel?.subscribeStatus != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //   width: double.infinity,
                                    //   height: 1,
                                    //   color: Colors.grey[300],
                                    // ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.adjust_rounded,
                                          color: primaryColor,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'تفاصيل الباقه ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          'الشهرية',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: primaryColor),
                                        ),
                                      ],
                                    ),
                                    Card(
                                      elevation: 0,
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      color: primaryColor.withOpacity(.7),
                                      // color: Colors.green.withOpacity(.3),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        height: 110,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.monetization_on,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'تم دفع : ${profileModel?.subscribeStatus?.payed} ',
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.monetization_on,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        ' الباقي : ${profileModel?.subscribeStatus?.remaining} ',
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: const [
                                                      Icon(
                                                        Icons.date_range,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text('تاريخ البدايه  ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: const [
                                                      Icon(
                                                        Icons.date_range,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text('تاريخ النهايه  ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                          profileModel
                                                                  ?.subscribeStatus
                                                                  ?.startDate ??
                                                              '',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                          profileModel
                                                                  ?.subscribeStatus
                                                                  ?.endDate ??
                                                              '',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              const SizedBox(
                                height: 20,
                              ),
                              //#######################
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 50,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 38,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/sick.png')),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                      '${profileModel?.illnesses ?? 'لا يوجد امراض'}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 50,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 38,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/info.png')),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                      '${profileModel?.notes ?? 'لا توجد معلومات اضافيه او ملاحظات'}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ))
                                  ],
                                ),
                              ),
                              // const SizedBox(
                              //   height: 15,
                              // ),

                              const SizedBox(
                                height: 15,
                              ),
                              ///////////////////////
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              //training
                              InkWell(
                                onTap: () {
                                  AppCubit.get(context).myTrainingIndex = 0;
                                  navigateTo(
                                      context,
                                      MyTrainingScreen(
                                        trainings: profileModel?.training,
                                        packages: profileModel?.package,
                                        foodPlan: profileModel?.foodPlane,
                                        trainingPlan:
                                            profileModel?.trainingPlane,
                                      ));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.amber.withOpacity(.6),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Icon(
                                        Icons.fitness_center,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Text('تمارينك',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        )),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                        ))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              //packages
                              InkWell(
                                onTap: () {
                                  AppCubit.get(context).myTrainingIndex = 1;
                                  navigateTo(
                                      context,
                                      MyTrainingScreen(
                                        trainings: profileModel?.training,
                                        packages: profileModel?.package,
                                        foodPlan: profileModel?.foodPlane,
                                        trainingPlan:
                                            profileModel?.trainingPlane,
                                      ));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: primaryColor.withOpacity(.6),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Icon(
                                        Icons.all_inclusive,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Text('باقاتك',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        )),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                        ))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              //food plan
                              InkWell(
                                onTap: () {
                                  AppCubit.get(context).myTrainingIndex = 3;
                                  navigateTo(
                                      context,
                                      MyTrainingScreen(
                                        trainings: profileModel?.training,
                                        packages: profileModel?.package,
                                        foodPlan: profileModel?.foodPlane,
                                        trainingPlan:
                                            profileModel?.trainingPlane,
                                      ));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(.6),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Icon(
                                        Icons.food_bank,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Text('خططك الغذائيه',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        )),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                        ))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              //training plan
                              InkWell(
                                onTap: () {
                                  print(profileModel
                                      ?.package?[0].packageData?.name);
                                  AppCubit.get(context).myTrainingIndex = 2;
                                  navigateTo(
                                      context,
                                      MyTrainingScreen(
                                        trainings: profileModel?.training,
                                        packages: profileModel?.package,
                                        foodPlan: profileModel?.foodPlane,
                                        trainingPlan:
                                            profileModel?.trainingPlane,
                                      ));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.cyan.withOpacity(.6),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Icon(
                                        Icons.sports_gymnastics_outlined,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Text('خططك التدريبيه',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        )),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                        ))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  print(profileModel
                                      ?.package?[0].packageData?.name);
                                  AppCubit.get(context).myTrainingIndex = 0;
                                  navigateTo(
                                      context,
                                      HistoryScreen(
                                          trainings:
                                              profileModel?.trainingHistory,
                                          packages:
                                              profileModel?.packageHistory));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.brown.withOpacity(.6),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Icon(
                                        Icons.history,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Text('سجل الإشتراكات',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        )),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : buildLoginItem(context);
      },
    );
  }
}
