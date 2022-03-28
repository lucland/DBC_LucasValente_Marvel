import 'package:dbc_lucas_valente/common/url_endpoints.dart';
import 'package:dbc_lucas_valente/model/character.dart';
import 'package:dbc_lucas_valente/service/dio_connection.dart';

class CharacterRepository {
  final DioConnection dioConnection = DioConnection();
  final UrlEndpoints urlEndpoints = UrlEndpoints();

  Future<Character> getCharacter(String id) async {
    final response =
        await dioConnection.get(urlEndpoints.generateUrl("characters", id: id));
    var data = new Map<String, dynamic>.from(response.data);
    return Character.fromJson(data);
  }

  Future<List<Character>> getCharacters({int offset = 0}) async {
    final response = await dioConnection
        .get(urlEndpoints.generateUrl("characters", offset: offset));
    var data = new Map<String, dynamic>.from(response.data);
    List<Character> characters = data["data"]["results"]
        .map<Character>((json) => Character.fromJson(json))
        .toList();
    return characters;
  }
}
