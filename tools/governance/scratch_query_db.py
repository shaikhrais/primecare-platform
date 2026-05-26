import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    print("--- SLOW / UNOPTIMIZED APIs (from view) ---")
    cursor.execute("""
        SELECT id, route_path, db_query_time_ms, possible_n_plus_one, optimization_status, prisma_model_names, query_pattern, uses_pagination, uses_select, uses_include
        FROM api_endpoints
        WHERE id IN (SELECT api_id FROM v_slow_api_index_recommendations)
    """)
    rows = cursor.fetchall()
    print("Count:", len(rows))
    for r in rows:
        print(f"ID: {r['id']} | Route: {r['route_path']} | time_ms: {r['db_query_time_ms']} | N+1: {r['possible_n_plus_one']} | status: {r['optimization_status']} | models: {r['prisma_model_names']} | pattern: {r['query_pattern']} | pagination: {r['uses_pagination']} | select: {r['uses_select']} | include: {r['uses_include']}")
    
    print("\n--- INDEX RECOMMENDATIONS STATUS ---")
    cursor.execute("SELECT recommendation_status, count(*) as count FROM db_index_recommendations GROUP BY recommendation_status")
    for r in cursor.fetchall():
        print(f"Status: {r['recommendation_status']} | Count: {r['count']}")
        
    print("\n--- GOVERNANCE FUNCTIONS RUN ORDER STATUS ---")
    cursor.execute("SELECT id, function_code, last_run_status, run_order FROM governance_functions ORDER BY run_order")
    for r in cursor.fetchall():
        print(f"ID: {r['id']} | Code: {r['function_code']} | Status: {r['last_run_status']} | Order: {r['run_order']}")

    print("\n--- PENDING IN QUEUE VIEW ---")
    cursor.execute("SELECT * FROM v_governance_function_queue")
    q_rows = cursor.fetchall()
    print("Count:", len(q_rows))
    for r in q_rows:
        print(dict(r))
        
    conn.close()

if __name__ == '__main__':
    main()

