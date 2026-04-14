import 'package:flutter/material.dart';
import '../../dashboard_service.dart';
import '../models/intelligence_insight.dart';
import '../models/scheduler_models.dart';

/// Core Data Logistics Hub for the PrimeCare Platform.
/// Provides a unified mechanism for API hydration with automatic fallback to offline blueprints.
class DataLogisticsHub {
  /// Provides high-fidelity clinical intelligence blueprints.
  static ClinicalIntelligenceViewModel getClinicIntelligenceMetrics() {
    return ClinicalIntelligenceViewModel(
      isOfflineFallback: true,
      blueprints: [
        const AuraDashboardHudBlueprint(dataPayload: null),
        const StatGridBlueprint(
          dataPayload: [
            UniversalKpi(
              title: 'Patient Census',
              value: '142',
              trend: 4.2,
              status: KpiStatus.positive,
            ),
            UniversalKpi(
              title: 'Bed Occupancy',
              value: '88%',
              trend: -1.5,
              status: KpiStatus.warning,
            ),
            UniversalKpi(
              title: 'Staff Readiness',
              value: '94%',
              trend: 0.8,
              status: KpiStatus.positive,
            ),
          ],
        ),
        const ClinicalMetricBlueprint(
          dataPayload: {
            'title': 'ADL Velocity',
            'metrics': [
              {'label': 'Mobility', 'value': 0.85},
              {'label': 'Hygiene', 'value': 0.72},
              {'label': 'Nutrition', 'value': 0.94},
            ],
          },
        ),
        const ActivityFeedBlueprint(
          dataPayload: [
            {
              'id': 'evt_1',
              'title': 'Medication Protocol Met',
              'timestamp': '12m ago',
              'type': 'success',
            },
            {
              'id': 'evt_2',
              'title': 'High Heart Rate Alert (Room 102)',
              'timestamp': '5m ago',
              'type': 'warning',
            },
          ],
        ),
        ChartBlueprint(
          dataPayload: AnalyticsChart(
            id: 'risk_trajectory',
            title: 'Critical Risk Velocity',
            type: ChartType.line,
            dataPoints: [
              ChartDataPoint(label: 'Mon', value: 12),
              ChartDataPoint(label: 'Tue', value: 18),
              ChartDataPoint(label: 'Wed', value: 14),
              ChartDataPoint(label: 'Thu', value: 22),
              ChartDataPoint(label: 'Fri', value: 19),
            ],
            forecastDataPoints: [
              ChartDataPoint(label: 'Sat', value: 25),
              ChartDataPoint(label: 'Sun', value: 28),
            ],
          ),
        ),
        FinancialRailBlueprint(
          dataPayload: [
            FinancialMetric(
              label: 'Operational Ledger',
              value: 'SYNCED',
              status: 'operational',
              trend: 'NOMINAL',
            ),
            FinancialMetric(
              label: 'Revenue Variance',
              value: '-\$12,400',
              status: 'warning',
              trend: '-2.4%',
            ),
          ],
        ),
      ],
    );
  }

  /// Assembles the data payload from the API into strongly-typed UI components.
  /// If the API payload fails, times out, or throws an exception, this gracefully falls back
  /// to the [fallbackBuilder] so that the UI can assemble its offline/fallback views.
  /// Assembles the data payload from the API into strongly-typed UI components.
  /// If the API payload fails, times out, or throws an exception, this gracefully falls back
  /// to the [fallbackBuilder] so that the UI can assemble its offline/fallback views.
  static Future<T> fetchAndAssemble<T>({
    required Future<T> Function() fetchCall,
    required T Function() fallbackBuilder,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    try {
      return await fetchCall();
    } catch (e, st) {
      if (onError != null) {
        onError(e, st);
      }
      return fallbackBuilder();
    }
  }

  static Map<String, dynamic>? getReportBlueprint(String reportId) {
    return _reportBlueprints[reportId];
  }

  /// Provides high-fidelity intelligence blueprints for demonstrators and resilient fallbacks.
  static List<IntelligenceInsight> getAuraBlueprints(String role) {
    final tRole = role.toLowerCase();
    if (tRole.contains('receptionist') || tRole.contains('facility')) {
      return [
        IntelligenceInsight(
          id: 'aura_rec_1',
          title: 'Room Optimization',
          summary:
              'Room 102 (Surgical) has high idle time. Suggest rescheduling Bob Smith from 101 to improve turnover velocity.',
          impact: InsightImpact.positive,
        ),
        IntelligenceInsight(
          id: 'aura_rec_2',
          title: 'Maintenance Alert',
          summary:
              'Laser Machine Alpha is due for calibration in 48 hours. Avoid scheduling intensive procedures after Thursday.',
          impact: InsightImpact.caution,
        ),
      ];
    }

    return [
      IntelligenceInsight(
        id: 'aura_1',
        title: 'Projected Surplus',
        summary:
            'Aura analyzes institutional trends and projects a 15% revenue surplus for this quarter based on current occupancy velocity.',
        impact: InsightImpact.positive,
      ),
      IntelligenceInsight(
        id: 'aura_2',
        title: 'Workforce Efficiency',
        summary:
            'Operational documentation volume is peaking. Aura suggests auditing documentation velocity in Ward A.',
        impact: InsightImpact.caution,
      ),
    ];
  }

  /// Alias for test and resilient hydration layers.
  static List<IntelligenceInsight> getAuraInsights(String role) =>
      getAuraBlueprints(role);

  static DashboardMetrics getDashboardMetrics(String role) {
    final tRole = role.toLowerCase();

    if (tRole.contains('receptionist') || tRole.contains('facility')) {
      return DashboardMetrics(
        kpis: [
          KpiMetric(
            title: 'Room Utilization',
            value: '78%',
            status: 'good',
            subtitle: '8 rooms online',
          ),
          KpiMetric(
            title: 'Equipment Health',
            value: '94%',
            status: 'stable',
            subtitle: '1 unit needs calibration',
          ),
          KpiMetric(
            title: 'Avg Turnover',
            value: '14m',
            status: 'warning',
            subtitle: '+2m vs peak',
          ),
          KpiMetric(
            title: 'Resource Alerts',
            value: '3',
            status: 'danger',
            subtitle: 'Action required',
          ),
        ],
        recentActivity: [],
        charts: [
          AnalyticsChart(
            id: 'res_util_1',
            title: 'Resource Utilization Hub',
            type: ChartType.bar,
            dataPoints: [
              ChartDataPoint(label: 'Laser Alpha', value: 85, color: '#3B82F6'),
              ChartDataPoint(label: 'Room 101', value: 92, color: '#10B981'),
              ChartDataPoint(label: 'Room 102', value: 45, color: '#F59E0B'),
              ChartDataPoint(label: 'Facial Unit', value: 70, color: '#818CF8'),
            ],
          ),
        ],
      );
    }

    // Default Fallback for other roles
    return DashboardMetrics(
      kpis: [
        KpiMetric(
          title: 'Active Patients',
          value: '1,240',
          status: 'stable',
          subtitle: '+12% from last month',
        ),
        KpiMetric(
          title: 'Pending Claims',
          value: '48',
          status: 'warning',
          subtitle: '8 high priority',
        ),
        KpiMetric(
          title: 'Staff Capacity',
          value: '92%',
          status: 'good',
          subtitle: 'Optimal',
        ),
      ],
      recentActivity: [],
      charts: [
        AnalyticsChart(
          id: 'rev_traj_1',
          title: 'Revenue Trajectory',
          type: ChartType.line,
          reportId: 'revenue_log',
          dataPoints: [
            ChartDataPoint(label: 'Mon', value: 12500, color: '#3B82F6'),
            ChartDataPoint(label: 'Tue', value: 14200, color: '#3B82F6'),
            ChartDataPoint(label: 'Wed', value: 13800, color: '#3B82F6'),
            ChartDataPoint(label: 'Thu', value: 16500, color: '#3B82F6'),
            ChartDataPoint(label: 'Fri', value: 15900, color: '#3B82F6'),
          ],
          forecastDataPoints: [
            ChartDataPoint(label: 'Sat', value: 17200, color: '#9333EA'),
            ChartDataPoint(label: 'Sun', value: 18500, color: '#9333EA'),
            ChartDataPoint(label: 'Mon', value: 19800, color: '#9333EA'),
          ],
        ),
      ],
    );
  }

  static HorizonSchedule getHorizonBlueprint() {
    return HorizonSchedule(
      staff: _staffBlueprints,
      resources: _resourceBlueprints,
      appointments: _appointmentBlueprints,
    );
  }

  static const List<InstitutionalResource> _resourceBlueprints = [
    InstitutionalResource(
      id: 'res_1',
      name: 'Office 101',
      type: ResourceType.room,
      description: 'Primary consultative office.',
      status: ResourceStatus.available,
    ),
    InstitutionalResource(
      id: 'res_2',
      name: 'Room 102 (Surgical)',
      type: ResourceType.room,
      description: 'Sterile procedure suite.',
      status: ResourceStatus.busy,
    ),
    InstitutionalResource(
      id: 'res_3',
      name: 'Laser Machine Alpha',
      type: ResourceType.equipment,
      description: 'CO2 Laser for dermatological procedures.',
      status: ResourceStatus.available,
    ),
    InstitutionalResource(
      id: 'res_4',
      name: 'Hydro Facial Unit 01',
      type: ResourceType.equipment,
      description: 'Advanced hydration therapy console.',
      status: ResourceStatus.maintenance,
      lastMaintenanceDate: null,
    ),
    InstitutionalResource(
      id: 'res_5',
      name: 'Room 103 (Therapy)',
      type: ResourceType.room,
      description: 'Private physical therapy room.',
      status: ResourceStatus.available,
    ),
    InstitutionalResource(
      id: 'res_6',
      name: 'Laser Machine Beta',
      type: ResourceType.equipment,
      description: 'Secondary diode laser unit.',
      status: ResourceStatus.available,
    ),
  ];

  static const List<StaffMember> _staffBlueprints = [
    StaffMember(
      id: 'staff_1',
      name: 'Dr. Shaikh Aris',
      role: 'Chief of Medicine',
      specialization: 'Cardiology',
      avatarUrl:
          'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=100',
      themeColor: Color(0xFF818CF8), // Indigo
    ),
    StaffMember(
      id: 'staff_2',
      name: 'Nurse Julian',
      role: 'Head Nurse',
      specialization: 'ICU / Critical Care',
      avatarUrl:
          'https://images.unsplash.com/photo-1559839734-2b71f1536783?w=100',
      themeColor: Color(0xFF2DD4BF), // Teal
    ),
    StaffMember(
      id: 'staff_3',
      name: 'Sarah Smith',
      role: 'Senior Therapist',
      specialization: 'Physiotherapy',
      avatarUrl:
          'https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=100',
      themeColor: Color(0xFFF59E0B), // Amber
    ),
  ];

  static final List<Appointment> _appointmentBlueprints = [
    Appointment(
      id: 'appt_1',
      patientName: 'Alice Johnson',
      startTime: DateTime.now().subtract(const Duration(hours: 1)),
      duration: const Duration(minutes: 60),
      staffId: 'staff_1',
      resourceId: 'res_1',
      status: AppointmentStatus.completed,
      note: 'Routine cardiology follow-up.',
    ),
    Appointment(
      id: 'appt_2',
      patientName: 'Bob Smith',
      startTime: DateTime.now().add(const Duration(minutes: 30)),
      duration: const Duration(minutes: 45),
      staffId: 'staff_1',
      resourceId: 'res_3', // Laser Machine Alpha
      status: AppointmentStatus.confirmed,
      note: 'ECG Review & Laser Prep.',
    ),
    Appointment(
      id: 'appt_3',
      patientName: 'Charlie Davis',
      startTime: DateTime.now().add(const Duration(hours: 1)),
      duration: const Duration(minutes: 30),
      staffId: 'staff_2',
      resourceId: 'res_4', // Hydro Facial Unit
      status: AppointmentStatus.confirmed,
    ),
  ];

  static const Map<String, dynamic> _reportBlueprints = {
    'revenue_log': {
      'id': 'revenue_log',
      'title': 'Financial Transaction Detail',
      'columns': [
        {'key': 'date', 'label': 'Date'},
        {'key': 'description', 'label': 'Description'},
        {'key': 'amount', 'label': 'Amount', 'isNumeric': true},
        {'key': 'status', 'label': 'Status'},
      ],
      'rows': [
        {
          'date': '2024-04-10',
          'description': 'Premium Home Care Subscription - Alice Johnson',
          'amount': 249.99,
          'status': 'Paid',
        },
        {
          'date': '2024-04-11',
          'description': 'Emergency Nursing Visit - Bob Smith',
          'amount': 150.00,
          'status': 'Pending',
        },
        {
          'date': '2024-04-12',
          'description': 'Medication Management Service',
          'amount': 85.00,
          'status': 'Paid',
        },
        {
          'date': '2024-04-12',
          'description': 'Telehealth Consultation - Charlie Davis',
          'amount': 45.00,
          'status': 'Paid',
        },
        {
          'date': '2024-04-13',
          'description': 'Physical Therapy Session - Sarah Connor',
          'amount': 120.00,
          'status': 'Pending',
        },
        {
          'date': '2024-04-13',
          'description': 'Diagnostic Imaging - Ward A',
          'amount': 750.00,
          'status': 'Paid',
        },
        {
          'date': '2024-04-14',
          'description': 'Post-Op Consultation - Kyle Reese',
          'amount': 210.00,
          'status': 'Pending',
        },
      ],
    },

    'patient_history': {
      'id': 'patient_history',
      'title': 'Patient Admission Log',
      'columns': [
        {'key': 'id', 'label': 'Case ID'},
        {'key': 'patient', 'label': 'Patient'},
        {'key': 'admitted', 'label': 'Admitted'},
        {'key': 'ward', 'label': 'Ward'},
        {'key': 'acuity', 'label': 'Acuity'},
      ],
      'rows': [
        {
          'id': 'PC-901',
          'patient': 'James Wilson',
          'admitted': '2h ago',
          'ward': 'Home Care A',
          'acuity': 'High',
        },
        {
          'id': 'PC-882',
          'patient': 'Sarah Connor',
          'admitted': '5h ago',
          'ward': 'Nursing Hub B',
          'acuity': 'Medium',
        },
        {
          'id': 'PC-750',
          'patient': 'Kyle Reese',
          'admitted': '1d ago',
          'ward': 'Home Care C',
          'acuity': 'Low',
        },
      ],
    },
  };
}
