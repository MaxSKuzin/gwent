import 'package:common_entites/common_entites.dart';

abstract class LeaderCard extends CoreCard {
  bool used;

  LeaderCard({
    required super.name,
    required super.description,
    required super.ability,
    required super.id,
    this.used = false,
  });

  void play();
}
