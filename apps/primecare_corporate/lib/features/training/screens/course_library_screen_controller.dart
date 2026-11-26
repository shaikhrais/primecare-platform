// Governance - Category: controller | Purpose: Non-executable scaffold for CourseLibraryScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final courseLibraryScreenControllerProvider =
    NotifierProvider<
      CourseLibraryScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CourseLibraryScreenController();
    });

class CourseLibraryScreenController extends BaseScaffoldController {}
