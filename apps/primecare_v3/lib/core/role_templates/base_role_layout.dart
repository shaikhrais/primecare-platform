import 'package:flutter/material.dart';
import '../layouts/master_layout.dart';

abstract class BaseRoleLayout extends StatelessWidget {
  const BaseRoleLayout({super.key});

  /// The specific sidebar for this role (e.g. psw_side_bar)
  Widget buildSideBar(BuildContext context);

  /// The specific topbar for this role (e.g. psw_top_bar)
  Widget buildTopBar(BuildContext context);

  /// The main content area injected by the router
  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return MasterLayout(
      sidebar: buildSideBar(context),
      topbar: buildTopBar(context),
      content: buildContent(context),
    );
  }
}
