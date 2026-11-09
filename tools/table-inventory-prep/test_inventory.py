import unittest
from inventory import inventory, ident

class Cur:
    def __init__(self, c): self.c=c
    def __enter__(self): return self
    def __exit__(self,*args): pass
    def execute(self, sql): self.c.queries.append(sql)
    def fetchall(self): return self.c.catalog
    def fetchone(self): return (7,)
class Conn:
    autocommit=True
    def __init__(self, catalog): self.catalog=catalog; self.queries=[]
    def cursor(self): return Cur(self)
class Tests(unittest.TestCase):
    def test_quote(self): self.assertEqual(ident('a"; DROP TABLE x;--'), '"a""; DROP TABLE x;--"')
    def test_scopes_and_guards(self):
        c=Conn([('x','t','r',3,False,False,False,False,True,False),
                ('x','restricted','r',-1,True,False,False,False,True,False),
                ('x','foreign','f',-1,False,False,False,False,True,False),
                ('x','denied','r',0,False,False,False,False,False,False)])
        out=inventory(c)['tables']
        self.assertEqual([r['count_status'] for r in out],['exact_table_rows','exact_visible_rows','skipped_foreign_table_or_descendants','no_select_privilege'])
        self.assertEqual(out[0]['exact_count'],7)
        self.assertEqual(out[0]['estimated_rows'],3)
        self.assertEqual(c.queries.count('BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ READ ONLY'),3)
        self.assertEqual(c.queries.count('ROLLBACK'),3)
        self.assertEqual(sum(q.startswith('SELECT count') for q in c.queries),2)
    def test_foreign_descendant(self):
        c=Conn([('x','parent','p',3,False,False,False,True,True,True)])
        self.assertEqual(inventory(c)['tables'][0]['count_status'],'skipped_foreign_table_or_descendants')
        self.assertFalse(any(q.startswith('SELECT count') for q in c.queries))
    def test_budget(self):
        c=Conn([('x','t','r',3,False,False,False,False,True,False)])
        values=iter([0,181])
        self.assertEqual(inventory(c,clock=lambda:next(values))['tables'][0]['count_status'],'overall_time_budget_reached')
        self.assertFalse(any(q.startswith('SELECT count') for q in c.queries))
if __name__=='__main__': unittest.main()
