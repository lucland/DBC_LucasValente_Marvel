import 'dart:developer';

import 'package:dbc_lucas_valente/bloc/character_state.dart';
import 'package:dbc_lucas_valente/model/character.dart';
import 'package:dbc_lucas_valente/repository/character_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit() : super(CharacterStateInitial());

  final CharacterRepository characterRepository = CharacterRepository();

  void getCharacters({int offset = 0}) async {
    if (offset == 0) {
      emit(CharactersListLoading());
    }
    try {
      List<Character> characters =
          await characterRepository.getCharacters(offset: offset);
      emit(CharacterListLoaded(characters: characters));
    } catch (e) {
      log(e.toString());
      emit(CharacterStateError(message: e.toString()));
    }
  }

  void getCharacter(String id) async {
    emit(CharacterStateLoading());
    try {
      Character character = await characterRepository.getCharacter(id);
      emit(CharacterStateLoaded(character: character));
    } catch (e) {
      log(e.toString());
      emit(CharacterStateError(message: e.toString()));
    }
  }
}
