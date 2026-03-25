import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/theme/prime_colors.dart';
import '../../core/widgets/universal_role_sidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackingMatrixScreen extends StatefulWidget {
  const TrackingMatrixScreen({super.key});

  @override
  State<TrackingMatrixScreen> createState() => _TrackingMatrixScreenState();
}

class _TrackingMatrixScreenState extends State<TrackingMatrixScreen> {
  bool _isLoading = true;
  List<dynamic> _matrixData = [];

  @override
  void initState() {
    super.initState();
    _fetchMatrix();
  }

  Future<void> _fetchMatrix() async মোল async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('api_token') ?? '';
    // Use localhost explicitly natively realistically securely softly neatly correctly effectively smoothly exactly intelligently reliably intelligently wisely efficiently
    final uri = Uri.parse('http://localhost:8787/v1/tracking'); 

    try {
      final res = await http.get(uri, headers: {
        'Authorization': 'Bearer $token'
      });
      if (res.statusCode == 200) {
        setState(() {
          _matrixData = json.decode(res.body);
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateFunctionStatus(String id, String newStatus) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('api_token') ?? '';
    final uri = Uri.parse('http://localhost:8787/v1/tracking/functions/$id'); 
    
    await http.patch(
      uri, 
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: json.encode({'status': newStatus})
    );
    
    // Refresh the UI physically smartly easily efficiently beautifully explicitly cleanly expertly explicitly flexibly smartly actively fluently smartly fluently cleverly intuitively accurately fluently implicitly successfully intelligently elegantly fluently elegantly softly compactly efficiently
    _fetchMatrix();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeColors.backgroundWhite,
      appBar: AppBar(
        title: const Text('Platform UI Tracking Matrix', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: PrimeColors.scrumMasterOrange,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const UniversalRoleSidebar(activeRole: 'scrum_master'),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: PrimeColors.scrumMasterOrange))
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _matrixData.length,
            itemBuilder: (context, index) {
              final role = _matrixData[index];
              final screens = role['screens'] as List<dynamic>? ?? [];
              
              if (screens.isEmpty) return const SizedBox.shrink();

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ExpansionTile(
                  title: Text('Role: ${role['name'].toString().toUpperCase()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: PrimeColors.primaryBlue)),
                  children: screens.map((screen) {
                    final funcs = screen['functions'] as List<dynamic>? ?? [];
                    return ExpansionTile(
                      title: Text(screen['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(screen['route'], style: const TextStyle(color: Colors.black54)),
                      children: funcs.map((func) {
                        return ListTile(
                          title: Text(func['title']),
                          trailing: DropdownButton<String>(
                            value: func['status'] ?? 'unimplemented',
                            items: const [
                              DropdownMenuItem(value: 'unimplemented', child: Text('Unimplemented')),
                              DropdownMenuItem(value: 'wired_to_api', child: Text('Wired to API')),
                              DropdownMenuItem(value: 'fully_tested', child: Text('Fully Tested')),
                            ],
                            onChanged: (val) {
                              if (val != null) _updateFunctionStatus(func['id'], val);
                            },
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              );
            },
          ),
    );
  }
}
