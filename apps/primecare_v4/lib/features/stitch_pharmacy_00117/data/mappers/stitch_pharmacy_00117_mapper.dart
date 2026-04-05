import '../dtos/stitch_pharmacy_00117_dto.dart';
import '../../domain/models/stitch_pharmacy_00117_view_model.dart';

class StitchPharmacy00117Mapper {
  static StitchPharmacy00117ViewModel fromApi(StitchPharmacy00117Dto dto) {
    return StitchPharmacy00117ViewModel(
      title: dto.title,
      status: dto.status,
      inventoryAlerts: [],
      prescriptionsPending: 0,
    );
  }
}
