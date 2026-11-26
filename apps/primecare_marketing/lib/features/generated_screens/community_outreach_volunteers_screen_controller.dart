// Governance - Category: controller | Purpose: Non-executable scaffold for CommunityOutreachVolunteersScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final communityOutreachVolunteersScreenControllerProvider =
    NotifierProvider<
      CommunityOutreachVolunteersScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CommunityOutreachVolunteersScreenController();
    });

class CommunityOutreachVolunteersScreenController
    extends BaseScaffoldController {}
