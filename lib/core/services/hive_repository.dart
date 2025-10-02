import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HiveRepository {
  // Box keys
  static String expensesBoxKey = "Expenses";
  static String revenuesBoxKey = "Revenues";
  static const String preferencesBoxKey = 'preferences_box';

  ///---------------------------------general methods
  ///
  static Future<void> init() async {
    await Hive.openBox(expensesBoxKey);
    await Hive.openBox(revenuesBoxKey);
    await Hive.openBox(preferencesBoxKey);

  }

  Future<void> add({required String boxName, required Map<String, Object?> value}) async {
    int id = await Hive.box(boxName).add(value);
    value["id"] = id;
    await Hive.box(boxName).put(id, value);
  }

  static Future<Map<String, Object?>?> get({required String boxName, required int id}) async {
    return Hive.box(boxName).get(id) as Map<String, Object?>?;
  }

  static List<Map<String, Object?>> getAll({required String boxName}) {
    return Hive.box(boxName).values.map((e) => Map<String, Object?>.from(e)).toList();
  }
  static Future<void> delete({required String boxName, required int id}) async {
    await Hive.box(boxName).delete(id);
  }
  static Future<void> update({required String boxName, required Map<String, Object?> value}) async {
    await Hive.box(boxName).put(value["id"], value);
  }

  static Future<void> clearBoxValues({required String boxName}) async {
    await Hive.box(boxName).clear();
  }
}
