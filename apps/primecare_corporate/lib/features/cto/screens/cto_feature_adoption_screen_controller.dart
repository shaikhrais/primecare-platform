// Governance - Category: controller | Purpose: Non-executable scaffold for CtoFeatureAdoptionScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final ctoFeatureAdoptionScreenControllerProvider =
    NotifierProvider<
      CtoFeatureAdoptionScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CtoFeatureAdoptionScreenController();
    });

class CtoFeatureAdoptionScreenController extends BaseScaffoldController {}
