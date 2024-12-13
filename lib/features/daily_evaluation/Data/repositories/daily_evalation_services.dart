
import 'package:daily_ev/features/daily_evaluation/Data/models/daily_evaluation.dart';
import 'package:hive/hive.dart';

abstract class IDailyEvaluationService {
  Future<void> addEvaluation(DailyEvaluation evaluation);
  Future<void> updateEvaluation(int index, DailyEvaluation evaluation);
  Future<void> deleteEvaluation(int index);
  Future<List<DailyEvaluation>> getAllEvaluations();
}

class HiveDailyEvaluationService implements IDailyEvaluationService {
  final Box<DailyEvaluation> _evaluationBox;

  HiveDailyEvaluationService(this._evaluationBox);

  @override
  Future<void> addEvaluation(DailyEvaluation evaluation) async {
    await _evaluationBox.add(evaluation);
  }

  @override
  Future<void> updateEvaluation(int index, DailyEvaluation evaluation) async {
    await _evaluationBox.putAt(index, evaluation);
  }

  @override
  Future<void> deleteEvaluation(int index) async {
    await _evaluationBox.deleteAt(index);
  }

  @override
  Future<List<DailyEvaluation>> getAllEvaluations() async {
    return _evaluationBox.values.toList();
  }
}
