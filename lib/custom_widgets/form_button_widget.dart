import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item_provider.dart';

class FormButtonWidget extends StatelessWidget {
  const FormButtonWidget({super.key, required this.buttonText});

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ItemProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.sizeOf(context).width,
      height: 70,
      child: ElevatedButton(
        onPressed: () => formButtonPress(context, provider),
        child: Text(
          buttonText,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void formButtonPress(BuildContext context, ItemProvider provider) {
    if (provider.formKey.currentState!.validate()) {
      if (provider.editItemBool) {
        updateItem(context, provider);
      } else {
        addItem(context, provider);
      }
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  void addItem(
    BuildContext context,
    ItemProvider provider,
  ) {
    provider.addItem();
    final controller = provider.scrollController;
    controller.animateTo(
      controller.position.maxScrollExtent + 100,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void updateItem(BuildContext context, ItemProvider provider) {
    provider.editItem();
    provider.scrollController.jumpTo(provider.editItemIndex.toDouble());
    provider.changeEditMode(false);
  }
}
