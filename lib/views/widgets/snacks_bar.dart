import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
    text,
    textAlign: TextAlign.center,
  )));
}

void showOtpDialog({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onPressed,
}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: const Text(
              "من فضلك ادخل الكود بالارقام الانجليزية",
              textAlign: TextAlign.center,
            ),
            content: DecoratedBox(
              decoration: BoxDecoration( border: Border.all(width: 1)),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                TextField(
                  textAlign: TextAlign.center,
                  controller: codeController,
                ),
              ]),
            ),
            actions: [
              TextButton(onPressed: onPressed, child: const Text("تم"))
            ],
          ));
}


