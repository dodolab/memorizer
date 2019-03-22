
import 'package:memorizer/models/LocString.dart';
import 'package:memorizer/models/species_item.dart';

class SpeciesItem extends Object {
  final LocString name;
  final List<String> imageUrls;

  String get imageUrl {
    return imageUrls.first;
  }

  SpeciesItem.fromJSON(Map<String, dynamic> json)
      : name = LocString.fromJSON(json['name']),
        imageUrls= (json['images'] as List).map((dyn) => dyn as String).toList();

}