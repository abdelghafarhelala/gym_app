import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gym_app/models/packages/packages_model.dart';
import 'package:gym_app/modules/home/home_screen.dart';
import 'package:gym_app/modules/layoutScreen/layoutScreen.dart';
import 'package:gym_app/modules/packages/packages_screen.dart';
import 'package:gym_app/shared/appCubit/app_cubit.dart';
import 'package:gym_app/shared/appCubit/app_states.dart';
import 'package:gym_app/shared/colors.dart';
import 'package:gym_app/shared/components/components.dart';
import 'package:gym_app/shared/const.dart';

var noteController = TextEditingController();
double rateNumber = 0.0;

class PackageDetailsScreen extends StatelessWidget {
  final Data? packageModel;
  const PackageDetailsScreen({Key? key, required this.packageModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) => {
        if (state is AppMakeRequestSuccessState)
          {
            if (state.model!.result!)
              {
                showToast(
                    text: state.model!.errorMessage, state: ToastStates.success)
              }
            else
              {
                showToast(
                    text: state.model!.errorMessage, state: ToastStates.error)
              }
          }
      },
      builder: (context, state) {
        print(packageModel?.trainCount);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              // For Android.
              // Use [light] for white status bar and [dark] for black status bar.
              // statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent,
              // For iOS.
              // Use [dark] for white status bar and [light] for black status bar.
              // statusBarBrightness: Brightness.dark,
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                            height: screenHight,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                              color: Colors.white,
                            )),
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero,

                              // height: screenHight / 2.7,
                              height: screenHight / 2.9,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://img.freepik.com/premium-photo/young-ripped-man-bodybuilder-with-perfect-abs-shoulders-biceps-triceps-chest-posing-with-dumbbell_136403-1032.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357'),
                                      fit: BoxFit.cover)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 40, horizontal: 10),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      height: screenHight / 1.37,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        packageModel?.name ?? '',
                                        style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (token != null)
                                      IconButton(
                                          onPressed: () {
                                            AppCubit.get(context).makeFavorite(
                                                type: 'package',
                                                id: packageModel!.id!);
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            size: 30,
                                            color: (AppCubit.get(context)
                                                            .favorites[
                                                        packageModel?.id]) ==
                                                    true
                                                ? primaryColor
                                                : Colors.grey[300],
                                          ))
                                  ],
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'تقييم الباقة',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        RatingBar.builder(
                                          itemSize: 18,
                                          initialRating: double.parse(
                                              packageModel?.ratesAvgRate ??
                                                  '1'),
                                          ignoreGestures: true,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: false,
                                          itemCount: 5,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    if (token != null)
                                      MaterialButton(
                                        color: primaryColor,
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => buildDialog(
                                                context, packageModel!.id!),
                                          );
                                        },
                                        child: const Text('قيم الباقة',
                                            style: TextStyle(
                                              color: Colors.white,
                                            )),
                                      ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'عدد التقييمات  :  ${packageModel?.ratesCount ?? 0}',
                                  style: TextStyle(color: Colors.green),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  '  حافظ علي رشاقة جسمك',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Icon(
                                        Icons.price_change,
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
                                          'جنيه',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          packageModel?.price.toString() ?? '',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 100,
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Icon(
                                        Icons.numbers,
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
                                          'مشترك',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          packageModel?.trainCount.toString() ??
                                              '',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                const Text(
                                  'التمارين الموجوده',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) => buildTrainItem(
                                    context,
                                    packageModel?.child?[index].trainings
                                            ?.parent?.name ??
                                        '',
                                    packageModel
                                        ?.child?[index].trainings?.parent?.img,
                                    true,
                                    true,
                                    sessionNum: packageModel?.child?[index]
                                            .trainings?.sessionNum ??
                                        '0'),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 1,
                                    ),
                                itemCount: packageModel?.child?.length ?? 0),
                          )),
                          if (token != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 3),
                              child: ConditionalBuilder(
                                condition: state is! AppMakeRequestLoadingState,
                                fallback: (context) => const Center(
                                    child: CircularProgressIndicator()),
                                builder: (context) => defaultButton(
                                    height: 50,
                                    onPress: () {
                                      AppCubit.get(context).makeRequest(
                                          type: 'package',
                                          id: packageModel?.id.toString() ??
                                              '');
                                    },
                                    text: 'تقديم طلب'),
                              ),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDialog(context, int id) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppMakeRateSuccessState) {
          if (state.model?.result == true) {
            showToast(
                text: state.model?.errorMessage, state: ToastStates.success);
            AppCubit.get(context).getPackagesData();
            AppCubit.get(context).currentIndex = 0;
            navigateAndFinish(context, LayoutScreen());
          } else {
            showToast(
                text: state.model?.errorMessage, state: ToastStates.error);
          }
        }
      },
      builder: (context, state) {
        return Dialog(
          insetAnimationCurve: Curves.linearToEaseOut,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                height: 260,
                width: 450,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    Text('يسعدنا تقييمك',
                        style: Theme.of(context).textTheme.headline1),
                    const SizedBox(
                      height: 20,
                    ),
                    RatingBar.builder(
                      itemSize: 28,
                      initialRating: 1,
                      // ignoreGestures: true,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                        // color: primaryColor,
                      ),
                      onRatingUpdate: (rating) {
                        rateNumber = rating;
                        print(rating);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 60,
                      child: TextFormField(
                        controller: noteController,
                        decoration: InputDecoration(
                          label: const Text(
                            'تعليقك',
                            style: TextStyle(fontSize: 16),
                          ),
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ConditionalBuilder(
                      condition: state is! AppMakeRateLoadingState,
                      fallback: (context) => const CircularProgressIndicator(),
                      builder: (context) => MaterialButton(
                        minWidth: 220,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9)),
                        clipBehavior: Clip.antiAlias,
                        color: primaryColor,
                        onPressed: () {
                          AppCubit.get(context).makeRate(
                              id: id,
                              rate: rateNumber,
                              note: noteController.text);
                        },
                        child: const Text(' ارسل التقييم',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close))
            ],
          ),
        );
      },
    );
  }
}
