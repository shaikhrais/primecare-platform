import glob, os, re

# 1. business_development
p1 = r'packages\flutter_ui\lib\src\screens\offices\business_development\franchise_sales_manager_dashboard\sections\franchise_sales_manager_kpi_section.dart'
if os.path.exists(p1):
    with open(p1, 'r') as f:
        c = f.read()

    c = c.replace('kpi.title,', "kpi.title ?? '',")
    c = c.replace('kpi.value,', "kpi.value ?? '',")
    c = c.replace('kpi.trend,', "kpi.trend ?? '',")
    c = c.replace('kpi.title)', "kpi.title ?? '')")
    c = c.replace('kpi.status)', "kpi.status ?? '')")

    with open(p1, 'w') as f:
        f.write(c)

# 2. common
p2 = r'packages\flutter_ui\lib\src\screens\offices\common\franchise_owner_dashboard\sections\franchise_owner_kpi_section.dart'
if os.path.exists(p2):
    with open(p2, 'r') as f:
        c = f.read()

    c = c.replace('kpi.label', 'kpi.title')
    with open(p2, 'w') as f:
        f.write(c)
