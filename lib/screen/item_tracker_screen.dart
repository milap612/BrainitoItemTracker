import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/dialog_widget.dart';
import '../custom_widgets/form_button_widget.dart';
import '../custom_widgets/form_text_field_widget.dart';
import '../mixin/decoration.dart';
import '../mixin/validator.dart';
import '../providers/item_provider.dart';
import '../utils/app_strings.dart';
import 'list_item_widget.dart';

class ItemTrackerScreen extends StatelessWidget
    with Validator, WidgetDecoration {
  ItemTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.itemTracker)),
      body: Consumer<ItemProvider>(builder: (context, itemProvider, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: itemProvider.searchController,
                decoration: textFieldDecoration(AppStrings.searchItem),
                onChanged: (value) => itemProvider.filterItems(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: itemProvider.items.isEmpty
                  ? const Center(
                      child: Text(AppStrings.noItemsFound),
                    )
                  : ListView.builder(
                      controller: itemProvider.scrollController,
                      itemCount: itemProvider.items.length,
                      itemBuilder: (context, index) => InkWell(
                          onTap: () => DialogWidget.showCustomDialog(
                              context: context, itemIndex: index),
                          child: ListItemWidget(itemIndex: index)),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: itemProvider.formKey,
                child: Column(
                  children: [
                    FormTextFieldWidget(
                      focusNode: itemProvider.focusItemName,
                      textInputType: TextInputType.name,
                      decoration: textFieldDecoration(AppStrings.name),
                      textEditingController: itemProvider.nameController,
                      maxLines: 1,
                      validatorFun: (String nameValue) =>
                          validateName(nameValue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormTextFieldWidget(
                      textInputType: TextInputType.multiline,
                      decoration: textFieldDecoration(AppStrings.description),
                      textEditingController: itemProvider.descriptionController,
                      maxLines: 3,
                      validatorFun: (String descriptionValue) =>
                          validateDescription(descriptionValue),
                    ),
                    FormButtonWidget(
                      buttonText: itemProvider.editItemBool
                          ? AppStrings.updateItem
                          : AppStrings.addItem,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
