import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class LocalEventsScreen extends ConsumerStatefulWidget {
  const LocalEventsScreen({super.key});

  @override
  ConsumerState<LocalEventsScreen> createState() => _LocalEventsScreenState();
}

class _LocalEventsScreenState extends ConsumerState<LocalEventsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 48),
          Text(
            'Upcoming Events',
            style: PrimeCareTheme.typography.h2.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 24),
          _buildUpcomingEventsCarousel(),
          const SizedBox(height: 48),
          Text(
            'Past Events & ROI',
            style: PrimeCareTheme.typography.h2.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 24),
          _buildPastEventsList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Local Events & Sponsorships',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage health fairs, community sponsorships, and local outreach.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        ClinicalGlassButton(
          onPressed: () {},
          icon: LucideIcons.plus,
          label: 'Register New Event',
          isActive: true,
        ),
      ],
    );
  }

  Widget _buildUpcomingEventsCarousel() {
    return SizedBox(
      height: 260,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildUpcomingEventCard(
            title: 'Downtown Health Fair Booth',
            type: 'Health Fair',
            date: 'Oct 15, 2026',
            location: 'Central Plaza',
            budget: '\$500',
            volunteersNeeded: 2,
          ),
          const SizedBox(width: 24),
          _buildUpcomingEventCard(
            title: 'Little League Sponsorship',
            type: 'Sponsorship',
            date: 'Spring 2027 Season',
            location: 'Community Fields',
            budget: '\$1,200',
            volunteersNeeded: 0,
          ),
          const SizedBox(width: 24),
          _buildUpcomingEventCard(
            title: 'Senior Center Blood Pressure Clinic',
            type: 'Community Outreach',
            date: 'Nov 2, 2026',
            location: 'Oakridge Senior Center',
            budget: '\$150',
            volunteersNeeded: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingEventCard({
    required String title,
    required String type,
    required String date,
    required String location,
    required String budget,
    required int volunteersNeeded,
  }) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: PrimeCareTheme.colors.navyIndigo.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 6, color: PrimeCareTheme.colors.emeraldTeal),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: PrimeCareTheme.colors.navyIndigo.withValues(
                        alpha: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      type,
                      style: PrimeCareTheme.typography.label.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: PrimeCareTheme.typography.h3.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.calendar,
                        size: 14,
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        date,
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.mapPin,
                        size: 14,
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        location,
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Volunteers',
                            style: PrimeCareTheme.typography.label.copyWith(
                              fontSize: 11,
                              color: PrimeCareTheme.colors.slateGray,
                            ),
                          ),
                          Text(
                            volunteersNeeded == 0
                                ? 'Not Required'
                                : '$volunteersNeeded Needed',
                            style: PrimeCareTheme.typography.h4.copyWith(
                              color: volunteersNeeded > 0
                                  ? PrimeCareTheme.colors.coralRed
                                  : PrimeCareTheme.colors.navyIndigo,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Budget',
                            style: PrimeCareTheme.typography.label.copyWith(
                              fontSize: 11,
                              color: PrimeCareTheme.colors.slateGray,
                            ),
                          ),
                          Text(
                            budget,
                            style: PrimeCareTheme.typography.h4.copyWith(
                              color: PrimeCareTheme.colors.navyIndigo,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPastEventsList() {
    return ClinicalGlassPanel(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildPastEventRow(
            title: 'Summer Fun Run 5k Sponsorship',
            date: 'Aug 20, 2026',
            attendance: '500+ attendees',
            leads: 45,
            costPerLead: '\$11.11',
            roiStatus: 'Positive',
          ),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildPastEventRow(
            title: 'Chamber of Commerce Mixer',
            date: 'Jul 15, 2026',
            attendance: '80 attendees',
            leads: 5,
            costPerLead: '\$50.00',
            roiStatus: 'Neutral',
          ),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildPastEventRow(
            title: 'Local Radio Health Segment Series',
            date: 'Jun 01 - Jun 30, 2026',
            attendance: '10k Est. Listeners',
            leads: 15,
            costPerLead: '\$133.33',
            roiStatus: 'Review Needed',
          ),
        ],
      ),
    );
  }

  Widget _buildPastEventRow({
    required String title,
    required String date,
    required String attendance,
    required int leads,
    required String costPerLead,
    required String roiStatus,
  }) {
    Color roiColor;
    if (roiStatus == 'Positive') {
      roiColor = PrimeCareTheme.colors.emeraldTeal;
    } else if (roiStatus == 'Neutral') {
      roiColor = Colors.amber.shade700;
    } else {
      roiColor = PrimeCareTheme.colors.coralRed;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: PrimeCareTheme.typography.h4.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reach/Attendance',
                  style: PrimeCareTheme.typography.label.copyWith(
                    fontSize: 11,
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
                Text(
                  attendance,
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Leads',
                  style: PrimeCareTheme.typography.label.copyWith(
                    fontSize: 11,
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
                Text(
                  leads.toString(),
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cost/Lead',
                  style: PrimeCareTheme.typography.label.copyWith(
                    fontSize: 11,
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
                Text(
                  costPerLead,
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: roiColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  roiStatus,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: roiColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: Icon(
              LucideIcons.chevronRight,
              color: PrimeCareTheme.colors.slateGray,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
