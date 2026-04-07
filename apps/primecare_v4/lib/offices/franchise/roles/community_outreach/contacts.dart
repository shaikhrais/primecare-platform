import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CommunityContactsScreen extends ConsumerStatefulWidget {
  const CommunityContactsScreen({super.key});

  @override
  ConsumerState<CommunityContactsScreen> createState() =>
      _CommunityContactsScreenState();
}

class _CommunityContactsScreenState
    extends ConsumerState<CommunityContactsScreen> {
  String _selectedFilter = 'All Contacts';
  final List<String> _filters = [
    'All Contacts',
    'Referral Sources',
    'Local Officials',
    'Stakeholders',
    'Volunteers',
    'Partner Orgs',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sidebar Filter
        SizedBox(width: 250, child: _buildSidebar()),
        const SizedBox(width: 32),
        // Main Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              Expanded(child: _buildContactsGrid()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSidebar() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Directory',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: PrimeCareTheme.colors.surfaceContainerHighest,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Icon(
                  LucideIcons.search,
                  size: 16,
                  color: PrimeCareTheme.colors.slateGray,
                ),
                const SizedBox(width: 8),
                Text(
                  'Search directory...',
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'RELATIONSHIP TYPE',
              style: PrimeCareTheme.typography.label.copyWith(
                color: PrimeCareTheme.colors.slateGray,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ..._filters.map((filter) => _buildFilterItem(filter)),
        ],
      ),
    );
  }

  Widget _buildFilterItem(String label) {
    bool isSelected = _selectedFilter == label;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? PrimeCareTheme.colors.navyIndigo.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: PrimeCareTheme.typography.body.copyWith(
                color: isSelected
                    ? PrimeCareTheme.colors.navyIndigo
                    : PrimeCareTheme.colors.slateGray,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isSelected)
              Icon(
                LucideIcons.chevronRight,
                size: 16,
                color: PrimeCareTheme.colors.navyIndigo,
              ),
          ],
        ),
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
            Row(
              children: [
                Icon(
                  LucideIcons.contact,
                  color: PrimeCareTheme.colors.navyIndigo,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Community Contacts',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Manage relationships with external community members and referral sources.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        ClinicalGlassButton(
          onPressed: () {},
          icon: LucideIcons.plus,
          label: 'Add Contact',
          isActive: true,
        ),
      ],
    );
  }

  Widget _buildContactsGrid() {
    final contacts = [
      {
        'name': 'Dr. Sarah Jenkins',
        'role': 'Chief Medical Officer',
        'organization': 'City General Hospital',
        'type': 'Referral Source',
        'lastInteraction': '2 days ago',
        'email': 'sjenkins@cgh.org',
        'phone': '(555) 123-4567',
      },
      {
        'name': 'Robert Garcia',
        'role': 'City Councilman',
        'organization': 'District 4 Office',
        'type': 'Local Officials',
        'lastInteraction': '1 week ago',
        'email': 'rgarcia@city.gov',
        'phone': '(555) 987-6543',
      },
      {
        'name': 'Emily Chen',
        'role': 'Executive Director',
        'organization': 'Community Health Foundation',
        'type': 'Partner Orgs',
        'lastInteraction': '3 days ago',
        'email': 'echen@chf.org',
        'phone': '(555) 345-6789',
      },
      {
        'name': 'Michael Thompson',
        'role': 'Lead Social Worker',
        'organization': 'Elder Care Network',
        'type': 'Referral Source',
        'lastInteraction': 'Yesterday',
        'email': 'mthompson@ecn.org',
        'phone': '(555) 555-5555',
      },
      {
        'name': 'Alice Reynolds',
        'role': 'Philanthropy Coordinator',
        'organization': 'United Way',
        'type': 'Stakeholders',
        'lastInteraction': '2 weeks ago',
        'email': 'alice@unitedway.org',
        'phone': '(555) 234-5678',
      },
      {
        'name': 'David Kim',
        'role': 'Principal',
        'organization': 'Lincoln High School',
        'type': 'Partner Orgs',
        'lastInteraction': '1 month ago',
        'email': 'dkim@lincoln.edu',
        'phone': '(555) 456-7890',
      },
    ];

    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 32),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.2,
      ),
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return _buildContactCard(contacts[index]);
      },
    );
  }

  Widget _buildContactCard(Map<String, String> contact) {
    Color typeColor;
    switch (contact['type']) {
      case 'Referral Source':
        typeColor = PrimeCareTheme.colors.emeraldTeal;
        break;
      case 'Local Officials':
        typeColor = Colors.amber.shade700;
        break;
      case 'Partner Orgs':
        typeColor = PrimeCareTheme.colors.navyIndigo;
        break;
      default:
        typeColor = PrimeCareTheme.colors.slateGray;
    }

    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: PrimeCareTheme.colors.navyIndigo.withValues(
                  alpha: 0.1,
                ),
                child: Text(
                  contact['name']!.substring(0, 1),
                  style: PrimeCareTheme.typography.h3.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: typeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  contact['type']!,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: typeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            contact['name']!,
            style: PrimeCareTheme.typography.h3.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
              fontSize: 18,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            contact['role']!,
            style: PrimeCareTheme.typography.body.copyWith(
              color: PrimeCareTheme.colors.slateGray,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            contact['organization']!,
            style: PrimeCareTheme.typography.body.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    LucideIcons.history,
                    size: 14,
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Last: ${contact['lastInteraction']}',
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    iconSize: 18,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      LucideIcons.mail,
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    iconSize: 18,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      LucideIcons.phone,
                      color: PrimeCareTheme.colors.emeraldTeal,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
