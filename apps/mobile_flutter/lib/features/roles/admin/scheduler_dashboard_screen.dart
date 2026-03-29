import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class SchedulerDashboardScreen extends StatelessWidget {
  const SchedulerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.5),
      appBar: const PrimeCareAppBar(title: 'Dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Scheduler / Coordinator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Row(
                     children: [
                        const Text('Franchise:', style: TextStyle(fontSize: 12, color: Colors.black54)),
                        const SizedBox(width: 8),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: Row(children: const [Text('\'Aurora Healthcare\'', style: TextStyle(fontSize: 12)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 16)])),
                        const SizedBox(width: 16),
                        Stack(
                           children: [
                              const Icon(Icons.notifications_none, color: Colors.grey, size: 20),
                              Positioned(right: 0, top: 0, child: Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle))),
                           ]
                        ),
                        const SizedBox(width: 16),
                        Row(
                           children: [
                              const CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5')),
                              const SizedBox(width: 8),
                              Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: const [
                                    Text('Samantha Reed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                    Text('Coordinator', style: TextStyle(color: Colors.black54, fontSize: 11)),
                                 ]
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
                           ]
                        )
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            Row(
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                  Expanded(flex: 2, child: _buildTodaysSummaryCard()),
                  const SizedBox(width: 16),
                  Expanded(flex: 1, child: _buildKeyActivityCard()),
               ]
            ).withHeight(180),
            const SizedBox(height: 24),
            Row(
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                  Expanded(flex: 3, child: _buildScheduleBlock()),
                  const SizedBox(width: 16),
                  Expanded(flex: 1, child: Column(children: [Expanded(flex: 2, child: _buildUpcomingScheduleBlock()), const SizedBox(height: 16), Expanded(flex: 1, child: _buildFacilityOverviewCard())])),
               ]
            ).withHeight(640),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTodaysSummaryCard() {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const Text('Today\'s Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
           const SizedBox(height: 16),
           Expanded(
              child: PrimeCareCard(
                 child: Row(
                    children: [
                       Expanded(
                          flex: 1,
                          child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                                _buildSummaryItem('Total Appointments', '38', 0.9, Colors.grey.shade300),
                                _buildSummaryItem('Cancellations', '2', 0.1, const Color(0xFF0F4C81)),
                             ]
                          )
                       ),
                       Container(width: 1, color: Colors.grey.shade200, margin: const EdgeInsets.symmetric(horizontal: 24)),
                       Expanded(
                          flex: 1,
                          child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                                _buildSummaryItem('Pending', '6', 0.2, Colors.grey.shade300),
                                _buildSummaryItem('Clinician Availability', '89%', 0.89, Colors.teal.shade500),
                             ]
                          )
                       ),
                    ]
                 )
              )
           )
        ]
     );
  }

  Widget _buildSummaryItem(String label, String val, double progress, Color fill) {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(label, style: const TextStyle(color: Colors.black87, fontSize: 12)),
           const SizedBox(height: 8),
           Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
           const SizedBox(height: 12),
           Container(
              height: 4, decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(2)), alignment: Alignment.centerLeft,
              child: FractionallySizedBox(widthFactor: progress, child: Container(decoration: BoxDecoration(color: fill, borderRadius: BorderRadius.circular(2)))),
           )
        ]
     );
  }

  Widget _buildKeyActivityCard() {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const Text('Key Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
           const SizedBox(height: 16),
           Expanded(
              child: PrimeCareCard(
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       const Text('Appointment Trends this week', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                       const SizedBox(height: 16),
                       Expanded(
                          child: Stack(
                             children: [
                                Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: const [
                                      _ChartLine('120'), _ChartLine('90'), _ChartLine('60'), _ChartLine('30'), _ChartLine('0'),
                                   ]
                                ),
                                Positioned.fill(
                                   child: Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                         crossAxisAlignment: CrossAxisAlignment.end,
                                         children: [
                                            _buildDualBarCol('Mon', 0.5, 0.25),
                                            _buildDualBarCol('Tue', 0.65, 0.35),
                                            _buildDualBarCol('Wed', 0.85, 0.65),
                                            _buildDualBarCol('Thu', 0.6, 0.55),
                                            _buildDualBarCol('Fri', 0.9, 1.0),
                                            _buildDualBarCol('Sat', 0.75, 0.55),
                                         ]
                                      )
                                   )
                                )
                             ]
                          )
                       )
                    ]
                 )
              )
           )
        ]
     );
  }

  Widget _buildDualBarCol(String lbl, double h1, double h2) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 Container(width: 8, height: 100 * h1, decoration: const BoxDecoration(color: Color(0xFF0F4C81), borderRadius: BorderRadius.vertical(top: Radius.circular(2)))),
                 const SizedBox(width: 4),
                 Container(width: 8, height: 100 * h2, decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: const BorderRadius.vertical(top: Radius.circular(2)))),
              ]
           ),
           const SizedBox(height: 8),
           Text(lbl, style: const TextStyle(fontSize: 10, color: Colors.black87)),
        ]
     );
  }

  Widget _buildScheduleBlock() {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 const Text('Schedule', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                 Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Row(children: const [Icon(Icons.filter_list, size: 14), SizedBox(width: 4), Text('Filter views', style: TextStyle(fontSize: 12))])),
              ]
           ),
           const SizedBox(height: 16),
           Row(
              children: [
                 Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)),
                    child: Row(children: const [Icon(Icons.chevron_left, size: 16), SizedBox(width: 12), Text('November 14, 2023', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), SizedBox(width: 12), Icon(Icons.chevron_right, size: 16)])
                 ),
                 const SizedBox(width: 24),
                 _buildFilterDropdown('Location', 'West Seattle'),
                 const SizedBox(width: 16),
                 _buildFilterDropdown('Specialist', 'Dr. Chen'),
                 const SizedBox(width: 16),
                 _buildFilterDropdown('Status', 'Confirmed'),
              ]
           ),
           const SizedBox(height: 24),
           Expanded(
              child: PrimeCareCard(
                 child: PrimeCareDataTable<Map<String, dynamic>>(
                    columns: const ['Time', 'Patient', 'Appointment Type', 'Clinician', 'Location', 'Status'],
                    data: const [
                       {'time': '08:00 AM', 'pn': 'Samantha Reed', 'id': 'ID- 82500', 'w': 1, 'type': 'Wellness Check', 'doc': 'Dr. M. Chen', 'loc': 'Aurora West', 'stat': 'Confirmed'},
                       {'time': '08:00 AM', 'pn': 'Anra Smith', 'id': 'ID- S2358', 'w': 2, 'type': 'Wellness Check', 'doc': 'Dr. M. Chen', 'loc': 'Aurora West', 'stat': 'Pending'},
                       {'time': '08:00 AM', 'pn': 'Rober Mantin', 'id': 'ID- S2550', 'w': 3, 'type': 'Wellness Check', 'doc': 'Dr. M. Chen', 'loc': 'Aurora West', 'stat': 'Rescheduled'},
                       {'time': '08:30 AM', 'pn': 'Ronm Smith', 'id': 'ID- S2550', 'w': 4, 'type': 'Follow-up', 'doc': 'Dr. M. Chen', 'loc': 'Aurora West', 'stat': 'Confirmed'},
                       {'time': '08:00 AM', 'pn': 'Remn Smith', 'id': 'ID- 82548', 'w': 5, 'type': 'Follow-up', 'doc': 'Dr. M. Chen', 'loc': 'Aurora West', 'stat': 'Rescheduled'},
                       {'time': '08:30 AM', 'pn': 'Bourn Smith', 'id': 'ID- 52550', 'w': 6, 'type': 'Wellness Check', 'doc': 'Dr. M. Chen', 'loc': 'Aurora West', 'stat': 'Canceled'},
                       {'time': '08:00 AM', 'pn': 'Rober Martih', 'id': 'ID- 82559', 'w': 7, 'type': 'Wellness Check', 'doc': 'Dr. M. Chen', 'loc': 'Aurora West', 'stat': 'Canceled'},
                       {'time': '08:30 AM', 'pn': 'Kaan Marin', 'id': 'ID- 83558', 'w': 8, 'type': 'Wellness Check', 'doc': 'Dr. M. Chen', 'loc': 'Aurora West', 'stat': 'Pending'},
                       {'time': '08:00 AM', 'pn': 'Samantha Reed', 'id': 'ID- 82550', 'w': 1, 'type': 'Wellness Check', 'doc': 'Dr. M. Chen', 'loc': 'Aurora West', 'stat': 'Confirmed'},
                       {'time': '10:00 AM', 'pn': 'Rava Marth', 'id': 'ID- 82548', 'w': 9, 'type': 'Wellness Check', 'doc': 'Dr. M. Chen', 'loc': 'Aurora West', 'stat': 'Pending'},
                       {'time': '08:00 AM', 'pn': 'Rotan Mortih', 'id': 'ID- 82558', 'w': 10, 'type': 'Follow-up', 'doc': 'Dr. M. Chen', 'loc': 'Aurora West', 'stat': 'Confirmed'},
                       {'time': '12:00 AM', 'pn': 'Kera Miotin', 'id': 'ID- 82530', 'w': 11, 'type': 'Wellness Check', 'doc': 'Dr. M. Chen', 'loc': 'Aurora West', 'stat': 'Confirmed'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['time'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                       DataCell(Row(children: [CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=${data['w']}')), const SizedBox(width: 8), Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(data['pn'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), Text(data['id'], style: const TextStyle(color: Colors.black54, fontSize: 9))])])),
                       DataCell(Text(data['type'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                       DataCell(Text(data['doc'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                       DataCell(Text(data['loc'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                       DataCell(_buildStatusPill(data['stat'])),
                    ],
                 )
              )
           )
        ]
     );
  }

  Widget _buildFilterDropdown(String label, String val) {
     return Expanded(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
              const SizedBox(height: 8),
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(val, style: const TextStyle(fontSize: 12)), const Icon(Icons.keyboard_arrow_down, size: 16)])),
           ]
        )
     );
  }

  Widget _buildStatusPill(String stat) {
     Color bg; Color text;
     if (stat == 'Confirmed') { bg = Colors.teal.shade50; text = Colors.teal.shade700; }
     else if (stat == 'Pending') { bg = Colors.amber.shade50; text = Colors.amber.shade800; }
     else if (stat == 'Rescheduled') { bg = Colors.orange.shade50; text = Colors.orange.shade800; }
     else { bg = Colors.red.shade50; text = Colors.red.shade800; }
     
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Text(stat, style: TextStyle(color: text, fontWeight: FontWeight.bold, fontSize: 10))
     );
  }

  Widget _buildUpcomingScheduleBlock() {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const Text('Upcoming Schedule', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
           const SizedBox(height: 16),
           Expanded(
              child: PrimeCareCard(
                 child: Column(
                    children: [
                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('List view', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Icon(Icons.more_horiz, color: Colors.grey)]),
                       const SizedBox(height: 16),
                       Expanded(
                          child: ListView(
                             children: [
                                _buildUpcomingCard('Samantha Reed', 1, 'Confirmed', '14 Nov 14, 2023'),
                                const SizedBox(height: 12),
                                _buildUpcomingCard('Boon Smith', 2, 'Confirmed', '14 Nov 13, 2023'),
                                const SizedBox(height: 12),
                                _buildUpcomingCard('Rober Marith', 3, 'Cantirmed', '14 Nov 13, 2023'), // matching typo in design
                                const SizedBox(height: 12),
                                _buildUpcomingCard('Kera Martin', 4, null, null),
                             ]
                          )
                       )
                    ]
                 )
              )
           )
        ]
     );
  }

  Widget _buildUpcomingCard(String pn, int w, String? stat, String? date) {
     return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0,2))]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Row(
                       children: [
                          CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=$w')),
                          const SizedBox(width: 8),
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(pn, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), const Text('Coordinator', style: TextStyle(color: Colors.black54, fontSize: 9))]),
                       ]
                    ),
                    const Icon(Icons.more_vert, color: Colors.grey, size: 16),
                 ]
              ),
              if (stat != null) const SizedBox(height: 12),
              if (stat != null) Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Row(children: [const Text('Follow-up ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: stat == 'Confirmed' ? Colors.teal.shade50 : Colors.orange.shade50, borderRadius: BorderRadius.circular(8)), child: Text(stat, style: TextStyle(color: stat == 'Confirmed' ? Colors.teal.shade700 : Colors.orange.shade800, fontWeight: FontWeight.bold, fontSize: 9)))]),
                 ]
              ),
              if (date != null) const SizedBox(height: 4),
              if (date != null) Text(date, style: const TextStyle(color: Colors.black54, fontSize: 10)),
           ]
        )
     );
  }

  Widget _buildFacilityOverviewCard() {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const Text('Facility Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
           const SizedBox(height: 16),
           Expanded(
              child: Stack(
                 children: [
                    Container(decoration: BoxDecoration(color: Colors.blueGrey.shade100, image: const DecorationImage(image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Map_of_Manhattan.png/800px-Map_of_Manhattan.png'), opacity: 0.15, fit: BoxFit.cover), borderRadius: BorderRadius.circular(8))),
                    const _CardMapPin(30, 20, 'West Seattle', true),
                    const _CardMapPin(80, 50, 'Clinic', true),
                 ]
              )
           )
        ]
     );
  }
}

class _CardMapPin extends StatelessWidget {
   final double t, l;
   final String loc;
   final bool isOk;
   const _CardMapPin(this.t, this.l, this.loc, this.isOk);
   
   @override
   Widget build(BuildContext context) {
      return Positioned(
         top: t, left: l,
         child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)]),
            child: Row(
               children: [
                  Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle), child: const Icon(Icons.location_on, color: Colors.white, size: 8)),
                  const SizedBox(width: 8),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(loc, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10)), Row(children: [const Text('Status ', style: TextStyle(color: Colors.black54, fontSize: 9)), Icon(Icons.diamond, color: isOk ? Colors.teal : Colors.red, size: 8), const Text(' Status', style: TextStyle(color: Colors.teal, fontSize: 9))])]),
               ]
            )
         )
      );
   }
}

class _ChartLine extends StatelessWidget {
   final String lbl;
   const _ChartLine(this.lbl);
   @override
   Widget build(BuildContext context) {
      return Row(
         children: [
            SizedBox(width: 24, child: Text(lbl, style: const TextStyle(fontSize: 10, color: Colors.black54))),
            Expanded(child: Divider(color: Colors.grey.shade300, height: 1)),
         ]
      );
   }
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
