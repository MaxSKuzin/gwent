import 'dart:async';

import 'package:common_entites/common_entites.dart';
import 'package:common_entites/src/squad_type/squad_modifier.dart';

class Bait extends SquadModifier {
  @override
  FutureOr<bool?> remove({
    required PlayField field,
    required Player player,
    required SquadCard card,
    bool goesToShash = true,
  }) => null;
}
