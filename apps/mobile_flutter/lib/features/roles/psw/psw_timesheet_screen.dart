import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswTimesheetScreen extends StatelessWidget {
  const PswTimesheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: const PrimeCareAppBar(title: 'Timesheet Dashboard'),
      body: ResponsiveLayoutManager(
        mobile: _buildMobileLayout(),
        tablet: _buildTabletLayout(),
        desktop: _buildDesktopLayout(),
      ),
    );
  }

  Widget _buildTopMetricBar(bool isDesktop) {
    return PrimeCareCardContainer(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMetric('32 hrs', 'Total Hours Worked', isDesktop),
          if (isDesktop) _buildMetric('4', 'Shifts Completed', isDesktop),
          if (isDesktop) _buildMetric('2', 'Upcoming Shifts', isDesktop),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.timer),
            label: const Text('Clock In'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E88E5),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMetric(String value, String label, bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: TextStyle(fontSize: isDesktop ? 32 : 24, fontWeight: FontWeight.bold, color: const Color(0xFF1E3A8A))),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildCalendarCard() {
    return PrimeCareCardContainer(
      child: Column(
        children: [
          const PrimeCareSectionHeaderWhite(title: 'Weekly Calendar View'),
          Container(
            height: 300,
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: 7,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: index == 2 ? const Color(0xFF1E88E5).withOpacity(0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Center(
                    child: Text('Day ${index + 1}', style: TextStyle(color: index == 2 ? const Color(0xFF1E88E5) : Colors.black87)),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildShiftList() {
    return PrimeCareCardContainer(
      child: Column(
        children: [
          const PrimeCareSectionHeaderWhite(title: 'Completed Shifts'),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(backgroundColor: Colors.green.shade100, child: const Icon(Icons.check, color: Colors.green)),
                title: const Text('John Doe - Personal Care'),
                subtitle: const Text('09:00 AM - 11:00 AM • 2 hrs'),
                trailing: const Icon(Icons.chevron_right),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildTopMetricBar(false),
        const SizedBox(height: 16),
        _buildCalendarCard(),
        const SizedBox(height: 16),
        _buildShiftList(),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        _buildTopMetricBar(true),
        const SizedBox(height: 24),
        _buildCalendarCard(),
        const SizedBox(height: 24),
        _buildShiftList(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return ListView(
      padding: const EdgeInsets.all(32.0),
      children: [
        _buildTopMetricBar(true),
        const SizedBox(height: 32),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildCalendarCard()),
            const SizedBox(width: 32),
            Expanded(flex: 3, child: _buildShiftList()),
          ],
        )
      ],
    );
  }
}

// Ensure PrimeCareSectionHeaderWhite exists or alias it
class PrimeCareSectionHeaderWhite extends StatelessWidget {
  final String title;
  const PrimeCareSectionHeaderWhite({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return PrimeCareSectionHeader(title: title, isWhite: true);
  }
}
