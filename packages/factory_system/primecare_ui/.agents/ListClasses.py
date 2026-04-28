with open(r'lib\src\features\features_model.dart', 'r', encoding='utf-8') as f:
    lines = f.readlines()
    count = 0
    for line in lines:
        if line.startswith('class '):
            print(line.strip())
            count += 1
            if count > 100:
                break
