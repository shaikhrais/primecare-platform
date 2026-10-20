import unittest
from theme_manifest import css_theme

def row(name='--spacing-sm',value='8px',theme_id=1,active=1):
    return {'css_variable_name':name,'token_value':value,'theme_id':theme_id,'active':active}

class ThemeManifestTests(unittest.TestCase):
    def test_null_non_css_token_is_omitted(self):
        self.assertEqual(css_theme([row(None),row()]),{'--spacing-sm':'8px'})
    def test_preserves_exact_approved_values(self):
        self.assertEqual(css_theme([row(value=' 0.5rem '),row('--color-primary','#123456')]),{'--spacing-sm':' 0.5rem ','--color-primary':'#123456'})
    def test_inactive_and_other_theme_do_not_leak(self):
        self.assertEqual(css_theme([row(active=0),row(theme_id=2),row('--spacing-md','16px')]),{'--spacing-md':'16px'})
    def test_invalid_css_names_fail(self):
        for name in ['null','color-primary','--x;display:none',0,'']:
            with self.subTest(name=name),self.assertRaises(ValueError):css_theme([row(name)])
    def test_invalid_values_fail(self):
        for value in [None,0,'','   ']:
            with self.subTest(value=value),self.assertRaises(ValueError):css_theme([row(value=value)])
    def test_conflicting_duplicates_fail(self):
        with self.assertRaises(ValueError):css_theme([row(),row(value='12px')])
    def test_identical_duplicate_is_stable(self):
        self.assertEqual(css_theme([row(),row()]),{'--spacing-sm':'8px'})
if __name__=='__main__':unittest.main()
