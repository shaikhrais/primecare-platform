import 'dart:ui';
import 'package:primecare_ui/primecare_ui.dart';

/// The omnipresent platform command center drawer, offering glassmorphic real-time controls,
/// compliance auto-patchers, and simulated ChatGPT messenger pipelines.
class AuraNexusConsoleDrawer extends ConsumerStatefulWidget {
  final String activeScreenId;

  const AuraNexusConsoleDrawer({
    super.key,
    required this.activeScreenId,
  });

  @override
  ConsumerState<AuraNexusConsoleDrawer> createState() => _AuraNexusConsoleDrawerState();
}

class _AuraNexusConsoleDrawerState extends ConsumerState<AuraNexusConsoleDrawer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _messageInputController = TextEditingController();
  final ScrollController _chatScrollController = ScrollController();
  bool _isPatching = false;
  double _integrityScore = 84.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _messageInputController.dispose();
    _chatScrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_chatScrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _chatScrollController.animateTo(
          _chatScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final messageState = ref.watch(platformMessagingProvider);
    final messageNotifier = ref.read(platformMessagingProvider.notifier);

    // Dynamic color indicator based on integrity
    final integrityColor = _integrityScore >= 95.0
        ? theme.colors.success
        : (_integrityScore >= 80.0 ? const Color(0xFFF59E0B) : theme.colors.error);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Drawer(
          backgroundColor: theme.colors.surface.withValues(alpha: 0.85),
          width: context.s(450), // Premium wider drawer space
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: theme.colors.primary.withValues(alpha: 0.2),
                  width: context.s(2),
                ),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colors.surface.withValues(alpha: 0.9),
                  theme.colors.surfaceContainerLow.withValues(alpha: 0.8),
                ],
              ),
            ),
            child: Column(
              children: [
                _buildHeader(theme, messageState),
                _buildTabBar(theme),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildChatTab(theme, messageState, messageNotifier),
                      _buildTelemetryTab(theme, messageState),
                      _buildIntegrityTab(theme, integrityColor, messageNotifier),
                      _buildRoleSwitcherTab(theme, messageState, messageNotifier),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(PrimeThemeData theme, PlatformMessagingState state) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        context.s(24),
        context.s(48),
        context.s(24),
        context.s(16),
      ),
      color: theme.colors.primary.withValues(alpha: 0.05),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(context.s(8)),
            decoration: BoxDecoration(
              color: theme.colors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              LucideIcons.pocket,
              color: theme.colors.primary,
              size: context.s(28),
            ),
          ),
          SizedBox(width: context.s(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aura Nexus Console',
                  style: theme.typography.h3.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  'Active Screen: ${widget.activeScreenId}',
                  style: theme.typography.bodySmall.copyWith(
                    color: theme.colors.onSurfaceVariant,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(PrimeThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colors.surfaceContainerLow,
        border: Border(bottom: BorderSide(color: theme.colors.divider)),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: theme.colors.primary,
        unselectedLabelColor: theme.colors.onSurfaceVariant,
        indicatorColor: theme.colors.primary,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(icon: Icon(LucideIcons.messageSquare, size: context.s(20))),
          Tab(icon: Icon(LucideIcons.activity, size: context.s(20))),
          Tab(icon: Icon(LucideIcons.shieldCheck, size: context.s(20))),
          Tab(icon: Icon(LucideIcons.userCheck, size: context.s(20))),
        ],
      ),
    );
  }

  Widget _buildChatTab(
    PrimeThemeData theme,
    PlatformMessagingState state,
    PlatformMessagingNotifier notifier,
  ) {
    final activeThread = state.activeThread;
    _scrollToBottom();

    return Column(
      children: [
        // Thread selector header
        Container(
          height: context.s(60),
          padding: EdgeInsets.symmetric(horizontal: context.s(8)),
          decoration: BoxDecoration(
            color: theme.colors.surfaceContainerLowest,
            border: Border(bottom: BorderSide(color: theme.colors.divider)),
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: state.threads.map((thread) {
              final isSelected = thread.id == state.activeThreadId;
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.s(6),
                  vertical: context.s(10),
                ),
                child: ChoiceChip(
                  label: Text(
                    thread.title.split(' ').last,
                    style: theme.typography.bodySmall.copyWith(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? theme.colors.primary : theme.colors.onSurface,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: theme.colors.primary.withValues(alpha: 0.1),
                  backgroundColor: Colors.transparent,
                  onSelected: (val) {
                    if (val) notifier.selectThread(thread.id);
                  },
                ),
              );
            }).toList(),
          ),
        ),

        // Message board area
        Expanded(
          child: Container(
            color: Colors.transparent,
            child: ListView.builder(
              controller: _chatScrollController,
              padding: EdgeInsets.all(context.s(16)),
              itemCount: activeThread.messages.length + (state.isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == activeThread.messages.length) {
                  return _buildTypingIndicator(theme);
                }

                final msg = activeThread.messages[index];
                final isMe = msg.sender == 'You';

                return Padding(
                  padding: EdgeInsets.only(bottom: context.s(12)),
                  child: Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment:
                          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              msg.sender,
                              style: theme.typography.bodySmall.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: context.s(11),
                              ),
                            ),
                            SizedBox(width: context.s(4)),
                            Text(
                              '[${msg.senderRole}]',
                              style: theme.typography.bodySmall.copyWith(
                                color: theme.colors.onSurfaceVariant,
                                fontSize: context.s(10),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.s(4)),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.s(14),
                            vertical: context.s(10),
                          ),
                          constraints: BoxConstraints(maxWidth: context.s(320)),
                          decoration: BoxDecoration(
                            color: isMe
                                ? theme.colors.primary
                                : (msg.isBot
                                    ? theme.colors.primary.withValues(alpha: 0.05)
                                    : theme.colors.surfaceContainerLowest),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(context.s(12)),
                              topRight: Radius.circular(context.s(12)),
                              bottomLeft: isMe
                                  ? Radius.circular(context.s(12))
                                  : Radius.circular(context.s(0)),
                              bottomRight: isMe
                                  ? Radius.circular(context.s(0))
                                  : Radius.circular(context.s(12)),
                            ),
                            border: isMe
                                ? null
                                : Border.all(
                                    color: msg.isBot
                                        ? theme.colors.primary.withValues(alpha: 0.2)
                                        : theme.colors.divider,
                                  ),
                          ),
                          child: Text(
                            msg.content,
                            style: theme.typography.bodyMedium.copyWith(
                              color: isMe ? Colors.white : theme.colors.onSurface,
                              fontSize: context.s(13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Dynamic typing area input
        Container(
          padding: EdgeInsets.all(context.s(12)),
          decoration: BoxDecoration(
            color: theme.colors.surfaceContainerLowest,
            border: Border(top: BorderSide(color: theme.colors.divider)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageInputController,
                  decoration: InputDecoration(
                    hintText: 'Type query (e.g. schedule nurse, emergency)...',
                    hintStyle: theme.typography.bodyMedium.copyWith(
                      color: theme.colors.onSurfaceVariant.withValues(alpha: 0.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(context.s(20)),
                      borderSide: BorderSide(color: theme.colors.divider),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: context.s(16),
                      vertical: context.s(8),
                    ),
                  ),
                  onSubmitted: (val) {
                    notifier.sendMessage(val);
                    _messageInputController.clear();
                  },
                ),
              ),
              SizedBox(width: context.s(8)),
              IconButton(
                icon: Icon(LucideIcons.send, color: theme.colors.primary),
                onPressed: () {
                  notifier.sendMessage(_messageInputController.text);
                  _messageInputController.clear();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTypingIndicator(PrimeThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.s(12),
          vertical: context.s(8),
        ),
        margin: EdgeInsets.only(bottom: context.s(12)),
        decoration: BoxDecoration(
          color: theme.colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(context.s(12)),
          border: Border.all(color: theme.colors.divider),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ResponseBot is generating reply...',
              style: theme.typography.bodySmall.copyWith(
                fontStyle: FontStyle.italic,
                color: theme.colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTelemetryTab(PrimeThemeData theme, PlatformMessagingState state) {
    return Padding(
      padding: EdgeInsets.all(context.s(16.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Real-time Metrics', style: theme.typography.h3),
          SizedBox(height: context.s(12)),
          
          // Mini Telemetry Graph Simulator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTelemetryCard(theme, 'API Uptime', '99.99%', LucideIcons.globe),
              _buildTelemetryCard(theme, 'Latency Avg', '18ms', LucideIcons.clock),
              _buildTelemetryCard(theme, 'Cache Hits', '92.4%', LucideIcons.database),
            ],
          ),
          
          SizedBox(height: context.s(20)),
          Text('Live Audit Engine Output', style: theme.typography.h3),
          SizedBox(height: context.s(8)),
          
          Expanded(
            child: Container(
              padding: EdgeInsets.all(context.s(12)),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(context.s(8)),
                border: Border.all(color: theme.colors.primary.withValues(alpha: 0.3)),
              ),
              child: ListView.builder(
                itemCount: state.telemetryLogs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: context.s(6)),
                    child: Text(
                      state.telemetryLogs[index],
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontSize: context.s(11),
                        color: Colors.greenAccent,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTelemetryCard(
    PrimeThemeData theme,
    String title,
    String val,
    IconData icon,
  ) {
    return Container(
      width: context.s(130),
      padding: EdgeInsets.all(context.s(12)),
      decoration: BoxDecoration(
        color: theme.colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(context.s(8)),
        border: Border.all(color: theme.colors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: context.s(16), color: theme.colors.primary),
          SizedBox(height: context.s(8)),
          Text(val, style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold)),
          Text(title, style: theme.typography.bodySmall.copyWith(fontSize: context.s(9))),
        ],
      ),
    );
  }

  Widget _buildIntegrityTab(
    PrimeThemeData theme,
    Color integrityColor,
    PlatformMessagingNotifier notifier,
  ) {
    return Padding(
      padding: EdgeInsets.all(context.s(24.0)),
      child: Column(
        children: [
          Text('Compliance Scorecard', style: theme.typography.h2),
          SizedBox(height: context.s(24)),
          
          // Integrity radial simulator
          Container(
            height: context.s(180),
            width: context.s(180),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: integrityColor, width: context.s(6)),
              boxShadow: [
                BoxShadow(
                  color: integrityColor.withValues(alpha: 0.15),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_integrityScore.toStringAsFixed(0)}%',
                  style: theme.typography.h1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: integrityColor,
                    fontSize: context.s(36),
                  ),
                ),
                Text(
                  'AST INTEGRITY',
                  style: theme.typography.bodySmall.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          
          SizedBox(height: context.s(24)),
          _integrityScore >= 99.0
              ? Card(
                  color: theme.colors.success.withValues(alpha: 0.05),
                  child: Padding(
                    padding: EdgeInsets.all(context.s(16)),
                    child: Row(
                      children: [
                        Icon(LucideIcons.checkCircle2, color: theme.colors.success),
                        SizedBox(width: context.s(12)),
                        Expanded(
                          child: Text(
                            'Compliance verified. Screen structures comply with all visual standards.',
                            style: theme.typography.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Card(
                  color: const Color(0xFFF59E0B).withValues(alpha: 0.05),
                  child: Padding(
                    padding: EdgeInsets.all(context.s(16)),
                    child: Row(
                      children: [
                        const Icon(LucideIcons.alertTriangle, color: Color(0xFFF59E0B)),
                        SizedBox(width: context.s(12)),
                        Expanded(
                          child: Text(
                            'Warning: Bounding box padding drifts detected on active page layouts.',
                            style: theme.typography.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: context.s(48),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.s(24))),
              ),
              icon: _isPatching
                  ? SizedBox(
                      height: context.s(18),
                      width: context.s(18),
                      child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Icon(LucideIcons.shieldAlert),
              label: Text(_isPatching ? 'Patching Drifts...' : 'Run Autopatch Audit'),
              onPressed: _isPatching
                  ? null
                  : () async {
                      setState(() {
                        _isPatching = true;
                      });
                      await notifier.runAutopatchAudit(widget.activeScreenId);
                      setState(() {
                        _isPatching = false;
                        _integrityScore = 100.0;
                      });
                    },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSwitcherTab(
    PrimeThemeData theme,
    PlatformMessagingState state,
    PlatformMessagingNotifier notifier,
  ) {
    final roles = [
      'Compliance Officer',
      'Operations Manager',
      'Intake Coordinator',
      'CFO Executive',
      'General Specialist',
    ];

    return Padding(
      padding: EdgeInsets.all(context.s(16.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Simulated Role', style: theme.typography.h3),
          SizedBox(height: context.s(8)),
          Text(
            'Simulating a role changes the context and domain metrics analyzed by ChatGPT ResponseBot in real-time.',
            style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
          ),
          SizedBox(height: context.s(16)),
          Expanded(
            child: ListView.builder(
              itemCount: roles.length,
              itemBuilder: (context, index) {
                final role = roles[index];
                final isSelected = state.activeSimulatedRole == role;

                return Padding(
                  padding: EdgeInsets.only(bottom: context.s(8)),
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.s(12))),
                    selectedTileColor: theme.colors.primary.withValues(alpha: 0.1),
                    tileColor: theme.colors.surfaceContainerLow,
                    selected: isSelected,
                    leading: Icon(
                      isSelected ? LucideIcons.checkSquare : LucideIcons.square,
                      color: isSelected ? theme.colors.primary : theme.colors.onSurfaceVariant,
                    ),
                    title: Text(
                      role,
                      style: theme.typography.bodyMedium.copyWith(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      notifier.selectSimulatedRole(role);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
