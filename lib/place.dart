class Place {
  final int id;
  final String title;
  final String image;

  Place({required this.id, required this.title, required this.image});

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['Place_Id'],
      title: map['Title'],
      image: map['Image'], // فقط اسم الملف، نكمل URL بعدين
    );
  }
}