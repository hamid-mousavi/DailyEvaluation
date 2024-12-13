
import 'package:daily_ev/features/daily_evaluation/Data/repositories/daily_evalation_services.dart';

import 'daily_evaluation_event.dart';
import 'daily_evaluation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyEvaluationBloc extends Bloc<DailyEvaluationEvent, DailyEvaluationState> {
  final IDailyEvaluationService service;

  DailyEvaluationBloc(this.service) : super(EvaluationInitial()) {
    on<LoadEvaluationsEvent>((event, emit) async {
      emit(EvaluationLoading());
      try {
        final evaluations = await service.getAllEvaluations();
        emit(EvaluationLoaded(evaluations));
      } catch (e) {
        emit(EvaluationFailure(e.toString()));
      }
    });

    on<AddEvaluationEvent>((event, emit) async {
      try {
        await service.addEvaluation(event.evaluation);
        add(LoadEvaluationsEvent());
      } catch (e) {
        emit(EvaluationFailure(e.toString()));
      }
    });

    on<UpdateEvaluationEvent>((event, emit) async {
      try {
        await service.updateEvaluation(event.index, event.evaluation);
        add(LoadEvaluationsEvent());
      } catch (e) {
        emit(EvaluationFailure(e.toString()));
      }
    });

    on<DeleteEvaluationEvent>((event, emit) async {
      try {
        await service.deleteEvaluation(event.index);
        add(LoadEvaluationsEvent());
      } catch (e) {
        emit(EvaluationFailure(e.toString()));
      }
    });
  }
}
