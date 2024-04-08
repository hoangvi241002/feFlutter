import 'package:flutter/cupertino.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';

class BigText extends StatelessWidget {
  final Color color;
  final String text;
  double size;
  TextOverflow overflow;
  BigText({super.key, this.color = const Color(0xFF332d2b),
    required this.text,
    this.size=0,
    this.overflow=TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size==0?Dimensions.font23:size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
