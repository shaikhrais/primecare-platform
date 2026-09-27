# Business-capability registry utility
def get_capabilities(conn):
    return conn.execute("SELECT capability_code, capability_name FROM business_capability_registry").fetchall()
