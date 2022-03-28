import 'dart:developer';

import 'package:dbc_lucas_valente/bloc/character_cubit.dart';
import 'package:dbc_lucas_valente/bloc/character_state.dart';
import 'package:dbc_lucas_valente/model/character.dart';
import 'package:dbc_lucas_valente/presentation/widgets/loading_indicator.dart';
import 'package:dbc_lucas_valente/styles/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatefulWidget {
  final String? characterId;
  final String? characterName;
  const DetailScreen({Key? key, @required this.characterId, this.characterName})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final CharactersCubit _charactersCubit = CharactersCubit();
  late Character? _character;

  @override
  void initState() {
    super.initState();
    _charactersCubit.getCharacter(widget.characterId.toString());

    _charactersCubit.stream.listen((state) {
      if (state is CharacterStateLoaded) {
        _character = state.character;
        log(_character!.name.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.primary,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/marvel_Logo.png',
              width: 110,
              height: 35,
              fit: BoxFit.contain,
            ),
            Flexible(
              flex: 1,
              child: Text(
                  widget.characterName != null
                      ? "| ${widget.characterName}"
                      : "",
                  style: const TextStyle(
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis,
                      wordSpacing: 0.5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Balsamiq',
                      color: CustomColor.white)),
            ),
          ],
        ),
      ),
      backgroundColor: CustomColor.primary,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CharactersCubit, CharactersState>(
                bloc: _charactersCubit,
                builder: (context, state) {
                  if (state is CharacterStateLoading) {
                    return const LoadingIndicator();
                  }
                  if (state is CharacterStateLoaded) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            _character!.thumbnail!.path! +
                                '.' +
                                _character!.thumbnail!.extension!,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.5,
                            fit: BoxFit.cover,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(
                              color: CustomColor.red,
                              thickness: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _character?.name ?? "",
                              style: const TextStyle(
                                  fontSize: 20,
                                  wordSpacing: 0.5,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Balsamiq',
                                  color: CustomColor.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_character?.description ?? "",
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: CustomColor.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Balsamiq')),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(
                              color: CustomColor.red,
                              thickness: 2,
                            ),
                          ),
                          const Text("APPEARED IN COMICS:",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: CustomColor.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Balsamiq')),
                          const SizedBox(height: 10),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _character?.comics?.items?.length ?? 0,
                            itemBuilder: (context, index) {
                              return ListTile(
                                visualDensity: VisualDensity(horizontal: 0),
                                title: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: CustomColor.primary,
                                    border: Border.all(
                                      color: CustomColor.red,
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _character?.comics?.items
                                              ?.elementAt(index)
                                              ?.name ??
                                          "",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: CustomColor.white,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Balsamiq'),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '© 2022 Lucas Valente for DBC Company',
                              style: TextStyle(
                                fontSize: 12,
                                color: CustomColor.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
