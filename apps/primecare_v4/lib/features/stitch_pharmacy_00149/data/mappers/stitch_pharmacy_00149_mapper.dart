import '../dtos/stitch_pharmacy_00149_dto.dart';
import '../../domain/models/stitch_pharmacy_00149_view_model.dart';

class StitchPharmacy00149Mapper {
  static StitchPharmacy00149ViewModel fromApi(StitchPharmacy00149Dto dto) {
    return StitchPharmacy00149ViewModel(
      title: dto.title,
      status: dto.status,
      inventoryAlerts: [],
      prescriptionsPending: 0,
    );
  }
}
