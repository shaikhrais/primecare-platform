import '../dtos/stitch_pharmacy_00113_dto.dart';
import '../../domain/models/stitch_pharmacy_00113_view_model.dart';

class StitchPharmacy00113Mapper {
  static StitchPharmacy00113ViewModel fromApi(StitchPharmacy00113Dto dto) {
    return StitchPharmacy00113ViewModel(
      title: dto.title,
      status: dto.status,
      inventoryAlerts: [],
      prescriptionsPending: 0,
    );
  }
}
