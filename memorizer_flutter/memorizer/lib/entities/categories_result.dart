import 'package:memorizer/entities/category_content.dart';

class CategoryPageResult {
  final List<CategoryContent> categories;

  int get totalResults {
    return categories.length;
  }

  CategoryPageResult.fromJSON(Map<String, dynamic> json)
      : categories = (json['categories'] as List).map((json) => CategoryContent.fromJSON(json)).toList();
}