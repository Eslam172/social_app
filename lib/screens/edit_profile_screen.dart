import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
   EditProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

   File? image;
  var picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null){
      image = File(pickedFile.path);
    }else {
      print('No image selected');
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel =AppCubit.get(context).userModel;
        var profileImage = AppCubit.get(context).profileImage;
        var coverImage = AppCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return  Scaffold(
          appBar: defaultAppBar(context: context, text: 'Edit Profile', actions: [
            TextButton(
                onPressed: () {
                  AppCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text
                  );
                },
                child: const Text('SAVE'),
            ),
            const SizedBox(
              width: 5,
            )
          ]),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(state is AppUserUpdateLoadingState || state is AppProfileUpdateLoadingState || state is AppCoverUpdateLoadingState)
                  const Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5),
                    child:  LinearProgressIndicator(),
                  ),
                if(state is AppUserUpdateLoadingState || state is AppProfileUpdateLoadingState || state is AppCoverUpdateLoadingState)
                  const SizedBox(height: 10,),
                SizedBox(
                  height: 230,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              )),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Image(
                                image: coverImage == null ? NetworkImage('${userModel.cover}')
                                    : FileImage(coverImage) as ImageProvider
                                ,
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                              IconButton(
                                  onPressed: (){
                                    AppCubit.get(context).getCoverImage();
                                  },
                                  icon:  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: primaryColor,
                                    child:  const Icon(IconBroken.Camera,
                                      size: 18,
                                    ),
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 59,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 55,
                              backgroundImage:profileImage == null ? NetworkImage('${userModel.image}')
                                  : FileImage(profileImage) as ImageProvider
                              ,
                            ),
                          ),
                          IconButton(
                              onPressed: (){
                                AppCubit.get(context).getProfileImage();
                              },
                              icon:  CircleAvatar(
                                radius: 15,
                                backgroundColor: primaryColor,
                                child:  const Icon(IconBroken.Camera,
                                  size: 15,
                                ),
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if(AppCubit.get(context).coverImage != null || AppCubit.get(context).profileImage != null)
                  Padding(
                  padding: const EdgeInsets.only(left: 5 , right: 5),
                  child: Row(
                    children: [
                      if(AppCubit.get(context).profileImage != null)
                        Expanded(
                        child: ElevatedButton(
                            onPressed: (){
                              AppCubit.get(context).uploadProfileImage(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text('Update Profile'),
                                 SizedBox(width: 5,),
                                Icon(IconBroken.Edit_Square ,
                                  size: 16,
                                )
                              ],
                            )
                        ),
                      ),
                      if(AppCubit.get(context).coverImage != null && AppCubit.get(context).profileImage != null)
                        const SizedBox(width: 5,),
                      if(AppCubit.get(context).coverImage != null)
                        Expanded(
                        child: ElevatedButton(
                            onPressed: (){
                              AppCubit.get(context).uploadCoverImage(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text('Update Cover'),
                                 SizedBox(width: 5,),
                                Icon(IconBroken.Edit_Square ,
                                  size: 16,
                                )
                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                if(AppCubit.get(context).coverImage != null || AppCubit.get(context).profileImage != null)
                  const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      label: Text('Name'),
                      prefixIcon: Icon(IconBroken.Profile),
                      border: OutlineInputBorder()
                    ),
                    validator: (String? value){
                      return 'Name mus\'t be empty';
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextFormField(
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        label: Text('Bio'),
                        prefixIcon: Icon(IconBroken.Info_Circle),
                        border: OutlineInputBorder()
                    ),
                    validator: (String? value){
                      return 'Bio mus\'t be empty';
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        label: Text('Phone'),
                        prefixIcon: Icon(IconBroken.Call),
                        border: OutlineInputBorder()
                    ),
                    validator: (String? value){
                      return 'Phone mus\'t be empty';
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: ElevatedButton(
                      onPressed: (){

                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:const [
                          Text('LOG OUT'),
                          SizedBox(width: 10,),
                          Icon(IconBroken.Logout)
                        ],
                      )
                  ),
                )
              ],
            ),
          ),

        );
      },
    );
  }
}
