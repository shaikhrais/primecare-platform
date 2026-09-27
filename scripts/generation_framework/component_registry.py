# Component registry utility
def get_components(conn, screen_id):
    return conn.execute("SELECT id, component_name, data_cy FROM component_test_registry WHERE screen_id=?", (screen_id,)).fetchall()
