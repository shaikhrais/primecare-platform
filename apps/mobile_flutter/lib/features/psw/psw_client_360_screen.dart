import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class PswClient360Screen extends StatelessWidget {
  final String clientId;
  final String clientName;

  const PswClient360Screen({super.key, required this.clientId, required this.clientName});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: PrimeCareAppBar(title: '$clientName - 360°'),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareScrollWrapper(
        child: PrimeCareColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Structural Header Block
            PrimeCareContainer(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
              child: PrimeCareColumn(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: PrimeCareColors.slate200,
                    child: PrimeCareText(
                      clientName.substring(0, 1), 
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 36, color: PrimeCareColors.radarDark)
                    ),
                  ),
                  const PrimeCareSizedBox(height: 16),
                  PrimeCareText(clientName, style: Theme.of(context).textTheme.headlineMedium),
                  const PrimeCareSizedBox(height: 8),
                  const PrimeCareText('Dementia Care Track • Resuscitate (DNR) - No', style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // Drilled Data Modules
            PrimeCarePadding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: PrimeCareColumn(
                children: [
                  _buildNexusCard(
                    context, 
                    title: 'Active Care Plan Vault', 
                    icon: Icons.folder_special_rounded, 
                    color: const Color(0xFF3B82F6),
                    child: PrimeCareColumn(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const PrimeCareText('Valid from: Oct 1, 2025 to Oct 1, 2026', style: TextStyle(color: Color(0xFF475569))),
                        const PrimeCareSizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const PrimeCareIcon(Icons.picture_as_pdf),
                          label: const PrimeCareText('View Official Directive (PDF)'),
                          
                        )
                      ],
                    )
                  ),
                  
                  const PrimeCareSizedBox(height: 16),

                  _buildNexusCard(
                    context, 
                    title: '30-Day Vitals Trend', 
                    icon: Icons.monitor_heart_rounded, 
                    color: PrimeCareColors.emerald,
                    child: PrimeCareColumn(
                      children: [
                        PrimeCareRow(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            PrimeCareText('Blood Pressure', style: TextStyle(fontWeight: FontWeight.bold)),
                            PrimeCareText('118/72 mmHg', style: TextStyle(color: PrimeCareColors.emerald, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const PrimeCareSizedBox(height: 8),
                        PrimeCareRow(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            PrimeCareText('Heart Rate', style: TextStyle(fontWeight: FontWeight.bold)),
                            PrimeCareText('68 BPM', style: TextStyle(color: PrimeCareColors.emerald, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const PrimeCareSizedBox(height: 20),
                        // Simulated embedded chart graph area
                        PrimeCareCard(
                          height: 100,
                          
                          child: const PrimeCareCenter(child: PrimeCareText('Interactive Spline Chart Area', style: TextStyle(color: PrimeCareColors.slate400))),
                        )
                      ],
                    )
                  ),

                  const PrimeCareSizedBox(height: 16),

                  _buildNexusCard(
                    context, 
                    title: 'Emergency Contacts', 
                    icon: Icons.contact_phone_rounded, 
                    color: PrimeCareColors.rose,
                    child: PrimeCareRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimeCareColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            PrimeCareText('Maria Jenkins (Daughter)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            PrimeCareSizedBox(height: 4),
                            PrimeCareText('Primary Power of Attorney', style: TextStyle(color: PrimeCareColors.slate500, fontSize: 13)),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const PrimeCareIcon(Icons.phone, color: PrimeCareColors.rose),
                          style: IconButton.styleFrom(backgroundColor: const Color(0x11E11D48)),
                        )
                      ],
                    )
                  ),
                  
                  const PrimeCareSizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      )
        ),
      ),
    );
  }

  Widget _buildNexusCard(BuildContext context, {required String title, required IconData icon, required Color color, required Widget child}) {
    return PrimeCareCard(
      padding: const EdgeInsets.all(24),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareRow(
            children: [
              PrimeCareCard(
                padding: const EdgeInsets.all(10),
                
                child: PrimeCareIcon(icon, color: color, size: 24),
              ),
              const PrimeCareSizedBox(width: 16),
              PrimeCareText(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: PrimeCareColors.radarDark)),
            ],
          ),
          const PrimeCareSizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}
