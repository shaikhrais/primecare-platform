import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/franchise_owner/domain/models/franchise_owner_view_model.dart';
import 'package:flutter_core/features/franchise_owner/data/mappers/franchise_owner_mapper.dart';
// import 'package:flutter_core/features/franchise_owner/data/dtos/franchise_owner_dto.dart';

final franchiseOwnerAdapterProvider = FutureProvider<FranchiseOwnerViewModel>((
  ref,
) async {
  // Simulating hybrid/mock data pipeline as per architecture.
  await Future.delayed(
    const Duration(milliseconds: 600),
  ); // Simulate network latency

  // Here we would use DataSourceConfig.currentMode to check if we are in API or Mock mode.
  // For safety and immediate rendering, we fallback to the robust Mock Mapper parsing.
  return FranchiseOwnerMapper.fromMock({});
});
