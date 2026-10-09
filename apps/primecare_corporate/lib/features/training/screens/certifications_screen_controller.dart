// Governance - Category: controller | Purpose: Non-executable scaffold for CertificationsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final certificationsScreenControllerProvider =
    NotifierProvider<
      CertificationsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CertificationsScreenController();
    });

class CertificationsScreenController extends BaseScaffoldController {}
