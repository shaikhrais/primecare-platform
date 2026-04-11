import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:primecare_psw/src/core/api/api_client.dart';
import 'package:primecare_psw/src/core/theme/app_theme.dart';

class VisitCheckinScreen extends ConsumerStatefulWidget {
  final String visitId;
  const VisitCheckinScreen({super.key, required this.visitId});

  @override
  ConsumerState<VisitCheckinScreen> createState() => _VisitCheckinScreenState();
}

class _VisitCheckinScreenState extends ConsumerState<VisitCheckinScreen> {
  bool _isCheckedIn = false;
  bool _isLoading = false;
  String? _error;
  Position? _currentPosition;
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<Position?> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() =>
            _error = 'Location services are disabled. Enable GPS to check in.');
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _error =
              'Location permission denied. GPS is required for EVV compliance.');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _error =
            'Location permanently denied. Please enable in system settings.');
        return null;
      }

      return await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high),
      );
    } catch (e) {
      setState(() => _error = 'Could not get location: $e');
      return null;
    }
  }

  Future<void> _handleCheckIn() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    HapticFeedback.mediumImpact();

    final pos = await _getCurrentLocation();
    if (pos == null) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      final api = ref.read(apiClientProvider);
      await api.checkIn(
        visitId: widget.visitId,
        latitude: pos.latitude,
        longitude: pos.longitude,
      );
      setState(() {
        _isCheckedIn = true;
        _currentPosition = pos;
      });
      HapticFeedback.heavyImpact();
    } catch (e) {
      setState(() => _error = 'Check-in failed. Please try again.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleCheckOut() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    HapticFeedback.mediumImpact();

    final pos = await _getCurrentLocation();
    if (pos == null) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      final api = ref.read(apiClientProvider);
      await api.checkOut(
        visitId: widget.visitId,
        latitude: pos.latitude,
        longitude: pos.longitude,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      );
      HapticFeedback.heavyImpact();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Visit completed. Great work!'),
            backgroundColor: AppTheme.success,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() => _error = 'Check-out failed. Please try again.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visit Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Visit info card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.medical_services,
                                color: AppTheme.primary, size: 24),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Visit',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18)),
                                SizedBox(height: 2),
                                Text('Personal Care Assistance',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF6B7280))),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 12),
                      _infoRow(
                          'Status',
                          _isCheckedIn
                              ? '🟢 Checked In'
                              : '⏳ Awaiting Check-in'),
                      if (_currentPosition != null)
                        _infoRow('Location',
                            '${_currentPosition!.latitude.toStringAsFixed(4)}, ${_currentPosition!.longitude.toStringAsFixed(4)}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Error display
              if (_error != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppTheme.error.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber,
                          color: AppTheme.error, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Text(_error!,
                              style: const TextStyle(
                                  color: AppTheme.error, fontSize: 13))),
                    ],
                  ),
                ),

              // Visit notes (shown after check-in)
              if (_isCheckedIn) ...[
                Text('Visit Notes',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                TextField(
                  controller: _notesController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Enter any notes about this visit...',
                  ),
                ),
                const SizedBox(height: 20),
              ],

              const Spacer(),

              // Main action button
              SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _isLoading
                      ? null
                      : (_isCheckedIn ? _handleCheckOut : _handleCheckIn),
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : Icon(_isCheckedIn ? Icons.logout : Icons.login),
                  label: Text(_isCheckedIn ? 'CHECK OUT' : 'CHECK IN'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isCheckedIn ? AppTheme.warning : AppTheme.primary,
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13)),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }
}
