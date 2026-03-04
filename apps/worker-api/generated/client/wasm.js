
Object.defineProperty(exports, "__esModule", { value: true });

const {
  PrismaClientKnownRequestError,
  PrismaClientUnknownRequestError,
  PrismaClientRustPanicError,
  PrismaClientInitializationError,
  PrismaClientValidationError,
  NotFoundError,
  getPrismaClient,
  sqltag,
  empty,
  join,
  raw,
  skip,
  Decimal,
  Debug,
  objectEnumValues,
  makeStrictEnum,
  Extensions,
  warnOnce,
  defineDmmfProperty,
  Public,
  getRuntime
} = require('./runtime/wasm.js')


const Prisma = {}

exports.Prisma = Prisma
exports.$Enums = {}

/**
 * Prisma Client JS version: 5.22.0
 * Query Engine version: 605197351a3c8bdd595af2d2a9bc3025bca48ea2
 */
Prisma.prismaVersion = {
  client: "5.22.0",
  engine: "605197351a3c8bdd595af2d2a9bc3025bca48ea2"
}

Prisma.PrismaClientKnownRequestError = PrismaClientKnownRequestError;
Prisma.PrismaClientUnknownRequestError = PrismaClientUnknownRequestError
Prisma.PrismaClientRustPanicError = PrismaClientRustPanicError
Prisma.PrismaClientInitializationError = PrismaClientInitializationError
Prisma.PrismaClientValidationError = PrismaClientValidationError
Prisma.NotFoundError = NotFoundError
Prisma.Decimal = Decimal

/**
 * Re-export of sql-template-tag
 */
Prisma.sql = sqltag
Prisma.empty = empty
Prisma.join = join
Prisma.raw = raw
Prisma.validator = Public.validator

/**
* Extensions
*/
Prisma.getExtensionContext = Extensions.getExtensionContext
Prisma.defineExtension = Extensions.defineExtension

/**
 * Shorthand utilities for JSON filtering
 */
Prisma.DbNull = objectEnumValues.instances.DbNull
Prisma.JsonNull = objectEnumValues.instances.JsonNull
Prisma.AnyNull = objectEnumValues.instances.AnyNull

Prisma.NullTypes = {
  DbNull: objectEnumValues.classes.DbNull,
  JsonNull: objectEnumValues.classes.JsonNull,
  AnyNull: objectEnumValues.classes.AnyNull
}





/**
 * Enums
 */
exports.Prisma.TransactionIsolationLevel = makeStrictEnum({
  ReadUncommitted: 'ReadUncommitted',
  ReadCommitted: 'ReadCommitted',
  RepeatableRead: 'RepeatableRead',
  Serializable: 'Serializable'
});

exports.Prisma.UserScalarFieldEnum = {
  id: 'id',
  email: 'email',
  phone: 'phone',
  passwordHash: 'passwordHash',
  status: 'status',
  resetToken: 'resetToken',
  resetTokenExpiry: 'resetTokenExpiry',
  lastLoginAt: 'lastLoginAt',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  tenantId: 'tenantId',
  roles: 'roles'
};

exports.Prisma.TenantScalarFieldEnum = {
  id: 'id',
  name: 'name',
  slug: 'slug',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  businessNumber: 'businessNumber',
  supportEmail: 'supportEmail',
  logoUrl: 'logoUrl',
  taxSettings: 'taxSettings',
  brandingConfig: 'brandingConfig',
  stripeAccountId: 'stripeAccountId',
  onboardingStep: 'onboardingStep',
  parentTenantId: 'parentTenantId'
};

exports.Prisma.ApiKeyScalarFieldEnum = {
  id: 'id',
  key: 'key',
  name: 'name',
  status: 'status',
  tenantId: 'tenantId',
  createdAt: 'createdAt',
  lastUsedAt: 'lastUsedAt'
};

exports.Prisma.ClientProfileScalarFieldEnum = {
  id: 'id',
  userId: 'userId',
  fullName: 'fullName',
  dob: 'dob',
  addressLine1: 'addressLine1',
  addressLine2: 'addressLine2',
  city: 'city',
  province: 'province',
  postalCode: 'postalCode',
  lat: 'lat',
  lng: 'lng',
  emergencyName: 'emergencyName',
  emergencyPhone: 'emergencyPhone',
  preferences: 'preferences',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  tenantId: 'tenantId'
};

exports.Prisma.PswProfileScalarFieldEnum = {
  id: 'id',
  userId: 'userId',
  fullName: 'fullName',
  bio: 'bio',
  languages: 'languages',
  serviceAreas: 'serviceAreas',
  availabilityJson: 'availabilityJson',
  isApproved: 'isApproved',
  approvedAt: 'approvedAt',
  createdAt: 'createdAt',
  tenantId: 'tenantId',
  address: 'address',
  avatarUrl: 'avatarUrl',
  skills: 'skills'
};

exports.Prisma.VisitScalarFieldEnum = {
  id: 'id',
  clientId: 'clientId',
  serviceId: 'serviceId',
  requestedStartAt: 'requestedStartAt',
  durationMinutes: 'durationMinutes',
  status: 'status',
  assignedPswId: 'assignedPswId',
  serviceAddressLine1: 'serviceAddressLine1',
  serviceAddressLine2: 'serviceAddressLine2',
  serviceCity: 'serviceCity',
  serviceProvince: 'serviceProvince',
  servicePostalCode: 'servicePostalCode',
  serviceLat: 'serviceLat',
  serviceLng: 'serviceLng',
  clientNotes: 'clientNotes',
  coordinatorNotes: 'coordinatorNotes',
  cancellationReason: 'cancellationReason',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  tenantId: 'tenantId',
  bookingId: 'bookingId',
  crisisMode: 'crisisMode',
  priority: 'priority',
  requiredSkills: 'requiredSkills',
  isSurgeActive: 'isSurgeActive',
  surgeMultiplier: 'surgeMultiplier'
};

exports.Prisma.ServiceScalarFieldEnum = {
  id: 'id',
  name: 'name',
  slug: 'slug',
  description: 'description',
  baseRateHourly: 'baseRateHourly',
  providerRateHourly: 'providerRateHourly',
  isActive: 'isActive',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  tenantId: 'tenantId',
  isFeatured: 'isFeatured'
};

exports.Prisma.VisitCheckEventScalarFieldEnum = {
  id: 'id',
  visitId: 'visitId',
  pswId: 'pswId',
  eventType: 'eventType',
  lat: 'lat',
  lng: 'lng',
  accuracyM: 'accuracyM',
  computedDistanceM: 'computedDistanceM',
  deviceTimeIso: 'deviceTimeIso',
  serverTime: 'serverTime',
  result: 'result',
  rejectReason: 'rejectReason',
  isOverride: 'isOverride',
  overrideByUserId: 'overrideByUserId',
  overrideReason: 'overrideReason',
  createdAt: 'createdAt',
  tenantId: 'tenantId'
};

exports.Prisma.VisitNoteScalarFieldEnum = {
  id: 'id',
  visitId: 'visitId',
  pswId: 'pswId',
  noteText: 'noteText',
  createdAt: 'createdAt'
};

exports.Prisma.VisitChecklistScalarFieldEnum = {
  id: 'id',
  visitId: 'visitId',
  pswId: 'pswId',
  checklistJson: 'checklistJson',
  createdAt: 'createdAt'
};

exports.Prisma.IncidentScalarFieldEnum = {
  id: 'id',
  visitId: 'visitId',
  reporterUserId: 'reporterUserId',
  type: 'type',
  description: 'description',
  status: 'status',
  resolutionNotes: 'resolutionNotes',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  tenantId: 'tenantId'
};

exports.Prisma.TimesheetScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  weekId: 'weekId',
  totalMinutes: 'totalMinutes',
  status: 'status',
  submittedAt: 'submittedAt',
  reviewedBy: 'reviewedBy',
  reviewedAt: 'reviewedAt',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  tenantId: 'tenantId'
};

exports.Prisma.TimesheetItemScalarFieldEnum = {
  id: 'id',
  timesheetId: 'timesheetId',
  visitId: 'visitId',
  minutes: 'minutes',
  createdAt: 'createdAt'
};

exports.Prisma.InvoiceScalarFieldEnum = {
  id: 'id',
  clientId: 'clientId',
  status: 'status',
  currency: 'currency',
  subtotal: 'subtotal',
  tax: 'tax',
  total: 'total',
  stripeInvoiceId: 'stripeInvoiceId',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  tenantId: 'tenantId'
};

exports.Prisma.PaymentScalarFieldEnum = {
  id: 'id',
  invoiceId: 'invoiceId',
  stripePaymentIntentId: 'stripePaymentIntentId',
  amount: 'amount',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.MessageThreadScalarFieldEnum = {
  id: 'id',
  threadType: 'threadType',
  clientId: 'clientId',
  pswId: 'pswId',
  createdAt: 'createdAt',
  tenantId: 'tenantId'
};

exports.Prisma.MessageScalarFieldEnum = {
  id: 'id',
  threadId: 'threadId',
  senderUserId: 'senderUserId',
  bodyText: 'bodyText',
  createdAt: 'createdAt'
};

exports.Prisma.AuditLogScalarFieldEnum = {
  id: 'id',
  actorUserId: 'actorUserId',
  action: 'action',
  resourceType: 'resourceType',
  resourceId: 'resourceId',
  metadataJson: 'metadataJson',
  ipAddress: 'ipAddress',
  createdAt: 'createdAt',
  tenantId: 'tenantId'
};

exports.Prisma.LeadScalarFieldEnum = {
  id: 'id',
  fullName: 'fullName',
  email: 'email',
  phone: 'phone',
  message: 'message',
  source: 'source',
  status: 'status',
  serviceInterest: 'serviceInterest',
  notes: 'notes',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.BookingScalarFieldEnum = {
  id: 'id',
  clientId: 'clientId',
  branchId: 'branchId',
  startAt: 'startAt',
  endAt: 'endAt',
  serviceType: 'serviceType',
  priority: 'priority',
  notes: 'notes',
  status: 'status',
  recurrenceRule: 'recurrenceRule',
  tenantId: 'tenantId'
};

exports.Prisma.PswAvailabilityScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  dayOfWeek: 'dayOfWeek',
  startTime: 'startTime',
  endTime: 'endTime',
  tenantId: 'tenantId'
};

exports.Prisma.ShiftAssignmentScalarFieldEnum = {
  id: 'id',
  visitId: 'visitId',
  pswId: 'pswId',
  status: 'status',
  score: 'score',
  assignedAt: 'assignedAt',
  tenantId: 'tenantId'
};

exports.Prisma.BlogPostScalarFieldEnum = {
  id: 'id',
  title: 'title',
  slug: 'slug',
  excerpt: 'excerpt',
  contentHtml: 'contentHtml',
  status: 'status',
  publishedAt: 'publishedAt',
  authorUserId: 'authorUserId',
  featureImageDocId: 'featureImageDocId',
  seoTitle: 'seoTitle',
  seoDescription: 'seoDescription',
  canonicalUrl: 'canonicalUrl',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  targetRole: 'targetRole',
  category: 'category'
};

exports.Prisma.StaffTaskScalarFieldEnum = {
  id: 'id',
  title: 'title',
  description: 'description',
  status: 'status',
  priority: 'priority',
  dueDate: 'dueDate',
  assigneeId: 'assigneeId',
  tenantId: 'tenantId',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.PswDocumentScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  docType: 'docType',
  fileKey: 'fileKey',
  status: 'status',
  expiryDate: 'expiryDate',
  verifiedBy: 'verifiedBy',
  verifiedAt: 'verifiedAt',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.FAQScalarFieldEnum = {
  id: 'id',
  question: 'question',
  answer: 'answer',
  category: 'category',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.DailyEntryScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  clientId: 'clientId',
  staffId: 'staffId',
  visitId: 'visitId',
  adlData: 'adlData',
  medication: 'medication',
  mood: 'mood',
  vitals: 'vitals',
  notes: 'notes',
  signature: 'signature',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.MarketplaceListingScalarFieldEnum = {
  id: 'id',
  title: 'title',
  description: 'description',
  price: 'price',
  category: 'category',
  providerId: 'providerId',
  tenantId: 'tenantId',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.FeedbackScalarFieldEnum = {
  id: 'id',
  clientId: 'clientId',
  visitId: 'visitId',
  rating: 'rating',
  comment: 'comment',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  tenantId: 'tenantId'
};

exports.Prisma.SortOrder = {
  asc: 'asc',
  desc: 'desc'
};

exports.Prisma.NullableJsonNullValueInput = {
  DbNull: Prisma.DbNull,
  JsonNull: Prisma.JsonNull
};

exports.Prisma.JsonNullValueInput = {
  JsonNull: Prisma.JsonNull
};

exports.Prisma.QueryMode = {
  default: 'default',
  insensitive: 'insensitive'
};

exports.Prisma.NullsOrder = {
  first: 'first',
  last: 'last'
};

exports.Prisma.JsonNullValueFilter = {
  DbNull: Prisma.DbNull,
  JsonNull: Prisma.JsonNull,
  AnyNull: Prisma.AnyNull
};
exports.Role = exports.$Enums.Role = {
  super_admin: 'super_admin',
  admin: 'admin',
  staff: 'staff',
  manager: 'manager',
  marketing_manager: 'marketing_manager',
  operations_manager: 'operations_manager',
  hr_manager: 'hr_manager',
  clinical_manager: 'clinical_manager',
  regional_manager: 'regional_manager',
  finance_manager: 'finance_manager',
  recruiting_manager: 'recruiting_manager',
  coordinator: 'coordinator',
  client: 'client',
  psw: 'psw',
  rn: 'rn',
  rmt: 'rmt',
  rpt: 'rpt',
  rch: 'rch',
  finance: 'finance',
  scrum_master: 'scrum_master'
};

exports.VisitStatus = exports.$Enums.VisitStatus = {
  requested: 'requested',
  scheduled: 'scheduled',
  assigned: 'assigned',
  en_route: 'en_route',
  arrived: 'arrived',
  in_progress: 'in_progress',
  completed: 'completed',
  cancelled: 'cancelled',
  draft: 'draft',
  posted: 'posted',
  offered: 'offered',
  accepted: 'accepted',
  no_show: 'no_show',
  replaced: 'replaced'
};

exports.EventType = exports.$Enums.EventType = {
  check_in: 'check_in',
  check_out: 'check_out'
};

exports.EventResult = exports.$Enums.EventResult = {
  success: 'success',
  rejected: 'rejected'
};

exports.IncidentType = exports.$Enums.IncidentType = {
  fall_risk: 'fall_risk',
  refusal: 'refusal',
  no_show: 'no_show',
  safety: 'safety',
  other: 'other'
};

exports.IncidentStatus = exports.$Enums.IncidentStatus = {
  open: 'open',
  investigating: 'investigating',
  resolved: 'resolved'
};

exports.TimesheetStatus = exports.$Enums.TimesheetStatus = {
  draft: 'draft',
  submitted: 'submitted',
  approved: 'approved',
  rejected: 'rejected'
};

exports.InvoiceStatus = exports.$Enums.InvoiceStatus = {
  draft: 'draft',
  unpaid: 'unpaid',
  paid: 'paid',
  void: 'void'
};

exports.AssignmentStatus = exports.$Enums.AssignmentStatus = {
  offered: 'offered',
  accepted: 'accepted',
  declined: 'declined',
  assigned: 'assigned'
};

exports.DocStatus = exports.$Enums.DocStatus = {
  pending: 'pending',
  verified: 'verified',
  rejected: 'rejected'
};

exports.DailyEntryStatus = exports.$Enums.DailyEntryStatus = {
  DRAFT: 'DRAFT',
  SUBMITTED: 'SUBMITTED'
};

exports.Prisma.ModelName = {
  User: 'User',
  Tenant: 'Tenant',
  ApiKey: 'ApiKey',
  ClientProfile: 'ClientProfile',
  PswProfile: 'PswProfile',
  Visit: 'Visit',
  Service: 'Service',
  VisitCheckEvent: 'VisitCheckEvent',
  VisitNote: 'VisitNote',
  VisitChecklist: 'VisitChecklist',
  Incident: 'Incident',
  Timesheet: 'Timesheet',
  TimesheetItem: 'TimesheetItem',
  Invoice: 'Invoice',
  Payment: 'Payment',
  MessageThread: 'MessageThread',
  Message: 'Message',
  AuditLog: 'AuditLog',
  Lead: 'Lead',
  Booking: 'Booking',
  PswAvailability: 'PswAvailability',
  ShiftAssignment: 'ShiftAssignment',
  BlogPost: 'BlogPost',
  StaffTask: 'StaffTask',
  PswDocument: 'PswDocument',
  FAQ: 'FAQ',
  DailyEntry: 'DailyEntry',
  MarketplaceListing: 'MarketplaceListing',
  Feedback: 'Feedback'
};
/**
 * Create the Client
 */
const config = {
  "generator": {
    "name": "client",
    "provider": {
      "fromEnvVar": null,
      "value": "prisma-client-js"
    },
    "output": {
      "value": "C:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform\\apps\\worker-api\\generated\\client",
      "fromEnvVar": null
    },
    "config": {
      "engineType": "library"
    },
    "binaryTargets": [
      {
        "fromEnvVar": null,
        "value": "windows",
        "native": true
      }
    ],
    "previewFeatures": [
      "driverAdapters"
    ],
    "sourceFilePath": "C:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform\\apps\\worker-api\\prisma\\schema.prisma",
    "isCustomOutput": true
  },
  "relativeEnvPaths": {
    "rootEnvPath": null,
    "schemaEnvPath": "../../.env"
  },
  "relativePath": "../../prisma",
  "clientVersion": "5.22.0",
  "engineVersion": "605197351a3c8bdd595af2d2a9bc3025bca48ea2",
  "datasourceNames": [
    "db"
  ],
  "activeProvider": "postgresql",
  "postinstall": false,
  "inlineDatasources": {
    "db": {
      "url": {
        "fromEnvVar": "DATABASE_URL",
        "value": null
      }
    }
  },
  "inlineSchema": "generator client {\n  provider        = \"prisma-client-js\"\n  previewFeatures = [\"driverAdapters\"]\n  output          = \"../generated/client\"\n}\n\ndatasource db {\n  provider = \"postgresql\"\n  url      = env(\"DATABASE_URL\")\n}\n\n// ==========================================\n// PLATFORM MODULES (Global Infrastructure)\n// ==========================================\n\nmodel User {\n  id                 String            @id @default(uuid())\n  email              String            @unique\n  phone              String?\n  passwordHash       String            @map(\"password_hash\")\n  status             String?           @default(\"active\")\n  resetToken         String?\n  resetTokenExpiry   DateTime?\n  lastLoginAt        DateTime?         @map(\"last_login_at\")\n  createdAt          DateTime          @default(now()) @map(\"created_at\")\n  updatedAt          DateTime          @updatedAt @map(\"updated_at\")\n  tenantId           String            @map(\"tenant_id\")\n  roles              Role[]            @default([client])\n  auditLogs          AuditLog[]\n  blogPosts          BlogPost[]\n  clientProfile      ClientProfile?\n  DailyEntry         DailyEntry[]\n  reportedIncidents  Incident[]        @relation(\"Reporter\")\n  sentMessages       Message[]\n  verifiedDocs       PswDocument[]     @relation(\"VerifiedBy\")\n  pswProfile         PswProfile?\n  reviewedTimesheets Timesheet[]       @relation(\"ReviewedBy\")\n  tenant             Tenant            @relation(fields: [tenantId], references: [id])\n  VisitCheckEvent    VisitCheckEvent[]\n\n  @@index([tenantId])\n  @@map(\"users\")\n}\n\nmodel Tenant {\n  id               String            @id @default(uuid())\n  name             String\n  slug             String            @unique\n  status           String            @default(\"active\")\n  createdAt        DateTime          @default(now()) @map(\"created_at\")\n  updatedAt        DateTime          @updatedAt @map(\"updated_at\")\n  auditLogs        AuditLog[]\n  bookings         Booking[]\n  clientProfiles   ClientProfile[]\n  dailyEntries     DailyEntry[]\n  incidents        Incident[]\n  invoices         Invoice[]\n  messageThreads   MessageThread[]\n  pswAvailability  PswAvailability[]\n  pswProfiles      PswProfile[]\n  services         Service[]\n  shiftAssignments ShiftAssignment[]\n  timesheets       Timesheet[]\n  staffTasks       StaffTask[]\n  users            User[]\n  checkEvents      VisitCheckEvent[]\n  visits           Visit[]\n  apiKeys          ApiKey[]\n  feedbacks        Feedback[]\n\n  // Business Model Extensions\n  businessNumber  String? @map(\"business_number\")\n  supportEmail    String? @map(\"support_email\")\n  logoUrl         String? @map(\"logo_url\")\n  taxSettings     Json?   @map(\"tax_settings\")\n  brandingConfig  Json?   @map(\"branding_config\")\n  stripeAccountId String? @map(\"stripe_account_id\")\n  onboardingStep  Int     @default(1) @map(\"onboarding_step\")\n\n  // Fractal SaaS Extensions\n  parentTenantId      String?              @map(\"parent_tenant_id\")\n  parentTenant        Tenant?              @relation(\"TenantHierarchy\", fields: [parentTenantId], references: [id])\n  childTenants        Tenant[]             @relation(\"TenantHierarchy\")\n  marketplaceListings MarketplaceListing[]\n\n  @@map(\"tenants\")\n}\n\nmodel ApiKey {\n  id         String    @id @default(uuid())\n  key        String    @unique\n  name       String\n  status     String    @default(\"active\")\n  tenantId   String    @map(\"tenant_id\")\n  createdAt  DateTime  @default(now()) @map(\"created_at\")\n  lastUsedAt DateTime? @map(\"last_used_at\")\n  tenant     Tenant    @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"api_keys\")\n}\n\nmodel ClientProfile {\n  id             String          @id @default(uuid())\n  userId         String          @unique @map(\"user_id\")\n  fullName       String          @map(\"full_name\")\n  dob            DateTime?\n  addressLine1   String?         @map(\"address_line1\")\n  addressLine2   String?         @map(\"address_line2\")\n  city           String?\n  province       String?\n  postalCode     String?         @map(\"postal_code\")\n  lat            Float?\n  lng            Float?\n  emergencyName  String?         @map(\"emergency_contact_name\")\n  emergencyPhone String?         @map(\"emergency_contact_phone\")\n  preferences    Json?           @map(\"preferences_json\")\n  createdAt      DateTime        @default(now()) @map(\"created_at\")\n  updatedAt      DateTime        @updatedAt @map(\"updated_at\")\n  tenantId       String          @map(\"tenant_id\")\n  bookings       Booking[]\n  tenant         Tenant          @relation(fields: [tenantId], references: [id])\n  user           User            @relation(fields: [userId], references: [id])\n  DailyEntry     DailyEntry[]\n  invoices       Invoice[]\n  messageThreads MessageThread[]\n  visits         Visit[]\n  feedbacks      Feedback[]\n\n  @@index([tenantId])\n  @@map(\"client_profiles\")\n}\n\nmodel PswProfile {\n  id               String            @id @default(uuid())\n  userId           String            @unique @map(\"user_id\")\n  fullName         String            @map(\"full_name\")\n  bio              String?\n  languages        String[]\n  serviceAreas     String[]          @map(\"service_areas\")\n  availabilityJson Json?             @map(\"availability_json\")\n  isApproved       Boolean           @default(false) @map(\"is_approved\")\n  approvedAt       DateTime?         @map(\"approved_at\")\n  createdAt        DateTime          @default(now()) @map(\"created_at\")\n  tenantId         String            @map(\"tenant_id\")\n  address          String?\n  avatarUrl        String?           @map(\"avatar_url\")\n  skills           String[]          @default([])\n  messageThreads   MessageThread[]   @relation(\"PswToThreads\")\n  availability     PswAvailability[] @relation(\"PswToAvailability\")\n  documents        PswDocument[]     @relation(\"PswToDocuments\")\n  tenant           Tenant            @relation(fields: [tenantId], references: [id])\n  user             User              @relation(fields: [userId], references: [id])\n  assignments      ShiftAssignment[] @relation(\"PswToAssignments\")\n  timesheets       Timesheet[]       @relation(\"PswToTimesheets\")\n  checkEvents      VisitCheckEvent[] @relation(\"PswToCheckEvents\")\n  checklists       VisitChecklist[]  @relation(\"PswToChecklists\")\n  notes            VisitNote[]       @relation(\"PswToNotes\")\n  assignedVisits   Visit[]           @relation(\"PswToVisits\")\n\n  @@index([tenantId])\n  @@map(\"psw_profiles\")\n}\n\nmodel Visit {\n  id                  String            @id @default(uuid())\n  clientId            String            @map(\"client_id\")\n  serviceId           String            @map(\"service_id\")\n  requestedStartAt    DateTime          @map(\"requested_start_at\")\n  durationMinutes     Int               @map(\"duration_minutes\")\n  status              VisitStatus?      @default(requested)\n  assignedPswId       String?           @map(\"assigned_psw_id\")\n  serviceAddressLine1 String?           @map(\"service_address_line1\")\n  serviceAddressLine2 String?           @map(\"service_address_line2\")\n  serviceCity         String?           @map(\"service_city\")\n  serviceProvince     String?           @map(\"service_province\")\n  servicePostalCode   String?           @map(\"service_postal_code\")\n  serviceLat          Float?            @map(\"service_lat\")\n  serviceLng          Float?            @map(\"service_lng\")\n  clientNotes         String?           @map(\"client_notes\")\n  coordinatorNotes    String?           @map(\"coordinator_notes\")\n  cancellationReason  String?           @map(\"cancellation_reason\")\n  createdAt           DateTime          @default(now()) @map(\"created_at\")\n  updatedAt           DateTime          @updatedAt @map(\"updated_at\")\n  tenantId            String            @map(\"tenant_id\")\n  bookingId           String?           @map(\"booking_id\")\n  crisisMode          Boolean?          @default(false) @map(\"crisis_mode\")\n  priority            String?           @default(\"normal\")\n  requiredSkills      String[]          @map(\"required_skills\")\n  isSurgeActive       Boolean?          @default(false) @map(\"is_surge_active\")\n  surgeMultiplier     Float?            @default(1.0) @map(\"surge_multiplier\")\n  DailyEntry          DailyEntry[]\n  incidents           Incident[]\n  assignments         ShiftAssignment[]\n  timesheetItems      TimesheetItem[]\n  checkEvents         VisitCheckEvent[]\n  checklists          VisitChecklist[]\n  notes               VisitNote[]\n  feedbacks           Feedback[]\n  psw                 PswProfile?       @relation(\"PswToVisits\", fields: [assignedPswId], references: [id])\n  booking             Booking?          @relation(fields: [bookingId], references: [id])\n  client              ClientProfile     @relation(fields: [clientId], references: [id])\n  service             Service           @relation(fields: [serviceId], references: [id])\n  tenant              Tenant            @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"visits\")\n}\n\nmodel Service {\n  id                 String   @id @default(uuid())\n  name               String\n  slug               String   @unique\n  description        String?\n  baseRateHourly     Decimal? @map(\"base_rate_hourly\") @db.Decimal(10, 2)\n  providerRateHourly Decimal? @map(\"provider_rate_hourly\") @db.Decimal(10, 2)\n  isActive           Boolean? @default(true) @map(\"is_active\")\n  createdAt          DateTime @default(now()) @map(\"created_at\")\n  updatedAt          DateTime @updatedAt @map(\"updated_at\")\n  tenantId           String   @map(\"tenant_id\")\n  isFeatured         Boolean  @default(false) @map(\"is_featured\")\n  tenant             Tenant   @relation(fields: [tenantId], references: [id])\n  visits             Visit[]\n\n  @@index([tenantId])\n  @@map(\"services\")\n}\n\nmodel VisitCheckEvent {\n  id                String      @id @default(uuid())\n  visitId           String      @map(\"visit_id\")\n  pswId             String      @map(\"psw_id\")\n  eventType         EventType   @map(\"event_type\")\n  lat               Float?\n  lng               Float?\n  accuracyM         Float?      @map(\"accuracy_m\")\n  computedDistanceM Float?      @map(\"computed_distance_m\")\n  deviceTimeIso     DateTime?   @map(\"device_time_iso\")\n  serverTime        DateTime?   @default(now()) @map(\"server_time\")\n  result            EventResult\n  rejectReason      String?     @map(\"reject_reason\")\n  isOverride        Boolean?    @default(false) @map(\"is_override\")\n  overrideByUserId  String?     @map(\"override_by_user_id\")\n  overrideReason    String?     @map(\"override_reason\")\n  createdAt         DateTime    @default(now()) @map(\"created_at\")\n  tenantId          String      @map(\"tenant_id\")\n  overriddenBy      User?       @relation(fields: [overrideByUserId], references: [id])\n  pswProfile        PswProfile  @relation(\"PswToCheckEvents\", fields: [pswId], references: [id])\n  tenant            Tenant      @relation(fields: [tenantId], references: [id])\n  visit             Visit       @relation(fields: [visitId], references: [id])\n\n  @@map(\"visit_check_events\")\n}\n\nmodel VisitNote {\n  id        String     @id @default(uuid())\n  visitId   String     @map(\"visit_id\")\n  pswId     String     @map(\"psw_id\")\n  noteText  String     @map(\"note_text\")\n  createdAt DateTime   @default(now()) @map(\"created_at\")\n  psw       PswProfile @relation(\"PswToNotes\", fields: [pswId], references: [id])\n  visit     Visit      @relation(fields: [visitId], references: [id])\n\n  @@map(\"visit_notes\")\n}\n\nmodel VisitChecklist {\n  id            String     @id @default(uuid())\n  visitId       String     @map(\"visit_id\")\n  pswId         String     @map(\"psw_id\")\n  checklistJson Json       @map(\"checklist_json\")\n  createdAt     DateTime   @default(now()) @map(\"created_at\")\n  psw           PswProfile @relation(\"PswToChecklists\", fields: [pswId], references: [id])\n  visit         Visit      @relation(fields: [visitId], references: [id])\n\n  @@map(\"visit_checklists\")\n}\n\nmodel Incident {\n  id              String          @id @default(uuid())\n  visitId         String?         @map(\"visit_id\")\n  reporterUserId  String          @map(\"reporter_user_id\")\n  type            IncidentType\n  description     String\n  status          IncidentStatus? @default(open)\n  resolutionNotes String?         @map(\"resolution_notes\")\n  createdAt       DateTime        @default(now()) @map(\"created_at\")\n  updatedAt       DateTime        @updatedAt @map(\"updated_at\")\n  tenantId        String          @map(\"tenant_id\")\n  reporter        User            @relation(\"Reporter\", fields: [reporterUserId], references: [id])\n  tenant          Tenant          @relation(fields: [tenantId], references: [id])\n  visit           Visit?          @relation(fields: [visitId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"incidents\")\n}\n\nmodel Timesheet {\n  id           String           @id @default(uuid())\n  pswId        String           @map(\"psw_id\")\n  weekId       String           @map(\"week_id\")\n  totalMinutes Int?             @default(0) @map(\"total_minutes\")\n  status       TimesheetStatus? @default(draft)\n  submittedAt  DateTime?        @map(\"submitted_at\")\n  reviewedBy   String?          @map(\"reviewed_by\")\n  reviewedAt   DateTime?        @map(\"reviewed_at\")\n  createdAt    DateTime         @default(now()) @map(\"created_at\")\n  updatedAt    DateTime         @updatedAt @map(\"updated_at\")\n  tenantId     String           @map(\"tenant_id\")\n  items        TimesheetItem[]\n  psw          PswProfile       @relation(\"PswToTimesheets\", fields: [pswId], references: [id])\n  reviewer     User?            @relation(\"ReviewedBy\", fields: [reviewedBy], references: [id])\n  tenant       Tenant           @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"timesheets\")\n}\n\nmodel TimesheetItem {\n  id          String    @id @default(uuid())\n  timesheetId String    @map(\"timesheet_id\")\n  visitId     String    @map(\"visit_id\")\n  minutes     Int\n  createdAt   DateTime  @default(now()) @map(\"created_at\")\n  timesheet   Timesheet @relation(fields: [timesheetId], references: [id])\n  visit       Visit     @relation(fields: [visitId], references: [id])\n\n  @@map(\"timesheet_items\")\n}\n\nmodel Invoice {\n  id              String         @id @default(uuid())\n  clientId        String         @map(\"client_id\")\n  status          InvoiceStatus? @default(draft)\n  currency        String?        @default(\"CAD\")\n  subtotal        Decimal?       @db.Decimal(10, 2)\n  tax             Decimal?       @db.Decimal(10, 2)\n  total           Decimal?       @db.Decimal(10, 2)\n  stripeInvoiceId String?        @map(\"stripe_invoice_id\")\n  createdAt       DateTime       @default(now()) @map(\"created_at\")\n  updatedAt       DateTime       @updatedAt @map(\"updated_at\")\n  tenantId        String         @map(\"tenant_id\")\n  client          ClientProfile  @relation(fields: [clientId], references: [id])\n  tenant          Tenant         @relation(fields: [tenantId], references: [id])\n  payments        Payment[]\n\n  @@index([tenantId])\n  @@map(\"invoices\")\n}\n\nmodel Payment {\n  id                    String   @id @default(uuid())\n  invoiceId             String   @map(\"invoice_id\")\n  stripePaymentIntentId String?  @map(\"stripe_payment_intent_id\")\n  amount                Decimal? @db.Decimal(10, 2)\n  status                String?\n  createdAt             DateTime @default(now()) @map(\"created_at\")\n  updatedAt             DateTime @updatedAt @map(\"updated_at\")\n  invoice               Invoice  @relation(fields: [invoiceId], references: [id])\n\n  @@map(\"payments\")\n}\n\nmodel MessageThread {\n  id         String         @id @default(uuid())\n  threadType String         @map(\"thread_type\")\n  clientId   String?        @map(\"client_id\")\n  pswId      String?        @map(\"psw_id\")\n  createdAt  DateTime       @default(now()) @map(\"created_at\")\n  tenantId   String         @map(\"tenant_id\")\n  messages   Message[]\n  client     ClientProfile? @relation(fields: [clientId], references: [id])\n  psw        PswProfile?    @relation(\"PswToThreads\", fields: [pswId], references: [id])\n  tenant     Tenant         @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"messages_threads\")\n}\n\nmodel Message {\n  id           String        @id @default(uuid())\n  threadId     String        @map(\"thread_id\")\n  senderUserId String        @map(\"sender_user_id\")\n  bodyText     String        @map(\"body_text\")\n  createdAt    DateTime      @default(now()) @map(\"created_at\")\n  sender       User          @relation(fields: [senderUserId], references: [id])\n  thread       MessageThread @relation(fields: [threadId], references: [id])\n\n  @@map(\"messages\")\n}\n\nmodel AuditLog {\n  id           String   @id @default(uuid())\n  actorUserId  String?  @map(\"actor_user_id\")\n  action       String\n  resourceType String   @map(\"resource_type\")\n  resourceId   String?  @map(\"resource_id\")\n  metadataJson Json?    @map(\"metadata_json\")\n  ipAddress    String?  @map(\"ip_address\")\n  createdAt    DateTime @default(now()) @map(\"created_at\")\n  tenantId     String   @map(\"tenant_id\")\n  actor        User?    @relation(fields: [actorUserId], references: [id])\n  tenant       Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"audit_logs\")\n}\n\nmodel Lead {\n  id              String   @id @default(uuid())\n  fullName        String   @map(\"full_name\")\n  email           String\n  phone           String?\n  message         String?\n  source          String\n  status          String?  @default(\"new\")\n  serviceInterest String[] @default([]) @map(\"service_interest\")\n  notes           String?\n  createdAt       DateTime @default(now()) @map(\"created_at\")\n  updatedAt       DateTime @updatedAt @map(\"updated_at\")\n\n  @@map(\"leads\")\n}\n\nmodel Booking {\n  id             String        @id @default(uuid())\n  clientId       String        @map(\"client_id\")\n  branchId       String?       @map(\"branch_id\")\n  startAt        DateTime      @map(\"start_at\")\n  endAt          DateTime      @map(\"end_at\")\n  serviceType    String        @map(\"service_type\")\n  priority       String        @default(\"normal\")\n  notes          String?\n  status         String        @default(\"pending\")\n  recurrenceRule Json?         @map(\"recurrence_rule\")\n  tenantId       String        @map(\"tenant_id\")\n  client         ClientProfile @relation(fields: [clientId], references: [id])\n  tenant         Tenant        @relation(fields: [tenantId], references: [id])\n  visits         Visit[]\n\n  @@map(\"bookings\")\n}\n\nmodel PswAvailability {\n  id        String     @id @default(uuid())\n  pswId     String     @map(\"psw_id\")\n  dayOfWeek Int        @map(\"day_of_week\")\n  startTime String     @map(\"start_time\")\n  endTime   String     @map(\"end_time\")\n  tenantId  String     @map(\"tenant_id\")\n  psw       PswProfile @relation(\"PswToAvailability\", fields: [pswId], references: [id])\n  tenant    Tenant     @relation(fields: [tenantId], references: [id])\n\n  @@map(\"psw_availability\")\n}\n\nmodel ShiftAssignment {\n  id         String           @id @default(uuid())\n  visitId    String           @map(\"visit_id\")\n  pswId      String           @map(\"psw_id\")\n  status     AssignmentStatus @default(offered)\n  score      Float?\n  assignedAt DateTime         @default(now()) @map(\"assigned_at\")\n  tenantId   String           @map(\"tenant_id\")\n  psw        PswProfile       @relation(\"PswToAssignments\", fields: [pswId], references: [id])\n  tenant     Tenant           @relation(fields: [tenantId], references: [id])\n  visit      Visit            @relation(fields: [visitId], references: [id])\n\n  @@map(\"shift_assignments\")\n}\n\nmodel BlogPost {\n  id                String    @id @default(uuid())\n  title             String\n  slug              String    @unique\n  excerpt           String?\n  contentHtml       String?   @map(\"content_html\")\n  status            String?   @default(\"draft\")\n  publishedAt       DateTime? @map(\"published_at\")\n  authorUserId      String?   @map(\"author_user_id\")\n  featureImageDocId String?   @map(\"feature_image_doc_id\")\n  seoTitle          String?   @map(\"seo_title\")\n  seoDescription    String?   @map(\"seo_description\")\n  canonicalUrl      String?   @map(\"canonical_url\")\n  createdAt         DateTime  @default(now()) @map(\"created_at\")\n  updatedAt         DateTime  @updatedAt @map(\"updated_at\")\n  author            User?     @relation(fields: [authorUserId], references: [id])\n  targetRole        Role?     @map(\"target_role\")\n  category          String?   @default(\"announcement\")\n\n  @@map(\"blog_posts\")\n}\n\nmodel StaffTask {\n  id          String    @id @default(uuid())\n  title       String\n  description String?\n  status      String    @default(\"todo\") // todo, in_progress, completed, blocked\n  priority    String    @default(\"medium\") // low, medium, high, urgent\n  dueDate     DateTime? @map(\"due_date\")\n  assigneeId  String?   @map(\"assignee_id\")\n  tenantId    String    @map(\"tenant_id\")\n  createdAt   DateTime  @default(now()) @map(\"created_at\")\n  updatedAt   DateTime  @updatedAt @map(\"updated_at\")\n\n  tenant Tenant @relation(fields: [tenantId], references: [id])\n\n  @@map(\"staff_tasks\")\n}\n\nmodel PswDocument {\n  id         String     @id @default(uuid())\n  pswId      String     @map(\"psw_id\")\n  docType    String     @map(\"doc_type\")\n  fileKey    String     @map(\"file_key\")\n  status     DocStatus? @default(pending)\n  expiryDate DateTime?  @map(\"expiry_date\")\n  verifiedBy String?    @map(\"verified_by\")\n  verifiedAt DateTime?  @map(\"verified_at\")\n  createdAt  DateTime   @default(now()) @map(\"created_at\")\n  updatedAt  DateTime   @updatedAt @map(\"updated_at\")\n  psw        PswProfile @relation(\"PswToDocuments\", fields: [pswId], references: [id])\n  verifier   User?      @relation(\"VerifiedBy\", fields: [verifiedBy], references: [id])\n\n  @@map(\"psw_documents\")\n}\n\nmodel FAQ {\n  id        String   @id @default(uuid())\n  question  String\n  answer    String\n  category  String\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  updatedAt DateTime @updatedAt @map(\"updated_at\")\n\n  @@map(\"faqs\")\n}\n\nmodel DailyEntry {\n  id         String           @id @default(uuid())\n  tenantId   String           @map(\"tenant_id\")\n  clientId   String           @map(\"client_id\")\n  staffId    String           @map(\"staff_id\")\n  visitId    String?          @map(\"visit_id\")\n  adlData    Json             @map(\"adl_data\")\n  medication Json?\n  mood       Int?\n  vitals     Json?\n  notes      String?\n  signature  String?\n  status     DailyEntryStatus @default(DRAFT)\n  createdAt  DateTime         @default(now()) @map(\"created_at\")\n  updatedAt  DateTime         @updatedAt @map(\"updated_at\")\n  client     ClientProfile    @relation(fields: [clientId], references: [id])\n  staff      User             @relation(fields: [staffId], references: [id])\n  tenant     Tenant           @relation(fields: [tenantId], references: [id])\n  visit      Visit?           @relation(fields: [visitId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"daily_entries\")\n}\n\nenum Role {\n  super_admin\n  admin\n  staff\n  manager\n  marketing_manager\n  operations_manager\n  hr_manager\n  clinical_manager\n  regional_manager\n  finance_manager\n  recruiting_manager\n  coordinator\n  client\n  psw\n  rn\n  rmt\n  rpt\n  rch\n  finance\n  scrum_master\n}\n\nenum DocStatus {\n  pending\n  verified\n  rejected\n}\n\nenum VisitStatus {\n  requested\n  scheduled\n  assigned\n  en_route\n  arrived\n  in_progress\n  completed\n  cancelled\n  draft\n  posted\n  offered\n  accepted\n  no_show\n  replaced\n}\n\nenum AssignmentStatus {\n  offered\n  accepted\n  declined\n  assigned\n}\n\nenum EventType {\n  check_in\n  check_out\n}\n\nenum EventResult {\n  success\n  rejected\n}\n\nenum IncidentType {\n  fall_risk\n  refusal\n  no_show\n  safety\n  other\n}\n\nenum IncidentStatus {\n  open\n  investigating\n  resolved\n}\n\nenum TimesheetStatus {\n  draft\n  submitted\n  approved\n  rejected\n}\n\nenum InvoiceStatus {\n  draft\n  unpaid\n  paid\n  void\n}\n\nenum DailyEntryStatus {\n  DRAFT\n  SUBMITTED\n}\n\nmodel MarketplaceListing {\n  id          String   @id @default(uuid())\n  title       String\n  description String\n  price       Decimal  @db.Decimal(10, 2)\n  category    String\n  providerId  String   @map(\"provider_id\")\n  tenantId    String?  @map(\"tenant_id\")\n  createdAt   DateTime @default(now()) @map(\"created_at\")\n  updatedAt   DateTime @updatedAt @map(\"updated_at\")\n  tenant      Tenant?  @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"marketplace_listings\")\n}\n\nmodel Feedback {\n  id        String        @id @default(uuid())\n  clientId  String        @map(\"client_id\")\n  visitId   String?       @map(\"visit_id\")\n  rating    Int\n  comment   String?\n  status    String?       @default(\"pending\") // pending, reviewed, archived\n  createdAt DateTime      @default(now()) @map(\"created_at\")\n  updatedAt DateTime      @updatedAt @map(\"updated_at\")\n  tenantId  String        @map(\"tenant_id\")\n  client    ClientProfile @relation(fields: [clientId], references: [id])\n  tenant    Tenant        @relation(fields: [tenantId], references: [id])\n  visit     Visit?        @relation(fields: [visitId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"feedbacks\")\n}\n",
  "inlineSchemaHash": "a8754839e17299048c3223378aa7b08fe3bb067d62d7089bcad285a0897d245b",
  "copyEngine": true
}
config.dirname = '/'

config.runtimeDataModel = JSON.parse("{\"models\":{\"User\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"email\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"phone\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"passwordHash\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"password_hash\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"resetToken\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"resetTokenExpiry\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"lastLoginAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_login_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"roles\",\"kind\":\"enum\",\"type\":\"Role\"},{\"name\":\"auditLogs\",\"kind\":\"object\",\"type\":\"AuditLog\",\"relationName\":\"AuditLogToUser\"},{\"name\":\"blogPosts\",\"kind\":\"object\",\"type\":\"BlogPost\",\"relationName\":\"BlogPostToUser\"},{\"name\":\"clientProfile\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToUser\"},{\"name\":\"DailyEntry\",\"kind\":\"object\",\"type\":\"DailyEntry\",\"relationName\":\"DailyEntryToUser\"},{\"name\":\"reportedIncidents\",\"kind\":\"object\",\"type\":\"Incident\",\"relationName\":\"Reporter\"},{\"name\":\"sentMessages\",\"kind\":\"object\",\"type\":\"Message\",\"relationName\":\"MessageToUser\"},{\"name\":\"verifiedDocs\",\"kind\":\"object\",\"type\":\"PswDocument\",\"relationName\":\"VerifiedBy\"},{\"name\":\"pswProfile\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswProfileToUser\"},{\"name\":\"reviewedTimesheets\",\"kind\":\"object\",\"type\":\"Timesheet\",\"relationName\":\"ReviewedBy\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToUser\"},{\"name\":\"VisitCheckEvent\",\"kind\":\"object\",\"type\":\"VisitCheckEvent\",\"relationName\":\"UserToVisitCheckEvent\"}],\"dbName\":\"users\"},\"Tenant\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"slug\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"auditLogs\",\"kind\":\"object\",\"type\":\"AuditLog\",\"relationName\":\"AuditLogToTenant\"},{\"name\":\"bookings\",\"kind\":\"object\",\"type\":\"Booking\",\"relationName\":\"BookingToTenant\"},{\"name\":\"clientProfiles\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToTenant\"},{\"name\":\"dailyEntries\",\"kind\":\"object\",\"type\":\"DailyEntry\",\"relationName\":\"DailyEntryToTenant\"},{\"name\":\"incidents\",\"kind\":\"object\",\"type\":\"Incident\",\"relationName\":\"IncidentToTenant\"},{\"name\":\"invoices\",\"kind\":\"object\",\"type\":\"Invoice\",\"relationName\":\"InvoiceToTenant\"},{\"name\":\"messageThreads\",\"kind\":\"object\",\"type\":\"MessageThread\",\"relationName\":\"MessageThreadToTenant\"},{\"name\":\"pswAvailability\",\"kind\":\"object\",\"type\":\"PswAvailability\",\"relationName\":\"PswAvailabilityToTenant\"},{\"name\":\"pswProfiles\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswProfileToTenant\"},{\"name\":\"services\",\"kind\":\"object\",\"type\":\"Service\",\"relationName\":\"ServiceToTenant\"},{\"name\":\"shiftAssignments\",\"kind\":\"object\",\"type\":\"ShiftAssignment\",\"relationName\":\"ShiftAssignmentToTenant\"},{\"name\":\"timesheets\",\"kind\":\"object\",\"type\":\"Timesheet\",\"relationName\":\"TenantToTimesheet\"},{\"name\":\"staffTasks\",\"kind\":\"object\",\"type\":\"StaffTask\",\"relationName\":\"StaffTaskToTenant\"},{\"name\":\"users\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"TenantToUser\"},{\"name\":\"checkEvents\",\"kind\":\"object\",\"type\":\"VisitCheckEvent\",\"relationName\":\"TenantToVisitCheckEvent\"},{\"name\":\"visits\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"TenantToVisit\"},{\"name\":\"apiKeys\",\"kind\":\"object\",\"type\":\"ApiKey\",\"relationName\":\"ApiKeyToTenant\"},{\"name\":\"feedbacks\",\"kind\":\"object\",\"type\":\"Feedback\",\"relationName\":\"FeedbackToTenant\"},{\"name\":\"businessNumber\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"business_number\"},{\"name\":\"supportEmail\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"support_email\"},{\"name\":\"logoUrl\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"logo_url\"},{\"name\":\"taxSettings\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"tax_settings\"},{\"name\":\"brandingConfig\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"branding_config\"},{\"name\":\"stripeAccountId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"stripe_account_id\"},{\"name\":\"onboardingStep\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"onboarding_step\"},{\"name\":\"parentTenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"parent_tenant_id\"},{\"name\":\"parentTenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantHierarchy\"},{\"name\":\"childTenants\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantHierarchy\"},{\"name\":\"marketplaceListings\",\"kind\":\"object\",\"type\":\"MarketplaceListing\",\"relationName\":\"MarketplaceListingToTenant\"}],\"dbName\":\"tenants\"},\"ApiKey\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"key\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"lastUsedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_used_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ApiKeyToTenant\"}],\"dbName\":\"api_keys\"},\"ClientProfile\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"fullName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"full_name\"},{\"name\":\"dob\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"addressLine1\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"address_line1\"},{\"name\":\"addressLine2\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"address_line2\"},{\"name\":\"city\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"province\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"postalCode\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"postal_code\"},{\"name\":\"lat\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"lng\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"emergencyName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"emergency_contact_name\"},{\"name\":\"emergencyPhone\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"emergency_contact_phone\"},{\"name\":\"preferences\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"preferences_json\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"bookings\",\"kind\":\"object\",\"type\":\"Booking\",\"relationName\":\"BookingToClientProfile\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ClientProfileToTenant\"},{\"name\":\"user\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"ClientProfileToUser\"},{\"name\":\"DailyEntry\",\"kind\":\"object\",\"type\":\"DailyEntry\",\"relationName\":\"ClientProfileToDailyEntry\"},{\"name\":\"invoices\",\"kind\":\"object\",\"type\":\"Invoice\",\"relationName\":\"ClientProfileToInvoice\"},{\"name\":\"messageThreads\",\"kind\":\"object\",\"type\":\"MessageThread\",\"relationName\":\"ClientProfileToMessageThread\"},{\"name\":\"visits\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"ClientProfileToVisit\"},{\"name\":\"feedbacks\",\"kind\":\"object\",\"type\":\"Feedback\",\"relationName\":\"ClientProfileToFeedback\"}],\"dbName\":\"client_profiles\"},\"PswProfile\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"fullName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"full_name\"},{\"name\":\"bio\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"languages\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"serviceAreas\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_areas\"},{\"name\":\"availabilityJson\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"availability_json\"},{\"name\":\"isApproved\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_approved\"},{\"name\":\"approvedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"approved_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"address\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"avatarUrl\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"avatar_url\"},{\"name\":\"skills\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"messageThreads\",\"kind\":\"object\",\"type\":\"MessageThread\",\"relationName\":\"PswToThreads\"},{\"name\":\"availability\",\"kind\":\"object\",\"type\":\"PswAvailability\",\"relationName\":\"PswToAvailability\"},{\"name\":\"documents\",\"kind\":\"object\",\"type\":\"PswDocument\",\"relationName\":\"PswToDocuments\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"PswProfileToTenant\"},{\"name\":\"user\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"PswProfileToUser\"},{\"name\":\"assignments\",\"kind\":\"object\",\"type\":\"ShiftAssignment\",\"relationName\":\"PswToAssignments\"},{\"name\":\"timesheets\",\"kind\":\"object\",\"type\":\"Timesheet\",\"relationName\":\"PswToTimesheets\"},{\"name\":\"checkEvents\",\"kind\":\"object\",\"type\":\"VisitCheckEvent\",\"relationName\":\"PswToCheckEvents\"},{\"name\":\"checklists\",\"kind\":\"object\",\"type\":\"VisitChecklist\",\"relationName\":\"PswToChecklists\"},{\"name\":\"notes\",\"kind\":\"object\",\"type\":\"VisitNote\",\"relationName\":\"PswToNotes\"},{\"name\":\"assignedVisits\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"PswToVisits\"}],\"dbName\":\"psw_profiles\"},\"Visit\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"serviceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_id\"},{\"name\":\"requestedStartAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"requested_start_at\"},{\"name\":\"durationMinutes\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"duration_minutes\"},{\"name\":\"status\",\"kind\":\"enum\",\"type\":\"VisitStatus\"},{\"name\":\"assignedPswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"assigned_psw_id\"},{\"name\":\"serviceAddressLine1\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_address_line1\"},{\"name\":\"serviceAddressLine2\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_address_line2\"},{\"name\":\"serviceCity\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_city\"},{\"name\":\"serviceProvince\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_province\"},{\"name\":\"servicePostalCode\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_postal_code\"},{\"name\":\"serviceLat\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"service_lat\"},{\"name\":\"serviceLng\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"service_lng\"},{\"name\":\"clientNotes\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_notes\"},{\"name\":\"coordinatorNotes\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"coordinator_notes\"},{\"name\":\"cancellationReason\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"cancellation_reason\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"bookingId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"booking_id\"},{\"name\":\"crisisMode\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"crisis_mode\"},{\"name\":\"priority\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"requiredSkills\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"required_skills\"},{\"name\":\"isSurgeActive\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_surge_active\"},{\"name\":\"surgeMultiplier\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"surge_multiplier\"},{\"name\":\"DailyEntry\",\"kind\":\"object\",\"type\":\"DailyEntry\",\"relationName\":\"DailyEntryToVisit\"},{\"name\":\"incidents\",\"kind\":\"object\",\"type\":\"Incident\",\"relationName\":\"IncidentToVisit\"},{\"name\":\"assignments\",\"kind\":\"object\",\"type\":\"ShiftAssignment\",\"relationName\":\"ShiftAssignmentToVisit\"},{\"name\":\"timesheetItems\",\"kind\":\"object\",\"type\":\"TimesheetItem\",\"relationName\":\"TimesheetItemToVisit\"},{\"name\":\"checkEvents\",\"kind\":\"object\",\"type\":\"VisitCheckEvent\",\"relationName\":\"VisitToVisitCheckEvent\"},{\"name\":\"checklists\",\"kind\":\"object\",\"type\":\"VisitChecklist\",\"relationName\":\"VisitToVisitChecklist\"},{\"name\":\"notes\",\"kind\":\"object\",\"type\":\"VisitNote\",\"relationName\":\"VisitToVisitNote\"},{\"name\":\"feedbacks\",\"kind\":\"object\",\"type\":\"Feedback\",\"relationName\":\"FeedbackToVisit\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToVisits\"},{\"name\":\"booking\",\"kind\":\"object\",\"type\":\"Booking\",\"relationName\":\"BookingToVisit\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToVisit\"},{\"name\":\"service\",\"kind\":\"object\",\"type\":\"Service\",\"relationName\":\"ServiceToVisit\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToVisit\"}],\"dbName\":\"visits\"},\"Service\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"slug\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"baseRateHourly\",\"kind\":\"scalar\",\"type\":\"Decimal\",\"dbName\":\"base_rate_hourly\"},{\"name\":\"providerRateHourly\",\"kind\":\"scalar\",\"type\":\"Decimal\",\"dbName\":\"provider_rate_hourly\"},{\"name\":\"isActive\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_active\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"isFeatured\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_featured\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ServiceToTenant\"},{\"name\":\"visits\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"ServiceToVisit\"}],\"dbName\":\"services\"},\"VisitCheckEvent\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"eventType\",\"kind\":\"enum\",\"type\":\"EventType\",\"dbName\":\"event_type\"},{\"name\":\"lat\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"lng\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"accuracyM\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"accuracy_m\"},{\"name\":\"computedDistanceM\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"computed_distance_m\"},{\"name\":\"deviceTimeIso\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"device_time_iso\"},{\"name\":\"serverTime\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"server_time\"},{\"name\":\"result\",\"kind\":\"enum\",\"type\":\"EventResult\"},{\"name\":\"rejectReason\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"reject_reason\"},{\"name\":\"isOverride\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_override\"},{\"name\":\"overrideByUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"override_by_user_id\"},{\"name\":\"overrideReason\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"override_reason\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"overriddenBy\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"UserToVisitCheckEvent\"},{\"name\":\"pswProfile\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToCheckEvents\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToVisitCheckEvent\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"VisitToVisitCheckEvent\"}],\"dbName\":\"visit_check_events\"},\"VisitNote\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"noteText\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"note_text\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToNotes\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"VisitToVisitNote\"}],\"dbName\":\"visit_notes\"},\"VisitChecklist\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"checklistJson\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"checklist_json\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToChecklists\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"VisitToVisitChecklist\"}],\"dbName\":\"visit_checklists\"},\"Incident\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"reporterUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"reporter_user_id\"},{\"name\":\"type\",\"kind\":\"enum\",\"type\":\"IncidentType\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"enum\",\"type\":\"IncidentStatus\"},{\"name\":\"resolutionNotes\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"resolution_notes\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"reporter\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"Reporter\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"IncidentToTenant\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"IncidentToVisit\"}],\"dbName\":\"incidents\"},\"Timesheet\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"weekId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"week_id\"},{\"name\":\"totalMinutes\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"total_minutes\"},{\"name\":\"status\",\"kind\":\"enum\",\"type\":\"TimesheetStatus\"},{\"name\":\"submittedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"submitted_at\"},{\"name\":\"reviewedBy\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"reviewed_by\"},{\"name\":\"reviewedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"reviewed_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"items\",\"kind\":\"object\",\"type\":\"TimesheetItem\",\"relationName\":\"TimesheetToTimesheetItem\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToTimesheets\"},{\"name\":\"reviewer\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"ReviewedBy\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToTimesheet\"}],\"dbName\":\"timesheets\"},\"TimesheetItem\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"timesheetId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"timesheet_id\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"minutes\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"timesheet\",\"kind\":\"object\",\"type\":\"Timesheet\",\"relationName\":\"TimesheetToTimesheetItem\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"TimesheetItemToVisit\"}],\"dbName\":\"timesheet_items\"},\"Invoice\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"status\",\"kind\":\"enum\",\"type\":\"InvoiceStatus\"},{\"name\":\"currency\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"subtotal\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"tax\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"total\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"stripeInvoiceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"stripe_invoice_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToInvoice\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"InvoiceToTenant\"},{\"name\":\"payments\",\"kind\":\"object\",\"type\":\"Payment\",\"relationName\":\"InvoiceToPayment\"}],\"dbName\":\"invoices\"},\"Payment\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"invoiceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"invoice_id\"},{\"name\":\"stripePaymentIntentId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"stripe_payment_intent_id\"},{\"name\":\"amount\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"invoice\",\"kind\":\"object\",\"type\":\"Invoice\",\"relationName\":\"InvoiceToPayment\"}],\"dbName\":\"payments\"},\"MessageThread\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"threadType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"thread_type\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"messages\",\"kind\":\"object\",\"type\":\"Message\",\"relationName\":\"MessageToMessageThread\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToMessageThread\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToThreads\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"MessageThreadToTenant\"}],\"dbName\":\"messages_threads\"},\"Message\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"threadId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"thread_id\"},{\"name\":\"senderUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"sender_user_id\"},{\"name\":\"bodyText\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"body_text\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"sender\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"MessageToUser\"},{\"name\":\"thread\",\"kind\":\"object\",\"type\":\"MessageThread\",\"relationName\":\"MessageToMessageThread\"}],\"dbName\":\"messages\"},\"AuditLog\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"actorUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"actor_user_id\"},{\"name\":\"action\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"resourceType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"resource_type\"},{\"name\":\"resourceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"resource_id\"},{\"name\":\"metadataJson\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"metadata_json\"},{\"name\":\"ipAddress\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"ip_address\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"actor\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"AuditLogToUser\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"AuditLogToTenant\"}],\"dbName\":\"audit_logs\"},\"Lead\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"fullName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"full_name\"},{\"name\":\"email\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"phone\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"message\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"source\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"serviceInterest\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_interest\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"}],\"dbName\":\"leads\"},\"Booking\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"branchId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"branch_id\"},{\"name\":\"startAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"start_at\"},{\"name\":\"endAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"end_at\"},{\"name\":\"serviceType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_type\"},{\"name\":\"priority\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"recurrenceRule\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"recurrence_rule\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"BookingToClientProfile\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"BookingToTenant\"},{\"name\":\"visits\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"BookingToVisit\"}],\"dbName\":\"bookings\"},\"PswAvailability\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"dayOfWeek\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"day_of_week\"},{\"name\":\"startTime\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"start_time\"},{\"name\":\"endTime\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"end_time\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToAvailability\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"PswAvailabilityToTenant\"}],\"dbName\":\"psw_availability\"},\"ShiftAssignment\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"status\",\"kind\":\"enum\",\"type\":\"AssignmentStatus\"},{\"name\":\"score\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"assignedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"assigned_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToAssignments\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ShiftAssignmentToTenant\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"ShiftAssignmentToVisit\"}],\"dbName\":\"shift_assignments\"},\"BlogPost\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"slug\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"excerpt\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"contentHtml\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"content_html\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"publishedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"published_at\"},{\"name\":\"authorUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"author_user_id\"},{\"name\":\"featureImageDocId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"feature_image_doc_id\"},{\"name\":\"seoTitle\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"seo_title\"},{\"name\":\"seoDescription\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"seo_description\"},{\"name\":\"canonicalUrl\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"canonical_url\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"author\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"BlogPostToUser\"},{\"name\":\"targetRole\",\"kind\":\"enum\",\"type\":\"Role\",\"dbName\":\"target_role\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"}],\"dbName\":\"blog_posts\"},\"StaffTask\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"priority\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"dueDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"due_date\"},{\"name\":\"assigneeId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"assignee_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"StaffTaskToTenant\"}],\"dbName\":\"staff_tasks\"},\"PswDocument\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"docType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"doc_type\"},{\"name\":\"fileKey\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"file_key\"},{\"name\":\"status\",\"kind\":\"enum\",\"type\":\"DocStatus\"},{\"name\":\"expiryDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"expiry_date\"},{\"name\":\"verifiedBy\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"verified_by\"},{\"name\":\"verifiedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"verified_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToDocuments\"},{\"name\":\"verifier\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"VerifiedBy\"}],\"dbName\":\"psw_documents\"},\"FAQ\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"question\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"answer\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"}],\"dbName\":\"faqs\"},\"DailyEntry\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"staffId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"staff_id\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"adlData\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"adl_data\"},{\"name\":\"medication\",\"kind\":\"scalar\",\"type\":\"Json\"},{\"name\":\"mood\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"vitals\",\"kind\":\"scalar\",\"type\":\"Json\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"signature\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"enum\",\"type\":\"DailyEntryStatus\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToDailyEntry\"},{\"name\":\"staff\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"DailyEntryToUser\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"DailyEntryToTenant\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"DailyEntryToVisit\"}],\"dbName\":\"daily_entries\"},\"MarketplaceListing\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"price\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"providerId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"provider_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"MarketplaceListingToTenant\"}],\"dbName\":\"marketplace_listings\"},\"Feedback\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"rating\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"comment\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToFeedback\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"FeedbackToTenant\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"FeedbackToVisit\"}],\"dbName\":\"feedbacks\"}},\"enums\":{},\"types\":{}}")
defineDmmfProperty(exports.Prisma, config.runtimeDataModel)
config.engineWasm = {
  getRuntime: () => require('./query_engine_bg.js'),
  getQueryEngineWasmModule: async () => {
    const loader = (await import('#wasm-engine-loader')).default
    const engine = (await loader).default
    return engine 
  }
}

config.injectableEdgeEnv = () => ({
  parsed: {
    DATABASE_URL: typeof globalThis !== 'undefined' && globalThis['DATABASE_URL'] || typeof process !== 'undefined' && process.env && process.env.DATABASE_URL || undefined
  }
})

if (typeof globalThis !== 'undefined' && globalThis['DEBUG'] || typeof process !== 'undefined' && process.env && process.env.DEBUG || undefined) {
  Debug.enable(typeof globalThis !== 'undefined' && globalThis['DEBUG'] || typeof process !== 'undefined' && process.env && process.env.DEBUG || undefined)
}

const PrismaClient = getPrismaClient(config)
exports.PrismaClient = PrismaClient
Object.assign(exports, Prisma)

