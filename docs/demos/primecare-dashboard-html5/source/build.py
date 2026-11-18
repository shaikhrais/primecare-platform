#!/usr/bin/env python3
"""Build and verify an offline PrimeCare dashboard registry review."""
import argparse
from collections import Counter
from html import escape
from html.parser import HTMLParser
from pathlib import Path
import hashlib
import json
import re
import subprocess
import zipfile

SHA = "c6772fc0a4b3500b4c5159ef777c9fd589dcc616"
REGISTRY = "cloudflare/workers/src/workspace-registry.json"
FIXTURE = "packages/primecare_ui/test/fixtures/role_dashboard_entries.dart"
SPECIALIZED = {"care_delivery", "founder_growth_dashboard"}
COUNT = 115
ROOT = Path(__file__).resolve().parent
REPO = ROOT.parents[3]
OUT = ROOT / "bundle"
ZIP = ROOT.parent / "PrimeCare-Dashboard-115-HTML5.zip"

def git(repo, *args):
    return subprocess.check_output(["git", "-C", str(repo), *args])

def esc(s):
    return escape(str(s), quote=True)

def base(title, prefix, body, js=False, runner=False):
    script = '<script src="assets/search.js" defer></script>' if js else ''
    if runner:
        script += ('<link rel="stylesheet" href="../assets/task-runner.css">'
                   '<script src="../assets/templates.js" defer></script>'
                   '<script src="../assets/task-runner.js" defer></script>')
    return f"""<!doctype html>
<html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta http-equiv="Content-Security-Policy" content="connect-src 'none'; object-src 'none'; base-uri 'none'">
<title>{esc(title)} | PrimeCare HTML5 simulator</title>
<link rel="stylesheet" href="{prefix}assets/styles.css">{script}
</head><body>
<a class="skip" href="#main">Skip to content</a>
<header class="masthead"><div class="frame masthead-inner">
<a class="brand" href="{prefix}index.html">PrimeCare <span>HTML5 dashboard simulator</span></a>
<span class="badge">Offline simulation · no live access</span>
</div></header>
<main class="frame" id="main">{body}</main>
<footer class="frame footer">Registry snapshot <code>{SHA}</code></footer>
</body></html>"""

def index(rows):
    apps = Counter(row["appCode"] for row in rows)
    options = ''.join(f'<option value="{esc(k)}">{esc(k.upper())} ({v})</option>' for k, v in sorted(apps.items()))
    cards = ''.join(f"""
<li class="entry" data-app="{esc(r['appCode'])}" data-text="{esc(' '.join(str(r[k]) for k in ('id','name','code','route','appCode','role')))}">
<span class="meta">{esc(r['appCode'].upper())} <span aria-hidden="true">·</span> {esc(r['role'])}</span>
<a href="dashboards/{esc(r['code'])}.html">{esc(r['name'])}</a>
<code>{esc(r['route'])}</code>
<small>{r['practiceScenarios']} practice scenarios · {len(r['sections'])} registered sections</small>
</li>""" for r in rows)
    return base("115 dashboards", "", f"""
<div class="intro"><p class="eyebrow">Pinned source · 115 dashboard records</p>
<h1>PrimeCare dashboards</h1>
<p>Open any of 115 dashboards to practice tasks in an interactive, offline workbench. Dashboard identities and sections are tied to registry commit <code>{SHA[:8]}</code>. Practice stays in this browser and does not change live PrimeCare.</p>
<p><a href="roles.html">What’s done by role</a> · <a href="manifest.json">Registry manifest (JSON)</a> · <a href="README.txt">Read setup and limits</a></p></div>
<div class="filters" aria-label="Dashboard filters">
<label for="search">Find a dashboard <input id="search" type="search" placeholder="Name, code, route, role or ID"></label>
<label for="app">Registered app <select id="app"><option value="">All apps (115)</option>{options}</select></label>
</div>
<p id="matches" role="status" aria-live="polite">115 of 115 dashboards</p>
<noscript><p>Search requires JavaScript. The full list and all dashboard pages are available without it.</p></noscript>
<ul class="entries" id="entries">{cards}</ul>
<p class="empty" id="empty" hidden>No dashboards match these filters.</p>
""", js=True)


def role_index(rows, templates):
    roles = {}
    for row in rows:
        roles.setdefault(row["role"],[]).append(row)
    groups=[]
    jump=[]
    for number,(role,members) in enumerate(sorted(roles.items()),1):
        anchor=f'role-{number}'
        choices=sum(len(templates[r['code']]) for r in members)
        noun='dashboard' if len(members)==1 else 'dashboards'
        jump.append(f'<li><a href="#{anchor}">{esc(role)} · {len(members)} {noun}</a></li>')
        displays=[]
        for r in members:
            names=''.join(f'<li>{esc(task["title"])}</li>' for task in templates[r['code']])
            blockers=''.join(f'<li>{esc(blocker)}</li>' for blocker in r["blockers"])
            count=r["practiceScenarios"]
            n=len(r["pendingActions"])
            registered=f'{n} controls are listed in the pinned registry’s pending list.' if n>0 else 'No controls appear in this row’s pending list; that does not prove readiness.'
            displays.append(f"""
<li class="section scorecard" data-code="{esc(r['code'])}">
<h3><a href="dashboards/{esc(r['code'])}.html">{esc(r['name'])}</a></h3>
<code>{esc(r['route'])}</code>
<p><strong>Role’s registered purpose:</strong> {esc(r['purpose'])}</p>
<p><strong>Done in this download:</strong> {count} local practice scenarios.</p>
<details><summary>See practice scenarios</summary><ol>{names}</ol></details>
<p><strong>Live integration:</strong> Not verified by this file. {esc(registered)}</p>
<details><summary>Blockers recorded at this commit</summary><ul>{blockers}</ul></details>
</li>""")
        groups.append(f"""<section class="role-group" id="{anchor}">
<h2><code>{esc(role)}</code> <span class="section-count">{len(members)} {noun} · {choices} scenarios</span></h2>
<ul class="sections">{''.join(displays)}</ul></section>""")
    return base("Dashboard role scorecard","",f"""
<a class="back" href="index.html">← All 115 dashboards</a>
<div class="intro"><p class="eyebrow">Registered roles · {len(roles)} groups</p>
<h1>What’s done by role</h1>
<p>Each dashboard shows its registered purpose, what you can practise now, and what this offline file does not prove about live integration. These are catalog owner roles, not access grants.</p>
<details><summary>Jump to an owner role</summary><ul class="role-jump">{''.join(jump)}</ul></details>
</div>
{''.join(groups)}
""")

def detail(row, previous, next_row):
    previous_link = f'<a rel="prev" href="{esc(previous["code"])}.html">← Previous dashboard</a>' if previous else ''
    next_link = f'<a rel="next" href="{esc(next_row["code"])}.html">Next dashboard →</a>' if next_row else ''
    cards = "".join(f"""
<li class="section" data-code="{esc(s['code'])}" data-name="{esc(s['name'])}" data-type="{esc(s['type'])}">
<details><summary>{esc(s['name'])}</summary>
<p>Registered type: <code>{esc(s['type'])}</code></p>
<p>Section code: <code>{esc(s['code'])}</code></p>
<p>{esc(s['purpose'])}</p></details>
</li>""" for s in row['sections'])
    registry_identity = data_identity(row)
    pending = row['pendingActions']
    blockers = ''.join(f'<li>{esc(blocker)}</li>' for blocker in row["blockers"])
    if pending:
        pending_list = ''.join(f'<tr><th scope="row">{esc(a["label"])}</th><td><code>{esc(a["key"])}</code></td><td><code>{esc(a["status"])}</code></td></tr>' for a in pending)
        statuses = f"""<details class="provenance"><summary>Documented pending controls ({len(pending)})</summary>
<p>The pinned registry lists these controls as pending. This is source metadata, not a clickable function or a claim about current production.</p>
<div class="status-wrap"><table><thead><tr><th>Registered label</th><th>Key</th><th>Recorded status</th></tr></thead><tbody>{pending_list}</tbody></table></div></details>"""
    else:
        statuses = '<p class="hint">This registry row has no entries in its pending control list. That does not establish that all live actions work.</p>'
    return base(row["name"], "../", f"""
<nav class="back" aria-label="Dashboard directory"><a href="../index.html">← All 115 dashboards</a>{previous_link}{next_link}</nav>
<div class="intro detail">
<p class="eyebrow">Registry record {esc(row['id'])} · {esc(row['appCode'].upper())}</p><h1>{esc(row['name'])}</h1>
<p><strong>Registered purpose:</strong> {esc(row['purpose'])}</p>
<p class="hint">Purpose is catalog text, not a statement that the workflow is available in this simulation or in production.</p>
</div>
<section id="task-runner" data-code="{esc(row['code'])}" data-screen="{esc(row['id'])}"></section>
<noscript><p class="hint">Enable JavaScript to run practice tasks. Dashboard information remains available below.</p></noscript>
<details class="provenance"><summary>Dashboard identity and existing implementation</summary>
<dl class="identity" {registry_identity}>
<div><dt>Screen code</dt><dd><code>{esc(row['code'])}</code></dd></div>
<div><dt>Registered route</dt><dd><code>{esc(row['route'])}</code></dd></div>
<div><dt>Registered app</dt><dd><code>{esc(row['appCode'])}</code></dd></div>
<div><dt>Catalog owner role</dt><dd><code>{esc(row['role'])}</code></dd></div>
<div><dt>Existing code at this commit</dt><dd>{esc(row['codeKind'])}</dd></div>
</dl>
<p class="hint">The owner role is not a permission or access grant.</p>
</details>
<h2>Registered sections <span class="section-count">{len(row['sections'])}</span></h2>
<ol class="sections">{cards}</ol>
<details class="provenance"><summary>Blockers recorded at this commit</summary><ul>{blockers}</ul></details>
{statuses}
""", runner=True)

def data_identity(row):
    return " ".join(f'data-{key.lower()}="{esc(row[key])}"' for key in ("id","code","route","appCode","role"))

CSS = """
:root{--ink:#17263b;--muted:#475972;--line:#d4dfeb;--paper:#fff;--base:#f4f8fc;--accent:#086170;--brand:#122943;--badge:#fff2c8;--accent-light:#e1f4f2;font:16px/1.5 system-ui,-apple-system,Segoe UI,sans-serif;color:var(--ink);background:var(--base)}
*{box-sizing:border-box}body{margin:0}a{color:#065d81;text-underline-offset:.18em}a:hover{text-decoration-thickness:.15em}a:focus-visible,input:focus-visible,select:focus-visible{outline:3px solid #a23b06;outline-offset:4px}.frame{width:min(100% - 2rem,72rem);margin-inline:auto}.masthead{background:var(--brand);color:white}.masthead-inner{display:flex;justify-content:space-between;align-items:center;gap:1rem;flex-wrap:wrap;padding-block:1rem}.masthead a{color:#fff}.brand{font-size:1.15rem;font-weight:740;text-decoration:none}.brand span{color:#bdd7ed;font-weight:550}.badge{background:var(--badge);color:#643a00;border-radius:1rem;padding:.25rem .65rem;font-weight:750;font-size:.82rem}.skip{position:absolute;background:white;padding:.3rem .6rem;left:1rem;top:-5rem}.skip:focus{top:.7rem}.intro{border-radius:1rem;background:var(--paper);margin:1.45rem 0 1rem;padding:clamp(1rem,4vw,2.45rem);border:1px solid var(--line)}h1{font-size:clamp(1.7rem,5vw,3.1rem);line-height:1.08;margin:.3rem 0 .65rem;letter-spacing:-.035em;overflow-wrap:anywhere}h2{font-size:1.25rem;line-height:1.25;overflow-wrap:anywhere}.intro p{max-width:55rem;color:var(--muted)}.intro .eyebrow{color:var(--accent);font-weight:800;font-size:.82rem;letter-spacing:.06em;text-transform:uppercase}.filters{display:grid;grid-template-columns:minmax(0,2fr) minmax(0,1fr);gap:1rem}.filters label{font-weight:700}.filters input,.filters select{margin-top:.28rem;display:block;width:100%;min-height:2.8rem;color:var(--ink);background:var(--paper);border:1px solid #899fba;border-radius:.55rem;font:inherit;padding:.38rem .55rem}#matches{font-weight:600;color:var(--muted)}.entries,.sections{list-style:none;margin:0;padding:0;display:grid;gap:.8rem;grid-template-columns:repeat(auto-fit,minmax(min(100%,17rem),1fr))}.entry,.section{min-width:0;padding:1rem;display:flex;flex-direction:column;gap:.2rem;border:1px solid var(--line);border-radius:.8rem;background:var(--paper)}.entry a{font-weight:750;overflow-wrap:anywhere}.meta,.entry small{color:var(--muted);font-size:.83rem;overflow-wrap:anywhere}.meta{font-weight:700}.entry small{margin-top:.18rem}code{font-size:.88em;overflow-wrap:anywhere;color:#193d56}.footer{margin:1.6rem auto 2.2rem;color:var(--muted);font-size:.84rem}.back{display:flex;flex-wrap:wrap;gap:.5rem 1.1rem;margin-top:1rem}.detail{margin-top:.75rem}.identity{display:grid;grid-template-columns:repeat(auto-fit,minmax(min(100%,13rem),1fr));gap:1rem;margin:1.05rem 0}.identity div{border-left:.17rem solid #85aaa9;padding-left:.6rem}dt{font-weight:700;font-size:.86rem;color:var(--muted)}dd{margin:0;overflow-wrap:anywhere}.hint{font-size:.88rem}.section-count{background:var(--accent-light);color:#174949;padding:.14rem .5rem;font-size:.78em;border-radius:.8rem}.section h2,.scorecard h3{margin:0 0 .2rem}.role-group{margin-top:1.4rem;scroll-margin-top:1rem}.role-jump{columns:3;gap:1.4rem}.role-jump li{break-inside:avoid;margin:.24rem 0;overflow-wrap:anywhere}.role-jump a{font-weight:600}.scorecard ol{padding-left:1.2rem}.scorecard ol li{margin:.35rem 0}.back a{display:inline-block}@media(max-width:52rem){.role-jump{columns:2}}@media(max-width:34rem){.role-jump{columns:1}}.section summary,.provenance>summary{font-weight:750;cursor:pointer;overflow-wrap:anywhere}.provenance{border:1px solid var(--line);background:var(--paper);border-radius:.75rem;padding:.85rem;margin:1rem 0}.status-wrap{overflow-x:auto}.status-wrap table{border-collapse:collapse;width:100%;text-align:left;font-size:.9rem}.status-wrap th,.status-wrap td{border-bottom:1px solid var(--line);padding:.4rem;overflow-wrap:anywhere;text-align:left}.section p{color:var(--muted);margin:.1rem 0;font-size:.91rem}.empty{padding:.8rem;border-radius:.55rem;background:var(--paper)}[hidden]{display:none!important}@media(max-width:36rem){.filters{grid-template-columns:1fr}.masthead-inner{gap:.35rem}}@media print{.masthead{color:#17263b;background:white}.masthead a,.brand span{color:#17263b}.intro{padding:.8rem}.entry,.section,.identity{break-inside:avoid}.filters,.back,.skip{display:none}.frame{width:100%}}
"""
JS = r"""
'use strict';
const query = document.querySelector('#search');
const app = document.querySelector('#app');
const cards = Array.from(document.querySelectorAll('#entries > li'));
const count = document.querySelector('#matches');
const empty = document.querySelector('#empty');
function update() {
  const terms = query.value.toLocaleLowerCase().trim().split(/\s+/).filter(Boolean);
  let visible = 0;
  for (const card of cards) {
    const hay = card.dataset.text.toLocaleLowerCase();
    const match = (!app.value || card.dataset.app === app.value) && terms.every(term => hay.includes(term));
    card.hidden = !match;
    if (match) visible += 1;
  }
  count.textContent = visible + ' of ' + cards.length + ' dashboards';
  empty.hidden = visible !== 0;
}
query.addEventListener('input',update);
app.addEventListener('change',update);
update();
"""

def write(path, content):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")

class Page(HTMLParser):
    def __init__(self, path):
        super().__init__(convert_charrefs=True)
        self.tags, self.links, self.sections, self.identities, self.runners, self.anchors = [], [], [], [], [], set()
        self.feed(path.read_text(encoding="utf-8"))
    def handle_starttag(self, tag, attrs):
        attrs=dict(attrs)
        self.tags.append(tag)
        if "id" in attrs:
            if attrs["id"] in self.anchors:
                raise ValueError("Duplicate ID")
            self.anchors.add(attrs["id"])
        if "href" in attrs:
            self.links.append(attrs["href"])
        if "src" in attrs:
            self.links.append(attrs["src"])
        if tag=="li" and attrs.get("class")=="section":
            self.sections.append({k:attrs["data-"+k] for k in ("code","name","type")})
        if tag=="dl" and attrs.get("class")=="identity":
            self.identities.append({k:attrs["data-"+k.lower()] for k in ("id","code","route","appCode","role")})
        if tag=="section" and attrs.get("id")=="task-runner":
            self.runners.append(attrs.get("data-code"))
        if any(k.startswith("on") for k in attrs):
            raise ValueError("Unexpected inline handler")

def validate(out, rows):
    pages = set((out/"dashboards").glob("*.html"))
    expected = {out/"dashboards"/(r["code"]+".html") for r in rows}
    if pages != expected or len(pages) != COUNT:
        raise ValueError("Dashboard file coverage or path collision")
    catalog = Page(out/"index.html")
    catalog_links = [ref for ref in catalog.links if ref.startswith("dashboards/")]
    if sorted(catalog_links) != sorted(f"dashboards/{r['code']}.html" for r in rows):
        raise ValueError("Index links do not match rows")
    for row in rows:
        path = out/"dashboards"/(row["code"]+".html")
        review = Page(path)
        identity = {k:str(row[k]) for k in ("id","code","route","appCode","role")}
        if review.sections != [{k:s[k] for k in ("code","name","type")} for s in row["sections"]] or review.identities != [identity] or review.runners != [row["code"]]:
            raise ValueError(f"Registry-parity failure for {row['code']}")
        if set(review.tags)&{"form","input","button","iframe","object","embed"} or review.tags.count("script")!=2:
            raise ValueError("Unexpected static document element or script load count")
    role_scorecard=Page(out/"roles.html")
    role_links=[ref for ref in role_scorecard.links if ref.startswith("dashboards/")]
    if sorted(role_links)!=sorted(catalog_links):
        raise ValueError("Role scorecard links do not match rows")
    for path in [out/"index.html",out/"roles.html", *sorted(pages)]:
        document=Page(path)
        for link in document.links:
            if link.startswith("#"):
                if link[1:] not in document.anchors:
                    raise ValueError(f"Missing page anchor {path}: {link}")
                continue
            if re.match(r"^[a-zA-Z][a-zA-Z0-9+.-]*:|^/|^\\", link):
                raise ValueError("Nonlocal link")
            target=(path.parent/link).resolve()
            if out.resolve() not in target.parents or not target.is_file():
                raise ValueError(f"Invalid reference from {path}: {link}")

def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--repo",type=Path,default=REPO)
    parser.add_argument("--out",type=Path,default=OUT)
    parser.add_argument("--zip",type=Path,default=ZIP)
    parser.add_argument("--templates",type=Path,default=ROOT/"task-templates.json")
    args=parser.parse_args()
    raw=git(args.repo,"show",f"{SHA}:{REGISTRY}")
    registry=json.loads(raw)
    allrows=[r for r in registry["screens"] if r["renderer"]=="dashboard"]
    if len(allrows)!=COUNT or any(len({r[k] for r in allrows})!=COUNT for k in ("id","code","route")):
        raise ValueError("Unexpected canonical dashboard coverage")
    if any(not re.fullmatch(r"[a-z][a-z0-9_]*",r["code"]) for r in allrows):
        raise ValueError("Unexpected screen code")
    fixture=git(args.repo,"show",f"{SHA}:{FIXTURE}").decode("utf-8")
    wrapper_codes=set(re.findall(r"generated_screens/([a-z0-9_]+)\.dart",fixture))
    wrapper_routes=set(re.findall(r"^  '(/[^']+)',$",fixture,re.M))
    if wrapper_codes|SPECIALIZED!={r["code"] for r in allrows} or wrapper_codes&SPECIALIZED:
        raise ValueError("Wrapper coverage differs from fixture")
    if wrapper_routes!={r["route"] for r in allrows if r["code"] in wrapper_codes}:
        raise ValueError("Wrapper route coverage differs from fixture")
    rows=[]
    for r in sorted(allrows,key=lambda x:(x["appCode"],x["name"].casefold(),x["code"])):
        rows.append({**{k:r[k] for k in ("id","code","name","route","appCode","role")},
            "purpose":r["requirements"]["business_purpose"],
            "blockers":r["blockers"],
            "sections":[{k:s[k] for k in ("code","name","type","purpose")} for s in r["sections"]],
            "pendingActions":[{k:a[k] for k in ("key","label","status")} for a in r["pendingActions"]],
            "codeKind":"Shared governed Dart wrapper" if r["code"] in wrapper_codes else "Specialized implementation preserved"})
    section_count=sum(len(r["sections"]) for r in rows)
    out=args.out
    write(out/"assets/styles.css",CSS)
    write(out/"assets/search.js",JS)
    for name in ("task-runner.js","task-runner.css"):
        write(out/"assets"/name,(ROOT/name).read_text(encoding="utf-8"))
    templates=json.loads(args.templates.read_text(encoding="utf-8"))
    if set(templates)!={r["code"] for r in rows} or any(not isinstance(v,list) or not v for v in templates.values()):
        raise ValueError("Practice templates do not match registry dashboard coverage")
    template_count=sum(len(v) for v in templates.values())
    for row in rows:
        row["practiceScenarios"]=len(templates[row["code"]])
    write(out/"assets/templates.js","window.PRIMECARE_TEMPLATES = " + json.dumps(templates,ensure_ascii=True,separators=(",",":")) + ";\n")
    write(out/"index.html",index(rows))
    write(out/"roles.html",role_index(rows,templates))
    for i,r in enumerate(rows):
        write(out/"dashboards"/(r["code"]+".html"),
            detail(r,rows[i-1] if i>0 else None,rows[i+1] if i+1<len(rows) else None))
    write(out/"manifest.json",json.dumps({"format":1,"sourceCommit":SHA,"registryPath":REGISTRY,
      "registrySha256":hashlib.sha256(raw).hexdigest(),"sharedWrapperFixture":FIXTURE,
      "dashboardCount":COUNT,"sectionCount":section_count,"offlineSimulationOnly":True,
      "practiceScenarios":template_count,"catalogOwnerRoles":len({r["role"] for r in rows}),"dashboards":rows},
      ensure_ascii=False,indent=2)+"\n")
    write(out/"README.txt",f"""PRIMECARE DASHBOARDS · HTML5 OFFLINE SIMULATOR

Extract the entire ZIP into a folder. Then open index.html in a browser.
Internet, server, sign-in, and installation are not needed. Enable JavaScript
for task practice and searchable index. See roles.html for the owner-role scorecard.
Dashboard identity and section information
remain readable with JavaScript off. Use fictional data only; never enter patient,
client or staff information. Use export to keep a copy of local practice data,
since access to browser storage for files and private windows can vary.

Source commit: {SHA}
Registry: {REGISTRY}
Exact filter: screens with renderer equal to dashboard.
Coverage: {COUNT} unique screen IDs, names as registered, codes and routes;
{section_count} registered sections in registry order. {template_count} fictional task templates. Code classifications
are based on the committed shared Dart wrapper test fixture ({len(wrapper_codes)})
and documented preserved specialized implementations ({len(SPECIALIZED)}).

This is an offline practice simulator, not a production UI or deployment.
Labels such as Quick Actions are catalog names. Task practice and sample records
are fictional; there are no live API requests, actual workflow execution, permission
changes, or access to PrimeCare. The manifest separates exact registry metadata
from practice scenario counts. A role name identifies a dashboard's catalog owner,
not proof that a person can access it.

Prior app checks (separate from this bundle):
https://github.com/shaikhrais/primecare-platform/actions/runs/44093113563
The app's isolated acceptance run covered 113 shared screens at two widths.
Care Delivery had dedicated route-handoff checks and Growth a separate
loading/error/retry check. These are not end-to-end workflow readiness results.
""")
    validate(out,rows)
    included=[out/"index.html",out/"roles.html",out/"manifest.json",out/"README.txt",out/"assets/styles.css",out/"assets/search.js",out/"assets/task-runner.js",out/"assets/task-runner.css",out/"assets/templates.js"]
    included.extend(out/"dashboards"/(r["code"]+".html") for r in rows)
    args.zip.parent.mkdir(parents=True,exist_ok=True)
    with zipfile.ZipFile(args.zip,"w",compression=zipfile.ZIP_DEFLATED,compresslevel=9) as z:
        for f in included:
            info = zipfile.ZipInfo(str(f.relative_to(out)),date_time=(2026,11,18,0,0,0))
            info.compress_type=zipfile.ZIP_DEFLATED
            z.writestr(info,f.read_bytes())
    with zipfile.ZipFile(args.zip) as z:
        if z.testzip() is not None or len(z.namelist())!=COUNT+9 or len(set(z.namelist()))!=COUNT+9:
            raise ValueError("ZIP integrity or coverage failure")
    print(json.dumps({"dashboardPages":len(rows),"registeredSections":section_count,"practiceScenarios":template_count,
      "sharedWrappers":len(wrapper_codes),"specialized":len(SPECIALIZED),"zipEntries":len(included),
      "sourceCommit":SHA,"sha256":hashlib.sha256(args.zip.read_bytes()).hexdigest(),
      "zip":str(args.zip)},indent=2))

if __name__=="__main__":
    main()
