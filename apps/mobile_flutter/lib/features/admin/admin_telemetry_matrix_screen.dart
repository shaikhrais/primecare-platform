import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';
import '../../core/api_client.dart';
import 'package:go_router/go_router.dart';

class AdminTelemetryMatrixScreen extends StatefulWidget {
  const AdminTelemetryMatrixScreen({super.key});

  @override
  State<AdminTelemetryMatrixScreen> createState() => _AdminTelemetryMatrixScreenState();
}

class _AdminTelemetryMatrixScreenState extends State<AdminTelemetryMatrixScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  List<Map<String, dynamic>> _masterData = [];
  List<Map<String, dynamic>> _filteredData = [];
  bool _isLoading = true;
  String? _errorMsg;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _fetchLiveRegistries();
  }

  Future<void> _fetchLiveRegistries() async {
    try {
      final response = await apiClient.get('/v1/public/registries');
      
      // Attempt to map standard REST collections, fallback securely if empty.
      final List<dynamic> records = response['data'] ?? response['items'] ?? [];
      
      if (mounted) {
        setState(() {
          _masterData = records.map((e) => {
            'id': e['id']?.toString() ?? 'UKN-000',
            'name': e['name']?.toString() ?? e['title']?.toString() ?? 'System Resource',
            'status': e['status']?.toString() ?? 'Active',
            'date': e['updatedAt']?.toString() ?? 'Just now',
          }).toList();
          _filteredData = _masterData;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMsg = 'Failed to sync with PrimeCare API: $e';
          _isLoading = false;
        });
      }
    }
  }

  void _filterData(String query) {
    setState(() {
      _selectedIndex = null; // Clear selection on search
      if (query.trim().isEmpty) {
        _filteredData = _masterData;
      } else {
        final lowerQuery = query.toLowerCase();
        _filteredData = _masterData.where((item) {
          return item.values.any((val) => val.toString().toLowerCase().contains(lowerQuery));
        }).toList();
      }
    });
  }

  void _handleLogout() async {
    await apiClient.logout();
    if (mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCarePadding(
        padding: EdgeInsets.all(16.0),
        child: PrimeCareColumn(
          children: [
            // Structural Global Header Search Filter
            PrimeCareCard(
              
              child: TextField(
                controller: _searchController,
                onChanged: _filterData,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.liveKeywordSearch,
                  hintStyle: TextStyle(color: PrimeCareColors.slate400, fontSize: 14),
                  prefixIcon: PrimeCareIcon(Icons.search, color: PrimeCareColors.slate400),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            SizedBox(height: 16),
            
            // Native Zebra Striped Data Table Wrapper
            PrimeCareExpanded(
              child: PrimeCareCard(
                
                child: PrimeCareColumn(
                  children: [
                    // Native Header Layout
                    PrimeCareCard(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      
                      child: PrimeCareRow(
                        children: [
                          PrimeCareExpanded(flex: 2, child: PrimeCareText('IDENTIFIER', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: PrimeCareColors.slate500, letterSpacing: 0.5))),
                          PrimeCareExpanded(flex: 3, child: PrimeCareText('CLASSIFICATION', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: PrimeCareColors.slate500, letterSpacing: 0.5))),
                          PrimeCareExpanded(flex: 2, child: PrimeCareCenter(child: PrimeCareText('STATUS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: PrimeCareColors.slate500, letterSpacing: 0.5)))),
                        ],
                      ),
                    ),
                    
                    // Native ListView rendering
                    PrimeCareExpanded(
                      child: _isLoading 
                        ? PrimeCareCenter(child: CircularProgressIndicator(color: Color(0xFF0EA5E9)))
                        : _errorMsg != null
                          ? PrimeCareCenter(
                              child: PrimeCarePadding(
                                padding: EdgeInsets.all(32.0),
                                child: PrimeCareText(_errorMsg!, textAlign: TextAlign.center, style: TextStyle(color: PrimeCareColors.rose, fontWeight: FontWeight.bold)),
                              ),
                            )
                          : _filteredData.isEmpty
                            ? PrimeCareCenter(
                                child: PrimeCareColumn(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PrimeCareIcon(Icons.inventory_2_outlined, size: 48, color: PrimeCareColors.slate300),
                                    SizedBox(height: 12),
                                    PrimeCareText('No active API entities discovered.', style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: _filteredData.length,
                            itemBuilder: (context, index) {
                              final item = _filteredData[index];
                              final isEven = index % 2 == 1; // 1-based indexing parity
                              final isSelected = _selectedIndex == index;
                              
                              Color rowColor = Colors.white;
                              if (isSelected) {
                                rowColor = Color(0x140EA5E9); // Highlight
                              } else if (isEven) {
                                rowColor = Color(0x05000000); // Zebra Strike
                              }

                              return InkWell(
                                onTap: () => setState(() => _selectedIndex = isSelected ? null : index),
                                child: PrimeCareCard(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  
                                  child: PrimeCareRow(
                                    children: [
                                      PrimeCareExpanded(flex: 2, child: PrimeCareText(item['id'] ?? '', style: TextStyle(fontWeight: FontWeight.w600, color: PrimeCareColors.radarDark, fontSize: 13))),
                                      PrimeCareExpanded(flex: 3, child: PrimeCareText(item['name'] ?? '', style: TextStyle(color: PrimeCareColors.slate700, fontSize: 13))),
                                      PrimeCareExpanded(flex: 2, child: PrimeCareCenter(
                                        child: PrimeCareCard(
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          
                                          child: PrimeCareText(
                                            (item['status'] ?? '').toUpperCase(),
                                            style: TextStyle(
                                              color: item['status'] == 'Active' ? PrimeCareColors.emerald : PrimeCareColors.amber,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
        ),
      ),
    );
  }
}
