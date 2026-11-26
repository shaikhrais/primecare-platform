// Governance - Category: controller | Purpose: Non-executable scaffold for CtoIssueTrackingScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ctoIssueTrackingScreenControllerProvider =
    NotifierProvider<
      CtoIssueTrackingScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CtoIssueTrackingScreenController();
    });

class CtoIssueTrackingScreenController extends BaseScaffoldController {}
