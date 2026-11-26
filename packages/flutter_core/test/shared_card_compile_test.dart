import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/dashboard_widgets/prime_dashboard_widgets.dart';
import 'package:flutter_core/work_modules/prime_work_module.dart';
import 'package:flutter_core/page/prime_page_template.dart';
import 'package:flutter_core/component_catalogue/prime_component_catalogue.dart';
import 'package:flutter_core/dashboard_pages/prime_record_page.dart';
import 'package:flutter_core/dashboard_pages/prime_dashboard_page.dart';
import 'package:flutter_core/registry/widgets/responsive_split_dashboard.dart';
import 'package:flutter_core/registry/widgets/theme_settings_drawer.dart';
void main(){test('all migrated flutter_core card consumers compile',(){expect(<Type>[PrimeChart,PrimeWorkModule,PrimePageTemplate,PrimeComponentKit,PrimeRecordPage,PrimeDashboardPage,ResponsiveSplitDashboard,ThemeSettingsDrawer],hasLength(8));});}
