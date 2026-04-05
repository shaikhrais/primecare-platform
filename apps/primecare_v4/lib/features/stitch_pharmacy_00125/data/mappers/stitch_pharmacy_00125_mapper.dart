import '../dtos/stitch_pharmacy_00125_dto.dart';
import '../../domain/models/stitch_pharmacy_00125_view_model.dart';

class StitchPharmacy00125Mapper {
  static StitchPharmacy00125ViewModel fromApi(StitchPharmacy00125Dto dto) {
    return StitchPharmacy00125ViewModel(
      title: dto.title,
      status: dto.status,
      inventoryAlerts: [],
      prescriptionsPending: 0,
    );
  }
}
