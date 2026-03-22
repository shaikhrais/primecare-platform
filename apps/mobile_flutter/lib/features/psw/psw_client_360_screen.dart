import 'package:primecare_mobile/l10n/app_localizations.dart';
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
      appBar: PrimeCareAppBar(title: '$clientName - 360°'),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: SingleChildScrollView(
        child: PrimeCareColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Structural Header Block
            PrimeCareContainer(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(24, 24, 24, 40),
              child: PrimeCareColumn(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: PrimeCareColors.slate200,
                    child: PrimeCareText(
                      clientName.substring(0, 1), 
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36, color: PrimeCareColors.radarDark)
                    ),
                  ),
                  SizedBox(height: 16),
                  PrimeCareText(clientName, style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(height: 8),
                  PrimeCareText('Dementia Care Track • Resuscitate (DNR) - No', style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // Drilled Data Modules
            PrimeCarePadding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: PrimeCareColumn(
                children: [
                  _buildNexusCard(
                    context, 
                    title: AppLocalizations.of(context)!.activeCarePlanVault, 
                    icon: Icons.folder_special_rounded, 
                    color: Color(0xFF3B82F6),
                    child: PrimeCareColumn(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PrimeCareText('Valid from: Oct 1, 2025 to Oct 1, 2026', style: TextStyle(color: Color(0xFF475569))),
                        SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: PrimeCareIcon(Icons.picture_as_pdf),
                          label: PrimeCareText(AppLocalizations.of(context)!.viewOfficialDirectivePdf),
                          
                        )
                      ],
                    )
                  ),
                  
                  SizedBox(height: 16),

                  _buildNexusCard(
                    context, 
                    title: AppLocalizations.of(context)!.txt30DayVitalsTrend, 
                    icon: Icons.monitor_heart_rounded, 
                    color: PrimeCareColors.emerald,
                    child: PrimeCareColumn(
                      children: [
                        PrimeCareRow(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PrimeCareText('Blood Pressure', style: TextStyle(fontWeight: FontWeight.bold)),
                            PrimeCareText('118/72 mmHg', style: TextStyle(color: PrimeCareColors.emerald, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 8),
                        PrimeCareRow(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PrimeCareText('Heart Rate', style: TextStyle(fontWeight: FontWeight.bold)),
                            PrimeCareText('68 BPM', style: TextStyle(color: PrimeCareColors.emerald, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Simulated embedded chart graph area
                        PrimeCareCard(
                          height: 100,
                          
                          child: PrimeCareCenter(child: PrimeCareText('Interactive Spline Chart Area', style: TextStyle(color: PrimeCareColors.slate400))),
                        )
                      ],
                    )
                  ),

                  SizedBox(height: 16),

                  _buildNexusCard(
                    context, 
                    title: AppLocalizations.of(context)!.emergencyContacts, 
                    icon: Icons.contact_phone_rounded, 
                    color: PrimeCareColors.rose,
                    child: PrimeCareRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimeCareColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimeCareText('Maria Jenkins (Daughter)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            SizedBox(height: 4),
                            PrimeCareText('Primary Power of Attorney', style: TextStyle(color: PrimeCareColors.slate500, fontSize: 13)),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: PrimeCareIcon(Icons.phone, color: PrimeCareColors.rose),
                          style: IconButton.styleFrom(backgroundColor: Color(0x11E11D48)),
                        )
                      ],
                    )
                  ),
                  
                  SizedBox(height: 40),
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
      padding: EdgeInsets.all(24),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareRow(
            children: [
              PrimeCareCard(
                padding: EdgeInsets.all(10),
                
                child: PrimeCareIcon(icon, color: color, size: 24),
              ),
              SizedBox(width: 16),
              PrimeCareText(title, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: PrimeCareColors.radarDark)),
            ],
          ),
          SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}
