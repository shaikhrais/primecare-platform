import json

log_path = r"C:\Users\Admin2\.gemini\antigravity-ide\brain\f9e36ad0-4598-4416-b579-3b01db8954f7\.system_generated\logs\transcript.jsonl"

with open(log_path, 'r', encoding='utf-8') as f:
    for line in f:
        try:
            data = json.loads(line)
            if data.get('type') == 'USER_INPUT':
                print(f"=== Step {data.get('step_index')} ===")
                print(data.get('content'))
                print("-" * 50)
        except Exception as e:
            pass
