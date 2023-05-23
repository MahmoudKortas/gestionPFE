import 'dart:convert';

List<Seance> seanceFromJson(String str) =>
    List<Seance>.from(json.decode(str).map((x) => Seance.fromJson(x)));

String seanceToJson(List<Seance> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson()))); 

class Seance {
  int? idseance;
  String? description;

  Seance({this.idseance, this.description});
  Seance.fromJson(Map<String, dynamic> json) {
    idseance = json['idseance'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idseance'] = idseance;
    data['description'] = description;
    return data;
  }

  @override
  String toString() {
    return 'Seance(idseance: $idseance, description: $description)';
  }
}
