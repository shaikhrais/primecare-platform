import 'dart:io';
import 'dart:convert';

class CacheManager {
  final Map<String, dynamic> data;
  final File _cacheFile;

  CacheManager._(this.data, this._cacheFile);

  factory CacheManager() {
    // Get the directory of the currently running script
    final scriptPath = Platform.script.toFilePath();
    final scriptDir = Directory(scriptPath).parent.path;
    final file = File('$scriptDir/.guardian_cache.json');
    
    Map<String, dynamic> data = {'milestones': {}};
    if (file.existsSync()) {
      try {
        data = jsonDecode(file.readAsStringSync());
      } catch (_) {}
    }
    return CacheManager._(data, file);
  }

  bool isHashMatch(String milestoneId, String currentHash) {
    final milestoneData = data['milestones']?[milestoneId];
    if (milestoneData == null) return false;
    return milestoneData['hash'] == currentHash && milestoneData['status'] == 'PASS';
  }

  bool wasRecentlyChecked(String milestoneId, int seconds) {
    final milestoneData = data['milestones']?[milestoneId];
    if (milestoneData == null) return false;
    
    final timestampStr = milestoneData['timestamp'];
    if (timestampStr == null) return false;
    
    final lastCheck = DateTime.parse(timestampStr);
    final diff = DateTime.now().difference(lastCheck).inSeconds;
    
    return diff < seconds && milestoneData['status'] == 'PASS';
  }

  void updateMilestone(String milestoneId, String hash, String status) {
    data['milestones'] ??= {};
    data['milestones'][milestoneId] = {
      'hash': hash,
      'status': status,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  void save() {
    _cacheFile.writeAsStringSync(jsonEncode(data));
  }
}
