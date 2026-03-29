const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, 'src/routes/psw_dashboard.ts');
let content = fs.readFileSync(filePath, 'utf8');

content = content.replace(/import \{ PrismaClient \} from "@prisma\/client\/edge";/, "import { Bindings, Variables } from '../bindings';");
content = content.replace(/import \{ withAccelerate \} from "@prisma\/extension-accelerate";/, "");
content = content.replace(/const pswDashboardRouter = new OpenAPIHono\(\);/, "const pswDashboardRouter = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();");

content = content.replaceAll(
  /const prisma = new PrismaClient\(.*?withAccelerate\(\);/g, 
  "const prisma = c.get('prisma');"
);

fs.writeFileSync(filePath, content, 'utf8');
