// Governance - Category: controller | Purpose: Non-executable scaffold for AiChatbotScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final aiChatbotScreenControllerProvider =
    NotifierProvider<
      AiChatbotScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return AiChatbotScreenController();
    });

class AiChatbotScreenController extends BaseScaffoldController {}
