import 'package:flutter/material.dart';
import 'package:undineinventorysystem/utils/alert_dialog_utils.dart';

enum UpdateError {
  none,
  firebaseError,
  invalidAmount,
  userCancelled,
  itemNotFound,
  categoryNotFound,
  invalidData,
}

class ErrorHandler {
  static void handleError(UpdateError error, BuildContext context) {
    switch (error) {
      case UpdateError.firebaseError:
        AlertDialogUtils.showErrorAlertDialog(
          context,
          title: 'Network Error',
          message:
              'Failed to update due to a network error. Please try again later.',
        );
        break;

      case UpdateError.invalidAmount:
        AlertDialogUtils.showErrorAlertDialog(
          context,
          title: 'Invalid Amount',
          message: 'The amount entered is invalid. Please check and try again.',
        );
        break;

      case UpdateError.itemNotFound:
        AlertDialogUtils.showErrorAlertDialog(context,
            title: "Item Not Found",
            message:
                "Item is not found. Check if it exists in database or check for spelling mistake.");
        break;

      case UpdateError.userCancelled:
        break;

      case UpdateError.categoryNotFound:
        AlertDialogUtils.showDeleteConfirmationDialog(context,
            title: "Category Not Found",
            message: "Category is not found. Check if it exists in database.");
        break;

      case UpdateError.invalidData:
        AlertDialogUtils.showDeleteConfirmationDialog(context,
            title: "Invalid Data",
            message: "Data is invalid. Data is not a list.");
        break;

      case UpdateError.none:
        break;

      default:
        AlertDialogUtils.showErrorAlertDialog(
          context,
          title: 'Unexpected Error',
          message: 'An unexpected error occurred. Please try again.',
        );
        break;
    }
  }
}
