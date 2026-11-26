// Governance - Category: controller | Purpose: Non-executable scaffold for HeadOfMarketingLeadsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final headOfMarketingLeadsScreenControllerProvider =
    NotifierProvider<
      HeadOfMarketingLeadsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HeadOfMarketingLeadsScreenController();
    });

class HeadOfMarketingLeadsScreenController extends BaseScaffoldController {}
