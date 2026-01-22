import 'package:flutter/material.dart';

class AppDialog {
  /// Simple confirmation dialog
  ///


  static Future<bool?> showConfirmDialog({
    required BuildContext context,
    String title = "Confirm",
    String message = "Are you sure?",
    String positiveText = "Yes",
    String negativeText = "No",
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(negativeText),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(positiveText),
            ),
          ],
        );
      },
    );
  }
}


class EditNameDialog {
  static Future<String?> show({
    required BuildContext context,
    String title = "Edit Name",
    String hintMsg = "Enter name ",
    String initialValue = "",
  }) {
    final TextEditingController controller =
    TextEditingController(text: initialValue);

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(title),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText :hintMsg,
              border: const OutlineInputBorder(),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, controller.text.trim());
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}

