"""Contract consolidation preserves identity/evidence and refuses unsafe drift."""
import copy,hashlib,importlib.util,json,tempfile,unittest,subprocess,sys
from pathlib import Path
spec=importlib.util.spec_from_file_location('plan',Path(__file__).with_name('generate-workflow-contract-plan.py'))
m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
def fixtures():
 ops=[]
 for i,(api,stage) in enumerate([('POST /v1/client/a','needs_contract_and_verification'),('GET /v1/client/b','blocked'),('GET /v1/client/c','unit_evidence_recorded'),('POST /v1/client/d','retired_with_evidence')]):
  method,route=api.split(' ',1);ops.append({'api':api,'method':method,'route':route,'declarationIds':[i+1],'stage':stage})
 stages={o['stage']:1 for o in ops}
 c={'summary':{'uniqueOperations':4,'stages':stages},'operations':ops}
 def review(rid,priority,targets,family):return {'id':rid,'priority':priority,'familyKey':family,'title':family,'operations':[{'api':ops[i]['api'],'declarationIds':ops[i]['declarationIds']} for i in targets],'policyDecisions':['Define actor and response contract'],'evidencePaths':['source.txt'],'authorityDisposition':'requires_defined_contract','activationEligible':False}
 manifest={'version':1,'baselineUniqueOperations':4,'noActivation':True,'reviews':[review('b',2,[0,1],'fallback'),review('a',1,[0],'specific')],'provenance':[{'api':ops[0]['api'],'tag':'caller'}],'sourceHashes':{'source.txt':hashlib.sha256(b'evidence').hexdigest()}}
 return c,manifest
class Tests(unittest.TestCase):
 def setUp(self):self.c,self.manifest=fixtures()
 def test_primary_assignment_unique_stable_and_original_states_preserved(self):
  result=m.build(self.c,self.manifest);self.assertEqual(result['operations'],self.c['operations']);self.assertEqual(result['summary'],self.c['summary']);self.assertEqual(result['unresolvedUniqueOperations'],2)
  self.assertEqual([r['primaryReviewId'] for r in result['assignments']],['b','a'])
  self.assertTrue(all(not r['activationEligible'] for r in result['assignments']))
  self.assertEqual(result['implementationCredits'],0);self.assertEqual(result['retirementCredits'],0)
  shuffled=copy.deepcopy(self.manifest);shuffled['reviews'].reverse();self.assertEqual(m.build(self.c,shuffled),result)
 def test_priority_tie_uses_stable_review_identity(self):
  self.manifest['reviews'][1]['priority']=2
  result=m.build(self.c,self.manifest);self.assertEqual(next(r for r in result['assignments'] if r['api'].startswith('POST'))['primaryReviewId'],'a')
 def test_source_hashes_match_files_and_refuse_content_or_missing_sources(self):
  with tempfile.TemporaryDirectory() as d:
   p=Path(d)/'source.txt';p.write_bytes(b'evidence');m.build(self.c,self.manifest,d)
   p.write_bytes(b'drift')
   with self.assertRaisesRegex(ValueError,'Source evidence changed'):m.build(self.c,self.manifest,d)
   p.unlink()
   with self.assertRaises(ValueError):m.build(self.c,self.manifest,d)
 def test_identity_stage_duplicates_and_missing_coverage_refused(self):
  mutations=[lambda c,v:c['operations'].append(c['operations'][0]),lambda c,v:c['operations'][0].update(method='GET'),lambda c,v:c['operations'][0].update(stage='blocked'),lambda c,v:v['reviews'][0]['operations'][0].update(declarationIds=[999]),lambda c,v:v['reviews'][0]['operations'].append(v['reviews'][0]['operations'][0]),lambda c,v:v['reviews'][0]['operations'].pop(),lambda c,v:v['reviews'][0]['operations'][0].update(api='GET /unknown'),lambda c,v:v['reviews'][0]['operations'][0].update(api='GET /v1/client/c')]
  for mutate in mutations:
   c,v=copy.deepcopy(self.c),copy.deepcopy(self.manifest);mutate(c,v)
   with self.assertRaises(ValueError):m.build(c,v)
 def test_no_fake_authority_baseline_or_unhashed_provenance(self):
  mutations=[lambda v:v['reviews'][0].update(activationEligible=True),lambda v:v['reviews'][0].update(activationEligible='true'),lambda v:v['reviews'][0].pop('activationEligible'),lambda v:v['reviews'][0].update(implementationCredits=1),lambda v:v['reviews'][0].update(retirementCredits=1),lambda v:v['provenance'][0].update(sourceReferences=[{'path':'unhashed.txt'}]),lambda v:v.update(noActivation=False),lambda v:v.update(baselineUniqueOperations=5),lambda v:v['reviews'][0].update(authorityDisposition='authorized'),lambda v:v['reviews'][0]['evidencePaths'].append('unhashed'),lambda v:v['provenance'].append({'api':'GET /unknown'}),lambda v:v['sourceHashes'].update({'../outside':'0'*64}),lambda v:v['reviews'].append(v['reviews'][0])]
  for mutate in mutations:
   v=copy.deepcopy(self.manifest);mutate(v)
   with self.assertRaises(ValueError):m.build(self.c,v)
 def test_cross_operation_declaration_collision_refused(self):
  self.c['operations'][1]['declarationIds']=[1]
  with self.assertRaisesRegex(ValueError,'reused'):m.build(self.c,self.manifest)
 def test_symlink_source_cannot_escape_repository(self):
  with tempfile.TemporaryDirectory() as d,tempfile.TemporaryDirectory() as outside:
   target=Path(outside)/'source.txt';target.write_bytes(b'evidence');(Path(d)/'source.txt').symlink_to(target)
   with self.assertRaisesRegex(ValueError,'escapes repository'):m.build(self.c,self.manifest,d)
 def test_cli_check_refuses_stale_artifacts_without_rewriting_them(self):
  with tempfile.TemporaryDirectory() as d:
   root=Path(d);(root/'scripts').mkdir();(root/'docs/api').mkdir(parents=True)
   script=root/'scripts/generate-workflow-contract-plan.py';script.write_text(Path(m.__file__).read_text())
   (root/'source.txt').write_bytes(b'evidence')
   (root/'docs/api/api-delivery-checklist.json').write_text(json.dumps(self.c))
   (root/'docs/api/workflow-contract-reviews.json').write_text(json.dumps(self.manifest))
   self.assertEqual(subprocess.run([sys.executable,str(script)],capture_output=True).returncode,0)
   self.assertEqual(subprocess.run([sys.executable,str(script),'--check'],capture_output=True).returncode,0)
   out=root/'docs/api/WORKFLOW_CONTRACT_PLAN.md';out.write_text('stale')
   self.assertNotEqual(subprocess.run([sys.executable,str(script),'--check'],capture_output=True).returncode,0)
   self.assertEqual(out.read_text(),'stale')
 def test_markdown_explains_policies_and_zero_activation(self):
  text=m.render(m.build(self.c,self.manifest));self.assertIn('Define actor and response contract',text);self.assertIn('zero API',text);self.assertIn('No endpoints are activated',text)
class SourceAmendmentTests(unittest.TestCase):
 def setUp(self):
  self.c,self.manifest=fixtures();self.old='evidence';self.new='reviewed evidence'
  self.doc={'version':1,'noActivation':True,'implementationCredits':0,'retirementCredits':0,'reviewedAtCommit':'a'*40,'scope':'Only the inspected source change; no authority or operation status change.','entries':[{'path':'source.txt','baselineCommit':'b'*40,'baselineSha256':hashlib.sha256(self.old.encode()).hexdigest(),'reviewedSha256':hashlib.sha256(self.new.encode()).hexdigest(),'reason':'Inspected exact source change; existing unresolved operations remain unresolved.','hunks':[{'before':self.old,'after':self.new}]}]}
 def write(self,root,doc=None,text=None):
  root=Path(root);(root/'docs/api').mkdir(parents=True,exist_ok=True)
  (root/'source.txt').write_text(self.new if text is None else text)
  (root/'docs/api/workflow-contract-source-amendments.json').write_text(json.dumps(self.doc if doc is None else doc))
 def test_exact_amendment_preserves_entire_plan_and_historical_hashes(self):
  with tempfile.TemporaryDirectory() as root:
   self.write(root);before=copy.deepcopy(self.manifest)
   self.assertEqual(m.build(self.c,self.manifest,root),m.build(self.c,self.manifest))
   self.assertEqual(self.manifest,before)
 def test_extra_drift_reversion_and_deleted_source_remain_errors(self):
  with tempfile.TemporaryDirectory() as root:
   for text in [self.new+' extra unauthorized code',self.old,self.new+'\n']:
    self.write(root,text=text)
    with self.assertRaisesRegex(ValueError,'amendment changed'):m.build(self.c,self.manifest,root)
   Path(root,'source.txt').unlink()
   with self.assertRaisesRegex(ValueError,'Source evidence changed'):m.build(self.c,self.manifest,root)
 def test_hash_update_without_exact_baseline_reconstruction_is_rejected(self):
  with tempfile.TemporaryDirectory() as root:
   doc=copy.deepcopy(self.doc);doc['entries'][0]['hunks'][0]['before']='not the reviewed baseline';self.write(root,doc)
   with self.assertRaisesRegex(ValueError,'exceeds reviewed scope'):m.build(self.c,self.manifest,root)
 def test_ambiguous_reverse_patch_cannot_choose_an_occurrence(self):
  with tempfile.TemporaryDirectory() as root:
   text='changed changed';doc=copy.deepcopy(self.doc);doc['entries'][0]['reviewedSha256']=hashlib.sha256(text.encode()).hexdigest();doc['entries'][0]['hunks']=[{'before':'evidence','after':'changed'}];self.write(root,doc,text)
   with self.assertRaisesRegex(ValueError,'Ambiguous source amendment'):m.build(self.c,self.manifest,root)
 def test_authority_flags_scope_duplicates_unknown_sources_and_malformed_hunks_are_rejected(self):
  mutations=[lambda d:d.update(noActivation=False),lambda d:d.update(implementationCredits=1),lambda d:d.update(retirementCredits=1),lambda d:d.update(implementationCredits=False),lambda d:d.update(version=True),lambda d:d.update(activationEligible=True),lambda d:d.update(entries=[]),lambda d:d.update(reviewedAtCommit='not a commit'),lambda d:d['entries'].append(copy.deepcopy(d['entries'][0])),lambda d:d['entries'][0].update(path='../source.txt'),lambda d:d['entries'][0].update(path='unknown.txt'),lambda d:d['entries'][0].update(baselineSha256='0'*64),lambda d:d['entries'][0].update(reviewedSha256=d['entries'][0]['baselineSha256']),lambda d:d['entries'][0].update(reason=''),lambda d:d['entries'][0].update(hunks=[]),lambda d:d['entries'][0]['hunks'][0].update(after=''),lambda d:d['entries'][0]['hunks'][0].update(before=1)]
  with tempfile.TemporaryDirectory() as root:
   for mutate in mutations:
    doc=copy.deepcopy(self.doc);mutate(doc);self.write(root,doc)
    with self.assertRaises(ValueError):m.build(self.c,self.manifest,root)
 def test_amendment_document_cannot_be_a_symlink_outside_repository(self):
  with tempfile.TemporaryDirectory() as root,tempfile.TemporaryDirectory() as outside:
   self.write(root);path=Path(root,'docs/api/workflow-contract-source-amendments.json');target=Path(outside,'amendments.json');target.write_text(path.read_text());path.unlink();path.symlink_to(target)
   with self.assertRaisesRegex(ValueError,'document escapes'):m.build(self.c,self.manifest,root)

if __name__=='__main__':unittest.main()
