// Governance - Category: model | Purpose: The root business entity. Controls global configurations, branding variables, and subscription limits. A logical coll...
import 'package:primecare_screen_models/models/navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:primecare_models/src/models/platform_role.dart';
import 'package:primecare_platform_registries/registry/platform_screen_registry.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:primecare_route_catalog/routes/groups/common_routes.dart';
import 'package:primecare_screen_intents/models/screen.dart';

import 'package:primecare_models/primecare_models.dart' show BasePlatformTenant, BasePlatformModule, BasePlatformRoleDefinition, BasePlatformApplication;

part '../src/domain/governance/platform_tenant.dart';
part '../src/domain/governance/platform_module.dart';
part '../src/domain/governance/platform_role_definition.dart';
part '../src/domain/governance/platform_application.dart';
part '../src/domain/governance/prime_care_tenant.dart';
part '../src/domain/governance/dynamic_platform_module.dart';
