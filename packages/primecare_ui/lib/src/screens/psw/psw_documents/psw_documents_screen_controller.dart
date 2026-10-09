import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentsState extends DashboardState<DocumentsState> {
  DocumentsState({required super.isLoading, super.error, required super.data});

  @override
  DocumentsState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => DocumentsState(isLoading: isLoading, error: error, data: data);
}

class DocumentsController extends BaseDashboardController<DocumentsState> {
  DocumentsController(Ref ref)
    : super(
        ref,
        initialState: DocumentsState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/psw/documents',
      );
}

final psw_documentsControllerProvider =
    StateNotifierProvider<DocumentsController, DocumentsState>((ref) {
      return DocumentsController(ref);
    });
