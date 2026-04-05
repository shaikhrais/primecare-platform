import '../dtos/stitch_pharmacy_00129_dto.dart';
import '../../domain/models/stitch_pharmacy_00129_view_model.dart';

class StitchPharmacy00129Mapper {
  static StitchPharmacy00129ViewModel fromApi(StitchPharmacy00129Dto dto) {
    return StitchPharmacy00129ViewModel(
      title: dto.title,
      status: dto.status,
      inventoryAlerts: [],
      prescriptionsPending: 0,
    );
  }
}
