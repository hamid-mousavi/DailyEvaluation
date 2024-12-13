import 'package:hive/hive.dart';

part 'daily_evaluation.g.dart';
@HiveType(typeId: 0)
class DailyEvaluation {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final int spiritualScore;

  @HiveField(2)
  final int physicalScore;

  @HiveField(3)
  final int mentalScore;

  @HiveField(4)
  final String notes;

  DailyEvaluation({
    required this.date,
    required this.spiritualScore,
    required this.physicalScore,
    required this.mentalScore,
    required this.notes,
  });
}
