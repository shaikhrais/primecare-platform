import 'package:flutter/material.dart';
import '../shared/layouts/desktop_pane_wrapper.dart';
import '../../core/api_client.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('PrimeCare Matrix', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: const Color(0xFF0EA5E9),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, size: 22),
            onPressed: _handleLogout,
            tooltip: 'Terminate Session',
          ),
        ],
      ),
      body: Center(
        child: DesktopPaneWrapper(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Structural Global Header Search Filter
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterData,
                decoration: const InputDecoration(
                  hintText: 'Live Keyword Search...',
                  hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF94A3B8)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Native Zebra Striped Data Table Wrapper
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: const [BoxShadow(color: Color(0x05000000), blurRadius: 4, offset: Offset(0, 2))],
                ),
                child: Column(
                  children: [
                    // Native Header Layout
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 2)),
                      ),
                      child: const Row(
                        children: [
                          Expanded(flex: 2, child: Text('IDENTIFIER', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF64748B), letterSpacing: 0.5))),
                          Expanded(flex: 3, child: Text('CLASSIFICATION', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF64748B), letterSpacing: 0.5))),
                          Expanded(flex: 2, child: Center(child: Text('STATUS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF64748B), letterSpacing: 0.5)))),
                        ],
                      ),
                    ),
                    
                    // Native ListView rendering
                    Expanded(
                      child: _isLoading 
                        ? const Center(child: CircularProgressIndicator(color: Color(0xFF0EA5E9)))
                        : _errorMsg != null
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Text(_errorMsg!, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFFE11D48), fontWeight: FontWeight.bold)),
                              ),
                            )
                          : _filteredData.isEmpty
                            ? const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.inventory_2_outlined, size: 48, color: Color(0xFFCBD5E1)),
                                    SizedBox(height: 12),
                                    Text('No active API entities discovered.', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
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
                                rowColor = const Color(0x140EA5E9); // Highlight
                              } else if (isEven) {
                                rowColor = const Color(0x05000000); // Zebra Strike
                              }

                              return InkWell(
                                onTap: () => setState(() => _selectedIndex = isSelected ? null : index),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  decoration: BoxDecoration(
                                    color: rowColor,
                                    border: Border(
                                      bottom: const BorderSide(color: Color(0xFFE2E8F0)),
                                      left: BorderSide(
                                        color: isSelected ? const Color(0xFF0EA5E9) : Colors.transparent,
                                        width: 3,
                                      )
                                    )
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(flex: 2, child: Text(item['id'] ?? '', style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF0F172A), fontSize: 13))),
                                      Expanded(flex: 3, child: Text(item['name'] ?? '', style: const TextStyle(color: Color(0xFF334155), fontSize: 13))),
                                      Expanded(flex: 2, child: Center(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: item['status'] == 'Active' ? const Color(0x1A10B981) : const Color(0x1AF59E0B),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            (item['status'] ?? '').toUpperCase(),
                                            style: TextStyle(
                                              color: item['status'] == 'Active' ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
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
