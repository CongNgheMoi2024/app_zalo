class District {
  String? name;
  String? idDistrict;
  String? idCommune;

  District({this.name, this.idDistrict, this.idCommune});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      name: json['name'],
      idDistrict: json['idDistrict'],
      idCommune: json['idCommune'],
    );
  }
}
