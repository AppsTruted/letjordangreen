import 'package:hive/hive.dart';
import 'package:letjordangreen/core/hive/user.dart';

class UserBox {
  static Box<UserHiveModel>? _instance;

  static Future<Box<UserHiveModel>> getInstance() async {
    _instance = await Hive.openBox<UserHiveModel>('userBox');
    return _instance!;
  }

  static Future<void> putBox(String key, UserHiveModel value) async {
    final box = await getInstance();
    await box.put(key, value);
  }
  static Future<Box<UserHiveModel>?> getUserBox() async {
    final box = await getInstance();
    _instance = box;
    return _instance;
  }

  // static Future<void> clearBox() async {
  //   final box = await getInstance();
  //   await box.clear();
  // }

  static Future<void> clearBox() async {
    final box = await getInstance();
    await box.clear();  // Clears all data in the box
    await box.close();  // Closes the box after clearing the data
    _instance = null;  // Reset the instance to null
  }

  static Future<void> closeBox() async {
    final box = await getInstance();
    await box.close();
    _instance = null;
  }

  static Future<bool> isUserSignedIn() async {
    final box = await getInstance();
    return box.isNotEmpty;
  }
}