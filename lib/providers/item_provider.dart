import 'package:flutter/material.dart';

import '../utils/app_strings.dart';

class ItemProvider with ChangeNotifier {
  final FocusNode focusItemName = FocusNode();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final ScrollController scrollController = ScrollController();
  final List<Map<String, String>> _items = [];
  List<Map<String, String>> _filteredItems = [];
  bool editItemBool = false;
  int editItemIndex = 0;

  List<Map<String, String>> get items => List.unmodifiable(_filteredItems);

  void addItem() {
    _items.add({
      AppStrings.id: DateTime.now().millisecondsSinceEpoch.toString(),
      AppStrings.name: nameController.text,
      AppStrings.description: descriptionController.text,
    });
    clearController();
    _updateFilteredItems();
    notifyListeners();
  }

  void editItem() {
    final editItem = _filteredItems[editItemIndex];
    for (var item in _items) {
      if (item[AppStrings.id] == editItem[AppStrings.id]) {
        item[AppStrings.name] = nameController.text;
        item[AppStrings.description] = descriptionController.text;
        break;
      }
    }

    clearController();
    _updateFilteredItems();
    notifyListeners();
  }

  void removeItem(int index) {
    final deleteItem = _filteredItems[index];
    _items.removeWhere(
        (mapItem) => mapItem[AppStrings.id] == deleteItem[AppStrings.id]);
    clearController();
    _updateFilteredItems();
    notifyListeners();
  }

  void changeEditMode(bool editItemMode) {
    editItemBool = editItemMode;
    notifyListeners();
  }

  void setEditItemIndex(int itemIndex) {
    editItemIndex = itemIndex;
  }

  void filterItems() {
    var query = searchController.text.toString();
    if (query.isEmpty) {
      _filteredItems = List.from(_items);
    } else {
      _filteredItems = _items
          .where((item) =>
              item[AppStrings.name]!.contains(query) ||
              item[AppStrings.description]!.contains(query))
          .toList();
    }
    notifyListeners();
  }

  void _updateFilteredItems() {
    _filteredItems = List.from(_items);
  }

  void clearController() {
    nameController.clear();
    descriptionController.clear();
    searchController.clear();
    notifyListeners();
  }
}
