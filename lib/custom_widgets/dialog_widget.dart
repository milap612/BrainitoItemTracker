import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item_provider.dart';
import '../utils/app_strings.dart';

class DialogWidget extends StatelessWidget {
  final int itemIndex;

  const DialogWidget({
    super.key,
    required this.itemIndex,
  });

  @override
  Widget build(BuildContext context) {
    final item = context.read<ItemProvider>().items[itemIndex];
    return AlertDialog(
      title: Text(item[AppStrings.name]!),
      content: SingleChildScrollView(child: Text(item[AppStrings.description]!)),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(AppStrings.ok),
        ),
      ],
    );
  }

  static Future<void> showCustomDialog({
    required BuildContext context,
    required int itemIndex,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWidget(itemIndex: itemIndex);
      },
    );
  }
}
