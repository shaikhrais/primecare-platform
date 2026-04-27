import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../core/ui/dynamic_form_builder.dart';
import '../../../core/utils/logger.dart';
import 'audit_log_view.dart';

class GovernanceDataEntryView extends StatelessWidget {
  const GovernanceDataEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Governance Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Screens', icon: Icon(Icons.monitor)),
              Tab(text: 'Routes', icon: Icon(Icons.route)),
              Tab(text: 'Permissions', icon: Icon(Icons.security)),
              Tab(text: 'Apps', icon: Icon(Icons.apps)),
              Tab(text: 'Modules', icon: Icon(Icons.view_module)),
              Tab(text: 'Roles', icon: Icon(Icons.badge)),
              Tab(text: 'Audit Logs', icon: Icon(Icons.history)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildScreenForm(),
            _buildRouteForm(),
            _buildPermissionForm(),
            _buildAppForm(),
            _buildModuleForm(),
            _buildRoleForm(),
            const AuditLogView(),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: DynamicFormBuilder(
        configs: [
          FormFieldConfig(
            name: 'id',
            label: 'Screen ID (Upper Case)',
            type: FieldType.text,
            validators: [Validators.required.call],
          ),
          FormFieldConfig(
            name: 'title',
            label: 'Display Title',
            type: FieldType.text,
            validators: [Validators.required.call],
          ),
          FormFieldConfig(
            name: 'featureName',
            label: 'Feature Group',
            type: FieldType.dropdown,
            options: ['Core', 'User Management', 'Financials', 'Logistics'],
            validators: [Validators.required.call],
          ),
        ],
        onSave: (data) => AppLogger.i('Saving Form Data: $data'),
      ),
    );
  }

  Widget _buildRouteForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: DynamicFormBuilder(
        configs: [
          FormFieldConfig(
            name: 'path',
            label: 'Route Path (e.g. /users)',
            type: FieldType.text,
            validators: [Validators.required.call],
          ),
          FormFieldConfig(
            name: 'screenId',
            label: 'Target Screen',
            type: FieldType.text,
            validators: [Validators.required.call],
          ),
        ],
        onSave: (data) => AppLogger.i('Saving Form Data: $data'),
      ),
    );
  }

  Widget _buildPermissionForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: DynamicFormBuilder(
        configs: [
          FormFieldConfig(
            name: 'role',
            label: 'Role Name',
            type: FieldType.text,
            validators: [Validators.required.call],
          ),
          FormFieldConfig(
            name: 'resource',
            label: 'Protected Resource',
            type: FieldType.text,
            validators: [Validators.required.call],
          ),
          FormFieldConfig(
            name: 'canRead',
            label: 'Read Access',
            type: FieldType.boolean,
            initialValue: true,
          ),
          FormFieldConfig(
            name: 'canWrite',
            label: 'Write Access',
            type: FieldType.boolean,
            initialValue: false,
          ),
        ],
        onSave: (data) => AppLogger.i('Saving Form Data: $data'),
      ),
    );
  }

  Widget _buildModuleForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: DynamicFormBuilder(
        configs: [
          FormFieldConfig(
            name: 'moduleId',
            label: 'Module ID (e.g. MOD-001)',
            type: FieldType.text,
            validators: [Validators.required.call],
          ),
          FormFieldConfig(
            name: 'moduleName',
            label: 'Module Name',
            type: FieldType.text,
            validators: [Validators.required.call],
          ),
          FormFieldConfig(
            name: 'description',
            label: 'Module Description',
            type: FieldType.text,
          ),
          FormFieldConfig(
            name: 'appId',
            label: 'Parent Application',
            type: FieldType.dropdown,
            options: ['APP-CORP-001', 'APP-PSW-001'],
            validators: [Validators.required.call],
          ),
        ],
        onSave: (data) => AppLogger.i('Saving Module: $data'),
      ),
    );
  }

  Widget _buildAppForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: DynamicFormBuilder(
        configs: [
          FormFieldConfig(
            name: 'appId',
            label: 'Application ID (e.g. APP-001)',
            type: FieldType.text,
            validators: [Validators.required.call],
          ),
          FormFieldConfig(
            name: 'appName',
            label: 'Application Name',
            type: FieldType.text,
            validators: [Validators.required.call],
          ),
          FormFieldConfig(
            name: 'appType',
            label: 'Type',
            type: FieldType.dropdown,
            options: ['Web Admin', 'Mobile', 'Kiosk', 'Worker Service'],
            validators: [Validators.required.call],
          ),
        ],
        onSave: (data) => AppLogger.i('Saving App: $data'),
      ),
    );
  }

  Widget _buildRoleForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: DynamicFormBuilder(
        configs: [
          FormFieldConfig(
            name: 'roleName',
            label: 'Role Name',
            type: FieldType.text,
            validators: [Validators.required.call],
          ),
          FormFieldConfig(
            name: 'description',
            label: 'Role Description',
            type: FieldType.text,
          ),
          FormFieldConfig(
            name: 'appId',
            label: 'Associated App',
            type: FieldType.dropdown,
            options: ['APP-CORP-001', 'APP-PSW-001'],
          ),
        ],
        onSave: (data) => AppLogger.i('Saving Role: $data'),
      ),
    );
  }
}
