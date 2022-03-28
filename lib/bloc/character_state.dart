import 'package:dbc_lucas_valente/model/character.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class CharactersState extends Equatable {
  const CharactersState();
}

class CharacterStateInitial extends CharactersState {
  @override
  List<Object> get props => [];
}

class CharacterStateLoading extends CharactersState {
  @override
  List<Object> get props => [];
}

class CharacterStateLoaded extends CharactersState {
  final Character? character;
  CharacterStateLoaded({@required this.character});

  @override
  List<Object> get props => [character!];
}

class CharacterStateError extends CharactersState {
  final String? message;

  CharacterStateError({@required this.message});

  @override
  List<Object> get props => [message!];
}

class CharacterListStateInitial extends CharactersState {
  @override
  List<Object> get props => [];
}

class CharactersListLoading extends CharactersState {
  @override
  List<Object> get props => [];
}

class CharacterListLoaded extends CharactersState {
  final List<Character>? characters;

  CharacterListLoaded({@required this.characters});

  @override
  List<Object> get props => [characters!];
}
