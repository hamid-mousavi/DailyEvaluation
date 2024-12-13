import 'package:daily_ev/features/daily_evaluation/Data/models/daily_evaluation.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/daily_evaluation_bloc.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/daily_evaluation_event.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/daily_evaluation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class DailyEvaluationView extends StatelessWidget {
  const DailyEvaluationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Evaluation'),
      ),
      body: BlocBuilder<DailyEvaluationBloc, DailyEvaluationState>(
        builder: (context, state) {
          if (state is EvaluationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EvaluationLoaded) {
            List<DailyEvaluation> evaluations = state.evaluations;

            return ListView.builder(
              itemCount: evaluations.length,
              itemBuilder: (context, index) {
                final evaluation = evaluations[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text('${evaluation.date.toLocal()}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Spiritual Score: ${evaluation.spiritualScore}'),
                        Text('Physical Score: ${evaluation.physicalScore}'),
                        Text('Mental Score: ${evaluation.mentalScore}'),
                        Text('Notes: ${evaluation.notes}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // ارسال اندیس به رویداد حذف
                        BlocProvider.of<DailyEvaluationBloc>(context)
                            .add(DeleteEvaluationEvent(index: index));
                      },
                    ),
                    onTap: () {
                      // می‌توانید عملکرد دیگری برای باز کردن صفحه ویرایش اضافه کنید.
                    },
                  ),
                );
              },
            );
          } else if (state is EvaluationFailure) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else {
            return const Center(child: Text('No evaluations found.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // می‌توانید یک فرم جدید برای اضافه کردن ارزیابی روزانه باز کنید.
          Navigator.pushNamed(context, '/addDailyEvaluation');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
