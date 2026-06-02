import shutil
import os

src_dir = r'C:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_clinic\assets\translations'
dest_dir = r'C:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_clinic\build\web\assets\assets\translations'
dest_dir_alt = r'C:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_clinic\build\web\assets\translations'

for d in [dest_dir, dest_dir_alt]:
    if os.path.exists(d):
        for f in os.listdir(src_dir):
            if f.endswith('.json'):
                src_file = os.path.join(src_dir, f)
                dest_file = os.path.join(d, f)
                shutil.copy2(src_file, dest_file)
                print(f"Copied {f} to {d}")
