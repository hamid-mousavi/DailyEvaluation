
import 'package:hive/hive.dart';

part 'criterion.g.dart';

@HiveType(typeId: 1)
class Criterion {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final int weight;

  Criterion({required this.name, required this.category, required this.weight});
}
