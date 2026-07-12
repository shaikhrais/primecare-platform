# Error/loading/empty state checker
def has_resilience_states(file_content):
    return 'loading' in file_content.lower() and 'error' in file_content.lower()
