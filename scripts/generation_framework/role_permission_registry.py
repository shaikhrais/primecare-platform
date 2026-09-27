# Role-permission registry utility
def get_role_permissions(conn, role_id):
    return conn.execute("SELECT role_name, permission_code FROM role_permission_registry WHERE role_id=?", (role_id,)).fetchall()
