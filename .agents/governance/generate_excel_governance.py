import os
import csv
import sys
import sqlite3

# Add local directory to path to import governance_db
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import governance_db

def get_screen_category(route_path):
    parts = route_path.replace('\\', '/').split('/')
    if 'screens' in parts:
        idx = parts.index('screens')
        if idx + 1 < len(parts):
            return parts[idx + 1]
    return 'common'

def generate_reports():
    print("=====================================================")
    print("Generating Ultimate Excel Governance Reports (34 Relational Tables)")
    print("=====================================================")

    repo_gov_dir = os.path.dirname(os.path.abspath(__file__))
    xlsx_out_path = os.path.join(repo_gov_dir, "primecare_governance_audit.xlsx")
    
    conn = governance_db.get_connection()
    cursor = conn.cursor()

    # 1. Summary: Module Breakdown (Processed dynamically)
    categories_stats = {}
    cursor.execute("SELECT id, route_path FROM screens;")
    screens_list = cursor.fetchall()
    for s in screens_list:
        scr_id = s['id']
        path = s['route_path']
        cat = get_screen_category(path).upper()
        
        if cat not in categories_stats:
            categories_stats[cat] = {
                'Module': cat,
                'Total Screens': 0,
                'Action Functions': 0,
                'UI Components': 0
            }
            
        categories_stats[cat]['Total Screens'] += 1
        
        cursor.execute("SELECT COUNT(*) FROM screen_functions WHERE screen_id = ?;", (scr_id,))
        categories_stats[cat]['Action Functions'] += cursor.fetchone()[0] or 0
        
        cursor.execute("SELECT COUNT(*) FROM screen_components WHERE screen_id = ?;", (scr_id,))
        categories_stats[cat]['UI Components'] += cursor.fetchone()[0] or 0
        
    modules_list = list(categories_stats.values())

    # Helper function to fetch all rows from a table
    def fetch_table(table_name):
        cursor.execute(f"SELECT * FROM [{table_name}];")
        rows = cursor.fetchall()
        data = []
        for idx, r in enumerate(rows, 1):
            row_dict = {'S.No.': idx}
            for col in r.keys():
                row_dict[col.replace('_', ' ').title()] = r[col]
            data.append(row_dict)
        return data if data else [{'S.No.': 1, 'Status': 'No Data Available'}]

    # 2. Tab: Orgs Registry
    orgs_data = fetch_table('orgs')

    # 3. Tab: Apps Registry
    apps_data = fetch_table('apps')

    # 4. Tab: Roles Registry
    roles_data = fetch_table('roles')

    # 5. Tab: Screens Registry
    screens_data = fetch_table('screens')

    # 6. Tab: Code Files Catalog
    code_files_data = fetch_table('code_files')

    # 7. Tab: Screen File Links
    screen_file_links_data = fetch_table('screen_file_links')

    # 8. Tab: API Endpoints
    api_endpoints_data = fetch_table('api_endpoints')

    # 9. Tab: Screen API Links
    screen_api_links_data = fetch_table('screen_api_links')

    # 10. Tab: DB Schema Tables
    db_schema_tables_data = fetch_table('db_schema_tables')

    # 11. Tab: DB Schema Columns
    db_schema_columns_data = fetch_table('db_schema_columns')

    # 12. Tab: Screen Components
    screen_components_data = fetch_table('screen_components')

    # 13. Tab: Screen Functions
    screen_functions_data = fetch_table('screen_functions')

    # 14. Tab: Role Screen Permissions
    role_screen_permissions_data = fetch_table('role_screen_permissions')

    # 15. Tab: Role Function Permissions
    role_function_permissions_data = fetch_table('role_function_permissions')

    # 16. Tab: Test Cases Matrix
    test_cases_data = fetch_table('test_cases')

    # 17. Tab: Drift Findings Ledger
    drift_findings_data = fetch_table('drift_findings')

    # 18. Tab: AI Tasks Backlog
    implementation_tasks_data = fetch_table('implementation_tasks')

    # 19. Tab: Governance Snapshots
    governance_snapshots_data = fetch_table('governance_snapshots')

    # 20. Tab: Governance Reports
    governance_reports_data = fetch_table('governance_reports')

    # 21. Tab: Physical Packages
    physical_packages_data = fetch_table('physical_packages')

    # 22. Tab: Logical Apps
    logical_apps_data = fetch_table('logical_apps')

    # 23. Tab: Package Files
    package_files_data = fetch_table('package_files')

    # 24. Tab: Artifact Ownership
    artifact_ownership_data = fetch_table('artifact_ownership')

    # 25. Tab: Router Mounts
    router_mounts_data = fetch_table('router_mounts')

    # 26. Tab: Layout Bindings
    layout_bindings_data = fetch_table('layout_bindings')

    # 27. Tab: Branding Profiles
    branding_profiles_data = fetch_table('branding_profiles')

    # 28. Tab: Environment Configs
    environment_configs_data = fetch_table('environment_configs')

    # 29. Tab: Feature Flags
    feature_flags_data = fetch_table('feature_flags')

    # 30. Tab: Universal Dependencies
    artifact_dependencies_data = fetch_table('artifact_dependencies')

    conn.close()

    # Generate styled Excel workbook using openpyxl & pandas
    try:
        import pandas as pd
        from openpyxl.styles import Font, PatternFill, Alignment, Border, Side
        from openpyxl.utils import get_column_letter
        
        print("Generating beautifully styled Excel workbook using openpyxl and pandas...")
        
        # Load dataframes
        df_summary = pd.DataFrame(modules_list)
        df_orgs = pd.DataFrame(orgs_data)
        df_apps = pd.DataFrame(apps_data)
        df_roles = pd.DataFrame(roles_data)
        df_screens = pd.DataFrame(screens_data)
        df_cf = pd.DataFrame(code_files_data)
        df_sfl = pd.DataFrame(screen_file_links_data)
        df_api = pd.DataFrame(api_endpoints_data)
        df_sal = pd.DataFrame(screen_api_links_data)
        df_dst = pd.DataFrame(db_schema_tables_data)
        df_dsc = pd.DataFrame(db_schema_columns_data)
        df_sc = pd.DataFrame(screen_components_data)
        df_sf = pd.DataFrame(screen_functions_data)
        df_rsp = pd.DataFrame(role_screen_permissions_data)
        df_rfp = pd.DataFrame(role_function_permissions_data)
        df_tc = pd.DataFrame(test_cases_data)
        df_df = pd.DataFrame(drift_findings_data)
        df_it = pd.DataFrame(implementation_tasks_data)
        df_gs = pd.DataFrame(governance_snapshots_data)
        df_gr = pd.DataFrame(governance_reports_data)
        df_pp = pd.DataFrame(physical_packages_data)
        df_la = pd.DataFrame(logical_apps_data)
        df_pf = pd.DataFrame(package_files_data)
        df_ao = pd.DataFrame(artifact_ownership_data)
        df_rm = pd.DataFrame(router_mounts_data)
        df_lb = pd.DataFrame(layout_bindings_data)
        df_bp = pd.DataFrame(branding_profiles_data)
        df_ec = pd.DataFrame(environment_configs_data)
        df_ff = pd.DataFrame(feature_flags_data)
        df_ad = pd.DataFrame(artifact_dependencies_data)
        
        with pd.ExcelWriter(xlsx_out_path, engine='openpyxl') as writer:
            df_summary.to_excel(writer, sheet_name='Module Breakdown', index=False)
            df_orgs.to_excel(writer, sheet_name='Orgs Registry', index=False)
            df_apps.to_excel(writer, sheet_name='Apps Registry', index=False)
            df_roles.to_excel(writer, sheet_name='Roles Registry', index=False)
            df_screens.to_excel(writer, sheet_name='Screens Registry', index=False)
            df_cf.to_excel(writer, sheet_name='Code Files Catalog', index=False)
            df_sfl.to_excel(writer, sheet_name='Screen File Links', index=False)
            df_api.to_excel(writer, sheet_name='API Endpoints', index=False)
            df_sal.to_excel(writer, sheet_name='Screen API Links', index=False)
            df_dst.to_excel(writer, sheet_name='DB Schema Tables', index=False)
            df_dsc.to_excel(writer, sheet_name='DB Schema Columns', index=False)
            df_sc.to_excel(writer, sheet_name='Screen Components', index=False)
            df_sf.to_excel(writer, sheet_name='Screen Functions', index=False)
            df_rsp.to_excel(writer, sheet_name='Role Screen Permissions', index=False)
            df_rfp.to_excel(writer, sheet_name='Role Function Permissions', index=False)
            df_tc.to_excel(writer, sheet_name='Test Cases Matrix', index=False)
            df_df.to_excel(writer, sheet_name='Drift Findings Ledger', index=False)
            df_it.to_excel(writer, sheet_name='AI Tasks Backlog', index=False)
            df_gs.to_excel(writer, sheet_name='Governance Snapshots', index=False)
            df_gr.to_excel(writer, sheet_name='Governance Reports', index=False)
            df_pp.to_excel(writer, sheet_name='Physical Packages', index=False)
            df_la.to_excel(writer, sheet_name='Logical Apps', index=False)
            df_pf.to_excel(writer, sheet_name='Package Files', index=False)
            df_ao.to_excel(writer, sheet_name='Artifact Ownership', index=False)
            df_rm.to_excel(writer, sheet_name='Router Mounts', index=False)
            df_lb.to_excel(writer, sheet_name='Layout Bindings', index=False)
            df_bp.to_excel(writer, sheet_name='Branding Profiles', index=False)
            df_ec.to_excel(writer, sheet_name='Environment Configs', index=False)
            df_ff.to_excel(writer, sheet_name='Feature Flags', index=False)
            df_ad.to_excel(writer, sheet_name='Universal Dependencies', index=False)
            
            # Apply premium styling using openpyxl
            workbook = writer.book
            
            # Styles Definitions
            font_family = "Segoe UI"
            header_font = Font(name=font_family, size=11, bold=True, color="FFFFFF")
            header_fill = PatternFill(start_color="1F497D", end_color="1F497D", fill_type="solid") # Dark steel blue
            zebra_fill = PatternFill(start_color="F2F5F8", end_color="F2F5F8", fill_type="solid") # Light ice blue
            
            cell_font = Font(name=font_family, size=10, color="333333")
            thin_side = Side(border_style="thin", color="D9D9D9")
            cell_border = Border(left=thin_side, right=thin_side, top=thin_side, bottom=thin_side)
            
            left_align = Alignment(horizontal="left", vertical="top", wrap_text=True)
            center_align = Alignment(horizontal="center", vertical="top")
            
            for sheet_name in workbook.sheetnames:
                ws = workbook[sheet_name]
                ws.views.sheetView[0].showGridLines = True # Ensure gridlines stay visible
                
                max_cols = ws.max_column
                max_rows = ws.max_row
                
                # Format Header
                for col in range(1, max_cols + 1):
                    cell = ws.cell(row=1, column=col)
                    cell.font = header_font
                    cell.fill = header_fill
                    cell.alignment = Alignment(horizontal="center", vertical="center", wrap_text=True)
                    cell.border = cell_border
                
                # Row height adjustments
                ws.row_dimensions[1].height = 28
                
                # Format Cells
                for row in range(2, max_rows + 1):
                    ws.row_dimensions[row].height = 20
                    is_even = (row % 2 == 0)
                    
                    for col in range(1, max_cols + 1):
                        cell = ws.cell(row=row, column=col)
                        cell.font = cell_font
                        cell.border = cell_border
                        
                        # Apply zebra striping
                        if is_even:
                            cell.fill = zebra_fill
                        
                        # Handle alignments based on header name
                        header_val = ws.cell(row=1, column=col).value or ""
                        if header_val.strip() in ('S.No.', 'Id', 'Org Id', 'App Id', 'Role Id', 'Screen Id', 'File Id', 'Api Id', 'Table Id', 'Related Screen Id', 'Related Api Id', 'Related File Id', 'Role Level', 'Is Generated', 'Is Primary', 'Is Foreign', 'Is Nullable', 'Auth Required', 'Can View', 'Can Create', 'Can Edit', 'Can Delete', 'Can Export', 'Can Execute', 'Status', 'Implementation Status', 'Priority', 'Severity', 'Created At', 'Last Scanned At', 'Resolved At', 'Completed At'):
                            cell.alignment = center_align
                        else:
                            cell.alignment = left_align
                
                # Auto-fit columns with safety buffer and bounds
                for col in range(1, max_cols + 1):
                    col_letter = get_column_letter(col)
                    max_len = 0
                    
                    for row in range(1, max_rows + 1):
                        val = ws.cell(row=row, column=col).value
                        if val is not None:
                            str_val = str(val)
                            # Truncate JSON/DDL structures for length calculation
                            if len(str_val) > 100:
                                str_val = str_val[:50]
                            max_len = max(max_len, len(str_val))
                    
                    adjusted_width = max(max_len + 3, 12)
                    adjusted_width = min(adjusted_width, 60) # Cap width at 60 characters
                    ws.column_dimensions[col_letter].width = adjusted_width
                    
        print(f"Beautifully styled Excel Workbook created successfully at: {xlsx_out_path}")
    except ImportError as e:
        print(f"Pandas or Openpyxl is missing ({e}). Excel workbook generation skipped.")

if __name__ == "__main__":
    generate_reports()
