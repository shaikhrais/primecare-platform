"""Project active governed theme rows into browser CSS variables."""
import re

def css_theme(rows):
    theme={}
    for row in rows:
        if row['theme_id']!=1 or row['active']!=1:
            continue
        name=row['css_variable_name']
        # Some governed tokens are not CSS exports; never stringify NULL as a key.
        if name is None:
            continue
        if not isinstance(name,str) or not re.fullmatch(r'--[A-Za-z0-9_-]+',name):
            raise ValueError('Invalid governed CSS variable name')
        value=row['token_value']
        if not isinstance(value,str) or not value.strip():
            raise ValueError('Invalid governed CSS token value')
        if name in theme and theme[name]!=value:
            raise ValueError('Conflicting governed CSS token values')
        theme[name]=value
    return theme
