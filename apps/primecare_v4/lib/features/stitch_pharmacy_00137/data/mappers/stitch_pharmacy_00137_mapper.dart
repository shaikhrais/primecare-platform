import '../dtos/stitch_pharmacy_00137_dto.dart';
import '../../domain/models/stitch_pharmacy_00137_view_model.dart';

class StitchPharmacy00137Mapper {
  static StitchPharmacy00137ViewModel fromApi(StitchPharmacy00137Dto dto) {
    return StitchPharmacy00137ViewModel(
      title: dto.title,
      status: dto.status,
      inventoryAlerts: [],
      prescriptionsPending: 0,
    );
  }
}
