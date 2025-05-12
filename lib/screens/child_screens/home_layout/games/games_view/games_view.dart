import 'package:flutter/material.dart';
import 'widgets/mystery_games/mystery_games.dart';
import 'widgets/puzzle_games/puzzle_games.dart';

class GamesView extends StatelessWidget {
  final int index;
  const GamesView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          index == 0
              ? const PuzzleGames()
              : index == 1
              ? const MysteryGames()
              : Container(),
    );
  }
}
