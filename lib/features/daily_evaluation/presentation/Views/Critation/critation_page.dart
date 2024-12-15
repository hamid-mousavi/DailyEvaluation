import 'package:daily_ev/features/daily_evaluation/Data/repositories/ICriterionService%20.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/Views/add_evalution_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/criterion_bloc.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/criterion_event.dart';
import 'package:daily_ev/features/daily_evaluation/presentation/blocs/bloc/criterion_state.dart';
import 'package:daily_ev/features/daily_evaluation/Data/models/Criterion/criterion.dart';

class CriterionPage extends StatefulWidget {
  const CriterionPage({Key? key}) : super(key: key);

  @override
  State<CriterionPage> createState() => _CriterionPageState();
}

class _CriterionPageState extends State<CriterionPage> {
  List<bool> selectedCriteria = [];

  @override
  void initState() {
    super.initState();
    final criterionBloc = context.read<CriterionBloc>();

    // مقداردهی اولیه selectedCriteria هنگام بارگذاری معیارها
    criterionBloc.stream.listen((state) {
      if (state is CriterionLoaded) {
        setState(() {
          selectedCriteria =
              List<bool>.filled(state.criteria.length, false); // مقداردهی اولیه
        });
      }
    });

    // در صورت نیاز می‌توانید در اینجا یک Event اولیه بفرستید
    criterionBloc.add(LoadCriteriaEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Criteria List")),
      body: BlocListener<CriterionBloc, CriterionState>(
        listener: (context, state) {
          if (state is CriterionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        child: BlocBuilder<CriterionBloc, CriterionState>(
          builder: (context, state) {
            if (state is CriterionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CriterionLoaded) {
              // تنظیم وضعیت پیش‌فرض چک‌باکس‌ها به false

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.criteria.length,
                      itemBuilder: (context, index) {
                        final criterion = state.criteria[index];
                    
                        return ListTile(
                          title: Text(criterion.name),
                          subtitle: Text('Category: ${criterion.category}'),
                          trailing: Row(
                            mainAxisSize:
                                MainAxisSize.min, // جلوگیری از اشغال فضای اضافی
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  context
                                      .read<CriterionBloc>()
                                      .add(DeleteCriterionEvent(index));
                                },
                              ),
                              // استفاده از Expanded برای جلوگیری از خطای اندازه
                              Checkbox(
                                value: selectedCriteria[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    selectedCriteria[index] = value ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            _showEditDialog(context, criterion, index);
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('No Criteria Available'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // نمایش دیالوگ برای افزودن یک معیار جدید
  void _showAddDialog(BuildContext context) {
    final nameController = TextEditingController();
    final weightController = TextEditingController();

    // لیست دسته‌بندی‌ها
    final categories = ['Category 1', 'Category 2', 'Category 3', 'Category 4'];
    String? selectedCategory; // مقدار دسته‌بندی انتخاب‌شده

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Criterion'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Category'),
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                value: selectedCategory,
                onChanged: (String? newValue) {
                  selectedCategory =
                      newValue; // به‌روزرسانی دسته‌بندی انتخاب‌شده
                },
              ),
              TextField(
                controller: weightController,
                decoration: const InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (selectedCategory != null) {
                  final criterion = Criterion(
                    name: nameController.text,
                    category: selectedCategory!,
                    weight: int.parse(weightController.text),
                  );
                  context
                      .read<CriterionBloc>()
                      .add(AddCriterionEvent(criterion));
                  Navigator.of(context).pop();
                } else {
                  // نمایش خطا اگر دسته‌بندی انتخاب نشده باشد
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a category.')),
                  );
                }
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // نمایش دیالوگ برای ویرایش یک معیار
 
 void _showEditDialog(BuildContext context, Criterion criterion, int index) {
  final nameController = TextEditingController(text: criterion.name);
  final weightController = TextEditingController(text: criterion.weight.toString());

  // لیست دسته‌بندی‌ها
  final categories = ['Category 1', 'Category 2', 'Category 3', 'Category 4'];
  String? selectedCategory = criterion.category; // مقدار پیش‌فرض

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Edit Criterion'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Category'),
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              value: selectedCategory,
              onChanged: (String? newValue) {
                selectedCategory = newValue; // به‌روزرسانی دسته‌بندی انتخاب‌شده
              },
            ),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(labelText: 'Weight'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (selectedCategory != null) {
                final updatedCriterion = Criterion(
                  name: nameController.text,
                  category: selectedCategory!,
                  weight: int.parse(weightController.text),
                );
                context.read<CriterionBloc>().add(UpdateCriterionEvent(index, updatedCriterion));
                Navigator.of(context).pop();
              } else {
                // نمایش خطا اگر دسته‌بندی انتخاب نشده باشد
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select a category.')),
                );
              }
            },
            child: const Text('Update'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}

 }
