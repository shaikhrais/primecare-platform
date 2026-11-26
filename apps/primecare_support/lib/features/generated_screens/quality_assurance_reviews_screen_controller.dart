// Governance - Category: controller | Purpose: Non-executable scaffold for QualityAssuranceReviewsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final qualityAssuranceReviewsScreenControllerProvider =
    NotifierProvider<
      QualityAssuranceReviewsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return QualityAssuranceReviewsScreenController();
    });

class QualityAssuranceReviewsScreenController extends BaseScaffoldController {}
