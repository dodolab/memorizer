
import 'package:memorizer/models/LocString.dart';
import 'package:memorizer/models/category_item.dart';

class CategoryContent extends Object {
  final LocString name;
  final List<CategoryItem> items;

  CategoryContent.fromJSON(Map<String, dynamic> json)
      : name = LocString.fromJSON(json['name']),
        items= (json['items'] as List).map((json) => CategoryItem.fromJSON(json)).toList();
}