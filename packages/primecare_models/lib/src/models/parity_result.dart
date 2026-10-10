/// Represents the result of a parity check between a UI Screen and its Backend APIs.
class ParityResult {
  final String screenId;
  final bool isCompliant;
  final List<String> missingApis;
  final List<String> mismatchingApis;

  ParityResult({
    required this.screenId,
    required this.isCompliant,
    this.missingApis = const [],
    this.mismatchingApis = const [],
  });
}
