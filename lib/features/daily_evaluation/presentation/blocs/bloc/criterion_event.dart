import 'package:daily_ev/features/daily_evaluation/Data/models/Criterion/criterion.dart';

abstract class CriterionEvent {}

class LoadCriteriaEvent extends CriterionEvent {}

class AddCriterionEvent extends CriterionEvent {
  final Criterion criterion;

  AddCriterionEvent(this.criterion);
}

class UpdateCriterionEvent extends CriterionEvent {
  final int index;
  final Criterion criterion;

  UpdateCriterionEvent(this.index, this.criterion);
}

class DeleteCriterionEvent extends CriterionEvent {
  final int index;

  DeleteCriterionEvent(this.index);
}
