import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';

import 'package:primecare_v4/offices/corporate/roles/ceo/analytics_dashboard.dart'
    as ceo_dash;
import 'package:primecare_v4/offices/corporate/roles/coo/coo_dashboard.dart'
    as coo_dash;
import 'package:primecare_v4/offices/corporate/roles/cfo/cfo_dashboard.dart'
    as cfo_dash;
import 'package:primecare_v4/offices/corporate/roles/cto/cto_dashboard.dart'
    as cto_dash;
import 'package:primecare_v4/offices/corporate/roles/compliance_manager/compliance_dashboard.dart'
    as compliance_manager_dash;
import 'package:primecare_v4/offices/corporate/roles/head_of_bus_dev/bus_dev_dashboard.dart'
    as head_of_bus_dev_dash;
import 'package:primecare_v4/offices/marketing/roles/head_of_marketing/marketing_director_dashboard.dart'
    as head_of_marketing_dash;
import 'package:primecare_v4/offices/corporate/roles/training_director/training_admin_dashboard.dart'
    as training_director_dash;
import 'package:primecare_v4/offices/business_development/roles/regional_manager_ontario/region_dashboard.dart'
    as regional_manager_ontario_dash;
import 'package:primecare_v4/offices/business_development/roles/regional_manager_usa/region_dashboard.dart'
    as regional_manager_usa_dash;
import 'package:primecare_v4/offices/business_development/roles/franchise_sales_manager/pipeline_dashboard.dart'
    as franchise_sales_manager_dash;
import 'package:primecare_v4/offices/business_development/roles/general_manager/ops_dashboard.dart'
    as general_manager_dash;
import 'package:primecare_v4/offices/business_development/roles/partnership_manager/partner_dashboard.dart'
    as partnership_manager_dash;
import 'package:primecare_v4/offices/business_development/roles/territory_expansion_manager/expansion_analytics_dashboard.dart'
    as territory_expansion_manager_dash;
import 'package:primecare_v4/offices/franchise/roles/franchise_owner/owner_dashboard.dart'
    as franchise_owner_dash;
import 'package:primecare_v4/offices/franchise/roles/operations_manager/ops_manager_dashboard.dart'
    as operations_manager_dash;
import 'package:primecare_v4/offices/franchise/roles/scheduler/scheduling_dashboard.dart'
    as scheduler_dash;
import 'package:primecare_v4/offices/franchise/roles/billing_admin/billing_dashboard.dart'
    as billing_admin_dash;
import 'package:primecare_v4/offices/franchise/roles/hr_hiring/hr_dashboard.dart'
    as hr_hiring_dash;
import 'package:primecare_v4/offices/clinic/roles/rn/rn_dashboard.dart'
    as rn_dash;
import 'package:primecare_v4/offices/clinic/roles/rpn/rpn_dashboard.dart'
    as rpn_dash;
import 'package:primecare_v4/offices/clinic/roles/rmt/rmt_dashboard.dart'
    as rmt_dash;
import 'package:primecare_v4/offices/clinic/roles/psw/psw_dashboard.dart'
    as psw_dash;
import 'package:primecare_v4/offices/support/roles/customer_support/support_dashboard.dart'
    as customer_support_dash;
import 'package:primecare_v4/offices/support/roles/intake_coordinator/intake_dashboard.dart'
    as intake_coordinator_dash;
import 'package:primecare_v4/offices/support/roles/quality_assurance/qa_dashboard.dart'
    as quality_assurance_dash;
import 'package:primecare_v4/offices/support/roles/training_coordinator/training_modules.dart'
    as training_coordinator_dash;
import 'package:primecare_v4/offices/marketing/roles/local_marketing_manager/local_marketing_dashboard.dart'
    as local_marketing_manager_dash;
import 'package:primecare_v4/offices/marketing/roles/community_outreach/community_dashboard.dart'
    as community_outreach_dash;
import 'package:primecare_v4/offices/marketing/roles/territory_sales_manager/sales_dashboard.dart'
    as territory_sales_manager_dash;
import 'package:primecare_v4/offices/client/roles/client/client_dashboard.dart'
    as patient_dash;
import 'package:primecare_v4/offices/client/roles/family_member/family_dashboard.dart'
    as family_member_dash;
import 'package:primecare_v4/offices/clinic/roles/physio/physio_dashboard.dart'
    as physio_dash;
import 'package:primecare_v4/offices/clinic/roles/chiro/chiro_dashboard.dart'
    as chiro_dash;
import 'package:primecare_v4/offices/clinic/roles/occupational_therapist/ot_dashboard.dart'
    as ot_dash;
import 'package:primecare_v4/offices/clinic/roles/speech_pathologist/slp_dashboard.dart'
    as slp_dash;
import 'package:primecare_v4/offices/system/roles/guest/guest_dashboard.dart'
    as guest_dash;
import 'package:primecare_v4/offices/system/roles/scrum_master/scrum_master_dashboard.dart'
    as scrum_master_dash;

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env');
  });
  group('Dashboard Smoke Tests', () {
    testWidgets('Mock Smoke Test', (WidgetTester tester) async {
      expect(true, isTrue);
    });
    testWidgets('guest_dash.GuestDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: guest_dash.GuestDashboard())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(guest_dash.GuestDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('ceo_dash.CeoAnalyticsDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: ceo_dash.CeoAnalyticsDashboard()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(ceo_dash.CeoAnalyticsDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('coo_dash.CooDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: coo_dash.CooDashboard())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(coo_dash.CooDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('cfo_dash.CfoDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: cfo_dash.CfoDashboard())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(cfo_dash.CfoDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('cto_dash.CtoDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: cto_dash.CtoDashboard())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(cto_dash.CtoDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets(
      'compliance_manager_dash.ComplianceDashboard renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: compliance_manager_dash.ComplianceDashboard(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(compliance_manager_dash.ComplianceDashboard),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets('head_of_bus_dev_dash.BusDevDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: head_of_bus_dev_dash.BusDevDashboard()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(head_of_bus_dev_dash.BusDevDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets(
      'head_of_marketing_dash.HeadOfMarketingDashboard renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: head_of_marketing_dash.HeadOfMarketingDashboard(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(head_of_marketing_dash.HeadOfMarketingDashboard),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets(
      'training_director_dash.TrainingAdminDashboard renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: training_director_dash.TrainingAdminDashboard(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(training_director_dash.TrainingAdminDashboard),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets(
      'regional_manager_ontario_dash.RegionDashboard renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: regional_manager_ontario_dash.RegionDashboard(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(regional_manager_ontario_dash.RegionDashboard),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets(
      'regional_manager_usa_dash.RegionDashboard renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(body: regional_manager_usa_dash.RegionDashboard()),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(regional_manager_usa_dash.RegionDashboard),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets(
      'franchise_sales_manager_dash.FranchiseSalesDashboard renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: franchise_sales_manager_dash.FranchiseSalesDashboard(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(franchise_sales_manager_dash.FranchiseSalesDashboard),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets('general_manager_dash.OpsDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: general_manager_dash.OpsDashboard()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(general_manager_dash.OpsDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets(
      'partnership_manager_dash.PartnerDashboard renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(body: partnership_manager_dash.PartnerDashboard()),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(partnership_manager_dash.PartnerDashboard),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets(
      'territory_expansion_manager_dash.ExpansionAnalyticsDashboard renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body:
                    territory_expansion_manager_dash.ExpansionAnalyticsDashboard(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(
            territory_expansion_manager_dash.ExpansionAnalyticsDashboard,
          ),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets('franchise_owner_dash.OwnerDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: franchise_owner_dash.OwnerDashboard()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(franchise_owner_dash.OwnerDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets(
      'operations_manager_dash.OpsManagerDashboard renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: operations_manager_dash.OpsManagerDashboard(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(operations_manager_dash.OpsManagerDashboard),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets('scheduler_dash.SchedulingDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: scheduler_dash.SchedulingDashboard()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(scheduler_dash.SchedulingDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('billing_admin_dash.BillingDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: billing_admin_dash.BillingDashboard()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(billing_admin_dash.BillingDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('hr_hiring_dash.HrDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: hr_hiring_dash.HrDashboard()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(hr_hiring_dash.HrDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets(
      'local_marketing_manager_dash.LocalMarketingDashboard renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: local_marketing_manager_dash.LocalMarketingDashboard(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(local_marketing_manager_dash.LocalMarketingDashboard),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets(
      'community_outreach_dash.CommunityOutreachDashboard renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: community_outreach_dash.CommunityOutreachDashboard(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(community_outreach_dash.CommunityOutreachDashboard),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets(
      'territory_sales_manager_dash.TerritorySalesDashboard renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: territory_sales_manager_dash.TerritorySalesDashboard(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(territory_sales_manager_dash.TerritorySalesDashboard),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets('rn_dash.RnDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: rn_dash.RnDashboard())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(rn_dash.RnDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('rpn_dash.RpnDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: rpn_dash.RpnDashboard())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(rpn_dash.RpnDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('rmt_dash.RmtDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: rmt_dash.RmtDashboard())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(rmt_dash.RmtDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('psw_dash.PswDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: psw_dash.PswDashboard())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(psw_dash.PswDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets(
      'customer_support_dash.SupportDashboard renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(body: customer_support_dash.SupportDashboard()),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(customer_support_dash.SupportDashboard),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets(
      'intake_coordinator_dash.IntakeDashboard renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(body: intake_coordinator_dash.IntakeDashboard()),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(intake_coordinator_dash.IntakeDashboard),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets('quality_assurance_dash.QaDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: quality_assurance_dash.QaDashboard()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(quality_assurance_dash.QaDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets(
      'training_coordinator_dash.TrainingCoordinatorDashboard renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: training_coordinator_dash.TrainingCoordinatorDashboard(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(training_coordinator_dash.TrainingCoordinatorDashboard),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets('physio_dash.PhysioDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: physio_dash.PhysioDashboard()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(physio_dash.PhysioDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('chiro_dash.ChiroDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: chiro_dash.ChiroDashboard())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(chiro_dash.ChiroDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('ot_dash.OtDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: ot_dash.OtDashboard())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(ot_dash.OtDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('slp_dash.SlpDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: slp_dash.SlpDashboard())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(slp_dash.SlpDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('patient_dash.ClientDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: patient_dash.ClientDashboard()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(patient_dash.ClientDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('family_member_dash.FamilyDashboard renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: family_member_dash.FamilyDashboard()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(family_member_dash.FamilyDashboard), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets(
      'scrum_master_dash.ScrumMasterDashboard renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(body: scrum_master_dash.ScrumMasterDashboard()),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(scrum_master_dash.ScrumMasterDashboard),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );
  });
}
