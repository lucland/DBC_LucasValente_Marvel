import 'package:dbc_lucas_valente/bloc/character_cubit.dart';
import 'package:dbc_lucas_valente/bloc/character_state.dart';
import 'package:dbc_lucas_valente/model/character.dart';
import 'package:dbc_lucas_valente/presentation/widgets/character_card.dart';
import 'package:dbc_lucas_valente/presentation/widgets/loading_indicator.dart';
import 'package:dbc_lucas_valente/styles/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CharactersCubit _charactersCubit = CharactersCubit();
  final _controller = ScrollController();
  final List<Character> _characters = [];

  @override
  void initState() {
    super.initState();
    _charactersCubit.getCharacters();

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent &&
          _characters.isNotEmpty) {
        _charactersCubit.getCharacters(offset: _characters.length);
      }
    });

    _charactersCubit.stream.listen((event) {
      if (event is CharacterListLoaded) {
        _characters.addAll(event.characters!);
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
            const Text("| All Characters",
                style: TextStyle(
                    fontSize: 20,
                    wordSpacing: 0.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Balsamiq',
                    color: CustomColor.white)),
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
                  if (state is CharactersListLoading) {
                    return const LoadingIndicator();
                  }
                  if (state is CharacterListLoaded) {
                    return ListView.builder(
                      controller: _controller,
                      itemCount: _characters.length,
                      itemBuilder: (context, index) {
                        return index == _characters.length - 1
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: LoadingIndicator(),
                              )
                            : CharacterCard(character: _characters[index]);
                      },
                    );
                  }
                  return Container();
                },
              ),
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
      ),
    );
  }
}
