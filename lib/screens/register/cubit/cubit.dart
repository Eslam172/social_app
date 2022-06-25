import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/screens/register/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,

  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid,
      );
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState());
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
}){
    UserModel model = UserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap()).then((value) {
          emit(CreateSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CreateErrorState());
    });
}

  Icon suffix = const Icon(Icons.visibility);
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix = isPassword
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off_outlined);

    emit(RegisterChangePasswordVisibilityState());
  }
}
