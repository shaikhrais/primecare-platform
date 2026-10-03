import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'auth_design_tokens.dart';
import 'password_recovery_form.dart';

enum AuthPage { login, signup, forgot, reset, mfa, language, consent, success, error }

String _copy(BuildContext context, String key) => 'auth_design_$key'.tr(context: context);

/// Shared, responsive presentation. Controllers own authentication decisions.
class PrimeAuthExperience extends ConsumerWidget {
  final AuthPage page;
  const PrimeAuthExperience({super.key, required this.page});

  void _go(BuildContext context, String path) {
    final target = validateAppReturnUrl(GoRouterState.of(context).uri.queryParameters['returnUrl']);
    context.go(Uri(path: path, queryParameters: {
      if (target != null) 'returnUrl': target,
    }).toString());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final gap = theme.spacing;
    final form = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AuthDesignTokens.formWidth),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Semantics(header: true, child: Text(_copy(context, '${page.name}_title'), style: theme.typography.h1)),
        SizedBox(height: gap.sm),
        Text(_copy(context, '${page.name}_body'), style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurfaceVariant)),
        SizedBox(height: gap.xl),
        ..._content(context, ref),
        SizedBox(height: gap.lg),
        if (page != AuthPage.login && page != AuthPage.success && page != AuthPage.consent)
          TextButton.icon(onPressed: () => _go(context, '/login'), icon: const Icon(Icons.arrow_back_rounded), label: Text(_copy(context, 'back'))),
        if (page == AuthPage.login)
          TextButton(onPressed: () => _go(context, '/signup'), child: Text(_copy(context, 'signup'))),
        SizedBox(height: gap.lg),
        Divider(color: theme.colors.divider),
        Wrap(alignment: WrapAlignment.center, spacing: gap.sm, children: [
          if (page != AuthPage.language)
            TextButton.icon(onPressed: () => _go(context, '/language'), icon: const Icon(Icons.language_rounded), label: Text(_copy(context, 'language'))),
        ]),
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Text(_copy(context, 'help'), style: theme.typography.bodyMedium),
          leading: Icon(Icons.help_outline_rounded, color: theme.colors.onSurfaceVariant),
          children: [Padding(padding: EdgeInsets.only(bottom: gap.md), child: Text(_copy(context, 'help_body'), style: theme.typography.bodyMedium))],
        ),
      ]),
    );
    return Scaffold(
      backgroundColor: theme.colors.background,
      body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
        final desktop = constraints.maxWidth >= AuthDesignTokens.desktopBreakpoint;
        return SingleChildScrollView(
          padding: EdgeInsets.all(desktop ? gap.xl : gap.lg),
          child: Center(child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AuthDesignTokens.canvasWidth),
            child: Column(children: [
              if (!desktop) ...[
                const _BrandMark(), SizedBox(height: gap.xxl),
              ],
              DecoratedBox(
                decoration: BoxDecoration(color: theme.colors.surface, borderRadius: BorderRadius.circular(theme.radiusLg), boxShadow: theme.shadowsSurface1),
                child: desktop
                    ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const Expanded(child: _BrandPanel()),
                        Expanded(child: Padding(padding: EdgeInsets.all(gap.xxl), child: form)),
                      ])
                    : Padding(padding: EdgeInsets.all(gap.lg), child: form),
              ),
              SizedBox(height: gap.lg),
              Text(_copy(context, 'footer'), textAlign: TextAlign.center, style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
            ]),
          )),
        );
      })),
    );
  }

  List<Widget> _content(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final gap = SizedBox(height: theme.spacing.lg);
    switch (page) {
      case AuthPage.login:
        final state = ref.watch(loginControllerProvider);
        final controller = ref.read(loginControllerProvider.notifier);
        return [AutofillGroup(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          PrimeAuthTextField(id: 'login-email', label: _copy(context, 'email'), hint: _copy(context, 'email_hint'), initialValue: state.email, onChanged: controller.onEmailChanged, enabled: !state.isLoading, autofillHints: const [AutofillHints.username, AutofillHints.email], keyboardType: TextInputType.emailAddress),
          gap,
          PrimeAuthTextField(id: 'login-password', label: _copy(context, 'password'), initialValue: state.password, onChanged: controller.onPasswordChanged, enabled: !state.isLoading, password: true, autofillHints: const [AutofillHints.password], onSubmitted: state.isLoading ? null : (_) => controller.login()),
          Align(alignment: AlignmentDirectional.centerEnd, child: TextButton(onPressed: state.isLoading ? null : () => _go(context, '/forgot-password'), child: Text(_copy(context, 'forgot')))),
          if (state.errorMessage != null) ...[_Notice(message: state.errorMessage!, error: true), gap],
          PrimeButton(label: _copy(context, state.isLoading ? 'loading' : 'login'), onPressed: controller.login, isLoading: state.isLoading, isFullWidth: true, dataCy: 'login-submit'),
        ]))];
      case AuthPage.signup:
        return [
          Text(_copy(context, 'signup_info'), style: theme.typography.bodyLarge), gap,
          for (final key in ['signup_step_one', 'signup_step_two', 'signup_step_three'])
            Padding(padding: EdgeInsets.only(bottom: theme.spacing.md), child: Row(children: [Icon(Icons.check_circle_outline_rounded, color: theme.colors.primary), SizedBox(width: theme.spacing.md), Expanded(child: Text(_copy(context, key), style: theme.typography.bodyMedium))])),
          gap, Text(_copy(context, 'signup_note'), style: theme.typography.bodyMedium),
          gap, PrimeButton(label: _copy(context, 'login'), onPressed: () => _go(context, '/login'), isFullWidth: true),
        ];
      case AuthPage.forgot:
        return [const PasswordRecoveryForm(reset: false)];
      case AuthPage.reset:
        return [const PasswordRecoveryForm(reset: true)];
      case AuthPage.mfa:
      case AuthPage.consent:
        // These backend capabilities are not enabled. Do not collect unusable
        // passwords/codes, fabricate success, or imply a recovery email was sent.
        return [
          _Notice(message: '${_copy(context, 'unavailable_title')}\n${_copy(context, 'unavailable_body')}'),
          gap,
          if (page == AuthPage.consent)
            PrimeButton(label: _copy(context, 'session'), onPressed: () => _go(context, '/success'), isFullWidth: true),
        ];
      case AuthPage.language:
        final language = ref.watch(languageProvider);
        return [for (final entry in const {'en': 'english', 'fr': 'french', 'es': 'spanish'}.entries)
          Padding(padding: EdgeInsets.only(bottom: theme.spacing.md), child: OutlinedButton(
            style: OutlinedButton.styleFrom(padding: EdgeInsets.all(theme.spacing.md), alignment: AlignmentDirectional.centerStart),
            onPressed: () async {
              await ref.read(languageProvider.notifier).setLanguage(entry.key);
            },
            child: Row(children: [Expanded(child: Text(_copy(context, entry.value))), if (language == entry.key) const Icon(Icons.check_circle_rounded)]),
          ))];
      case AuthPage.success:
        final auth = ref.watch(authProvider);
        return [
          Icon(Icons.check_circle_outline_rounded, size: AuthDesignTokens.markSize, color: theme.colors.primary), gap,
          Text(_copy(context, 'account'), style: theme.typography.labelBold),
          Text(auth.userName ?? '', style: theme.typography.bodyLarge), gap,
          Text(_copy(context, 'role'), style: theme.typography.labelBold),
          Text(auth.role ?? '', style: theme.typography.bodyLarge), gap,
          PrimeButton(label: _copy(context, 'signout'), onPressed: () async {
            await ref.read(authProvider.notifier).logout();
            if (context.mounted) _go(context, '/login');
          }, isFullWidth: true),
          TextButton(onPressed: () => _go(context, '/consent'), child: Text(_copy(context, 'consent'))),
        ];
      case AuthPage.error:
        return [PrimeButton(label: _copy(context, 'retry'), onPressed: () => _go(context, '/login'), isFullWidth: true)];
    }
  }
}

class _BrandMark extends StatelessWidget {
  final bool inverse;
  const _BrandMark({this.inverse = false});
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final color = inverse ? theme.colors.onPrimary : theme.colors.primary;
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(width: AuthDesignTokens.markSize, height: AuthDesignTokens.markSize,
        decoration: BoxDecoration(color: theme.colors.primary, borderRadius: BorderRadius.circular(theme.radiusSm)),
        child: Icon(Icons.add_rounded, color: theme.colors.onPrimary)),
      SizedBox(width: theme.spacing.md),
      Flexible(child: Text(_copy(context, 'brand'), style: theme.typography.h2.copyWith(color: color))),
    ]);
  }
}

class _BrandPanel extends StatelessWidget {
  const _BrandPanel();
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      constraints: const BoxConstraints(minHeight: AuthDesignTokens.brandMinHeight),
      padding: EdgeInsets.all(theme.spacing.xxl),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(theme.radiusLg),
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [theme.colors.sidebarBackground, theme.colors.primary]),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const _BrandMark(inverse: true),
        SizedBox(height: theme.spacing.xxxl),
        Text(_copy(context, 'eyebrow'), style: theme.typography.labelBold.copyWith(color: theme.colors.onPrimary)),
        SizedBox(height: theme.spacing.lg),
        Text(_copy(context, 'brand_title'), style: theme.typography.h1.copyWith(color: theme.colors.onPrimary)),
        SizedBox(height: theme.spacing.lg),
        Text(_copy(context, 'brand_body'), style: theme.typography.bodyLarge.copyWith(color: theme.colors.onPrimary)),
        SizedBox(height: theme.spacing.xxl),
        ExcludeSemantics(child: Center(child: Container(
          width: AuthDesignTokens.artSize, height: AuthDesignTokens.artSize,
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: theme.colors.onPrimary.withValues(alpha: 0.3))),
          padding: EdgeInsets.all(theme.spacing.xl),
          child: Container(decoration: BoxDecoration(shape: BoxShape.circle, color: theme.colors.onPrimary.withValues(alpha: 0.1)),
            child: Icon(Icons.favorite_outline_rounded, size: AuthDesignTokens.markSize, color: theme.colors.onPrimary)),
        ))),
        SizedBox(height: theme.spacing.xxl),
        Text(_copy(context, 'brand_note'), style: theme.typography.bodySmall.copyWith(color: theme.colors.onPrimary)),
      ]),
    );
  }
}

class _Notice extends StatelessWidget {
  final String message;
  final bool error;
  const _Notice({required this.message, this.error = false});
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Semantics(liveRegion: true, child: Container(
      padding: EdgeInsets.all(theme.spacing.md),
      decoration: BoxDecoration(color: error ? theme.colors.errorContainer : theme.colors.primaryContainer, borderRadius: BorderRadius.circular(theme.radiusDefault)),
      child: Text(message, style: theme.typography.bodyMedium.copyWith(color: error ? theme.colors.onErrorContainer : theme.colors.onSurface)),
    ));
  }
}

/// Accessible auth field with autofill, keyboard actions and password visibility.
class PrimeAuthTextField extends StatefulWidget {
  final String id, label;
  final String? hint, initialValue;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool password, enabled;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  const PrimeAuthTextField({super.key, required this.id, required this.label,
    required this.onChanged, this.hint, this.initialValue, this.onSubmitted,
    this.password = false, this.enabled = true, this.autofillHints, this.keyboardType});
  @override
  State<PrimeAuthTextField> createState() => _PrimeAuthTextFieldState();
}

class _PrimeAuthTextFieldState extends State<PrimeAuthTextField> {
  bool revealed = false;
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Cy(id: widget.id, child: TextFormField(
      initialValue: widget.initialValue, enabled: widget.enabled,
      onChanged: widget.onChanged, onFieldSubmitted: widget.onSubmitted,
      obscureText: widget.password && !revealed, autocorrect: false,
      enableSuggestions: !widget.password, keyboardType: widget.keyboardType,
      autofillHints: widget.autofillHints,
      textInputAction: widget.password ? TextInputAction.done : TextInputAction.next,
      style: theme.typography.bodyLarge,
      decoration: InputDecoration(
        labelText: widget.label, hintText: widget.hint,
        filled: true, fillColor: theme.colors.surface,
        contentPadding: EdgeInsets.all(theme.spacing.md),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(theme.radiusDefault), borderSide: BorderSide(color: theme.colors.border)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(theme.radiusDefault), borderSide: BorderSide(color: theme.colors.primary, width: AuthDesignTokens.focusWidth)),
        suffixIcon: widget.password ? IconButton(
          tooltip: _copy(context, revealed ? 'hide_password' : 'show_password'),
          onPressed: widget.enabled ? () => setState(() => revealed = !revealed) : null,
          icon: Icon(revealed ? Icons.visibility_off_outlined : Icons.visibility_outlined),
        ) : null,
      ),
    ));
  }
}
