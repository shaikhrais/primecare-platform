# Data-cy/tag generator utility
def generate_datacy_tag(screen_name, element_name):
    return f"data-cy={screen_name.lower()}-{element_name.lower()}"
