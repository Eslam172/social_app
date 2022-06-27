import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/screens/chats_screen.dart';
import 'package:social_app/screens/feeds_screen.dart';
import 'package:social_app/screens/profile_screen.dart';
import 'package:social_app/screens/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/states.dart';



class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

   var user = UserModel();

  void getUserDate(){
    emit(AppGetUserLoadingState());

    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .get()
        .then((value) {
          user = UserModel.fromJson(value.data());
      emit(AppGetUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetUserErrorState());
    });
  }

  int currentIndex=0;

  List<Widget> screens =[
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const ProfileScreen(),
  ];

  List<String> titles =[
    'Home',
    'Chats',
    'Add Users',
    'Profile',
  ];

  void changeBottomNav(int index){
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }
}