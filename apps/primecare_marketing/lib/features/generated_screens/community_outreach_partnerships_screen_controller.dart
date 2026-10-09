// Governance - Category: controller | Purpose: Non-executable scaffold for CommunityOutreachPartnershipsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final communityOutreachPartnershipsScreenControllerProvider =
    NotifierProvider<
      CommunityOutreachPartnershipsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CommunityOutreachPartnershipsScreenController();
    });

class CommunityOutreachPartnershipsScreenController
    extends BaseScaffoldController {}
