import glob, os, re

files = glob.glob('packages/flutter_ui/lib/src/screens/stitch_generated/*.dart')

for p in files:
    with open(p, 'r') as f:
        c = f.read()

    # Kpis
    c = c.replace('kpi.title,', "kpi.title ?? '',")
    c = c.replace('kpi.value,', "kpi.value ?? '',")
    c = c.replace('kpi.trend,', "kpi.trend ?? '',")
    c = c.replace('kpi.status,', "kpi.status ?? '',")
    c = c.replace('kpi.title)', "kpi.title ?? '')")
    c = c.replace('kpi.status)', "kpi.status ?? '')")

    # Activity inside Text widget
    c = re.sub(r'Text\(\s*activity\.title,\s*', r"Text(activity.title ?? '',", c)
    c = re.sub(r'Text\(\s*activity\.subtitle,\s*', r"Text(activity.subtitle ?? '',", c)
    c = re.sub(r'Text\(\s*activity\.timestamp,\s*', r"Text(activity.timestamp ?? '',", c)

    with open(p, 'w') as f:
        f.write(c)

print('Done stitch generated patches.')
