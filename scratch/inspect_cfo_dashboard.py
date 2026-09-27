import os

project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
rel_path = "packages/primecare_ui/lib/src/features/generated_screens/cfo_dashboard.dart"
full_path = os.path.join(project_root, rel_path.replace("/", os.sep))

with open(full_path, "r", encoding="utf-8") as f:
    code = f.read()

has_data_table = "DataTable" in code or "Table(" in code or "DataRow" in code or "DataCell" in code
has_text_field = "TextField" in code or "TextFormField" in code
has_dropdown = "DropdownButton" in code or "DropdownButtonFormField" in code
has_api_call = "apiClient" in code or "http" in code or "fetch" in code
has_save_action = "save" in code.lower() or "submit" in code.lower() or "update" in code.lower()
has_approve = "approve" in code.lower() or "confirm" in code.lower()
has_export = "export" in code.lower() or "download" in code.lower() or "csv" in code.lower() or "pdf" in code.lower()

print(f"CfoDashboardScreen:")
print(f"  Has DataTable/Table: {has_data_table}")
print(f"  Has TextField/TextFormField: {has_text_field}")
print(f"  Has DropdownButton: {has_dropdown}")
print(f"  Has API Client/http: {has_api_call}")
print(f"  Has Save/Submit/Update: {has_save_action}")
print(f"  Has Approve/Confirm: {has_approve}")
print(f"  Has Export/Download: {has_export}")
