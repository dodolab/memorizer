import 'package:memorizer/models/category_card.dart';

class CategoryPageResult {
  final int pageIndex;
  final int totalResults;
  final int totalPages;
  final List<CategoryCard> categories;

  CategoryPageResult.fromJSON(Map<String, dynamic> json)
      : pageIndex = json['page'],
        totalResults = json['total_results'],
        totalPages = json['total_pages'],
        categories = (json['results'] as List).map((json) => CategoryCard.fromJSON(json)).toList();
}