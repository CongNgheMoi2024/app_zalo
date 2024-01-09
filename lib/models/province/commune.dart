class Commune {
  String idCommune;
  String name;
  String? idDistrict;

  Commune({this.idCommune = "", this.name = "", this.idDistrict});

  factory Commune.fromJson(Map<String, dynamic> json) {
    return Commune(
      idCommune: json['idCommune'],
      name: json['name'],
      idDistrict: json['idDistrict'],
    );
  }
}
