import 'package:gym_app/models/contact/contact_model.dart';
import 'package:gym_app/models/favorite/favorite_model.dart';
import 'package:gym_app/models/food_advices/food_advices_model.dart';
import 'package:gym_app/models/food_plan/food_plan_model.dart';
import 'package:gym_app/models/packages/packages_model.dart';
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
import 'package:gym_app/models/user_rates_model/user_rates_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeLanguageState extends AppStates {}

class ChangeNavButtomNavState extends AppStates {}

class AppChangeThemState extends AppStates {}

//get user data states
class AppGetUserDataSuccessState extends AppStates {}

class PasswordShownState extends AppStates {}

class PasswordShownStatee extends AppStates {}

class AppGetUserDataErrorState extends AppStates {}

class AppGetUserDataLoadingState extends AppStates {}

//update user data states
class AppUpdateUserDataSuccessState extends AppStates {
  final UserModel? model;

  AppUpdateUserDataSuccessState(this.model);
}

class AppUpdateUserDataErrorState extends AppStates {}

class AppUpdateUserDataLoadingState extends AppStates {}

// app logout states
class AppLogOutSuccessState extends AppStates {}

class AppLogOutErrorState extends AppStates {}

//send Email states
class AppSendEmailSuccessState extends AppStates {
  final SendEmailModel? model;

  AppSendEmailSuccessState(this.model);
}

class AppSendEmailErrorState extends AppStates {}

class AppSendEmailLoadingState extends AppStates {}

//send make favorite states
class AppMakeFavoriteSuccessState extends AppStates {
  final FavoriteModel? model;

  AppMakeFavoriteSuccessState(this.model);
}

class AppMakeFavoriteErrorState extends AppStates {}

class AppMakeFavoriteLoadingState extends AppStates {}

//send make rate states
class AppMakeRateSuccessState extends AppStates {
  final RateModel? model;

  AppMakeRateSuccessState(this.model);
}

class AppMakeRateErrorState extends AppStates {}

class AppMakeRateLoadingState extends AppStates {}

//get user rate
//get food advices states
class AppGetUserRateSuccessState extends AppStates {
  final UserRatesModel? model;

  AppGetUserRateSuccessState(this.model);
}

class AppGetUserRateErrorState extends AppStates {}

class AppGetUserRateLoadingState extends AppStates {}

//reset Password states
class AppRestPasswordSuccessState extends AppStates {
  final ResetPasswordModel? model;

  AppRestPasswordSuccessState(this.model);
}

class AppRestPasswordErrorState extends AppStates {}

class AppRestPasswordLoadingState extends AppStates {}

//change password states
class AppChangePasswordSuccessState extends AppStates {
  final ResetPasswordModel? model;

  AppChangePasswordSuccessState(this.model);
}

class AppChangePasswordErrorState extends AppStates {}

class AppChangePasswordLoadingState extends AppStates {}

//get packages states

class AppGetPackagesSuccessState extends AppStates {
  final PackagesModel? model;

  AppGetPackagesSuccessState(this.model);
}

class AppGetPackagesErrorState extends AppStates {}

class AppGetPackagesLoadingState extends AppStates {}

//get food advices states
class AppGetFoodAdvicesSuccessState extends AppStates {
  final FoodAdvices? model;

  AppGetFoodAdvicesSuccessState(this.model);
}

class AppGetFoodAdvicesErrorState extends AppStates {}

class AppGetFoodAdvicesLoadingState extends AppStates {}

//get train advices states
class AppGetTrainAdvicesSuccessState extends AppStates {
  final TrainAdvicesModel? model;

  AppGetTrainAdvicesSuccessState(this.model);
}

class AppGetTrainAdvicesErrorState extends AppStates {}

class AppGetTrainAdvicesLoadingState extends AppStates {}

//make contact states
class AppMakeContactSuccessState extends AppStates {
  final ContactModel? model;

  AppMakeContactSuccessState(this.model);
}

class AppMakeContactErrorState extends AppStates {}

class AppMakeContactLoadingState extends AppStates {}

//update profile states
class AppUpdateProfileSuccessState extends AppStates {
  final UpdateProfileModel model;
  AppUpdateProfileSuccessState(this.model);
}

class AppUpdateProfileErrorState extends AppStates {}

class AppUpdateProfileLoadingState extends AppStates {}

//get training states
class AppGetTrainingSuccessState extends AppStates {
  final TrainingModel? model;

  AppGetTrainingSuccessState(this.model);
}

class AppGetTrainingErrorState extends AppStates {}

class AppGetTrainingLoadingState extends AppStates {}

//get training plan states
class AppGetTrainingPlanSuccessState extends AppStates {
  final TrainPlanModel? model;

  AppGetTrainingPlanSuccessState(this.model);
}

class AppGetTrainingPlanErrorState extends AppStates {}

class AppGetTrainingPlanLoadingState extends AppStates {}

//get food plan states
class AppGetFoodPlanSuccessState extends AppStates {
  final FoodPlanModel? model;

  AppGetFoodPlanSuccessState(this.model);
}

class AppGetFoodPlanErrorState extends AppStates {}

class AppGetFoodPlanLoadingState extends AppStates {}

//get Train and offers states
class AppGetTrainAndOffersSuccessState extends AppStates {
  final TrainingOffersModel? model;

  AppGetTrainAndOffersSuccessState(this.model);
}

class AppGetTrainAndOffersErrorState extends AppStates {}

class AppGetTrainAndOffersLoadingState extends AppStates {}

//pic image states

class AppPickImageSuccessState extends AppStates {}

class AppPickImageErrorState extends AppStates {}

class AppRemovePickImageState extends AppStates {}

//get make request states
class AppMakeRequestSuccessState extends AppStates {
  final RequestModel? model;

  AppMakeRequestSuccessState(this.model);
}

class AppMakeRequestErrorState extends AppStates {}

class AppMakeRequestLoadingState extends AppStates {}
