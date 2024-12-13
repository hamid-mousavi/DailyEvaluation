import 'package:daily_ev/features/daily_evaluation/Data/models/daily_evaluation.dart';
import 'package:equatable/equatable.dart';

abstract class DailyEvaluationState extends Equatable {
  const DailyEvaluationState();

  @override
  List<Object?> get props => [];
}

class EvaluationInitial extends DailyEvaluationState {}

class EvaluationLoading extends DailyEvaluationState {}

class EvaluationLoaded extends DailyEvaluationState {
  final List<DailyEvaluation> evaluations;

  const EvaluationLoaded(this.evaluations);

  @override
  List<Object?> get props => [evaluations];
}

class EvaluationFailure extends DailyEvaluationState {
  final String error;

  const EvaluationFailure(this.error);

  @override
  List<Object?> get props => [error];
}
