// Governance - Category: controller | Purpose: Non-executable scaffold for HrHiringOffersScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final hrHiringOffersScreenControllerProvider =
    NotifierProvider<
      HrHiringOffersScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HrHiringOffersScreenController();
    });

class HrHiringOffersScreenController extends BaseScaffoldController {}
