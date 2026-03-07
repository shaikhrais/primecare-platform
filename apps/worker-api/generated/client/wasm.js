
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
  osmId: 'osmId',
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
  allowedVpnRanges: 'allowedVpnRanges',
  enforceVpn: 'enforceVpn',
  requireDeviceApproval: 'requireDeviceApproval',
  maxDevicesPerUser: 'maxDevicesPerUser',
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
  deviceId: 'deviceId',
  ipAddress: 'ipAddress',
  createdAt: 'createdAt',
  tenantId: 'tenantId'
};

exports.Prisma.SystemEventScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  operation: 'operation',
  modelName: 'modelName',
  entityId: 'entityId',
  payload: 'payload',
  previousData: 'previousData',
  actorUserId: 'actorUserId',
  deviceId: 'deviceId',
  ipAddress: 'ipAddress',
  createdAt: 'createdAt'
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

exports.Prisma.UserDeviceScalarFieldEnum = {
  id: 'id',
  userId: 'userId',
  deviceId: 'deviceId',
  deviceName: 'deviceName',
  deviceType: 'deviceType',
  lastIp: 'lastIp',
  status: 'status',
  isAuthorized: 'isAuthorized',
  authorizedAt: 'authorizedAt',
  isTemporary: 'isTemporary',
  expiresAt: 'expiresAt',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  lastActiveAt: 'lastActiveAt'
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

exports.Prisma.BookingRequestScalarFieldEnum = {
  id: 'id',
  clientId: 'clientId',
  tenantId: 'tenantId',
  serviceType: 'serviceType',
  preferredDate: 'preferredDate',
  preferredTime: 'preferredTime',
  notes: 'notes',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.DailyAuditSignOffScalarFieldEnum = {
  id: 'id',
  rnId: 'rnId',
  tenantId: 'tenantId',
  visitId: 'visitId',
  clinicalComment: 'clinicalComment',
  status: 'status',
  signedAt: 'signedAt'
};

exports.Prisma.WellnessPulseScalarFieldEnum = {
  id: 'id',
  userId: 'userId',
  tenantId: 'tenantId',
  status: 'status',
  note: 'note',
  createdAt: 'createdAt'
};

exports.Prisma.SystemTouchpointScalarFieldEnum = {
  id: 'id',
  touchpointId: 'touchpointId',
  type: 'type',
  role: 'role',
  module: 'module',
  label: 'label',
  path: 'path',
  status: 'status',
  errorDetail: 'errorDetail',
  isOverridden: 'isOverridden',
  overrideValue: 'overrideValue',
  lastChecked: 'lastChecked',
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
  SystemEvent: 'SystemEvent',
  Lead: 'Lead',
  Booking: 'Booking',
  PswAvailability: 'PswAvailability',
  ShiftAssignment: 'ShiftAssignment',
  BlogPost: 'BlogPost',
  StaffTask: 'StaffTask',
  PswDocument: 'PswDocument',
  FAQ: 'FAQ',
  DailyEntry: 'DailyEntry',
  UserDevice: 'UserDevice',
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
  RegistryEntry: 'RegistryEntry',
  BookingRequest: 'BookingRequest',
  DailyAuditSignOff: 'DailyAuditSignOff',
  WellnessPulse: 'WellnessPulse',
  SystemTouchpoint: 'SystemTouchpoint'
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
  "inlineSchema": "generator client {\n  provider        = \"prisma-client-js\"\n  previewFeatures = [\"driverAdapters\"]\n  output          = \"../generated/client\"\n}\n\ndatasource db {\n  provider = \"postgresql\"\n  url      = env(\"DATABASE_URL\")\n}\n\n// ==========================================\n// PLATFORM MODULES (Global Infrastructure)\n// ==========================================\n\nmodel User {\n  id                 String              @id @default(uuid())\n  email              String              @unique\n  phone              String?\n  passwordHash       String?             @map(\"password_hash\")\n  osmId              String?             @unique @map(\"osm_id\")\n  status             String?             @default(\"active\")\n  resetToken         String?\n  resetTokenExpiry   DateTime?\n  lastLoginAt        DateTime?           @map(\"last_login_at\")\n  createdAt          DateTime            @default(now()) @map(\"created_at\")\n  updatedAt          DateTime            @updatedAt @map(\"updated_at\")\n  tenantId           String              @map(\"tenant_id\")\n  roles              Role[]              @default([client])\n  auditLogs          AuditLog[]\n  blogPosts          BlogPost[]\n  clientProfile      ClientProfile?\n  DailyEntry         DailyEntry[]\n  reportedIncidents  Incident[]          @relation(\"Reporter\")\n  sentMessages       Message[]\n  verifiedDocs       PswDocument[]       @relation(\"VerifiedBy\")\n  pswProfile         PswProfile?\n  reviewedTimesheets Timesheet[]         @relation(\"ReviewedBy\")\n  telehealthSessions TelehealthSession[]\n  tenant             Tenant              @relation(fields: [tenantId], references: [id])\n  VisitCheckEvent    VisitCheckEvent[]\n\n  // RN Mastery Extensions\n  carePlansAuthored     CarePlan[]           @relation(\"CarePlanAuthor\")\n  assessments           ClinicalAssessment[]\n  medicationRecons      MedicationRecon[]\n  supervisionLogs       SupervisionLog[]\n  acknowledgedIncidents Incident[]           @relation(\"Acknowledger\")\n  performedAudits       TechnicalAudit[]     @relation(\"PerformedAudits\")\n  dailyAuditSignOffs    DailyAuditSignOff[]\n  wellnessPulses        WellnessPulse[]\n  devices               UserDevice[]\n  systemEvents          SystemEvent[]\n\n  @@index([tenantId])\n  @@map(\"users\")\n}\n\nmodel Tenant {\n  id                  String               @id @default(uuid())\n  name                String\n  slug                String               @unique\n  status              String               @default(\"active\")\n  createdAt           DateTime             @default(now()) @map(\"created_at\")\n  updatedAt           DateTime             @updatedAt @map(\"updated_at\")\n  auditLogs           AuditLog[]\n  bookings            Booking[]\n  clientProfiles      ClientProfile[]\n  dailyEntries        DailyEntry[]\n  incidents           Incident[]\n  invoices            Invoice[]\n  messageThreads      MessageThread[]\n  pswAvailability     PswAvailability[]\n  pswProfiles         PswProfile[]\n  services            Service[]\n  shiftAssignments    ShiftAssignment[]\n  timesheets          Timesheet[]\n  staffTasks          StaffTask[]\n  leads               Lead[]\n  users               User[]\n  checkEvents         VisitCheckEvent[]\n  visits              Visit[]\n  apiKeys             ApiKey[]\n  feedbacks           Feedback[]\n  carePlans           CarePlan[]\n  trainingModules     TrainingModule[]\n  surveys             Survey[]\n  regions             Region[]\n  clinicalRecords     ClinicalRecord[]\n  fhirSyncLogs        FhirSyncLog[]\n  aiRecommendations   AIRecommendation[]\n  sentimentAnalyses   SentimentAnalysis[]\n  securityThreats     SecurityThreat[]\n  slas                TenantSLA[]\n  telehealthSessions  TelehealthSession[]\n  patientAlerts       PatientAlert[]\n  insuranceProviders  InsuranceProvider[]\n  visitMatches        VisitMatch[]\n  waitlistEntries     WaitlistEntry[]\n  claims              Claim[]\n  prescriptions       Prescription[]\n  branchStats         BranchStat[]\n  complianceRecords   ComplianceRecord[]\n  familyNotifications FamilyNotification[]\n  careFeedbacks       CareFeedback[]\n  technicalAudits     TechnicalAudit[]\n  bookingRequests     BookingRequest[]\n  dailyAuditSignOffs  DailyAuditSignOff[]\n  wellnessPulses      WellnessPulse[]\n  systemTouchpoints   SystemTouchpoint[]\n\n  // Business Model Extensions\n  businessNumber  String? @map(\"business_number\")\n  supportEmail    String? @map(\"support_email\")\n  logoUrl         String? @map(\"logo_url\")\n  taxSettings     Json?   @map(\"tax_settings\")\n  brandingConfig  Json?   @map(\"branding_config\")\n  stripeAccountId String? @map(\"stripe_account_id\")\n  onboardingStep  Int     @default(1) @map(\"onboarding_step\")\n\n  // Security & Sovereignty Extensions\n  allowedVpnRanges      String[] @default([]) @map(\"allowed_vpn_ranges\")\n  enforceVpn            Boolean  @default(false) @map(\"enforce_vpn\")\n  requireDeviceApproval Boolean  @default(false) @map(\"require_device_approval\")\n  maxDevicesPerUser     Int      @default(5) @map(\"max_devices_per_user\")\n\n  // Fractal SaaS Extensions\n  parentTenantId        String?                @map(\"parent_tenant_id\")\n  parentTenant          Tenant?                @relation(\"TenantHierarchy\", fields: [parentTenantId], references: [id])\n  childTenants          Tenant[]               @relation(\"TenantHierarchy\")\n  franchises            Franchise[]            @relation(\"ResellerTenants\")\n  marketplaceListings   MarketplaceListing[]\n  handovers             ShiftHandover[]\n  availabilityOverrides AvailabilityOverride[]\n  payouts               Payout[]\n  clinicalAssessments   ClinicalAssessment[]\n  medicationRecons      MedicationRecon[]\n  supervisionLogs       SupervisionLog[]\n  inventoryItems        InventoryItem[]\n  purchaseOrders        PurchaseOrder[]\n  systemEvents          SystemEvent[]\n\n  @@map(\"tenants\")\n}\n\nmodel ApiKey {\n  id         String    @id @default(uuid())\n  key        String    @unique\n  name       String\n  status     String    @default(\"active\")\n  tenantId   String    @map(\"tenant_id\")\n  createdAt  DateTime  @default(now()) @map(\"created_at\")\n  lastUsedAt DateTime? @map(\"last_used_at\")\n  tenant     Tenant    @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"api_keys\")\n}\n\nmodel ClientProfile {\n  id                  String               @id @default(uuid())\n  userId              String               @unique @map(\"user_id\")\n  fullName            String               @map(\"full_name\")\n  dob                 DateTime?\n  addressLine1        String?              @map(\"address_line1\")\n  addressLine2        String?              @map(\"address_line2\")\n  city                String?\n  province            String?\n  postalCode          String?              @map(\"postal_code\")\n  lat                 Float?\n  lng                 Float?\n  emergencyName       String?              @map(\"emergency_contact_name\")\n  emergencyPhone      String?              @map(\"emergency_contact_phone\")\n  preferences         Json?                @map(\"preferences_json\")\n  createdAt           DateTime             @default(now()) @map(\"created_at\")\n  updatedAt           DateTime             @updatedAt @map(\"updated_at\")\n  tenantId            String               @map(\"tenant_id\")\n  bookings            Booking[]\n  tenant              Tenant               @relation(fields: [tenantId], references: [id])\n  user                User                 @relation(fields: [userId], references: [id])\n  DailyEntry          DailyEntry[]\n  invoices            Invoice[]\n  messageThreads      MessageThread[]\n  visits              Visit[]\n  feedbacks           Feedback[]\n  franchise           Franchise?           @relation(fields: [franchiseId], references: [id])\n  franchiseId         String?              @map(\"franchise_id\")\n  inventoryItems      InventoryItem[]\n  purchaseOrders      PurchaseOrder[]\n  telehealthSessions  TelehealthSession[]\n  vitalSigns          VitalSign[]\n  patientAlerts       PatientAlert[]\n  claims              Claim[]\n  prescriptions       Prescription[]\n  marEntries          MAR_Entry[]\n  carePlans           CarePlan[]\n  assessments         ClinicalAssessment[]\n  medicationRecons    MedicationRecon[]\n  waitlistEntries     WaitlistEntry[]\n  familyNotifications FamilyNotification[]\n  careFeedbacks       CareFeedback[]\n  bookingRequests     BookingRequest[]\n\n  @@index([tenantId])\n  @@map(\"client_profiles\")\n}\n\nmodel PswProfile {\n  id               String                 @id @default(uuid())\n  userId           String                 @unique @map(\"user_id\")\n  fullName         String                 @map(\"full_name\")\n  bio              String?\n  languages        String[]\n  serviceAreas     String[]               @map(\"service_areas\")\n  availabilityJson Json?                  @map(\"availability_json\")\n  isApproved       Boolean                @default(false) @map(\"is_approved\")\n  approvedAt       DateTime?              @map(\"approved_at\")\n  createdAt        DateTime               @default(now()) @map(\"created_at\")\n  tenantId         String                 @map(\"tenant_id\")\n  address          String?\n  avatarUrl        String?                @map(\"avatar_url\")\n  skills           String[]               @default([])\n  messageThreads   MessageThread[]        @relation(\"PswToThreads\")\n  availability     PswAvailability[]      @relation(\"PswToAvailability\")\n  documents        PswDocument[]          @relation(\"PswToDocuments\")\n  tenant           Tenant                 @relation(fields: [tenantId], references: [id])\n  user             User                   @relation(fields: [userId], references: [id])\n  assignments      ShiftAssignment[]      @relation(\"PswToAssignments\")\n  timesheets       Timesheet[]            @relation(\"PswToTimesheets\")\n  checkEvents      VisitCheckEvent[]      @relation(\"PswToCheckEvents\")\n  checklists       VisitChecklist[]       @relation(\"PswToChecklists\")\n  notes            VisitNote[]            @relation(\"PswToNotes\")\n  assignedVisits   Visit[]                @relation(\"PswToVisits\")\n  handovers        ShiftHandover[]\n  overrides        AvailabilityOverride[]\n  payouts          Payout[]\n  fleetStatus      FleetStatus?\n  supervisionLogs  SupervisionLog[]\n  matches          VisitMatch[]           @relation(\"VisitMatches\")\n\n  @@index([tenantId])\n  @@map(\"psw_profiles\")\n}\n\nmodel Visit {\n  id                  String             @id @default(uuid())\n  clientId            String             @map(\"client_id\")\n  serviceId           String             @map(\"service_id\")\n  requestedStartAt    DateTime           @map(\"requested_start_at\")\n  durationMinutes     Int                @map(\"duration_minutes\")\n  status              VisitStatus?       @default(requested)\n  assignedPswId       String?            @map(\"assigned_psw_id\")\n  serviceAddressLine1 String?            @map(\"service_address_line1\")\n  serviceAddressLine2 String?            @map(\"service_address_line2\")\n  serviceCity         String?            @map(\"service_city\")\n  serviceProvince     String?            @map(\"service_province\")\n  servicePostalCode   String?            @map(\"service_postal_code\")\n  serviceLat          Float?             @map(\"service_lat\")\n  serviceLng          Float?             @map(\"service_lng\")\n  clientNotes         String?            @map(\"client_notes\")\n  coordinatorNotes    String?            @map(\"coordinator_notes\")\n  cancellationReason  String?            @map(\"cancellation_reason\")\n  createdAt           DateTime           @default(now()) @map(\"created_at\")\n  updatedAt           DateTime           @updatedAt @map(\"updated_at\")\n  tenantId            String             @map(\"tenant_id\")\n  bookingId           String?            @map(\"booking_id\")\n  crisisMode          Boolean?           @default(false) @map(\"crisis_mode\")\n  priority            String?            @default(\"normal\")\n  requiredSkills      String[]           @map(\"required_skills\")\n  isSurgeActive       Boolean?           @default(false) @map(\"is_surge_active\")\n  surgeMultiplier     Float?             @default(1.0) @map(\"surge_multiplier\")\n  DailyEntry          DailyEntry[]\n  incidents           Incident[]\n  assignments         ShiftAssignment[]\n  timesheetItems      TimesheetItem[]\n  checkEvents         VisitCheckEvent[]\n  checklists          VisitChecklist[]\n  notes               VisitNote[]\n  feedbacks           Feedback[]\n  matches             VisitMatch[]\n  psw                 PswProfile?        @relation(\"PswToVisits\", fields: [assignedPswId], references: [id])\n  booking             Booking?           @relation(fields: [bookingId], references: [id])\n  client              ClientProfile      @relation(fields: [clientId], references: [id])\n  service             Service            @relation(fields: [serviceId], references: [id])\n  tenant              Tenant             @relation(fields: [tenantId], references: [id])\n  handovers           ShiftHandover[]\n  careFeedbacks       CareFeedback[]\n  dailyAuditSignOff   DailyAuditSignOff?\n\n  @@index([tenantId])\n  @@map(\"visits\")\n}\n\nmodel Service {\n  id                 String          @id @default(uuid())\n  name               String\n  slug               String          @unique\n  description        String?\n  baseRateHourly     Decimal?        @map(\"base_rate_hourly\") @db.Decimal(10, 2)\n  providerRateHourly Decimal?        @map(\"provider_rate_hourly\") @db.Decimal(10, 2)\n  isActive           Boolean?        @default(true) @map(\"is_active\")\n  createdAt          DateTime        @default(now()) @map(\"created_at\")\n  updatedAt          DateTime        @updatedAt @map(\"updated_at\")\n  tenantId           String          @map(\"tenant_id\")\n  isFeatured         Boolean         @default(false) @map(\"is_featured\")\n  tenant             Tenant          @relation(fields: [tenantId], references: [id])\n  visits             Visit[]\n  waitlistEntries    WaitlistEntry[]\n\n  @@index([tenantId])\n  @@map(\"services\")\n}\n\nmodel VisitCheckEvent {\n  id                String      @id @default(uuid())\n  visitId           String      @map(\"visit_id\")\n  pswId             String      @map(\"psw_id\")\n  eventType         EventType   @map(\"event_type\")\n  lat               Float?\n  lng               Float?\n  accuracyM         Float?      @map(\"accuracy_m\")\n  computedDistanceM Float?      @map(\"computed_distance_m\")\n  deviceTimeIso     DateTime?   @map(\"device_time_iso\")\n  serverTime        DateTime?   @default(now()) @map(\"server_time\")\n  result            EventResult\n  rejectReason      String?     @map(\"reject_reason\")\n  isOverride        Boolean?    @default(false) @map(\"is_override\")\n  overrideByUserId  String?     @map(\"override_by_user_id\")\n  overrideReason    String?     @map(\"override_reason\")\n  createdAt         DateTime    @default(now()) @map(\"created_at\")\n  tenantId          String      @map(\"tenant_id\")\n  overriddenBy      User?       @relation(fields: [overrideByUserId], references: [id])\n  pswProfile        PswProfile  @relation(\"PswToCheckEvents\", fields: [pswId], references: [id])\n  tenant            Tenant      @relation(fields: [tenantId], references: [id])\n  visit             Visit       @relation(fields: [visitId], references: [id])\n\n  @@map(\"visit_check_events\")\n}\n\nmodel VisitNote {\n  id        String     @id @default(uuid())\n  visitId   String     @map(\"visit_id\")\n  pswId     String     @map(\"psw_id\")\n  noteText  String     @map(\"note_text\")\n  createdAt DateTime   @default(now()) @map(\"created_at\")\n  psw       PswProfile @relation(\"PswToNotes\", fields: [pswId], references: [id])\n  visit     Visit      @relation(fields: [visitId], references: [id])\n\n  @@map(\"visit_notes\")\n}\n\nmodel VisitChecklist {\n  id            String     @id @default(uuid())\n  visitId       String     @map(\"visit_id\")\n  pswId         String     @map(\"psw_id\")\n  checklistJson Json       @map(\"checklist_json\")\n  createdAt     DateTime   @default(now()) @map(\"created_at\")\n  psw           PswProfile @relation(\"PswToChecklists\", fields: [pswId], references: [id])\n  visit         Visit      @relation(fields: [visitId], references: [id])\n\n  @@map(\"visit_checklists\")\n}\n\nmodel Incident {\n  id              String          @id @default(uuid())\n  visitId         String?         @map(\"visit_id\")\n  reporterUserId  String          @map(\"reporter_user_id\")\n  type            IncidentType\n  description     String\n  status          IncidentStatus? @default(open)\n  resolutionNotes String?         @map(\"resolution_notes\")\n  createdAt       DateTime        @default(now()) @map(\"created_at\")\n  updatedAt       DateTime        @updatedAt @map(\"updated_at\")\n  tenantId        String          @map(\"tenant_id\")\n  acknowledgedAt  DateTime?       @map(\"acknowledged_at\")\n  acknowledgedBy  String?         @map(\"acknowledged_by\")\n  acknowledger    User?           @relation(\"Acknowledger\", fields: [acknowledgedBy], references: [id])\n  reporter        User            @relation(\"Reporter\", fields: [reporterUserId], references: [id])\n  tenant          Tenant          @relation(fields: [tenantId], references: [id])\n  visit           Visit?          @relation(fields: [visitId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"incidents\")\n}\n\nmodel Timesheet {\n  id           String           @id @default(uuid())\n  pswId        String           @map(\"psw_id\")\n  weekId       String           @map(\"week_id\")\n  totalMinutes Int?             @default(0) @map(\"total_minutes\")\n  status       TimesheetStatus? @default(draft)\n  submittedAt  DateTime?        @map(\"submitted_at\")\n  reviewedBy   String?          @map(\"reviewed_by\")\n  reviewedAt   DateTime?        @map(\"reviewed_at\")\n  createdAt    DateTime         @default(now()) @map(\"created_at\")\n  updatedAt    DateTime         @updatedAt @map(\"updated_at\")\n  tenantId     String           @map(\"tenant_id\")\n  items        TimesheetItem[]\n  psw          PswProfile       @relation(\"PswToTimesheets\", fields: [pswId], references: [id])\n  reviewer     User?            @relation(\"ReviewedBy\", fields: [reviewedBy], references: [id])\n  tenant       Tenant           @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"timesheets\")\n}\n\nmodel TimesheetItem {\n  id          String    @id @default(uuid())\n  timesheetId String    @map(\"timesheet_id\")\n  visitId     String    @map(\"visit_id\")\n  minutes     Int\n  createdAt   DateTime  @default(now()) @map(\"created_at\")\n  timesheet   Timesheet @relation(fields: [timesheetId], references: [id])\n  visit       Visit     @relation(fields: [visitId], references: [id])\n\n  @@map(\"timesheet_items\")\n}\n\nmodel Invoice {\n  id              String         @id @default(uuid())\n  clientId        String         @map(\"client_id\")\n  status          InvoiceStatus? @default(draft)\n  currency        String?        @default(\"CAD\")\n  subtotal        Decimal?       @db.Decimal(10, 2)\n  tax             Decimal?       @db.Decimal(10, 2)\n  total           Decimal?       @db.Decimal(10, 2)\n  stripeInvoiceId String?        @map(\"stripe_invoice_id\")\n  createdAt       DateTime       @default(now()) @map(\"created_at\")\n  updatedAt       DateTime       @updatedAt @map(\"updated_at\")\n  tenantId        String         @map(\"tenant_id\")\n  client          ClientProfile  @relation(fields: [clientId], references: [id])\n  tenant          Tenant         @relation(fields: [tenantId], references: [id])\n  payments        Payment[]\n\n  @@index([tenantId])\n  @@map(\"invoices\")\n}\n\nmodel Payment {\n  id                    String   @id @default(uuid())\n  invoiceId             String   @map(\"invoice_id\")\n  stripePaymentIntentId String?  @map(\"stripe_payment_intent_id\")\n  amount                Decimal? @db.Decimal(10, 2)\n  status                String?\n  createdAt             DateTime @default(now()) @map(\"created_at\")\n  updatedAt             DateTime @updatedAt @map(\"updated_at\")\n  invoice               Invoice  @relation(fields: [invoiceId], references: [id])\n\n  @@map(\"payments\")\n}\n\nmodel MessageThread {\n  id         String         @id @default(uuid())\n  threadType String         @map(\"thread_type\")\n  clientId   String?        @map(\"client_id\")\n  pswId      String?        @map(\"psw_id\")\n  createdAt  DateTime       @default(now()) @map(\"created_at\")\n  tenantId   String         @map(\"tenant_id\")\n  messages   Message[]\n  client     ClientProfile? @relation(fields: [clientId], references: [id])\n  psw        PswProfile?    @relation(\"PswToThreads\", fields: [pswId], references: [id])\n  tenant     Tenant         @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"messages_threads\")\n}\n\nmodel Message {\n  id           String        @id @default(uuid())\n  threadId     String        @map(\"thread_id\")\n  senderUserId String        @map(\"sender_user_id\")\n  bodyText     String        @map(\"body_text\")\n  createdAt    DateTime      @default(now()) @map(\"created_at\")\n  sender       User          @relation(fields: [senderUserId], references: [id])\n  thread       MessageThread @relation(fields: [threadId], references: [id])\n\n  @@map(\"messages\")\n}\n\nmodel AuditLog {\n  id           String   @id @default(uuid())\n  actorUserId  String?  @map(\"actor_user_id\")\n  action       String\n  resourceType String   @map(\"resource_type\")\n  resourceId   String?  @map(\"resource_id\")\n  metadataJson Json?    @map(\"metadata_json\")\n  deviceId     String?  @map(\"device_id\")\n  ipAddress    String?  @map(\"ip_address\")\n  createdAt    DateTime @default(now()) @map(\"created_at\")\n  tenantId     String   @map(\"tenant_id\")\n  actor        User?    @relation(fields: [actorUserId], references: [id])\n  tenant       Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@index([deviceId])\n  @@map(\"audit_logs\")\n}\n\nmodel SystemEvent {\n  id           String   @id @default(uuid())\n  tenantId     String   @map(\"tenant_id\")\n  operation    String // CREATE, UPDATE, DELETE\n  modelName    String   @map(\"model_name\")\n  entityId     String?  @map(\"entity_id\")\n  payload      Json?\n  previousData Json?    @map(\"previous_data\")\n  actorUserId  String?  @map(\"actor_user_id\")\n  deviceId     String?  @map(\"device_id\")\n  ipAddress    String?  @map(\"ip_address\")\n  createdAt    DateTime @default(now()) @map(\"created_at\")\n\n  tenant Tenant @relation(fields: [tenantId], references: [id])\n  actor  User?  @relation(fields: [actorUserId], references: [id])\n\n  @@index([tenantId])\n  @@index([modelName, entityId])\n  @@index([createdAt])\n  @@map(\"system_events\")\n}\n\nmodel Lead {\n  id                String    @id @default(uuid())\n  fullName          String    @map(\"full_name\")\n  email             String\n  phone             String?\n  message           String?\n  source            String\n  status            String?   @default(\"new\")\n  serviceInterest   String[]  @default([]) @map(\"service_interest\")\n  notes             String?\n  convertedToUserId String?   @map(\"converted_to_user_id\")\n  conversionDate    DateTime? @map(\"conversion_date\")\n  tenantId          String?   @map(\"tenant_id\")\n  tenant            Tenant?   @relation(fields: [tenantId], references: [id])\n  createdAt         DateTime  @default(now()) @map(\"created_at\")\n  updatedAt         DateTime  @updatedAt @map(\"updated_at\")\n\n  @@index([tenantId])\n  @@map(\"leads\")\n}\n\nmodel Booking {\n  id             String        @id @default(uuid())\n  clientId       String        @map(\"client_id\")\n  branchId       String?       @map(\"branch_id\")\n  startAt        DateTime      @map(\"start_at\")\n  endAt          DateTime      @map(\"end_at\")\n  serviceType    String        @map(\"service_type\")\n  priority       String        @default(\"normal\")\n  notes          String?\n  status         String        @default(\"pending\")\n  recurrenceRule Json?         @map(\"recurrence_rule\")\n  tenantId       String        @map(\"tenant_id\")\n  client         ClientProfile @relation(fields: [clientId], references: [id])\n  tenant         Tenant        @relation(fields: [tenantId], references: [id])\n  visits         Visit[]\n\n  @@map(\"bookings\")\n}\n\nmodel PswAvailability {\n  id        String     @id @default(uuid())\n  pswId     String     @map(\"psw_id\")\n  dayOfWeek Int        @map(\"day_of_week\")\n  startTime String     @map(\"start_time\")\n  endTime   String     @map(\"end_time\")\n  tenantId  String     @map(\"tenant_id\")\n  psw       PswProfile @relation(\"PswToAvailability\", fields: [pswId], references: [id])\n  tenant    Tenant     @relation(fields: [tenantId], references: [id])\n\n  @@map(\"psw_availability\")\n}\n\nmodel ShiftAssignment {\n  id         String           @id @default(uuid())\n  visitId    String           @map(\"visit_id\")\n  pswId      String           @map(\"psw_id\")\n  status     AssignmentStatus @default(offered)\n  score      Float?\n  assignedAt DateTime         @default(now()) @map(\"assigned_at\")\n  tenantId   String           @map(\"tenant_id\")\n  psw        PswProfile       @relation(\"PswToAssignments\", fields: [pswId], references: [id])\n  tenant     Tenant           @relation(fields: [tenantId], references: [id])\n  visit      Visit            @relation(fields: [visitId], references: [id])\n\n  @@map(\"shift_assignments\")\n}\n\nmodel BlogPost {\n  id                String    @id @default(uuid())\n  title             String\n  slug              String    @unique\n  excerpt           String?\n  contentHtml       String?   @map(\"content_html\")\n  status            String?   @default(\"draft\")\n  publishedAt       DateTime? @map(\"published_at\")\n  authorUserId      String?   @map(\"author_user_id\")\n  featureImageDocId String?   @map(\"feature_image_doc_id\")\n  seoTitle          String?   @map(\"seo_title\")\n  seoDescription    String?   @map(\"seo_description\")\n  canonicalUrl      String?   @map(\"canonical_url\")\n  createdAt         DateTime  @default(now()) @map(\"created_at\")\n  updatedAt         DateTime  @updatedAt @map(\"updated_at\")\n  author            User?     @relation(fields: [authorUserId], references: [id])\n  targetRole        Role?     @map(\"target_role\")\n  category          String?   @default(\"announcement\")\n\n  @@map(\"blog_posts\")\n}\n\nmodel StaffTask {\n  id          String    @id @default(uuid())\n  title       String\n  description String?\n  status      String    @default(\"todo\") // todo, in_progress, completed, blocked\n  priority    String    @default(\"medium\") // low, medium, high, urgent\n  dueDate     DateTime? @map(\"due_date\")\n  assigneeId  String?   @map(\"assignee_id\")\n  tenantId    String    @map(\"tenant_id\")\n  createdAt   DateTime  @default(now()) @map(\"created_at\")\n  updatedAt   DateTime  @updatedAt @map(\"updated_at\")\n\n  tenant Tenant @relation(fields: [tenantId], references: [id])\n\n  @@map(\"staff_tasks\")\n}\n\nmodel PswDocument {\n  id         String     @id @default(uuid())\n  pswId      String     @map(\"psw_id\")\n  docType    String     @map(\"doc_type\")\n  fileKey    String     @map(\"file_key\")\n  status     DocStatus? @default(pending)\n  expiryDate DateTime?  @map(\"expiry_date\")\n  verifiedBy String?    @map(\"verified_by\")\n  verifiedAt DateTime?  @map(\"verified_at\")\n  createdAt  DateTime   @default(now()) @map(\"created_at\")\n  updatedAt  DateTime   @updatedAt @map(\"updated_at\")\n  psw        PswProfile @relation(\"PswToDocuments\", fields: [pswId], references: [id])\n  verifier   User?      @relation(\"VerifiedBy\", fields: [verifiedBy], references: [id])\n\n  @@map(\"psw_documents\")\n}\n\nmodel FAQ {\n  id        String   @id @default(uuid())\n  question  String\n  answer    String\n  category  String\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  updatedAt DateTime @updatedAt @map(\"updated_at\")\n\n  @@map(\"faqs\")\n}\n\nmodel DailyEntry {\n  id         String           @id @default(uuid())\n  tenantId   String           @map(\"tenant_id\")\n  clientId   String           @map(\"client_id\")\n  staffId    String           @map(\"staff_id\")\n  visitId    String?          @map(\"visit_id\")\n  adlData    Json             @map(\"adl_data\")\n  medication Json?\n  mood       Int?\n  vitals     Json?\n  notes      String?\n  signature  String?\n  status     DailyEntryStatus @default(DRAFT)\n  createdAt  DateTime         @default(now()) @map(\"created_at\")\n  updatedAt  DateTime         @updatedAt @map(\"updated_at\")\n  client     ClientProfile    @relation(fields: [clientId], references: [id])\n  staff      User             @relation(fields: [staffId], references: [id])\n  tenant     Tenant           @relation(fields: [tenantId], references: [id])\n  visit      Visit?           @relation(fields: [visitId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"daily_entries\")\n}\n\nmodel UserDevice {\n  id           String    @id @default(uuid())\n  userId       String    @map(\"user_id\")\n  deviceId     String    @map(\"device_id\")\n  deviceName   String?   @map(\"device_name\")\n  deviceType   String?   @map(\"device_type\")\n  lastIp       String?   @map(\"last_ip\")\n  status       String    @default(\"active\")\n  isAuthorized Boolean   @default(false) @map(\"is_authorized\")\n  authorizedAt DateTime? @map(\"authorized_at\")\n  isTemporary  Boolean   @default(false) @map(\"is_temporary\")\n  expiresAt    DateTime? @map(\"expires_at\")\n  createdAt    DateTime  @default(now()) @map(\"created_at\")\n  updatedAt    DateTime  @updatedAt @map(\"updated_at\")\n  lastActiveAt DateTime  @default(now()) @map(\"last_active_at\")\n  user         User      @relation(fields: [userId], references: [id])\n\n  @@unique([userId, deviceId])\n  @@index([userId])\n  @@map(\"user_devices\")\n}\n\nenum Role {\n  super_admin\n  admin\n  staff\n  manager\n  marketing_manager\n  operations_manager\n  hr_manager\n  clinical_manager\n  regional_manager\n  finance_manager\n  recruiting_manager\n  coordinator\n  client\n  psw\n  rn\n  rmt\n  rpt\n  rch\n  finance\n  scrum_master\n}\n\nenum DocStatus {\n  pending\n  verified\n  rejected\n}\n\nenum VisitStatus {\n  requested\n  scheduled\n  assigned\n  en_route\n  arrived\n  in_progress\n  completed\n  cancelled\n  draft\n  posted\n  offered\n  accepted\n  no_show\n  replaced\n}\n\nenum AssignmentStatus {\n  offered\n  accepted\n  declined\n  assigned\n}\n\nenum EventType {\n  check_in\n  check_out\n}\n\nenum EventResult {\n  success\n  rejected\n}\n\nenum IncidentType {\n  fall_risk\n  refusal\n  no_show\n  safety\n  medical_emergency\n  sos_alert\n  other\n}\n\nenum IncidentStatus {\n  open\n  investigating\n  resolved\n}\n\nenum TimesheetStatus {\n  draft\n  submitted\n  approved\n  rejected\n}\n\nenum InvoiceStatus {\n  draft\n  unpaid\n  paid\n  void\n}\n\nenum DailyEntryStatus {\n  DRAFT\n  SUBMITTED\n}\n\nmodel MarketplaceListing {\n  id          String   @id @default(uuid())\n  title       String\n  description String\n  price       Decimal  @db.Decimal(10, 2)\n  category    String\n  providerId  String   @map(\"provider_id\")\n  tenantId    String?  @map(\"tenant_id\")\n  createdAt   DateTime @default(now()) @map(\"created_at\")\n  updatedAt   DateTime @updatedAt @map(\"updated_at\")\n  tenant      Tenant?  @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"marketplace_listings\")\n}\n\nmodel Feedback {\n  id        String        @id @default(uuid())\n  clientId  String        @map(\"client_id\")\n  visitId   String?       @map(\"visit_id\")\n  rating    Int\n  comment   String?\n  status    String?       @default(\"pending\") // pending, reviewed, archived\n  createdAt DateTime      @default(now()) @map(\"created_at\")\n  updatedAt DateTime      @updatedAt @map(\"updated_at\")\n  tenantId  String        @map(\"tenant_id\")\n  client    ClientProfile @relation(fields: [clientId], references: [id])\n  tenant    Tenant        @relation(fields: [tenantId], references: [id])\n  visit     Visit?        @relation(fields: [visitId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"feedbacks\")\n}\n\nmodel CarePlan {\n  id            String    @id @default(uuid())\n  clientId      String    @map(\"client_id\")\n  tenantId      String    @map(\"tenant_id\")\n  diagnoses     String[]  @default([])\n  clinicalGoals Json?     @map(\"clinical_goals\")\n  interventions Json?     @map(\"interventions\")\n  status        String    @default(\"active\") // active, completed, archived\n  reviewDate    DateTime? @map(\"review_date\")\n  createdAt     DateTime  @default(now()) @map(\"created_at\")\n  updatedAt     DateTime  @updatedAt @map(\"updated_at\")\n\n  client ClientProfile @relation(fields: [clientId], references: [id])\n  tenant Tenant        @relation(fields: [tenantId], references: [id])\n\n  // RN Mastery Extensions\n  authorId     String? @map(\"author_id\")\n  version      Int     @default(1)\n  isArchived   Boolean @default(false) @map(\"is_archived\")\n  outcomeNotes String? @map(\"outcome_notes\")\n  author       User?   @relation(\"CarePlanAuthor\", fields: [authorId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"care_plans\")\n}\n\nmodel TrainingModule {\n  id          String               @id @default(uuid())\n  title       String\n  description String?\n  category    String?\n  videoUrl    String?              @map(\"video_url\")\n  createdAt   DateTime             @default(now()) @map(\"created_at\")\n  updatedAt   DateTime             @updatedAt @map(\"updated_at\")\n  tenantId    String               @map(\"tenant_id\")\n  tenant      Tenant               @relation(fields: [tenantId], references: [id])\n  assignments TrainingAssignment[]\n\n  @@index([tenantId])\n  @@map(\"training_modules\")\n}\n\nmodel TrainingAssignment {\n  id          String         @id @default(uuid())\n  pswId       String?        @map(\"psw_id\")\n  staffId     String?        @map(\"staff_id\")\n  moduleId    String         @map(\"module_id\")\n  status      String         @default(\"assigned\") // assigned, completed\n  completedAt DateTime?      @map(\"completed_at\")\n  assignedAt  DateTime       @default(now()) @map(\"assigned_at\")\n  module      TrainingModule @relation(fields: [moduleId], references: [id])\n\n  @@map(\"training_assignments\")\n}\n\nmodel Survey {\n  id         String           @id @default(uuid())\n  title      String\n  targetRole Role?            @map(\"target_role\")\n  questions  Json             @map(\"questions_json\")\n  isActive   Boolean          @default(true) @map(\"is_active\")\n  createdAt  DateTime         @default(now()) @map(\"created_at\")\n  tenantId   String           @map(\"tenant_id\")\n  tenant     Tenant           @relation(fields: [tenantId], references: [id])\n  responses  SurveyResponse[]\n\n  @@index([tenantId])\n  @@map(\"surveys\")\n}\n\nmodel SurveyResponse {\n  id        String   @id @default(uuid())\n  surveyId  String   @map(\"survey_id\")\n  userId    String   @map(\"user_id\")\n  answers   Json     @map(\"answers_json\")\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  survey    Survey   @relation(fields: [surveyId], references: [id])\n\n  @@map(\"survey_responses\")\n}\n\nmodel Region {\n  id        String           @id @default(uuid())\n  name      String           @unique\n  city      String\n  province  String\n  boundary  Json?            @map(\"boundary_json\")\n  status    String           @default(\"active\")\n  createdAt DateTime         @default(now()) @map(\"created_at\")\n  tenantId  String           @map(\"tenant_id\")\n  tenant    Tenant           @relation(fields: [tenantId], references: [id])\n  stats     BranchCapacity[]\n\n  @@index([tenantId])\n  @@map(\"regions\")\n}\n\nmodel BranchCapacity {\n  id              String   @id @default(uuid())\n  regionId        String   @map(\"region_id\")\n  totalStaff      Int      @default(0) @map(\"total_staff\")\n  availableStaff  Int      @default(0) @map(\"available_staff\")\n  activeVisits    Int      @default(0) @map(\"active_visits\")\n  pendingBookings Int      @default(0) @map(\"pending_bookings\")\n  utilizationRate Float?   @map(\"utilization_rate\")\n  timestamp       DateTime @default(now())\n  region          Region   @relation(fields: [regionId], references: [id])\n\n  @@map(\"branch_capacity\")\n}\n\nmodel ClinicalRecord {\n  id        String   @id @default(uuid())\n  clientId  String   @map(\"client_id\")\n  type      String // e.g., 'Observation', 'Condition', 'Medication'\n  data      Json     @map(\"data_json\") // FHIR-compliant structure\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  updatedAt DateTime @updatedAt @map(\"updated_at\")\n  tenantId  String   @map(\"tenant_id\")\n  tenant    Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@index([clientId])\n  @@index([tenantId])\n  @@map(\"clinical_records\")\n}\n\nmodel HealthID {\n  id        String   @id @default(uuid())\n  userId    String   @unique @map(\"user_id\")\n  did       String   @unique // W3C Decentralized Identifier\n  publicKey String   @map(\"public_key\")\n  status    String   @default(\"active\")\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  updatedAt DateTime @updatedAt @map(\"updated_at\")\n\n  @@map(\"health_ids\")\n}\n\nmodel FhirSyncLog {\n  id           String   @id @default(uuid())\n  direction    String // INBOUND, OUTBOUND\n  resourceType String   @map(\"resource_type\")\n  externalId   String?  @map(\"external_id\")\n  status       String // SUCCESS, FAILURE\n  error        String?\n  timestamp    DateTime @default(now())\n  tenantId     String   @map(\"tenant_id\")\n  tenant       Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"fhir_sync_logs\")\n}\n\nmodel AIRecommendation {\n  id        String   @id @default(uuid())\n  type      String // e.g., 'Staffing', 'Clinical', 'Financial'\n  priority  String // LOW, MEDIUM, HIGH, CRITICAL\n  content   String\n  isApplied Boolean  @default(false) @map(\"is_applied\")\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  tenantId  String   @map(\"tenant_id\")\n  tenant    Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"ai_recommendations\")\n}\n\nmodel SentimentAnalysis {\n  id        String   @id @default(uuid())\n  source    String // 'VisitNote', 'SupportChat', 'Survey'\n  sourceId  String   @map(\"source_id\")\n  score     Float // -1.0 to 1.0\n  magnitude Float\n  entities  Json?\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  tenantId  String   @map(\"tenant_id\")\n  tenant    Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"sentiment_analysis\")\n}\n\nmodel SecurityThreat {\n  id          String    @id @default(uuid())\n  type        String // e.g., 'BRUTE_FORCE', 'SQL_INJECTION', 'ANOMALOUS_LOGON'\n  severity    String // LOW, MEDIUM, HIGH, CRITICAL\n  status      String    @default(\"detected\") // detected, mitigating, resolved\n  description String\n  source      String? // IP address or user ID\n  detectedAt  DateTime  @default(now()) @map(\"detected_at\")\n  resolvedAt  DateTime? @map(\"resolved_at\")\n  tenantId    String    @map(\"tenant_id\")\n  tenant      Tenant    @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"security_threats\")\n}\n\nmodel TenantSLA {\n  id                 String   @id @default(uuid())\n  uptimeTarget       Float    @default(99.9) @map(\"uptime_target\")\n  responseTimeTarget Int      @default(500) @map(\"response_time_target\") // ms\n  supportTier        String   @default(\"STANDARD\") @map(\"support_tier\") // BRONZE, SILVER, GOLD, PLATINUM\n  status             String   @default(\"compliant\")\n  lastAuditAt        DateTime @default(now()) @map(\"last_audit_at\")\n  tenantId           String   @unique @map(\"tenant_id\")\n  tenant             Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@map(\"tenant_slas\")\n}\n\nmodel SystemPolicy {\n  id         String   @id @default(uuid())\n  code       String   @unique // e.g., 'CORE_SEC_01'\n  name       String\n  category   String // SECURITY, CLINICAL, BILLING, OPS\n  value      Json\n  isEnforced Boolean  @default(true) @map(\"is_enforced\")\n  version    Int      @default(1)\n  updatedAt  DateTime @updatedAt @map(\"updated_at\")\n\n  @@map(\"system_policies\")\n}\n\nmodel FleetStatus {\n  id              String     @id @default(uuid())\n  pswId           String     @unique @map(\"psw_id\")\n  lat             Float?\n  lng             Float?\n  status          String     @default(\"available\") // available, en_route, on_site, offline\n  batteryLevel    Int?       @map(\"battery_level\")\n  lastHeartbeatAt DateTime   @default(now()) @map(\"last_heartbeat_at\")\n  currentVisitId  String?    @map(\"current_visit_id\")\n  psw             PswProfile @relation(fields: [pswId], references: [id])\n\n  @@map(\"fleet_status\")\n}\n\nmodel ResponseBotAudit {\n  id         String   @id @default(uuid())\n  type       String // REGISTRY_CHECK, 404_HEARTBEAT, SCHEMA_PARITY\n  status     String   @default(\"success\") // success, warning, failure\n  summary    String\n  details    Json\n  durationMs Int      @map(\"duration_ms\")\n  createdAt  DateTime @default(now()) @map(\"created_at\")\n\n  @@map(\"response_bot_audits\")\n}\n\nmodel VisitMatch {\n  id        String   @id @default(uuid())\n  visitId   String   @map(\"visit_id\")\n  pswId     String   @map(\"psw_id\")\n  score     Float\n  status    String   @default(\"pending\") // pending, rejected, accepted\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  tenantId  String   @map(\"tenant_id\")\n\n  visit  Visit      @relation(fields: [visitId], references: [id])\n  psw    PswProfile @relation(\"VisitMatches\", fields: [pswId], references: [id])\n  tenant Tenant     @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"visit_matches\")\n}\n\nmodel WaitlistEntry {\n  id               String    @id @default(uuid())\n  clientId         String    @map(\"client_id\")\n  serviceId        String    @map(\"service_id\")\n  priority         Int       @default(0)\n  status           String    @default(\"active\") // active, matched, cancelled\n  notes            String?\n  requestedStartAt DateTime? @map(\"requested_start_at\")\n  createdAt        DateTime  @default(now()) @map(\"created_at\")\n  tenantId         String    @map(\"tenant_id\")\n\n  client  ClientProfile @relation(fields: [clientId], references: [id])\n  service Service       @relation(fields: [serviceId], references: [id])\n  tenant  Tenant        @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"waitlist_entries\")\n}\n\nmodel BranchStat {\n  id              String   @id @default(uuid())\n  date            DateTime @default(now())\n  utilization     Float\n  revenue         Float\n  churnRate       Float    @map(\"churn_rate\")\n  activeClients   Int      @map(\"active_clients\")\n  activeProviders Int      @map(\"active_providers\")\n  tenantId        String   @map(\"tenant_id\")\n  tenant          Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"branch_stats\")\n}\n\nmodel ComplianceRecord {\n  id         String   @id @default(uuid())\n  type       String // e.g., \"document_audit\", \"training_completion\"\n  status     String   @default(\"pending\") // pending, compliant, non_compliant\n  score      Float?\n  notes      String?\n  lastSyncAt DateTime @default(now()) @map(\"last_sync_at\")\n  tenantId   String   @map(\"tenant_id\")\n  tenant     Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"compliance_records\")\n}\n\nmodel Franchise {\n  id          String   @id @default(uuid())\n  name        String\n  resellerId  String   @map(\"reseller_id\") // The tenant that acts as reseller\n  ownerUserId String   @map(\"owner_user_id\")\n  status      String   @default(\"active\") // active, suspended, terminated\n  createdAt   DateTime @default(now()) @map(\"created_at\")\n  updatedAt   DateTime @updatedAt @map(\"updated_at\")\n\n  reseller   Tenant              @relation(\"ResellerTenants\", fields: [resellerId], references: [id])\n  agreements ResellerAgreement[]\n  clients    ClientProfile[]\n\n  @@map(\"franchises\")\n}\n\nmodel ResellerAgreement {\n  id            String    @id @default(uuid())\n  franchiseId   String    @map(\"franchise_id\")\n  terms         String\n  feePercentage Float     @map(\"fee_percentage\")\n  startDate     DateTime  @map(\"start_date\")\n  endDate       DateTime? @map(\"end_date\")\n  status        String    @default(\"active\")\n\n  franchise Franchise @relation(fields: [franchiseId], references: [id])\n\n  @@map(\"reseller_agreements\")\n}\n\nmodel Supplier {\n  id             String          @id @default(uuid())\n  name           String\n  contactName    String?         @map(\"contact_name\")\n  email          String?\n  phone          String?\n  category       String // MEDICAL_DEVICES, CONSUMABLES, PHARMACEUTICALS\n  status         String          @default(\"active\")\n  createdAt      DateTime        @default(now()) @map(\"created_at\")\n  purchaseOrders PurchaseOrder[]\n\n  @@map(\"suppliers\")\n}\n\nmodel InventoryItem {\n  id              String         @id @default(uuid())\n  name            String\n  sku             String         @unique\n  category        String\n  quantity        Int            @default(0)\n  reorderPoint    Int            @default(10) @map(\"reorder_point\")\n  unitPrice       Float          @map(\"unit_price\")\n  tenantId        String         @map(\"tenant_id\")\n  createdAt       DateTime       @default(now()) @map(\"created_at\")\n  updatedAt       DateTime       @updatedAt @map(\"updated_at\")\n  tenant          Tenant         @relation(fields: [tenantId], references: [id])\n  ClientProfile   ClientProfile? @relation(fields: [clientProfileId], references: [id])\n  clientProfileId String?\n\n  @@map(\"inventory_items\")\n}\n\nmodel PurchaseOrder {\n  id              String         @id @default(uuid())\n  poNumber        String         @unique @map(\"po_number\")\n  supplierId      String         @map(\"supplier_id\")\n  tenantId        String         @map(\"tenant_id\")\n  totalAmount     Float          @map(\"total_amount\")\n  status          String         @default(\"draft\") // draft, sent, received, cancelled\n  createdAt       DateTime       @default(now()) @map(\"created_at\")\n  supplier        Supplier       @relation(fields: [supplierId], references: [id])\n  tenant          Tenant         @relation(fields: [tenantId], references: [id])\n  ClientProfile   ClientProfile? @relation(fields: [clientProfileId], references: [id])\n  clientProfileId String?\n\n  @@map(\"purchase_orders\")\n}\n\nmodel TelehealthSession {\n  id          String    @id @default(uuid())\n  tenantId    String    @map(\"tenant_id\")\n  patientId   String    @map(\"patient_id\") // ClientProfile ID\n  providerId  String    @map(\"provider_id\") // User ID (RN, PSW, etc.)\n  startTime   DateTime  @map(\"start_time\")\n  endTime     DateTime? @map(\"end_time\")\n  meetingLink String?   @map(\"meeting_link\")\n  status      String    @default(\"scheduled\") // scheduled, in-progress, completed, cancelled\n  createdAt   DateTime  @default(now()) @map(\"created_at\")\n\n  tenant   Tenant        @relation(fields: [tenantId], references: [id])\n  patient  ClientProfile @relation(fields: [patientId], references: [id])\n  provider User          @relation(fields: [providerId], references: [id])\n\n  @@map(\"telehealth_sessions\")\n}\n\nmodel VitalSign {\n  id         String   @id @default(uuid())\n  patientId  String   @map(\"patient_id\")\n  type       String // HEART_RATE, BLOOD_PRESSURE, OXYGEN_SAT, TEMPERATURE\n  value      Float\n  unit       String\n  source     String   @default(\"MANUAL\") // MANUAL, WEARABLE, DEVICE\n  recordedAt DateTime @default(now()) @map(\"recorded_at\")\n\n  patient ClientProfile @relation(fields: [patientId], references: [id])\n\n  @@map(\"vital_signs\")\n}\n\nmodel PatientAlert {\n  id        String   @id @default(uuid())\n  tenantId  String   @map(\"tenant_id\")\n  patientId String   @map(\"patient_id\")\n  type      String // CLINICAL, OPERATIONAL, TECHNICAL\n  severity  String   @default(\"MEDIUM\") // LOW, MEDIUM, HIGH, CRITICAL\n  message   String\n  status    String   @default(\"open\") // open, acknowledged, resolved\n  createdAt DateTime @default(now()) @map(\"created_at\")\n\n  tenant  Tenant        @relation(fields: [tenantId], references: [id])\n  patient ClientProfile @relation(fields: [patientId], references: [id])\n\n  @@map(\"patient_alerts\")\n}\n\nmodel InsuranceProvider {\n  id           String   @id @default(uuid())\n  tenantId     String   @map(\"tenant_id\")\n  name         String\n  networkId    String?  @map(\"network_id\")\n  contactPhone String?  @map(\"contact_phone\")\n  claimsEmail  String?  @map(\"claims_email\")\n  createdAt    DateTime @default(now()) @map(\"created_at\")\n\n  tenant Tenant  @relation(fields: [tenantId], references: [id])\n  claims Claim[]\n\n  @@map(\"insurance_providers\")\n}\n\nmodel Claim {\n  id           String   @id @default(uuid())\n  tenantId     String   @map(\"tenant_id\")\n  patientId    String   @map(\"patient_id\")\n  providerId   String   @map(\"provider_id\") // InsuranceProvider ID\n  serviceDate  DateTime @map(\"service_date\")\n  amount       Float\n  status       String   @default(\"draft\") // draft, submitted, pending, paid, denied\n  denialReason String?  @map(\"denial_reason\")\n  createdAt    DateTime @default(now()) @map(\"created_at\")\n\n  tenant   Tenant            @relation(fields: [tenantId], references: [id])\n  patient  ClientProfile     @relation(fields: [patientId], references: [id])\n  provider InsuranceProvider @relation(fields: [providerId], references: [id])\n\n  @@map(\"claims\")\n}\n\nmodel BillingCode {\n  id          String @id @default(uuid())\n  code        String @unique\n  description String\n  category    String // HCPCS, CPT, ICD-10\n  defaultRate Float  @map(\"default_rate\")\n\n  @@map(\"billing_codes\")\n}\n\nmodel Medication {\n  id           String   @id @default(uuid())\n  name         String\n  genericName  String?  @map(\"generic_name\")\n  dosageForm   String?  @map(\"dosage_form\") // Tablet, Injection, etc.\n  strength     String?\n  instructions String?\n  createdAt    DateTime @default(now()) @map(\"created_at\")\n\n  prescriptions Prescription[]\n\n  @@map(\"medications\")\n}\n\nmodel Prescription {\n  id           String    @id @default(uuid())\n  tenantId     String    @map(\"tenant_id\")\n  patientId    String    @map(\"patient_id\")\n  medicationId String    @map(\"medication_id\")\n  prescriberId String?   @map(\"prescriber_id\")\n  dosage       String\n  frequency    String\n  route        String\n  startDate    DateTime  @map(\"start_date\")\n  endDate      DateTime? @map(\"end_date\")\n  status       String    @default(\"active\") // active, completed, discontinued\n  createdAt    DateTime  @default(now()) @map(\"created_at\")\n\n  tenant     Tenant        @relation(fields: [tenantId], references: [id])\n  patient    ClientProfile @relation(fields: [patientId], references: [id])\n  medication Medication    @relation(fields: [medicationId], references: [id])\n  marEntries MAR_Entry[]\n\n  @@map(\"prescriptions\")\n}\n\nmodel MAR_Entry {\n  id             String   @id @default(uuid())\n  patientId      String   @map(\"patient_id\")\n  prescriptionId String   @map(\"prescription_id\")\n  administerId   String?  @map(\"administer_id\") // User ID (PSW, RN)\n  adminTime      DateTime @default(now()) @map(\"admin_time\")\n  status         String   @default(\"administered\") // administered, missed, refused\n  notes          String?\n\n  patient      ClientProfile @relation(fields: [patientId], references: [id])\n  prescription Prescription  @relation(fields: [prescriptionId], references: [id])\n\n  @@map(\"mar_entries\")\n}\n\nmodel ShiftHandover {\n  id             String   @id @default(uuid())\n  pswId          String   @map(\"psw_id\")\n  visitId        String   @map(\"visit_id\")\n  tenantId       String   @map(\"tenant_id\")\n  handoverNotes  String   @map(\"handover_notes\")\n  safetyConcerns String?  @map(\"safety_concerns\")\n  suppliesNeeded String?  @map(\"supplies_needed\")\n  createdAt      DateTime @default(now()) @map(\"created_at\")\n\n  psw    PswProfile @relation(fields: [pswId], references: [id])\n  visit  Visit      @relation(fields: [visitId], references: [id])\n  tenant Tenant     @relation(fields: [tenantId], references: [id])\n\n  @@map(\"shift_handovers\")\n}\n\nmodel AvailabilityOverride {\n  id          String   @id @default(uuid())\n  pswId       String   @map(\"psw_id\")\n  tenantId    String   @map(\"tenant_id\")\n  date        DateTime\n  startTime   String   @map(\"start_time\")\n  endTime     String   @map(\"end_time\")\n  isAvailable Boolean  @default(true) @map(\"is_available\")\n\n  psw    PswProfile @relation(fields: [pswId], references: [id])\n  tenant Tenant     @relation(fields: [tenantId], references: [id])\n\n  @@map(\"psw_availability_overrides\")\n}\n\nmodel Payout {\n  id          String    @id @default(uuid())\n  pswId       String    @map(\"psw_id\")\n  tenantId    String    @map(\"tenant_id\")\n  amount      Decimal   @db.Decimal(10, 2)\n  currency    String    @default(\"CAD\")\n  status      String    @default(\"pending\") // pending, paid, failed\n  processedAt DateTime? @map(\"processed_at\")\n  createdAt   DateTime  @default(now()) @map(\"created_at\")\n\n  psw    PswProfile @relation(fields: [pswId], references: [id])\n  tenant Tenant     @relation(fields: [tenantId], references: [id])\n\n  @@map(\"payouts\")\n}\n\nmodel ClinicalAssessment {\n  id              String   @id @default(uuid())\n  clientId        String   @map(\"client_id\")\n  rnId            String   @map(\"rn_id\")\n  tenantId        String   @map(\"tenant_id\")\n  type            String // ADL, MOBILITY, COGNITIVE, etc.\n  assessmentData  Json     @map(\"assessment_data\")\n  score           Int?\n  recommendations String?\n  createdAt       DateTime @default(now()) @map(\"created_at\")\n  updatedAt       DateTime @updatedAt @map(\"updated_at\")\n\n  client ClientProfile @relation(fields: [clientId], references: [id])\n  rn     User          @relation(fields: [rnId], references: [id])\n  tenant Tenant        @relation(fields: [tenantId], references: [id])\n\n  @@map(\"clinical_assessments\")\n}\n\nmodel MedicationRecon {\n  id            String   @id @default(uuid())\n  clientId      String   @map(\"client_id\")\n  rnId          String   @map(\"rn_id\")\n  tenantId      String   @map(\"tenant_id\")\n  reconData     Json     @map(\"recon_data\")\n  discrepancies String?\n  status        String   @default(\"completed\") // completed, pending_review\n  createdAt     DateTime @default(now()) @map(\"created_at\")\n\n  client ClientProfile @relation(fields: [clientId], references: [id])\n  rn     User          @relation(fields: [rnId], references: [id])\n  tenant Tenant        @relation(fields: [tenantId], references: [id])\n\n  @@map(\"medication_reconciliations\")\n}\n\nmodel SupervisionLog {\n  id             String   @id @default(uuid())\n  pswId          String   @map(\"psw_id\")\n  rnId           String   @map(\"rn_id\")\n  tenantId       String   @map(\"tenant_id\")\n  competencies   Json\n  isSatisfactory Boolean  @default(true) @map(\"is_satisfactory\")\n  feedback       String?\n  createdAt      DateTime @default(now()) @map(\"created_at\")\n\n  psw    PswProfile @relation(fields: [pswId], references: [id])\n  rn     User       @relation(fields: [rnId], references: [id])\n  tenant Tenant     @relation(fields: [tenantId], references: [id])\n\n  @@map(\"supervision_logs\")\n}\n\nmodel FamilyNotification {\n  id        String        @id @default(uuid())\n  clientId  String        @map(\"client_id\")\n  type      String // VISIT_STARTED, ALERT, BILLING\n  message   String\n  isRead    Boolean       @default(false) @map(\"is_read\")\n  createdAt DateTime      @default(now()) @map(\"created_at\")\n  client    ClientProfile @relation(fields: [clientId], references: [id])\n  tenantId  String        @map(\"tenant_id\")\n  tenant    Tenant        @relation(fields: [tenantId], references: [id])\n\n  @@map(\"family_notifications\")\n}\n\nmodel CareFeedback {\n  id              String        @id @default(uuid())\n  clientId        String        @map(\"client_id\")\n  visitId         String        @map(\"visit_id\")\n  rating          Int\n  comment         String?\n  triageStatus    String        @default(\"pending\") @map(\"triage_status\")\n  resolutionNotes String?       @map(\"resolution_notes\")\n  createdAt       DateTime      @default(now()) @map(\"created_at\")\n  client          ClientProfile @relation(fields: [clientId], references: [id])\n  visit           Visit         @relation(fields: [visitId], references: [id])\n  tenantId        String        @map(\"tenant_id\")\n  tenant          Tenant        @relation(fields: [tenantId], references: [id])\n\n  @@map(\"care_feedbacks\")\n}\n\nmodel TechnicalAudit {\n  id            String   @id @default(uuid())\n  type          String   @map(\"audit_type\") // LINK_REGISTRY, BUTTON_REGISTRY, etc.\n  status        String   @default(\"success\")\n  summary       String\n  issuesCount   Int      @default(0) @map(\"issues_count\")\n  details       Json?\n  performedById String?  @map(\"performed_by_id\")\n  performedAt   DateTime @default(now()) @map(\"performed_at\")\n  tenantId      String?  @map(\"tenant_id\")\n\n  performedBy User?   @relation(\"PerformedAudits\", fields: [performedById], references: [id])\n  tenant      Tenant? @relation(fields: [tenantId], references: [id])\n\n  @@map(\"technical_audits\")\n}\n\nmodel RegistryEntry {\n  id          String    @id @default(uuid())\n  externalId  String    @unique @map(\"external_id\") // e.g., 'btn-admin-user-invite'\n  type        String // button, link, interaction\n  label       String\n  role        String\n  module      String\n  action      String?\n  targetPath  String?   @map(\"target_path\")\n  description String?\n  status      String    @default(\"active\")\n  lastChecked DateTime? @map(\"last_checked\")\n  errorCount  Int       @default(0) @map(\"error_count\")\n  metadata    Json?\n  createdAt   DateTime  @default(now()) @map(\"created_at\")\n  updatedAt   DateTime  @updatedAt @map(\"updated_at\")\n\n  @@map(\"registry_entries\")\n}\n\nmodel BookingRequest {\n  id            String   @id @default(uuid())\n  clientId      String   @map(\"client_id\")\n  tenantId      String   @map(\"tenant_id\")\n  serviceType   String   @map(\"service_type\")\n  preferredDate DateTime @map(\"preferred_date\")\n  preferredTime String?  @map(\"preferred_time\")\n  notes         String?\n  status        String   @default(\"pending\") // pending, approved, rejected, cancelled\n  createdAt     DateTime @default(now()) @map(\"created_at\")\n  updatedAt     DateTime @updatedAt @map(\"updated_at\")\n\n  client ClientProfile @relation(fields: [clientId], references: [id])\n  tenant Tenant        @relation(fields: [tenantId], references: [id])\n\n  @@map(\"booking_requests\")\n}\n\nmodel DailyAuditSignOff {\n  id              String   @id @default(uuid())\n  rnId            String   @map(\"rn_id\")\n  tenantId        String   @map(\"tenant_id\")\n  visitId         String   @unique @map(\"visit_id\")\n  clinicalComment String?  @map(\"clinical_comment\")\n  status          String   @default(\"verified\") // verified, flagged\n  signedAt        DateTime @default(now()) @map(\"signed_at\")\n\n  rn     User   @relation(fields: [rnId], references: [id])\n  tenant Tenant @relation(fields: [tenantId], references: [id])\n  visit  Visit  @relation(fields: [visitId], references: [id])\n\n  @@map(\"daily_audit_signoffs\")\n}\n\nmodel WellnessPulse {\n  id        String   @id @default(uuid())\n  userId    String   @map(\"user_id\")\n  tenantId  String   @map(\"tenant_id\")\n  status    String // great, okay, struggling, burnout\n  note      String?\n  createdAt DateTime @default(now()) @map(\"created_at\")\n\n  user   User   @relation(fields: [userId], references: [id])\n  tenant Tenant @relation(fields: [tenantId], references: [id])\n\n  @@map(\"wellness_pulses\")\n}\n\nmodel SystemTouchpoint {\n  id            String   @id @default(uuid())\n  touchpointId  String   @unique @map(\"touchpoint_id\")\n  type          String // BUTTON, LINK, INTERACTION\n  role          String\n  module        String\n  label         String? // The text displayed on UI\n  path          String\n  status        String   @default(\"OK\") // OK, 404, ERROR\n  errorDetail   String?  @map(\"error_detail\")\n  isOverridden  Boolean  @default(false) @map(\"is_overridden\")\n  overrideValue String?  @map(\"override_value\")\n  lastChecked   DateTime @default(now()) @map(\"last_checked\")\n  tenantId      String   @map(\"tenant_id\")\n  tenant        Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@map(\"system_touchpoints\")\n}\n",
  "inlineSchemaHash": "0c92c667e252ec5f8f0482e8350b08272210b36713bfa086112068a50431cdb1",
  "copyEngine": true
}
config.dirname = '/'

config.runtimeDataModel = JSON.parse("{\"models\":{\"User\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"email\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"phone\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"passwordHash\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"password_hash\"},{\"name\":\"osmId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"osm_id\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"resetToken\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"resetTokenExpiry\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"lastLoginAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_login_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"roles\",\"kind\":\"enum\",\"type\":\"Role\"},{\"name\":\"auditLogs\",\"kind\":\"object\",\"type\":\"AuditLog\",\"relationName\":\"AuditLogToUser\"},{\"name\":\"blogPosts\",\"kind\":\"object\",\"type\":\"BlogPost\",\"relationName\":\"BlogPostToUser\"},{\"name\":\"clientProfile\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToUser\"},{\"name\":\"DailyEntry\",\"kind\":\"object\",\"type\":\"DailyEntry\",\"relationName\":\"DailyEntryToUser\"},{\"name\":\"reportedIncidents\",\"kind\":\"object\",\"type\":\"Incident\",\"relationName\":\"Reporter\"},{\"name\":\"sentMessages\",\"kind\":\"object\",\"type\":\"Message\",\"relationName\":\"MessageToUser\"},{\"name\":\"verifiedDocs\",\"kind\":\"object\",\"type\":\"PswDocument\",\"relationName\":\"VerifiedBy\"},{\"name\":\"pswProfile\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswProfileToUser\"},{\"name\":\"reviewedTimesheets\",\"kind\":\"object\",\"type\":\"Timesheet\",\"relationName\":\"ReviewedBy\"},{\"name\":\"telehealthSessions\",\"kind\":\"object\",\"type\":\"TelehealthSession\",\"relationName\":\"TelehealthSessionToUser\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToUser\"},{\"name\":\"VisitCheckEvent\",\"kind\":\"object\",\"type\":\"VisitCheckEvent\",\"relationName\":\"UserToVisitCheckEvent\"},{\"name\":\"carePlansAuthored\",\"kind\":\"object\",\"type\":\"CarePlan\",\"relationName\":\"CarePlanAuthor\"},{\"name\":\"assessments\",\"kind\":\"object\",\"type\":\"ClinicalAssessment\",\"relationName\":\"ClinicalAssessmentToUser\"},{\"name\":\"medicationRecons\",\"kind\":\"object\",\"type\":\"MedicationRecon\",\"relationName\":\"MedicationReconToUser\"},{\"name\":\"supervisionLogs\",\"kind\":\"object\",\"type\":\"SupervisionLog\",\"relationName\":\"SupervisionLogToUser\"},{\"name\":\"acknowledgedIncidents\",\"kind\":\"object\",\"type\":\"Incident\",\"relationName\":\"Acknowledger\"},{\"name\":\"performedAudits\",\"kind\":\"object\",\"type\":\"TechnicalAudit\",\"relationName\":\"PerformedAudits\"},{\"name\":\"dailyAuditSignOffs\",\"kind\":\"object\",\"type\":\"DailyAuditSignOff\",\"relationName\":\"DailyAuditSignOffToUser\"},{\"name\":\"wellnessPulses\",\"kind\":\"object\",\"type\":\"WellnessPulse\",\"relationName\":\"UserToWellnessPulse\"},{\"name\":\"devices\",\"kind\":\"object\",\"type\":\"UserDevice\",\"relationName\":\"UserToUserDevice\"},{\"name\":\"systemEvents\",\"kind\":\"object\",\"type\":\"SystemEvent\",\"relationName\":\"SystemEventToUser\"}],\"dbName\":\"users\"},\"Tenant\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"slug\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"auditLogs\",\"kind\":\"object\",\"type\":\"AuditLog\",\"relationName\":\"AuditLogToTenant\"},{\"name\":\"bookings\",\"kind\":\"object\",\"type\":\"Booking\",\"relationName\":\"BookingToTenant\"},{\"name\":\"clientProfiles\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToTenant\"},{\"name\":\"dailyEntries\",\"kind\":\"object\",\"type\":\"DailyEntry\",\"relationName\":\"DailyEntryToTenant\"},{\"name\":\"incidents\",\"kind\":\"object\",\"type\":\"Incident\",\"relationName\":\"IncidentToTenant\"},{\"name\":\"invoices\",\"kind\":\"object\",\"type\":\"Invoice\",\"relationName\":\"InvoiceToTenant\"},{\"name\":\"messageThreads\",\"kind\":\"object\",\"type\":\"MessageThread\",\"relationName\":\"MessageThreadToTenant\"},{\"name\":\"pswAvailability\",\"kind\":\"object\",\"type\":\"PswAvailability\",\"relationName\":\"PswAvailabilityToTenant\"},{\"name\":\"pswProfiles\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswProfileToTenant\"},{\"name\":\"services\",\"kind\":\"object\",\"type\":\"Service\",\"relationName\":\"ServiceToTenant\"},{\"name\":\"shiftAssignments\",\"kind\":\"object\",\"type\":\"ShiftAssignment\",\"relationName\":\"ShiftAssignmentToTenant\"},{\"name\":\"timesheets\",\"kind\":\"object\",\"type\":\"Timesheet\",\"relationName\":\"TenantToTimesheet\"},{\"name\":\"staffTasks\",\"kind\":\"object\",\"type\":\"StaffTask\",\"relationName\":\"StaffTaskToTenant\"},{\"name\":\"leads\",\"kind\":\"object\",\"type\":\"Lead\",\"relationName\":\"LeadToTenant\"},{\"name\":\"users\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"TenantToUser\"},{\"name\":\"checkEvents\",\"kind\":\"object\",\"type\":\"VisitCheckEvent\",\"relationName\":\"TenantToVisitCheckEvent\"},{\"name\":\"visits\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"TenantToVisit\"},{\"name\":\"apiKeys\",\"kind\":\"object\",\"type\":\"ApiKey\",\"relationName\":\"ApiKeyToTenant\"},{\"name\":\"feedbacks\",\"kind\":\"object\",\"type\":\"Feedback\",\"relationName\":\"FeedbackToTenant\"},{\"name\":\"carePlans\",\"kind\":\"object\",\"type\":\"CarePlan\",\"relationName\":\"CarePlanToTenant\"},{\"name\":\"trainingModules\",\"kind\":\"object\",\"type\":\"TrainingModule\",\"relationName\":\"TenantToTrainingModule\"},{\"name\":\"surveys\",\"kind\":\"object\",\"type\":\"Survey\",\"relationName\":\"SurveyToTenant\"},{\"name\":\"regions\",\"kind\":\"object\",\"type\":\"Region\",\"relationName\":\"RegionToTenant\"},{\"name\":\"clinicalRecords\",\"kind\":\"object\",\"type\":\"ClinicalRecord\",\"relationName\":\"ClinicalRecordToTenant\"},{\"name\":\"fhirSyncLogs\",\"kind\":\"object\",\"type\":\"FhirSyncLog\",\"relationName\":\"FhirSyncLogToTenant\"},{\"name\":\"aiRecommendations\",\"kind\":\"object\",\"type\":\"AIRecommendation\",\"relationName\":\"AIRecommendationToTenant\"},{\"name\":\"sentimentAnalyses\",\"kind\":\"object\",\"type\":\"SentimentAnalysis\",\"relationName\":\"SentimentAnalysisToTenant\"},{\"name\":\"securityThreats\",\"kind\":\"object\",\"type\":\"SecurityThreat\",\"relationName\":\"SecurityThreatToTenant\"},{\"name\":\"slas\",\"kind\":\"object\",\"type\":\"TenantSLA\",\"relationName\":\"TenantToTenantSLA\"},{\"name\":\"telehealthSessions\",\"kind\":\"object\",\"type\":\"TelehealthSession\",\"relationName\":\"TelehealthSessionToTenant\"},{\"name\":\"patientAlerts\",\"kind\":\"object\",\"type\":\"PatientAlert\",\"relationName\":\"PatientAlertToTenant\"},{\"name\":\"insuranceProviders\",\"kind\":\"object\",\"type\":\"InsuranceProvider\",\"relationName\":\"InsuranceProviderToTenant\"},{\"name\":\"visitMatches\",\"kind\":\"object\",\"type\":\"VisitMatch\",\"relationName\":\"TenantToVisitMatch\"},{\"name\":\"waitlistEntries\",\"kind\":\"object\",\"type\":\"WaitlistEntry\",\"relationName\":\"TenantToWaitlistEntry\"},{\"name\":\"claims\",\"kind\":\"object\",\"type\":\"Claim\",\"relationName\":\"ClaimToTenant\"},{\"name\":\"prescriptions\",\"kind\":\"object\",\"type\":\"Prescription\",\"relationName\":\"PrescriptionToTenant\"},{\"name\":\"branchStats\",\"kind\":\"object\",\"type\":\"BranchStat\",\"relationName\":\"BranchStatToTenant\"},{\"name\":\"complianceRecords\",\"kind\":\"object\",\"type\":\"ComplianceRecord\",\"relationName\":\"ComplianceRecordToTenant\"},{\"name\":\"familyNotifications\",\"kind\":\"object\",\"type\":\"FamilyNotification\",\"relationName\":\"FamilyNotificationToTenant\"},{\"name\":\"careFeedbacks\",\"kind\":\"object\",\"type\":\"CareFeedback\",\"relationName\":\"CareFeedbackToTenant\"},{\"name\":\"technicalAudits\",\"kind\":\"object\",\"type\":\"TechnicalAudit\",\"relationName\":\"TechnicalAuditToTenant\"},{\"name\":\"bookingRequests\",\"kind\":\"object\",\"type\":\"BookingRequest\",\"relationName\":\"BookingRequestToTenant\"},{\"name\":\"dailyAuditSignOffs\",\"kind\":\"object\",\"type\":\"DailyAuditSignOff\",\"relationName\":\"DailyAuditSignOffToTenant\"},{\"name\":\"wellnessPulses\",\"kind\":\"object\",\"type\":\"WellnessPulse\",\"relationName\":\"TenantToWellnessPulse\"},{\"name\":\"systemTouchpoints\",\"kind\":\"object\",\"type\":\"SystemTouchpoint\",\"relationName\":\"SystemTouchpointToTenant\"},{\"name\":\"businessNumber\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"business_number\"},{\"name\":\"supportEmail\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"support_email\"},{\"name\":\"logoUrl\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"logo_url\"},{\"name\":\"taxSettings\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"tax_settings\"},{\"name\":\"brandingConfig\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"branding_config\"},{\"name\":\"stripeAccountId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"stripe_account_id\"},{\"name\":\"onboardingStep\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"onboarding_step\"},{\"name\":\"allowedVpnRanges\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"allowed_vpn_ranges\"},{\"name\":\"enforceVpn\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"enforce_vpn\"},{\"name\":\"requireDeviceApproval\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"require_device_approval\"},{\"name\":\"maxDevicesPerUser\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"max_devices_per_user\"},{\"name\":\"parentTenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"parent_tenant_id\"},{\"name\":\"parentTenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantHierarchy\"},{\"name\":\"childTenants\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantHierarchy\"},{\"name\":\"franchises\",\"kind\":\"object\",\"type\":\"Franchise\",\"relationName\":\"ResellerTenants\"},{\"name\":\"marketplaceListings\",\"kind\":\"object\",\"type\":\"MarketplaceListing\",\"relationName\":\"MarketplaceListingToTenant\"},{\"name\":\"handovers\",\"kind\":\"object\",\"type\":\"ShiftHandover\",\"relationName\":\"ShiftHandoverToTenant\"},{\"name\":\"availabilityOverrides\",\"kind\":\"object\",\"type\":\"AvailabilityOverride\",\"relationName\":\"AvailabilityOverrideToTenant\"},{\"name\":\"payouts\",\"kind\":\"object\",\"type\":\"Payout\",\"relationName\":\"PayoutToTenant\"},{\"name\":\"clinicalAssessments\",\"kind\":\"object\",\"type\":\"ClinicalAssessment\",\"relationName\":\"ClinicalAssessmentToTenant\"},{\"name\":\"medicationRecons\",\"kind\":\"object\",\"type\":\"MedicationRecon\",\"relationName\":\"MedicationReconToTenant\"},{\"name\":\"supervisionLogs\",\"kind\":\"object\",\"type\":\"SupervisionLog\",\"relationName\":\"SupervisionLogToTenant\"},{\"name\":\"inventoryItems\",\"kind\":\"object\",\"type\":\"InventoryItem\",\"relationName\":\"InventoryItemToTenant\"},{\"name\":\"purchaseOrders\",\"kind\":\"object\",\"type\":\"PurchaseOrder\",\"relationName\":\"PurchaseOrderToTenant\"},{\"name\":\"systemEvents\",\"kind\":\"object\",\"type\":\"SystemEvent\",\"relationName\":\"SystemEventToTenant\"}],\"dbName\":\"tenants\"},\"ApiKey\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"key\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"lastUsedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_used_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ApiKeyToTenant\"}],\"dbName\":\"api_keys\"},\"ClientProfile\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"fullName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"full_name\"},{\"name\":\"dob\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"addressLine1\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"address_line1\"},{\"name\":\"addressLine2\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"address_line2\"},{\"name\":\"city\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"province\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"postalCode\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"postal_code\"},{\"name\":\"lat\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"lng\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"emergencyName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"emergency_contact_name\"},{\"name\":\"emergencyPhone\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"emergency_contact_phone\"},{\"name\":\"preferences\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"preferences_json\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"bookings\",\"kind\":\"object\",\"type\":\"Booking\",\"relationName\":\"BookingToClientProfile\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ClientProfileToTenant\"},{\"name\":\"user\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"ClientProfileToUser\"},{\"name\":\"DailyEntry\",\"kind\":\"object\",\"type\":\"DailyEntry\",\"relationName\":\"ClientProfileToDailyEntry\"},{\"name\":\"invoices\",\"kind\":\"object\",\"type\":\"Invoice\",\"relationName\":\"ClientProfileToInvoice\"},{\"name\":\"messageThreads\",\"kind\":\"object\",\"type\":\"MessageThread\",\"relationName\":\"ClientProfileToMessageThread\"},{\"name\":\"visits\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"ClientProfileToVisit\"},{\"name\":\"feedbacks\",\"kind\":\"object\",\"type\":\"Feedback\",\"relationName\":\"ClientProfileToFeedback\"},{\"name\":\"franchise\",\"kind\":\"object\",\"type\":\"Franchise\",\"relationName\":\"ClientProfileToFranchise\"},{\"name\":\"franchiseId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"franchise_id\"},{\"name\":\"inventoryItems\",\"kind\":\"object\",\"type\":\"InventoryItem\",\"relationName\":\"ClientProfileToInventoryItem\"},{\"name\":\"purchaseOrders\",\"kind\":\"object\",\"type\":\"PurchaseOrder\",\"relationName\":\"ClientProfileToPurchaseOrder\"},{\"name\":\"telehealthSessions\",\"kind\":\"object\",\"type\":\"TelehealthSession\",\"relationName\":\"ClientProfileToTelehealthSession\"},{\"name\":\"vitalSigns\",\"kind\":\"object\",\"type\":\"VitalSign\",\"relationName\":\"ClientProfileToVitalSign\"},{\"name\":\"patientAlerts\",\"kind\":\"object\",\"type\":\"PatientAlert\",\"relationName\":\"ClientProfileToPatientAlert\"},{\"name\":\"claims\",\"kind\":\"object\",\"type\":\"Claim\",\"relationName\":\"ClaimToClientProfile\"},{\"name\":\"prescriptions\",\"kind\":\"object\",\"type\":\"Prescription\",\"relationName\":\"ClientProfileToPrescription\"},{\"name\":\"marEntries\",\"kind\":\"object\",\"type\":\"MAR_Entry\",\"relationName\":\"ClientProfileToMAR_Entry\"},{\"name\":\"carePlans\",\"kind\":\"object\",\"type\":\"CarePlan\",\"relationName\":\"CarePlanToClientProfile\"},{\"name\":\"assessments\",\"kind\":\"object\",\"type\":\"ClinicalAssessment\",\"relationName\":\"ClientProfileToClinicalAssessment\"},{\"name\":\"medicationRecons\",\"kind\":\"object\",\"type\":\"MedicationRecon\",\"relationName\":\"ClientProfileToMedicationRecon\"},{\"name\":\"waitlistEntries\",\"kind\":\"object\",\"type\":\"WaitlistEntry\",\"relationName\":\"ClientProfileToWaitlistEntry\"},{\"name\":\"familyNotifications\",\"kind\":\"object\",\"type\":\"FamilyNotification\",\"relationName\":\"ClientProfileToFamilyNotification\"},{\"name\":\"careFeedbacks\",\"kind\":\"object\",\"type\":\"CareFeedback\",\"relationName\":\"CareFeedbackToClientProfile\"},{\"name\":\"bookingRequests\",\"kind\":\"object\",\"type\":\"BookingRequest\",\"relationName\":\"BookingRequestToClientProfile\"}],\"dbName\":\"client_profiles\"},\"PswProfile\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"fullName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"full_name\"},{\"name\":\"bio\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"languages\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"serviceAreas\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_areas\"},{\"name\":\"availabilityJson\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"availability_json\"},{\"name\":\"isApproved\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_approved\"},{\"name\":\"approvedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"approved_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"address\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"avatarUrl\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"avatar_url\"},{\"name\":\"skills\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"messageThreads\",\"kind\":\"object\",\"type\":\"MessageThread\",\"relationName\":\"PswToThreads\"},{\"name\":\"availability\",\"kind\":\"object\",\"type\":\"PswAvailability\",\"relationName\":\"PswToAvailability\"},{\"name\":\"documents\",\"kind\":\"object\",\"type\":\"PswDocument\",\"relationName\":\"PswToDocuments\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"PswProfileToTenant\"},{\"name\":\"user\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"PswProfileToUser\"},{\"name\":\"assignments\",\"kind\":\"object\",\"type\":\"ShiftAssignment\",\"relationName\":\"PswToAssignments\"},{\"name\":\"timesheets\",\"kind\":\"object\",\"type\":\"Timesheet\",\"relationName\":\"PswToTimesheets\"},{\"name\":\"checkEvents\",\"kind\":\"object\",\"type\":\"VisitCheckEvent\",\"relationName\":\"PswToCheckEvents\"},{\"name\":\"checklists\",\"kind\":\"object\",\"type\":\"VisitChecklist\",\"relationName\":\"PswToChecklists\"},{\"name\":\"notes\",\"kind\":\"object\",\"type\":\"VisitNote\",\"relationName\":\"PswToNotes\"},{\"name\":\"assignedVisits\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"PswToVisits\"},{\"name\":\"handovers\",\"kind\":\"object\",\"type\":\"ShiftHandover\",\"relationName\":\"PswProfileToShiftHandover\"},{\"name\":\"overrides\",\"kind\":\"object\",\"type\":\"AvailabilityOverride\",\"relationName\":\"AvailabilityOverrideToPswProfile\"},{\"name\":\"payouts\",\"kind\":\"object\",\"type\":\"Payout\",\"relationName\":\"PayoutToPswProfile\"},{\"name\":\"fleetStatus\",\"kind\":\"object\",\"type\":\"FleetStatus\",\"relationName\":\"FleetStatusToPswProfile\"},{\"name\":\"supervisionLogs\",\"kind\":\"object\",\"type\":\"SupervisionLog\",\"relationName\":\"PswProfileToSupervisionLog\"},{\"name\":\"matches\",\"kind\":\"object\",\"type\":\"VisitMatch\",\"relationName\":\"VisitMatches\"}],\"dbName\":\"psw_profiles\"},\"Visit\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"serviceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_id\"},{\"name\":\"requestedStartAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"requested_start_at\"},{\"name\":\"durationMinutes\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"duration_minutes\"},{\"name\":\"status\",\"kind\":\"enum\",\"type\":\"VisitStatus\"},{\"name\":\"assignedPswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"assigned_psw_id\"},{\"name\":\"serviceAddressLine1\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_address_line1\"},{\"name\":\"serviceAddressLine2\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_address_line2\"},{\"name\":\"serviceCity\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_city\"},{\"name\":\"serviceProvince\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_province\"},{\"name\":\"servicePostalCode\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_postal_code\"},{\"name\":\"serviceLat\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"service_lat\"},{\"name\":\"serviceLng\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"service_lng\"},{\"name\":\"clientNotes\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_notes\"},{\"name\":\"coordinatorNotes\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"coordinator_notes\"},{\"name\":\"cancellationReason\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"cancellation_reason\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"bookingId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"booking_id\"},{\"name\":\"crisisMode\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"crisis_mode\"},{\"name\":\"priority\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"requiredSkills\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"required_skills\"},{\"name\":\"isSurgeActive\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_surge_active\"},{\"name\":\"surgeMultiplier\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"surge_multiplier\"},{\"name\":\"DailyEntry\",\"kind\":\"object\",\"type\":\"DailyEntry\",\"relationName\":\"DailyEntryToVisit\"},{\"name\":\"incidents\",\"kind\":\"object\",\"type\":\"Incident\",\"relationName\":\"IncidentToVisit\"},{\"name\":\"assignments\",\"kind\":\"object\",\"type\":\"ShiftAssignment\",\"relationName\":\"ShiftAssignmentToVisit\"},{\"name\":\"timesheetItems\",\"kind\":\"object\",\"type\":\"TimesheetItem\",\"relationName\":\"TimesheetItemToVisit\"},{\"name\":\"checkEvents\",\"kind\":\"object\",\"type\":\"VisitCheckEvent\",\"relationName\":\"VisitToVisitCheckEvent\"},{\"name\":\"checklists\",\"kind\":\"object\",\"type\":\"VisitChecklist\",\"relationName\":\"VisitToVisitChecklist\"},{\"name\":\"notes\",\"kind\":\"object\",\"type\":\"VisitNote\",\"relationName\":\"VisitToVisitNote\"},{\"name\":\"feedbacks\",\"kind\":\"object\",\"type\":\"Feedback\",\"relationName\":\"FeedbackToVisit\"},{\"name\":\"matches\",\"kind\":\"object\",\"type\":\"VisitMatch\",\"relationName\":\"VisitToVisitMatch\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToVisits\"},{\"name\":\"booking\",\"kind\":\"object\",\"type\":\"Booking\",\"relationName\":\"BookingToVisit\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToVisit\"},{\"name\":\"service\",\"kind\":\"object\",\"type\":\"Service\",\"relationName\":\"ServiceToVisit\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToVisit\"},{\"name\":\"handovers\",\"kind\":\"object\",\"type\":\"ShiftHandover\",\"relationName\":\"ShiftHandoverToVisit\"},{\"name\":\"careFeedbacks\",\"kind\":\"object\",\"type\":\"CareFeedback\",\"relationName\":\"CareFeedbackToVisit\"},{\"name\":\"dailyAuditSignOff\",\"kind\":\"object\",\"type\":\"DailyAuditSignOff\",\"relationName\":\"DailyAuditSignOffToVisit\"}],\"dbName\":\"visits\"},\"Service\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"slug\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"baseRateHourly\",\"kind\":\"scalar\",\"type\":\"Decimal\",\"dbName\":\"base_rate_hourly\"},{\"name\":\"providerRateHourly\",\"kind\":\"scalar\",\"type\":\"Decimal\",\"dbName\":\"provider_rate_hourly\"},{\"name\":\"isActive\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_active\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"isFeatured\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_featured\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ServiceToTenant\"},{\"name\":\"visits\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"ServiceToVisit\"},{\"name\":\"waitlistEntries\",\"kind\":\"object\",\"type\":\"WaitlistEntry\",\"relationName\":\"ServiceToWaitlistEntry\"}],\"dbName\":\"services\"},\"VisitCheckEvent\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"eventType\",\"kind\":\"enum\",\"type\":\"EventType\",\"dbName\":\"event_type\"},{\"name\":\"lat\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"lng\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"accuracyM\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"accuracy_m\"},{\"name\":\"computedDistanceM\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"computed_distance_m\"},{\"name\":\"deviceTimeIso\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"device_time_iso\"},{\"name\":\"serverTime\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"server_time\"},{\"name\":\"result\",\"kind\":\"enum\",\"type\":\"EventResult\"},{\"name\":\"rejectReason\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"reject_reason\"},{\"name\":\"isOverride\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_override\"},{\"name\":\"overrideByUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"override_by_user_id\"},{\"name\":\"overrideReason\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"override_reason\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"overriddenBy\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"UserToVisitCheckEvent\"},{\"name\":\"pswProfile\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToCheckEvents\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToVisitCheckEvent\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"VisitToVisitCheckEvent\"}],\"dbName\":\"visit_check_events\"},\"VisitNote\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"noteText\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"note_text\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToNotes\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"VisitToVisitNote\"}],\"dbName\":\"visit_notes\"},\"VisitChecklist\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"checklistJson\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"checklist_json\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToChecklists\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"VisitToVisitChecklist\"}],\"dbName\":\"visit_checklists\"},\"Incident\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"reporterUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"reporter_user_id\"},{\"name\":\"type\",\"kind\":\"enum\",\"type\":\"IncidentType\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"enum\",\"type\":\"IncidentStatus\"},{\"name\":\"resolutionNotes\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"resolution_notes\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"acknowledgedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"acknowledged_at\"},{\"name\":\"acknowledgedBy\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"acknowledged_by\"},{\"name\":\"acknowledger\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"Acknowledger\"},{\"name\":\"reporter\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"Reporter\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"IncidentToTenant\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"IncidentToVisit\"}],\"dbName\":\"incidents\"},\"Timesheet\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"weekId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"week_id\"},{\"name\":\"totalMinutes\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"total_minutes\"},{\"name\":\"status\",\"kind\":\"enum\",\"type\":\"TimesheetStatus\"},{\"name\":\"submittedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"submitted_at\"},{\"name\":\"reviewedBy\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"reviewed_by\"},{\"name\":\"reviewedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"reviewed_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"items\",\"kind\":\"object\",\"type\":\"TimesheetItem\",\"relationName\":\"TimesheetToTimesheetItem\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToTimesheets\"},{\"name\":\"reviewer\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"ReviewedBy\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToTimesheet\"}],\"dbName\":\"timesheets\"},\"TimesheetItem\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"timesheetId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"timesheet_id\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"minutes\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"timesheet\",\"kind\":\"object\",\"type\":\"Timesheet\",\"relationName\":\"TimesheetToTimesheetItem\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"TimesheetItemToVisit\"}],\"dbName\":\"timesheet_items\"},\"Invoice\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"status\",\"kind\":\"enum\",\"type\":\"InvoiceStatus\"},{\"name\":\"currency\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"subtotal\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"tax\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"total\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"stripeInvoiceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"stripe_invoice_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToInvoice\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"InvoiceToTenant\"},{\"name\":\"payments\",\"kind\":\"object\",\"type\":\"Payment\",\"relationName\":\"InvoiceToPayment\"}],\"dbName\":\"invoices\"},\"Payment\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"invoiceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"invoice_id\"},{\"name\":\"stripePaymentIntentId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"stripe_payment_intent_id\"},{\"name\":\"amount\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"invoice\",\"kind\":\"object\",\"type\":\"Invoice\",\"relationName\":\"InvoiceToPayment\"}],\"dbName\":\"payments\"},\"MessageThread\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"threadType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"thread_type\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"messages\",\"kind\":\"object\",\"type\":\"Message\",\"relationName\":\"MessageToMessageThread\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToMessageThread\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToThreads\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"MessageThreadToTenant\"}],\"dbName\":\"messages_threads\"},\"Message\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"threadId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"thread_id\"},{\"name\":\"senderUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"sender_user_id\"},{\"name\":\"bodyText\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"body_text\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"sender\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"MessageToUser\"},{\"name\":\"thread\",\"kind\":\"object\",\"type\":\"MessageThread\",\"relationName\":\"MessageToMessageThread\"}],\"dbName\":\"messages\"},\"AuditLog\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"actorUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"actor_user_id\"},{\"name\":\"action\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"resourceType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"resource_type\"},{\"name\":\"resourceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"resource_id\"},{\"name\":\"metadataJson\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"metadata_json\"},{\"name\":\"deviceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"device_id\"},{\"name\":\"ipAddress\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"ip_address\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"actor\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"AuditLogToUser\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"AuditLogToTenant\"}],\"dbName\":\"audit_logs\"},\"SystemEvent\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"operation\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"modelName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"model_name\"},{\"name\":\"entityId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"entity_id\"},{\"name\":\"payload\",\"kind\":\"scalar\",\"type\":\"Json\"},{\"name\":\"previousData\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"previous_data\"},{\"name\":\"actorUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"actor_user_id\"},{\"name\":\"deviceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"device_id\"},{\"name\":\"ipAddress\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"ip_address\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"SystemEventToTenant\"},{\"name\":\"actor\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"SystemEventToUser\"}],\"dbName\":\"system_events\"},\"Lead\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"fullName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"full_name\"},{\"name\":\"email\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"phone\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"message\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"source\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"serviceInterest\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_interest\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"convertedToUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"converted_to_user_id\"},{\"name\":\"conversionDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"conversion_date\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"LeadToTenant\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"}],\"dbName\":\"leads\"},\"Booking\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"branchId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"branch_id\"},{\"name\":\"startAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"start_at\"},{\"name\":\"endAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"end_at\"},{\"name\":\"serviceType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_type\"},{\"name\":\"priority\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"recurrenceRule\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"recurrence_rule\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"BookingToClientProfile\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"BookingToTenant\"},{\"name\":\"visits\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"BookingToVisit\"}],\"dbName\":\"bookings\"},\"PswAvailability\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"dayOfWeek\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"day_of_week\"},{\"name\":\"startTime\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"start_time\"},{\"name\":\"endTime\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"end_time\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToAvailability\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"PswAvailabilityToTenant\"}],\"dbName\":\"psw_availability\"},\"ShiftAssignment\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"status\",\"kind\":\"enum\",\"type\":\"AssignmentStatus\"},{\"name\":\"score\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"assignedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"assigned_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToAssignments\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ShiftAssignmentToTenant\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"ShiftAssignmentToVisit\"}],\"dbName\":\"shift_assignments\"},\"BlogPost\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"slug\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"excerpt\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"contentHtml\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"content_html\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"publishedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"published_at\"},{\"name\":\"authorUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"author_user_id\"},{\"name\":\"featureImageDocId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"feature_image_doc_id\"},{\"name\":\"seoTitle\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"seo_title\"},{\"name\":\"seoDescription\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"seo_description\"},{\"name\":\"canonicalUrl\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"canonical_url\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"author\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"BlogPostToUser\"},{\"name\":\"targetRole\",\"kind\":\"enum\",\"type\":\"Role\",\"dbName\":\"target_role\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"}],\"dbName\":\"blog_posts\"},\"StaffTask\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"priority\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"dueDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"due_date\"},{\"name\":\"assigneeId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"assignee_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"StaffTaskToTenant\"}],\"dbName\":\"staff_tasks\"},\"PswDocument\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"docType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"doc_type\"},{\"name\":\"fileKey\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"file_key\"},{\"name\":\"status\",\"kind\":\"enum\",\"type\":\"DocStatus\"},{\"name\":\"expiryDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"expiry_date\"},{\"name\":\"verifiedBy\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"verified_by\"},{\"name\":\"verifiedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"verified_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToDocuments\"},{\"name\":\"verifier\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"VerifiedBy\"}],\"dbName\":\"psw_documents\"},\"FAQ\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"question\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"answer\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"}],\"dbName\":\"faqs\"},\"DailyEntry\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"staffId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"staff_id\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"adlData\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"adl_data\"},{\"name\":\"medication\",\"kind\":\"scalar\",\"type\":\"Json\"},{\"name\":\"mood\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"vitals\",\"kind\":\"scalar\",\"type\":\"Json\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"signature\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"enum\",\"type\":\"DailyEntryStatus\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToDailyEntry\"},{\"name\":\"staff\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"DailyEntryToUser\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"DailyEntryToTenant\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"DailyEntryToVisit\"}],\"dbName\":\"daily_entries\"},\"UserDevice\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"deviceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"device_id\"},{\"name\":\"deviceName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"device_name\"},{\"name\":\"deviceType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"device_type\"},{\"name\":\"lastIp\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"last_ip\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"isAuthorized\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_authorized\"},{\"name\":\"authorizedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"authorized_at\"},{\"name\":\"isTemporary\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_temporary\"},{\"name\":\"expiresAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"expires_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"lastActiveAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_active_at\"},{\"name\":\"user\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"UserToUserDevice\"}],\"dbName\":\"user_devices\"},\"MarketplaceListing\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"price\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"providerId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"provider_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"MarketplaceListingToTenant\"}],\"dbName\":\"marketplace_listings\"},\"Feedback\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"rating\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"comment\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToFeedback\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"FeedbackToTenant\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"FeedbackToVisit\"}],\"dbName\":\"feedbacks\"},\"CarePlan\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"diagnoses\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clinicalGoals\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"clinical_goals\"},{\"name\":\"interventions\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"interventions\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"reviewDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"review_date\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"CarePlanToClientProfile\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"CarePlanToTenant\"},{\"name\":\"authorId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"author_id\"},{\"name\":\"version\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"isArchived\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_archived\"},{\"name\":\"outcomeNotes\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"outcome_notes\"},{\"name\":\"author\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"CarePlanAuthor\"}],\"dbName\":\"care_plans\"},\"TrainingModule\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"videoUrl\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"video_url\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToTrainingModule\"},{\"name\":\"assignments\",\"kind\":\"object\",\"type\":\"TrainingAssignment\",\"relationName\":\"TrainingAssignmentToTrainingModule\"}],\"dbName\":\"training_modules\"},\"TrainingAssignment\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"staffId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"staff_id\"},{\"name\":\"moduleId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"module_id\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"completedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"completed_at\"},{\"name\":\"assignedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"assigned_at\"},{\"name\":\"module\",\"kind\":\"object\",\"type\":\"TrainingModule\",\"relationName\":\"TrainingAssignmentToTrainingModule\"}],\"dbName\":\"training_assignments\"},\"Survey\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"targetRole\",\"kind\":\"enum\",\"type\":\"Role\",\"dbName\":\"target_role\"},{\"name\":\"questions\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"questions_json\"},{\"name\":\"isActive\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_active\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"SurveyToTenant\"},{\"name\":\"responses\",\"kind\":\"object\",\"type\":\"SurveyResponse\",\"relationName\":\"SurveyToSurveyResponse\"}],\"dbName\":\"surveys\"},\"SurveyResponse\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"surveyId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"survey_id\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"answers\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"answers_json\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"survey\",\"kind\":\"object\",\"type\":\"Survey\",\"relationName\":\"SurveyToSurveyResponse\"}],\"dbName\":\"survey_responses\"},\"Region\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"city\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"province\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"boundary\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"boundary_json\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"RegionToTenant\"},{\"name\":\"stats\",\"kind\":\"object\",\"type\":\"BranchCapacity\",\"relationName\":\"BranchCapacityToRegion\"}],\"dbName\":\"regions\"},\"BranchCapacity\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"regionId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"region_id\"},{\"name\":\"totalStaff\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"total_staff\"},{\"name\":\"availableStaff\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"available_staff\"},{\"name\":\"activeVisits\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"active_visits\"},{\"name\":\"pendingBookings\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"pending_bookings\"},{\"name\":\"utilizationRate\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"utilization_rate\"},{\"name\":\"timestamp\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"region\",\"kind\":\"object\",\"type\":\"Region\",\"relationName\":\"BranchCapacityToRegion\"}],\"dbName\":\"branch_capacity\"},\"ClinicalRecord\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"data\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"data_json\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ClinicalRecordToTenant\"}],\"dbName\":\"clinical_records\"},\"HealthID\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"did\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"publicKey\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"public_key\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"}],\"dbName\":\"health_ids\"},\"FhirSyncLog\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"direction\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"resourceType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"resource_type\"},{\"name\":\"externalId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"external_id\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"error\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"timestamp\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"FhirSyncLogToTenant\"}],\"dbName\":\"fhir_sync_logs\"},\"AIRecommendation\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"priority\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"content\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"isApplied\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_applied\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"AIRecommendationToTenant\"}],\"dbName\":\"ai_recommendations\"},\"SentimentAnalysis\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"source\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"sourceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"source_id\"},{\"name\":\"score\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"magnitude\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"entities\",\"kind\":\"scalar\",\"type\":\"Json\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"SentimentAnalysisToTenant\"}],\"dbName\":\"sentiment_analysis\"},\"SecurityThreat\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"severity\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"source\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"detectedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"detected_at\"},{\"name\":\"resolvedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"resolved_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"SecurityThreatToTenant\"}],\"dbName\":\"security_threats\"},\"TenantSLA\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"uptimeTarget\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"uptime_target\"},{\"name\":\"responseTimeTarget\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"response_time_target\"},{\"name\":\"supportTier\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"support_tier\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"lastAuditAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_audit_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToTenantSLA\"}],\"dbName\":\"tenant_slas\"},\"SystemPolicy\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"code\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"value\",\"kind\":\"scalar\",\"type\":\"Json\"},{\"name\":\"isEnforced\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_enforced\"},{\"name\":\"version\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"}],\"dbName\":\"system_policies\"},\"FleetStatus\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"lat\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"lng\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"batteryLevel\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"battery_level\"},{\"name\":\"lastHeartbeatAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_heartbeat_at\"},{\"name\":\"currentVisitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"current_visit_id\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"FleetStatusToPswProfile\"}],\"dbName\":\"fleet_status\"},\"ResponseBotAudit\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"summary\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"details\",\"kind\":\"scalar\",\"type\":\"Json\"},{\"name\":\"durationMs\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"duration_ms\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"}],\"dbName\":\"response_bot_audits\"},\"VisitMatch\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"score\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"VisitToVisitMatch\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"VisitMatches\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToVisitMatch\"}],\"dbName\":\"visit_matches\"},\"WaitlistEntry\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"serviceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_id\"},{\"name\":\"priority\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"requestedStartAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"requested_start_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToWaitlistEntry\"},{\"name\":\"service\",\"kind\":\"object\",\"type\":\"Service\",\"relationName\":\"ServiceToWaitlistEntry\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToWaitlistEntry\"}],\"dbName\":\"waitlist_entries\"},\"BranchStat\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"date\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"utilization\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"revenue\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"churnRate\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"churn_rate\"},{\"name\":\"activeClients\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"active_clients\"},{\"name\":\"activeProviders\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"active_providers\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"BranchStatToTenant\"}],\"dbName\":\"branch_stats\"},\"ComplianceRecord\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"score\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"lastSyncAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_sync_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ComplianceRecordToTenant\"}],\"dbName\":\"compliance_records\"},\"Franchise\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"resellerId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"reseller_id\"},{\"name\":\"ownerUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"owner_user_id\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"reseller\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ResellerTenants\"},{\"name\":\"agreements\",\"kind\":\"object\",\"type\":\"ResellerAgreement\",\"relationName\":\"FranchiseToResellerAgreement\"},{\"name\":\"clients\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToFranchise\"}],\"dbName\":\"franchises\"},\"ResellerAgreement\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"franchiseId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"franchise_id\"},{\"name\":\"terms\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"feePercentage\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"fee_percentage\"},{\"name\":\"startDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"start_date\"},{\"name\":\"endDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"end_date\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"franchise\",\"kind\":\"object\",\"type\":\"Franchise\",\"relationName\":\"FranchiseToResellerAgreement\"}],\"dbName\":\"reseller_agreements\"},\"Supplier\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"contactName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"contact_name\"},{\"name\":\"email\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"phone\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"purchaseOrders\",\"kind\":\"object\",\"type\":\"PurchaseOrder\",\"relationName\":\"PurchaseOrderToSupplier\"}],\"dbName\":\"suppliers\"},\"InventoryItem\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"sku\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"quantity\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"reorderPoint\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"reorder_point\"},{\"name\":\"unitPrice\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"unit_price\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"InventoryItemToTenant\"},{\"name\":\"ClientProfile\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToInventoryItem\"},{\"name\":\"clientProfileId\",\"kind\":\"scalar\",\"type\":\"String\"}],\"dbName\":\"inventory_items\"},\"PurchaseOrder\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"poNumber\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"po_number\"},{\"name\":\"supplierId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"supplier_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"totalAmount\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"total_amount\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"supplier\",\"kind\":\"object\",\"type\":\"Supplier\",\"relationName\":\"PurchaseOrderToSupplier\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"PurchaseOrderToTenant\"},{\"name\":\"ClientProfile\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToPurchaseOrder\"},{\"name\":\"clientProfileId\",\"kind\":\"scalar\",\"type\":\"String\"}],\"dbName\":\"purchase_orders\"},\"TelehealthSession\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"patientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"patient_id\"},{\"name\":\"providerId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"provider_id\"},{\"name\":\"startTime\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"start_time\"},{\"name\":\"endTime\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"end_time\"},{\"name\":\"meetingLink\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"meeting_link\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TelehealthSessionToTenant\"},{\"name\":\"patient\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToTelehealthSession\"},{\"name\":\"provider\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"TelehealthSessionToUser\"}],\"dbName\":\"telehealth_sessions\"},\"VitalSign\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"patientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"patient_id\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"value\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"unit\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"source\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"recordedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"recorded_at\"},{\"name\":\"patient\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToVitalSign\"}],\"dbName\":\"vital_signs\"},\"PatientAlert\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"patientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"patient_id\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"severity\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"message\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"PatientAlertToTenant\"},{\"name\":\"patient\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToPatientAlert\"}],\"dbName\":\"patient_alerts\"},\"InsuranceProvider\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"networkId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"network_id\"},{\"name\":\"contactPhone\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"contact_phone\"},{\"name\":\"claimsEmail\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"claims_email\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"InsuranceProviderToTenant\"},{\"name\":\"claims\",\"kind\":\"object\",\"type\":\"Claim\",\"relationName\":\"ClaimToInsuranceProvider\"}],\"dbName\":\"insurance_providers\"},\"Claim\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"patientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"patient_id\"},{\"name\":\"providerId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"provider_id\"},{\"name\":\"serviceDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"service_date\"},{\"name\":\"amount\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"denialReason\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"denial_reason\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ClaimToTenant\"},{\"name\":\"patient\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClaimToClientProfile\"},{\"name\":\"provider\",\"kind\":\"object\",\"type\":\"InsuranceProvider\",\"relationName\":\"ClaimToInsuranceProvider\"}],\"dbName\":\"claims\"},\"BillingCode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"code\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"defaultRate\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"default_rate\"}],\"dbName\":\"billing_codes\"},\"Medication\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"genericName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"generic_name\"},{\"name\":\"dosageForm\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"dosage_form\"},{\"name\":\"strength\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"instructions\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"prescriptions\",\"kind\":\"object\",\"type\":\"Prescription\",\"relationName\":\"MedicationToPrescription\"}],\"dbName\":\"medications\"},\"Prescription\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"patientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"patient_id\"},{\"name\":\"medicationId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"medication_id\"},{\"name\":\"prescriberId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"prescriber_id\"},{\"name\":\"dosage\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"frequency\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"route\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"startDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"start_date\"},{\"name\":\"endDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"end_date\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"PrescriptionToTenant\"},{\"name\":\"patient\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToPrescription\"},{\"name\":\"medication\",\"kind\":\"object\",\"type\":\"Medication\",\"relationName\":\"MedicationToPrescription\"},{\"name\":\"marEntries\",\"kind\":\"object\",\"type\":\"MAR_Entry\",\"relationName\":\"MAR_EntryToPrescription\"}],\"dbName\":\"prescriptions\"},\"MAR_Entry\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"patientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"patient_id\"},{\"name\":\"prescriptionId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"prescription_id\"},{\"name\":\"administerId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"administer_id\"},{\"name\":\"adminTime\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"admin_time\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"patient\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToMAR_Entry\"},{\"name\":\"prescription\",\"kind\":\"object\",\"type\":\"Prescription\",\"relationName\":\"MAR_EntryToPrescription\"}],\"dbName\":\"mar_entries\"},\"ShiftHandover\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"handoverNotes\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"handover_notes\"},{\"name\":\"safetyConcerns\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"safety_concerns\"},{\"name\":\"suppliesNeeded\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"supplies_needed\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswProfileToShiftHandover\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"ShiftHandoverToVisit\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ShiftHandoverToTenant\"}],\"dbName\":\"shift_handovers\"},\"AvailabilityOverride\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"date\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"startTime\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"start_time\"},{\"name\":\"endTime\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"end_time\"},{\"name\":\"isAvailable\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_available\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"AvailabilityOverrideToPswProfile\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"AvailabilityOverrideToTenant\"}],\"dbName\":\"psw_availability_overrides\"},\"Payout\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"amount\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"currency\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"processedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"processed_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PayoutToPswProfile\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"PayoutToTenant\"}],\"dbName\":\"payouts\"},\"ClinicalAssessment\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"rnId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"rn_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"assessmentData\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"assessment_data\"},{\"name\":\"score\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"recommendations\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToClinicalAssessment\"},{\"name\":\"rn\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"ClinicalAssessmentToUser\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ClinicalAssessmentToTenant\"}],\"dbName\":\"clinical_assessments\"},\"MedicationRecon\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"rnId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"rn_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"reconData\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"recon_data\"},{\"name\":\"discrepancies\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToMedicationRecon\"},{\"name\":\"rn\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"MedicationReconToUser\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"MedicationReconToTenant\"}],\"dbName\":\"medication_reconciliations\"},\"SupervisionLog\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"rnId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"rn_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"competencies\",\"kind\":\"scalar\",\"type\":\"Json\"},{\"name\":\"isSatisfactory\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_satisfactory\"},{\"name\":\"feedback\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswProfileToSupervisionLog\"},{\"name\":\"rn\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"SupervisionLogToUser\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"SupervisionLogToTenant\"}],\"dbName\":\"supervision_logs\"},\"FamilyNotification\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"message\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"isRead\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_read\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToFamilyNotification\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"FamilyNotificationToTenant\"}],\"dbName\":\"family_notifications\"},\"CareFeedback\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"rating\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"comment\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"triageStatus\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"triage_status\"},{\"name\":\"resolutionNotes\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"resolution_notes\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"CareFeedbackToClientProfile\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"CareFeedbackToVisit\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"CareFeedbackToTenant\"}],\"dbName\":\"care_feedbacks\"},\"TechnicalAudit\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"audit_type\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"summary\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"issuesCount\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"issues_count\"},{\"name\":\"details\",\"kind\":\"scalar\",\"type\":\"Json\"},{\"name\":\"performedById\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"performed_by_id\"},{\"name\":\"performedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"performed_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"performedBy\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"PerformedAudits\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TechnicalAuditToTenant\"}],\"dbName\":\"technical_audits\"},\"RegistryEntry\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"externalId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"external_id\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"label\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"role\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"module\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"action\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"targetPath\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"target_path\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"lastChecked\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_checked\"},{\"name\":\"errorCount\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"error_count\"},{\"name\":\"metadata\",\"kind\":\"scalar\",\"type\":\"Json\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"}],\"dbName\":\"registry_entries\"},\"BookingRequest\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"serviceType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_type\"},{\"name\":\"preferredDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"preferred_date\"},{\"name\":\"preferredTime\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"preferred_time\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"BookingRequestToClientProfile\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"BookingRequestToTenant\"}],\"dbName\":\"booking_requests\"},\"DailyAuditSignOff\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"rnId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"rn_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"clinicalComment\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"clinical_comment\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"signedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"signed_at\"},{\"name\":\"rn\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"DailyAuditSignOffToUser\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"DailyAuditSignOffToTenant\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"DailyAuditSignOffToVisit\"}],\"dbName\":\"daily_audit_signoffs\"},\"WellnessPulse\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"note\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"user\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"UserToWellnessPulse\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToWellnessPulse\"}],\"dbName\":\"wellness_pulses\"},\"SystemTouchpoint\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"touchpointId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"touchpoint_id\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"role\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"module\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"label\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"path\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"errorDetail\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"error_detail\"},{\"name\":\"isOverridden\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_overridden\"},{\"name\":\"overrideValue\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"override_value\"},{\"name\":\"lastChecked\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_checked\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"SystemTouchpointToTenant\"}],\"dbName\":\"system_touchpoints\"}},\"enums\":{},\"types\":{}}")
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

