import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswEarningsScreen extends StatelessWidget {
  const PswEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: const PrimeCareAppBar(title: 'Earnings Report'),
      body: ResponsiveLayoutManager(
        mobile: _buildMobileLayout(),
        tablet: _buildDesktopLayout(), // Tablet mimics desktop here
        desktop: _buildDesktopLayout(),
      ),
    );
  }

  Widget _buildTotalEarningsCard() {
    return PrimeCareCardContainer(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total Earnings This Period', style: TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 8),
          const Text('\$1,240.50', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(4)),
                child: const Text('+12% vs last week', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildChartMock() {
    return PrimeCareCardContainer(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Earnings Trend', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                final height = 50.0 + (index * 20.0);
                return Container(
                  width: 32,
                  height: height,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E88E5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPayoutHistory() {
    return PrimeCareCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrimeCareSectionHeader(title: 'Recent Payout History', isWhite: true),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(backgroundColor: Colors.blue.shade50, child: const Icon(Icons.account_balance, color: Colors.blue)),
                title: Text('Direct Deposit - Week ${42 - index}'),
                subtitle: const Text('Processed on Friday'),
                trailing: Text('+\$${950 + (index * 45)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
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
        _buildTotalEarningsCard(),
        const SizedBox(height: 16),
        _buildChartMock(),
        const SizedBox(height: 16),
        _buildPayoutHistory(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return ListView(
      padding: const EdgeInsets.all(32.0),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildTotalEarningsCard()),
            const SizedBox(width: 32),
            Expanded(flex: 3, child: _buildChartMock()),
          ],
        ),
        const SizedBox(height: 32),
        _buildPayoutHistory(),
      ],
    );
  }
}
