import 'package:flutter/material.dart';

class UpdateUniversity extends StatefulWidget {
  const UpdateUniversity({super.key});

  @override
  State<UpdateUniversity> createState() => _UpdateUniversityState();
}

class _UpdateUniversityState extends State<UpdateUniversity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update University')),
      body: Center(child: Text('Update your university information here!')),
    );
  }
}
