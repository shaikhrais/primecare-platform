"""Explicit CI-only reconstruction of historical test data, never live authority."""
import hashlib,json,os,pathlib,subprocess,tempfile
ROOT=pathlib.Path(__file__).resolve().parents[2]
SOURCE_COMMIT='64324c5915945afa97426c30157ce0080496ba83'
SOURCE_PATH='.agents/governance/governance.db'
SHA256='42d350b6b3ab46540cbc58f2696d896f3afe6658b1f5153bec410dfce87d1262'
def prepare(root=ROOT):
 if os.environ.get('CI')!='true' or os.environ.get('GOVERNANCE_ALLOW_SQLITE_FIXTURES')!='1':raise RuntimeError('Historical SQLite reconstruction requires explicit isolated CI fixture mode')
 if any(os.environ.get(k) for k in ('GOVERNANCE_DATABASE_URL','PRODUCTION_DATABASE_URL')):raise RuntimeError('Production credentials cannot coexist with SQLite fixture reconstruction')
 source=SOURCE_COMMIT+':'+SOURCE_PATH
 found=subprocess.run(['git','cat-file','-e',source],cwd=root,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL)
 if found.returncode:subprocess.run(['git','fetch','--no-tags','--depth=1','origin',SOURCE_COMMIT],cwd=root,check=True,stdout=subprocess.DEVNULL)
 data=subprocess.check_output(['git','show',source],cwd=root)
 if hashlib.sha256(data).hexdigest()!=SHA256:raise RuntimeError('Historical fixture hash mismatch')
 target=root/SOURCE_PATH
 if any(p.is_symlink() for p in (target,*target.parents)):raise RuntimeError('Fixture path cannot contain symlinks')
 if target.exists():
  if not target.is_file() or hashlib.sha256(target.read_bytes()).hexdigest()!=SHA256:raise RuntimeError('Unknown local data preserved; fixture installation refused')
 else:
  target.parent.mkdir(parents=True,exist_ok=True)
  with tempfile.NamedTemporaryFile(dir=target.parent,delete=False) as file:
   staging=pathlib.Path(file.name);file.write(data);file.flush();os.fsync(file.fileno())
  try:os.link(staging,target)
  finally:staging.unlink(missing_ok=True)
 return {'source':'explicit-historical-ci-fixture','sourceCommit':SOURCE_COMMIT,'sha256':SHA256,'liveAuthority':False}
if __name__=='__main__':
 try:print(json.dumps(prepare()))
 except (RuntimeError,OSError,subprocess.CalledProcessError) as error:raise SystemExit(str(error))
