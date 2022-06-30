import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/screens/chats_screen.dart';
import 'package:social_app/screens/feeds_screen.dart';
import 'package:social_app/screens/profile_screen.dart';
import 'package:social_app/screens/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/network/local.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;




class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel? userModel ;

  void getUserDate(){
    uId = CacheHelper.getData(key: 'uId');
    emit(AppGetUserLoadingState());

     FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .get()
        .then((value) {
          userModel = UserModel.fromJson(value.data());
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

  File? profileImage;
  var picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null){
      profileImage = File(pickedFile.path);
      emit(AppProfileImagePickedSuccessState());
    }else {
      print('No image selected');
      emit(AppProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null){
      coverImage = File(pickedFile.path);
      emit(AppCoverImagePickedSuccessState());
    }else {
      print('No image selected');
      emit(AppCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,})
  {
    emit(AppProfileUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
         value.ref.getDownloadURL().then((value) {
           updateUser(
               name: name,
               phone: phone,
               bio: bio,
             image: value
           );
           print(value);
         }).catchError((error){
           print(error.toString());
           print(AppUploadProfileImageErrorState());
         });
    }).catchError((error){
      print(error.toString());
      print(AppUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio
}){
    emit(AppCoverUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
            cover: value
        );
        print(value);
      }).catchError((error){
        print(error.toString());
        print(AppUploadCoverImageErrorState());
      });
    }).catchError((error){
      print(error.toString());
      print(AppUploadCoverImageErrorState());
    });
  }

  void updateUser({
  required String name,
  required String phone,
  required String bio,
    String? image,
    String? cover,
}){
    emit(AppUserUpdateLoadingState());
      UserModel? model = UserModel(
        name: name,
        phone: phone,
        bio: bio,
        cover:cover?? userModel!.cover,
        image:image?? userModel!.image,
        email: userModel!.email,
        uId: userModel!.uId,
        isEmailVerified: false,
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uId)
          .update(model.toMap())
          .then((value) {
        getUserDate();
      }).catchError((error){
        print(error.toString());
        emit(AppUserUpdateErrorState());
      });

  }
}