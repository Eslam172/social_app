import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/screens/edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).userModel;
          return Column(
          children: [
            Container(
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
                      child: Image(
                        image: NetworkImage('${userModel!.cover}'),
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 59,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${userModel.name}',
              style: TextStyle(fontFamily: GoogleFonts.aclonica().fontFamily),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${userModel.bio}',
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: OutlinedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12))
                ),
                  onPressed: () {
                  navigateTo(context,  EditProfileScreen());
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Edit Profile',style: TextStyle(
                        fontSize: 16
                      ),),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        IconBroken.Edit,
                        size: 16,
                      )
                    ],
                  )),
            ),
            const SizedBox(height: 20,),
            const Text('Your Content')
          ],
        );
      },
    );
  }
}
