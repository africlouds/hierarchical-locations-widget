import 'package:flutter/material.dart';
import 'package:hierarchical_locations_widget/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final String? label;
  final String? validationMessage;
  final String? helpText;
  final double? width, height;
  final double? marginLeft;
  final Color backgroundColor;

  const TextFieldContainer({
    Key? key,
    required this.child,
    this.label,
    this.validationMessage,
    this.width = 250,
    this.height = 40,
    this.marginLeft = 20,
    this.backgroundColor = bgColor,
    this.helpText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: Alignment.bottomLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (label != null)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    label!.toString(),
                    style: TextStyle(
                        color: Colors.black.withOpacity(1.0), fontSize: 13),
                  ),
                ),
              if (validationMessage != null)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: const Text(
                    "*",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              if (helpText != null)
                InkWell(
                    onTap: () {
                      // helpController.helpComponentText = helpText;
                    },
                    child: const Text(
                      "?",
                      style: TextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ))
            ],
          ),
          Stack(children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              height: height,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: marginLeft ?? 20), child: child)
          ]),
        ],
      ),
    );
  }
}
