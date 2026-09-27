# Route registry utility
def verify_routes(conn):
    return conn.execute("SELECT screen_id, route_path FROM route_registry").fetchall()
