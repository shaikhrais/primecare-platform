import 'dart:io';
import 'dart:convert';

void main() {
  final path = 'packages/primecare_ui/new_analysis_errors_all.txt';
  final file = File(path);
  if (!file.existsSync()) {
    print('File does not exist: $path');
    return;
  }
  
  try {
    final bytes = file.readAsBytesSync();
    // Try to decode as UTF-16LE, UTF-8, etc.
    String content;
    if (bytes.length >= 2 && bytes[0] == 0xFF && bytes[1] == 0xFE) {
      content = systemEncodingDecode(bytes.sublist(2));
    } else {
      content = utf8Decode(bytes);
    }
    print('--- File Content ---');
    print(content);
    print('-------------------');
  } catch (e) {
    print('Error reading file: $e');
    // Try simple readAsString
    try {
      print(file.readAsStringSync());
    } catch (e2) {
      print('Fallback read failed: $e2');
    }
  }
}

String utf8Decode(List<int> bytes) {
  try {
    return utf8.decode(bytes);
  } catch (e) {
    return String.fromCharCodes(bytes);
  }
}

String systemEncodingDecode(List<int> bytes) {
  // Simple UTF-16LE decoder
  final chars = <int>[];
  for (int i = 0; i < bytes.length - 1; i += 2) {
    chars.add(bytes[i] | (bytes[i + 1] << 8));
  }
  return String.fromCharCodes(chars);
}
