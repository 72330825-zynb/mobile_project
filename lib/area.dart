class Area {
  final int id;
  final String name;

  Area({required this.id, required this.name});

  factory Area.fromMap(Map<String, dynamic> map) {
    return Area(
      id: map['area_id'],
      name: map['area_name'],
    );
  }
}
