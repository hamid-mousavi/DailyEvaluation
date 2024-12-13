import 'package:daily_ev/features/daily_evaluation/Data/models/daily_evaluation.dart';
import 'package:daily_ev/features/daily_evaluation/Data/repositories/daily_evalation_services.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/Views/add_evalution_view.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/Views/daily_evaluation_view.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/Views/edit_evalation_view.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/daily_evaluation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DailyEvaluationAdapter());
  final evaluationBox = await Hive.openBox<DailyEvaluation>('dailyEvaluations');

  runApp(MyApp(evaluationBox));
}

class MyApp extends StatelessWidget {
  final Box<DailyEvaluation> evaluationBox;

  const MyApp(this.evaluationBox);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return MaterialApp(
      title: 'Daily Evaluation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => DailyEvaluationBloc(
           HiveDailyEvaluationService(evaluationBox),
        ),
        child: DailyEvaluationView(),
      ),
      // اضافه کردن مسیرها
      routes: {
        '/addDailyEvaluation': (context) => const AddEvaluationPage(),
        '/editEvaluation': (context) => EditEvaluationPage(
              evaluation: args?['evaluation'],
              index: args?['index'],
            )
      },
    );
  }
}
