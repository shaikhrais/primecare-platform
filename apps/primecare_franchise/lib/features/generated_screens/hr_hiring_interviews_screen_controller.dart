// Governance - Category: controller | Purpose: Non-executable scaffold for HrHiringInterviewsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final hrHiringInterviewsScreenControllerProvider =
    NotifierProvider<
      HrHiringInterviewsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HrHiringInterviewsScreenController();
    });

class HrHiringInterviewsScreenController extends BaseScaffoldController {}
