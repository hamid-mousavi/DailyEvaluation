import 'package:daily_ev/features/daily_evaluation/Data/models/Criterion/criterion.dart';
import 'package:daily_ev/features/daily_evaluation/Data/repositories/ICriterionService%20.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/criterion_event.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/criterion_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CriterionBloc extends Bloc<CriterionEvent, CriterionState> {
  final ICriterionService criterionService;

  CriterionBloc(this.criterionService) : super(CriterionInitial()) {
    on<LoadCriteriaEvent>((event, emit) async {
      emit(CriterionLoading());
      try {
        final criteria = await criterionService.getAllCriteria();
        emit(CriterionLoaded(criteria));
      } catch (e) {
        emit(CriterionFailure(e.toString()));
      }
    });

    on<AddCriterionEvent>((event, emit) async {
      try {
        await criterionService.addCriterion(event.criterion);
        add(LoadCriteriaEvent());
      } catch (e) {
        emit(CriterionFailure(e.toString()));
      }
    });

    on<UpdateCriterionEvent>((event, emit) async {
      try {
        await criterionService.updateCriterion(event.index, event.criterion);
        add(LoadCriteriaEvent());
      } catch (e) {
        emit(CriterionFailure(e.toString()));
      }
    });

    on<DeleteCriterionEvent>((event, emit) async {
      try {
        await criterionService.deleteCriterion(event.index);
        add(LoadCriteriaEvent());
      } catch (e) {
        emit(CriterionFailure(e.toString()));
      }
    });
  }
}
