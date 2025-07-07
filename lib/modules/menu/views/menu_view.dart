import 'package:flutter/material.dart';
import 'package:pdf_reader/core/theme/colors.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: primaryColor,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: _body(),
    );
  }

  Widget _body(){
     return Column(
       children: [],
     );
  }
}
