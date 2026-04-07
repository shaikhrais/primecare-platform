import '../dtos/stitch_pharmacy_00133_dto.dart';
import '../../domain/models/stitch_pharmacy_00133_view_model.dart';

class StitchPharmacy00133Mapper {
  static StitchPharmacy00133ViewModel fromApi(StitchPharmacy00133Dto dto) {
    return StitchPharmacy00133ViewModel(
      title: dto.title,
      status: dto.status,
      inventoryAlerts: [],
      prescriptionsPending: 0,
    );
  }
}
