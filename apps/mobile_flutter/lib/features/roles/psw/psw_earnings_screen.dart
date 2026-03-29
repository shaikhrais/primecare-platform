import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:fl_chart/fl_chart.dart';

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
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 1200,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.blueAccent,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '\$${rod.toY.round()}',
                        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12);
                        String text;
                        switch (value.toInt()) {
                          case 0: text = 'Mon'; break;
                          case 1: text = 'Tue'; break;
                          case 2: text = 'Wed'; break;
                          case 3: text = 'Thu'; break;
                          case 4: text = 'Fri'; break;
                          case 5: text = 'Sat'; break;
                          case 6: text = 'Sun'; break;
                          default: text = ''; break;
                        }
                        return SideTitleWidget(axisSide: meta.axisSide, child: Text(text, style: style));
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                barGroups: [
                  BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 600, color: const Color(0xFF1E88E5), width: 16, borderRadius: BorderRadius.circular(4))]),
                  BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 850, color: const Color(0xFF1E88E5), width: 16, borderRadius: BorderRadius.circular(4))]),
                  BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 700, color: const Color(0xFF1E88E5), width: 16, borderRadius: BorderRadius.circular(4))]),
                  BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 1100, color: const Color(0xFF1E88E5), width: 16, borderRadius: BorderRadius.circular(4))]),
                  BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 900, color: const Color(0xFF1E88E5), width: 16, borderRadius: BorderRadius.circular(4))]),
                  BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 400, color: const Color(0xFF1E88E5), width: 16, borderRadius: BorderRadius.circular(4))]),
                  BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 500, color: const Color(0xFF1E88E5), width: 16, borderRadius: BorderRadius.circular(4))]),
                ],
              ),
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
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              final double amount = 950.0 + (index * 45);
              return ExpansionTile(
                leading: CircleAvatar(backgroundColor: Colors.blue.shade50, child: const Icon(Icons.account_balance, color: Colors.blue)),
                title: Text('Direct Deposit - Week ${42 - index}', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Processed on Friday'),
                trailing: Text('+\$${amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: Colors.grey.shade50,
                    child: Column(
                      children: [
                        _buildBreakdownRow('Shift Base Pay', '\$${(amount * 0.8).toStringAsFixed(2)}'),
                        _buildBreakdownRow('Mileage / Travel', '\$${(amount * 0.15).toStringAsFixed(2)}'),
                        _buildBreakdownRow('Weekend Premium', '\$${(amount * 0.05).toStringAsFixed(2)}'),
                      ],
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1E3A8A))),
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
