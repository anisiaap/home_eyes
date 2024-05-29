import 'package:flutter/material.dart';

class UiHelper {
  static Widget CustomTextField(TextEditingController controller, String hintText, IconData icon, bool obscureText, {String? placeholder, Color? placeholderColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.black), // Default text color
        decoration: InputDecoration(
          hintText: placeholder ?? hintText, // Use placeholder if provided, otherwise use hintText
          hintStyle: TextStyle(color: placeholderColor ?? Colors.black), // Default placeholder color
          icon: Icon(
            icon,
            color: Colors.black, // Default icon color
          ),
          border: UnderlineInputBorder(),
        ),
      ),
    );
  }
  static Widget CustomButton(VoidCallback onPressed, String text, {Color? buttonColor, Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor ?? Colors.white, backgroundColor: buttonColor ?? Colors.purple, // Default text color
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor ?? Colors.white), // Default text color
        ),
      ),
    );
  }

  static CustomAlertBox(BuildContext context, String text) {
    final themeData  = Theme.of(context);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(text),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok"))
            ],
          );
        });
  }
}
