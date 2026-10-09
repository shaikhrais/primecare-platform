// Governance - Category: controller | Purpose: Non-executable scaffold for CourseArchitectScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final courseArchitectScreenControllerProvider =
    NotifierProvider<
      CourseArchitectScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CourseArchitectScreenController();
    });

class CourseArchitectScreenController extends BaseScaffoldController {}
