import 'package:flutter/material.dart';

class AddPostScreen extends StatelessWidget{
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Post'),
        titleSpacing: 5,
      ),
    );
  }
}
