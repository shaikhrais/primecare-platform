import 'package:primecare_ui/primecare_ui.dart';

/// [IntegrityService] - Calculates architectural health and compliance scores.
class IntegrityService {
  /// Calculates a health score (0-100) for a project based on its MVC distribution and heuristics.
  static double calculateHealthScore(PlatformProject project) {
    final mvc = PlatformGovernanceRegistry.uiMvcManifest[project] ?? 
                PlatformGovernanceRegistry.apiMvcManifest[project] ?? 
                {};
    final loc = PlatformGovernanceRegistry.projectLocManifest[project] ?? 0;
    final files = PlatformGovernanceRegistry.projectFileManifest[project] ?? 0;
    
    if (mvc.isEmpty && loc == 0) return 0;

    double score = 100;

    // Heuristic Penalties
    if (files > 0 && loc / files > 1000) score -= 15; // Technical Debt: Fat files
    if (loc > 0 && files == 0) score -= 30; // Ghost code

    final m = mvc['M'] ?? 0;
    final v = mvc['V'] ?? 0;
    final c = mvc['C'] ?? 0;
    final isUi = PlatformGovernanceRegistry.uiProjects.contains(project);

    if (isUi) {
      if (v == 0 && loc > 0) score -= 40; 
      if (m == 0 && loc > 0) score -= 10;
      if (c == 0 && loc > 0) score -= 10;
    } else {
      if (c == 0 && loc > 0) score -= 40; 
      if (m == 0 && loc > 0) score -= 10;
    }

    if (loc == 0 && files > 0) score = 50; // Skeleton only

    return score.clamp(0, 100);
  }

  /// Returns the integrity status label.
  static String getIntegrityStatus(PlatformProject project) {
    final score = calculateHealthScore(project);
    if (score >= 90) return 'PASS';
    if (score >= 60) return 'WARN';
    return 'ERROR';
  }

  /// Returns a list of identified architectural issues for a project.
  static List<String> getProjectIssues(PlatformProject project) {
    final mvc = PlatformGovernanceRegistry.uiMvcManifest[project] ?? 
                PlatformGovernanceRegistry.apiMvcManifest[project] ?? 
                {};
    final loc = PlatformGovernanceRegistry.projectLocManifest[project] ?? 0;
    final files = PlatformGovernanceRegistry.projectFileManifest[project] ?? 0;
    final isUi = PlatformGovernanceRegistry.uiProjects.contains(project);
    final List<String> issues = [];

    if (mvc.isEmpty && loc == 0) {
      issues.add('Project manifest is empty or missing');
      return issues;
    }

    if (loc > 0 && files == 0) {
      issues.add('Ghost code detected (LOC > 0 but files == 0)');
    }

    if (files > 0 && loc / files > 1000) {
      issues.add('High file density detected (>1000 LOC per file)');
    }

    final m = mvc['M'] ?? 0;
    final v = mvc['V'] ?? 0;
    final c = mvc['C'] ?? 0;

    if (isUi) {
      if (v == 0 && loc > 0) issues.add('UI project missing View layer');
      if (m == 0 && loc > 0) issues.add('UI project missing Model layer');
      if (c == 0 && loc > 0) issues.add('UI project missing Controller layer');
      if (v > 50) issues.add('High view density detected (>50 screens)');
    } else {
      if (c == 0 && loc > 0) issues.add('API project missing Controller layer');
      if (m == 0 && loc > 0) issues.add('API project missing Model layer');
    }

    if (loc == 0 && files > 0) {
      issues.add('Skeleton project detected (Files exist but empty)');
    }

    return issues;
  }

  /// Returns a list of actionable suggestions for architectural remediation.
  static List<String> getProjectSuggestions(PlatformProject project) {
    final issues = getProjectIssues(project);
    final List<String> suggestions = [];

    for (final issue in issues) {
      if (issue.contains('missing View')) suggestions.add('Generate views from registered blueprints');
      if (issue.contains('missing Model')) suggestions.add('Scaffold Prisma models for project');
      if (issue.contains('missing Controller')) suggestions.add('Implement Riverpod providers or API controllers');
      if (issue.contains('High view density')) suggestions.add('Refactor into sub-modules using Skeleton Index Pattern');
      if (issue.contains('High file density')) suggestions.add('Break down large files into atomic components');
      if (issue.contains('Skeleton project')) suggestions.add('Populate layers from platform templates');
      if (issue.contains('Ghost code')) suggestions.add('Synchronize filesystem manifest with registry');
    }

    return suggestions;
  }
}
