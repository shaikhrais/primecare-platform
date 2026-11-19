import os, unittest
import psycopg
from help_desk_owner import guarded_change, KEY, GUEST, VIEW

class Adapter:
    pin={'readOnly':True,'sqliteFallback':False}
    table=staticmethod(lambda name:'public.'+name)
    def __init__(self,db):self.db=db
    def execute(self,s,args=()):return self.db.execute(s.replace('?','%s'),args)

class HelpDesk(unittest.TestCase):
    def setUp(self):
        self.db=psycopg.connect(os.environ['HELP_DESK_FIXTURE'])
        self.addCleanup(self.db.close)
        self.db.execute("""CREATE TABLE screens(id integer,app_id integer,screen_code text,route_path text,active integer,role_id integer);
        CREATE TABLE roles(role_code text,id integer,active integer);
        CREATE TABLE role_screen_permissions(id integer,screen_id integer,role_id integer,can_view integer,can_create integer,can_edit integer,can_delete integer,can_export integer);
        CREATE TABLE screen_api_links(screen_id integer,api_id integer);
        CREATE TABLE api_endpoints(id integer,endpoint_code text);
        INSERT INTO roles VALUES('guest',1,1),('customer_support',9,1),('outsider',11,1);
        INSERT INTO role_screen_permissions VALUES (5,896,1,1,1,1,1,1),(6,500,11,1,1,1,1,1);
        INSERT INTO api_endpoints VALUES(1,'GOVERNED_WORKSPACE_READ');
        INSERT INTO screen_api_links VALUES(896,1);""")
        self.db.execute('INSERT INTO screens VALUES(%s,%s,%s,%s,%s,%s)',(*KEY,1))
    def test_apply_is_exact(self):
        guarded_change(Adapter(self.db),True)
        self.assertEqual(self.db.execute('SELECT role_id FROM screens').fetchall(),[(9,)])
        self.assertEqual(self.db.execute('SELECT id,role_id,can_view,can_create,can_edit,can_delete,can_export FROM role_screen_permissions ORDER BY id').fetchall(),[(5,9,*VIEW),(6,11,*GUEST)])
    def test_domain_link_stops_before_write(self):
        self.db.execute("UPDATE api_endpoints SET endpoint_code='JUST_AN_UNAPPROVED_ROUTE'")
        with self.assertRaises(ValueError): guarded_change(Adapter(self.db),True)
        self.assertEqual(self.db.execute('SELECT role_id FROM screens').fetchall(),[(1,)])
    def test_other_grant_stops_before_write(self):
        self.db.execute("INSERT INTO role_screen_permissions VALUES (8,896,11,1,0,0,0,0)")
        with self.assertRaises(ValueError): guarded_change(Adapter(self.db),True)
        self.assertEqual(self.db.execute('SELECT role_id FROM screens').fetchall(),[(1,)])
if __name__=='__main__':unittest.main()
