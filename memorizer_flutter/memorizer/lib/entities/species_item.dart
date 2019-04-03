
import 'package:memorizer/entities/loc_string.dart';

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