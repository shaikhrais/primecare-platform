// Governance - Category: controller | Purpose: Non-executable scaffold for PswDocumentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final pswDocumentsScreenControllerProvider =
    NotifierProvider<
      PswDocumentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswDocumentsScreenController();
    });

class PswDocumentsScreenController extends BaseScaffoldController {}
