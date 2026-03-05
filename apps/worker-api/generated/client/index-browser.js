
Object.defineProperty(exports, "__esModule", { value: true });

const {
  Decimal,
  objectEnumValues,
  makeStrictEnum,
  Public,
  getRuntime,
  skip
} = require('./runtime/index-browser.js')


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

Prisma.PrismaClientKnownRequestError = () => {
  const runtimeName = getRuntime().prettyName;
  throw new Error(`PrismaClientKnownRequestError is unable to run in this browser environment, or has been bundled for the browser (running in ${runtimeName}).
In case this error is unexpected for you, please report it in https://pris.ly/prisma-prisma-bug-report`,
)};
Prisma.PrismaClientUnknownRequestError = () => {
  const runtimeName = getRuntime().prettyName;
  throw new Error(`PrismaClientUnknownRequestError is unable to run in this browser environment, or has been bundled for the browser (running in ${runtimeName}).
In case this error is unexpected for you, please report it in https://pris.ly/prisma-prisma-bug-report`,
)}
Prisma.PrismaClientRustPanicError = () => {
  const runtimeName = getRuntime().prettyName;
  throw new Error(`PrismaClientRustPanicError is unable to run in this browser environment, or has been bundled for the browser (running in ${runtimeName}).
In case this error is unexpected for you, please report it in https://pris.ly/prisma-prisma-bug-report`,
)}
Prisma.PrismaClientInitializationError = () => {
  const runtimeName = getRuntime().prettyName;
  throw new Error(`PrismaClientInitializationError is unable to run in this browser environment, or has been bundled for the browser (running in ${runtimeName}).
In case this error is unexpected for you, please report it in https://pris.ly/prisma-prisma-bug-report`,
)}
Prisma.PrismaClientValidationError = () => {
  const runtimeName = getRuntime().prettyName;
  throw new Error(`PrismaClientValidationError is unable to run in this browser environment, or has been bundled for the browser (running in ${runtimeName}).
In case this error is unexpected for you, please report it in https://pris.ly/prisma-prisma-bug-report`,
)}
Prisma.NotFoundError = () => {
  const runtimeName = getRuntime().prettyName;
  throw new Error(`NotFoundError is unable to run in this browser environment, or has been bundled for the browser (running in ${runtimeName}).
In case this error is unexpected for you, please report it in https://pris.ly/prisma-prisma-bug-report`,
)}
Prisma.Decimal = Decimal

/**
 * Re-export of sql-template-tag
 */
Prisma.sql = () => {
  const runtimeName = getRuntime().prettyName;
  throw new Error(`sqltag is unable to run in this browser environment, or has been bundled for the browser (running in ${runtimeName}).
In case this error is unexpected for you, please report it in https://pris.ly/prisma-prisma-bug-report`,
)}
Prisma.empty = () => {
  const runtimeName = getRuntime().prettyName;
  throw new Error(`empty is unable to run in this browser environment, or has been bundled for the browser (running in ${runtimeName}).
In case this error is unexpected for you, please report it in https://pris.ly/prisma-prisma-bug-report`,
)}
Prisma.join = () => {
  const runtimeName = getRuntime().prettyName;
  throw new Error(`join is unable to run in this browser environment, or has been bundled for the browser (running in ${runtimeName}).
In case this error is unexpected for you, please report it in https://pris.ly/prisma-prisma-bug-report`,
)}
Prisma.raw = () => {
  const runtimeName = getRuntime().prettyName;
  throw new Error(`raw is unable to run in this browser environment, or has been bundled for the browser (running in ${runtimeName}).
In case this error is unexpected for you, please report it in https://pris.ly/prisma-prisma-bug-report`,
)}
Prisma.validator = Public.validator

/**
* Extensions
*/
Prisma.getExtensionContext = () => {
  const runtimeName = getRuntime().prettyName;
  throw new Error(`Extensions.getExtensionContext is unable to run in this browser environment, or has been bundled for the browser (running in ${runtimeName}).
In case this error is unexpected for you, please report it in https://pris.ly/prisma-prisma-bug-report`,
)}
Prisma.defineExtension = () => {
  const runtimeName = getRuntime().prettyName;
  throw new Error(`Extensions.defineExtension is unable to run in this browser environment, or has been bundled for the browser (running in ${runtimeName}).
In case this error is unexpected for you, please report it in https://pris.ly/prisma-prisma-bug-report`,
)}

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
  tenantId: 'tenantId',
  franchiseId: 'franchiseId'
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
  tenantId: 'tenantId',
  acknowledgedAt: 'acknowledgedAt',
  acknowledgedBy: 'acknowledgedBy'
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
  convertedToUserId: 'convertedToUserId',
  conversionDate: 'conversionDate',
  tenantId: 'tenantId',
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

exports.Prisma.CarePlanScalarFieldEnum = {
  id: 'id',
  clientId: 'clientId',
  tenantId: 'tenantId',
  diagnoses: 'diagnoses',
  clinicalGoals: 'clinicalGoals',
  interventions: 'interventions',
  status: 'status',
  reviewDate: 'reviewDate',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  authorId: 'authorId',
  version: 'version',
  isArchived: 'isArchived',
  outcomeNotes: 'outcomeNotes'
};

exports.Prisma.TrainingModuleScalarFieldEnum = {
  id: 'id',
  title: 'title',
  description: 'description',
  category: 'category',
  videoUrl: 'videoUrl',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  tenantId: 'tenantId'
};

exports.Prisma.TrainingAssignmentScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  staffId: 'staffId',
  moduleId: 'moduleId',
  status: 'status',
  completedAt: 'completedAt',
  assignedAt: 'assignedAt'
};

exports.Prisma.SurveyScalarFieldEnum = {
  id: 'id',
  title: 'title',
  targetRole: 'targetRole',
  questions: 'questions',
  isActive: 'isActive',
  createdAt: 'createdAt',
  tenantId: 'tenantId'
};

exports.Prisma.SurveyResponseScalarFieldEnum = {
  id: 'id',
  surveyId: 'surveyId',
  userId: 'userId',
  answers: 'answers',
  createdAt: 'createdAt'
};

exports.Prisma.RegionScalarFieldEnum = {
  id: 'id',
  name: 'name',
  city: 'city',
  province: 'province',
  boundary: 'boundary',
  status: 'status',
  createdAt: 'createdAt',
  tenantId: 'tenantId'
};

exports.Prisma.BranchCapacityScalarFieldEnum = {
  id: 'id',
  regionId: 'regionId',
  totalStaff: 'totalStaff',
  availableStaff: 'availableStaff',
  activeVisits: 'activeVisits',
  pendingBookings: 'pendingBookings',
  utilizationRate: 'utilizationRate',
  timestamp: 'timestamp'
};

exports.Prisma.ClinicalRecordScalarFieldEnum = {
  id: 'id',
  clientId: 'clientId',
  type: 'type',
  data: 'data',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  tenantId: 'tenantId'
};

exports.Prisma.HealthIDScalarFieldEnum = {
  id: 'id',
  userId: 'userId',
  did: 'did',
  publicKey: 'publicKey',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.FhirSyncLogScalarFieldEnum = {
  id: 'id',
  direction: 'direction',
  resourceType: 'resourceType',
  externalId: 'externalId',
  status: 'status',
  error: 'error',
  timestamp: 'timestamp',
  tenantId: 'tenantId'
};

exports.Prisma.AIRecommendationScalarFieldEnum = {
  id: 'id',
  type: 'type',
  priority: 'priority',
  content: 'content',
  isApplied: 'isApplied',
  createdAt: 'createdAt',
  tenantId: 'tenantId'
};

exports.Prisma.SentimentAnalysisScalarFieldEnum = {
  id: 'id',
  source: 'source',
  sourceId: 'sourceId',
  score: 'score',
  magnitude: 'magnitude',
  entities: 'entities',
  createdAt: 'createdAt',
  tenantId: 'tenantId'
};

exports.Prisma.SecurityThreatScalarFieldEnum = {
  id: 'id',
  type: 'type',
  severity: 'severity',
  status: 'status',
  description: 'description',
  source: 'source',
  detectedAt: 'detectedAt',
  resolvedAt: 'resolvedAt',
  tenantId: 'tenantId'
};

exports.Prisma.TenantSLAScalarFieldEnum = {
  id: 'id',
  uptimeTarget: 'uptimeTarget',
  responseTimeTarget: 'responseTimeTarget',
  supportTier: 'supportTier',
  status: 'status',
  lastAuditAt: 'lastAuditAt',
  tenantId: 'tenantId'
};

exports.Prisma.SystemPolicyScalarFieldEnum = {
  id: 'id',
  code: 'code',
  name: 'name',
  category: 'category',
  value: 'value',
  isEnforced: 'isEnforced',
  version: 'version',
  updatedAt: 'updatedAt'
};

exports.Prisma.FleetStatusScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  lat: 'lat',
  lng: 'lng',
  status: 'status',
  batteryLevel: 'batteryLevel',
  lastHeartbeatAt: 'lastHeartbeatAt',
  currentVisitId: 'currentVisitId'
};

exports.Prisma.ResponseBotAuditScalarFieldEnum = {
  id: 'id',
  type: 'type',
  status: 'status',
  summary: 'summary',
  details: 'details',
  durationMs: 'durationMs',
  createdAt: 'createdAt'
};

exports.Prisma.VisitMatchScalarFieldEnum = {
  id: 'id',
  visitId: 'visitId',
  pswId: 'pswId',
  score: 'score',
  status: 'status',
  createdAt: 'createdAt',
  tenantId: 'tenantId'
};

exports.Prisma.WaitlistEntryScalarFieldEnum = {
  id: 'id',
  clientId: 'clientId',
  serviceId: 'serviceId',
  priority: 'priority',
  status: 'status',
  notes: 'notes',
  requestedStartAt: 'requestedStartAt',
  createdAt: 'createdAt',
  tenantId: 'tenantId'
};

exports.Prisma.BranchStatScalarFieldEnum = {
  id: 'id',
  date: 'date',
  utilization: 'utilization',
  revenue: 'revenue',
  churnRate: 'churnRate',
  activeClients: 'activeClients',
  activeProviders: 'activeProviders',
  tenantId: 'tenantId'
};

exports.Prisma.ComplianceRecordScalarFieldEnum = {
  id: 'id',
  type: 'type',
  status: 'status',
  score: 'score',
  notes: 'notes',
  lastSyncAt: 'lastSyncAt',
  tenantId: 'tenantId'
};

exports.Prisma.FranchiseScalarFieldEnum = {
  id: 'id',
  name: 'name',
  resellerId: 'resellerId',
  ownerUserId: 'ownerUserId',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.ResellerAgreementScalarFieldEnum = {
  id: 'id',
  franchiseId: 'franchiseId',
  terms: 'terms',
  feePercentage: 'feePercentage',
  startDate: 'startDate',
  endDate: 'endDate',
  status: 'status'
};

exports.Prisma.SupplierScalarFieldEnum = {
  id: 'id',
  name: 'name',
  contactName: 'contactName',
  email: 'email',
  phone: 'phone',
  category: 'category',
  status: 'status',
  createdAt: 'createdAt'
};

exports.Prisma.InventoryItemScalarFieldEnum = {
  id: 'id',
  name: 'name',
  sku: 'sku',
  category: 'category',
  quantity: 'quantity',
  reorderPoint: 'reorderPoint',
  unitPrice: 'unitPrice',
  tenantId: 'tenantId',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  clientProfileId: 'clientProfileId'
};

exports.Prisma.PurchaseOrderScalarFieldEnum = {
  id: 'id',
  poNumber: 'poNumber',
  supplierId: 'supplierId',
  tenantId: 'tenantId',
  totalAmount: 'totalAmount',
  status: 'status',
  createdAt: 'createdAt',
  clientProfileId: 'clientProfileId'
};

exports.Prisma.TelehealthSessionScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  patientId: 'patientId',
  providerId: 'providerId',
  startTime: 'startTime',
  endTime: 'endTime',
  meetingLink: 'meetingLink',
  status: 'status',
  createdAt: 'createdAt'
};

exports.Prisma.VitalSignScalarFieldEnum = {
  id: 'id',
  patientId: 'patientId',
  type: 'type',
  value: 'value',
  unit: 'unit',
  source: 'source',
  recordedAt: 'recordedAt'
};

exports.Prisma.PatientAlertScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  patientId: 'patientId',
  type: 'type',
  severity: 'severity',
  message: 'message',
  status: 'status',
  createdAt: 'createdAt'
};

exports.Prisma.InsuranceProviderScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  name: 'name',
  networkId: 'networkId',
  contactPhone: 'contactPhone',
  claimsEmail: 'claimsEmail',
  createdAt: 'createdAt'
};

exports.Prisma.ClaimScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  patientId: 'patientId',
  providerId: 'providerId',
  serviceDate: 'serviceDate',
  amount: 'amount',
  status: 'status',
  denialReason: 'denialReason',
  createdAt: 'createdAt'
};

exports.Prisma.BillingCodeScalarFieldEnum = {
  id: 'id',
  code: 'code',
  description: 'description',
  category: 'category',
  defaultRate: 'defaultRate'
};

exports.Prisma.MedicationScalarFieldEnum = {
  id: 'id',
  name: 'name',
  genericName: 'genericName',
  dosageForm: 'dosageForm',
  strength: 'strength',
  instructions: 'instructions',
  createdAt: 'createdAt'
};

exports.Prisma.PrescriptionScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  patientId: 'patientId',
  medicationId: 'medicationId',
  prescriberId: 'prescriberId',
  dosage: 'dosage',
  frequency: 'frequency',
  route: 'route',
  startDate: 'startDate',
  endDate: 'endDate',
  status: 'status',
  createdAt: 'createdAt'
};

exports.Prisma.MAR_EntryScalarFieldEnum = {
  id: 'id',
  patientId: 'patientId',
  prescriptionId: 'prescriptionId',
  administerId: 'administerId',
  adminTime: 'adminTime',
  status: 'status',
  notes: 'notes'
};

exports.Prisma.ShiftHandoverScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  visitId: 'visitId',
  tenantId: 'tenantId',
  handoverNotes: 'handoverNotes',
  safetyConcerns: 'safetyConcerns',
  suppliesNeeded: 'suppliesNeeded',
  createdAt: 'createdAt'
};

exports.Prisma.AvailabilityOverrideScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  tenantId: 'tenantId',
  date: 'date',
  startTime: 'startTime',
  endTime: 'endTime',
  isAvailable: 'isAvailable'
};

exports.Prisma.PayoutScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  tenantId: 'tenantId',
  amount: 'amount',
  currency: 'currency',
  status: 'status',
  processedAt: 'processedAt',
  createdAt: 'createdAt'
};

exports.Prisma.ClinicalAssessmentScalarFieldEnum = {
  id: 'id',
  clientId: 'clientId',
  rnId: 'rnId',
  tenantId: 'tenantId',
  type: 'type',
  assessmentData: 'assessmentData',
  score: 'score',
  recommendations: 'recommendations',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.MedicationReconScalarFieldEnum = {
  id: 'id',
  clientId: 'clientId',
  rnId: 'rnId',
  tenantId: 'tenantId',
  reconData: 'reconData',
  discrepancies: 'discrepancies',
  status: 'status',
  createdAt: 'createdAt'
};

exports.Prisma.SupervisionLogScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  rnId: 'rnId',
  tenantId: 'tenantId',
  competencies: 'competencies',
  isSatisfactory: 'isSatisfactory',
  feedback: 'feedback',
  createdAt: 'createdAt'
};

exports.Prisma.FamilyNotificationScalarFieldEnum = {
  id: 'id',
  clientId: 'clientId',
  type: 'type',
  message: 'message',
  isRead: 'isRead',
  createdAt: 'createdAt',
  tenantId: 'tenantId'
};

exports.Prisma.CareFeedbackScalarFieldEnum = {
  id: 'id',
  clientId: 'clientId',
  visitId: 'visitId',
  rating: 'rating',
  comment: 'comment',
  triageStatus: 'triageStatus',
  resolutionNotes: 'resolutionNotes',
  createdAt: 'createdAt',
  tenantId: 'tenantId'
};

exports.Prisma.TechnicalAuditScalarFieldEnum = {
  id: 'id',
  type: 'type',
  status: 'status',
  summary: 'summary',
  issuesCount: 'issuesCount',
  details: 'details',
  performedById: 'performedById',
  performedAt: 'performedAt',
  tenantId: 'tenantId'
};

exports.Prisma.RegistryEntryScalarFieldEnum = {
  id: 'id',
  externalId: 'externalId',
  type: 'type',
  label: 'label',
  role: 'role',
  module: 'module',
  action: 'action',
  targetPath: 'targetPath',
  description: 'description',
  status: 'status',
  lastChecked: 'lastChecked',
  errorCount: 'errorCount',
  metadata: 'metadata',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
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
  medical_emergency: 'medical_emergency',
  sos_alert: 'sos_alert',
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
  Feedback: 'Feedback',
  CarePlan: 'CarePlan',
  TrainingModule: 'TrainingModule',
  TrainingAssignment: 'TrainingAssignment',
  Survey: 'Survey',
  SurveyResponse: 'SurveyResponse',
  Region: 'Region',
  BranchCapacity: 'BranchCapacity',
  ClinicalRecord: 'ClinicalRecord',
  HealthID: 'HealthID',
  FhirSyncLog: 'FhirSyncLog',
  AIRecommendation: 'AIRecommendation',
  SentimentAnalysis: 'SentimentAnalysis',
  SecurityThreat: 'SecurityThreat',
  TenantSLA: 'TenantSLA',
  SystemPolicy: 'SystemPolicy',
  FleetStatus: 'FleetStatus',
  ResponseBotAudit: 'ResponseBotAudit',
  VisitMatch: 'VisitMatch',
  WaitlistEntry: 'WaitlistEntry',
  BranchStat: 'BranchStat',
  ComplianceRecord: 'ComplianceRecord',
  Franchise: 'Franchise',
  ResellerAgreement: 'ResellerAgreement',
  Supplier: 'Supplier',
  InventoryItem: 'InventoryItem',
  PurchaseOrder: 'PurchaseOrder',
  TelehealthSession: 'TelehealthSession',
  VitalSign: 'VitalSign',
  PatientAlert: 'PatientAlert',
  InsuranceProvider: 'InsuranceProvider',
  Claim: 'Claim',
  BillingCode: 'BillingCode',
  Medication: 'Medication',
  Prescription: 'Prescription',
  MAR_Entry: 'MAR_Entry',
  ShiftHandover: 'ShiftHandover',
  AvailabilityOverride: 'AvailabilityOverride',
  Payout: 'Payout',
  ClinicalAssessment: 'ClinicalAssessment',
  MedicationRecon: 'MedicationRecon',
  SupervisionLog: 'SupervisionLog',
  FamilyNotification: 'FamilyNotification',
  CareFeedback: 'CareFeedback',
  TechnicalAudit: 'TechnicalAudit',
  RegistryEntry: 'RegistryEntry'
};

/**
 * This is a stub Prisma Client that will error at runtime if called.
 */
class PrismaClient {
  constructor() {
    return new Proxy(this, {
      get(target, prop) {
        let message
        const runtime = getRuntime()
        if (runtime.isEdge) {
          message = `PrismaClient is not configured to run in ${runtime.prettyName}. In order to run Prisma Client on edge runtime, either:
- Use Prisma Accelerate: https://pris.ly/d/accelerate
- Use Driver Adapters: https://pris.ly/d/driver-adapters
`;
        } else {
          message = 'PrismaClient is unable to run in this browser environment, or has been bundled for the browser (running in `' + runtime.prettyName + '`).'
        }
        
        message += `
If this is unexpected, please open an issue: https://pris.ly/prisma-prisma-bug-report`

        throw new Error(message)
      }
    })
  }
}

exports.PrismaClient = PrismaClient

Object.assign(exports, Prisma)
