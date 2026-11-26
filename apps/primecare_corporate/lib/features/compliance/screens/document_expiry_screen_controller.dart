// Governance - Category: controller | Purpose: Non-executable scaffold for DocumentExpiryScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final documentExpiryScreenControllerProvider =
    NotifierProvider<
      DocumentExpiryScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return DocumentExpiryScreenController();
    });

class DocumentExpiryScreenController extends BaseScaffoldController {}
