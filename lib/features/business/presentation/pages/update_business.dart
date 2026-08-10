import 'package:flutter/material.dart';

class UpdateBusiness extends StatefulWidget {
  const UpdateBusiness({super.key});

  @override
  State<UpdateBusiness> createState() => _UpdateBusinessState();
}

class _UpdateBusinessState extends State<UpdateBusiness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Business')),
      body: Center(child: Text('Update your business information here!')),
    );
  }
}
