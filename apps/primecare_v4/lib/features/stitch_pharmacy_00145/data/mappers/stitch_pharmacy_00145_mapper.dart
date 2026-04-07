import '../dtos/stitch_pharmacy_00145_dto.dart';
import '../../domain/models/stitch_pharmacy_00145_view_model.dart';

class StitchPharmacy00145Mapper {
  static StitchPharmacy00145ViewModel fromApi(StitchPharmacy00145Dto dto) {
    return StitchPharmacy00145ViewModel(
      title: dto.title,
      status: dto.status,
      inventoryAlerts: [],
      prescriptionsPending: 0,
    );
  }
}
