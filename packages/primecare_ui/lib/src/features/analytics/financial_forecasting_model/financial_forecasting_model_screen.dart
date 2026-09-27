import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/financial_forecasting_model_header_section.dart';
import 'sections/financial_forecasting_model_content_summary_section.dart';
import 'sections/financial_forecasting_model_primary_content_section.dart';
import 'sections/financial_forecasting_model_action_bar_section.dart';

class FinancialForecastingModelScreen extends StatelessWidget {
  const FinancialForecastingModelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'financial_forecasting_model',
      title: 'Financial Forecasting Model',
      child: Column(
        children: const [
          const FinancialForecastingModelHeaderSection(),
          const FinancialForecastingModelContentSummarySection(),
          const FinancialForecastingModelPrimaryContentSection(),
          const FinancialForecastingModelActionBarSection(),
        ],
      ),
    );
  }
}
