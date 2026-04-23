// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
import 'package:primecare_ui/src/warehouse/01_I_component_warehouse.dart';
import 'package:primecare_ui/src/warehouse/offices/base_office_warehouse.dart';
import 'package:primecare_ui/src/components/generated_placeholders/01_I_primecare_placeholders.dart';
import 'package:primecare_ui/src/components/aura/01_I_aura_dashboard_hud.dart';
import 'package:primecare_ui/src/screens/common/05_U_dynamic_role_dashboard_screen.dart';
import 'package:primecare_ui/src/components/01_I_primecare_stat_card.dart';
import 'package:primecare_ui/src/components/cards/01_I_primecare_chart_card.dart';
import 'package:primecare_ui/src/components/charts/01_I_prime_care_line_chart.dart';
import 'package:primecare_ui/src/components/analytics/01_I_ai_forecasting_dashlet.dart';


class CommonComponentWarehouse extends BaseOfficeWarehouse {
  @override
  Map<String, ComponentBuilder> get builders => {
    'auraDashboardHud': (context, payload) => const AuraDashboardHud(),
    'auraNotificationCenter': (context, payload) => AuranotificationcenterPlaceholder(data: payload),
    'auraSearch': (context, payload) => AurasearchPlaceholder(data: payload),
    'auraSettings': (context, payload) => AurasettingsPlaceholder(data: payload),
    'auraUserMenu': (context, payload) => AurausermenuPlaceholder(data: payload),
    'auraBreadcrumbs': (context, payload) => AurabreadcrumbsPlaceholder(data: payload),
    'auraSidebar': (context, payload) => AurasidebarPlaceholder(data: payload),
    'auraHeader': (context, payload) => AuraheaderPlaceholder(data: payload),
    'auraFooter': (context, payload) => AurafooterPlaceholder(data: payload),

    'statCard': (context, payload) {
      final data = payload as Map<String, dynamic>;
      return PrimeCareStatCard(
        title: data['title'] as String? ?? 'Stat',
        value: data['value'] as String? ?? '0',
        delta: data['delta'] as double?,
        deltaSuffix: data['deltaSuffix'] as String?,
        icon: data['icon'] as IconData? ?? LucideIcons.barChart,
        iconColor: data['color'] as Color? ?? Colors.blueAccent,
      );
    },
    'chartCard': (context, payload) {
      final data = payload as Map<String, dynamic>;
      return PrimeCareChartCard(
        title: data['title'] as String? ?? 'Chart',
        chart: data['chart'] as Widget? ?? const SizedBox(),
      );
    },
    'primeCareLineChart': (context, payload) {
      final data = payload as Map<String, dynamic>;
      return PrimeCareLineChart(
        chart: data['chart'] as AnalyticsChart? ?? AnalyticsChart(
          id: 'line_chart_placeholder',
          title: 'Chart',
          type: ChartType.line,
          dataPoints: [],
        ),
      );
    },
    'aiForecastingDashlet': (context, payload) => AIForecastingDashlet(
          data: payload as AIAnalyticsForecastingData? ?? AIAnalyticsForecastingData(
            projections: [],
            kpis: ForecastingKPIs(
              quarterlyRevenue: 0,
              projectedGrowth: 0,
              marginEfficiency: 0,
              projectedAdmissions: 0,
            ),
            insights: [],
            confidenceScore: 0,
          ),
        ),

    'dynamicRoleDashboardScreen': (context, payload) => DynamicRoleDashboardScreen(role: payload as String),
    'dynamicRoleDashboardScreenAdapter': (context, payload) => DynamicroledashboardscreenadapterPlaceholder(data: payload),

    'error401PageView': (context, payload) => Error401pageviewPlaceholder(data: payload),
    'error404PageView': (context, payload) => Error404pageviewPlaceholder(data: payload),
    'errorBoundary': (context, payload) => ErrorboundaryPlaceholder(data: payload),

    'i18nContext': (context, payload) => I18ncontextPlaceholder(data: payload),
    'i18nProvider': (context, payload) => I18nproviderPlaceholder(data: payload),

    'app': (context, payload) => AppscreenPlaceholder(data: payload),
    'authentication': (context, payload) => AuthenticationscreenPlaceholder(data: payload),
    'button': (context, payload) => ButtonscreenPlaceholder(data: payload),
    'configurator': (context, payload) => ConfiguratorscreenPlaceholder(data: payload),
    'layout1': (context, payload) => Layout1screenPlaceholder(data: payload),
    'layout2': (context, payload) => Layout2screenPlaceholder(data: payload),
    'layout3': (context, payload) => Layout3screenPlaceholder(data: payload),
    'link': (context, payload) => LinkscreenPlaceholder(data: payload),
    'logo': (context, payload) => LogoscreenPlaceholder(data: payload),
    'navigation': (context, payload) => NavigationscreenPlaceholder(data: payload),

    'pageBreadcrumb': (context, payload) => PagebreadcrumbPlaceholder(data: payload),
    'pageTitle': (context, payload) => PagetitlePlaceholder(data: payload),

    'moodSliderWidget': (context, payload) => MoodsliderwidgetPlaceholder(data: payload),
    'etaTrackerWidget': (context, payload) => EtatrackerwidgetPlaceholder(data: payload),
    'dragAssignWidget': (context, payload) => DragassignwidgetPlaceholder(data: payload),
    'greetingHeaderWidget': (context, payload) => GreetingheaderwidgetPlaceholder(data: payload),

    'dataTable': (context, payload) => DatatablePlaceholder(data: payload),
    'dataTableTopToolbar': (context, payload) => DatatabletoptoolbarPlaceholder(data: payload),
    'demoContent': (context, payload) => DemocontentPlaceholder(data: payload),
    'demoFrame': (context, payload) => DemoframePlaceholder(data: payload),

    'palettePreview': (context, payload) => PalettepreviewPlaceholder(data: payload),
    'paletteSelector': (context, payload) => PaletteselectorPlaceholder(data: payload),
    'lightDarkModeToggle': (context, payload) => LightdarkmodetogglePlaceholder(data: payload),
    'fullScreenToggle': (context, payload) => FullscreentogglePlaceholder(data: payload),
    'adjustFontSize': (context, payload) => AdjustfontsizePlaceholder(data: payload),

    // Icons
    'alignCenterIcon': (context, payload) => AligncentericonPlaceholder(data: payload),
    'alignJustifyIcon': (context, payload) => AlignjustifyiconPlaceholder(data: payload),
    'alignLeftIcon': (context, payload) => AlignlefticonPlaceholder(data: payload),
    'alignRightIcon': (context, payload) => AlignrighticonPlaceholder(data: payload),
    'arrowLeftIcon': (context, payload) => ArrowlefticonPlaceholder(data: payload),
    'banIcon': (context, payload) => BaniconPlaceholder(data: payload),
    'chevronDownIcon': (context, payload) => ChevrondowniconPlaceholder(data: payload),
    'closeIcon': (context, payload) => CloseiconPlaceholder(data: payload),
    'code2Icon': (context, payload) => Code2iconPlaceholder(data: payload),
    'externalLinkIcon': (context, payload) => ExternallinkiconPlaceholder(data: payload),
    'heartIcon': (context, payload) => HearticonPlaceholder(data: payload),
    'helpCircleIcon': (context, payload) => HelpcircleiconPlaceholder(data: payload),
    'homeIcon': (context, payload) => HomeiconPlaceholder(data: payload),
    'infoIcon': (context, payload) => InfoiconPlaceholder(data: payload),
    'linkIcon': (context, payload) => LinkiconPlaceholder(data: payload),
    'listIcon': (context, payload) => ListiconPlaceholder(data: payload),
    'lockIcon': (context, payload) => LockiconPlaceholder(data: payload),
    'logOutIcon': (context, payload) => LogouticonPlaceholder(data: payload),
    'mailIcon': (context, payload) => MailiconPlaceholder(data: payload),
    'menuIcon': (context, payload) => MenuiconPlaceholder(data: payload),
    'messageCircleIcon': (context, payload) => MessagecircleiconPlaceholder(data: payload),
    'messageSquareIcon': (context, payload) => MessagesquareiconPlaceholder(data: payload),
    'moonIcon': (context, payload) => MooniconPlaceholder(data: payload),
    'moreHorizontalIcon': (context, payload) => MorehorizontaliconPlaceholder(data: payload),
    'moreVerticalIcon': (context, payload) => MoreverticaliconPlaceholder(data: payload),
    'packageIcon': (context, payload) => PackageiconPlaceholder(data: payload),
    'plusIcon': (context, payload) => PlusiconPlaceholder(data: payload),
    'searchIcon': (context, payload) => SearchiconPlaceholder(data: payload),
    'settingsIcon': (context, payload) => SettingsiconPlaceholder(data: payload),
    'shieldIcon': (context, payload) => ShieldiconPlaceholder(data: payload),
    'shoppingBagIcon': (context, payload) => ShoppingbagiconPlaceholder(data: payload),
    'shoppingCartIcon': (context, payload) => ShoppingcarticonPlaceholder(data: payload),
    'starIcon': (context, payload) => StariconPlaceholder(data: payload),
    'sunIcon': (context, payload) => SuniconPlaceholder(data: payload),
    'tagIcon': (context, payload) => TagiconPlaceholder(data: payload),
    'trash2Icon': (context, payload) => Trash2iconPlaceholder(data: payload),
    'userIcon': (context, payload) => UsericonPlaceholder(data: payload),
    'usersIcon': (context, payload) => UsersiconPlaceholder(data: payload),
    'xIcon': (context, payload) => XiconPlaceholder(data: payload),
  };
}
