import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/login_header_section.dart';
import 'sections/login_filter_bar_section.dart';
import 'sections/login_data_table_section.dart';
import 'sections/login_pagination_section.dart';
import 'sections/login_action_bar_section.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'login',
      title: 'Login',
      child: Column(
        children: const [
          const LoginHeaderSection(),
          const LoginFilterBarSection(),
          const LoginDataTableSection(),
          const LoginPaginationSection(),
          const LoginActionBarSection(),
        ],
      ),
    );
  }
}
