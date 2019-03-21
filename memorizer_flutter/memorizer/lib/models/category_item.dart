
import 'package:memorizer/models/LocString.dart';
import 'package:memorizer/models/category_item.dart';

class CategoryItem extends Object {
  final LocString name;
  final List<String> imageUrls;

  CategoryItem.fromJSON(Map<String, dynamic> json)
      : name = LocString.fromJSON(json['name']),
        imageUrls= (json['images'] as List).map((dyn) => dyn as String).toList();

}