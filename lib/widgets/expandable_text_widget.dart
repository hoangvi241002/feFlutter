import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khoaluan_flutter/utils/dimensions.dart';
import 'package:khoaluan_flutter/widgets/small_text.dart';

import '../utils/colors.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = false;
  double textHeight = Dimensions.screenHeight / 7.33;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt(), widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(color: AppColors.paraColor, size: Dimensions.font16, text: firstHalf)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hiddenText ? (firstHalf + secondHalf) : (firstHalf + "..."),
                  style: TextStyle(
                    color: AppColors.paraColor,
                    fontSize: Dimensions.font16,
                  ),
                  softWrap: true, // This allows text to wrap to the next line
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                          size: Dimensions.font16,
                          text: hiddenText ? 'Show less' : 'Show more',
                          color: AppColors.mainColor),
                      Icon(
                          hiddenText ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                          color: AppColors.mainColor)
                    ],
                  ),
                )
              ],
            ),
          );
        }

}
