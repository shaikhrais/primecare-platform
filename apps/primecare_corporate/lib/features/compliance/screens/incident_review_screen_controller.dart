// Governance - Category: controller | Purpose: Non-executable scaffold for IncidentReviewScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final incidentReviewScreenControllerProvider =
    NotifierProvider<
      IncidentReviewScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return IncidentReviewScreenController();
    });

class IncidentReviewScreenController extends BaseScaffoldController {}
