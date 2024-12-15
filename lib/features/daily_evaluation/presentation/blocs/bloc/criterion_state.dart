import 'package:daily_ev/features/daily_evaluation/Data/models/Criterion/criterion.dart';

abstract class CriterionState {}

class CriterionInitial extends CriterionState {}

class CriterionLoading extends CriterionState {}

class CriterionLoaded extends CriterionState {
  final List<Criterion> criteria;

  CriterionLoaded(this.criteria);
}

class CriterionFailure extends CriterionState {
  final String error;

  CriterionFailure(this.error);
}
