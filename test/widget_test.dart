// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dbc_lucas_valente/main.dart';
import 'package:dbc_lucas_valente/model/character.dart';
import 'package:dbc_lucas_valente/presentation/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets(
      "GIVEN a complete character card with no name, WHEN built, THEN it renders correctly",
      (WidgetTester tester) async {
    //GIVEN
    final character = Character(
      name: "",
      id: 1011334,
      description: "TEST DESCRIPTION",
    );

    //WHEN
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CharacterCard(character: character),
      ),
    ));

    //THEN
    expect(find.text("TEST DESCRIPTION"), findsOneWidget);
  });
}
