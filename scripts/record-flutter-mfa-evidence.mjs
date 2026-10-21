import pg from 'pg';
import {readFileSync} from 'node:fs';
import {createHash} from 'node:crypto';
import {validateFlutterMfaReceipt} from './validate-flutter-mfa-receipt.mjs';
const pin = JSON.parse(readFileSync('tools/governance-production/production-pin.json'));
const definition = readFileSync('tools/governance-production/mfa-native-surface.json');
const expected = {optInVariable: 'RECORD_FLUTTER_MFA_EVIDENCE', tables: ['screen_components', 'platform_hierarchy_policy'],
  screenId: 949, componentPrefix: 'authMfa.native.', definitionSha256: createHash('sha256').update(definition).digest('hex'),
  reviewApprovals: false, productionReadyCredit: false, accountChanges: false};
if (JSON.stringify(pin.flutterMfaEvidenceWriter) !== JSON.stringify(expected) ||
    process.env.RECORD_FLUTTER_MFA_EVIDENCE !== '1' || !/^[a-z0-9_]+$/.test(pin.schema)) {
  throw Error('Exact native MFA evidence scope required');
}
const receipt = JSON.parse(readFileSync('test-results/live-flutter-mfa/receipt.json'));
validateFlutterMfaReceipt(receipt, process.env.MFA_PRODUCER_SHA);
if (!/^[0-9]+$/.test(process.env.MFA_PRODUCER_RUN ?? '')) throw Error('Producer identity required');
const db = new pg.Client({connectionString: process.env.PRODUCTION_DATABASE_URL, ssl: {rejectUnauthorized: true}});
await db.connect();
try {
  await db.query('BEGIN');
  const schema = '"' + pin.schema + '"';
  const manifest = await db.query(`SELECT manifest_sha256 FROM ${schema}.govt_source_manifest`);
  if (manifest.rows.length !== 1 || manifest.rows[0].manifest_sha256 !== pin.manifestSha256) throw Error('Governance authority mismatch');
  await db.query(`LOCK TABLE ${schema}.govt_screen_components,${schema}.govt_platform_hierarchy_policy IN SHARE ROW EXCLUSIVE MODE`);
  const controls = Object.keys(JSON.parse(definition).controls).map(k => 'authMfa.native.' + k);
  const updated = await db.query(`UPDATE ${schema}.govt_screen_components SET implementation_status='implemented-scoped-tested'
    WHERE screen_id=949 AND component_code=ANY($1::text[]) AND file_path=$2
    AND implementation_status IN ('registered-unimplemented','implemented-scoped-tested') RETURNING component_code`,
    [controls, 'packages/primecare_ui/lib/src/features/auth/mfa_form.dart']);
  if (updated.rows.length !== controls.length) throw Error('Native MFA metadata drift');
  const id = 'flutter-mfa-live-evidence-v1:' + receipt.source;
  const proof = {...receipt, scope: 'Deployed Flutter Code Admin MFA', reviewApprovals: false,
    wholePlatformAuthVerified: false, producerRun: process.env.MFA_PRODUCER_RUN};
  const existing = await db.query(`SELECT definition FROM ${schema}.govt_platform_hierarchy_policy WHERE id=$1`, [id]);
  if (!existing.rows.length) {
    await db.query(`INSERT INTO ${schema}.govt_platform_hierarchy_policy(_primecare_import_row,id,definition,requirement)
      SELECT COALESCE(MAX(_primecare_import_row),-1)+1,$1,$2,$3 FROM ${schema}.govt_platform_hierarchy_policy`,
      [id, JSON.stringify(proof), 'Live Flutter MFA scoped proof; no independent approval or whole-auth acceptance.']);
  } else if (existing.rows.length !== 1 || JSON.stringify(JSON.parse(existing.rows[0].definition)) !== JSON.stringify(proof)) {
    throw Error('Preserve existing source-bound proof');
  }
  await db.query('COMMIT');
  console.log('FLUTTER_MFA_EVIDENCE ' + JSON.stringify({controls: updated.rows.length,
    source: receipt.source, independentApprovals: false, wholePlatformAuthVerified: false}));
} catch {
  await db.query('ROLLBACK');
  throw Error('Native MFA evidence failed; metadata preserved');
} finally {await db.end();}
