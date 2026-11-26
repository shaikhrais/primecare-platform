// Governance - Category: controller | Purpose: Non-executable scaffold for ComplianceReviewsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final complianceReviewsScreenControllerProvider =
    NotifierProvider<
      ComplianceReviewsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ComplianceReviewsScreenController();
    });

class ComplianceReviewsScreenController extends BaseScaffoldController {}
