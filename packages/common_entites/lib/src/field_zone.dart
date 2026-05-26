import 'package:collection/collection.dart';
import 'package:common_entites/common_entites.dart';

class FieldZone {
  final CardZone zone;
  Set<FieldEffect> effects;

  FieldZone({
    required this.zone,
    required this.effects,
  });

  List<FieldEffect> get effectsByPriority => effects.sorted(
    (a, b) => a.priority.compareTo(b.priority),
  );
}
