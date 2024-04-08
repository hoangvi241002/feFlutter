import 'package:flutter/cupertino.dart';

import '../utils/dimensions.dart';

class SmallText extends StatelessWidget {
  final Color color;
  final String text;
  double size;
  double height;
  SmallText({super.key, this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size=0,
    this.height=1.2,});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size==0?Dimensions.font12:size,
        height: height,
      ),
    );
  }
}
