import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

/// Core service for Hive local database operations.
///
/// **Storage Responsibility:**
/// - [HiveService] is for general-purpose local data (e.g., user preferences,
///   cached dashboard data, settings).
/// - [SecureStorageService] handles sensitive auth data (JWT tokens). Do NOT
///   store tokens or credentials in Hive.
@lazySingleton
class HiveService {
  static const String _settingsBox = 'settings';

  /// Opens all required Hive boxes. Call this once during app startup.
  Future<void> init() async {
    await Hive.openBox<dynamic>(_settingsBox);
    // Register additional boxes here as features grow:
    // await Hive.openBox<YourModel>(YourModel.boxName);
  }

  /// A general-purpose key-value box for app settings/preferences.
  Box<dynamic> get settingsBox => Hive.box<dynamic>(_settingsBox);

  // ---------------------------------------------------------------------------
  // Convenience helpers for the settings box
  // ---------------------------------------------------------------------------

  Future<void> put(String key, dynamic value) async {
    await settingsBox.put(key, value);
  }

  T? get<T>(String key, {T? defaultValue}) {
    return settingsBox.get(key, defaultValue: defaultValue) as T?;
  }

  Future<void> delete(String key) async {
    await settingsBox.delete(key);
  }

  Future<void> clearAll() async {
    await settingsBox.clear();
  }
}
