"""Build the founder's readable guide from checked project documentation and fixture screenshots."""
from pathlib import Path
import argparse,json,re
from xml.sax.saxutils import escape
from reportlab.platypus import SimpleDocTemplate,Paragraph,Spacer,Table,TableStyle,PageBreak,Image,Flowable
from reportlab.lib.styles import getSampleStyleSheet,ParagraphStyle
from reportlab.lib.colors import HexColor,white
from reportlab.lib.pagesizes import A4
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
pdfmetrics.registerFont(TTFont('PCSans','/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf'))
pdfmetrics.registerFont(TTFont('PCSansBold','/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf'))
ROOT=Path(__file__).resolve().parents[1]
TEAL=HexColor('#107B77');INK=HexColor('#18343E');PALE=HexColor('#EFF8F7');MUTED=HexColor('#516771')
styles=getSampleStyleSheet()
styles.add(ParagraphStyle(name='BodyPC',fontName='PCSans',fontSize=10.5,leading=15,textColor=INK,spaceAfter=9))
styles.add(ParagraphStyle(name='SmallPC',fontName='PCSans',fontSize=8.5,leading=11,textColor=MUTED,spaceAfter=5))
styles.add(ParagraphStyle(name='TitlePC',fontName='PCSansBold',fontSize=27,leading=33,textColor=INK,spaceAfter=15))
styles.add(ParagraphStyle(name='HeadPC',fontName='PCSansBold',fontSize=18,leading=23,textColor=TEAL,spaceAfter=15))
styles.add(ParagraphStyle(name='CellPC',fontName='PCSans',fontSize=9,leading=12,textColor=INK))
W,H=A4;usable=W-80

def para(text,style='BodyPC'):return Paragraph(text,styles[style])
def grid(rows,widths):
 table=Table([[para(escape(str(v)),'CellPC') for v in row] for row in rows],colWidths=widths,repeatRows=1,hAlign='LEFT')
 table.setStyle(TableStyle([('BACKGROUND',(0,0),(-1,0),PALE),('VALIGN',(0,0),(-1,-1),'TOP'),('LEFTPADDING',(0,0),(-1,-1),8),('RIGHTPADDING',(0,0),(-1,-1),8),('TOPPADDING',(0,0),(-1,-1),8),('BOTTOMPADDING',(0,0),(-1,-1),8),('LINEBELOW',(0,0),(-1,0),1,TEAL),('LINEBELOW',(0,1),(-1,-1),.35,HexColor('#D9E5E7'))]))
 return table
class BusinessFlow(Flowable):
 def __init__(self):super().__init__();self.width=usable;self.height=530
 def draw(self):
  c=self.canv
  def box(x,y,w,title,note):
   c.setFillColor(PALE);c.setStrokeColor(TEAL);c.roundRect(x,y,w,54,8,fill=1,stroke=1)
   p=para(escape(title),'CellPC');p.wrap(w-18,30);p.drawOn(c,x+9,y+34)
   p=Paragraph(escape(note),styles['SmallPC']);pw,ph=p.wrap(w-18,27);p.drawOn(c,x+9,y+6)
  def arrow(x,y,x2,y2):
   c.setStrokeColor(TEAL);c.setLineWidth(1.4);c.line(x,y,x2,y2);c.line(x2,y2,x2-4,y2+6);c.line(x2,y2,x2+4,y2+6)
  half=(usable-24)/2
  box(120,467,usable-240,'Consented lead intake','Website, QR, referral; manual digital sources')
  arrow(usable/2,467,half/2,437);arrow(usable/2,467,half+24+half/2,437)
  left=[('Client needs assessment','Caller follows up; coordinator records appointment'),('Agreement and client setup','CRM evidence; existing authorized care account'),('Existing care workflow','Staffing and visits created in the care system'),('Care link and manual ledger','Read current visit status; invoice, payment, refund')]
  right=[('Partner discussion and demo','Nurse, retired nurse or care business entrepreneur'),('Pilot and human verification','Identity, agreement and insurance review references'),('Global tenant activation','Central/platform admin creates tenant and admin'),('Tenant owner runs local operations','Own growth dashboard, staff accounts and marketing')]
  for i,(a,b) in enumerate(zip(left,right)):
   y=365-i*82;box(0,y,half,*a);box(half+24,y,half,*b)
   if i<3:arrow(half/2,y,half/2,y-28);arrow(half+24+half/2,y,half+24+half/2,y-28)
  box(80,24,usable-160,'Founder reviews targets, gaps and cash','Assign an owner and deadline; check results next week')
  arrow(half/2,119,usable/2,78);arrow(half+24+half/2,119,usable/2,78)

def footer(c,doc):
 c.setStrokeColor(HexColor('#D9E5E7'));c.line(40,36,W-40,36);c.setFont('Helvetica',8);c.setFillColor(MUTED);c.drawString(40,23,'PrimeCare | Business operations guide | 14 October 2026');c.drawRightString(W-40,23,str(doc.page))

def build(output):
 seed=json.loads((ROOT/'docs/marketing/growth-seed.json').read_text());story=[]
 def heading(text):story.append(para(text,'HeadPC'))
 def body(text):story.append(para(text))
 def page():story.append(PageBreak())
 story+=[Spacer(1,35),para('PrimeCare<br/>Business Operations Guide','TitlePC'),para('One founder. Two acquisition pipelines.<br/>Clear owners, follow-ups and business records.','HeadPC'),Spacer(1,18)]
 body('The remaining work that can run locally has been implemented and checked. The app now includes reminders, source/employee reports, PDF downloads, controlled email handling, distinct administrator roles, partner activation, existing care-visit links and a manual CAD finance ledger.')
 body('<b>This is a locally tested build.</b> It is not a published production service. Google/Meta/telephone accounts, live mail, production access, standard PostgreSQL CI and physical devices still need their stated prerequisites.')
 story.append(grid([['Evidence','Result'],['Unit, auth, report, legacy route and bootstrap checks','103 passed'],['Local SQL scenarios','8 growth + 2 hierarchy scenarios; PGlite, not PostgreSQL 16'],['Browser workflows','34 founder + 6 administrator workflows; EN / FR / ES'],['Native and live production acceptance','Not run; exact blockers listed in the task register']],[190,usable-190]))
 story.append(Spacer(1,18));body('All screenshots and test records in this guide are synthetic. They illustrate working flows and do not represent your actual clients, tenants, care delivery or revenue.')
 page();heading('How the business runs');story.append(BusinessFlow());body('Marketing milestones remain recorded CRM evidence. A clinical visit is managed in the existing care workflow; linking it does not create care, assign a provider or prove that care was delivered.')
 page();heading('Targets and the leads you need')
 body('Starting dashboard targets are editable planning assumptions. No real business achievement is known from the test environment. Set a period, enter targets, and compare recorded acquisitions with the expected pace.')
 rows=[['Pipeline','Starting targets in order'],['Partner / tenant','20 enquiries → 5 discussions → 2 demos → 1 pilot → 1 active partner'],['Client','30 enquiries → 12 assessments → 6 agreements → 3 started → 3 recurring']]
 story.append(grid(rows,[130,usable-130]));story.append(Spacer(1,14))
 body('<b>Required leads = round up(desired acquired clients ÷ measured lead-to-client conversion).</b> The examples below use assumptions, not a promised conversion rate.')
 story.append(grid([['Goal','Assumed conversion','Required leads'],['3 recurring clients','10%','30'],['10 recurring clients','10%','100'],['20 recurring clients','10%','200'],['10 recurring clients','5%','200'],['10 recurring clients','20%','50'],['1 active partner','5%','20'],['6 active partners','5%','120']],[180,180,usable-360]))
 story.append(Spacer(1,12));body('Invite suitable partner prospects through consent-based discussions, demos and a pilot. Active or retired nurses can be business owners. Record identity, agreement and insurance reviews. These reviews do not grant clinical credentials. Only a global administrator provisions the approved tenant and tenant administrator.')
 body('A tenant administrator can run the growth dashboard within their own tenant, recruit eligible local staff, create client enquiry links and coordinate marketing/callers. They cannot create global tenants or promote global administrators.')
 page();heading('Who owns each part of the flow')
 story.append(grid([['Role','Responsibility and limit'],['Central administrator','Global tenant/account provisioning; may manage platform administrators. Central peers require protected operator bootstrap.'],['Platform administrator','Global tenant provisioning and eligible local accounts; cannot create or modify global peers.'],['Tenant administrator / founder','Own active tenant: growth targets, leads, campaigns, reminders, business reviews, care links, ledger and eligible staff accounts.'],['Marketing lead','Own tenant acquisition campaigns, source/owner reports, caller coordination, tasks and enquiry links. No founder finance/verification authority.'],['Telephone caller / coordinator','Assigned lead contacts and own appointments/tasks; record calls and requested callbacks.'],['Google / Meta / SEO / offline specialist','Permitted sources and own campaign briefs/tasks. No general access to client contacts.']],[145,usable-145]))
 story.append(Spacer(1,12));body('Unknown report email outcomes stay in the delivery log and cannot be blindly resent. The actor must reconcile the result with evidence. Provider acceptance is not proof that the recipient received the report. No real invitations, calls, advertisements or emails were sent by these tests.')
 page();heading('Numbered task register: 1–15')
 checklist=(ROOT/'docs/marketing/NUMBERED_TASK_CHECKLIST.md').read_text();records=[]
 for line in checklist.splitlines():
  match=re.match(r'^\| (\d+) \| ([^|]+) \| (.+) \|$',line)
  if match:records.append((int(match[1]),match[2].strip(),match[3].strip()))
 story.append(grid([['No.','Task','Result']]+[[n,task,'Built and checked locally'] for n,task,status in records if n<=15],[35,330,usable-365]))
 page();heading('Numbered task register: 16–28')
 short={16:'Blocked: Google account/credentials',17:'Blocked: Meta account/credentials',18:'Blocked: telephone provider/access',19:'In-app reminders built; outbound automation needs provider',20:'Source/current-owner/caller reporting built locally',21:'PDF built; email code tested with mock binding; live setup needed',22:'Central/platform/tenant scope built and tested',23:'Manual review and atomic tenant/admin activation built',24:'Existing visit links built; clinical scheduling/delivery acceptance pending',25:'Manual CAD ledger/CAC built; bank/payment connections pending',26:'Blocked: Flutter/Dart and physical devices',27:'Local checks pass; PostgreSQL CI, Cypress, full accessibility/native pending',28:'Blocked: release credentials and approved private-source publication'}
 story.append(grid([['No.','Task','Result']]+[[n,task,short[n]] for n,task,status in records if n>=16],[35,220,usable-255]))
 page();heading('Daily management and the independence goal')
 for title,detail in [('Start of day','Review callbacks, near appointments and overdue/escalated tasks. Each action needs an owner.'),('Weekly funnel review','Find the stage with the biggest gap. Check contact speed, assessment attendance, agreement objections or capacity. Assign a specific corrective task with evidence.'),('Weekly finance review','Record invoices, received payments, refunds and operating costs. Campaign spending is separate. Outstanding = invoiced − received + refunded.'),('Partner review','Check verification and provisioning state. A contact change invalidates the earlier review. Revoked reviews may be corrected and reviewed again.')]:body('<b>'+title+'</b><br/>'+detail)
 body('The ledger is append-only and manual. Cash after recorded costs is not a bank balance or profit statement. Acquisition cost per paying CRM lead uses recorded lifetime campaign spend and lead records with positive net receipts, not verified unique patients.')
 body('<b>There is no defensible “independent in X years” forecast yet.</b> Use a 2–3 year planning horizon only as a scenario: year 1 validates one service area and the funnel; year 2 delegates callers, marketing and care coordination; year 3 reduces founder involvement if the business has sustained cash coverage, staffing reliability and acceptable care-quality evidence.')
 body('A stronger independence test is six consecutive months of recorded cash covering recurring costs and owner pay, plus accountable team owners and verified care-quality/retention measures. Those thresholds are planning criteria, not results already achieved by this app.')
 page();heading('What is needed for the live release')
 for title,detail in [('Marketing and phone accounts','Authorized Google Ads and Meta lead-form access; a chosen telephone provider, number and credentials.'),('Mail and production','Approved sender/recipient configuration, database/Worker deployment credentials and a release window.'),('Acceptance checks','Run PostgreSQL 16 CI with the real pg driver, Cypress and full accessibility checks, native/device acceptance and an authenticated staging-to-production smoke test.'),('Care and payments','Test real staffing/scheduling/care flows and the payment/bank systems independently. The marketing build only links existing visits and keeps manual accounting records.')]:body('<b>'+title+'</b><br/>'+detail)
 body('Publishing remains blocked: automatic approval review previously rejected pushing the private source repository to GitHub. Local commits retain the work. No push or deployment is claimed.')
 body('If the running service reports “Missing or invalid access token”, sign in again to obtain an active session. The app rejects expired/revoked sessions. A local screenshot or PDF does not provide a production login or prove the live service has been fixed.')
 body('Use the numbered register to finish dependencies in order: account access → real CI → staging migrations/API → website → live flow acceptance. The earlier engineering planning windows were 2–4 weeks for core live acceptance and 6–10 weeks total for connected marketing; access and native requirements can extend them. No calendar completion promise is made.')
 images=[('Founder targets and gaps','growth-light-preview.png'),('Caller work queue','caller-workspace-preview.png'),('Task reassignment and escalation','task-management-preview.png'),('Campaign review','campaign-review-preview.png'),('Public enquiry form','public-enquiry-preview.png'),('Offline and referral QR intake','offline-referral-qr-preview.png'),('Source and owner performance report','performance-report-preview.png'),('Partner tenant activation','partner-provisioning-preview.png'),('Tenant administrator console','tenant-admin-preview.png'),('Tenant owner growth dashboard','tenant-growth-preview.png'),('Verification and manual finance','business-operations-preview.png')]
 for title,name in images:
  file=ROOT/'docs/marketing/images'/name
  if not file.exists():raise RuntimeError('Missing verified screenshot '+name)
  page();heading(title);body('Synthetic browser fixture. Local implementation evidence; not production results.')
  image=Image(str(file));factor=min(usable/image.imageWidth,610/image.imageHeight);image.drawWidth=image.imageWidth*factor;image.drawHeight=image.imageHeight*factor;story.append(image)
 output.parent.mkdir(parents=True,exist_ok=True)
 SimpleDocTemplate(str(output),pagesize=A4,leftMargin=40,rightMargin=40,topMargin=40,bottomMargin=48,title='PrimeCare Business Operations Guide',author='PrimeCare project').build(story,onFirstPage=footer,onLaterPages=footer)
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);build(p.parse_args().output)
