import 'package:dbc_lucas_valente/model/character.dart';

class Data {
  int? offset;
  int? limit;
  int? total;
  int? count;
  List<Character>? characters;

  Data({this.offset, this.limit, this.total, this.count, this.characters});

  Data.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    total = json['total'];
    count = json['count'];
    if (json['results'] != null) {
      characters = <Character>[];
      json['results'].forEach((v) {
        characters!.add(new Character.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['offset'] = this.offset;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['count'] = this.count;
    if (this.characters != null) {
      data['results'] = this.characters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
