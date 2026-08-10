import 'package:flutter/material.dart';

class UpdateEmail extends StatefulWidget {
  const UpdateEmail({super.key});

  @override
  State<UpdateEmail> createState() => _UpdateEmailState();
}

class _UpdateEmailState extends State<UpdateEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Email')),
      body: Center(child: Text('Update your email address here!')),
    );
  }
}
