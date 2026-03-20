import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../shared/layouts/responsive_layout_manager.dart';
import '../../../core/localization/app_strings.dart';

class PswHomeScreen extends StatelessWidget {
  const PswHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(AppStrings.appName, 
          style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: -0.5)
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF0F172A)),
            onPressed: () {},
          )
        ],
      ),
      body: ResponsiveLayoutManager(
        mobile: _buildMobileLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: AnimationLimiter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 600),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              _buildWelcomeCard(),
              const SizedBox(height: 32),
              _buildStatisticsArray(),
              const SizedBox(height: 32),
              _buildQuickLinks(context, 2),
              const SizedBox(height: 32),
              _buildFeed(),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40.0),
      child: AnimationLimiter(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 600),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: [
                    _buildWelcomeCard(),
                    const SizedBox(height: 32),
                    _buildQuickLinks(context, 3), // 3 columns for quick links on wide view
                  ],
                ),
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 600),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: [
                    _buildStatisticsArray(),
                    const SizedBox(height: 32),
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
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0EA5E9), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Color(0x330EA5E9), blurRadius: 20, offset: Offset(0, 10))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(AppStrings.welcomeBack, style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(AppStrings.nextShiftAnnouncement, style: TextStyle(color: Colors.white.withAlpha(230), fontSize: 16, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildStatisticsArray() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppStrings.performanceMetrics, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildStatCard(AppStrings.weeklyHoursLabel, '34.5', Icons.schedule, const Color(0xFF8B5CF6))),
            const SizedBox(width: 16),
            Expanded(child: _buildStatCard(AppStrings.complianceLabel, '94%', Icons.verified_user_outlined, const Color(0xFF10B981))),
            const SizedBox(width: 16),
            Expanded(child: _buildStatCard(AppStrings.surgeActiveLabel, '1.5x', Icons.bolt, const Color(0xFFF59E0B))),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickLinks(BuildContext context, int crossAxisCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppStrings.quickAccessNodes, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
        const SizedBox(height: 16),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: [
            _buildQuickLinkTile(context, AppStrings.secureInbox, Icons.message_rounded, const Color(0xFF3B82F6), () => context.push('/psw/messages')),
            _buildQuickLinkTile(context, AppStrings.dailyTimeline, Icons.calendar_view_day_rounded, const Color(0xFF8B5CF6), () => context.push('/psw/daily-timeline')),
            _buildQuickLinkTile(context, AppStrings.trainingHub, Icons.school_rounded, const Color(0xFFEC4899), () => context.push('/psw/training')),
            _buildQuickLinkTile(context, AppStrings.sosTrigger, Icons.emergency_rounded, const Color(0xFFE11D48), () {
              HapticFeedback.heavyImpact();
              context.push('/psw/live-video-triage/emergency-123');
            }),
            _buildQuickLinkTile(context, AppStrings.viewClients, Icons.group_rounded, const Color(0xFF14B8A6), () {
              HapticFeedback.lightImpact();
              context.go('/psw/clients');
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildFeed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppStrings.organizationalFeed, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
        const SizedBox(height: 16),
        _buildFeedCard('Clinical Safety Update', 'Please review the updated sterile gloving procedures mandated by the Ministry of Health. Mandatory compliance required by Friday.'),
        const SizedBox(height: 16),
        _buildFeedCard('Holiday Pay Multipliers', 'The PrimeCare system will automatically attach 1.5x surge pricing limits to all EVV shifts recorded on statutory holidays.'),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)), textAlign: TextAlign.center),
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 10, offset: Offset(0, 4))],
          border: Border.all(color: color.withAlpha(30), width: 1.5),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -10,
              top: -10,
              child: Icon(icon, size: 80, color: color.withAlpha(15)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: color.withAlpha(20), borderRadius: BorderRadius.circular(10)),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  const Spacer(),
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedCard(String title, String desc) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 10, offset: Offset(0, 4))],
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFF10B981).withAlpha(20), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.campaign_outlined, color: Color(0xFF10B981), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A)))),
            ],
          ),
          const SizedBox(height: 12),
          Text(desc, style: const TextStyle(color: Color(0xFF64748B), fontSize: 14, height: 1.5)),
        ],
      ),
    );
  }
}
