import glob, os, re

files = glob.glob('packages/flutter_ui/lib/src/screens/stitch_generated/*.dart')

for path in files:
    with open(path, 'r') as f:
        c = f.read()

    # Activities
    c = re.sub(r'activity\.title(?!\s*\?\?)', r"activity.title ?? ''", c)
    c = re.sub(r'activity\.subtitle(?!\s*\?\?)', r"activity.subtitle ?? ''", c)
    c = re.sub(r'activity\.timestamp(?!\s*\?\?)', r"activity.timestamp ?? ''", c)

    # KPIs
    c = re.sub(r'kpi\.title(?!\s*\?\?)', r"kpi.title ?? ''", c)
    c = re.sub(r'kpi\.value(?!\s*\?\?)', r"kpi.value ?? ''", c)
    c = re.sub(r'kpi\.trend(?!\s*\?\?)', r"kpi.trend ?? ''", c)
    c = re.sub(r'kpi\.status(?!\s*\?\?)', r"kpi.status ?? ''", c)
    
    # metrics
    c = re.sub(r'metric\.title(?!\s*\?\?)', r"metric.title ?? ''", c)
    c = re.sub(r'metric\.value(?!\s*\?\?)', r"metric.value ?? ''", c)
    c = re.sub(r'metric\.trend(?!\s*\?\?)', r"metric.trend ?? ''", c)
    c = re.sub(r'metric\.status(?!\s*\?\?)', r"metric.status ?? ''", c)

    with open(path, 'w') as f:
        f.write(c)

print('Done stitch generated patches.')
