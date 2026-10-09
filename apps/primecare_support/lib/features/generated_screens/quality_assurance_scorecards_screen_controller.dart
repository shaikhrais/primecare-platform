// Governance - Category: controller | Purpose: Non-executable scaffold for QualityAssuranceScorecardsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final qualityAssuranceScorecardsScreenControllerProvider =
    NotifierProvider<
      QualityAssuranceScorecardsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return QualityAssuranceScorecardsScreenController();
    });

class QualityAssuranceScorecardsScreenController
    extends BaseScaffoldController {}
