# Screen registry utility
def get_screens(conn):
    return conn.execute("SELECT id, screen_name, actual_file_path FROM screens").fetchall()
