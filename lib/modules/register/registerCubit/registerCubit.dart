// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/models/userModel/userModel.dart';
import 'package:gym_app/modules/register/registerCubit/registerStates.dart';
import 'package:gym_app/network/endpoints.dart';
import 'package:gym_app/network/local/cache_Helper.dart';
import 'package:gym_app/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPass = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibility() {
    isPass = !isPass;
    isPass
        ? suffix = Icons.visibility_outlined
        : suffix = Icons.visibility_off_outlined;
    emit(RegisterPasswordShown());
  }

  UserModel? registerModel;
  void userRegister({
    required String email,
    required String phone,
    required String name,
    required String password,
    required String weight,
    required String illnesses,
    required String notes,
    required String sex,
    required String hight,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postDataWithoutToken(url: registerUrl, data: {
      'email': email,
      'mobile': phone,
      'name': name,
      'password': password,
      'length': hight,
      'weight': weight,
      'illnesses': illnesses,
      'notes': notes,
      'sex': sex,
      'onesignal_id': 'lkfjfkj0450jflfjotij5iufdiueiu433i4ujkdnfd',
    }).then((value) {
      print(value.data);
      registerModel = UserModel.fromJson(value.data);
      // print(registerModel!.data!.name);
      print(value.data);
      CacheHelper.saveData(key: 'token', value: registerModel?.success?.token);
      // token = registerModel?.token;
      // AppCubit.get(context).getUserData();
      emit(RegisterSuccessState(registerModel));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState());
    });
  }
}
