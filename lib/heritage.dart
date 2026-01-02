class HeritageModel {
  final int id;
  final String title;
  final String image;

  HeritageModel({
    required this.id,
    required this.title,
    required this.image,
  });

  factory HeritageModel.fromMap(Map<String, dynamic> map) {
    return HeritageModel(
      id: map['Heritage_Id'],
      title: map['Heritage_Title'],
      image: map['Main_Image'],
    );
  }
}