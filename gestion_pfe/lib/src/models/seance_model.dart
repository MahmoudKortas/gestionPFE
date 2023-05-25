import 'dart:convert';

List<Seance> seanceFromJson(String str) =>
    List<Seance>.from(json.decode(str).map((x) => Seance.fromJson(x)));

String seanceToJson(List<Seance> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson()))); 

class Seance {
  int? idSeance;
  String? description;

  Seance({this.idSeance, this.description});
  Seance.fromJson(Map<String, dynamic> json) {
    idSeance = json['idSeance'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idSeance'] = idSeance;
    data['description'] = description;
    return data;
  }

  @override
  String toString() {
    return 'Seance(idSeance: $idSeance, description: $description)';
  }
}
