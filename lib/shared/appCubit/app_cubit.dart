// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/models/contact/contact_model.dart';
import 'package:gym_app/models/favorite/favorite_model.dart';
import 'package:gym_app/models/food_advices/food_advices_model.dart';
import 'package:gym_app/models/food_plan/food_plan_model.dart';
import 'package:gym_app/models/packages/packages_model.dart';
import 'package:gym_app/models/profile/profileModel.dart';
import 'package:gym_app/models/rate/rate_model.dart';
import 'package:gym_app/models/request/request_model.dart';
import 'package:gym_app/models/reset_password/reset_password.dart';
import 'package:gym_app/models/send_email/send_email.dart';
import 'package:gym_app/models/train_advices/train_advices_model.dart';
import 'package:gym_app/models/train_plan/train_plan_model.dart';
import 'package:gym_app/models/training/training_model.dart';
import 'package:gym_app/models/training_offers/training_offers_model.dart';
import 'package:gym_app/models/update_profile/update_profile_model.dart';
import 'package:gym_app/models/userModel/userModel.dart';
import 'package:gym_app/modules/home/home_screen.dart';
import 'package:gym_app/modules/login/login.dart';
import 'package:gym_app/modules/packages/packages_screen.dart';
import 'package:gym_app/modules/plan/Plan_screen.dart';
import 'package:gym_app/modules/profile/profile_screen.dart';
import 'package:gym_app/modules/training/training_screen.dart';
import 'package:gym_app/network/endpoints.dart';
import 'package:gym_app/network/local/cache_Helper.dart';
import 'package:gym_app/network/remote/dio_helper.dart';
import 'package:gym_app/shared/colors.dart';
import 'package:gym_app/shared/components/components.dart';
import 'package:gym_app/shared/const.dart';
import 'package:http_parser/http_parser.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  bool isFirst = true;
  int currentIndex = 2;
  var formKeyLogin = GlobalKey<FormState>();
  var formKeyRegister = GlobalKey<FormState>();

  List<Widget> buttonWidget(index) => [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.task_square,
              color: index == 0 ? primaryColor : Colors.black,
            ),
            Text(
              'الخطط',
              style: TextStyle(
                fontSize: 12,
                color: index == 0 ? primaryColor : Colors.black,
              ),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.apps,
              color: index == 1 ? primaryColor : Colors.black,
            ),
            Text(
              'الباقات',
              style: TextStyle(
                fontSize: 12,
                color: index == 1 ? primaryColor : Colors.black,
              ),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.home_14,
              color: index == 2 ? primaryColor : Colors.black,
            ),
            Text(
              'الرئيسية',
              style: TextStyle(
                fontSize: 12,
                color: index == 2 ? primaryColor : Colors.black,
              ),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center_outlined,
              color: index == 3 ? primaryColor : Colors.black,
            ),
            Text(
              'التمارين',
              style: TextStyle(
                fontSize: 12,
                color: index == 3 ? primaryColor : Colors.black,
              ),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.user,
              color: index == 4 ? primaryColor : Colors.black,
            ),
            Text(
              'الشخصية',
              style: TextStyle(
                fontSize: 12,
                color: index == 4 ? primaryColor : Colors.black,
              ),
            )
          ],
        ),
      ];
  List<String> titles = [
    'البرامج',
    'الباقات',
    'الرئيسية',
    'التمارين',
    ' الصفحه الشخصيه',
  ];
  List<Widget> appScreens = [
    const PlanScreen(),
    const PackagesScreen(),
    const HomeScreen(),
    const TrainingAndOffersScreen(),
    const ProfileScreen(),
  ];

  void changeAppNav(index) {
    currentIndex = index;
    if (index == 1) {
      getPackagesData();
    }
    emit(ChangeNavButtomNavState());
  }

  bool isPass = true;
  IconData suffix = Icons.visibility;
  void changePasswordVisibility() {
    isPass = !isPass;
    isPass ? suffix = Icons.visibility : suffix = Icons.visibility_off;
    emit(PasswordShownState());
  }

  bool isPasss = true;
  IconData suffixx = Icons.visibility;
  void changePasswordVisibilityy() {
    isPasss = !isPasss;
    isPasss ? suffixx = Icons.visibility : suffixx = Icons.visibility_off;
    emit(PasswordShownStatee());
  }

  var isDark = false;
  void changeAppTheme({bool? fromCache}) {
    if (fromCache != null) {
      isDark = fromCache;
      emit(AppChangeThemState());
    } else {
      isDark = !isDark;
      CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeThemState());
      });
    }
  }

//get user

  ProfileModel? profile;
  void getUserData() {
    emit(AppGetUserDataLoadingState());
    DioHelper.getData(url: profileUrl, token: token).then((value) {
      // print(value.data);
      profile = ProfileModel.fromJson(value.data);
      print('********************************************');
      print(profile?.data?.package?[0].packageData?.name);
      print('********************************************');
      emit(AppGetUserDataSuccessState());
    }).catchError((error) {
      emit(AppGetUserDataErrorState());
      print(error.toString());
    });
  }

  UserModel? user;
  void updateUserData({
    required String email,
    required String phone,
    required String name,
    required String jobTitle,
    required int departmentId,
  }) {
    emit(AppUpdateUserDataLoadingState());
    DioHelper.putData(url: '', token: token, data: {
      'email': email,
      'mobile_number': phone,
      'name': name,
      'department_id': departmentId,
      'job_title': jobTitle,
    }).then((value) {
      user = UserModel.fromJson(value.data);
      print(user?.errorMessage);
      getUserData();

      emit(AppUpdateUserDataSuccessState(user));
    }).catchError((error) {
      emit(AppUpdateUserDataErrorState());
      print(error.toString());
    });
  }

  void logOut(context) {
    CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        profile = null;
        navigateAndFinish(context, LoginScreen());
        emit(AppLogOutSuccessState());
      }
    });
  }

  SendEmailModel? sendEmailModel;
  void sendEmail({required String email}) {
    emit(AppSendEmailLoadingState());
    DioHelper.postDataWithoutToken(
      url: sendEmailUrl,
      data: {'email': email},
    ).then((value) {
      sendEmailModel = SendEmailModel.fromJson(value.data);
      emit(AppSendEmailSuccessState(sendEmailModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppSendEmailErrorState());
    });
  }

  void resetPassword({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }) {
    emit(AppRestPasswordLoadingState());
    DioHelper.postData(
            url: changePasswordUrl,
            data: {
              'old_password': oldPassword,
              'new_password': password,
              'c_password': confirmPassword,
            },
            token: token)
        .then((value) {
      resetPasswordModel = ResetPasswordModel.fromJson(value.data);
      emit(AppRestPasswordSuccessState(resetPasswordModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppRestPasswordErrorState());
    });
  }

  //change password
  ResetPasswordModel? resetPasswordModel;
  void updatePasswordData({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) {
    emit(AppChangePasswordLoadingState());
    DioHelper.putData(url: changePasswordUrl, token: token, data: {
      'old_password': oldPassword,
      'new_password': newPassword,
      'c_password': confirmNewPassword,
    }).then((value) {
      resetPasswordModel = ResetPasswordModel.fromJson(value.data);
      print(user?.errorMessage);
      emit(AppChangePasswordSuccessState(resetPasswordModel));
    }).catchError((error) {
      emit(AppChangePasswordErrorState());
      print(error.toString());
    });
  }

//get packages
  Map<int, bool> favorites = {};
  PackagesModel? packagesModel;
  void getPackagesData() {
    emit(AppGetPackagesLoadingState());
    DioHelper.getDataWithoutToken(url: packageUrl, token: token).then((value) {
      // print(value.data);
      packagesModel = PackagesModel.fromJson(value.data);
      packagesModel?.data?.forEach((element) {
        favorites.addAll(
            {element.id!: element.favorites!.length > 0 ? true : false});
      });
      emit(AppGetPackagesSuccessState(packagesModel));
    }).catchError((error) {
      emit(AppGetPackagesErrorState());
      print(error.toString());
    });
  }

  //make favorite
  FavoriteModel? favoriteModel;
  void makeFavorite({required String type, required int id}) {
    favorites[id] = !favorites[id]!;

    emit(AppMakeFavoriteLoadingState());
    DioHelper.postData(
            url: favoriteUrl, data: {"type": type, "favo_id": id}, token: token)
        .then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(AppMakeFavoriteSuccessState(favoriteModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppMakeFavoriteErrorState());
    });
  }

//make rate
  RateModel? rateModel;
  void makeRate(
      {required int id, required double rate, String? note, int? appRate}) {
    emit(AppMakeRateLoadingState());
    DioHelper.postData(
            url: rateUrl,
            data: {
              "rate": rate,
              "rated_in_id": id,
              "rate_app": appRate ?? 1,
              "notes": note ?? ''
            },
            token: token)
        .then((value) {
      rateModel = RateModel.fromJson(value.data);
      emit(AppMakeRateSuccessState(rateModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppMakeRateErrorState());
    });
  }

  int myTrainingIndex = 0;

//get food advices
  FoodAdvices? foodAdvices;
  void getFoodAdvicesData() {
    emit(AppGetFoodAdvicesLoadingState());
    DioHelper.getDataWithoutToken(url: foodAdvicesUrl).then((value) {
      foodAdvices = FoodAdvices.fromJson(value.data);
      emit(AppGetFoodAdvicesSuccessState(foodAdvices));
      getPackagesData();
    }).catchError((error) {
      emit(AppGetFoodAdvicesErrorState());
      print(error.toString());
    });
  }

//get train advices
  TrainAdvicesModel? trainAdvicesModel;
  void getTrainAdvicesData() {
    emit(AppGetTrainAdvicesLoadingState());
    DioHelper.getDataWithoutToken(url: trainAdvicesUrl).then((value) {
      trainAdvicesModel = TrainAdvicesModel.fromJson(value.data);

      emit(AppGetTrainAdvicesSuccessState(trainAdvicesModel));
      getFoodPlanData();
      getTrainPlanData();
    }).catchError((error) {
      emit(AppGetTrainAdvicesErrorState());
      print(error.toString());
    });
  }

//make contact
  ContactModel? contactModel;
  void makeContact(
      {required String name,
      required String phone,
      required String email,
      required String message}) {
    emit(AppMakeContactLoadingState());
    DioHelper.postDataWithoutToken(url: contactUsUrl, data: {
      "name": name,
      "phone": phone,
      "email": email,
      "message": message
    }).then((value) {
      contactModel = ContactModel.fromJson(value.data);
      emit(AppMakeContactSuccessState(contactModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppMakeContactErrorState());
    });
  }

  File? postImage;
  var picker = ImagePicker();
  Future<void> picProfileImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      postImage = File(pickerFile.path);
      emit(AppPickImageSuccessState());
    } else {
      print('No Image Selected');
      emit(AppPickImageErrorState());
    }
  }

  void removeImage() {
    postImage = null;
    emit(AppRemovePickImageState());
  }

  //update profile
  UpdateProfileModel? updateProfileModel;
  void updateProfileWithoutImage({
    required String email,
    required String phone,
    required String name,
    required int weight,
    required String illnesses,
    required String notes,
    required String sex,
    required int hight,
  }) {
    emit(AppUpdateProfileLoadingState());
    DioHelper.postData(
            url: updateProfileUrl,
            data: {
              'email': email,
              'mobile': phone,
              'name': name,
              'length': hight,
              'weight': weight,
              'illnesses': illnesses,
              'notes': notes,
              'sex': sex,
            },
            token: token)
        .then((value) {
      print(value.data);
      updateProfileModel = UpdateProfileModel.fromJson(value.data);
      getUserData();
      emit(AppUpdateProfileSuccessState(updateProfileModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AppUpdateProfileErrorState());
    });
  }

  void updateProfile({
    required String email,
    required String phone,
    required String name,
    required int weight,
    required String illnesses,
    required String notes,
    required String sex,
    required int hight,
  }) async {
    String? fileName = postImage?.path.split('/').last;
    FormData formData = FormData.fromMap({
      "profile_photo_path": await MultipartFile.fromFile(
        postImage?.path ?? '',
        filename: fileName,
        contentType: new MediaType("image", "jpeg"), //important
      ),
      'email': email,
      'mobile': phone,
      'name': name,
      'length': hight,
      'weight': weight,
      'illnesses': illnesses,
      'notes': notes,
      'sex': sex,
    });
    emit(AppUpdateProfileLoadingState());
    Dio dio = new Dio()..options.baseUrl = 'https://gym.masool.net/api/';
    dio
        .post(updateProfileUrl,
            data: formData,
            options: Options(headers: {
              'Authorization': 'Bearer ' + token!,
            }))
        .then((response) {
      updateProfileModel = UpdateProfileModel.fromJson(response.data);
      getUserData();
      emit(AppUpdateProfileSuccessState(updateProfileModel!));
      print(response);
    }).catchError((error) {
      print(error.toString());
      emit(AppUpdateProfileErrorState());
    });
  }

  String? registerGender = 'A';
  var registerEmailController = TextEditingController();
  var registerHightController = TextEditingController();
  var registerIllController = TextEditingController();
  var registerDetailsController = TextEditingController();
  var registerNameController = TextEditingController();
  var registerPhoneController = TextEditingController();
  var registerPasswordController = TextEditingController();
  var registerConfirmPasswordController = TextEditingController();
//update controllers
  var updateEmailController = TextEditingController();
  var updateHightController = TextEditingController();
  var updateIllController = TextEditingController();
  var updateDetailsController = TextEditingController();
  var updateWightController = TextEditingController();
  var updateNameController = TextEditingController();
  var updatePhoneController = TextEditingController();
  var formKeyUpdate = GlobalKey<FormState>();
  String? gender;

  void getdata() {
    updateDetailsController.text = profile?.data?.notes ?? '';
    updateEmailController.text = profile?.data?.email ?? '';
    updatePhoneController.text = profile?.data?.mobile ?? '';
    updateHightController.text = profile?.data?.length.toString() ?? '';
    updateWightController.text = profile?.data?.weight.toString() ?? '';
    updateNameController.text = profile?.data?.name ?? '';
    updateIllController.text = profile?.data?.illnesses ?? '';
    gender = profile?.data?.sex;
  }

//get training
  TrainingModel? trainingModel;
  void getTrainingData() {
    emit(AppGetTrainingLoadingState());
    DioHelper.getDataWithoutToken(url: trainingUrl).then((value) {
      trainingModel = TrainingModel.fromJson(value.data);
      emit(AppGetTrainingSuccessState(trainingModel));
    }).catchError((error) {
      emit(AppGetTrainingErrorState());
      print(error.toString());
    });
  }

  //get training plan
  TrainPlanModel? trainPlanModel;
  void getTrainPlanData() {
    emit(AppGetTrainingPlanLoadingState());
    DioHelper.getDataWithoutToken(url: trainPlanUrl).then((value) {
      trainPlanModel = TrainPlanModel.fromJson(value.data);

      emit(AppGetTrainingPlanSuccessState(trainPlanModel));
    }).catchError((error) {
      emit(AppGetTrainingPlanErrorState());
      print(error.toString());
    });
  }

  //get training plan
  FoodPlanModel? foodPlanModel;
  void getFoodPlanData() {
    emit(AppGetFoodPlanLoadingState());
    DioHelper.getDataWithoutToken(
      url: foodPlanUrl,
    ).then((value) {
      foodPlanModel = FoodPlanModel.fromJson(value.data);
      emit(AppGetFoodPlanSuccessState(foodPlanModel));
    }).catchError((error) {
      emit(AppGetFoodPlanErrorState());
      print(error.toString());
    });
  }

  //get training & offers
  TrainingOffersModel? trainingOffersModel;
  void getTrainAndOffersData() {
    emit(AppGetTrainAndOffersLoadingState());
    DioHelper.getDataWithoutToken(url: trainingOfferUrl).then((value) {
      trainingOffersModel = TrainingOffersModel.fromJson(value.data);
      emit(AppGetTrainAndOffersSuccessState(trainingOffersModel));
    }).catchError((error) {
      emit(AppGetTrainAndOffersErrorState());
      print(error.toString());
    });
  }

  var controller = PageController(initialPage: 2);
  //update profile
  RequestModel? requestModel;
  void makeRequest({
    required String type,
    required String id,
  }) {
    emit(AppMakeRequestLoadingState());
    DioHelper.postData(
            url: makeRequestUrl,
            data: {
              'type': type,
              'train_pac_id': id,
            },
            token: token)
        .then((value) {
      print(value.data);
      requestModel = RequestModel.fromJson(value.data);
      emit(AppMakeRequestSuccessState(requestModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AppMakeRequestErrorState());
    });
  }
}
