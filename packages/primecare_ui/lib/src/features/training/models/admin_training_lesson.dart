/// Immutable governed lesson definition shared with the web course export.
class AdminTrainingLesson {
  final String id, titleKey, procedureKey, practiceKey, questionKey;
  final List<String> optionKeys;
  final int correct;
  const AdminTrainingLesson({required this.id, required this.titleKey,
    required this.procedureKey, required this.practiceKey,
    required this.questionKey, required this.optionKeys, required this.correct});
}
