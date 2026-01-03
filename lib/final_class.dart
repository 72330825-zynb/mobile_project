class PlaceDetailsModel {
  final int id;
  final String title;
  final String image;
  final double rating;
  final bool favorite;
  final String menu;

  PlaceDetailsModel({
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
    required this.favorite,
    required this.menu,
  });

  factory PlaceDetailsModel.fromMap(Map<String, dynamic> map) {
    return PlaceDetailsModel(
      id: map['Place_Id'],
      title: map['Title'],
      image: map['Image'],
      rating: (map['Rating'] as num).toDouble(),
      favorite: map['Favorite'] == 1 || map['Favorite'] == true,
      menu: map['Menu'] ?? "",
    );
  }
}
