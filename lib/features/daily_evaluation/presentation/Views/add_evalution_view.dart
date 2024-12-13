import 'package:daily_ev/features/daily_evaluation/Data/models/daily_evaluation.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/daily_evaluation_bloc.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/daily_evaluation_event.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/daily_evaluation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEvaluationPage extends StatefulWidget {
  const AddEvaluationPage({Key? key}) : super(key: key);

  @override
  _AddEvaluationPageState createState() => _AddEvaluationPageState();
}

class _AddEvaluationPageState extends State<AddEvaluationPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _selectedDate;
  int _spiritualScore = 0;
  int _physicalScore = 0;
  int _mentalScore = 0;
  String _notes = '';

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  // متد برای ذخیره کردن ارزیابی جدید
void _submitEvaluation() {
  if (_formKey.currentState?.validate() ?? false) {
    _formKey.currentState?.save();

    // ارسال رویداد اضافه کردن ارزیابی به BLoC
    context.read<DailyEvaluationBloc>().add(
      AddEvaluationEvent(
        DailyEvaluation(
          date: _selectedDate,
          spiritualScore: _spiritualScore,
          physicalScore: _physicalScore,
          mentalScore: _mentalScore,
          notes: _notes,
        ),
      ),
    );

    // بازگشت به صفحه اصلی پس از ارسال ارزیابی
    Navigator.pop(context);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Daily Evaluation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // فیلد تاریخ
              TextFormField(
                decoration: const InputDecoration(labelText: 'Date'),
                initialValue: _selectedDate.toLocal().toString().split(' ')[0],
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // فیلد امتیاز روحی
              TextFormField(
                decoration: const InputDecoration(labelText: 'Spiritual Score'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter spiritual score';
                  }
                  return null;
                },
                onSaved: (value) {
                  _spiritualScore = int.parse(value!);
                },
              ),
              const SizedBox(height: 16),

              // فیلد امتیاز جسمی
              TextFormField(
                decoration: const InputDecoration(labelText: 'Physical Score'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter physical score';
                  }
                  return null;
                },
                onSaved: (value) {
                  _physicalScore = int.parse(value!);
                },
              ),
              const SizedBox(height: 16),

              // فیلد امتیاز ذهنی
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mental Score'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mental score';
                  }
                  return null;
                },
                onSaved: (value) {
                  _mentalScore = int.parse(value!);
                },
              ),
              const SizedBox(height: 16),

              // فیلد یادداشت‌ها
              TextFormField(
                decoration: const InputDecoration(labelText: 'Notes'),
                maxLines: 3,
                onSaved: (value) {
                  _notes = value ?? '';
                },
              ),
              const SizedBox(height: 16),

              // دکمه ارسال
              ElevatedButton(
                onPressed: _submitEvaluation,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
