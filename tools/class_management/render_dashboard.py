"""Render a bounded, searchable class-review artifact, not an authorized app route."""

import argparse, json
from pathlib import Path

HTML = """<!doctype html><html lang="en"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>PrimeCare Class Management</title>
<style>*{box-sizing:border-box}body{margin:0;font:14px system-ui,sans-serif;color:#1f232b;background:#f6f7f8}header{padding:24px 32px;background:#fff;border-bottom:1px solid #e5e7eb}h1{margin:0 0 8px;font-size:24px}small,.muted{color:#4b5563}main{max-width:1600px;margin:auto;padding:24px}.summary{display:grid;grid-template-columns:repeat(auto-fit,minmax(160px,1fr));gap:16px}.card{background:#fff;padding:20px;border-radius:12px}.value{font-size:28px;font-weight:600;margin:8px 0}.layout{display:grid;grid-template-columns:240px minmax(0,1fr);gap:20px;margin-top:20px}aside button{display:block;width:100%;text-align:left;background:transparent;border:0;padding:10px;cursor:pointer}aside button:hover{background:#f3f4f6}.filters{display:flex;gap:10px;flex-wrap:wrap;margin-bottom:16px}input,select,textarea,button{font:inherit;border:1px solid #d1d5db;border-radius:8px;padding:9px 12px;background:#fff;color:inherit}input{min-width:160px;flex:1}button{cursor:pointer}button:disabled{opacity:.45;cursor:default}button:focus-visible,input:focus-visible,select:focus-visible,textarea:focus-visible{outline:3px solid #1565c0;outline-offset:2px}.table{overflow:auto}table{width:100%;border-collapse:collapse}th,td{text-align:left;padding:12px;border-bottom:1px solid #e5e7eb;vertical-align:top}th{font-size:12px;color:#4b5563}.name{font-weight:600;border:0;padding:0;text-align:left;color:#1565c0;overflow-wrap:anywhere}.badge{font-size:12px;border-radius:20px;background:#f3f4f6;padding:4px 8px;display:inline-block}footer{display:flex;align-items:center;gap:12px;padding-top:16px}.notice{padding:12px 16px;margin:16px 0;border-left:4px solid #1565c0;background:#eff6ff}dialog{border:0;border-radius:12px;max-width:800px;width:90vw;max-height:90vh;padding:24px}dialog::backdrop{background:#0008}pre{white-space:pre-wrap;overflow-wrap:anywhere;background:#f6f7f8;padding:12px}textarea{display:block;width:100%;min-height:80px;margin:6px 0 14px}label{display:block;font-weight:600}.close{float:right}@media(max-width:800px){main{padding:12px}.layout{grid-template-columns:1fr}aside{display:none}header{padding:20px}.card{padding:16px}}@media(prefers-color-scheme:dark){body{background:#0f1115;color:#f3f4f6}header,.card,dialog,input,select,button,textarea{background:#1a1d22;color:#f3f4f6}small,.muted,th{color:#b0b8c4}.badge,pre{background:#252a33}.notice{background:#16283d}.name{color:#83b8f2}}</style>
<header><h1>Class Management</h1><div id="source" class="muted"></div><div id="status" class="notice"></div></header>
<main><section class="summary" id="summary" aria-label="Catalog summary"></section><div class="layout"><aside class="card"><h2>Master managers</h2><div id="managers"></div></aside><section class="card"><div class="filters"><input id="search" aria-label="Search class purpose or source" placeholder="Search class, purpose, manager, source…"><select id="language" aria-label="Language"><option value="">All languages</option></select><select id="owner" aria-label="Manager"><option value="">All managers</option></select><select id="role" aria-label="Architectural role"><option value="">All class roles</option></select><select id="appClass" aria-label="Application class"><option value="">All application scopes</option></select><select id="appName" aria-label="Application name"><option value="">All applications</option></select><select id="review" aria-label="Review filter"><option value="">All review states</option><option value="missing">Missing purpose</option><option value="overlap">Overlap candidate</option><option value="base">Unresolved base</option></select></div><div class="table"><table><thead><tr><th>Class / source</th><th>Manager / parent</th><th>Role / application</th><th>Base</th><th>Purpose</th><th>Database / metadata review</th></tr></thead><tbody id="rows"></tbody></table></div><footer><button id="previous">Previous</button><span id="range" aria-live="polite"></span><button id="next">Next</button></footer></section></div><p class="muted">Role and appClass labels are inferred from names, paths and bases and require review. Ownership metadata is not an access grant or proof of business readiness. Overlap candidates require review; no automatic merging occurs.</p></main>
<dialog id="detail"><button class="close" id="close" aria-label="Close class detail">Close</button><h2 id="title"></h2><pre id="metadata"></pre><label for="purpose">Purpose proposal</label><textarea id="purpose"></textarea><label for="rationale">Why this class is needed</label><textarea id="rationale"></textarea><button id="download">Download review proposal</button><p class="muted">Downloads a source-bound proposal only. Production is not changed or approved.</p></dialog>
<script id="catalog" type="application/json">__CATALOG__</script>
<script>
const data=JSON.parse(document.getElementById('catalog').textContent),all=data.classes,base=new Map(data.baseClasses.map(x=>[x.id,x])),manager=new Map(data.managers.map(x=>[x.id,x])),overlaps=new Map();
for(const finding of data.findings)for(const id of finding.classIds){if(!overlaps.has(id))overlaps.set(id,[]);overlaps.get(id).push(finding)}
const $=id=>document.getElementById(id);let page=0,filtered=all,current=null;
$('source').textContent=`${all.length.toLocaleString()} declarations · ${data.sourceCommit} · ${data.workingTreeDirty?'uncommitted source snapshot':'committed source snapshot'}`;
$('status').textContent=data.dataKind==='production_readback'?'Production presence verified for this committed scan. Metadata reviews are separate.':'Database status UNKNOWN: this source-only report has no production read-back. No class is marked absent or registered from an offline scan.';
if(!data.complete)$('status').textContent+=' Scan contains parse diagnostics; coverage is partial. Missing declarations must not be treated as deleted.';
for(const [title,value]of [['Classes',all.length],['Managers',manager.size],['Missing purpose',all.filter(x=>!x.purpose&&!x.sourceDescription).length],['Overlap groups',data.findings.length],['Unresolved bases',data.baseClasses.filter(x=>x.resolution==='needs_resolution').length]]){const box=document.createElement('div');box.className='card';const label=document.createElement('div');label.textContent=title;const number=document.createElement('div');number.className='value';number.textContent=value.toLocaleString();box.append(label,number);$('summary').append(box)}
for(const language of [...new Set(all.map(x=>x.language))].sort()){const option=new Option(language,language);$('language').add(option)}
for(const key of ['role','appClass','appName']){const field=key==='role'?'architecturalRole':key;for(const value of [...new Set(all.map(x=>x[field]).filter(Boolean))].sort())$(key).add(new Option(value,value))}
for(const m of data.managers){$('owner').add(new Option(m.id,m.id));const button=document.createElement('button');let depth=0,p=m;while(p.parentId){depth++;p=manager.get(p.parentId)}button.style.paddingLeft=(depth*14+8)+'px';button.textContent=m.id+' ('+all.filter(x=>x.managerId===m.id).length+')';button.title=m.purpose;button.onclick=()=>{$('owner').value=m.id;apply()};$('managers').append(button)}
function apply(){const term=$('search').value.toLocaleLowerCase();filtered=all.filter(row=>{const b=base.get(row.baseId);return(['role','appClass','appName'].every(key=>!$(key).value||row[key==='role'?'architecturalRole':key]===$(key).value))&&(!$('language').value||row.language===$('language').value)&&(!$('owner').value||row.managerId===$('owner').value)&&(!$('review').value||($('review').value==='missing'&&!row.purpose&&!row.sourceDescription)||($('review').value==='overlap'&&overlaps.has(row.id))||($('review').value==='base'&&b?.resolution==='needs_resolution'))&&(!term||[row.name,row.path,row.purpose,row.sourceDescription,row.rationale,row.managerId,row.baseName,row.architecturalRole,row.appClass,row.appName].join(' ').toLocaleLowerCase().includes(term))});page=0;paint()}
function cell(value){const td=document.createElement('td');td.textContent=value??'Not provided';return td}
function paint(){$('rows').replaceChildren();for(const row of filtered.slice(page*25,(page+1)*25)){const tr=document.createElement('tr'),td=document.createElement('td'),button=document.createElement('button');button.className='name';button.textContent=row.name;button.onclick=()=>open(row);const path=document.createElement('small');path.textContent=row.path+':'+row.line;td.append(button,document.createElement('br'),path);const b=base.get(row.baseId);tr.append(td,cell((row.managerId||'Unassigned')+' / '+(row.parentManagerId||'Master')),cell((row.architecturalRoleLabel||'Not classified')+' / '+(row.appName||row.appClass||'Unknown')),cell(row.baseName?row.baseName+' · '+b.resolution:'No extends declaration'),cell(row.reviewedPurpose||row.purpose||row.sourceDescription||'Missing — review required'),cell((row.databaseStatus||'unknown')+' / '+(row.databaseReviewStatus||'DB review unknown')));$('rows').append(tr)}$('range').textContent=filtered.length?`${page*25+1}–${Math.min((page+1)*25,filtered.length)} of ${filtered.length.toLocaleString()}`:'No matching declarations';$('previous').disabled=page===0;$('next').disabled=(page+1)*25>=filtered.length}
function open(row){current=row;$('title').textContent=row.name;$('metadata').textContent=JSON.stringify({id:row.id,path:row.path,line:row.line,manager:manager.get(row.managerId),base:base.get(row.baseId),organization:{role:row.architecturalRole,appClass:row.appClass,appName:row.appName,evidence:row.classificationEvidence,status:row.classificationStatus,usageScope:row.usageScope},scope:row.scope,parseValid:row.parseValid,databaseStatus:row.databaseStatus,sourceReviewStatus:row.reviewStatus,overlaps:overlaps.get(row.id)||[]},null,2);$('purpose').value=row.reviewedPurpose||row.purpose||row.sourceDescription||'';$('rationale').value=row.reviewedRationale||row.rationale||'';$('detail').showModal()}
$('close').onclick=()=>$('detail').close();$('previous').onclick=()=>{page--;paint()};$('next').onclick=()=>{page++;paint()};for(const id of ['search','language','owner','role','appClass','appName','review'])$(id).addEventListener(id==='search'?'input':'change',apply);
$('download').onclick=()=>{if(!current)return;const proposed={format:1,classId:current.id,sourceSha256:current.sourceSha256,purpose:$('purpose').value,rationale:$('rationale').value,reviewed:false};const url=URL.createObjectURL(new Blob([JSON.stringify(proposed,null,2)],{type:'application/json'}));const link=document.createElement('a');link.href=url;link.download='class-purpose-proposal.json';link.click();setTimeout(()=>URL.revokeObjectURL(url),1000)};paint();
</script></html>"""


def render(value):
    data = (
        json.dumps(value, ensure_ascii=False)
        .replace("<", "\\u003c")
        .replace(">", "\\u003e")
        .replace("&", "\\u0026")
    )
    return HTML.replace("__CATALOG__", data)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--catalog", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    value = json.loads(args.catalog.read_text())
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(render(value))
    print(
        json.dumps(
            {
                "classes": len(value["classes"]),
                "databaseReadback": value.get("dataKind") == "production_readback",
            }
        )
    )


if __name__ == "__main__":
    main()
