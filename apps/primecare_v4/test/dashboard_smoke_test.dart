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
    testWidgets('guest_dash.GuestDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: Scaffold(body: guest_dash.GuestDashboardScreen())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(guest_dash.GuestDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('ceo_dash.CeoAnalyticsDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: ceo_dash.CeoAnalyticsDashboardScreen()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(ceo_dash.CeoAnalyticsDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('coo_dash.CooDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: Scaffold(body: coo_dash.CooDashboardScreen())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(coo_dash.CooDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('cfo_dash.CfoDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: Scaffold(body: cfo_dash.CfoDashboardScreen())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(cfo_dash.CfoDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('cto_dash.CtoDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: Scaffold(body: cto_dash.CtoDashboardScreen())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(cto_dash.CtoDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets(
      'compliance_manager_dash.ComplianceDashboardScreen renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: compliance_manager_dash.ComplianceDashboardScreen(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(compliance_manager_dash.ComplianceDashboardScreen),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets('head_of_bus_dev_dash.BusDevDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: head_of_bus_dev_dash.BusDevDashboardScreen()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(head_of_bus_dev_dash.BusDevDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets(
      'head_of_marketing_dash.HeadOfMarketingDashboardScreen renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: head_of_marketing_dash.HeadOfMarketingDashboardScreen(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(head_of_marketing_dash.HeadOfMarketingDashboardScreen),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets(
      'training_director_dash.TrainingAdminDashboardScreen renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: training_director_dash.TrainingAdminDashboardScreen(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(training_director_dash.TrainingAdminDashboardScreen),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets(
      'regional_manager_ontario_dash.RegionDashboardScreen renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: regional_manager_ontario_dash.RegionDashboardScreen(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(regional_manager_ontario_dash.RegionDashboardScreen),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets(
      'regional_manager_usa_dash.RegionDashboardScreen renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(body: regional_manager_usa_dash.RegionDashboardScreen()),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(regional_manager_usa_dash.RegionDashboardScreen),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets(
      'franchise_sales_manager_dash.FranchiseSalesDashboardScreen renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: franchise_sales_manager_dash.FranchiseSalesDashboardScreen(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(franchise_sales_manager_dash.FranchiseSalesDashboardScreen),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets('general_manager_dash.OpsDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: general_manager_dash.OpsDashboardScreen()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(general_manager_dash.OpsDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets(
      'partnership_manager_dash.PartnerDashboardScreen renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(body: partnership_manager_dash.PartnerDashboardScreen()),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(partnership_manager_dash.PartnerDashboardScreen),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets(
      'territory_expansion_manager_dash.ExpansionAnalyticsDashboardScreen renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body:
                    territory_expansion_manager_dash.ExpansionAnalyticsDashboardScreen(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(
            territory_expansion_manager_dash.ExpansionAnalyticsDashboardScreen,
          ),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets('franchise_owner_dash.OwnerDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: franchise_owner_dash.OwnerDashboardScreen()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(franchise_owner_dash.OwnerDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets(
      'operations_manager_dash.OpsManagerDashboardScreen renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: operations_manager_dash.OpsManagerDashboardScreen(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(operations_manager_dash.OpsManagerDashboardScreen),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets('scheduler_dash.SchedulingDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: scheduler_dash.SchedulingDashboardScreen()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(scheduler_dash.SchedulingDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('billing_admin_dash.BillingDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: billing_admin_dash.BillingDashboardScreen()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(billing_admin_dash.BillingDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('hr_hiring_dash.HrDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: hr_hiring_dash.HrDashboardScreen()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(hr_hiring_dash.HrDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets(
      'local_marketing_manager_dash.LocalMarketingDashboardScreen renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: local_marketing_manager_dash.LocalMarketingDashboardScreen(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(local_marketing_manager_dash.LocalMarketingDashboardScreen),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets(
      'community_outreach_dash.CommunityOutreachDashboardScreen renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: community_outreach_dash.CommunityOutreachDashboardScreen(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(community_outreach_dash.CommunityOutreachDashboardScreen),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets(
      'territory_sales_manager_dash.TerritorySalesDashboardScreen renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: territory_sales_manager_dash.TerritorySalesDashboardScreen(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(territory_sales_manager_dash.TerritorySalesDashboardScreen),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets('rn_dash.RnDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: Scaffold(body: rn_dash.RnDashboardScreen())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(rn_dash.RnDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('rpn_dash.RpnDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: Scaffold(body: rpn_dash.RpnDashboardScreen())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(rpn_dash.RpnDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('rmt_dash.RmtDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: Scaffold(body: rmt_dash.RmtDashboardScreen())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(rmt_dash.RmtDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('psw_dash.PswDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: Scaffold(body: psw_dash.PswDashboardScreen())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(psw_dash.PswDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets(
      'customer_support_dash.SupportDashboardScreen renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(body: customer_support_dash.SupportDashboardScreen()),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(customer_support_dash.SupportDashboardScreen),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets(
      'intake_coordinator_dash.IntakeDashboardScreen renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(body: intake_coordinator_dash.IntakeDashboardScreen()),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(intake_coordinator_dash.IntakeDashboardScreen),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets('quality_assurance_dash.QaDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: quality_assurance_dash.QaDashboardScreen()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(quality_assurance_dash.QaDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets(
      'training_coordinator_dash.TrainingCoordinatorDashboardScreen renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: training_coordinator_dash.TrainingCoordinatorDashboardScreen(),
              ),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(training_coordinator_dash.TrainingCoordinatorDashboardScreen),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );

    testWidgets('physio_dash.PhysioDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: physio_dash.PhysioDashboardScreen()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(physio_dash.PhysioDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('chiro_dash.ChiroDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: Scaffold(body: chiro_dash.ChiroDashboardScreen())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(chiro_dash.ChiroDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('ot_dash.OtDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: Scaffold(body: ot_dash.OtDashboardScreen())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(ot_dash.OtDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('slp_dash.SlpDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: Scaffold(body: slp_dash.SlpDashboardScreen())),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(slp_dash.SlpDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('patient_dash.ClientDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: patient_dash.ClientDashboardScreen()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(patient_dash.ClientDashboardScreen), findsOneWidget);

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('family_member_dash.FamilyDashboardScreen renders without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: family_member_dash.FamilyDashboardScreen()),
          ),
        ),
      );
      // Just pump a single frame (and a small duration) to allow for initial layout/rendering
      // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
      await tester.pump(const Duration(milliseconds: 500));
      expect(
        find.byType(family_member_dash.FamilyDashboardScreen),
        findsOneWidget,
      );

      // reset size
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets(
      'scrum_master_dash.ScrumMasterDashboardScreen renders without exceptions',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(body: scrum_master_dash.ScrumMasterDashboardScreen()),
            ),
          ),
        );
        // Just pump a single frame (and a small duration) to allow for initial layout/rendering
        // avoiding pumpAndSettle() due to potential infinite animations or loading spinners.
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(scrum_master_dash.ScrumMasterDashboardScreen),
          findsOneWidget,
        );

        // reset size
        addTearDown(() => tester.view.resetPhysicalSize());
      },
    );
  });
}
