class Province {
  String? id;
  String? name;

  Province({this.id, this.name});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['idProvince'],
      name: json['name'],
    );
  }
}
