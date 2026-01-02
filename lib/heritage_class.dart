class HeritageDetailsModel {
  final int id;
  final String title;
  final String story;
  final String cost;
  final String weather;
  final String image;

  HeritageDetailsModel({
    required this.id,
    required this.title,
    required this.story,
    required this.cost,
    required this.weather,
    required this.image,
  });

  factory HeritageDetailsModel.fromMap(Map<String, dynamic> map) {
    return HeritageDetailsModel(
      id: map['Heritage_id'],
      title: map['Heritage_Title'],
      story: map['Story'],
      cost: map['Cost'],
      weather: map['Weather'],
      image: map['Main_Image'],
    );
  }
}