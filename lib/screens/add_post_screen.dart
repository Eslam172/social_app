import 'package:flutter/material.dart';
import 'package:social_app/shared/components/components.dart';

class AddPostScreen extends StatelessWidget{
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
          context: context,
        text: 'Create Post',

      ),
    );
  }
}
