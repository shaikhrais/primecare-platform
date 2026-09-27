import os
import re

cfo_files = {
    33: ("CfoDashboardScreen", "packages/primecare_ui/lib/src/features/generated_screens/cfo_dashboard.dart"),
    153: ("CfoAnalyticsScreen", "packages/primecare_ui/lib/src/screens/executive/cfo_analytics_screen.dart"),
    155: ("CfoWorkflowScreen", "packages/primecare_ui/lib/src/screens/executive/cfo_workflow_screen.dart"),
    283: ("CfoRevenueScreen", "packages/primecare_ui/lib/src/screens/executive/cfo_revenue_screen.dart"),
    284: ("CfoExpensesScreen", "packages/primecare_ui/lib/src/screens/executive/cfo_expenses_screen.dart"),
    285: ("CfoPayrollScreen", "packages/primecare_ui/lib/src/screens/executive/cfo_payroll_screen.dart"),
    286: ("CfoInvoicesScreen", "packages/primecare_ui/lib/src/screens/executive/cfo_invoices_screen.dart"),
    287: ("CfoTaxScreen", "packages/primecare_ui/lib/src/screens/executive/cfo_tax_screen.dart"),
    288: ("CfoProfitabilityScreen", "packages/primecare_ui/lib/src/screens/executive/cfo_profitability_screen.dart"),
    289: ("CfoCashflowScreen", "packages/primecare_ui/lib/src/screens/executive/cfo_cashflow_screen.dart"),
    475: ("FinancialDashboardScreen", "packages/primecare_ui/lib/src/screens/executive/financial_dashboard_screen.dart"),
    715: ("Cfo Accounts Payable", "apps/primecare_corporate/lib/features/generated_screens/cfo_accounts_payable_screen.dart"),
    716: ("Cfo Accounts Receivable", "apps/primecare_corporate/lib/features/generated_screens/cfo_accounts_receivable_screen.dart"),
    717: ("Cfo Financial Overview", "apps/primecare_corporate/lib/features/generated_screens/cfo_financial_overview_screen.dart"),
    718: ("Cfo Franchise Financials", "apps/primecare_corporate/lib/features/generated_screens/cfo_franchise_financials_screen.dart"),
    719: ("Cfo Reports", "apps/primecare_corporate/lib/features/generated_screens/cfo_reports_screen.dart"),
    720: ("Cfo Tax And Remittance", "apps/primecare_corporate/lib/features/generated_screens/cfo_tax_and_remittance_screen.dart"),
}

project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

def inspect_cfo_code():
    for sid, (name, rel_path) in cfo_files.items():
        full_path = os.path.join(project_root, rel_path.replace("/", os.sep))
        print(f"==================================================")
        print(f"SCREEN: {name} (ID: {sid})")
        print(f"File: {rel_path}")
        if not os.path.exists(full_path):
            print("FILE DOES NOT EXIST")
            continue
        
        with open(full_path, "r", encoding="utf-8") as f:
            code = f.read()
        
        # Check basic properties
        has_data_table = "DataTable" in code or "Table(" in code or "DataRow" in code or "DataCell" in code
        has_text_field = "TextField" in code or "TextFormField" in code
        has_dropdown = "DropdownButton" in code or "DropdownButtonFormField" in code
        has_api_call = "apiClient" in code or "http" in code or "fetch" in code
        has_save_action = "save" in code.lower() or "submit" in code.lower() or "update" in code.lower()
        has_approve = "approve" in code.lower() or "confirm" in code.lower()
        has_export = "export" in code.lower() or "download" in code.lower() or "csv" in code.lower() or "pdf" in code.lower()
        
        print(f"  Has DataTable/Table: {has_data_table}")
        print(f"  Has TextField/TextFormField: {has_text_field}")
        print(f"  Has DropdownButton: {has_dropdown}")
        print(f"  Has API Client/http: {has_api_call}")
        print(f"  Has Save/Submit/Update: {has_save_action}")
        print(f"  Has Approve/Confirm: {has_approve}")
        print(f"  Has Export/Download: {has_export}")
        
        # Print first few matches of UI widgets or text to see context
        print("  Context:")
        lines = code.split("\n")
        for i, l in enumerate(lines):
            if "DataTable" in l or "ElevatedButton" in l or "TextField" in l or "runComplianceScan" in l:
                print(f"    Line {i+1}: {l.strip()}")
        print()

if __name__ == "__main__":
    inspect_cfo_code()
