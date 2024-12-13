

import 'package:daily_ev/features/daily_evaluation/Data/models/daily_evaluation.dart';
import 'package:equatable/equatable.dart';

abstract class DailyEvaluationEvent extends Equatable {
  const DailyEvaluationEvent();

  @override
  List<Object> get props => [];
}

class LoadEvaluationsEvent extends DailyEvaluationEvent {}

class AddEvaluationEvent extends DailyEvaluationEvent {
  final DailyEvaluation evaluation;

  const AddEvaluationEvent(this.evaluation);

  @override
  List<Object> get props => [evaluation];
}
class UpdateEvaluationEvent extends DailyEvaluationEvent {
  final int index; // اندیس آیتمی که باید ویرایش شود
  final DailyEvaluation evaluation; // داده‌های جدید ارزیابی

  UpdateEvaluationEvent({required this.index, required this.evaluation});
}

class DeleteEvaluationEvent extends DailyEvaluationEvent {
  final int index; // اندیس آیتمی که باید حذف شود

  DeleteEvaluationEvent({required this.index});
}
