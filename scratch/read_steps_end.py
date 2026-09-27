import json

log_path = r"C:\Users\Admin2\.gemini\antigravity-ide\brain\f9e36ad0-4598-4416-b579-3b01db8954f7\.system_generated\logs\transcript.jsonl"

with open(log_path, 'r', encoding='utf-8') as f:
    for line in f:
        try:
            data = json.loads(line)
            idx = data.get('step_index')
            if idx is not None and idx >= 360:
                print(f"=== Step {idx} ({data.get('source')}, {data.get('type')}) ===")
                if data.get('type') == 'USER_INPUT':
                    print(data.get('content'))
                elif data.get('type') == 'PLANNER_RESPONSE':
                    print(data.get('content')[:500] + "...")
                elif data.get('tool_calls'):
                    print(f"Tool calls: {[tc['name'] for tc in data['tool_calls']]}")
                print("-" * 50)
        except Exception as e:
            pass
