# Placeholder/mock data detector
def has_mock_data(file_content):
    return 'mock' in file_content.lower() or 'placeholder' in file_content.lower()
