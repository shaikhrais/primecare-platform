import '../dtos/stitch_pharmacy_00121_dto.dart';
import '../../domain/models/stitch_pharmacy_00121_view_model.dart';

class StitchPharmacy00121Mapper {
  static StitchPharmacy00121ViewModel fromApi(StitchPharmacy00121Dto dto) {
    return StitchPharmacy00121ViewModel(
      title: dto.title,
      status: dto.status,
    );
  }
}
