
import 'package:memorizer/models/LocString.dart';
import 'package:memorizer/models/category_item.dart';

class CategoryCard extends Object {
  final LocString name;
  final List<CategoryItem> items;

  CategoryCard.fromJSON(Map<String, dynamic> json)
      : name = LocString.fromJSON(json['name']),
        items= (json['items'] as List).map((json) => CategoryItem.fromJSON(json)).toList();

}