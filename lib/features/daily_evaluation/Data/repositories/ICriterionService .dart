import 'package:daily_ev/features/daily_evaluation/Data/models/Criterion/criterion.dart';
import 'package:hive/hive.dart';

abstract class ICriterionService{
  Future<void> addCriterion(Criterion criterion);
  Future<void> updateCriterion(int index, Criterion criterion);
  Future<void> deleteCriterion(int index);
  Future<List<Criterion>> getAllCriteria();
}


class HiveCriterionService implements ICriterionService {
  final Box<Criterion> _criterionBox;

  HiveCriterionService(this._criterionBox);

  @override
  Future<void> addCriterion(Criterion criterion) async {
    await _criterionBox.add(criterion);  // اضافه کردن فعالیت جدید به دیتابیس Hive
  }

  @override
  Future<void> updateCriterion(int index, Criterion criterion) async {
    await _criterionBox.putAt(index, criterion);  // بروزرسانی فعالیت در دیتابیس Hive
  }

  @override
  Future<void> deleteCriterion(int index) async {
    await _criterionBox.deleteAt(index);  // حذف فعالیت از دیتابیس Hive
  }

  @override
  Future<List<Criterion>> getAllCriteria() async {
    return _criterionBox.values.toList();  // خواندن تمامی فعالیت‌ها از دیتابیس Hive
  }
}
