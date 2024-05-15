import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  Widget containerContent;
  Color? color;

  CustomAppBar({super.key, required this.containerContent, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        child: SingleChildScrollView(
          child: containerContent,
        ),
      ),
    );
  }
}
