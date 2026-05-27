import 'package:common_entites/src/card_zone.dart';
import 'package:common_entites/src/play_field.dart';
import 'package:common_entites/src/player.dart';
import 'package:common_entites/src/squad_type/squad_modifier.dart';
import 'package:common_entites/src/zoned_card.dart';

class Scarecrow extends SquadModifier {
  @override
  Future<bool> play({
    required PlayField field,
    required CardZone zone,
    required Player player,
    required SquadCard card,
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
    required SquadCard card,
  }) => 0;
}
