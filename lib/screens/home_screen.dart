import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/screens/add_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit =AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:  Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: const Icon(IconBroken.Search)),
              IconButton(
                  onPressed: (){},
                  icon: const Icon(IconBroken.Notification)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (int index){
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat),
                label: 'Chat'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Add_User),
                label: 'Users'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Profile),
                label: 'Settings'
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            mini: true,
            onPressed: (){
              navigateTo(context, AddPostScreen());
            },
            child: Icon(IconBroken.Upload),
          ),
        );
      },
    );
  }
}
