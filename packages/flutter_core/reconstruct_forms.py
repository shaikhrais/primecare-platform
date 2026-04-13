import os
import re
import glob

def reconstruct_form_view_models():
    # Find all DTOs just in case we need fields
    base_dir = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\lib\features"
    form_view_models = glob.glob(os.path.join(base_dir, "*_forms", "domain", "models", "*_form_view_model.dart"))
    
    for vm_path in form_view_models:
        # e.g. submit_exit_interview_form_view_model.dart
        filename = os.path.basename(vm_path)
        base_name = filename.replace("_view_model.dart", "")
        
        # e.g. submit_exit_interview_form_dto.dart
        dto_filename = f"{base_name}_dto.dart"
        dir_name = os.path.dirname(os.path.dirname(os.path.dirname(vm_path)))
        dto_path = os.path.join(dir_name, "data", "dtos", dto_filename)
        
        class_name = "".join(word.capitalize() for word in filename.replace(".dart", "").split("_"))
        
        fields = []
        if os.path.exists(dto_path):
            with open(dto_path, "r", encoding="utf-8") as f:
                content = f.read()
                # find fields: final Type? name;
                matches = re.findall(r"final\s+([\w\<\>]+)\??\s+(\w+);", content)
                for match in matches:
                    fields.append((match[0], match[1]))
                    
        # Generate generic ViewModel content with dynamic fields
        vm_content = f"class {class_name} {{\n"
        vm_content += "  final bool isLoading;\n"
        vm_content += "  final bool isSuccess;\n"
        vm_content += "  final Map<String, dynamic> data;\n"
        vm_content += "  final String? error;\n"
        
        for ptype, pname in fields:
            vm_content += f"  final {ptype}? {pname};\n"
            
        vm_content += f"\n  {class_name}({{\n"
        vm_content += "    this.isLoading = false,\n"
        vm_content += "    this.isSuccess = false,\n"
        vm_content += "    this.data = const {},\n"
        vm_content += "    this.error,\n"
        for ptype, pname in fields:
            vm_content += f"    this.{pname},\n"
        vm_content += "  });\n"
        
        vm_content += f"\n  {class_name} copyWith({{\n"
        vm_content += "    bool? isLoading,\n"
        vm_content += "    bool? isSuccess,\n"
        vm_content += "    Map<String, dynamic>? data,\n"
        vm_content += "    String? error,\n"
        for ptype, pname in fields:
            vm_content += f"    {ptype}? {pname},\n"
        vm_content += "  }) {\n"
        
        vm_content += f"    return {class_name}(\n"
        vm_content += "      isLoading: isLoading ?? this.isLoading,\n"
        vm_content += "      isSuccess: isSuccess ?? this.isSuccess,\n"
        vm_content += "      data: data ?? this.data,\n"
        vm_content += "      error: error ?? this.error,\n"
        for ptype, pname in fields:
            vm_content += f"      {pname}: {pname} ?? this.{pname},\n"
        vm_content += "    );\n"
        
        vm_content += "  }\n}\n"
        
        with open(vm_path, "w", encoding="utf-8") as f:
            f.write(vm_content)
        print(f"Restored: {class_name}")

if __name__ == "__main__":
    reconstruct_form_view_models()
