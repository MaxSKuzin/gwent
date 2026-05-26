import 'dart:async';

import 'package:common_entites/common_entites.dart';

abstract class SquadModifier {
  int? calcStrength({
    required PlayField field,
    required Player player,
    required SquadCard card,
  }) => null;

  FutureOr<bool?> play({
    required PlayField field,
    required CardZone zone,
    required Player player,
    required SquadCard card,
  }) => null;

  FutureOr<void> remove({
    required PlayField field,
    required Player player,
    required SquadCard card,
    bool goesToShash = true,
  }) => null;
}
