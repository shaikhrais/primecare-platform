"""Derive an isolated matrix fixture from the maintained Theme Center test.
Only generated runner/scratch files change; no runtime or registration is added.
"""
from pathlib import Path
import sys
ROOT=Path(__file__).resolve().parents[2]
source=(ROOT/'packages/flutter_core/test/screenshots/theme_center_capture_test.dart').read_text()
replacements={
 "  for(final view in": "  for(final family in ['1','2','3']){\n  for(final view in",
 'layoutStyle:LayoutStyle.verticalLeft,presetName:': "layoutStyle:family=='1'?LayoutStyle.verticalLeft:LayoutStyle.horizontal,presetName:",
 "'navigationWidth':248,'footer':'sticky'": "'navigationWidth':248,'footer':'sticky','navigation':family=='1'?'left':'top','scroll':family=='3'?'content':'page','toolbar':family=='1'?'top':'belowNavigation','toolbarStyle':family=='1'?'sticky':'static'",
 "final suffix=mode=='dark'?'-dark':'';": "final suffix='-layout$family'+(mode=='dark'?'-dark':'');",
 "${view.$1} $mode": "layout$family ${view.$1} $mode",
 "'device':view.$1,'mode':mode": "'layout':'layout$family','device':view.$1,'mode':mode",
 'primecare-metrics-${view.$1}-$mode': 'primecare-metrics-layout$family-${view.$1}-$mode',
 'primecare-editor-$mode': 'primecare-editor-layout$family-$mode',
}
for old,new in replacements.items():
 if source.count(old)!=1:raise ValueError('Capture fixture source changed: '+old)
 source=source.replace(old,new)
index=source.rfind('\n}')
source=source[:index]+'\n  }'+source[index:]
source='// GENERATED isolated layout matrix; base fixture remains the authoring source.\n'+source
output=Path(sys.argv[1]);output.parent.mkdir(parents=True,exist_ok=True);output.write_text(source)
print('Prepared 18 native layout/device/mode cases and 42 image captures')
