import 'package:flutter/material.dart';

class AlertDialogUtils {
  static void showErrorAlertDialog(BuildContext context,
      {required String title,
      required String message,
      String buttonText = 'OK',
      VoidCallback? buttonAction,
      Color buttonColor = const Color.fromARGB(218, 1, 15, 58)}) {
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
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
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
                  child: Text(
                    buttonText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        );
      },
    );
  }

  static Future<bool> showDeleteConfirmationDialog(BuildContext context,
      {String title = 'Delete this item?',
      String message = 'Are you sure you want to delete this item?',
      String confirmButtonText = 'Delete item',
      Color confirmButtonColor = const Color.fromARGB(255, 203, 0, 0),
      String cancelButtonText = 'Cancel',
      Color cancelButtonColor = const Color.fromARGB(218, 1, 15, 58)}) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              contentPadding: const EdgeInsets.only(top: 20.0),
              titlePadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0),
              title: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(
                            width: 120, height: 40),
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          style: TextButton.styleFrom(
                            backgroundColor: confirmButtonColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0)),
                            textStyle: const TextStyle(fontSize: 16.0),
                            elevation: 5,
                          ),
                          child: Text(confirmButtonText,
                              style: const TextStyle(color: Colors.white)),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(
                            width: 120, height: 40),
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          style: TextButton.styleFrom(
                            backgroundColor: cancelButtonColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0)),
                            textStyle: const TextStyle(fontSize: 16.0),
                          ),
                          child: Text(cancelButtonText,
                              style: const TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            );
          },
        ) ??
        false;
  }
}
