// Native disposable GitHub Actions PostgreSQL service only. No external DSN.
const {randomUUID}=require('node:crypto');
const {Client}=require(process.env.CLINICAL_FIXTURE_PG_MODULE);
exports.PGlite=class NativeFixture {
 constructor(){
  if(process.env.GITHUB_ACTIONS!=='true'||process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL)
   throw Error('Disposable GitHub Actions PostgreSQL required');
  this.db=new Client({host:'127.0.0.1',port:5432,database:'clinical_fixture',user:'clinical_fixture',password:'fixture-only'});
  this.schema='clinical_fixture_'+randomUUID().replaceAll('-','');
  this.ready=this.db.connect().then(async()=>{
   await this.db.query('CREATE SCHEMA '+this.schema);
   await this.db.query('SET search_path TO '+this.schema);
  });
 }
 async exec(sql){await this.ready;return this.db.query(sql);}
 async query(sql,args){await this.ready;return this.db.query(sql,args);}
 async close(){
  try {await this.ready;await this.db.query('DROP SCHEMA '+this.schema+' CASCADE');}
  finally {await this.db.end();}
 }
};
