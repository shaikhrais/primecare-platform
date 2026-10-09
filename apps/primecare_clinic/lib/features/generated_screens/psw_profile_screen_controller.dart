// Governance - Category: controller | Purpose: Non-executable scaffold for PswProfileScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final pswProfileScreenControllerProvider =
    NotifierProvider<
      PswProfileScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswProfileScreenController();
    });

class PswProfileScreenController extends BaseScaffoldController {}
