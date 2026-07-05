import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:web/web.dart' as web;

class SuccessProfileActionBarSection extends ConsumerWidget {
  const SuccessProfileActionBarSection({super.key});

  String getPortalUrlForRole(String role) {
    final r = role.toLowerCase().replaceAll(' ', '_').replaceAll('/', '_');
    
    if (r.contains('ceo') || r.contains('cfo') || r.contains('ciso') || 
        r.contains('coo') || r.contains('cto') || r.contains('legal') || 
        r.contains('shareholder') || r.contains('compliance') || 
        r.contains('training_director') || r.contains('finance_director') || 
        r.contains('volunteer_coordinator') || r.contains('bus_dev') || 
        r.contains('marketing') || r.contains('cx_director') || r.contains('hr_director')) {
      return 'https://primecare-corporate.pages.dev';
    }
    
    if (r.contains('regional_manager') || r.contains('franchise_sales') || 
        r.contains('partnership') || r.contains('territory_expansion') || 
        r.contains('general_manager') || r.contains('gm') || r.contains('regional_bdm')) {
      return 'https://primecare-business-development.pages.dev';
    }
    
    if (r.contains('owner') || r.contains('ops_manager') || r.contains('scheduler') || 
        r.contains('coordinator') || r.contains('billing_admin') || r.contains('hr_hiring') || r.contains('hr_manager')) {
      return 'https://primecare-franchise.pages.dev';
    }
    
    if (r.contains('customer_support') || r.contains('premium_concierge') || r.contains('vip_manager') || r.contains('qa_specialist')) {
      return 'https://primecare-support.pages.dev';
    }
    
    if (r.contains('local_marketing') || r.contains('community_outreach')) {
      return 'https://primecare-marketing.pages.dev';
    }
    
    if (r.contains('clinical_director') || r == 'psw' || r == 'chiropractor' || 
        r == 'physio' || r == 'physiotherapist' || r == 'rmt' || 
        r == 'social_worker' || r == 'therapist' || r == 'caregiver' || 
        r == 'rn' || r == 'rpn' || r == 'lpn' || r == 'np' || r == 'physician' || r == 'cns' || r == 'pediatric' || r == 'hsw') {
      return 'https://primecare-clinic.pages.dev';
    }
    
    if (r == 'client' || r.contains('family') || r == 'patient' || r == 'portal') {
      return 'https://primecare-client.pages.dev';
    }
    
    if (r.contains('system_verification') || r.contains('infrastructure') || 
        r.contains('dynamic') || r.contains('training') || r == 'admin' || r == 'employee' || r == 'volunteer' || r == 'governance') {
      return 'https://primecare-governance.pages.dev';
    }
    
    return 'https://primecare-auth.pages.dev';
  }

  bool _hasAccessToPortal(String role, String portalUrl) {
    final userPortal = getPortalUrlForRole(role);
    final r = role.toLowerCase();
    
    // Super admin / governance roles get access to everything for cross-system debugging
    if (r == 'admin' || r == 'governance' || r == 'system_verification' || r == 'ciso') {
      return true;
    }
    
    return userPortal == portalUrl;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final theme = context.theme;

    final portalApps = [
      {
        'name': 'Corporate Headquarters',
        'url': 'https://primecare-corporate.pages.dev',
        'icon': LucideIcons.building,
        'description': 'Executive leadership, financial planning, HR, legal, compliance, and training management.',
        'color': const Color(0xFF60A5FA), // Blue
      },
      {
        'name': 'Business Development',
        'url': 'https://primecare-business-development.pages.dev',
        'icon': LucideIcons.trendingUp,
        'description': 'Partnerships, regional growth, franchise sales, market research, and expansion planning.',
        'color': const Color(0xFF818CF8), // Indigo
      },
      {
        'name': 'Franchise Operations',
        'url': 'https://primecare-franchise.pages.dev',
        'icon': LucideIcons.briefcase,
        'description': 'Local franchise ownership, office operations, local hiring, and client billing.',
        'color': const Color(0xFF22D3EE), // Cyan
      },
      {
        'name': 'Customer Support',
        'url': 'https://primecare-support.pages.dev',
        'icon': LucideIcons.phone,
        'description': 'VIP concierge care coordination, premium client support, and ticket management.',
        'color': const Color(0xFFFBBF24), // Amber
      },
      {
        'name': 'Marketing & Outreach',
        'url': 'https://primecare-marketing.pages.dev',
        'icon': LucideIcons.megaphone,
        'description': 'Local marketing campaigns, community events, partnerships, and brand assets.',
        'color': const Color(0xFFC084FC), // Purple
      },
      {
        'name': 'Clinical Intelligence',
        'url': 'https://primecare-clinic.pages.dev',
        'icon': LucideIcons.stethoscope,
        'description': 'Clinical director oversight, caregiver schedules, client vitals, and treatment plans.',
        'color': const Color(0xFF34D399), // Emerald/Green
      },
      {
        'name': 'Client Care Portal',
        'url': 'https://primecare-client.pages.dev',
        'icon': LucideIcons.heart,
        'description': 'Client appointments, loved one schedules, care team updates, and family billing.',
        'color': const Color(0xFFF472B6), // Pink/Rose
      },
      {
        'name': 'Platform Governance',
        'url': 'https://primecare-governance.pages.dev',
        'icon': LucideIcons.shieldCheck,
        'description': 'System integrity verification, infrastructure auditing, and dynamic blueprints.',
        'color': const Color(0xFF2DD4BF), // Teal
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        childAspectRatio: 1.35,
      ),
      itemCount: portalApps.length,
      itemBuilder: (context, index) {
        final app = portalApps[index];
        final name = app['name'] as String;
        final url = app['url'] as String;
        final icon = app['icon'] as IconData;
        final description = app['description'] as String;
        final accentColor = app['color'] as Color;
        
        final isAuthorized = _hasAccessToPortal(authState.role ?? 'Guest', url);

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: isAuthorized ? 1.0 : 0.45,
          child: Container(
            decoration: BoxDecoration(
              color: isAuthorized 
                  ? Colors.white.withValues(alpha: 0.03)
                  : Colors.white.withValues(alpha: 0.01),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isAuthorized 
                    ? accentColor.withValues(alpha: 0.25)
                    : Colors.white.withValues(alpha: 0.05),
                width: 1.5,
              ),
              boxShadow: isAuthorized ? [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.05),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                )
              ] : null,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: isAuthorized ? () {
                  final dashboardRoute = AuthNotifier.getDashboardRouteForRole(authState.role ?? '');
                  final delimiter = url.contains('?') ? '&' : '?';
                  final redirectUrl = '$url/auth/callback${delimiter}route=${Uri.encodeComponent(dashboardRoute)}&token=${authState.token ?? ''}&role=${Uri.encodeComponent(authState.role ?? '')}&userId=${authState.userId ?? ''}';
                  if (kIsWeb) {
                    web.window.location.href = redirectUrl;
                  }
                } : null,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: accentColor.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Icon(
                              icon,
                              color: accentColor,
                              size: 24,
                            ),
                          ),
                          if (!isAuthorized)
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                LucideIcons.lock,
                                color: Colors.white54,
                                size: 14,
                              ),
                            )
                          else
                            const Icon(
                              LucideIcons.arrowRight,
                              color: Colors.white54,
                              size: 18,
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        name,
                        style: theme.typography.h3.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          description,
                          style: theme.typography.bodyMedium.copyWith(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 12,
                            height: 1.4,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
