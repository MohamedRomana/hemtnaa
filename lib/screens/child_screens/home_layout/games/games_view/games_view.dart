import 'package:flutter/material.dart';
import 'widgets/focus_games/focus_games.dart';
import 'widgets/memory_game/memory_game.dart';
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
              : index == 2
              ? const FocusGames()
              : index == 3
              ? const MemoryGame()
              : Container(),
    );
  }
}
