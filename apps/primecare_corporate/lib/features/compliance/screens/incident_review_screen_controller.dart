// Governance - Category: controller | Purpose: Non-executable scaffold for IncidentReviewScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final incidentReviewScreenControllerProvider =
    NotifierProvider<
      IncidentReviewScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return IncidentReviewScreenController();
    });

class IncidentReviewScreenController extends BaseScaffoldController {}
