class SystemVerificationViewModel {
  final String status;
  final Map<String, int> modelCounts;
  final bool isOffline;
  
  const SystemVerificationViewModel({
    required this.status,
    required this.modelCounts,
    this.isOffline = false,
  });
  
  factory SystemVerificationViewModel.fromJson(Map<String, dynamic> json) {
    // The new Cloudflare edge endpoint returns:
    // {"success": true, "totalTables": X, "data": [{"relname": "User", "n_live_tup": 10}]}
    final dbStatus = json['success'] == true ? 'connected' : 'error';
    
    final countsRaw = json['data'] as List<dynamic>? ?? [];
    final parsedCounts = <String, int>{};
    
    for (final item in countsRaw) {
      if (item is Map) {
        final key = item['relname'] as String?;
        final value = item['n_live_tup'];
        if (key != null) {
          if (value is int) {
            parsedCounts[key] = value;
          } else if (value is String) {
            parsedCounts[key] = int.tryParse(value) ?? 0;
          }
        }
      }
    }

    return SystemVerificationViewModel(
      status: dbStatus,
      modelCounts: parsedCounts,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'db': status,
      'counts': modelCounts,
      'isOffline': isOffline,
    };
  }
  
  static SystemVerificationViewModel assemble({bool isOffline = false}) {
    return SystemVerificationViewModel(
      status: isOffline ? 'offline' : 'fallback',
      modelCounts: const {
        'PlatformScreen': 266,
        'VerificationLog': 0,
      },
      isOffline: isOffline,
    );
  }
}
