import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/api_client.dart';

final familyPortalMetricsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  return await apiClient.get('/v1/client/family/metrics');
});

class FamilyMemberDashboardScreen extends ConsumerWidget {
  const FamilyMemberDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(familyPortalMetricsProvider);

    return PageTemplate(
      title: 'Family Care Dashboard',
      subtitle: 'Overseeing Robert S. | Care Plan ID #8841-A',
      kpiCards: null, // Custom flex grid for Family layout
      children: [
        metricsAsync.when(
          data: (data) => _buildFamilyGrid(context, data),
          loading: () => const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator())),
          error: (err, stack) => Center(child: Text('Error loading portal: $err', style: const TextStyle(color: Colors.red))),
        ),
      ],
    );
  }

  Widget _buildFamilyGrid(BuildContext context, Map<String, dynamic> data) {
    // 900px breakpoint for Desktop Grid mapping
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Row: Live GPS/Status, Today's Care Journal
        Flex(
          direction: isDesktop ? Axis.horizontal : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: isDesktop ? 2 : 0, child: _buildLiveStatusTracker()),
            SizedBox(width: isDesktop ? 16 : 0, height: isDesktop ? 0 : 16),
            Expanded(flex: isDesktop ? 3 : 0, child: _buildCareJournalFeed()),
          ],
        ),
        const SizedBox(height: 16),
        // Bottom Row: Direct Message Care Team, Account Balance
        Flex(
          direction: isDesktop ? Axis.horizontal : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: _buildDirectMessageCard()),
            SizedBox(width: isDesktop ? 16 : 0, height: isDesktop ? 0 : 16),
            Expanded(flex: 2, child: _buildAccountBalanceSnapshot()),
          ],
        ),
      ],
    );
  }

  Widget _buildLiveStatusTracker() {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 const Text('Live Care Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                 Row(
                   children: [
                     Container(
                       width: 8, height: 8,
                       decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                     ),
                     const SizedBox(width: 6),
                     const Text('Active Shift', style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.bold)),
                   ],
                 ),
              ],
           ),
           const SizedBox(height: 16),
           Container(
             padding: const EdgeInsets.all(16),
             decoration: BoxDecoration(
               color: Colors.blueGrey.shade50,
               borderRadius: BorderRadius.circular(12),
               border: Border.all(color: Colors.blueGrey.shade100)
             ),
             child: Row(
                children: [
                   const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=32'), // Mock placeholder
                   ),
                   const SizedBox(width: 16),
                   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                         Text('Sarah Jenkins (PSW)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                         Text('Clocked In @ 1:02 PM', style: TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                   )
                ],
             ),
           ),
           const SizedBox(height: 24),
           // Vertical Timeline Mock
           _timelineNode('Arrived at Location', '1:02 PM', isCompleted: true),
           const _TimelineTick(),
           _timelineNode('Medication Administered', '2:15 PM', isCompleted: true),
           const _TimelineTick(),
           _timelineNode('Physical Mobility Exercises', 'Pending', isCompleted: false),
           const _TimelineTick(),
           _timelineNode('Shift Concludes', '3:30 PM', isCompleted: false),
        ],
      ),
    );
  }
  
  Widget _timelineNode(String action, String time, {required bool isCompleted}) {
      return Row(
         children: [
            Icon(isCompleted ? Icons.check_circle : Icons.circle_outlined, color: isCompleted ? Colors.teal : Colors.grey, size: 20),
            const SizedBox(width: 12),
            Expanded(
               child: Text(action, style: TextStyle(fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal, color: isCompleted ? Colors.black87 : Colors.grey)),
            ),
            Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
         ],
      );
  }

  Widget _buildCareJournalFeed() {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Today\'s Care Journal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Updates and photos directly from the caregiver.', style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 16),
          SizedBox(
             height: 250,
             child: ListView(
                children: [
                   _journalEntry('We went for a walk around the block! It was a beautiful day and Robert felt very energetic.', '25 mins ago', hasImage: true),
                   const Divider(height: 32),
                   _journalEntry('Blood pressure check: 118/79. Feeling good.', '1 hr ago', hasImage: false),
                   const Divider(height: 32),
                   _journalEntry('Arrived safely, prepared a light lunch.', '2 hrs ago', hasImage: false),
                ],
             ),
          )
        ],
      )
    );
  }

  Widget _journalEntry(String text, String time, {required bool hasImage}) {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 const Text('Sarah Jenkins', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                 Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
           ),
           const SizedBox(height: 8),
           Text(text, style: const TextStyle(fontSize: 13, height: 1.4)),
           if (hasImage) ...[
              const SizedBox(height: 12),
              Container(
                 height: 120,
                 width: double.infinity,
                 decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade200,
                    image: const DecorationImage(
                       image: NetworkImage('https://images.unsplash.com/photo-1543333995-a78aea2eee50?auto=format&fit=crop&q=80&w=400'),
                       fit: BoxFit.cover,
                    )
                 ),
              )
           ]
        ],
     );
  }

  Widget _buildDirectMessageCard() {
    return PrimeCareCard(
      child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            const Text('Coordination Team Messages', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
               padding: const EdgeInsets.all(12),
               decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(8)),
               child: Row(
                  children: const [
                     Icon(Icons.support_agent, color: Colors.teal),
                     SizedBox(width: 12),
                     Expanded(child: Text('Your primary case manager is Amanda T. Expect responses within 2 hours.', style: TextStyle(fontSize: 12, color: Colors.teal))),
                  ],
               ),
            ),
            const SizedBox(height: 16),
            const TextField(
               decoration: InputDecoration(
                  hintText: 'Type your message to the agency here...',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
               ),
               maxLines: 3,
            ),
            const SizedBox(height: 12),
            Align(
               alignment: Alignment.centerRight,
               child: ElevatedButton.icon(
                  onPressed: (){},
                  icon: const Icon(Icons.send, size: 16),
                  label: const Text('Send Message'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
               ),
            )
         ],
      )
    );
  }

  Widget _buildAccountBalanceSnapshot() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
              const Text('Family Co-Pay Balance', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey)),
              const SizedBox(height: 8),
              const Text('\$150.00', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.redAccent)),
              const SizedBox(height: 4),
              const Text('Due by Jun 30, 2024', style: TextStyle(fontSize: 13, color: Colors.grey)),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                 onPressed: (){},
                 icon: const Icon(Icons.payment),
                 label: const Text('Make a Payment'),
                 style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 45)),
              ),
              const SizedBox(height: 12),
              TextButton(
                 onPressed: (){}, 
                 child: const Center(child: Text('View Full Receipt History', style: TextStyle(color: Colors.teal)))
              )
           ]
        ),
     );
  }
}

class _TimelineTick extends StatelessWidget {
  const _TimelineTick();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 9.0, top: 4, bottom: 4),
      child: Container(
        width: 2,
        height: 16,
        color: Colors.grey.shade300,
      ),
    );
  }
}
