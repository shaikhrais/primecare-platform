import os

files = [
    r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features\features_model.dart',
    r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features\features_controller.dart',
    r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features\features_view.dart'
]

for file_path in files:
    if os.path.exists(file_path):
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Revert various corruptions
        new_content = content.replace('RpnRpnNotifier', 'Notifier')
        new_content = new_content.replace('PhysiotherapistPhysiotherapist', 'Physiotherapist')
        new_content = new_content.replace('RnRn', 'Rn')
        new_content = new_content.replace('RpnRpn', 'Rpn')
        new_content = new_content.replace('SchedulerScheduler', 'Scheduler')
        new_content = new_content.replace('CommonCommon', 'Common')
        
        if new_content != content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"Reverted {file_path}")
        else:
            print(f"No changes for {file_path}")
