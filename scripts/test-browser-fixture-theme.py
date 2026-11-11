import sqlite3
import unittest
from pathlib import Path
from unittest.mock import patch
from browser_fixture_theme import load_fixture_theme, read_theme


class BrowserFixtureThemeTests(unittest.TestCase):
    def setUp(self):
        self.db = sqlite3.connect(':memory:')
        self.addCleanup(self.db.close)
        self.db.execute('CREATE TABLE theme_design_tokens(theme_id,active,css_variable_name,token_value)')

    def rows(self, *rows):
        self.db.executemany('INSERT INTO theme_design_tokens VALUES(?,?,?,?)', rows)

    def test_non_css_dimensions_are_omitted_and_css_values_preserved(self):
        self.rows((1,1,None,'1200'), (1,1,None,'2'),
                  (1,1,'--color-primary','#0F172A'), (1,1,'--spacing-sm',' 8px '))
        self.assertEqual(read_theme(self.db), {'--color-primary':'#0F172A','--spacing-sm':' 8px '})

    def test_other_themes_and_inactive_rows_are_not_exported(self):
        self.rows((1,0,'--hidden','x'), (2,1,'--other','x'), (1,1,'--shown','1px'))
        self.assertEqual(read_theme(self.db), {'--shown':'1px'})

    def test_malformed_exported_names_still_fail(self):
        for name in ['null', '', 'color-primary', '--x;display:none', 3]:
            with self.subTest(name=name):
                self.db.execute('DELETE FROM theme_design_tokens')
                self.rows((1,1,name,'2'))
                with self.assertRaises(ValueError): read_theme(self.db)

    def test_invalid_values_still_fail(self):
        for value in [None, '', '  ', 3]:
            with self.subTest(value=value):
                self.db.execute('DELETE FROM theme_design_tokens')
                self.rows((1,1,'--spacing-sm',value))
                with self.assertRaises(ValueError): read_theme(self.db)

    def test_conflicting_duplicates_are_not_silently_overwritten(self):
        self.rows((1,1,'--spacing-sm','8px'), (1,1,'--spacing-sm','9px'))
        with self.assertRaises(ValueError): read_theme(self.db)

    def test_identical_duplicates_are_stable(self):
        self.rows((1,1,'--spacing-sm','8px'), (1,1,'--spacing-sm','8px'))
        self.assertEqual(read_theme(self.db), {'--spacing-sm':'8px'})

    def test_loader_opens_read_only_sets_query_only_and_closes(self):
        with patch('browser_fixture_theme.sqlite3.connect', return_value=self.db) as connect:
            statements = []
            self.db.set_trace_callback(statements.append)
            self.assertEqual(load_fixture_theme('synthetic fixture.db'), {})
            connect.assert_called_once_with(Path('synthetic fixture.db').resolve().as_uri()+'?mode=ro', uri=True)
        self.assertEqual(statements, ['PRAGMA query_only=ON', 'SELECT theme_id,active,css_variable_name,token_value FROM theme_design_tokens'])
        with self.assertRaises(sqlite3.ProgrammingError): self.db.execute('SELECT 1')

    def test_loader_closes_on_invalid_theme_without_repairing_input(self):
        self.rows((1,1,'null','2'))
        with patch('browser_fixture_theme.sqlite3.connect', return_value=self.db):
            with self.assertRaises(ValueError): load_fixture_theme('synthetic fixture.db')
        with self.assertRaises(sqlite3.ProgrammingError): self.db.execute('SELECT 1')


if __name__ == '__main__': unittest.main()
