# SQLite registry writer
def log_verification(conn, file_path, name, vtype, status, issue, fix):
    conn.execute("INSERT INTO code_verification_results (file_path, utility_name, verification_type, status, issue_found, recommended_fix) VALUES (?, ?, ?, ?, ?, ?)", (file_path, name, vtype, status, issue, fix))
