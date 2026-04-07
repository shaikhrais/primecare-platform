import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'My Profile',
      subtitle: 'Manage your personal and contact details',
      icon: LucideIcons.user,
      actions: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(LucideIcons.save, size: 18),
          label: const Text('Save Changes'),
          style: ElevatedButton.styleFrom(
            backgroundColor: PrimeCareTheme.primary,
            foregroundColor: PrimeCareTheme.onPrimary,
            elevation: 0,
          ),
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(PrimeCareTheme.spacing6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Information',
                    style: PrimeCareTheme.titleLarge,
                  ),
                  const SizedBox(height: PrimeCareTheme.spacing5),
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: PrimeCareTheme.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          LucideIcons.user,
                          size: 40,
                          color: PrimeCareTheme.primary,
                        ),
                      ),
                      const SizedBox(width: PrimeCareTheme.spacing6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Arthur M.',
                            style: PrimeCareTheme.headlineSmall,
                          ),
                          Text(
                            'Client ID: 4892-10',
                            style: PrimeCareTheme.bodyMedium.copyWith(
                              color: PrimeCareTheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: PrimeCareTheme.spacing6),
                  
                  // Contact Details
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoField(
                          'Email Address',
                          'arthur.m@example.com',
                        ),
                      ),
                      const SizedBox(width: PrimeCareTheme.spacing4),
                      Expanded(
                        child: _buildInfoField(
                          'Phone Number',
                          '(555) 123-4567',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: PrimeCareTheme.spacing6),
                  
                  // Emergency Contacts
                  Text(
                    'Emergency Contact',
                    style: PrimeCareTheme.titleMedium,
                  ),
                  const SizedBox(height: PrimeCareTheme.spacing4),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoField(
                          'Name',
                          'Margaret M.',
                        ),
                      ),
                      const SizedBox(width: PrimeCareTheme.spacing4),
                      Expanded(
                        child: _buildInfoField(
                          'Relationship',
                          'Daughter',
                        ),
                      ),
                      const SizedBox(width: PrimeCareTheme.spacing4),
                      Expanded(
                        child: _buildInfoField(
                          'Phone',
                          '(555) 987-6543',
                        ),
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

  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: PrimeCareTheme.labelSmall.copyWith(
            color: PrimeCareTheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: PrimeCareTheme.spacing1),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: PrimeCareTheme.spacing3,
            horizontal: PrimeCareTheme.spacing4,
          ),
          decoration: BoxDecoration(
            color: PrimeCareTheme.surfaceContainerLowest.withOpacity(0.5),
            borderRadius: BorderRadius.circular(PrimeCareTheme.radiusMd),
          ),
          child: Text(
            value,
            style: PrimeCareTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
