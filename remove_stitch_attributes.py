import os
import re

directory = 'c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform'

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Regex to remove the fields
    content = re.sub(r'^\s*stitchProject:\s*[\'"].*?[\'"],?\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*stitchUrl:\s*[\'"].*?[\'"],?\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*generationPrompt:\s*[\'"].*?[\'"],?\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*generateScreen:\s*(true|false),?\s*\n', '', content, flags=re.MULTILINE)
    
    # Also remove from constructors
    content = re.sub(r'^\s*this\.stitchProject,?\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*this\.stitchUrl,?\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*this\.generationPrompt,?\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*this\.generateScreen\s*=\s*(true|false),?\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*this\.generateScreen,?\s*\n', '', content, flags=re.MULTILINE)
    
    # Also remove from definitions in screen_metadata.dart
    content = re.sub(r'^\s*(///.*?[\r\n]+)*\s*final String\? stitchProject;\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*(///.*?[\r\n]+)*\s*final String\? stitchUrl;\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*(///.*?[\r\n]+)*\s*final String\? generationPrompt;\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*(///.*?[\r\n]+)*\s*final bool generateScreen;\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*(///.*?[\r\n]+)*\s*final String stitchUrl;\s*\n', '', content, flags=re.MULTILINE)
    
    # Also remove copyWith signature
    content = re.sub(r'^\s*String\? stitchProject,?\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*String\? stitchUrl,?\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*String\? generationPrompt,?\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*bool\? generateScreen,?\s*\n', '', content, flags=re.MULTILINE)
    
    # Also remove copyWith assignments
    content = re.sub(r'^\s*stitchProject:\s*stitchProject\s*\?\?\s*this\.stitchProject,?\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*stitchUrl:\s*stitchUrl\s*\?\?\s*this\.stitchUrl,?\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*generationPrompt:\s*generationPrompt\s*\?\?\s*this\.generationPrompt,?\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*generateScreen:\s*generateScreen\s*\?\?\s*this\.generateScreen,?\s*\n', '', content, flags=re.MULTILINE)
    
    # Also remove any remaining references from screen_work_item.dart
    content = re.sub(r'^\s*@JsonKey\(name: \'generate_screen\'\)\s*\n\s*final bool\? generateScreen;\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*@JsonKey\(name: \'generation_prompt\'\)\s*\n\s*final String\? generationPrompt;\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*@JsonKey\(name: \'stitch_url\'\)\s*\n\s*final String\? stitchUrl;\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*@JsonKey\(name: \'stitch_project\'\)\s*\n\s*final String\? stitchProject;\s*\n', '', content, flags=re.MULTILINE)

    # Remove from Freezed classes if any
    content = re.sub(r'^\s*bool\? generateScreen,?\s*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*String\? generationPrompt,?\s*\n', '', content, flags=re.MULTILINE)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

for root, _, files in os.walk(directory):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            try:
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
                if any(term in content for term in ['generateScreen', 'generationPrompt', 'stitchProject', 'stitchUrl']):
                    process_file(filepath)
                    print(f'Processed {filepath}')
            except:
                pass
