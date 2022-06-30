import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/screens/login/cubit/states.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.uid);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState());
    });
  }

  Icon suffix = const Icon(Icons.visibility);
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix = isPassword
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off_outlined);

    emit(LoginChangePasswordVisibilityState());
  }
}
