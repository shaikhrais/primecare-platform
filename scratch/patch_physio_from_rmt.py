import os

rmt_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\primecare_ui\lib\src\screens\allied\rmt_treatment_notes_screen.dart"
physio_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\primecare_ui\lib\src\screens\allied\physiotherapist_assessment_screen.dart"

with open(rmt_path, 'r', encoding='utf-8') as f:
    rmt_content = f.read()

# Extract RmtTreatmentNotesScreen class definition
start_token = "class RmtTreatmentNotesScreen extends GovernedConsumerWidget {"
start_idx = rmt_content.find(start_token)
if start_idx == -1:
    print("Error: Could not find start of RmtTreatmentNotesScreen!")
    exit(1)

rmt_class_code = rmt_content[start_idx:]

# Translate it to PhysiotherapistAssessmentScreen
physio_class_code = rmt_class_code
physio_class_code = physio_class_code.replace("RmtTreatmentNotesScreen", "PhysiotherapistAssessmentScreen")
physio_class_code = physio_class_code.replace("rmtTreatmentNotesProvider", "physiotherapistAssessmentProvider")
physio_class_code = physio_class_code.replace("rmttreatmentnotes-screen", "physiotherapistassessment-screen")
physio_class_code = physio_class_code.replace("rmttreatmentnotes-title", "physiotherapistassessment-title")
physio_class_code = physio_class_code.replace("rmttreatmentnotes-btn-1", "physiotherapistassessment-btn-1")
physio_class_code = physio_class_code.replace("rmttreatmentnotes-btn-2", "physiotherapistassessment-btn-2")
physio_class_code = physio_class_code.replace("rmttreatmentnotes-btn-3", "physiotherapistassessment-btn-3")
physio_class_code = physio_class_code.replace("rmttreatmentnotes-content", "physiotherapistassessment-content")
physio_class_code = physio_class_code.replace("rmttreatmentnotes-loading", "physiotherapistassessment-loading")
physio_class_code = physio_class_code.replace("treatmentnotes-screen", "assessment-screen")
physio_class_code = physio_class_code.replace("treatmentnotes-title", "assessment-title")
physio_class_code = physio_class_code.replace("treatmentnotes-content", "assessment-content")

# Now read the physiotherapist_assessment_screen.dart file
with open(physio_path, 'r', encoding='utf-8') as f:
    physio_content = f.read()

# Find the start of class PhysiotherapistAssessmentScreen in the current file
physio_start_token = "class PhysiotherapistAssessmentScreen extends GovernedConsumerWidget {"
physio_start_idx = physio_content.find(physio_start_token)
if physio_start_idx == -1:
    print("Error: Could not find start of PhysiotherapistAssessmentScreen in target file!")
    exit(1)

# Overwrite everything from the start of the class to the end of the file
new_physio_content = physio_content[:physio_start_idx] + physio_class_code

with open(physio_path, 'w', encoding='utf-8') as f:
    f.write(new_physio_content)

print("[+] Successfully patched physiotherapist_assessment_screen.dart from rmt_treatment_notes_screen.dart!")
