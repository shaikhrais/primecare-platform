import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:primecare_core/flutter_core.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../theme/design_system.dart';

class InstitutionalBookingDialog extends ConsumerStatefulWidget {
  final HorizonSchedule schedule;
  final DateTime initialDate;
  final bool showResources;
  final Appointment? initialAppointment;
  final InstitutionalResource? initialResource;
  final StaffMember? initialStaff;

  const InstitutionalBookingDialog({
    super.key,
    required this.schedule,
    required this.initialDate,
    this.showResources = true,
    this.initialAppointment,
    this.initialResource,
    this.initialStaff,
  });

  @override
  ConsumerState<InstitutionalBookingDialog> createState() =>
      _InstitutionalBookingDialogState();
}

class _InstitutionalBookingDialogState
    extends ConsumerState<InstitutionalBookingDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _patientName;
  late StaffMember _selectedStaff;
  late InstitutionalResource? _selectedResource;
  late DateTime _selectedTime;
  late int _durationMinutes;
  bool _isChecking = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final appt = widget.initialAppointment;

    _patientName = appt?.patientName ?? '';

    _selectedStaff = appt != null
        ? widget.schedule.staff.firstWhere(
            (s) => s.id == appt.staffId,
            orElse: () => widget.schedule.staff.first,
          )
        : widget.initialStaff ?? widget.schedule.staff.first;

    _selectedResource = appt != null
        ? widget.schedule.resources.cast<InstitutionalResource?>().firstWhere(
            (r) => r?.id == appt.resourceId,
            orElse: () => null,
          )
        : widget.initialResource ??
              ((widget.showResources && widget.schedule.resources.isNotEmpty)
                  ? widget.schedule.resources.first
                  : null);

    _selectedTime =
        appt?.startTime ?? widget.initialDate.copyWith(hour: 9, minute: 0);
    _durationMinutes = appt?.duration.inMinutes ?? 60;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(executionGateProvider)
          .passGate(
            ExecutionGateCategory.scheduler,
            'Hydrating Booking Dialog: ${widget.initialAppointment != null ? "Edit" : "New"}',
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;
    final theme = PrimeCareDesignSystem.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 500 * scale,
        padding: EdgeInsets.all(32 * scale),
        decoration: BoxDecoration(
          color: theme.colors.surface,
          borderRadius: PrimeCareRadii.scaled(scale),
          boxShadow: [
            BoxShadow(
              color: theme.colors.shadow,
              blurRadius: 40 * scale,
              offset: Offset(0, 20 * scale),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.initialAppointment != null
                        ? 'Edit Appointment'
                        : 'Book New Appointment',
                    style: TextStyle(
                      fontSize: 20 * scale,
                      fontWeight: FontWeight.bold,
                      color: theme.colors.textPrimary,
                    ),
                  ),
                  Row(
                    children: [
                      if (widget.initialAppointment != null)
                        IconButton(
                          onPressed: _handleDelete,
                          icon: Icon(
                            LucideIcons.trash2,
                            size: 20 * scale,
                            color: theme.colors.danger,
                          ),
                          tooltip: 'Delete Appointment',
                        ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(LucideIcons.x, size: 20 * scale),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 32),

              // Patient Name
              Text('Patient Name', style: _labelStyle(scale, theme)),
              SizedBox(height: 8 * scale),
              TextFormField(
                initialValue: _patientName,
                decoration: _inputDecoration(
                  'Enter patient name',
                  scale,
                  theme,
                ),
                onChanged: (v) => _patientName = v,
                validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
              ),
              SizedBox(height: 20 * scale),

              Row(
                children: [
                  // Staff Selection
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Professional Staff',
                          style: _labelStyle(scale, theme),
                        ),
                        SizedBox(height: 8 * scale),
                        DropdownButtonFormField<StaffMember>(
                          // ignore: deprecated_member_use
                          value: _selectedStaff,
                          items: widget.schedule.staff
                              .map(
                                (s) => DropdownMenuItem(
                                  value: s,

                                  child: Text(
                                    s.name,
                                    style: TextStyle(fontSize: 14 * scale),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => _selectedStaff = v!),
                          decoration: _inputDecoration('', scale, theme),
                        ),
                      ],
                    ),
                  ),
                  if (widget.showResources) ...[
                    SizedBox(width: 16 * scale),
                    // Resource Selection
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Resource / Suite',
                            style: _labelStyle(scale, theme),
                          ),
                          SizedBox(height: 8 * scale),
                          DropdownButtonFormField<InstitutionalResource?>(
                            // ignore: deprecated_member_use
                            value: _selectedResource,
                            items: [
                              const DropdownMenuItem(
                                value: null,
                                child: Text('No Resource'),
                              ),
                              ...widget.schedule.resources.map(
                                (r) => DropdownMenuItem(
                                  value: r,
                                  child: Text(
                                    r.name,
                                    style: TextStyle(fontSize: 14 * scale),
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (v) =>
                                setState(() => _selectedResource = v),
                            decoration: _inputDecoration('', scale, theme),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 20 * scale),

              // Time Selection (Simple for Demo)
              Text('Time Slot (Minutes)', style: _labelStyle(scale, theme)),
              SizedBox(height: 8 * scale),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${_selectedTime.hour}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16 * scale,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      initialValue: _durationMinutes.toString(),
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration('Min', scale, theme),
                      onChanged: (v) =>
                          _durationMinutes = int.tryParse(v) ?? 60,
                    ),
                  ),
                ],
              ),

              if (_error != null) ...[
                SizedBox(height: 16 * scale),
                Container(
                  padding: EdgeInsets.all(12 * scale),
                  decoration: BoxDecoration(
                    color: theme.colors.dangerSurface,
                    borderRadius: BorderRadius.circular(8 * scale),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.alertCircle,
                        color: theme.colors.danger,
                        size: 16 * scale,
                      ),
                      SizedBox(width: 8 * scale),
                      Expanded(
                        child: Text(
                          _error!,
                          style: TextStyle(
                            color: theme.colors.danger,
                            fontSize: 13 * scale,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const Divider(height: 48),

              SizedBox(
                width: double.infinity,
                height: 48 * scale,
                child: ElevatedButton(
                  onPressed: _isChecking ? null : _validateAndSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PrimeCareDesignSystem.primaryBrand,
                    foregroundColor: PrimeCareColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: PrimeCareRadii.scaled(scale),
                    ),
                  ),
                  child: _isChecking
                      ? SizedBox(
                          height: 20 * scale,
                          width: 20 * scale,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: PrimeCareColors.white,
                          ),
                        )
                      : Text(
                          widget.initialAppointment != null
                              ? 'Update Appointment'
                              : 'Confirm Appointment',
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Appointment?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: PrimeCareColors.rose),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      Navigator.pop(context, 'delete'); // Return special 'delete' signal
    }
  }

  TextStyle _labelStyle(double scale, PrimeCareDesignSystem theme) => TextStyle(
    fontSize: 12 * scale,
    fontWeight: FontWeight.bold,
    color: theme.colors.textSecondary,
    letterSpacing: 0.5,
  );

  InputDecoration _inputDecoration(
    String hint,
    double scale,
    PrimeCareDesignSystem theme,
  ) => InputDecoration(
    hintText: hint,
    isDense: true,
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16 * scale,
      vertical: 12 * scale,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8 * scale),
      borderSide: BorderSide(color: theme.colors.borderSubtle),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8 * scale),
      borderSide: BorderSide(color: theme.colors.borderSubtle),
    ),
  );

  Future<void> _validateAndSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isChecking = true;
      _error = null;
    });

    // Simulate Network Delay
    await Future<void>.delayed(const Duration(milliseconds: 800));

    final newAppt = Appointment(
      id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
      patientName: _patientName,
      startTime: _selectedTime,
      duration: Duration(minutes: _durationMinutes),
      staffId: _selectedStaff.id,
      resourceId: _selectedResource?.id,
      status: AppointmentStatus.pending,
    );

    final hasConflict = SchedulerService().hasConflict(
      newAppt,
      widget.schedule.appointments,
      widget.schedule.resources,
    );

    if (hasConflict) {
      ref
          .read(executionGateProvider)
          .failGate(
            ExecutionGateCategory.scheduler,
            'Booking Conflict: Patient $_patientName with ${_selectedStaff.name}',
          );
      setState(() {
        _isChecking = false;
        _error =
            'Conflict detected! Staff or Resource is unavailable or in maintenance during this slot.';
      });
    } else {
      ref
          .read(executionGateProvider)
          .passGate(
            ExecutionGateCategory.scheduler,
            'Booking Confirmed: $_patientName',
          );
      if (mounted) {
        // Return the constructed appointment object
        Navigator.pop(context, newAppt);
      }
    }
  }
}
