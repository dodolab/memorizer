import 'package:memorizer/models/category_card.dart';

class CategoryPageResult {
  final List<CategoryCard> categories;

  int get totalResults {
    return categories.length;
  }

  CategoryPageResult.fromJSON(Map<String, dynamic> json)
      : categories = (json['categories'] as List).map((json) => CategoryCard.fromJSON(json)).toList();
}