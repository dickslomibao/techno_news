import 'package:flutter/material.dart';
import 'package:techno_news/model/category.dart';
import 'package:techno_news/services/category_services.dart';

class NewsCategoryController extends ChangeNotifier {
  //used in explore
  String active = "";
  List<Category> categories = [];
  List<String> selectedCategory = [];
  Future<void> getCategory() async {
    categories = await categoryServices.getAllCategory();
    if (categories.isNotEmpty) {
      active = categories.first.id;
    }
  }

  addSelectedCategory(String id) {
    if (selectedCategory.contains(id)) {
      selectedCategory.remove(id);
    } else {
      selectedCategory.add(id);
    }
    notifyListeners();
  }

  removeSelectedCategory(String id) {
    selectedCategory.remove(id);
    notifyListeners();
  }

  changeActiveValue(String id) {
    if (id != active) {
      active = id;
      notifyListeners();
    }
  }
}
