// Governance - Category: controller | Purpose: Non-executable scaffold for TicketCenterScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ticketCenterScreenControllerProvider =
    NotifierProvider<
      TicketCenterScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TicketCenterScreenController();
    });

class TicketCenterScreenController extends BaseScaffoldController {}
