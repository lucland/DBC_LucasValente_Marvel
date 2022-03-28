import 'package:dbc_lucas_valente/bloc/character_cubit.dart';
import 'package:dbc_lucas_valente/presentation/screens/detail_screen.dart';
import 'package:dbc_lucas_valente/presentation/screens/home_screen.dart';
import 'package:dbc_lucas_valente/repository/character_repository.dart';
import 'package:dbc_lucas_valente/styles/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CharacterRepository>(
          create: (context) => CharacterRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => CharactersCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: CustomColor.primary,
          ),
          home: const HomeScreen(),
          routes: {
            '/home': (context) => const HomeScreen(),
            '/detail': (context) => const DetailScreen(),
          },
        ),
      ),
    );
  }
}
