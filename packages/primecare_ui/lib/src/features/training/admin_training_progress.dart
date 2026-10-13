import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization/admin_training_catalog_generated.dart';

abstract class AdminTrainingStorage {
  Future<String?> read(String key);
  Future<bool> write(String key, String value);
  Future<bool> remove(String key);
}
class PreferenceTrainingStorage implements AdminTrainingStorage {
  @override
  Future<String?> read(String key) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    return preferences.getString(key);
  }
  @override
  Future<bool> write(String key, String value) async =>
    (await SharedPreferences.getInstance()).setString(key, value);
  @override
  Future<bool> remove(String key) async =>
    (await SharedPreferences.getInstance()).remove(key);
}
class AdminTrainingResult {
  final String lesson, passedAt;
  const AdminTrainingResult(this.lesson, this.passedAt);
  Map<String,String> toJson() => {'lesson':lesson, 'passedAt':passedAt};
}

/// Device self-assessment only. A successful write precedes a recorded pass.
class AdminTrainingProgress {
  final AdminTrainingStorage storage;
  final String key;
  static final Map<String,Future<void>> _locks = {};
  AdminTrainingProgress({required String gateway, required String actor,
    AdminTrainingStorage? storage})
      : storage = storage ?? PreferenceTrainingStorage(),
        key = 'primecare.training.v1.${Uri.encodeComponent(gateway.replaceFirst(RegExp(r'/+$'), ''))}.${Uri.encodeComponent(actor)}.$adminTrainingCourseVersion' {
    if (actor.trim().isEmpty) throw ArgumentError('Training account scope required');
  }
  Future<T> _serial<T>(Future<T> Function() action) {
    final previous = _locks[key] ?? Future<void>.value();
    final operation = previous.then((_) => action());
    final tail = operation.then<void>((_) {}, onError: (Object _, StackTrace __) {});
    _locks[key] = tail;
    unawaited(tail.then((_) { if (identical(_locks[key],tail)) _locks.remove(key); }));
    return operation;
  }
  Future<List<AdminTrainingResult>> _read() async {
    try {
      final encoded = await storage.read(key);
      if (encoded == null || encoded.length > 32768) return [];
      final data = jsonDecode(encoded);
      if (data is! List || data.length > adminTrainingLessons.length) return [];
      final seen = <String>{};
      return [for (final row in data)
        if (row is Map && row['lesson'] is String && row['passedAt'] is String &&
          adminTrainingLessons.any((lesson) => lesson.id == row['lesson']) &&
          DateTime.tryParse(row['passedAt'] as String) != null && seen.add(row['lesson'] as String))
          AdminTrainingResult(row['lesson'] as String, row['passedAt'] as String)];
    } catch (_) { return []; }
  }
  Future<List<AdminTrainingResult>> results() => _serial(_read);
  Future<bool> answer(String lessonId, int choice) => _serial(() async {
    final lessons = adminTrainingLessons.where((lesson) => lesson.id == lessonId);
    if (lessons.isEmpty || choice < 0 || choice > 2) throw ArgumentError('Invalid training answer');
    if (lessons.first.correct != choice) return false;
    final records = await _read();
    if (!records.any((row) => row.lesson == lessonId)) {
      records.add(AdminTrainingResult(lessonId,DateTime.now().toUtc().toIso8601String()));
    }
    if (!await storage.write(key,jsonEncode(records.map((r)=>r.toJson()).toList()))) {
      throw StateError('Training progress storage unavailable');
    }
    return true;
  });
  Future<void> reset() => _serial(() async {
    if (!await storage.remove(key)) throw StateError('Training progress storage unavailable');
  });
  Future<Map<String,Object>> summary() => _serial(() async => {
    'course':adminTrainingCourseId,'version':adminTrainingCourseVersion,
    'recordType':'device-self-assessment','generatedAt':DateTime.now().toUtc().toIso8601String(),
    'passed':(await _read()).map((r)=>r.toJson()).toList(),
    'total':adminTrainingLessons.length,'supervisorVerified':false,
  });
}
