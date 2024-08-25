import 'package:get_storage/get_storage.dart';

class TLocalStorage {
  late final GetStorage _storage;

  // SINGLETON INSTANCE
  static TLocalStorage? _instance;
  TLocalStorage._internal();

  factory TLocalStorage.instance() {
    _instance ??= TLocalStorage._internal();
    return _instance!;
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = TLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName); // Initialize _storage here
  }

  // GENERIC METHOD TO SAVE DATA
  Future<void> saveData<T>(String key, T value) async {
    await _instance!._storage
        .write(key, value); // Access _storage through _instance
  }

  // GENERIC METHOD TO READ DATA
  T? readData<T>(String key) {
    return _instance!._storage
        .read<T>(key); // Access _storage through _instance
  }

  // GENERIC METHOD TO REMOVE DATA
  Future<void> removeData<T>(String key) async {
    await _instance!._storage.remove(key); // Access _storage through _instance
  }

  // CLEAR ALL DATA IN STORAGE
  Future<void> clearAll() async {
    await _instance!._storage.erase(); // Access _storage through _instance
  }
}
