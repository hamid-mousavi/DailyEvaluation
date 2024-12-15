import 'package:daily_ev/features/daily_evaluation/Data/models/Criterion/criterion.dart';
import 'package:daily_ev/features/daily_evaluation/Data/models/daily_evaluation.dart';
import 'package:daily_ev/features/daily_evaluation/Data/repositories/ICriterionService%20.dart';
import 'package:daily_ev/features/daily_evaluation/Data/repositories/daily_evalation_services.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/Views/Critation/critation_page.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/Views/add_evalution_view.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/Views/daily_evaluation_view.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/Views/edit_evalation_view.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/criterion_bloc.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/criterion_event.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/daily_evaluation_bloc.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/daily_evaluation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DailyEvaluationAdapter());
  Hive.registerAdapter(CriterionAdapter());

  final evaluationBox = await Hive.openBox<DailyEvaluation>('dailyEvaluations');
  final criterionBox = await Hive.openBox<Criterion>('criterions');

  runApp(MyApp(evaluationBox, criterionBox));
}

class MyApp extends StatelessWidget {
  final Box<DailyEvaluation> evaluationBox;
  final Box<Criterion> criterionBox;

  const MyApp(this.evaluationBox, this.criterionBox);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DailyEvaluationBloc(
            HiveDailyEvaluationService(evaluationBox),
          )..add(LoadEvaluationsEvent()),
        ),
        BlocProvider(
          create: (context) => CriterionBloc(
            HiveCriterionService(criterionBox),
          )..add(LoadCriteriaEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Daily Evaluation',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DailyEvaluationView(),
        // اضافه کردن مسیرها
        routes: {
          '/critation_page': (context) => const CriterionPage(),
          '/addDailyEvaluation': (context) => const AddEvaluationPage(),
          '/editEvaluation': (context) => EditEvaluationPage(
                evaluation: args?['evaluation'],
                index: args?['index'],
              )
        },
      ),
    );
  }
}
