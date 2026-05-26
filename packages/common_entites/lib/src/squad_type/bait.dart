import 'dart:async';

import 'package:common_entites/common_entites.dart';

mixin Bait on SquadCard {
  @override
  FutureOr<void> remove(
    PlayField field,
    Player player, {
    bool goesToShash = true,
  }) {
    
  }
}
