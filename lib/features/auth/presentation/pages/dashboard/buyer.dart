import 'package:flutter/material.dart';

class Buyer extends StatefulWidget {
  const Buyer({super.key});

  @override
  State<Buyer> createState() => _BuyerState();
}

class _BuyerState extends State<Buyer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buyer Dashboard')),
      body: Center(child: Text('Welcome to the Buyer Dashboard!')),
    );
  }
}
