import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

mixin WidgetDecoration {
  InputDecoration textFieldDecoration(String hint) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      fillColor: AppColors.textFieldGray,
      filled: true,
      hintStyle: const TextStyle(color: Colors.grey),
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(),
      ),
    );
  }
}
