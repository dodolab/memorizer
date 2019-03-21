
class CategoryCard extends Object {
  final int id;
  final String title;

  CategoryCard(this.id, this.title);

  CategoryCard.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'];

  @override
  bool operator==(dynamic other) => identical(this, other) || this.id == other.id;

  @override
  int get hashCode => id;
}