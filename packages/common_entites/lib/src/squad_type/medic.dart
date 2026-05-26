import 'package:common_entites/common_entites.dart';
import 'package:common_entites/src/squad_type/squad_modifier.dart';

class Medic extends SquadModifier {
  @override
  Future<bool> play({
    required PlayField field,
    required CardZone zone,
    required Player player,
    required SquadCard card,
  }) async {
    final stash = switch (player) {
      Player.player1 => field.player1Stash,
      Player.player2 => field.player2Stash,
    };

    final cardForRestore = await field.restoreCard(
      stash.whereType<SquadCard>().toList(),
    );

    if (cardForRestore != null && cardForRestore.zone != null) {
      field.playSquadCard(cardForRestore, player, cardForRestore.zone!);
    }

    return true;
  }
}
