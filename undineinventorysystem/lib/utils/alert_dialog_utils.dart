import 'package:flutter/material.dart';

class AlertDialogUtils {
  static void showErrorAlertDialog(BuildContext context,
      {required String title,
      required String message,
      String buttonText = 'OK',
      VoidCallback? buttonAction,
      Color buttonColor = const Color.fromARGB(156, 5, 22, 154)}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          contentPadding: const EdgeInsets.only(top: 20.0),
          titlePadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 25.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ConstrainedBox(
                constraints:
                    const BoxConstraints.tightFor(width: 120, height: 40),
                child: ElevatedButton(
                  onPressed: buttonAction ?? () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                    ),
                    elevation: 2,
                  ),
                  child: Text(buttonText),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        );
      },
    );
  }
}
