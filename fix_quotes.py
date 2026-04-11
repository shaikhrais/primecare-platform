import glob, os

files = [
    r'packages\flutter_ui\lib\src\screens\offices\franchise\operations_manager_dashboard\sections\operations_manager_kpi_section.dart',
    r'packages\flutter_ui\lib\src\screens\offices\franchise\owner_dashboard\sections\owner_kpi_section.dart',
    r'packages\flutter_ui\lib\src\screens\offices\franchise\scheduler_dashboard\sections\scheduler_kpi_section.dart',
    r'packages\flutter_ui\lib\src\screens\offices\franchise\scheduler_dashboard.dart',
    r'packages\flutter_ui\lib\src\screens\stitch_generated\franchise_sales_manager_dashboard_screen_stitch.dart',
    r'packages\flutter_ui\lib\src\screens\stitch_generated\territory_expansion_manager_dashboard_screen_stitch.dart',
    r'packages\flutter_ui\lib\src\screens\stitch_generated\territory_sales_manager_dashboard_screen_stitch.dart'
]

for filepath in files:
    if os.path.exists(filepath):
        print(f"Fixing {filepath}")
        with open(filepath, 'r') as f:
            c = f.read()
        
        c = c.replace(r"\'\'", "''")
        
        with open(filepath, 'w') as f:
            f.write(c)

print('Fixed backslash quotes.')
