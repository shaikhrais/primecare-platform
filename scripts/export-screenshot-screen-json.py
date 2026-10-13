"""Export old screenshot/HTML references as data; never infer runtime readiness."""
import argparse
from collections import defaultdict
import hashlib
from html.parser import HTMLParser
import json
from pathlib import Path
import struct

ROOT=Path(__file__).resolve().parents[1]
OUTPUT=ROOT/'docs/refactoring/screen-json-references'


class Node:
    def __init__(self,tag,attrs,parent=None):
        self.tag=tag;self.attrs=dict(attrs);self.parent=parent;self.children=[];self.parts=[]
    def text(self):return ' '.join(' '.join(self.parts).split())


class Preview(HTMLParser):
    def __init__(self):super().__init__();self.root=Node('document',[]);self.stack=[self.root];self.nodes=[]
    def handle_starttag(self,tag,attrs):
        node=Node(tag,attrs,self.stack[-1]);self.stack[-1].children.append(node);self.nodes.append(node)
        if tag not in {'area','base','br','col','embed','hr','img','input','link','meta','param','source','track','wbr'}:self.stack.append(node)
    def handle_endtag(self,tag):
        for i in range(len(self.stack)-1,0,-1):
            if self.stack[i].tag==tag:self.stack=self.stack[:i];return
    def handle_data(self,data):
        if any(n.tag in {'script','style','head'} for n in self.stack):return
        self.stack[-1].parts.append(data)


def digest(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def image(path):
    data=path.read_bytes();size=struct.unpack('>II',data[16:24]) if data.startswith(b'\x89PNG\r\n\x1a\n') else (None,None)
    return {'path':str(path.relative_to(ROOT)),'sha256':hashlib.sha256(data).hexdigest(),'width':size[0],'height':size[1]}


def export():
    OUTPUT.mkdir(parents=True,exist_ok=True)
    images=[image(p) for folder in ['docs/gallery/screenshots','screenshots'] for p in sorted((ROOT/folder).rglob('*.png'))]
    by_stem=defaultdict(list);hashes=defaultdict(list)
    for item in images:
        by_stem[Path(item['path']).stem.lower()].append(item);hashes[item['sha256']].append(item['path'])
    for item in images:item['identicalImageCount']=len(hashes[item['sha256']])
    roles=defaultdict(list);matched=0;chrome={}
    for path in sorted((ROOT/'html_screen_previews/roles').glob('*/screens/*.html')):
        role=path.parts[-3];screen=path.stem;preview=Preview();preview.feed(path.read_text(errors='replace'))
        resources={};sections=[];controls=[];shell_resources={};shell_controls=[]
        for index,node in enumerate(preview.nodes):
            ancestors=[];parent=node
            while parent is not None:
                ancestors.append(parent);parent=parent.parent
            is_shell=any(set(n.attrs.get('class','').split()) & {'app-topbar','app-sidebar'} for n in ancestors)
            target_resources=shell_resources if is_shell else resources
            target_controls=shell_controls if is_shell else controls
            attributes=node.attrs;identity=attributes.get('data-testid') or attributes.get('data-cy') or attributes.get('data-entity-id') or attributes.get('id') or f'node_{index}'
            for property,text in [('text',node.text()),('placeholder',attributes.get('placeholder')),('tooltip',attributes.get('title')),('ariaLabel',attributes.get('aria-label'))]:
                if text and text.strip() and node.tag not in {'script','style','meta','link'}:
                    target_resources[f'{identity}.{property}.{index}']=text
            if attributes.get('data-entity-type')=='section' or node.tag=='section':
                sections.append({'id':identity,'kind':attributes.get('data-entity-type',node.tag),'cssClasses':attributes.get('class','').split(),'inlineStyle':attributes.get('style'), 'sourceTag':attributes.get('data-implementation-tag')})
            if node.tag in {'button','input','select','textarea','a'}:
                target_controls.append({'id':identity,'kind':node.tag,'inputType':attributes.get('type'),'label':node.text(),'placeholder':attributes.get('placeholder'),'href':attributes.get('href'),'sourceActionTag':attributes.get('data-action-tag'),'workflowVerified':False})
        shell={'locales':{'en':shell_resources,'fr':{},'es':{}},'controls':shell_controls}
        shell_id=hashlib.sha256(json.dumps(shell,sort_keys=True).encode()).hexdigest()[:20];chrome[shell_id]=shell
        screenshots=by_stem.get(screen.lower(),[])
        if screenshots:matched+=1
        roles[role].append({'screen':screen,'role':role,'source':{'html':str(path.relative_to(ROOT)),'htmlSha256':digest(path),'screenshots':screenshots,'matchEvidence':'filename_candidate' if screenshots else 'no_screenshot_match','visualReview':'pending'},'layout':{'shellRef':shell_id,'sections':sections,'cssSource':str(path.relative_to(ROOT))},'locales':{'en':resources,'fr':{},'es':{}},'controls':controls,'runtimeImplementationVerified':False,'permissionsAndAPIs':'Must be read from governance; not inferred from screenshots','translationReview':'pending'})
    for role,records in roles.items():(OUTPUT/(role+'.json')).write_text(json.dumps({'version':1,'kind':'historical_visual_reference','screens':records},ensure_ascii=False,indent=2)+'\n')
    (OUTPUT/'shared-chrome.json').write_text(json.dumps({'version':1,'components':chrome},ensure_ascii=False,indent=2)+'\n')
    summary={'sharedChromeTemplates':len(chrome),'screens':sum(map(len,roles.values())),'roleFiles':len(roles),'screensWithFilenameScreenshotCandidates':matched,'images':len(images),'uniqueImageHashes':len(hashes),'duplicateImageHashes':sum(len(paths)>1 for paths in hashes.values()),'notRuntimeCatalogs':True,'note':'Text/control/layout evidence comes from matching legacy HTML previews. Screenshot filename matches are candidates; images may show galleries, login walls or placeholders. Translation, visual identity, workflows and new-inheritance compatibility require verification.'}
    (OUTPUT/'summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    return summary


if __name__=='__main__':print(json.dumps(export(),indent=2))
