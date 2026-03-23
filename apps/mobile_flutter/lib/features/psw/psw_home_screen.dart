import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/global_top_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../../../core/localization/app_strings.dart';

class PswHomeScreen extends StatelessWidget {
  const PswHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      body: ResponsiveLayoutManager(
        mobile: _buildMobileLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.0),
      child: AnimationLimiter(
        child: PrimeCareColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: AnimationConfiguration.toStaggeredList(
            duration: Duration(milliseconds: 600),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              _buildWelcomeCard(),
              SizedBox(height: 32),
              _buildStatisticsArray(),
              SizedBox(height: 32),
              _buildQuickLinks(context, 2),
              SizedBox(height: 32),
              _buildFeed(),
              SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(40.0),
      child: AnimationLimiter(
        child: PrimeCareRow(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimeCareExpanded(
              flex: 3,
              child: PrimeCareColumn(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: AnimationConfiguration.toStaggeredList(
                  duration: Duration(milliseconds: 600),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: [
                    _buildWelcomeCard(),
                    SizedBox(height: 32),
                    _buildQuickLinks(context, 3), // 3 columns for quick links on wide view
                  ],
                ),
              ),
            ),
            SizedBox(width: 40),
            PrimeCareExpanded(
              flex: 2,
              child: PrimeCareColumn(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: AnimationConfiguration.toStaggeredList(
                  duration: Duration(milliseconds: 600),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: [
                    _buildStatisticsArray(),
                    SizedBox(height: 32),
                    _buildFeed(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return PrimeCareCard(
      padding: EdgeInsets.all(32),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareText('Welcome Back', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          PrimeCareText('Your next shift starts in...', style: TextStyle(color: Colors.white.withAlpha(230), fontSize: 16, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildStatisticsArray() {
    return PrimeCareColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimeCareText('Performance Metrics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
        SizedBox(height: 16),
        PrimeCareRow(
          children: [
            PrimeCareExpanded(child: _buildStatCard('Weekly Hours', '34.5', Icons.schedule, PrimeCareColors.purple)),
            SizedBox(width: 16),
            PrimeCareExpanded(child: _buildStatCard('Compliance', '94%', Icons.verified_user_outlined, PrimeCareColors.emerald)),
            SizedBox(width: 16),
            PrimeCareExpanded(child: _buildStatCard('Surge Active', '1.5x', Icons.bolt, PrimeCareColors.amber)),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickLinks(BuildContext context, int crossAxisCount) {
    return PrimeCareColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimeCareText(AppLocalizations.of(context)!.quickAccessNodes, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
        SizedBox(height: 16),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: [
            _buildQuickLinkTile(context, AppLocalizations.of(context)!.secureInbox, Icons.message_rounded, Color(0xFF3B82F6), () => context.push('/psw/messages')),
            _buildQuickLinkTile(context, AppLocalizations.of(context)!.dailyTimeline, Icons.calendar_view_day_rounded, PrimeCareColors.purple, () => context.push('/psw/daily-timeline')),
            _buildQuickLinkTile(context, AppLocalizations.of(context)!.trainingHub, Icons.school_rounded, Color(0xFFEC4899), () => context.push('/psw/training')),
            _buildQuickLinkTile(context, AppLocalizations.of(context)!.sosTrigger, Icons.emergency_rounded, PrimeCareColors.rose, () {
              HapticFeedback.heavyImpact();
              context.push('/psw/live-video-triage/emergency-123');
            }),
            _buildQuickLinkTile(context, AppLocalizations.of(context)!.viewClients, Icons.group_rounded, Color(0xFF14B8A6), () {
              HapticFeedback.lightImpact();
              context.go('/psw/clients');
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildFeed() {
    return PrimeCareColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimeCareText('Organizational Feed', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
        SizedBox(height: 16),
        _buildFeedCard('Clinical Safety Update', 'Please review the updated sterile gloving procedures mandated by the Ministry of Health. Mandatory compliance required by Friday.'),
        SizedBox(height: 16),
        _buildFeedCard('Holiday Pay Multipliers', 'The PrimeCare system will automatically attach 1.5x surge pricing limits to all EVV shifts recorded on statutory holidays.'),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return PrimeCareCard(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      
      child: PrimeCareColumn(
        children: [
          PrimeCareIcon(icon, color: color, size: 28),
          SizedBox(height: 12),
          PrimeCareText(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
          SizedBox(height: 4),
          PrimeCareText(label, style: TextStyle(fontSize: 12, color: PrimeCareColors.slate500), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildQuickLinkTile(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: PrimeCareCard(
        
        child: PrimeCareStack(
          children: [
            Positioned(
              right: -10,
              top: -10,
              child: PrimeCareIcon(icon, size: 80, color: color.withAlpha(15)),
            ),
            PrimeCarePadding(
              padding: EdgeInsets.all(16.0),
              child: PrimeCareColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimeCareCard(
                    padding: EdgeInsets.all(8),
                    
                    child: PrimeCareIcon(icon, color: color, size: 24),
                  ),
                  Spacer(),
                  PrimeCareText(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: PrimeCareColors.radarDark)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedCard(String title, String desc) {
    return PrimeCareCard(
      padding: EdgeInsets.all(20),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareRow(
            children: [
              PrimeCareCard(
                padding: EdgeInsets.all(8),
                
                child: PrimeCareIcon(Icons.campaign_outlined, color: PrimeCareColors.emerald, size: 20),
              ),
              SizedBox(width: 12),
              PrimeCareExpanded(child: PrimeCareText(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: PrimeCareColors.radarDark))),
            ],
          ),
          SizedBox(height: 12),
          PrimeCareText(desc, style: TextStyle(color: PrimeCareColors.slate500, fontSize: 14, height: 1.5)),
        ],
      ),
    );
  }
}
