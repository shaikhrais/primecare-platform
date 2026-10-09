// Governance - Category: controller | Purpose: Non-executable scaffold for ProposalsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final proposalsScreenControllerProvider =
    NotifierProvider<
      ProposalsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ProposalsScreenController();
    });

class ProposalsScreenController extends BaseScaffoldController {}
