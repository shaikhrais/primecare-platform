import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:flutter/services.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'psw_client_360_screen.dart';

class PswClientsScreen extends StatefulWidget {
  const PswClientsScreen({super.key});

  @override
  State<PswClientsScreen> createState() => _PswClientsScreenState();
}

class _PswClientsScreenState extends State<PswClientsScreen> {
  final List<Map<String, String>> _clients = [
    {'id': 'c_1', 'name': 'Sarah Jenkins', 'status': 'Stable', 'address': '123 Main St, Toronto'},
    {'id': 'c_2', 'name': 'Robert Kiyosaki', 'status': 'Monitoring', 'address': '44 Financial Ave, York'},
    {'id': 'c_3', 'name': 'Eliza Thornberry', 'status': 'Critical', 'address': '99 Safari Rd, Etobicoke'},
  ];

  String? _selectedClientId;
  String? _selectedClientName;

  void _onClientSelected(String id, String name, bool isDesktop) {
    HapticFeedback.lightImpact();
    if (isDesktop) {
      setState(() {
        _selectedClientId = id;
        _selectedClientName = name;
      });
    } else {
      // Standard mobile routing push
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => PswClient360Screen(clientId: id, clientName: name))
      );
    }
  }

  void _onBackToMaster() {
    setState(() {
      _selectedClientId = null;
      _selectedClientName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    
    final masterListWidget = PrimeCareScaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: PrimeCareNavBar(
        title: PrimeCareText(
          'Assigned Clients', 
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(24, 8, 24, 120),
        itemCount: _clients.length,
        itemBuilder: (context, index) {
          final client = _clients[index];
          final isCritical = client['status'] == 'Critical';
          final statusColor = isCritical ? PrimeCareColors.rose : PrimeCareColors.emerald;
          final isSelected = _selectedClientId == client['id'];

          return PrimeCarePadding(
            padding: EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () => _onClientSelected(client['id']!, client['name']!, isDesktop),
              borderRadius: BorderRadius.circular(20),
              child: AnimatedPrimeCareCard(
                duration: Duration(milliseconds: 200),
                
                padding: EdgeInsets.all(20),
                child: PrimeCareRow(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: isSelected && isDesktop ? PrimeCareColors.slate400 : PrimeCareColors.slate200,
                      child: PrimeCareText(
                        client['name']!.substring(0, 1), 
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24, 
                          color: isSelected && isDesktop ? Colors.white : PrimeCareColors.radarDark
                        )
                      ),
                    ),
                    PrimeCareSizedBox(width: 16),
                    PrimeCareExpanded(
                      child: PrimeCareColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimeCareText(client['name']!, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: PrimeCareColors.radarDark)),
                          PrimeCareSizedBox(height: 4),
                          PrimeCareText(client['address']!, style: TextStyle(color: PrimeCareColors.slate500, fontSize: 14)),
                          PrimeCareSizedBox(height: 12),
                          PrimeCareRow(
                            children: [
                              PrimeCareCard(
                                width: 8, height: 8,
                                
                              ),
                              PrimeCareSizedBox(width: 6),
                              PrimeCareText(client['status']!, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 13)),
                            ],
                          )
                        ],
                      ),
                    ),
                    PrimeCareIcon(Icons.arrow_forward_ios_rounded, color: PrimeCareColors.slate300, size: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    return MasterDetailLayout(
      masterList: masterListWidget,
      detailView: _selectedClientId != null 
          ? PswClient360Screen(clientId: _selectedClientId!, clientName: _selectedClientName!)
          : PrimeCareContainer(color: Colors.white), // Handled by Layout placeholder naturally
      isDetailActive: _selectedClientId != null,
      onBackToMaster: _onBackToMaster,
    );
  }
}
