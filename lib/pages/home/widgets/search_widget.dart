import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';
import 'package:khoaluan_flutter/widgets/big_text.dart';
import 'package:khoaluan_flutter/widgets/small_text.dart';

class SearchWidget extends StatelessWidget {

  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final void Function()? onEditingComplete;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final String? hintText;

  const SearchWidget({super.key,
    this.keyboardType,
    this.controller,
    this.onEditingComplete,
    required this.obscureText,
    this.suffixIcon,
    this.validator,
    this.prefixIcon, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(Dimensions.height10,),
      padding: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: Dimensions.width20/10),
        borderRadius: BorderRadius.circular(Dimensions.radius20)
      ),
      child: SingleChildScrollView(
        child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            onEditingComplete: onEditingComplete,
            obscureText: obscureText ?? false,
            style: TextStyle(
              color: Colors.grey,
              fontSize: Dimensions.font16,
              fontWeight: FontWeight.normal,
            ),
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: Dimensions.font16,
                fontWeight: FontWeight.normal,
              ),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
            ),
        ),
      ),
    );
  }
}
