import 'package:injectable/injectable.dart';
import '../constants/di/getIt.dart';
import 'hive_repository.dart';

@lazySingleton
class RevenueService {
  final String boxName = HiveRepository.revenuesBoxKey;

  Future<void> addRevenue(Map<String, dynamic> value) async {
    await getIt<HiveRepository>().add(boxName: boxName, value: value);
  }

  Future<Map<String, Object?>?> getRevenue(int id) async {
    return HiveRepository.get(boxName: boxName, id: id);
  }

  List<Map<String, Object?>> getAllRevenues() {
    return HiveRepository.getAll(boxName: boxName);
  }

  Future<void> updateRevenue(Map<String, dynamic> value) async {
    await HiveRepository.update(boxName: boxName, value: value);
  }
  Future<void> deleteRevenue(int id) async {
    await HiveRepository.delete(boxName: boxName, id: id);
  }

  Future<void> clearRevenues() async {
    await HiveRepository.clearBoxValues(boxName: boxName);
  }
}
