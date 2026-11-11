/// Project acceptance has no configured observation transport here.
/// A project identifier or manifest is not a measured integrity receipt.
class IntegrityService {
  static double? calculateHealthScore(dynamic project) => null;
  static String getIntegrityStatus(dynamic project) => 'Unverified';
  static List<String> getProjectIssues(dynamic project) =>
      ['Project integrity acceptance evidence is unavailable.'];
  static List<String> getProjectSuggestions(dynamic project) => [];
}
