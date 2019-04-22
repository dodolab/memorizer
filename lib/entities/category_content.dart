
import 'package:memorizer/entities/loc_string.dart';
import 'package:memorizer/entities/species_item.dart';

class CategoryContent extends Object {
  final LocString name;
  final List<SpeciesItem> items;

  CategoryContent.fromJSON(Map<String, dynamic> json)
      : name = LocString.fromJSON(json['name']),
        items= (json['items'] as List).map((json) => SpeciesItem.fromJSON(json)).toList();
}