import 'package:daily_ev/features/daily_evaluation/Data/models/daily_evaluation.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/daily_evaluation_bloc.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/daily_evaluation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditEvaluationPage extends StatefulWidget {
  final DailyEvaluation evaluation;
  final int index;

  const EditEvaluationPage({
    Key? key,
    required this.evaluation,
    required this.index,
  }) : super(key: key);

  @override
  _EditEvaluationPageState createState() => _EditEvaluationPageState();
}

class _EditEvaluationPageState extends State<EditEvaluationPage> {
  late TextEditingController _spiritualController;
  late TextEditingController _physicalController;
  late TextEditingController _mentalController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _spiritualController = TextEditingController(text: widget.evaluation.spiritualScore.toString());
    _physicalController = TextEditingController(text: widget.evaluation.physicalScore.toString());
    _mentalController = TextEditingController(text: widget.evaluation.mentalScore.toString());
    _notesController = TextEditingController(text: widget.evaluation.notes);
  }

  @override
  void dispose() {
    _spiritualController.dispose();
    _physicalController.dispose();
    _mentalController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveEvaluation() {
    final spiritualScore = int.tryParse(_spiritualController.text) ?? 0;
    final physicalScore = int.tryParse(_physicalController.text) ?? 0;
    final mentalScore = int.tryParse(_mentalController.text) ?? 0;
    final notes = _notesController.text;

    final updatedEvaluation = DailyEvaluation(
      date: widget.evaluation.date,
      spiritualScore: spiritualScore,
      physicalScore: physicalScore,
      mentalScore: mentalScore,
      notes: notes,
    );

    BlocProvider.of<DailyEvaluationBloc>(context).add(
      UpdateEvaluationEvent(index: widget.index, evaluation: updatedEvaluation),
    );

    Navigator.pop(context, true); // بازگشت به صفحه قبلی با موفقیت
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Evaluation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _spiritualController,
              decoration: const InputDecoration(labelText: 'Spiritual Score'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _physicalController,
              decoration: const InputDecoration(labelText: 'Physical Score'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _mentalController,
              decoration: const InputDecoration(labelText: 'Mental Score'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveEvaluation,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
