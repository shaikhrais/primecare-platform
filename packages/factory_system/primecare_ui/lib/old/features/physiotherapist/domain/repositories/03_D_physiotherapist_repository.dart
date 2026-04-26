// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:primecare_adapters/primecare_adapters.dart';
import '../models/02_M_physiotherapist_data.dart';

abstract class IPhysiotherapistRepository {
  Future<Result<PhysiotherapistData>> getPhysiotherapistData();
}

class PhysiotherapistRepository implements IPhysiotherapistRepository {
  @override
  Future<Result<PhysiotherapistData>> getPhysiotherapistData() async {
    return Result.success(PhysiotherapistData.mock());
  }
}
