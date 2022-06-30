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
    UserModel? model = UserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      bio: 'write your bio ...',
      image: 'https://img.freepik.com/free-photo/female-enterpreneur-businesswoman-being-disappointed-with-news-from-colleague-reads-message-smartphone-shocked-recieve-responsibility-prepare-difficult-project-tomorrow-s-meeting_273609-2441.jpg?t=st=1656284772~exp=1656285372~hmac=8bde927e8242a353a6f343fd0c07adccf18b2c87588d084d7547c11d5594e333&w=996',
      cover: 'https://img.freepik.com/free-photo/european-woman-with-surprised-expression-dressed-yellow-casual-loose-jacket-pointing-with-index-finger-keeping-her-mouth-wide-open-being-shocked-with-what-she-sees-facial-expressions_273609-8067.jpg?t=st=1656287536~exp=1656288136~hmac=fa2d12a7a35b0fd893025b600712517448c793b1379ccd8403b9543ce3ab59be&w=996',
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
