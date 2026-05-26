import 'dart:async';

import 'package:common_entites/common_entites.dart';

class Scarecrow extends SquadCard {
  Scarecrow({
    required super.id,
  }) : super(
         name: 'Чучело',
         description: 'Пусть стреляют по крестьянам. А нет крестьян - поставьте чучела.',
         ability: 'Чучело',
         availableZones: CardZone.values,
         baseStrength: 0,
         special: false,
         zone: null,
       );

  @override
  Future<bool> play({
    required PlayField field,
    required CardZone zone,
    required Player player,
  }) async {
    final cards = switch (player) {
      Player.player1 => field.player1Cards,
      Player.player2 => field.player2Cards,
    }.whereType<SquadCard>().toList();

    final cardForReplacement = await field.pickCard(cards);
    if (cardForReplacement == null) {
      return false;
    }

    field.removeSquadCard(
      player: player,
      card: cardForReplacement,
      regularRemoval: false,
    );

    final hand = switch (player) {
      Player.player1 => field.player1Hand,
      Player.player2 => field.player2Hand,
    };
    hand.add(cardForReplacement);

    return true;
  }

  @override
  int calcStrength({
    required PlayField field,
    required Player player,
  }) => 0;
}
