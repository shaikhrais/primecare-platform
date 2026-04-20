import '../../../../network/result.dart';
import '../models/physiotherapist_data.dart';

abstract class IPhysiotherapistRepository {
  Future<Result<PhysiotherapistData>> getPhysiotherapistData();
}

class PhysiotherapistRepository implements IPhysiotherapistRepository {
  @override
  Future<Result<PhysiotherapistData>> getPhysiotherapistData() async {
    return Result.success(PhysiotherapistData.mock());
  }
}
