import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PswHomeScreen extends StatelessWidget {
  const PswHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('PrimeCare Hub', 
          style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: -0.5)
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF0F172A)),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
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
                // Welcome Card Hero
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0EA5E9), Color(0xFF3B82F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Color(0x330EA5E9), blurRadius: 20, offset: Offset(0, 10))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Welcome Back, First Responder!', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Your next shift begins in 2h 15m. You have 2 unread announcements.', style: TextStyle(color: Colors.white.withAlpha(230), fontSize: 15, height: 1.4)),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Statistics Array
            const Text('Performance Metrics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildStatCard('Weekly Hours', '34.5', Icons.schedule, const Color(0xFF8B5CF6))),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard('Compliance', '94%', Icons.verified_user_outlined, const Color(0xFF10B981))),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard('Surge Active', '1.5x', Icons.bolt, const Color(0xFFF59E0B))),
              ],
            ),
            const SizedBox(height: 32),

            // Quick Link Dynamic Tiles (2x2 Matrix)
            const Text('Quick Access Nodes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            const SizedBox(height: 16),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildQuickLinkTile(context, 'Secure Inbox', Icons.message_rounded, const Color(0xFF3B82F6), () => context.push('/psw/messages')),
                _buildQuickLinkTile(context, 'Daily Timeline', Icons.calendar_view_day_rounded, const Color(0xFF8B5CF6), () => context.push('/psw/daily-timeline')),
                _buildQuickLinkTile(context, 'Training Hub', Icons.school_rounded, const Color(0xFFEC4899), () => context.push('/psw/training')),
                _buildQuickLinkTile(context, 'SOS Trigger', Icons.emergency_rounded, const Color(0xFFE11D48), () {
                  HapticFeedback.heavyImpact();
                  context.push('/psw/live-video-triage/emergency-123');
                }),
                _buildQuickLinkTile(context, 'View Clients', Icons.group_rounded, const Color(0xFF14B8A6), () {
                  HapticFeedback.lightImpact();
                  context.go('/psw/clients');
                }),
              ],
            ),
            const SizedBox(height: 32),

            // Organizational Feed
            const Text('Organizational Feed', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            const SizedBox(height: 16),
            _buildFeedCard('Clinical Safety Update', 'Please review the updated sterile gloving procedures mandated by the Ministry of Health. Mandatory compliance required by Friday.'),
            const SizedBox(height: 16),
            _buildFeedCard('Holiday Pay Multipliers', 'The PrimeCare system will automatically attach 1.5x surge pricing limits to all EVV shifts recorded on statutory holidays.'),
                const SizedBox(height: 64), // Scroll padding for the Glass Shell
              ],
            ),
          ),
        ),
      )
        ),
      ),
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
