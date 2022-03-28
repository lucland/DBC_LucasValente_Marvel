import 'package:dbc_lucas_valente/bloc/character_cubit.dart';
import 'package:dbc_lucas_valente/bloc/character_state.dart';
import 'package:dbc_lucas_valente/model/character.dart';
import 'package:dbc_lucas_valente/presentation/widgets/loading_indicator.dart';
import 'package:dbc_lucas_valente/styles/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatefulWidget {
  final Character? character;
  const DetailScreen({Key? key, @required this.character}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final CharactersCubit _charactersCubit = CharactersCubit();
  late Character? _character;

  @override
  void initState() {
    super.initState();
    _charactersCubit.getCharacter(widget.character!.id.toString());

    _charactersCubit.stream.listen((state) {
      if (state is CharacterStateLoaded) {
        _character = state.character;
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
            Text("| ${widget.character?.name}",
                style: const TextStyle(
                    fontSize: 20,
                    wordSpacing: 0.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Balsamiq',
                    color: Colors.white)),
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
                    return Column(
                      children: [
                        Text(_character?.name ?? "",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Balsamiq')),
                        Text(_character?.description ?? "",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Balsamiq')),
                        Text(_character?.modified ?? "",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Balsamiq')),
                        Text(_character?.comics?.items?.first?.name ?? ""),
                      ],
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
