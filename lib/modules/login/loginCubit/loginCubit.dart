// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/models/userModel/userModel.dart';
import 'package:gym_app/modules/login/loginCubit/loginStates.dart';
import 'package:gym_app/network/endpoints.dart';
import 'package:gym_app/network/local/cache_Helper.dart';
import 'package:gym_app/network/remote/dio_helper.dart';
import 'package:gym_app/shared/appCubit/app_cubit.dart';
import 'package:gym_app/shared/const.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPass = true;
  IconData suffix = Icons.visibility;
  void changePasswordVisibility() {
    isPass = !isPass;
    isPass ? suffix = Icons.visibility : suffix = Icons.visibility_off;
    emit(LoginPasswordShown());
  }

  UserModel? loginModel;
  void userLogin(
      {required String phone, required String password, required var context}) {
    emit(LoginLoadingState());
    DioHelper.postDataWithoutToken(url: loginUrl, data: {
      'email': phone,
      'password': password,
    }).then((value) {
      loginModel = UserModel.fromJson(value.data);
      // print(value.data);
      CacheHelper.saveData(key: 'token', value: loginModel?.success?.token);
      token = loginModel?.success?.token;
      AppCubit.get(context).getUserData();
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState());
    });
  }
}
