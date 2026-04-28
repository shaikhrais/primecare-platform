import 'package:flutter/material.dart';
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/warehouse/component_warehouse.dart';
import 'package:primecare_ui/src/warehouse/offices/base_office_warehouse.dart';
// import 'package:primecare_ui/src/components/generated_placeholders/primecare_placeholders.dart';
// import 'package:primecare_ui/src/features/features_manifest.dart';

class InfrastructureComponentWarehouse extends BaseOfficeWarehouse {
  @override
  Map<String, ComponentBuilder> get builders => {
    'aWSAuthContext': (context, payload) => const SizedBox.shrink(),
    'aWSAuthProvider': (context, payload) => const SizedBox.shrink(),
    'aWSAuthenticator': (context, payload) => const SizedBox.shrink(),
    'awsSignInTab': (context, payload) => const SizedBox.shrink(),
    'awsSignUpTab': (context, payload) => const SizedBox.shrink(),

    'firebaseAuthContext': (context, payload) => const SizedBox.shrink(),
    'firebaseAuthProvider': (context, payload) => const SizedBox.shrink(),
    'firebaseSignInForm': (context, payload) => const SizedBox.shrink(),
    'firebaseSignInTab': (context, payload) => const SizedBox.shrink(),
    'firebaseSignUpForm': (context, payload) => const SizedBox.shrink(),
    'firebaseSignUpTab': (context, payload) => const SizedBox.shrink(),
    'initializeFirebase': (context, payload) => const SizedBox.shrink(),

    'jwtAuthContext': (context, payload) => const SizedBox.shrink(),
    'jwtAuthProvider': (context, payload) => const SizedBox.shrink(),
    'jwtSignInForm': (context, payload) => const SizedBox.shrink(),
    'jwtSignInTab': (context, payload) => const SizedBox.shrink(),
    'jwtSignUpForm': (context, payload) => const SizedBox.shrink(),
    'jwSignUpTab': (context, payload) => const SizedBox.shrink(),

    'ctoDashboardAdapter': (context, payload) => const SizedBox.shrink(),
    'ctoDashboardDto': (context, payload) => const SizedBox.shrink(),
    'ctoDashboardDtoAdapter': (context, payload) => const SizedBox.shrink(),
    'ctoDashboardMapper': (context, payload) => const SizedBox.shrink(),
    'ctoDashboardMapperAdapter': (context, payload) => const SizedBox.shrink(),
    'ctoDashboardViewModel': (context, payload) => const SizedBox.shrink(),
    'ctoDashboardViewModelAdapter': (context, payload) =>
        const SizedBox.shrink(),

    'auditSecurityComplianceForm': (context, payload) =>
        const SizedBox.shrink(),
    'auditOverrideForm': (context, payload) => const SizedBox.shrink(),
  };
}
