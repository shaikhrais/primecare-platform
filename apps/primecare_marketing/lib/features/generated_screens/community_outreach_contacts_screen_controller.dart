// Governance - Category: controller | Purpose: Non-executable scaffold for CommunityOutreachContactsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final communityOutreachContactsScreenControllerProvider =
    NotifierProvider<
      CommunityOutreachContactsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CommunityOutreachContactsScreenController();
    });

class CommunityOutreachContactsScreenController
    extends BaseScaffoldController {}
