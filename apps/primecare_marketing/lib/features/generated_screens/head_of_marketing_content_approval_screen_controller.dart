// Governance - Category: controller | Purpose: Non-executable scaffold for HeadOfMarketingContentApprovalScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final headOfMarketingContentApprovalScreenControllerProvider =
    NotifierProvider<
      HeadOfMarketingContentApprovalScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HeadOfMarketingContentApprovalScreenController();
    });

class HeadOfMarketingContentApprovalScreenController
    extends BaseScaffoldController {}
