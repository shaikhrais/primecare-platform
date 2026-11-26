// Governance - Category: controller | Purpose: Non-executable scaffold for HeadOfMarketingLeadsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final headOfMarketingLeadsScreenControllerProvider =
    NotifierProvider<
      HeadOfMarketingLeadsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HeadOfMarketingLeadsScreenController();
    });

class HeadOfMarketingLeadsScreenController extends BaseScaffoldController {}
