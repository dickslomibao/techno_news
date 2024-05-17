import 'package:flutter/material.dart';
import 'package:techno_news/model/category.dart';
import 'package:techno_news/services/category_services.dart';

class NewsCategoryController extends ChangeNotifier {
  List<Category> categories = [];
  List<String> selectedCategory = [];
  Future<void> getCategory() async {
    categories = await categoryServices.getAllCategory();
  }

  addSelectedCategory(String id) {
    if (selectedCategory.contains(id)) {
      selectedCategory.remove(id);
    } else {
      selectedCategory.add(id);
    }
    notifyListeners();
  }
}
