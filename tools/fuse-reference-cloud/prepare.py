"""Extract the supplied reference into a temporary runner, never a runtime dependency."""
import io,json,sys,zipfile
from pathlib import Path
root=Path(__file__).resolve().parents[2];target=Path(sys.argv[1]).resolve();target.mkdir(parents=True,exist_ok=True)
archive=root/'themeforest-LJbUsLYa-fuse-react-react-redux-material-design-admin-template.zip'
with zipfile.ZipFile(archive) as outer:
 with zipfile.ZipFile(io.BytesIO(outer.read('Fuse-React-v17.0.0-vitejs-skeleton.zip'))) as inner:
  for item in inner.infolist():
   dest=(target/item.filename).resolve()
   if not dest.is_relative_to(target):raise ValueError('Unsafe archive path')
  inner.extractall(target)
for source,name in [('host.tsx','src/cloud-reference.tsx'),('user-fixture.ts','src/cloud-user-fixture.ts'),('vite-reference.mts','vite-reference.mts')]:
 (target/name).write_bytes((root/'tools/fuse-reference-cloud'/source).read_bytes())
p=target/'index.html';p.write_text(p.read_text().replace('/src/index.tsx','/src/cloud-reference.tsx'))
print('Extracted original Vite skeleton; only entry host and local user fixture are supplied. Original settings/style components unchanged.')
