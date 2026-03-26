import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../../core/api_client.dart';

class TerritoryZone {
  final String region;
  final String zipCodes;
  final int population;
  final bool isClaimed;

  TerritoryZone({
    required this.region,
    required this.zipCodes,
    required this.population,
    required this.isClaimed,
  });
}

class SuperuserTerritoryMapScreen extends ConsumerStatefulWidget {
  const SuperuserTerritoryMapScreen({super.key});

  @override
  ConsumerState<SuperuserTerritoryMapScreen> createState() =>
      _SuperuserTerritoryMapScreenState();
}

class _SuperuserTerritoryMapScreenState
    extends ConsumerState<SuperuserTerritoryMapScreen> {
  bool _isLoading = false;
  List<TerritoryZone> _zones = [];

  @override
  void initState() {
    super.initState();
    _fetchTerritories();
  }

  Future<void> _fetchTerritories() async {
    setState(() => _isLoading = true);
    try {
      final data = await apiClient.get('/v1/superuser/territories');
      if (mounted) {
        setState(() {
          _zones = (data as List).map((z) => TerritoryZone(
            region: z['region'],
            zipCodes: z['zipCodes'],
            population: z['population'],
            isClaimed: z['isClaimed'],
          )).toList();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load territories from Edge API: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _slugCtrl = TextEditingController();
  final _adminNameCtrl = TextEditingController();
  final _adminEmailCtrl = TextEditingController();

  Future<void> _provisionFranchise(TerritoryZone zone) async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);

    try {
      final res = await apiClient.post('/v1/superuser/tenants', body: {
        'name': _nameCtrl.text.trim(),
        'slug': _slugCtrl.text.trim(),
        'adminName': _adminNameCtrl.text.trim(),
        'adminEmail': _adminEmailCtrl.text.trim(),
      });

      if (!mounted) return;

      if (res['success'] == true) {
        showSuccessSnackBar(
          context,
          'Franchise Deployed: ${res['tenant']['domain']}\nSetup Fee logged to Master Ledger.',
        );
        Navigator.pop(context); // Close modal
      } else {
        showErrorSnackBar(context, res['error'] ?? 'Provisioning Failed');
      }
    } catch (e) {
      showErrorSnackBar(context, 'Provisioning crashed: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showProvisionModal(TerritoryZone zone) {
    _nameCtrl.text = 'PrimeCare ${zone.region}';
    _slugCtrl.text = zone.region.toLowerCase().replaceAll(' ', '-');
    _adminNameCtrl.text = 'Regional GM';
    _adminEmailCtrl.text = 'gm@${_slugCtrl.text}.primecare.ca';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom,
              top: 24, left: 24, right: 24,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sell Franchise Territory', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(
                      'Target: ${zone.region} | Pop: ${zone.population}',
                      style: TextStyle(color: Colors.blue.shade600, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameCtrl,
                      decoration: const InputDecoration(labelText: 'Franchise Legal Name', border: OutlineInputBorder()),
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _slugCtrl,
                      decoration: const InputDecoration(labelText: 'Tenant Core Slug (Domain)', border: OutlineInputBorder()),
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _adminNameCtrl,
                      decoration: const InputDecoration(labelText: 'GM / Owner Name', border: OutlineInputBorder()),
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _adminEmailCtrl,
                      decoration: const InputDecoration(labelText: 'GM / Owner Email', border: OutlineInputBorder()),
                      validator: (v) => v!.contains('@') ? null : 'Invalid Email',
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981)),
                        icon: _isLoading 
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : const Icon(Icons.rocket_launch, color: Colors.white),
                        label: Text(_isLoading ? 'Provisioning...' : 'Provision Franchise & Bill \$50,000', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        onPressed: _isLoading ? null : () async {
                          setModalState(() => _isLoading = true);
                          await _provisionFranchise(zone);
                          setModalState(() => _isLoading = false);
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Master Territory Configurator'),
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live Geographic Mapbox UI Visualization
            SizedBox(
              height: 350,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.withOpacity(0.3), width: 2),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5)),
                    ],
                  ),
                  child: FlutterMap(
                    options: const MapOptions(
                      initialCenter: LatLng(43.8, -79.4),
                      initialZoom: 8.5,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibW9jay1kZW1vLW1hcGJveCJ9',
                        userAgentPackageName: 'com.primecare.mobile',
                      ),
                      CircleLayer(
                        circles: _zones.asMap().entries.map((entry) {
                          final idx = entry.key;
                          final z = entry.value;
                          final lat = 43.6 + (idx * 0.15);
                          final lng = -79.5 + (idx * 0.12);
                          return CircleMarker(
                            point: LatLng(lat, lng),
                            color: z.isClaimed ? Colors.red.withOpacity(0.4) : Colors.green.withOpacity(0.5),
                            borderColor: z.isClaimed ? Colors.red : Colors.green,
                            borderStrokeWidth: 2,
                            useRadiusInMeter: true,
                            radius: (z.population / 20).clamp(5000.0, 15000.0),
                          );
                        }).toList(),
                      ),
                      MarkerLayer(
                        markers: _zones.asMap().entries.map((entry) {
                          final idx = entry.key;
                          final z = entry.value;
                          final lat = 43.6 + (idx * 0.15);
                          final lng = -79.5 + (idx * 0.12);
                          return Marker(
                            point: LatLng(lat, lng),
                            width: 120,
                            height: 40,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: z.isClaimed ? Colors.red : Colors.green),
                              ),
                              child: Center(
                                child: Text(
                                  z.region,
                                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Exclusive Franchise Territories', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Select a demographic territory to instantly provision a new multi-tenant database for the franchisee.', style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 16),
            ..._zones.map((zone) => _buildZoneCard(zone)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildZoneCard(TerritoryZone zone) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: zone.isClaimed ? Colors.green.withOpacity(0.5) : Colors.grey.withOpacity(0.2))),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: zone.isClaimed ? Colors.green.withOpacity(0.2) : Colors.blue.withOpacity(0.2),
          child: Icon(zone.isClaimed ? Icons.check_circle : Icons.map, color: zone.isClaimed ? Colors.green : Colors.blue),
        ),
        title: Text(zone.region, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('ZIP/Postal Boundaries: ${zone.zipCodes}'),
            const SizedBox(height: 2),
            Text('Calculated Population: ${zone.population.toString().replaceAllMapped(RegExp(r'(\\d{1,3})(?=(\\d{3})+(?!\\d))'), (Match m) => '${m[1]},')}', style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
          ],
        ),
        trailing: zone.isClaimed 
          ? const Chip(label: Text('SOLD OUT'), backgroundColor: Colors.redAccent, labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
          : ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () => _showProvisionModal(zone),
              child: const Text('PROVISION', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
      ),
    );
  }
}
