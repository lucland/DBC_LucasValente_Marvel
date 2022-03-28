import 'package:dbc_lucas_valente/model/character.dart';
import 'package:dbc_lucas_valente/presentation/screens/detail_screen.dart';
import 'package:dbc_lucas_valente/styles/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CharacterCard extends StatelessWidget {
  final Character? character;
  const CharacterCard({Key? key, @required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: CustomColor.secondary,
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    characterId: character!.id.toString(),
                    characterName: character!.name,
                  ),
                ));
          },
          leading: Container(
            padding: const EdgeInsets.only(right: 12.0),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: CustomColor.white),
              ),
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(character!.thumbnail!.path! +
                  '.' +
                  character!.thumbnail!.extension!),
              radius: 30,
            ),
          ),
          title: Text(
            character!.name!,
            overflow: TextOverflow.clip,
            style: const TextStyle(
                fontSize: 15.0,
                color: CustomColor.white,
                fontFamily: 'Balsamiq',
                fontWeight: FontWeight.w500),
          ),
          subtitle: Row(
            children: <Widget>[
              const Icon(Icons.linear_scale, color: CustomColor.white),
              Text(
                'Hero ID: ${character!.id}',
                overflow: TextOverflow.clip,
                style: const TextStyle(
                    fontSize: 10.0,
                    color: CustomColor.white,
                    fontFamily: 'Balsamiq',
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          trailing: Neumorphic(
            style: const NeumorphicStyle(
                shape: NeumorphicShape.flat,
                depth: 0.5,
                intensity: 1,
                color: CustomColor.red,
                boxShape: NeumorphicBoxShape.circle()),
            child: const Icon(Icons.keyboard_arrow_right,
                color: CustomColor.white, size: 40.0),
          ),
        ),
      ),
    );
  }
}
