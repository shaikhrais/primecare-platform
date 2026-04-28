import re

with open('lib/src/shared/src/telemetry_service.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace(
    "enum ExecutionGateCategory {\n  auth,\n",
    "enum ExecutionGateCategory {\n  auth,\n  compliance,\n"
)

with open('lib/src/shared/src/telemetry_service.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print("Added compliance to ExecutionGateCategory")
