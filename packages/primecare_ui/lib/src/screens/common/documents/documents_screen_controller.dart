import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentsScreenState extends DashboardState<DocumentsScreenState> {
  DocumentsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  DocumentsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => DocumentsScreenState(isLoading: isLoading, error: error, data: data);
}

class DocumentsScreenController
    extends BaseDashboardController<DocumentsScreenState> {
  DocumentsScreenController(Ref ref)
    : super(
        ref,
        initialState: DocumentsScreenState(isLoading: true, data: {}),
        endpoint: '/common/documents',
      );
}

final documentsControllerProvider =
    StateNotifierProvider<DocumentsScreenController, DocumentsScreenState>((
      ref,
    ) {
      return DocumentsScreenController(ref);
    });
