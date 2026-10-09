// Governance - Category: controller | Purpose: Non-executable scaffold for CertificatesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final certificatesScreenControllerProvider =
    NotifierProvider<
      CertificatesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CertificatesScreenController();
    });

class CertificatesScreenController extends BaseScaffoldController {}
