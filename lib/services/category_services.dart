import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techno_news/model/category.dart';

class CategoryServices {
  Future<List<Category>> getAllCategory() async {
    final data = await FirebaseFirestore.instance.collection('category').get();
    return data.docs.map((e) => Category(id: e.id, title: e['title'])).toList();
  }

  Future<Category?> getCategoryWithDocumentId(String id) async {
    final data =
        await FirebaseFirestore.instance.collection('category').doc(id).get();
    return data.exists
        ? Category(id: data.id, title: data.data()!['id'])
        : null;
  }
}

CategoryServices categoryServices = CategoryServices();
