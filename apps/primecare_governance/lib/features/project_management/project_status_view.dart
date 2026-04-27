import 'package:flutter/material.dart';

class ProjectStatusScreen extends StatelessWidget {
  final String title;
  
  const ProjectStatusScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 4,
        shadowColor: theme.shadowColor.withValues(alpha: 0.5),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Projects & Error Status',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildProjectCard(
              context,
              projectName: 'PrimeCare Corporate Admin',
              status: 'Active',
              errors: 'None',
              url: 'https://admin.primecare.local',
              folder: 'apps/corporate_admin_app',
              isError: false,
            ),
            const SizedBox(height: 16),
            _buildProjectCard(
              context,
              projectName: 'PSW Mobile App',
              status: 'Active',
              errors: 'GPS location service timeout occasionally.',
              url: 'Deployed to Internal TestFlight',
              folder: 'apps/psw_mobile_app',
              isError: true,
            ),
            const SizedBox(height: 16),
            _buildProjectCard(
              context,
              projectName: 'Auth Microservice',
              status: 'Healthy',
              errors: 'None',
              url: 'https://api.primecare.local/auth',
              folder: 'services/auth_service',
              isError: false,
            ),
            const SizedBox(height: 16),
            _buildProjectCard(
              context,
              projectName: 'Check-In Microservice',
              status: 'Unknown',
              errors: 'Database connection drop reported in production.',
              url: 'https://api.primecare.local/checkin',
              folder: 'services/checkin_service',
              isError: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context, {
    required String projectName,
    required String status,
    required String errors,
    required String url,
    required String folder,
    required bool isError,
  }) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 6,
      shadowColor: theme.shadowColor.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isError ? theme.colorScheme.error : theme.colorScheme.primary.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  projectName,
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Chip(
                  label: Text(
                    status,
                    style: TextStyle(
                      color: isError ? theme.colorScheme.onError : theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: isError ? theme.colorScheme.error : theme.colorScheme.primary,
                ),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow(theme, 'Deployed URL:', url),
            const SizedBox(height: 8),
            _buildInfoRow(theme, 'Source Folder:', folder),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    'Errors / Issues:',
                    style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurfaceVariant),
                  ),
                ),
                Expanded(
                  child: Text(
                    errors,
                    style: TextStyle(
                      color: isError ? theme.colorScheme.error : theme.colorScheme.onSurface,
                      fontWeight: isError ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(ThemeData theme, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: theme.colorScheme.onSurface),
          ),
        ),
      ],
    );
  }
}
