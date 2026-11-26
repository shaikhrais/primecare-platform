import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VisitNotesScreenState extends DashboardState<VisitNotesScreenState> {
  VisitNotesScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  VisitNotesScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => VisitNotesScreenState(isLoading: isLoading, error: error, data: data);
}

class VisitNotesScreenController
    extends BaseDashboardController<VisitNotesScreenState> {
  VisitNotesScreenController(Ref ref)
    : super(
        ref,
        initialState: VisitNotesScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/psw/visit-notes',
      );
}

final psw_visit_notesControllerProvider =
    StateNotifierProvider<VisitNotesScreenController, VisitNotesScreenState>((
      ref,
    ) {
      return VisitNotesScreenController(ref);
    });
