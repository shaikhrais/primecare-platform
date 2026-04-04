import '../dtos/stitch_pharmacy_00141_dto.dart';
import '../../domain/models/stitch_pharmacy_00141_view_model.dart';

class StitchPharmacy00141Mapper {
  static StitchPharmacy00141ViewModel fromApi(StitchPharmacy00141Dto dto) {
    return StitchPharmacy00141ViewModel(
      title: dto.title,
      status: dto.status,
    );
  }
}
