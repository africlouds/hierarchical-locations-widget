import 'package:flutter/material.dart';

Future<void> showClosableDialog(BuildContext context, Widget child,
    double width, double? height, String? title) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      content: SizedBox(
        width: width,
        height: height!,
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(
              title ?? "",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.close,
                    size: 22,
                  ),
                ))
          ]),
          Container(decoration: const BoxDecoration(), child: child)
        ]),
      ),
    ),
  );
}
