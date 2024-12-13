import 'package:daily_ev/features/daily_evaluation/presentation/Views/daily_evaluation_view.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/daily_evaluation_bloc.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/daily_evaluation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class DailyEvaluationPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => DailyEvaluationBloc()..add(LoadEvaluationsEvent()),
//       child: Scaffold(
//         appBar: AppBar(title: Text("ارزیابی روزانه")),
//         body: DailyEvaluationView(),
//       ),
//     );
//   }
// }
