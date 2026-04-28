import 'package:flutter/material.dart';
// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/src/warehouse/offices/base_office_warehouse.dart';
import 'package:primecare_ui/src/warehouse/component_warehouse.dart';
// import 'package:primecare_ui/src/components/generated_placeholders/primecare_placeholders.dart';

class CommonComponentWarehouse extends BaseOfficeWarehouse {
  @override
  Map<String, ComponentBuilder> get builders => {
    'auraDashboardHud': (context, payload) => const SizedBox.shrink(),
    'auraNotificationCenter': (context, payload) => const SizedBox.shrink(),
    'auraSearch': (context, payload) => const SizedBox.shrink(),
    'auraSettings': (context, payload) => const SizedBox.shrink(),
    'auraUserMenu': (context, payload) => const SizedBox.shrink(),
    'auraBreadcrumbs': (context, payload) => const SizedBox.shrink(),
    'auraSidebar': (context, payload) => const SizedBox.shrink(),
    'auraHeader': (context, payload) => const SizedBox.shrink(),
    'auraFooter': (context, payload) => const SizedBox.shrink(),

    'statCard': (context, payload) => const SizedBox.shrink(),
    'chartCard': (context, payload) => const SizedBox.shrink(),
    'primeCareLineChart': (context, payload) => const SizedBox.shrink(),
    'aiForecastingDashlet': (context, payload) => const SizedBox.shrink(),
    'dynamicRoleDashboardScreen': (context, payload) => const SizedBox.shrink(),
    'dynamicRoleDashboardScreenAdapter': (context, payload) =>
        const SizedBox.shrink(),

    'error401PageView': (context, payload) => const SizedBox.shrink(),
    'error404PageView': (context, payload) => const SizedBox.shrink(),
    'errorBoundary': (context, payload) => const SizedBox.shrink(),

    'app': (context, payload) => const SizedBox.shrink(),
    'authentication': (context, payload) => const SizedBox.shrink(),
    'button': (context, payload) => const SizedBox.shrink(),
    'configurator': (context, payload) => const SizedBox.shrink(),
    'layout1': (context, payload) => const SizedBox.shrink(),
    'layout2': (context, payload) => const SizedBox.shrink(),
    'layout3': (context, payload) => const SizedBox.shrink(),
    'link': (context, payload) => const SizedBox.shrink(),
    'logo': (context, payload) => const SizedBox.shrink(),
    'navigation': (context, payload) => const SizedBox.shrink(),

    'pageBreadcrumb': (context, payload) => const SizedBox.shrink(),
    'pageTitle': (context, payload) => const SizedBox.shrink(),

    'moodSliderWidget': (context, payload) => const SizedBox.shrink(),
    'etaTrackerWidget': (context, payload) => const SizedBox.shrink(),
    'dragAssignWidget': (context, payload) => const SizedBox.shrink(),
    'greetingHeaderWidget': (context, payload) => const SizedBox.shrink(),

    'dataTable': (context, payload) => const SizedBox.shrink(),
    'dataTableTopToolbar': (context, payload) => const SizedBox.shrink(),
    'demoContent': (context, payload) => const SizedBox.shrink(),
    'demoFrame': (context, payload) => const SizedBox.shrink(),

    'palettePreview': (context, payload) => const SizedBox.shrink(),
    'paletteSelector': (context, payload) => const SizedBox.shrink(),
    'lightDarkModeToggle': (context, payload) => const SizedBox.shrink(),
    'fullScreenToggle': (context, payload) => const SizedBox.shrink(),
    'adjustFontSize': (context, payload) => const SizedBox.shrink(),

    // Icons
    'alignCenterIcon': (context, payload) => const SizedBox.shrink(),
    'alignJustifyIcon': (context, payload) => const SizedBox.shrink(),
    'alignLeftIcon': (context, payload) => const SizedBox.shrink(),
    'alignRightIcon': (context, payload) => const SizedBox.shrink(),
    'arrowLeftIcon': (context, payload) => const SizedBox.shrink(),
    'banIcon': (context, payload) => const SizedBox.shrink(),
    'chevronDownIcon': (context, payload) => const SizedBox.shrink(),
    'closeIcon': (context, payload) => const SizedBox.shrink(),
    'code2Icon': (context, payload) => const SizedBox.shrink(),
    'externalLinkIcon': (context, payload) => const SizedBox.shrink(),
    'heartIcon': (context, payload) => const SizedBox.shrink(),
    'helpCircleIcon': (context, payload) => const SizedBox.shrink(),
    'homeIcon': (context, payload) => const SizedBox.shrink(),
    'infoIcon': (context, payload) => const SizedBox.shrink(),
    'linkIcon': (context, payload) => const SizedBox.shrink(),
    'listIcon': (context, payload) => const SizedBox.shrink(),
    'lockIcon': (context, payload) => const SizedBox.shrink(),
    'logOutIcon': (context, payload) => const SizedBox.shrink(),
    'mailIcon': (context, payload) => const SizedBox.shrink(),
    'menuIcon': (context, payload) => const SizedBox.shrink(),
    'messageCircleIcon': (context, payload) => const SizedBox.shrink(),
    'messageSquareIcon': (context, payload) => const SizedBox.shrink(),
    'moonIcon': (context, payload) => const SizedBox.shrink(),
    'moreHorizontalIcon': (context, payload) => const SizedBox.shrink(),
    'moreVerticalIcon': (context, payload) => const SizedBox.shrink(),
    'packageIcon': (context, payload) => const SizedBox.shrink(),
    'plusIcon': (context, payload) => const SizedBox.shrink(),
    'searchIcon': (context, payload) => const SizedBox.shrink(),
    'settingsIcon': (context, payload) => const SizedBox.shrink(),
    'shieldIcon': (context, payload) => const SizedBox.shrink(),
    'shoppingBagIcon': (context, payload) => const SizedBox.shrink(),
    'shoppingCartIcon': (context, payload) => const SizedBox.shrink(),
    'starIcon': (context, payload) => const SizedBox.shrink(),
    'sunIcon': (context, payload) => const SizedBox.shrink(),
    'tagIcon': (context, payload) => const SizedBox.shrink(),
    'trash2Icon': (context, payload) => const SizedBox.shrink(),
    'userIcon': (context, payload) => const SizedBox.shrink(),
    'usersIcon': (context, payload) => const SizedBox.shrink(),
    'xIcon': (context, payload) => const SizedBox.shrink(),
  };
}
