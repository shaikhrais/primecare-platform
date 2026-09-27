# Form validation utility
def validate_required_field(value):
    return value is not None and len(str(value).strip()) > 0
