// Governance - Category: controller | Purpose: Non-executable scaffold for QualityAssuranceCorrectiveActionsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final qualityAssuranceCorrectiveActionsScreenControllerProvider =
    NotifierProvider<
      QualityAssuranceCorrectiveActionsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return QualityAssuranceCorrectiveActionsScreenController();
    });

class QualityAssuranceCorrectiveActionsScreenController
    extends BaseScaffoldController {}
