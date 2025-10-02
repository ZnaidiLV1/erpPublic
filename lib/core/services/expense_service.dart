import 'package:injectable/injectable.dart';

import '../constants/di/getIt.dart';
import 'hive_repository.dart';

@lazySingleton
class ExpenseService {
  final String boxName = HiveRepository.expensesBoxKey;

  Future<void> addExpense(Map<String, dynamic> value) async {
    await getIt<HiveRepository>().add(boxName: boxName, value: value);
  }

  Future<Map<String, Object?>?> getExpense(int id) async {
    return HiveRepository.get(boxName: boxName, id: id);
  }

  List<Map<String, Object?>> getAllExpenses() {
    return HiveRepository.getAll(boxName: boxName);
  }

  Future<void> updateExpense(Map<String, dynamic> value) async {
    await HiveRepository.update(boxName: boxName, value: value);
  }

  Future<void> deleteExpense(int id) async {
    await HiveRepository.delete(boxName: boxName, id: id);
  }

  Future<void> clearExpenses() async {
    await HiveRepository.clearBoxValues(boxName: boxName);
  }
}
