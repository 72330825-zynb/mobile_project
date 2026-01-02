class DestinationModel {
  final int id;
  final String name;
  final String image;
  final String details;

  DestinationModel({
    required this.id,
    required this.name,
    required this.image,
    required this.details,
  });

  factory DestinationModel.fromMap(Map<String, dynamic> map) {
    return DestinationModel(
      id: map['Destinations_Id'],
      name: map['Name'],
      image: map['Image'],
      details: map['Details'],
    );
  }
}