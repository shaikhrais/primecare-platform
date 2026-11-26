// Governance - Category: controller | Purpose: Non-executable scaffold for CommunityOutreachContactsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final communityOutreachContactsScreenControllerProvider =
    NotifierProvider<
      CommunityOutreachContactsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CommunityOutreachContactsScreenController();
    });

class CommunityOutreachContactsScreenController
    extends BaseScaffoldController {}
