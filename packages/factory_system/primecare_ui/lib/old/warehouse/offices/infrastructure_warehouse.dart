// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/warehouse/01_I_component_warehouse.dart';
import 'package:primecare_ui/src/warehouse/offices/base_office_warehouse.dart';
import 'package:primecare_ui/src/components/generated_placeholders/01_I_primecare_placeholders.dart';
import 'package:primecare_ui/src/features/features_manifest.dart';

class InfrastructureComponentWarehouse extends BaseOfficeWarehouse {
  @override
  Map<String, ComponentBuilder> get builders => {
    'aWSAuthContext': (context, payload) =>
        AwsauthcontextPlaceholder(data: payload),
    'aWSAuthProvider': (context, payload) =>
        AwsauthproviderPlaceholder(data: payload),
    'aWSAuthenticator': (context, payload) =>
        AwsauthenticatorPlaceholder(data: payload),
    'awsSignInTab': (context, payload) =>
        AwssignintabPlaceholder(data: payload),
    'awsSignUpTab': (context, payload) =>
        AwssignuptabPlaceholder(data: payload),

    'firebaseAuthContext': (context, payload) =>
        FirebaseauthcontextPlaceholder(data: payload),
    'firebaseAuthProvider': (context, payload) =>
        FirebaseauthproviderPlaceholder(data: payload),
    'firebaseSignInForm': (context, payload) =>
        FirebasesigninformPlaceholder(data: payload),
    'firebaseSignInTab': (context, payload) =>
        FirebasesignintabPlaceholder(data: payload),
    'firebaseSignUpForm': (context, payload) =>
        FirebasesignupformPlaceholder(data: payload),
    'firebaseSignUpTab': (context, payload) =>
        FirebasesignuptabPlaceholder(data: payload),
    'initializeFirebase': (context, payload) =>
        InitializefirebasePlaceholder(data: payload),

    'jwtAuthContext': (context, payload) =>
        JwtauthcontextPlaceholder(data: payload),
    'jwtAuthProvider': (context, payload) =>
        JwtauthproviderPlaceholder(data: payload),
    'jwtSignInForm': (context, payload) =>
        JwtsigninformPlaceholder(data: payload),
    'jwtSignInTab': (context, payload) =>
        JwtsignintabPlaceholder(data: payload),
    'jwtSignUpForm': (context, payload) =>
        JwtsignupformPlaceholder(data: payload),
    'jwSignUpTab': (context, payload) => JwsignuptabPlaceholder(data: payload),

    'ctoDashboardAdapter': (context, payload) =>
        CtodashboardadapterPlaceholder(data: payload),
    'ctoDashboardDto': (context, payload) =>
        CtodashboarddtoPlaceholder(data: payload),
    'ctoDashboardDtoAdapter': (context, payload) =>
        CtodashboarddtoadapterPlaceholder(data: payload),
    'ctoDashboardMapper': (context, payload) =>
        CtodashboardmapperPlaceholder(data: payload),
    'ctoDashboardMapperAdapter': (context, payload) =>
        CtodashboardmapperadapterPlaceholder(data: payload),
    'ctoDashboardViewModel': (context, payload) => const CtoDashboardScreen(),
    'ctoDashboardViewModelAdapter': (context, payload) =>
        CtodashboardviewmodeladapterPlaceholder(data: payload),

    'auditSecurityComplianceForm': (context, payload) =>
        AuditsecuritycomplianceformPlaceholder(data: payload),
    'auditOverrideForm': (context, payload) =>
        AuditoverrideformPlaceholder(data: payload),
  };
}
