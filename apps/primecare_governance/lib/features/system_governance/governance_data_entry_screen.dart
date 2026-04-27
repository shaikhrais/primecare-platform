import 'package:primecare_ui/primecare_ui.dart';
import 'app_entry_form.dart';
import 'role_entry_form.dart';
import 'module_entry_form.dart';
import 'feature_entry_form.dart';
import 'screen_entry_form.dart';
import 'route_entry_form.dart';
import 'api_entry_form.dart';
import 'permission_entry_form.dart';
import 'language_entry_form.dart';
import 'status_entry_form.dart';

class GovernanceDataEntryScreen extends StatefulWidget {
  final String? initialForm;
  const GovernanceDataEntryScreen({super.key, this.initialForm});

  @override
  State<GovernanceDataEntryScreen> createState() =>
      _GovernanceDataEntryScreenState();
}

class _GovernanceDataEntryScreenState extends State<GovernanceDataEntryScreen> {
  late String _selectedForm;

  @override
  void initState() {
    super.initState();
    _selectedForm = widget.initialForm ?? 'Feature Entry';
    if (_selectedForm == 'Data Entry' || _selectedForm == 'Feature Intake') {
      _selectedForm = 'Feature Entry';
    }
  }

  Widget _buildSelectedForm() {
    switch (_selectedForm) {
      case 'App Entry':
        return const AppEntryForm();
      case 'Role Entry':
        return const RoleEntryForm();
      case 'Module Entry':
        return const ModuleEntryForm();
      case 'Feature Entry':
        return const FeatureEntryForm();
      case 'Screen Entry':
        return const ScreenEntryForm();
      case 'Route Entry':
        return const RouteEntryForm();
      case 'API Entry':
        return const ApiEntryForm();
      case 'Permission Entry':
        return const PermissionEntryForm();
      case 'Language Entry':
        return const LanguageEntryForm();
      case 'Status Entry':
        return const StatusEntryForm();
      default:
        return const FeatureEntryForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: PrimeCareColors.white,
      margin: EdgeInsets.zero,
      elevation: 6,
      shadowColor: PrimeCareColors.slate800.withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: PrimeCareColors.slate300, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PrimeCare Control Data Entry System',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    [
                          'App Entry',
                          'Role Entry',
                          'Module Entry',
                          'Feature Entry',
                          'Screen Entry',
                          'Route Entry',
                          'API Entry',
                          'Permission Entry',
                          'Language Entry',
                          'Status Entry',
                        ]
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChoiceChip(
                              label: Text(e),
                              selected: _selectedForm == e,
                              onSelected: (selected) {
                                if (selected) {
                                  setState(() => _selectedForm = e);
                                }
                              },
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
            const SizedBox(height: 24),
            _buildSelectedForm(),
          ],
        ),
      ),
    );
  }
}
