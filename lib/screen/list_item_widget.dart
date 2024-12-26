import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item_provider.dart';
import '../utils/app_strings.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({super.key, required this.itemIndex});

  final int itemIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Consumer<ItemProvider>(builder: (context, itemProvider, child) {
        final item = itemProvider.items[itemIndex];
        return Card(
          elevation: 5,
          shadowColor: Colors.grey,
          color: Colors.white,
          child: ListTile(
            title: Text(item[AppStrings.name] ?? ''),
            trailing: Transform.translate(
              offset: const Offset(20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => editItemBtnClick(context, item, itemIndex),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      size: 20,
                    ),
                    onPressed: () {
                      if (itemProvider.editItemBool) {
                        itemProvider.changeEditMode(false);
                        itemProvider.clearController();
                      }
                      itemProvider.removeItem(itemIndex);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void editItemBtnClick(
      BuildContext context, Map<String, String> item, int index) {
    final provider = context.read<ItemProvider>();
    provider.changeEditMode(true);
    provider.setEditItemIndex(index);
    FocusScope.of(context).requestFocus(provider.focusItemName);
    provider.nameController.text = item[AppStrings.name] ?? '';
    provider.descriptionController.text = item[AppStrings.description] ?? '';
  }
}
