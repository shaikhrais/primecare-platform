
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
  corsAllowedOrigins: 'corsAllowedOrigins',
  corsAllowedMethods: 'corsAllowedMethods',
  corsAllowedHeaders: 'corsAllowedHeaders',
  taxPercentage: 'taxPercentage',
  parentTenantId: 'parentTenantId'
};

exports.Prisma.RegistryScalarFieldEnum = {
  id: 'id',
  key: 'key',
  value: 'value',
  category: 'category',
  section: 'section',
  metadata: 'metadata',
  tenantId: 'tenantId',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
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

exports.Prisma.AuditLogScalarFieldEnum = {
  id: 'id',
  actorUserId: 'actorUserId',
  action: 'action',
  resourceType: 'resourceType',
  resourceId: 'resourceId',
  metadata: 'metadata',
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
  checksum: 'checksum',
  previousChecksum: 'previousChecksum',
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

exports.Prisma.FAQScalarFieldEnum = {
  id: 'id',
  question: 'question',
  answer: 'answer',
  category: 'category',
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

exports.Prisma.ResponseBotAuditScalarFieldEnum = {
  id: 'id',
  type: 'type',
  status: 'status',
  summary: 'summary',
  details: 'details',
  durationMs: 'durationMs',
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

exports.Prisma.PlatformRoleScalarFieldEnum = {
  id: 'id',
  name: 'name',
  description: 'description',
  isCustom: 'isCustom',
  tenantId: 'tenantId',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.RoleScreenAccessScalarFieldEnum = {
  id: 'id',
  roleId: 'roleId',
  screenRoute: 'screenRoute',
  canRead: 'canRead',
  canWrite: 'canWrite'
};

exports.Prisma.CrisisProtocolScalarFieldEnum = {
  id: 'id',
  scenarioName: 'scenarioName',
  triggerEvent: 'triggerEvent',
  severity: 'severity',
  isActive: 'isActive',
  tenantId: 'tenantId',
  createdAt: 'createdAt'
};

exports.Prisma.ProtocolResolutionScalarFieldEnum = {
  id: 'id',
  protocolId: 'protocolId',
  actionType: 'actionType',
  escalateToRoleId: 'escalateToRoleId',
  uiOverrideKey: 'uiOverrideKey',
  orderIndex: 'orderIndex'
};

exports.Prisma.EcosystemStateOverrideScalarFieldEnum = {
  id: 'id',
  globalStateMacro: 'globalStateMacro',
  isActive: 'isActive',
  payMultiplier: 'payMultiplier',
  forceOfflineMode: 'forceOfflineMode',
  filterTriageOnly: 'filterTriageOnly',
  activatedAt: 'activatedAt',
  activatedByUserId: 'activatedByUserId'
};

exports.Prisma.UserReputationScalarFieldEnum = {
  id: 'id',
  userId: 'userId',
  points: 'points',
  eliteStatus: 'eliteStatus',
  permanentMultiplier: 'permanentMultiplier',
  crisesResolved: 'crisesResolved',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.EcosystemAutopilotConfigScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  isActive: 'isActive',
  maxDailySurgeBudget: 'maxDailySurgeBudget',
  currentDailySurgeSpend: 'currentDailySurgeSpend',
  marginFreezeThreshold: 'marginFreezeThreshold',
  lastCronRun: 'lastCronRun',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.HospitalTargetScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  hospitalName: 'hospitalName',
  dischargePlanner: 'dischargePlanner',
  status: 'status',
  lastTouchpointAt: 'lastTouchpointAt',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.ReferralPipelineScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  hospitalId: 'hospitalId',
  patientName: 'patientName',
  referralValue: 'referralValue',
  isConverted: 'isConverted',
  createdAt: 'createdAt'
};

exports.Prisma.SupplyForecastMetricsScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  targetDate: 'targetDate',
  geographyZone: 'geographyZone',
  predictedDemand: 'predictedDemand',
  physicalSupply: 'physicalSupply',
  deficitWarning: 'deficitWarning',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
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
  trustScore: 'trustScore',
  hasCompletedInduction: 'hasCompletedInduction',
  isLockedForRetraining: 'isLockedForRetraining',
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
  recurrenceRuleString: 'recurrenceRuleString',
  recurrenceEndDate: 'recurrenceEndDate',
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
  managementNotes: 'managementNotes',
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
  checklist: 'checklist',
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
  severity: 'severity',
  reportedAt: 'reportedAt',
  acknowledgedAt: 'acknowledgedAt',
  acknowledgedBy: 'acknowledgedBy'
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

exports.Prisma.ShiftAssignmentScalarFieldEnum = {
  id: 'id',
  visitId: 'visitId',
  pswId: 'pswId',
  status: 'status',
  score: 'score',
  assignedAt: 'assignedAt',
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

exports.Prisma.StaffTaskScalarFieldEnum = {
  id: 'id',
  title: 'title',
  description: 'description',
  status: 'status',
  priority: 'priority',
  dueDate: 'dueDate',
  assigneeId: 'assigneeId',
  groupId: 'groupId',
  tenantId: 'tenantId',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.StaffGroupScalarFieldEnum = {
  id: 'id',
  name: 'name',
  description: 'description',
  tenantId: 'tenantId',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.StaffGroupMemberScalarFieldEnum = {
  id: 'id',
  groupId: 'groupId',
  userId: 'userId',
  role: 'role',
  createdAt: 'createdAt'
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

exports.Prisma.ClinicalRecordScalarFieldEnum = {
  id: 'id',
  clientId: 'clientId',
  type: 'type',
  data: 'data',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  tenantId: 'tenantId'
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
  clientId: 'clientId',
  prescriptionId: 'prescriptionId',
  administerId: 'administerId',
  administeredById: 'administeredById',
  adminTime: 'adminTime',
  scheduledTime: 'scheduledTime',
  administeredAt: 'administeredAt',
  status: 'status',
  notes: 'notes',
  medicationName: 'medicationName',
  dosage: 'dosage',
  route: 'route',
  tenantId: 'tenantId'
};

exports.Prisma.EVVRecordScalarFieldEnum = {
  id: 'id',
  visitId: 'visitId',
  pswId: 'pswId',
  checkType: 'checkType',
  lat: 'lat',
  lng: 'lng',
  accuracy: 'accuracy',
  verificationMethod: 'verificationMethod',
  status: 'status',
  overrideById: 'overrideById',
  overrideReason: 'overrideReason',
  rawData: 'rawData',
  capturedAt: 'capturedAt',
  tenantId: 'tenantId'
};

exports.Prisma.ServiceAuthorizationScalarFieldEnum = {
  id: 'id',
  clientId: 'clientId',
  serviceId: 'serviceId',
  fundingSource: 'fundingSource',
  authorizedHours: 'authorizedHours',
  usedHours: 'usedHours',
  startDate: 'startDate',
  endDate: 'endDate',
  status: 'status',
  authCode: 'authCode',
  notes: 'notes',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  tenantId: 'tenantId'
};

exports.Prisma.ConsentFormScalarFieldEnum = {
  id: 'id',
  clientId: 'clientId',
  formType: 'formType',
  status: 'status',
  signatureDataUrl: 'signatureDataUrl',
  signedAt: 'signedAt',
  expiresAt: 'expiresAt',
  documentKey: 'documentKey',
  witnessName: 'witnessName',
  templateVersion: 'templateVersion',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  tenantId: 'tenantId'
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
  pswId: 'pswId',
  tenantId: 'tenantId',
  status: 'status',
  score: 'score',
  note: 'note',
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

exports.Prisma.PayoutScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  tenantId: 'tenantId',
  amount: 'amount',
  currency: 'currency',
  status: 'status',
  notes: 'notes',
  processedAt: 'processedAt',
  createdAt: 'createdAt'
};

exports.Prisma.MileageLogScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  date: 'date',
  fromVisitId: 'fromVisitId',
  toVisitId: 'toVisitId',
  fromAddress: 'fromAddress',
  toAddress: 'toAddress',
  distanceKm: 'distanceKm',
  travelMinutes: 'travelMinutes',
  reimbursementRate: 'reimbursementRate',
  reimbursementAmount: 'reimbursementAmount',
  status: 'status',
  createdAt: 'createdAt',
  tenantId: 'tenantId'
};

exports.Prisma.ChartOfAccountScalarFieldEnum = {
  id: 'id',
  code: 'code',
  name: 'name',
  type: 'type',
  status: 'status',
  tenantId: 'tenantId',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.FinancialTransactionScalarFieldEnum = {
  id: 'id',
  type: 'type',
  referenceId: 'referenceId',
  amount: 'amount',
  currency: 'currency',
  status: 'status',
  tenantId: 'tenantId',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.JournalEntryScalarFieldEnum = {
  id: 'id',
  transactionId: 'transactionId',
  accountId: 'accountId',
  debit: 'debit',
  paidOutAmount: 'paidOutAmount',
  currency: 'currency',
  balanceBefore: 'balanceBefore',
  balanceAfter: 'balanceAfter',
  tenantId: 'tenantId',
  createdAt: 'createdAt'
};

exports.Prisma.FinancialReconciliationScalarFieldEnum = {
  id: 'id',
  transactionId: 'transactionId',
  bankTransactionId: 'bankTransactionId',
  status: 'status',
  matchedAt: 'matchedAt',
  tenantId: 'tenantId'
};

exports.Prisma.BankTransactionScalarFieldEnum = {
  id: 'id',
  bankDate: 'bankDate',
  description: 'description',
  amount: 'amount',
  currency: 'currency',
  externalRef: 'externalRef',
  status: 'status',
  tenantId: 'tenantId',
  createdAt: 'createdAt'
};

exports.Prisma.TransactionLedgerScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  transactionType: 'transactionType',
  referenceType: 'referenceType',
  referenceId: 'referenceId',
  debitAccount: 'debitAccount',
  creditAccount: 'creditAccount',
  amount: 'amount',
  currency: 'currency',
  description: 'description',
  actorUserId: 'actorUserId',
  ipAddress: 'ipAddress',
  checksum: 'checksum',
  previousChecksum: 'previousChecksum',
  status: 'status',
  voidedByEntryId: 'voidedByEntryId',
  createdAt: 'createdAt'
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
  assignedAt: 'assignedAt',
  dueDate: 'dueDate'
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

exports.Prisma.MarketplaceListingScalarFieldEnum = {
  id: 'id',
  title: 'title',
  description: 'description',
  total: 'total',
  category: 'category',
  providerId: 'providerId',
  tenantId: 'tenantId',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
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

exports.Prisma.ReferralScalarFieldEnum = {
  id: 'id',
  clientName: 'clientName',
  clientPhone: 'clientPhone',
  clientEmail: 'clientEmail',
  referrerName: 'referrerName',
  referrerOrg: 'referrerOrg',
  referrerType: 'referrerType',
  serviceNeeded: 'serviceNeeded',
  urgency: 'urgency',
  clinicalNotes: 'clinicalNotes',
  status: 'status',
  convertedClientId: 'convertedClientId',
  convertedAt: 'convertedAt',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  tenantId: 'tenantId'
};

exports.Prisma.FamilyMemberScalarFieldEnum = {
  id: 'id',
  clientId: 'clientId',
  name: 'name',
  email: 'email',
  phone: 'phone',
  relationship: 'relationship',
  accessLevel: 'accessLevel',
  linkedUserId: 'linkedUserId',
  isEmergency: 'isEmergency',
  notifyVisits: 'notifyVisits',
  notifyCare: 'notifyCare',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  tenantId: 'tenantId'
};

exports.Prisma.PerformanceReviewScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  reviewerId: 'reviewerId',
  periodStart: 'periodStart',
  periodEnd: 'periodEnd',
  overallRating: 'overallRating',
  kpis: 'kpis',
  goals: 'goals',
  strengths: 'strengths',
  improvements: 'improvements',
  notes: 'notes',
  status: 'status',
  acknowledgedAt: 'acknowledgedAt',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  tenantId: 'tenantId'
};

exports.Prisma.WebhookEndpointScalarFieldEnum = {
  id: 'id',
  url: 'url',
  events: 'events',
  secret: 'secret',
  status: 'status',
  lastDeliveredAt: 'lastDeliveredAt',
  failureCount: 'failureCount',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  tenantId: 'tenantId'
};

exports.Prisma.WebhookDeliveryScalarFieldEnum = {
  id: 'id',
  endpointId: 'endpointId',
  event: 'event',
  payload: 'payload',
  statusCode: 'statusCode',
  responseBody: 'responseBody',
  retryCount: 'retryCount',
  deliveredAt: 'deliveredAt'
};

exports.Prisma.IoTEventScalarFieldEnum = {
  id: 'id',
  deviceId: 'deviceId',
  deviceType: 'deviceType',
  payload: 'payload',
  status: 'status',
  userId: 'userId',
  tenantId: 'tenantId',
  createdAt: 'createdAt'
};

exports.Prisma.AppNotificationScalarFieldEnum = {
  id: 'id',
  userId: 'userId',
  title: 'title',
  message: 'message',
  type: 'type',
  isRead: 'isRead',
  link: 'link',
  tenantId: 'tenantId',
  createdAt: 'createdAt'
};

exports.Prisma.GamificationProfileScalarFieldEnum = {
  id: 'id',
  userId: 'userId',
  careCoins: 'careCoins',
  currentTier: 'currentTier',
  lifetimePoints: 'lifetimePoints',
  tenantId: 'tenantId',
  updatedAt: 'updatedAt'
};

exports.Prisma.AIInferenceScalarFieldEnum = {
  id: 'id',
  modelName: 'modelName',
  targetId: 'targetId',
  targetType: 'targetType',
  confidenceScore: 'confidenceScore',
  predictionData: 'predictionData',
  tenantId: 'tenantId',
  createdAt: 'createdAt'
};

exports.Prisma.CommunicationLogScalarFieldEnum = {
  id: 'id',
  direction: 'direction',
  channel: 'channel',
  recipient: 'recipient',
  sender: 'sender',
  subject: 'subject',
  bodyText: 'bodyText',
  status: 'status',
  externalId: 'externalId',
  tenantId: 'tenantId',
  createdAt: 'createdAt'
};

exports.Prisma.DailyActivityScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  userId: 'userId',
  role: 'role',
  title: 'title',
  description: 'description',
  status: 'status',
  dueDate: 'dueDate',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.PlatformScreenScalarFieldEnum = {
  id: 'id',
  roleId: 'roleId',
  name: 'name',
  route: 'route',
  status: 'status',
  description: 'description',
  orderIndex: 'orderIndex',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.ScreenFunctionalityScalarFieldEnum = {
  id: 'id',
  screenId: 'screenId',
  title: 'title',
  isCore: 'isCore',
  status: 'status',
  apiEndpoint: 'apiEndpoint',
  dataEntryFields: 'dataEntryFields',
  justification: 'justification',
  notes: 'notes',
  orderIndex: 'orderIndex',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.PswShiftLogScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  clientId: 'clientId',
  tenantId: 'tenantId',
  date: 'date',
  startTime: 'startTime',
  endTime: 'endTime',
  gpsLat: 'gpsLat',
  gpsLng: 'gpsLng',
  shiftStatus: 'shiftStatus',
  signatureUrl: 'signatureUrl'
};

exports.Prisma.AdlCareLogScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  clientId: 'clientId',
  tenantId: 'tenantId',
  hygiene: 'hygiene',
  dressing: 'dressing',
  toileting: 'toileting',
  mobility: 'mobility',
  feeding: 'feeding',
  fluidIntake: 'fluidIntake',
  sleepStatus: 'sleepStatus',
  notes: 'notes',
  createdAt: 'createdAt'
};

exports.Prisma.PswVitalSignScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  clientId: 'clientId',
  tenantId: 'tenantId',
  temperature: 'temperature',
  pulse: 'pulse',
  respiration: 'respiration',
  bloodPressure: 'bloodPressure',
  spO2: 'spO2',
  painLevel: 'painLevel',
  recordedAt: 'recordedAt'
};

exports.Prisma.BehaviorNoteScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  clientId: 'clientId',
  tenantId: 'tenantId',
  mood: 'mood',
  orientation: 'orientation',
  behaviorChanges: 'behaviorChanges',
  communication: 'communication',
  recordedAt: 'recordedAt'
};

exports.Prisma.NutritionRecordScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  clientId: 'clientId',
  tenantId: 'tenantId',
  mealsTakenPct: 'mealsTakenPct',
  snacks: 'snacks',
  fluidIntakeMl: 'fluidIntakeMl',
  appetiteLevel: 'appetiteLevel',
  recordedAt: 'recordedAt'
};

exports.Prisma.MobilityLogScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  clientId: 'clientId',
  tenantId: 'tenantId',
  movementType: 'movementType',
  distanceOrDur: 'distanceOrDur',
  assistanceLevel: 'assistanceLevel',
  painDuring: 'painDuring',
  recordedAt: 'recordedAt'
};

exports.Prisma.InfectionControlChecklistScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  clientId: 'clientId',
  tenantId: 'tenantId',
  handHygieneDone: 'handHygieneDone',
  ppeUsed: 'ppeUsed',
  equipmentCleaned: 'equipmentCleaned',
  wasteDisposed: 'wasteDisposed',
  recordedAt: 'recordedAt'
};

exports.Prisma.NarrativeProgressNoteScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  clientId: 'clientId',
  tenantId: 'tenantId',
  whatWasDone: 'whatWasDone',
  clientResponse: 'clientResponse',
  changesObserved: 'changesObserved',
  planForNext: 'planForNext',
  recordedAt: 'recordedAt'
};

exports.Prisma.CarePlanFollowUpScalarFieldEnum = {
  id: 'id',
  pswId: 'pswId',
  clientId: 'clientId',
  tenantId: 'tenantId',
  tasksAssigned: 'tasksAssigned',
  tasksCompleted: 'tasksCompleted',
  notCompleted: 'notCompleted',
  reasonNotDone: 'reasonNotDone',
  recordedAt: 'recordedAt'
};

exports.Prisma.ClinicScalarFieldEnum = {
  id: 'id',
  name: 'name',
  location: 'location',
  patientVolume: 'patientVolume',
  efficiencyScore: 'efficiencyScore',
  revenue: 'revenue',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.PatientScalarFieldEnum = {
  id: 'id',
  firstName: 'firstName',
  lastName: 'lastName',
  age: 'age',
  gender: 'gender',
  status: 'status',
  avatarUrl: 'avatarUrl',
  clinicId: 'clinicId',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.FinancialRecordScalarFieldEnum = {
  id: 'id',
  month: 'month',
  revenue: 'revenue',
  expenses: 'expenses',
  clinicId: 'clinicId',
  createdAt: 'createdAt'
};

exports.Prisma.FamilyAppointmentScalarFieldEnum = {
  id: 'id',
  title: 'title',
  patientName: 'patientName',
  doctorName: 'doctorName',
  date: 'date',
  time: 'time',
  location: 'location',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.FamilyCarePlanTaskScalarFieldEnum = {
  id: 'id',
  patientName: 'patientName',
  taskName: 'taskName',
  category: 'category',
  timeSlot: 'timeSlot',
  isCompleted: 'isCompleted',
  completedBy: 'completedBy',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.FamilyClinicalMessageScalarFieldEnum = {
  id: 'id',
  threadId: 'threadId',
  senderName: 'senderName',
  senderRole: 'senderRole',
  content: 'content',
  timestamp: 'timestamp',
  isRead: 'isRead'
};

exports.Prisma.PatientIntakeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  patientName: 'patientName',
  status: 'status',
  priority: 'priority',
  franchiseCity: 'franchiseCity',
  coordinatorId: 'coordinatorId',
  scheduledDate: 'scheduledDate',
  scheduledTime: 'scheduledTime',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.IntakeReferralMetricScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  sourceName: 'sourceName',
  conversionCount: 'conversionCount',
  totalLeads: 'totalLeads',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.JobOpeningScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  title: 'title',
  department: 'department',
  location: 'location',
  status: 'status',
  applicationCount: 'applicationCount',
  postedDate: 'postedDate',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.JobCandidateScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  candidateName: 'candidateName',
  appliedRole: 'appliedRole',
  department: 'department',
  source: 'source',
  status: 'status',
  rating: 'rating',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.InterviewEventScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  candidateName: 'candidateName',
  roleTarget: 'roleTarget',
  managerName: 'managerName',
  scheduledDate: 'scheduledDate',
  scheduledTime: 'scheduledTime',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.InvoiceRecordScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  invoiceId: 'invoiceId',
  patientName: 'patientName',
  clinicLocation: 'clinicLocation',
  amount: 'amount',
  status: 'status',
  issueDate: 'issueDate',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.InsuranceClaimScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  claimCode: 'claimCode',
  patientName: 'patientName',
  provider: 'provider',
  status: 'status',
  denialReason: 'denialReason',
  amount: 'amount',
  submissionDate: 'submissionDate',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.FinancialGoalScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  month: 'month',
  year: 'year',
  label: 'label',
  targetRevenue: 'targetRevenue',
  actualRevenue: 'actualRevenue',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.FacilityNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  facilityName: 'facilityName',
  location: 'location',
  managerName: 'managerName',
  status: 'status',
  satisfaction: 'satisfaction',
  dailyVisits: 'dailyVisits',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.StaffUtilizationScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  staffName: 'staffName',
  role: 'role',
  totalHours: 'totalHours',
  clinicalHours: 'clinicalHours',
  adminHours: 'adminHours',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.OpsIssueTicketScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  title: 'title',
  description: 'description',
  facilityName: 'facilityName',
  severity: 'severity',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.IncidentReportNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  incidentType: 'incidentType',
  severity: 'severity',
  franchise: 'franchise',
  description: 'description',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.AuditLogNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  franchise: 'franchise',
  auditDate: 'auditDate',
  auditorName: 'auditorName',
  score: 'score',
  compliancePct: 'compliancePct',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.PatientSatisfactionNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  franchise: 'franchise',
  score: 'score',
  comments: 'comments',
  type: 'type',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.SalesDealNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  dealName: 'dealName',
  facilityTarget: 'facilityTarget',
  amount: 'amount',
  stage: 'stage',
  repName: 'repName',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.KeyAccountNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  accountName: 'accountName',
  contactName: 'contactName',
  stage: 'stage',
  potentialValue: 'potentialValue',
  probability: 'probability',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.RepPerformanceNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  repName: 'repName',
  quota: 'quota',
  attainment: 'attainment',
  meetings: 'meetings',
  pipelineValue: 'pipelineValue',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.MarketingCampaignNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  campaignName: 'campaignName',
  platform: 'platform',
  spend: 'spend',
  revenue: 'revenue',
  leads: 'leads',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.LocalGrowthNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  regionName: 'regionName',
  patientAcqCost: 'patientAcqCost',
  newPatients: 'newPatients',
  totalRevenue: 'totalRevenue',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.ContentAssetNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  assetName: 'assetName',
  assetType: 'assetType',
  author: 'author',
  status: 'status',
  thumbnailUrl: 'thumbnailUrl',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.PatientAdmissionNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  patientName: 'patientName',
  priority: 'priority',
  condition: 'condition',
  location: 'location',
  attendingPhys: 'attendingPhys',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.ClinicalShiftNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  providerName: 'providerName',
  role: 'role',
  startTime: 'startTime',
  endTime: 'endTime',
  facility: 'facility',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.MedicalAuditNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  regionCode: 'regionCode',
  survivalRate: 'survivalRate',
  readmissionRate: 'readmissionRate',
  averageWaitTime: 'averageWaitTime',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.SupportTicketNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  franchiseName: 'franchiseName',
  patientRef: 'patientRef',
  issueType: 'issueType',
  status: 'status',
  assignedTo: 'assignedTo',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.PatientFeedbackNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  patientName: 'patientName',
  franchiseName: 'franchiseName',
  rating: 'rating',
  comments: 'comments',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.SystemTelemetryNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  serviceName: 'serviceName',
  uptimePercent: 'uptimePercent',
  latencyMs: 'latencyMs',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.CurriculumNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  programName: 'programName',
  department: 'department',
  status: 'status',
  completionPct: 'completionPct',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.InstructorNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  facilitatorName: 'facilitatorName',
  assignedCourse: 'assignedCourse',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.CertificationNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  staffName: 'staffName',
  clinicalRole: 'clinicalRole',
  certName: 'certName',
  expiresAt: 'expiresAt',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.FranchiseRevenueNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  monthYear: 'monthYear',
  revenueAmt: 'revenueAmt',
  patientVisits: 'patientVisits',
  growthPct: 'growthPct',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.ClinicPerformanceNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  locationName: 'locationName',
  managerName: 'managerName',
  revenue: 'revenue',
  visits: 'visits',
  growth: 'growth',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.FranchiseBookingNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  patientName: 'patientName',
  clinicAssigned: 'clinicAssigned',
  appointmentType: 'appointmentType',
  scheduledTime: 'scheduledTime',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.OutreachEventNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  eventName: 'eventName',
  location: 'location',
  scheduledDate: 'scheduledDate',
  status: 'status',
  participantGoal: 'participantGoal',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.ParticipantMetricNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  metricDate: 'metricDate',
  totalReached: 'totalReached',
  engagementScore: 'engagementScore',
  healthScreened: 'healthScreened',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.OutreachBudgetNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  projectName: 'projectName',
  allocatedFunds: 'allocatedFunds',
  fundsUsed: 'fundsUsed',
  sponsor: 'sponsor',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.LocalNetworkNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  locationName: 'locationName',
  occupancyRate: 'occupancyRate',
  serverLoadScore: 'serverLoadScore',
  staffActive: 'staffActive',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.LocalFinanceNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  monthLabel: 'monthLabel',
  grossRevenue: 'grossRevenue',
  netMargin: 'netMargin',
  growthYoY: 'growthYoY',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.LocalActivityNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  eventTitle: 'eventTitle',
  eventType: 'eventType',
  eventTime: 'eventTime',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.LocalMarketingAnalyticNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  metricType: 'metricType',
  value: 'value',
  growthYoY: 'growthYoY',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.LocalCampaignNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  campaignName: 'campaignName',
  managerName: 'managerName',
  roiFactor: 'roiFactor',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.LocalContentNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  assetTitle: 'assetTitle',
  assetType: 'assetType',
  deployedDate: 'deployedDate',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.SupportAgentNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  agentName: 'agentName',
  shiftTime: 'shiftTime',
  activeTickets: 'activeTickets',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.TicketVolumeNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  hourlyMark: 'hourlyMark',
  inboundCount: 'inboundCount',
  resolvedCount: 'resolvedCount',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.ResolutionFeedbackNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  patientName: 'patientName',
  csatScore: 'csatScore',
  feedbackText: 'feedbackText',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.ClientTrendNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  monthLabel: 'monthLabel',
  revenueAmount: 'revenueAmount',
  apptCount: 'apptCount',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.ClientClinicNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  clinicName: 'clinicName',
  starRating: 'starRating',
  revenueString: 'revenueString',
  rank: 'rank',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.ClientDemographicNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  cohortGroup: 'cohortGroup',
  percentage: 'percentage',
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


exports.Prisma.ModelName = {
  User: 'User',
  Tenant: 'Tenant',
  Registry: 'Registry',
  ApiKey: 'ApiKey',
  AuditLog: 'AuditLog',
  SystemEvent: 'SystemEvent',
  Lead: 'Lead',
  FAQ: 'FAQ',
  UserDevice: 'UserDevice',
  SystemPolicy: 'SystemPolicy',
  ResponseBotAudit: 'ResponseBotAudit',
  SystemTouchpoint: 'SystemTouchpoint',
  RegistryEntry: 'RegistryEntry',
  MessageThread: 'MessageThread',
  Message: 'Message',
  PlatformRole: 'PlatformRole',
  RoleScreenAccess: 'RoleScreenAccess',
  CrisisProtocol: 'CrisisProtocol',
  ProtocolResolution: 'ProtocolResolution',
  EcosystemStateOverride: 'EcosystemStateOverride',
  UserReputation: 'UserReputation',
  EcosystemAutopilotConfig: 'EcosystemAutopilotConfig',
  HospitalTarget: 'HospitalTarget',
  ReferralPipeline: 'ReferralPipeline',
  SupplyForecastMetrics: 'SupplyForecastMetrics',
  ClientProfile: 'ClientProfile',
  PswProfile: 'PswProfile',
  Visit: 'Visit',
  Service: 'Service',
  VisitCheckEvent: 'VisitCheckEvent',
  VisitNote: 'VisitNote',
  VisitChecklist: 'VisitChecklist',
  Incident: 'Incident',
  DailyEntry: 'DailyEntry',
  Booking: 'Booking',
  PswAvailability: 'PswAvailability',
  PswDocument: 'PswDocument',
  ShiftAssignment: 'ShiftAssignment',
  Timesheet: 'Timesheet',
  TimesheetItem: 'TimesheetItem',
  ShiftHandover: 'ShiftHandover',
  AvailabilityOverride: 'AvailabilityOverride',
  VisitMatch: 'VisitMatch',
  WaitlistEntry: 'WaitlistEntry',
  StaffTask: 'StaffTask',
  StaffGroup: 'StaffGroup',
  StaffGroupMember: 'StaffGroupMember',
  BookingRequest: 'BookingRequest',
  FleetStatus: 'FleetStatus',
  CarePlan: 'CarePlan',
  ClinicalRecord: 'ClinicalRecord',
  ClinicalAssessment: 'ClinicalAssessment',
  MedicationRecon: 'MedicationRecon',
  SupervisionLog: 'SupervisionLog',
  HealthID: 'HealthID',
  FhirSyncLog: 'FhirSyncLog',
  VitalSign: 'VitalSign',
  PatientAlert: 'PatientAlert',
  Medication: 'Medication',
  Prescription: 'Prescription',
  MAR_Entry: 'MAR_Entry',
  EVVRecord: 'EVVRecord',
  ServiceAuthorization: 'ServiceAuthorization',
  ConsentForm: 'ConsentForm',
  DailyAuditSignOff: 'DailyAuditSignOff',
  WellnessPulse: 'WellnessPulse',
  Invoice: 'Invoice',
  Payment: 'Payment',
  InsuranceProvider: 'InsuranceProvider',
  Claim: 'Claim',
  BillingCode: 'BillingCode',
  Payout: 'Payout',
  MileageLog: 'MileageLog',
  ChartOfAccount: 'ChartOfAccount',
  FinancialTransaction: 'FinancialTransaction',
  JournalEntry: 'JournalEntry',
  FinancialReconciliation: 'FinancialReconciliation',
  BankTransaction: 'BankTransaction',
  TransactionLedger: 'TransactionLedger',
  BlogPost: 'BlogPost',
  Feedback: 'Feedback',
  TrainingModule: 'TrainingModule',
  TrainingAssignment: 'TrainingAssignment',
  Survey: 'Survey',
  SurveyResponse: 'SurveyResponse',
  Region: 'Region',
  BranchCapacity: 'BranchCapacity',
  BranchStat: 'BranchStat',
  ComplianceRecord: 'ComplianceRecord',
  Franchise: 'Franchise',
  ResellerAgreement: 'ResellerAgreement',
  Supplier: 'Supplier',
  InventoryItem: 'InventoryItem',
  PurchaseOrder: 'PurchaseOrder',
  TelehealthSession: 'TelehealthSession',
  MarketplaceListing: 'MarketplaceListing',
  TenantSLA: 'TenantSLA',
  AIRecommendation: 'AIRecommendation',
  SentimentAnalysis: 'SentimentAnalysis',
  SecurityThreat: 'SecurityThreat',
  TechnicalAudit: 'TechnicalAudit',
  FamilyNotification: 'FamilyNotification',
  CareFeedback: 'CareFeedback',
  Referral: 'Referral',
  FamilyMember: 'FamilyMember',
  PerformanceReview: 'PerformanceReview',
  WebhookEndpoint: 'WebhookEndpoint',
  WebhookDelivery: 'WebhookDelivery',
  IoTEvent: 'IoTEvent',
  AppNotification: 'AppNotification',
  GamificationProfile: 'GamificationProfile',
  AIInference: 'AIInference',
  CommunicationLog: 'CommunicationLog',
  DailyActivity: 'DailyActivity',
  PlatformScreen: 'PlatformScreen',
  ScreenFunctionality: 'ScreenFunctionality',
  PswShiftLog: 'PswShiftLog',
  AdlCareLog: 'AdlCareLog',
  PswVitalSign: 'PswVitalSign',
  BehaviorNote: 'BehaviorNote',
  NutritionRecord: 'NutritionRecord',
  MobilityLog: 'MobilityLog',
  InfectionControlChecklist: 'InfectionControlChecklist',
  NarrativeProgressNote: 'NarrativeProgressNote',
  CarePlanFollowUp: 'CarePlanFollowUp',
  Clinic: 'Clinic',
  Patient: 'Patient',
  FinancialRecord: 'FinancialRecord',
  FamilyAppointment: 'FamilyAppointment',
  FamilyCarePlanTask: 'FamilyCarePlanTask',
  FamilyClinicalMessage: 'FamilyClinicalMessage',
  PatientIntake: 'PatientIntake',
  IntakeReferralMetric: 'IntakeReferralMetric',
  JobOpening: 'JobOpening',
  JobCandidate: 'JobCandidate',
  InterviewEvent: 'InterviewEvent',
  InvoiceRecord: 'InvoiceRecord',
  InsuranceClaim: 'InsuranceClaim',
  FinancialGoal: 'FinancialGoal',
  FacilityNode: 'FacilityNode',
  StaffUtilization: 'StaffUtilization',
  OpsIssueTicket: 'OpsIssueTicket',
  IncidentReportNode: 'IncidentReportNode',
  AuditLogNode: 'AuditLogNode',
  PatientSatisfactionNode: 'PatientSatisfactionNode',
  SalesDealNode: 'SalesDealNode',
  KeyAccountNode: 'KeyAccountNode',
  RepPerformanceNode: 'RepPerformanceNode',
  MarketingCampaignNode: 'MarketingCampaignNode',
  LocalGrowthNode: 'LocalGrowthNode',
  ContentAssetNode: 'ContentAssetNode',
  PatientAdmissionNode: 'PatientAdmissionNode',
  ClinicalShiftNode: 'ClinicalShiftNode',
  MedicalAuditNode: 'MedicalAuditNode',
  SupportTicketNode: 'SupportTicketNode',
  PatientFeedbackNode: 'PatientFeedbackNode',
  SystemTelemetryNode: 'SystemTelemetryNode',
  CurriculumNode: 'CurriculumNode',
  InstructorNode: 'InstructorNode',
  CertificationNode: 'CertificationNode',
  FranchiseRevenueNode: 'FranchiseRevenueNode',
  ClinicPerformanceNode: 'ClinicPerformanceNode',
  FranchiseBookingNode: 'FranchiseBookingNode',
  OutreachEventNode: 'OutreachEventNode',
  ParticipantMetricNode: 'ParticipantMetricNode',
  OutreachBudgetNode: 'OutreachBudgetNode',
  LocalNetworkNode: 'LocalNetworkNode',
  LocalFinanceNode: 'LocalFinanceNode',
  LocalActivityNode: 'LocalActivityNode',
  LocalMarketingAnalyticNode: 'LocalMarketingAnalyticNode',
  LocalCampaignNode: 'LocalCampaignNode',
  LocalContentNode: 'LocalContentNode',
  SupportAgentNode: 'SupportAgentNode',
  TicketVolumeNode: 'TicketVolumeNode',
  ResolutionFeedbackNode: 'ResolutionFeedbackNode',
  ClientTrendNode: 'ClientTrendNode',
  ClientClinicNode: 'ClientClinicNode',
  ClientDemographicNode: 'ClientDemographicNode'
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
      "driverAdapters",
      "prismaSchemaFolder"
    ],
    "sourceFilePath": "C:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform\\apps\\worker-api\\prisma\\schema\\00_base.prisma",
    "isCustomOutput": true
  },
  "relativeEnvPaths": {
    "rootEnvPath": null,
    "schemaEnvPath": "../../.env"
  },
  "relativePath": "../../prisma/schema",
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
  "inlineSchema": "// ==========================================\n// Base Configuration\n// ==========================================\n\ngenerator client {\n  provider        = \"prisma-client-js\"\n  previewFeatures = [\"driverAdapters\", \"prismaSchemaFolder\"]\n  output          = \"../../generated/client\"\n}\n\ndatasource db {\n  provider = \"postgresql\"\n  url      = env(\"DATABASE_URL\")\n}\n\n// ==========================================\n// PLATFORM MODULES (Global Infrastructure)\n// ==========================================\n\nmodel User {\n  id                 String              @id @default(uuid())\n  email              String              @unique\n  phone              String?\n  passwordHash       String?             @map(\"password_hash\")\n  osmId              String?             @unique @map(\"osm_id\")\n  status             String?             @default(\"active\")\n  resetToken         String?\n  resetTokenExpiry   DateTime?\n  lastLoginAt        DateTime?           @map(\"last_login_at\")\n  createdAt          DateTime            @default(now()) @map(\"created_at\")\n  updatedAt          DateTime            @updatedAt @map(\"updated_at\")\n  tenantId           String              @map(\"tenant_id\")\n  roles              String              @default(\"client\")\n  auditLogs          AuditLog[]\n  blogPosts          BlogPost[]\n  clientProfile      ClientProfile?\n  DailyEntry         DailyEntry[]\n  reportedIncidents  Incident[]          @relation(\"Reporter\")\n  sentMessages       Message[]\n  verifiedDocs       PswDocument[]       @relation(\"VerifiedBy\")\n  pswProfile         PswProfile?\n  reviewedTimesheets Timesheet[]         @relation(\"ReviewedBy\")\n  telehealthSessions TelehealthSession[]\n  tenant             Tenant              @relation(fields: [tenantId], references: [id])\n  VisitCheckEvent    VisitCheckEvent[]\n  StaffGroupMember   StaffGroupMember[]\n  assignedTasks      StaffTask[]         @relation(\"AssignedTasks\")\n\n  // RN Mastery Extensions\n  carePlansAuthored          CarePlan[]                  @relation(\"CarePlanAuthor\")\n  ledgerEntries              TransactionLedger[]         @relation(\"LedgerActor\")\n  assessments                ClinicalAssessment[]\n  medicationRecons           MedicationRecon[]\n  supervisionLogs            SupervisionLog[]\n  acknowledgedIncidents      Incident[]                  @relation(\"Acknowledger\")\n  performedAudits            TechnicalAudit[]            @relation(\"PerformedAudits\")\n  dailyAuditSignOffs         DailyAuditSignOff[]\n  wellnessPulses             WellnessPulse[]\n  devices                    UserDevice[]\n  systemEvents               SystemEvent[]\n  performanceReviewsAuthored PerformanceReview[]         @relation(\"ReviewAuthor\")\n  iotEvents                  IoTEvent[]\n  appNotifications           AppNotification[]\n  gamificationProfile        GamificationProfile?\n  reputation                 UserReputation?\n  DailyActivity              DailyActivity[]\n  shiftCheckIns              PswShiftLog[]               @relation(\"UserShiftLogs\")\n  adlCareLogs                AdlCareLog[]                @relation(\"UserAdlLogs\")\n  pswVitals                  PswVitalSign[]              @relation(\"UserPswVitals\")\n  behaviorNotes              BehaviorNote[]              @relation(\"UserBehaviorNotes\")\n  nutritionRecords           NutritionRecord[]           @relation(\"UserNutrition\")\n  mobilityLogs               MobilityLog[]               @relation(\"UserMobility\")\n  infectionLogs              InfectionControlChecklist[] @relation(\"UserInfectionControl\")\n  narrativeNotes             NarrativeProgressNote[]     @relation(\"UserNarrativeNotes\")\n  carePlanFollowUps          CarePlanFollowUp[]          @relation(\"UserCarePlanFollowUp\")\n\n  @@index([tenantId])\n  @@map(\"users\")\n}\n\nmodel Tenant {\n  id                   String                @id @default(uuid())\n  name                 String\n  slug                 String                @unique\n  status               String                @default(\"active\")\n  createdAt            DateTime              @default(now()) @map(\"created_at\")\n  updatedAt            DateTime              @updatedAt @map(\"updated_at\")\n  auditLogs            AuditLog[]\n  bookings             Booking[]\n  clientProfiles       ClientProfile[]\n  dailyEntries         DailyEntry[]\n  incidents            Incident[]\n  invoices             Invoice[]\n  messageThreads       MessageThread[]\n  pswAvailability      PswAvailability[]\n  pswProfiles          PswProfile[]\n  services             Service[]\n  shiftAssignments     ShiftAssignment[]\n  timesheets           Timesheet[]\n  staffTasks           StaffTask[]\n  leads                Lead[]\n  users                User[]\n  checkEvents          VisitCheckEvent[]\n  visits               Visit[]\n  apiKeys              ApiKey[]\n  feedbacks            Feedback[]\n  carePlans            CarePlan[]\n  trainingModules      TrainingModule[]\n  surveys              Survey[]\n  regions              Region[]\n  clinicalRecords      ClinicalRecord[]\n  fhirSyncLogs         FhirSyncLog[]\n  aiRecommendations    AIRecommendation[]\n  sentimentAnalyses    SentimentAnalysis[]\n  securityThreats      SecurityThreat[]\n  slas                 TenantSLA[]\n  telehealthSessions   TelehealthSession[]\n  patientAlerts        PatientAlert[]\n  insuranceProviders   InsuranceProvider[]\n  visitMatches         VisitMatch[]\n  waitlistEntries      WaitlistEntry[]\n  claims               Claim[]\n  prescriptions        Prescription[]\n  branchStats          BranchStat[]\n  complianceRecords    ComplianceRecord[]\n  familyNotifications  FamilyNotification[]\n  careFeedbacks        CareFeedback[]\n  technicalAudits      TechnicalAudit[]\n  bookingRequests      BookingRequest[]\n  dailyAuditSignOffs   DailyAuditSignOff[]\n  wellnessPulses       WellnessPulse[]\n  systemTouchpoints    SystemTouchpoint[]\n  iotEvents            IoTEvent[]\n  appNotifications     AppNotification[]\n  gamificationProfiles GamificationProfile[]\n  aiInferences         AIInference[]\n  communicationLogs    CommunicationLog[]\n  transactionLedger    TransactionLedger[]\n\n  // Business Model Extensions\n  businessNumber  String? @map(\"business_number\")\n  supportEmail    String? @map(\"support_email\")\n  logoUrl         String? @map(\"logo_url\")\n  taxSettings     Json?   @map(\"tax_settings\")\n  brandingConfig  Json?   @map(\"branding_config\")\n  stripeAccountId String? @map(\"stripe_account_id\")\n  onboardingStep  Int     @default(1) @map(\"onboarding_step\")\n\n  // Security & Sovereignty Extensions\n  allowedVpnRanges      String  @map(\"allowed_vpn_ranges\")\n  enforceVpn            Boolean @default(false) @map(\"enforce_vpn\")\n  requireDeviceApproval Boolean @default(false) @map(\"require_device_approval\")\n  maxDevicesPerUser     Int     @default(5) @map(\"max_devices_per_user\")\n\n  // Runtime CORS Configuration\n  corsAllowedOrigins Json     @map(\"cors_allowed_origins\")\n  corsAllowedMethods Json     @map(\"cors_allowed_methods\")\n  corsAllowedHeaders Json     @map(\"cors_allowed_headers\")\n  taxPercentage      Decimal? @map(\"tax_percentage\")\n\n  // Fractal SaaS Extensions\n  parentTenantId        String?                @map(\"parent_tenant_id\")\n  parentTenant          Tenant?                @relation(\"TenantHierarchy\", fields: [parentTenantId], references: [id])\n  childTenants          Tenant[]               @relation(\"TenantHierarchy\")\n  franchises            Franchise[]            @relation(\"ResellerTenants\")\n  marketplaceListings   MarketplaceListing[]\n  handovers             ShiftHandover[]\n  availabilityOverrides AvailabilityOverride[]\n  payouts               Payout[]\n  clinicalAssessments   ClinicalAssessment[]\n  medicationRecons      MedicationRecon[]\n  supervisionLogs       SupervisionLog[]\n  inventoryItems        InventoryItem[]\n  purchaseOrders        PurchaseOrder[]\n  systemEvents          SystemEvent[]\n\n  // Financial Engine\n  financialAccounts        ChartOfAccount[]\n  financialTransactions    FinancialTransaction[]\n  financialJournalEntries  JournalEntry[]\n  financialReconciliations FinancialReconciliation[]\n  bankTransactions         BankTransaction[]\n\n  // Registry\n  registries Registry[]\n\n  // Domain Feature Extensions\n  evvRecords            EVVRecord[]\n  serviceAuthorizations ServiceAuthorization[]\n  consentForms          ConsentForm[]\n  mileageLogs           MileageLog[]\n  referrals             Referral[]\n  familyMembers         FamilyMember[]\n  performanceReviews    PerformanceReview[]\n  webhookEndpoints      WebhookEndpoint[]\n  staffGroups           StaffGroup[]\n  platformRoles         PlatformRole[]\n  DailyActivity         DailyActivity[]\n  shiftCheckIns         PswShiftLog[]               @relation(\"TenantShiftLogs\")\n  adlCareLogs           AdlCareLog[]                @relation(\"TenantAdlLogs\")\n  pswVitals             PswVitalSign[]              @relation(\"TenantPswVitals\")\n  behaviorNotes         BehaviorNote[]              @relation(\"TenantBehaviorNotes\")\n  nutritionRecords      NutritionRecord[]           @relation(\"TenantNutrition\")\n  mobilityLogs          MobilityLog[]               @relation(\"TenantMobility\")\n  infectionLogs         InfectionControlChecklist[] @relation(\"TenantInfectionControl\")\n  narrativeNotes        NarrativeProgressNote[]     @relation(\"TenantNarrativeNotes\")\n  carePlanFollowUps     CarePlanFollowUp[]          @relation(\"TenantCarePlanFollowUp\")\n\n  @@map(\"tenants\")\n}\n\nmodel Registry {\n  id        String   @id @default(uuid())\n  key       String // dot-path key e.g. \"ADMIN_HOME.TITLE\"\n  value     String // the actual text/content value\n  category  String // content, api, route, theme, button, interaction\n  section   String? // grouping: e.g. \"homes\", \"nav\", \"operations\"\n  metadata  String? // extra config, icon, color, etc.\n  tenantId  String?  @map(\"tenant_id\")\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  updatedAt DateTime @updatedAt @map(\"updated_at\")\n\n  tenant Tenant? @relation(fields: [tenantId], references: [id])\n\n  @@unique([key, tenantId])\n  @@index([category])\n  @@index([section])\n  @@index([tenantId])\n  @@map(\"registries\")\n}\n\nmodel ApiKey {\n  id         String    @id @default(uuid())\n  key        String    @unique\n  name       String\n  status     String    @default(\"active\")\n  tenantId   String    @map(\"tenant_id\")\n  createdAt  DateTime  @default(now()) @map(\"created_at\")\n  lastUsedAt DateTime? @map(\"last_used_at\")\n  tenant     Tenant    @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"api_keys\")\n}\n\nmodel AuditLog {\n  id           String   @id @default(uuid())\n  actorUserId  String?  @map(\"actor_user_id\")\n  action       String\n  resourceType String   @map(\"resource_type\")\n  resourceId   String?  @map(\"resource_id\")\n  metadata     Json?    @map(\"metadata_json\")\n  deviceId     String?  @map(\"device_id\")\n  ipAddress    String?  @map(\"ip_address\")\n  createdAt    DateTime @default(now()) @map(\"created_at\")\n  tenantId     String   @map(\"tenant_id\")\n  actor        User?    @relation(fields: [actorUserId], references: [id])\n  tenant       Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@index([tenantId, createdAt])\n  @@index([actorUserId])\n  @@index([deviceId])\n  @@map(\"audit_logs\")\n}\n\nmodel SystemEvent {\n  id               String   @id @default(uuid())\n  tenantId         String   @map(\"tenant_id\")\n  operation        String // CREATE, UPDATE, DELETE\n  modelName        String   @map(\"model_name\")\n  entityId         String?  @map(\"entity_id\")\n  payload          Json?\n  previousData     Json?    @map(\"previous_data\")\n  actorUserId      String?  @map(\"actor_user_id\")\n  deviceId         String?  @map(\"device_id\")\n  ipAddress        String?  @map(\"ip_address\")\n  checksum         String   @default(\"\")\n  previousChecksum String?  @map(\"previous_checksum\")\n  createdAt        DateTime @default(now()) @map(\"created_at\")\n\n  tenant Tenant @relation(fields: [tenantId], references: [id])\n  actor  User?  @relation(fields: [actorUserId], references: [id])\n\n  @@index([tenantId])\n  @@index([modelName, entityId])\n  @@index([createdAt])\n  @@map(\"system_events\")\n}\n\nmodel Lead {\n  id                String    @id @default(uuid())\n  fullName          String    @map(\"full_name\")\n  email             String\n  phone             String?\n  message           String?\n  source            String\n  status            String?   @default(\"new\")\n  serviceInterest   String    @map(\"service_interest\")\n  notes             String?\n  convertedToUserId String?   @map(\"converted_to_user_id\")\n  conversionDate    DateTime? @map(\"conversion_date\")\n  tenantId          String?   @map(\"tenant_id\")\n  tenant            Tenant?   @relation(fields: [tenantId], references: [id])\n  createdAt         DateTime  @default(now()) @map(\"created_at\")\n  updatedAt         DateTime  @updatedAt @map(\"updated_at\")\n\n  @@index([tenantId])\n  @@map(\"leads\")\n}\n\nmodel FAQ {\n  id        String   @id @default(uuid())\n  question  String\n  answer    String\n  category  String\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  updatedAt DateTime @updatedAt @map(\"updated_at\")\n\n  @@map(\"faqs\")\n}\n\nmodel UserDevice {\n  id           String    @id @default(uuid())\n  userId       String    @map(\"user_id\")\n  deviceId     String    @map(\"device_id\")\n  deviceName   String?   @map(\"device_name\")\n  deviceType   String?   @map(\"device_type\")\n  lastIp       String?   @map(\"last_ip\")\n  status       String    @default(\"active\")\n  isAuthorized Boolean   @default(false) @map(\"is_authorized\")\n  authorizedAt DateTime? @map(\"authorized_at\")\n  isTemporary  Boolean   @default(false) @map(\"is_temporary\")\n  expiresAt    DateTime? @map(\"expires_at\")\n  createdAt    DateTime  @default(now()) @map(\"created_at\")\n  updatedAt    DateTime  @updatedAt @map(\"updated_at\")\n  lastActiveAt DateTime  @default(now()) @map(\"last_active_at\")\n  user         User      @relation(fields: [userId], references: [id])\n\n  @@unique([userId, deviceId])\n  @@index([userId])\n  @@map(\"user_devices\")\n}\n\nmodel SystemPolicy {\n  id         String   @id @default(uuid())\n  code       String   @unique // e.g., 'CORE_SEC_01'\n  name       String\n  category   String // SECURITY, CLINICAL, BILLING, OPS\n  value      String\n  isEnforced Boolean  @default(true) @map(\"is_enforced\")\n  version    Int      @default(1)\n  updatedAt  DateTime @updatedAt @map(\"updated_at\")\n\n  @@map(\"system_policies\")\n}\n\nmodel ResponseBotAudit {\n  id         String   @id @default(uuid())\n  type       String // REGISTRY_CHECK, 404_HEARTBEAT, SCHEMA_PARITY\n  status     String   @default(\"success\") // success, warning, failure\n  summary    String\n  details    String\n  durationMs Int      @map(\"duration_ms\")\n  createdAt  DateTime @default(now()) @map(\"created_at\")\n\n  @@map(\"response_bot_audits\")\n}\n\nmodel SystemTouchpoint {\n  id            String   @id @default(uuid())\n  touchpointId  String   @unique @map(\"touchpoint_id\")\n  type          String // BUTTON, LINK, INTERACTION\n  role          String\n  module        String\n  label         String? // The text displayed on UI\n  path          String\n  status        String   @default(\"OK\") // OK, 404, ERROR\n  errorDetail   String?  @map(\"error_detail\")\n  isOverridden  Boolean  @default(false) @map(\"is_overridden\")\n  overrideValue String?  @map(\"override_value\")\n  lastChecked   DateTime @default(now()) @map(\"last_checked\")\n  tenantId      String   @map(\"tenant_id\")\n  tenant        Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"system_touchpoints\")\n}\n\nmodel RegistryEntry {\n  id          String    @id @default(uuid())\n  externalId  String    @unique @map(\"external_id\") // e.g., 'btn-admin-user-invite'\n  type        String // button, link, interaction\n  label       String\n  role        String\n  module      String\n  action      String?\n  targetPath  String?   @map(\"target_path\")\n  description String?\n  status      String    @default(\"active\")\n  lastChecked DateTime? @map(\"last_checked\")\n  errorCount  Int       @default(0) @map(\"error_count\")\n  metadata    String?\n  createdAt   DateTime  @default(now()) @map(\"created_at\")\n  updatedAt   DateTime  @updatedAt @map(\"updated_at\")\n\n  @@map(\"registry_entries\")\n}\n\nmodel MessageThread {\n  id         String         @id @default(uuid())\n  threadType String         @map(\"thread_type\")\n  clientId   String?        @map(\"client_id\")\n  pswId      String?        @map(\"psw_id\")\n  createdAt  DateTime       @default(now()) @map(\"created_at\")\n  tenantId   String         @map(\"tenant_id\")\n  messages   Message[]\n  client     ClientProfile? @relation(fields: [clientId], references: [id])\n  psw        PswProfile?    @relation(\"PswToThreads\", fields: [pswId], references: [id])\n  tenant     Tenant         @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"messages_threads\")\n}\n\nmodel Message {\n  id           String        @id @default(uuid())\n  threadId     String        @map(\"thread_id\")\n  senderUserId String        @map(\"sender_user_id\")\n  bodyText     String        @map(\"body_text\")\n  createdAt    DateTime      @default(now()) @map(\"created_at\")\n  sender       User          @relation(fields: [senderUserId], references: [id])\n  thread       MessageThread @relation(fields: [threadId], references: [id])\n\n  @@map(\"messages\")\n}\n\n// ==========================================\n// ECOSYSTEM ENGINE (Phase 66, 67, 68)\n// ==========================================\n\nmodel PlatformRole {\n  id           String               @id @default(uuid())\n  name         String               @unique // e.g., 'PSW', 'COORDINATOR', 'RN', 'GM'\n  description  String?\n  isCustom     Boolean              @default(false) @map(\"is_custom\")\n  tenantId     String?              @map(\"tenant_id\")\n  tenant       Tenant?              @relation(fields: [tenantId], references: [id])\n  screenAccess RoleScreenAccess[]\n  resolutions  ProtocolResolution[] @relation(\"EscalationRoles\")\n  screens      PlatformScreen[]\n  createdAt    DateTime             @default(now()) @map(\"created_at\")\n  updatedAt    DateTime             @updatedAt @map(\"updated_at\")\n\n  @@map(\"platform_roles\")\n}\n\nmodel RoleScreenAccess {\n  id          String       @id @default(uuid())\n  roleId      String       @map(\"role_id\")\n  screenRoute String       @map(\"screen_route\") // e.g., '/coordinator/live-map'\n  canRead     Boolean      @default(true) @map(\"can_read\")\n  canWrite    Boolean      @default(false) @map(\"can_write\")\n  role        PlatformRole @relation(fields: [roleId], references: [id])\n\n  @@unique([roleId, screenRoute])\n  @@map(\"role_screen_access\")\n}\n\nmodel CrisisProtocol {\n  id           String               @id @default(uuid())\n  scenarioName String               @map(\"scenario_name\") // e.g., 'Wi-Fi Drops'\n  triggerEvent String               @unique @map(\"trigger_event\") // e.g., 'EVV_CHECKOUT_TIMEOUT'\n  severity     String               @default(\"medium\")\n  isActive     Boolean              @default(true) @map(\"is_active\")\n  tenantId     String?              @map(\"tenant_id\")\n  resolutions  ProtocolResolution[]\n  createdAt    DateTime             @default(now()) @map(\"created_at\")\n\n  @@map(\"crisis_protocols\")\n}\n\nmodel ProtocolResolution {\n  id               String  @id @default(uuid())\n  protocolId       String  @map(\"protocol_id\")\n  actionType       String  @map(\"action_type\") // e.g., 'ENABLE_SQLITE_BUFFER', 'ACTIVATE_WEB_RTC'\n  escalateToRoleId String? @map(\"escalate_to_role_id\")\n  uiOverrideKey    String? @map(\"ui_override_key\") // e.g., 'RED_SOS_BANNER'\n  orderIndex       Int     @default(0) @map(\"order_index\")\n\n  protocol       CrisisProtocol @relation(fields: [protocolId], references: [id])\n  escalateToRole PlatformRole?  @relation(\"EscalationRoles\", fields: [escalateToRoleId], references: [id])\n\n  @@map(\"protocol_resolutions\")\n}\n\nmodel EcosystemStateOverride {\n  id                String    @id @default(uuid())\n  globalStateMacro  String    @unique @map(\"global_state_macro\") // e.g., 'SEVERE_STAFF_SHORTAGE', 'CODE_BLACK'\n  isActive          Boolean   @default(false) @map(\"is_active\")\n  payMultiplier     Decimal?  @default(1.0) @map(\"pay_multiplier\")\n  forceOfflineMode  Boolean   @default(false) @map(\"force_offline_mode\")\n  filterTriageOnly  Boolean   @default(false) @map(\"filter_triage_only\")\n  activatedAt       DateTime? @map(\"activated_at\")\n  activatedByUserId String?   @map(\"activated_by_user_id\")\n\n  @@map(\"ecosystem_state_overrides\")\n}\n\nmodel UserReputation {\n  id                  String   @id @default(uuid())\n  userId              String   @unique @map(\"user_id\")\n  points              Int      @default(0)\n  eliteStatus         Boolean  @default(false) @map(\"elite_status\")\n  permanentMultiplier Decimal  @default(1.0) @map(\"permanent_multiplier\")\n  crisesResolved      Int      @default(0) @map(\"crises_resolved\")\n  createdAt           DateTime @default(now()) @map(\"created_at\")\n  updatedAt           DateTime @updatedAt @map(\"updated_at\")\n\n  user User @relation(fields: [userId], references: [id])\n\n  @@map(\"user_reputations\")\n}\n\nmodel EcosystemAutopilotConfig {\n  id                     String    @id @default(uuid())\n  tenantId               String    @unique @map(\"tenant_id\")\n  isActive               Boolean   @default(true) @map(\"is_active\")\n  maxDailySurgeBudget    Decimal   @default(200.0) @map(\"max_daily_surge_budget\")\n  currentDailySurgeSpend Decimal   @default(0.0) @map(\"current_daily_surge_spend\")\n  marginFreezeThreshold  Decimal   @default(25.0) @map(\"margin_freeze_threshold\")\n  lastCronRun            DateTime? @map(\"last_cron_run\")\n  createdAt              DateTime  @default(now()) @map(\"created_at\")\n  updatedAt              DateTime  @updatedAt @map(\"updated_at\")\n\n  @@map(\"ecosystem_autopilot_configs\")\n}\n\nmodel HospitalTarget {\n  id               String    @id @default(uuid())\n  tenantId         String    @map(\"tenant_id\")\n  hospitalName     String    @map(\"hospital_name\")\n  dischargePlanner String?   @map(\"discharge_planner\")\n  status           String    @default(\"prospecting\")\n  lastTouchpointAt DateTime? @map(\"last_touchpoint_at\")\n  createdAt        DateTime  @default(now()) @map(\"created_at\")\n  updatedAt        DateTime  @updatedAt @map(\"updated_at\")\n\n  pipelines ReferralPipeline[]\n\n  @@map(\"hospital_targets\")\n}\n\nmodel ReferralPipeline {\n  id            String   @id @default(uuid())\n  tenantId      String   @map(\"tenant_id\")\n  hospitalId    String   @map(\"hospital_id\")\n  patientName   String   @map(\"patient_name\")\n  referralValue Decimal  @default(0.0) @map(\"referral_value\")\n  isConverted   Boolean  @default(false) @map(\"is_converted\")\n  createdAt     DateTime @default(now()) @map(\"created_at\")\n\n  hospital HospitalTarget @relation(fields: [hospitalId], references: [id])\n\n  @@map(\"referral_pipelines\")\n}\n\nmodel SupplyForecastMetrics {\n  id              String   @id @default(uuid())\n  tenantId        String   @map(\"tenant_id\")\n  targetDate      DateTime @map(\"target_date\")\n  geographyZone   String   @map(\"geography_zone\")\n  predictedDemand Int      @map(\"predicted_demand\")\n  physicalSupply  Int      @map(\"physical_supply\")\n  deficitWarning  Boolean  @default(false) @map(\"deficit_warning\")\n  createdAt       DateTime @default(now()) @map(\"created_at\")\n  updatedAt       DateTime @updatedAt @map(\"updated_at\")\n\n  @@map(\"supply_forecast_metrics\")\n}\n\n// ==========================================\n// CARE DELIVERY MODELS\n// ==========================================\n\nmodel ClientProfile {\n  id                    String                      @id @default(uuid())\n  userId                String                      @unique @map(\"user_id\")\n  fullName              String                      @map(\"full_name\")\n  dob                   DateTime?\n  addressLine1          String?                     @map(\"address_line1\")\n  addressLine2          String?                     @map(\"address_line2\")\n  city                  String?\n  province              String?\n  postalCode            String?                     @map(\"postal_code\")\n  lat                   Float?\n  lng                   Float?\n  emergencyName         String?                     @map(\"emergency_contact_name\")\n  emergencyPhone        String?                     @map(\"emergency_contact_phone\")\n  preferences           Json?                       @map(\"preferences_json\")\n  createdAt             DateTime                    @default(now()) @map(\"created_at\")\n  updatedAt             DateTime                    @updatedAt @map(\"updated_at\")\n  tenantId              String                      @map(\"tenant_id\")\n  bookings              Booking[]\n  tenant                Tenant                      @relation(fields: [tenantId], references: [id])\n  user                  User                        @relation(fields: [userId], references: [id])\n  DailyEntry            DailyEntry[]\n  invoices              Invoice[]\n  messageThreads        MessageThread[]\n  visits                Visit[]\n  feedbacks             Feedback[]\n  franchise             Franchise?                  @relation(fields: [franchiseId], references: [id])\n  franchiseId           String?                     @map(\"franchise_id\")\n  inventoryItems        InventoryItem[]\n  purchaseOrders        PurchaseOrder[]\n  telehealthSessions    TelehealthSession[]\n  vitalSigns            VitalSign[]\n  patientAlerts         PatientAlert[]\n  claims                Claim[]\n  prescriptions         Prescription[]\n  marEntries            MAR_Entry[]\n  carePlans             CarePlan[]\n  assessments           ClinicalAssessment[]\n  medicationRecons      MedicationRecon[]\n  waitlistEntries       WaitlistEntry[]\n  familyNotifications   FamilyNotification[]\n  careFeedbacks         CareFeedback[]\n  bookingRequests       BookingRequest[]\n  serviceAuthorizations ServiceAuthorization[]\n  consentForms          ConsentForm[]\n  familyMembers         FamilyMember[]\n  shiftCheckIns         PswShiftLog[]               @relation(\"ClientShiftLogs\")\n  adlCareLogs           AdlCareLog[]                @relation(\"ClientAdlLogs\")\n  pswVitals             PswVitalSign[]              @relation(\"ClientPswVitals\")\n  behaviorNotes         BehaviorNote[]              @relation(\"ClientBehaviorNotes\")\n  nutritionRecords      NutritionRecord[]           @relation(\"ClientNutrition\")\n  mobilityLogs          MobilityLog[]               @relation(\"ClientMobility\")\n  infectionLogs         InfectionControlChecklist[] @relation(\"ClientInfectionControl\")\n  narrativeNotes        NarrativeProgressNote[]     @relation(\"ClientNarrativeNotes\")\n  carePlanFollowUps     CarePlanFollowUp[]          @relation(\"ClientCarePlanFollowUp\")\n\n  @@index([tenantId])\n  @@map(\"client_profiles\")\n}\n\nmodel PswProfile {\n  id                    String                 @id @default(uuid())\n  userId                String                 @unique @map(\"user_id\")\n  fullName              String                 @map(\"full_name\")\n  bio                   String?\n  languages             String\n  serviceAreas          String                 @map(\"service_areas\")\n  availabilityJson      Json?                  @map(\"availability_json\")\n  isApproved            Boolean                @default(false) @map(\"is_approved\")\n  approvedAt            DateTime?              @map(\"approved_at\")\n  trustScore            Int                    @default(100) @map(\"trust_score\")\n  hasCompletedInduction Boolean                @default(false) @map(\"has_completed_induction\")\n  isLockedForRetraining Boolean                @default(false) @map(\"is_locked_for_retraining\")\n  createdAt             DateTime               @default(now()) @map(\"created_at\")\n  tenantId              String                 @map(\"tenant_id\")\n  address               String?\n  avatarUrl             String?                @map(\"avatar_url\")\n  skills                String\n  messageThreads        MessageThread[]        @relation(\"PswToThreads\")\n  availability          PswAvailability[]      @relation(\"PswToAvailability\")\n  documents             PswDocument[]          @relation(\"PswToDocuments\")\n  tenant                Tenant                 @relation(fields: [tenantId], references: [id])\n  user                  User                   @relation(fields: [userId], references: [id])\n  assignments           ShiftAssignment[]      @relation(\"PswToAssignments\")\n  timesheets            Timesheet[]            @relation(\"PswToTimesheets\")\n  checkEvents           VisitCheckEvent[]      @relation(\"PswToCheckEvents\")\n  checklists            VisitChecklist[]       @relation(\"PswToChecklists\")\n  notes                 VisitNote[]            @relation(\"PswToNotes\")\n  assignedVisits        Visit[]                @relation(\"PswToVisits\")\n  handovers             ShiftHandover[]\n  overrides             AvailabilityOverride[]\n  payouts               Payout[]\n  fleetStatus           FleetStatus?\n  supervisionLogs       SupervisionLog[]\n  matches               VisitMatch[]           @relation(\"VisitMatches\")\n  mileageLogs           MileageLog[]\n  performanceReviews    PerformanceReview[]\n\n  @@index([tenantId])\n  @@map(\"psw_profiles\")\n}\n\nmodel Visit {\n  id                   String             @id @default(uuid())\n  clientId             String             @map(\"client_id\")\n  serviceId            String             @map(\"service_id\")\n  requestedStartAt     DateTime           @map(\"requested_start_at\")\n  durationMinutes      Int                @map(\"duration_minutes\")\n  recurrenceRuleString String?            @map(\"recurrence_rule_string\")\n  recurrenceEndDate    DateTime?          @map(\"recurrence_end_date\")\n  status               String?            @default(\"requested\")\n  assignedPswId        String?            @map(\"assigned_psw_id\")\n  serviceAddressLine1  String?            @map(\"service_address_line1\")\n  serviceAddressLine2  String?            @map(\"service_address_line2\")\n  serviceCity          String?            @map(\"service_city\")\n  serviceProvince      String?            @map(\"service_province\")\n  servicePostalCode    String?            @map(\"service_postal_code\")\n  serviceLat           Float?             @map(\"service_lat\")\n  serviceLng           Float?             @map(\"service_lng\")\n  clientNotes          String?            @map(\"client_notes\")\n  coordinatorNotes     String?            @map(\"coordinator_notes\")\n  cancellationReason   String?            @map(\"cancellation_reason\")\n  createdAt            DateTime           @default(now()) @map(\"created_at\")\n  updatedAt            DateTime           @updatedAt @map(\"updated_at\")\n  tenantId             String             @map(\"tenant_id\")\n  bookingId            String?            @map(\"booking_id\")\n  crisisMode           Boolean?           @default(false) @map(\"crisis_mode\")\n  priority             String?            @default(\"normal\")\n  managementNotes      String?            @map(\"management_notes\")\n  requiredSkills       String             @map(\"required_skills\")\n  isSurgeActive        Boolean?           @default(false) @map(\"is_surge_active\")\n  surgeMultiplier      Float?             @default(1.0) @map(\"surge_multiplier\")\n  DailyEntry           DailyEntry[]\n  incidents            Incident[]\n  assignments          ShiftAssignment[]\n  timesheetItems       TimesheetItem[]\n  checkEvents          VisitCheckEvent[]\n  checklists           VisitChecklist[]\n  notes                VisitNote[]\n  feedbacks            Feedback[]\n  matches              VisitMatch[]\n  psw                  PswProfile?        @relation(\"PswToVisits\", fields: [assignedPswId], references: [id])\n  booking              Booking?           @relation(fields: [bookingId], references: [id])\n  client               ClientProfile      @relation(fields: [clientId], references: [id])\n  service              Service            @relation(fields: [serviceId], references: [id])\n  tenant               Tenant             @relation(fields: [tenantId], references: [id])\n  handovers            ShiftHandover[]\n  careFeedbacks        CareFeedback[]\n  dailyAuditSignOff    DailyAuditSignOff?\n\n  @@index([tenantId])\n  @@index([tenantId, status])\n  @@index([tenantId, assignedPswId])\n  @@index([tenantId, requestedStartAt])\n  @@map(\"visits\")\n}\n\nmodel Service {\n  id                 String          @id @default(uuid())\n  name               String\n  slug               String          @unique\n  description        String?\n  baseRateHourly     Decimal?        @map(\"base_rate_hourly\")\n  providerRateHourly Decimal?        @map(\"provider_rate_hourly\")\n  isActive           Boolean?        @default(true) @map(\"is_active\")\n  createdAt          DateTime        @default(now()) @map(\"created_at\")\n  updatedAt          DateTime        @updatedAt @map(\"updated_at\")\n  tenantId           String          @map(\"tenant_id\")\n  isFeatured         Boolean         @default(false) @map(\"is_featured\")\n  tenant             Tenant          @relation(fields: [tenantId], references: [id])\n  visits             Visit[]\n  waitlistEntries    WaitlistEntry[]\n\n  @@index([tenantId])\n  @@map(\"services\")\n}\n\nmodel VisitCheckEvent {\n  id                String     @id @default(uuid())\n  visitId           String     @map(\"visit_id\")\n  pswId             String     @map(\"psw_id\")\n  eventType         String     @map(\"event_type\")\n  lat               Float?\n  lng               Float?\n  accuracyM         Float?     @map(\"accuracy_m\")\n  computedDistanceM Float?     @map(\"computed_distance_m\")\n  deviceTimeIso     DateTime?  @map(\"device_time_iso\")\n  serverTime        DateTime?  @default(now()) @map(\"server_time\")\n  result            String\n  rejectReason      String?    @map(\"reject_reason\")\n  isOverride        Boolean?   @default(false) @map(\"is_override\")\n  overrideByUserId  String?    @map(\"override_by_user_id\")\n  overrideReason    String?    @map(\"override_reason\")\n  createdAt         DateTime   @default(now()) @map(\"created_at\")\n  tenantId          String     @map(\"tenant_id\")\n  overriddenBy      User?      @relation(fields: [overrideByUserId], references: [id])\n  pswProfile        PswProfile @relation(\"PswToCheckEvents\", fields: [pswId], references: [id])\n  tenant            Tenant     @relation(fields: [tenantId], references: [id])\n  visit             Visit      @relation(fields: [visitId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"visit_check_events\")\n}\n\nmodel VisitNote {\n  id        String     @id @default(uuid())\n  visitId   String     @map(\"visit_id\")\n  pswId     String     @map(\"psw_id\")\n  noteText  String     @map(\"note_text\")\n  createdAt DateTime   @default(now()) @map(\"created_at\")\n  psw       PswProfile @relation(\"PswToNotes\", fields: [pswId], references: [id])\n  visit     Visit      @relation(fields: [visitId], references: [id])\n\n  @@map(\"visit_notes\")\n}\n\nmodel VisitChecklist {\n  id        String     @id @default(uuid())\n  visitId   String     @map(\"visit_id\")\n  pswId     String     @map(\"psw_id\")\n  checklist Json       @map(\"checklist_json\")\n  createdAt DateTime   @default(now()) @map(\"created_at\")\n  psw       PswProfile @relation(\"PswToChecklists\", fields: [pswId], references: [id])\n  visit     Visit      @relation(fields: [visitId], references: [id])\n\n  @@map(\"visit_checklists\")\n}\n\nmodel Incident {\n  id              String    @id @default(uuid())\n  visitId         String?   @map(\"visit_id\")\n  reporterUserId  String    @map(\"reporter_user_id\")\n  type            String\n  description     String\n  status          String?   @default(\"open\")\n  resolutionNotes String?   @map(\"resolution_notes\")\n  createdAt       DateTime  @default(now()) @map(\"created_at\")\n  updatedAt       DateTime  @updatedAt @map(\"updated_at\")\n  tenantId        String    @map(\"tenant_id\")\n  severity        String?   @default(\"medium\") // low, medium, high, critical\n  reportedAt      DateTime? @map(\"reported_at\")\n  acknowledgedAt  DateTime? @map(\"acknowledged_at\")\n  acknowledgedBy  String?   @map(\"acknowledged_by\")\n  acknowledger    User?     @relation(\"Acknowledger\", fields: [acknowledgedBy], references: [id])\n  reporter        User      @relation(\"Reporter\", fields: [reporterUserId], references: [id])\n  tenant          Tenant    @relation(fields: [tenantId], references: [id])\n  visit           Visit?    @relation(fields: [visitId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"incidents\")\n}\n\nmodel DailyEntry {\n  id         String        @id @default(uuid())\n  tenantId   String        @map(\"tenant_id\")\n  clientId   String        @map(\"client_id\")\n  staffId    String        @map(\"staff_id\")\n  visitId    String?       @map(\"visit_id\")\n  adlData    Json          @map(\"adl_data\")\n  medication String?\n  mood       Int?\n  vitals     String?\n  notes      String?\n  signature  String?\n  status     String        @default(\"DRAFT\")\n  createdAt  DateTime      @default(now()) @map(\"created_at\")\n  updatedAt  DateTime      @updatedAt @map(\"updated_at\")\n  client     ClientProfile @relation(fields: [clientId], references: [id])\n  staff      User          @relation(fields: [staffId], references: [id])\n  tenant     Tenant        @relation(fields: [tenantId], references: [id])\n  visit      Visit?        @relation(fields: [visitId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"daily_entries\")\n}\n\nmodel Booking {\n  id             String        @id @default(uuid())\n  clientId       String        @map(\"client_id\")\n  branchId       String?       @map(\"branch_id\")\n  startAt        DateTime      @map(\"start_at\")\n  endAt          DateTime      @map(\"end_at\")\n  serviceType    String        @map(\"service_type\")\n  priority       String        @default(\"normal\")\n  notes          String?\n  status         String        @default(\"pending\")\n  recurrenceRule String?       @map(\"recurrence_rule\")\n  tenantId       String        @map(\"tenant_id\")\n  client         ClientProfile @relation(fields: [clientId], references: [id])\n  tenant         Tenant        @relation(fields: [tenantId], references: [id])\n  visits         Visit[]\n\n  @@index([tenantId])\n  @@index([tenantId, status])\n  @@map(\"bookings\")\n}\n\nmodel PswAvailability {\n  id        String     @id @default(uuid())\n  pswId     String     @map(\"psw_id\")\n  dayOfWeek Int        @map(\"day_of_week\")\n  startTime String     @map(\"start_time\")\n  endTime   String     @map(\"end_time\")\n  tenantId  String     @map(\"tenant_id\")\n  psw       PswProfile @relation(\"PswToAvailability\", fields: [pswId], references: [id])\n  tenant    Tenant     @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"psw_availability\")\n}\n\nmodel PswDocument {\n  id         String     @id @default(uuid())\n  pswId      String     @map(\"psw_id\")\n  docType    String     @map(\"doc_type\")\n  fileKey    String     @map(\"file_key\")\n  status     String?    @default(\"pending\")\n  expiryDate DateTime?  @map(\"expiry_date\")\n  verifiedBy String?    @map(\"verified_by\")\n  verifiedAt DateTime?  @map(\"verified_at\")\n  createdAt  DateTime   @default(now()) @map(\"created_at\")\n  updatedAt  DateTime   @updatedAt @map(\"updated_at\")\n  psw        PswProfile @relation(\"PswToDocuments\", fields: [pswId], references: [id])\n  verifier   User?      @relation(\"VerifiedBy\", fields: [verifiedBy], references: [id])\n\n  @@map(\"psw_documents\")\n}\n\n// ==========================================\n// SCHEDULING & WORKFORCE MODELS\n// ==========================================\n\nmodel ShiftAssignment {\n  id         String     @id @default(uuid())\n  visitId    String     @map(\"visit_id\")\n  pswId      String     @map(\"psw_id\")\n  status     String     @default(\"offered\")\n  score      Float?\n  assignedAt DateTime   @default(now()) @map(\"assigned_at\")\n  tenantId   String     @map(\"tenant_id\")\n  psw        PswProfile @relation(\"PswToAssignments\", fields: [pswId], references: [id])\n  tenant     Tenant     @relation(fields: [tenantId], references: [id])\n  visit      Visit      @relation(fields: [visitId], references: [id])\n\n  @@index([tenantId])\n  @@index([tenantId, status])\n  @@map(\"shift_assignments\")\n}\n\nmodel Timesheet {\n  id           String          @id @default(uuid())\n  pswId        String          @map(\"psw_id\")\n  weekId       String          @map(\"week_id\")\n  totalMinutes Int?            @default(0) @map(\"total_minutes\")\n  status       String?         @default(\"draft\")\n  submittedAt  DateTime?       @map(\"submitted_at\")\n  reviewedBy   String?         @map(\"reviewed_by\")\n  reviewedAt   DateTime?       @map(\"reviewed_at\")\n  createdAt    DateTime        @default(now()) @map(\"created_at\")\n  updatedAt    DateTime        @updatedAt @map(\"updated_at\")\n  tenantId     String          @map(\"tenant_id\")\n  items        TimesheetItem[]\n  psw          PswProfile      @relation(\"PswToTimesheets\", fields: [pswId], references: [id])\n  reviewer     User?           @relation(\"ReviewedBy\", fields: [reviewedBy], references: [id])\n  tenant       Tenant          @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"timesheets\")\n}\n\nmodel TimesheetItem {\n  id          String    @id @default(uuid())\n  timesheetId String    @map(\"timesheet_id\")\n  visitId     String    @map(\"visit_id\")\n  minutes     Int\n  createdAt   DateTime  @default(now()) @map(\"created_at\")\n  timesheet   Timesheet @relation(fields: [timesheetId], references: [id])\n  visit       Visit     @relation(fields: [visitId], references: [id])\n\n  @@map(\"timesheet_items\")\n}\n\nmodel ShiftHandover {\n  id             String   @id @default(uuid())\n  pswId          String   @map(\"psw_id\")\n  visitId        String   @map(\"visit_id\")\n  tenantId       String   @map(\"tenant_id\")\n  handoverNotes  String   @map(\"handover_notes\")\n  safetyConcerns String?  @map(\"safety_concerns\")\n  suppliesNeeded String?  @map(\"supplies_needed\")\n  createdAt      DateTime @default(now()) @map(\"created_at\")\n\n  psw    PswProfile @relation(fields: [pswId], references: [id])\n  visit  Visit      @relation(fields: [visitId], references: [id])\n  tenant Tenant     @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"shift_handovers\")\n}\n\nmodel AvailabilityOverride {\n  id          String   @id @default(uuid())\n  pswId       String   @map(\"psw_id\")\n  tenantId    String   @map(\"tenant_id\")\n  date        DateTime\n  startTime   String   @map(\"start_time\")\n  endTime     String   @map(\"end_time\")\n  isAvailable Boolean  @default(true) @map(\"is_available\")\n\n  psw    PswProfile @relation(fields: [pswId], references: [id])\n  tenant Tenant     @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"psw_availability_overrides\")\n}\n\nmodel VisitMatch {\n  id        String   @id @default(uuid())\n  visitId   String   @map(\"visit_id\")\n  pswId     String   @map(\"psw_id\")\n  score     Float\n  status    String   @default(\"pending\") // pending, rejected, accepted\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  tenantId  String   @map(\"tenant_id\")\n\n  visit  Visit      @relation(fields: [visitId], references: [id])\n  psw    PswProfile @relation(\"VisitMatches\", fields: [pswId], references: [id])\n  tenant Tenant     @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"visit_matches\")\n}\n\nmodel WaitlistEntry {\n  id               String    @id @default(uuid())\n  clientId         String    @map(\"client_id\")\n  serviceId        String    @map(\"service_id\")\n  priority         Int       @default(0)\n  status           String    @default(\"active\") // active, matched, cancelled\n  notes            String?\n  requestedStartAt DateTime? @map(\"requested_start_at\")\n  createdAt        DateTime  @default(now()) @map(\"created_at\")\n  tenantId         String    @map(\"tenant_id\")\n\n  client  ClientProfile @relation(fields: [clientId], references: [id])\n  service Service       @relation(fields: [serviceId], references: [id])\n  tenant  Tenant        @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"waitlist_entries\")\n}\n\nmodel StaffTask {\n  id          String    @id @default(uuid())\n  title       String\n  description String?\n  status      String    @default(\"todo\") // todo, in_progress, completed, blocked\n  priority    String    @default(\"medium\") // low, medium, high, urgent\n  dueDate     DateTime? @map(\"due_date\")\n  assigneeId  String?   @map(\"assignee_id\")\n  groupId     String?   @map(\"group_id\") // Assigned to a specific Admin Group rather than an individual\n  tenantId    String    @map(\"tenant_id\")\n  createdAt   DateTime  @default(now()) @map(\"created_at\")\n  updatedAt   DateTime  @updatedAt @map(\"updated_at\")\n\n  tenant   Tenant      @relation(fields: [tenantId], references: [id])\n  group    StaffGroup? @relation(fields: [groupId], references: [id])\n  assignee User?       @relation(\"AssignedTasks\", fields: [assigneeId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"staff_tasks\")\n}\n\nmodel StaffGroup {\n  id          String   @id @default(uuid())\n  name        String\n  description String?\n  tenantId    String   @map(\"tenant_id\")\n  createdAt   DateTime @default(now()) @map(\"created_at\")\n  updatedAt   DateTime @updatedAt @map(\"updated_at\")\n\n  tenant  Tenant             @relation(fields: [tenantId], references: [id])\n  members StaffGroupMember[]\n  tasks   StaffTask[]\n\n  @@index([tenantId])\n  @@map(\"staff_groups\")\n}\n\nmodel StaffGroupMember {\n  id        String   @id @default(uuid())\n  groupId   String   @map(\"group_id\")\n  userId    String   @map(\"user_id\")\n  role      String   @default(\"member\") // admin/leader, member\n  createdAt DateTime @default(now()) @map(\"created_at\")\n\n  group StaffGroup @relation(fields: [groupId], references: [id])\n  user  User       @relation(fields: [userId], references: [id])\n\n  @@unique([groupId, userId])\n  @@index([userId])\n  @@map(\"staff_group_members\")\n}\n\nmodel BookingRequest {\n  id            String   @id @default(uuid())\n  clientId      String   @map(\"client_id\")\n  tenantId      String   @map(\"tenant_id\")\n  serviceType   String   @map(\"service_type\")\n  preferredDate DateTime @map(\"preferred_date\")\n  preferredTime String?  @map(\"preferred_time\")\n  notes         String?\n  status        String   @default(\"pending\") // pending, approved, rejected, cancelled\n  createdAt     DateTime @default(now()) @map(\"created_at\")\n  updatedAt     DateTime @updatedAt @map(\"updated_at\")\n\n  client ClientProfile @relation(fields: [clientId], references: [id])\n  tenant Tenant        @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"booking_requests\")\n}\n\nmodel FleetStatus {\n  id              String     @id @default(uuid())\n  pswId           String     @unique @map(\"psw_id\")\n  lat             Float?\n  lng             Float?\n  status          String     @default(\"available\") // available, en_route, on_site, offline\n  batteryLevel    Int?       @map(\"battery_level\")\n  lastHeartbeatAt DateTime   @default(now()) @map(\"last_heartbeat_at\")\n  currentVisitId  String?    @map(\"current_visit_id\")\n  psw             PswProfile @relation(fields: [pswId], references: [id])\n\n  @@map(\"fleet_status\")\n}\n\n// ==========================================\n// CLINICAL OPERATIONS MODELS\n// ==========================================\n\nmodel CarePlan {\n  id            String    @id @default(uuid())\n  clientId      String    @map(\"client_id\")\n  tenantId      String    @map(\"tenant_id\")\n  diagnoses     String\n  clinicalGoals String?   @map(\"clinical_goals\")\n  interventions String?   @map(\"interventions\")\n  status        String    @default(\"active\") // active, completed, archived\n  reviewDate    DateTime? @map(\"review_date\")\n  createdAt     DateTime  @default(now()) @map(\"created_at\")\n  updatedAt     DateTime  @updatedAt @map(\"updated_at\")\n\n  client ClientProfile @relation(fields: [clientId], references: [id])\n  tenant Tenant        @relation(fields: [tenantId], references: [id])\n\n  // RN Mastery Extensions\n  authorId     String? @map(\"author_id\")\n  version      Int     @default(1)\n  isArchived   Boolean @default(false) @map(\"is_archived\")\n  outcomeNotes String? @map(\"outcome_notes\")\n  author       User?   @relation(\"CarePlanAuthor\", fields: [authorId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"care_plans\")\n}\n\nmodel ClinicalRecord {\n  id        String   @id @default(uuid())\n  clientId  String   @map(\"client_id\")\n  type      String // e.g., 'Observation', 'Condition', 'Medication'\n  data      String   @map(\"data_json\") // FHIR-compliant structure\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  updatedAt DateTime @updatedAt @map(\"updated_at\")\n  tenantId  String   @map(\"tenant_id\")\n  tenant    Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@index([clientId])\n  @@index([tenantId])\n  @@map(\"clinical_records\")\n}\n\nmodel ClinicalAssessment {\n  id              String   @id @default(uuid())\n  clientId        String   @map(\"client_id\")\n  rnId            String   @map(\"rn_id\")\n  tenantId        String   @map(\"tenant_id\")\n  type            String // ADL, MOBILITY, COGNITIVE, etc.\n  assessmentData  Json     @map(\"assessment_data\")\n  score           Int?\n  recommendations String?\n  createdAt       DateTime @default(now()) @map(\"created_at\")\n  updatedAt       DateTime @updatedAt @map(\"updated_at\")\n\n  client ClientProfile @relation(fields: [clientId], references: [id])\n  rn     User          @relation(fields: [rnId], references: [id])\n  tenant Tenant        @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"clinical_assessments\")\n}\n\nmodel MedicationRecon {\n  id            String   @id @default(uuid())\n  clientId      String   @map(\"client_id\")\n  rnId          String   @map(\"rn_id\")\n  tenantId      String   @map(\"tenant_id\")\n  reconData     Json     @map(\"recon_data\")\n  discrepancies String?\n  status        String   @default(\"completed\") // completed, pending_review\n  createdAt     DateTime @default(now()) @map(\"created_at\")\n\n  client ClientProfile @relation(fields: [clientId], references: [id])\n  rn     User          @relation(fields: [rnId], references: [id])\n  tenant Tenant        @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"medication_reconciliations\")\n}\n\nmodel SupervisionLog {\n  id             String   @id @default(uuid())\n  pswId          String   @map(\"psw_id\")\n  rnId           String   @map(\"rn_id\")\n  tenantId       String   @map(\"tenant_id\")\n  competencies   String\n  isSatisfactory Boolean  @default(true) @map(\"is_satisfactory\")\n  feedback       String?\n  createdAt      DateTime @default(now()) @map(\"created_at\")\n\n  psw    PswProfile @relation(fields: [pswId], references: [id])\n  rn     User       @relation(fields: [rnId], references: [id])\n  tenant Tenant     @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"supervision_logs\")\n}\n\nmodel HealthID {\n  id        String   @id @default(uuid())\n  userId    String   @unique @map(\"user_id\")\n  did       String   @unique // W3C Decentralized Identifier\n  publicKey String   @map(\"public_key\")\n  status    String   @default(\"active\")\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  updatedAt DateTime @updatedAt @map(\"updated_at\")\n\n  @@map(\"health_ids\")\n}\n\nmodel FhirSyncLog {\n  id           String   @id @default(uuid())\n  direction    String // INBOUND, OUTBOUND\n  resourceType String   @map(\"resource_type\")\n  externalId   String?  @map(\"external_id\")\n  status       String // SUCCESS, FAILURE\n  error        String?\n  timestamp    DateTime @default(now())\n  tenantId     String   @map(\"tenant_id\")\n  tenant       Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"fhir_sync_logs\")\n}\n\nmodel VitalSign {\n  id         String   @id @default(uuid())\n  patientId  String   @map(\"patient_id\")\n  type       String // HEART_RATE, BLOOD_PRESSURE, OXYGEN_SAT, TEMPERATURE\n  value      Float\n  unit       String\n  source     String   @default(\"MANUAL\") // MANUAL, WEARABLE, DEVICE\n  recordedAt DateTime @default(now()) @map(\"recorded_at\")\n\n  patient ClientProfile @relation(fields: [patientId], references: [id])\n\n  @@map(\"vital_signs\")\n}\n\nmodel PatientAlert {\n  id        String   @id @default(uuid())\n  tenantId  String   @map(\"tenant_id\")\n  patientId String   @map(\"patient_id\")\n  type      String // CLINICAL, OPERATIONAL, TECHNICAL\n  severity  String   @default(\"MEDIUM\") // LOW, MEDIUM, HIGH, CRITICAL\n  message   String\n  status    String   @default(\"open\") // open, acknowledged, resolved\n  createdAt DateTime @default(now()) @map(\"created_at\")\n\n  tenant  Tenant        @relation(fields: [tenantId], references: [id])\n  patient ClientProfile @relation(fields: [patientId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"patient_alerts\")\n}\n\nmodel Medication {\n  id           String   @id @default(uuid())\n  name         String\n  genericName  String?  @map(\"generic_name\")\n  dosageForm   String?  @map(\"dosage_form\") // Tablet, Injection, etc.\n  strength     String?\n  instructions String?\n  createdAt    DateTime @default(now()) @map(\"created_at\")\n\n  prescriptions Prescription[]\n\n  @@map(\"medications\")\n}\n\nmodel Prescription {\n  id           String    @id @default(uuid())\n  tenantId     String    @map(\"tenant_id\")\n  patientId    String    @map(\"patient_id\")\n  medicationId String    @map(\"medication_id\")\n  prescriberId String?   @map(\"prescriber_id\")\n  dosage       String\n  frequency    String\n  route        String\n  startDate    DateTime  @map(\"start_date\")\n  endDate      DateTime? @map(\"end_date\")\n  status       String    @default(\"active\") // active, completed, discontinued\n  createdAt    DateTime  @default(now()) @map(\"created_at\")\n\n  tenant     Tenant        @relation(fields: [tenantId], references: [id])\n  patient    ClientProfile @relation(fields: [patientId], references: [id])\n  medication Medication    @relation(fields: [medicationId], references: [id])\n  marEntries MAR_Entry[]\n\n  @@index([tenantId])\n  @@map(\"prescriptions\")\n}\n\nmodel MAR_Entry {\n  id               String    @id @default(uuid())\n  patientId        String?   @map(\"patient_id\")\n  clientId         String?   @map(\"client_id\")\n  prescriptionId   String?   @map(\"prescription_id\")\n  administerId     String?   @map(\"administer_id\") // User ID (PSW, RN)\n  administeredById String?   @map(\"administered_by_id\")\n  adminTime        DateTime  @default(now()) @map(\"admin_time\")\n  scheduledTime    DateTime? @map(\"scheduled_time\")\n  administeredAt   DateTime? @map(\"administered_at\")\n  status           String    @default(\"administered\") // administered, missed, refused, given, held, not_available\n  notes            String?\n  medicationName   String?   @map(\"medication_name\")\n  dosage           String?\n  route            String?\n  tenantId         String?   @map(\"tenant_id\")\n\n  patient      ClientProfile? @relation(fields: [patientId], references: [id])\n  prescription Prescription?  @relation(fields: [prescriptionId], references: [id])\n\n  @@index([clientId])\n  @@index([tenantId])\n  @@map(\"mar_entries\")\n}\n\nmodel EVVRecord {\n  id                 String   @id @default(uuid())\n  visitId            String   @map(\"visit_id\")\n  pswId              String   @map(\"psw_id\")\n  checkType          String   @map(\"check_type\") // check_in, check_out\n  lat                Float?\n  lng                Float?\n  accuracy           Float?\n  verificationMethod String   @default(\"gps\") @map(\"verification_method\") // gps, pin, biometric\n  status             String   @default(\"valid\") // valid, exception, overridden\n  overrideById       String?  @map(\"override_by_id\")\n  overrideReason     String?  @map(\"override_reason\")\n  rawData            String?  @map(\"raw_data\")\n  capturedAt         DateTime @default(now()) @map(\"captured_at\")\n  tenantId           String   @map(\"tenant_id\")\n\n  tenant Tenant @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@index([visitId])\n  @@index([pswId])\n  @@map(\"evv_records\")\n}\n\nmodel ServiceAuthorization {\n  id              String   @id @default(uuid())\n  clientId        String   @map(\"client_id\")\n  serviceId       String?  @map(\"service_id\")\n  fundingSource   String   @map(\"funding_source\") // ohip, private, insurance, lhin\n  authorizedHours Float    @map(\"authorized_hours\")\n  usedHours       Float    @default(0) @map(\"used_hours\")\n  startDate       DateTime @map(\"start_date\")\n  endDate         DateTime @map(\"end_date\")\n  status          String   @default(\"active\") // active, expired, exhausted, suspended\n  authCode        String?  @map(\"auth_code\")\n  notes           String?\n  createdAt       DateTime @default(now()) @map(\"created_at\")\n  updatedAt       DateTime @updatedAt @map(\"updated_at\")\n  tenantId        String   @map(\"tenant_id\")\n\n  client ClientProfile @relation(fields: [clientId], references: [id])\n  tenant Tenant        @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@index([clientId])\n  @@map(\"service_authorizations\")\n}\n\nmodel ConsentForm {\n  id               String    @id @default(uuid())\n  clientId         String    @map(\"client_id\")\n  formType         String    @map(\"form_type\") // service_agreement, phipa_consent, dnr, hipaa, general\n  status           String    @default(\"pending\") // pending, signed, expired, revoked\n  signatureDataUrl String?   @map(\"signature_data_url\")\n  signedAt         DateTime? @map(\"signed_at\")\n  expiresAt        DateTime? @map(\"expires_at\")\n  documentKey      String?   @map(\"document_key\") // R2 storage key for PDF\n  witnessName      String?   @map(\"witness_name\")\n  templateVersion  Int       @default(1) @map(\"template_version\")\n  createdAt        DateTime  @default(now()) @map(\"created_at\")\n  updatedAt        DateTime  @updatedAt @map(\"updated_at\")\n  tenantId         String    @map(\"tenant_id\")\n\n  client ClientProfile @relation(fields: [clientId], references: [id])\n  tenant Tenant        @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@index([clientId])\n  @@map(\"consent_forms\")\n}\n\nmodel DailyAuditSignOff {\n  id              String   @id @default(uuid())\n  rnId            String   @map(\"rn_id\")\n  tenantId        String   @map(\"tenant_id\")\n  visitId         String   @unique @map(\"visit_id\")\n  clinicalComment String?  @map(\"clinical_comment\")\n  status          String   @default(\"verified\") // verified, flagged\n  signedAt        DateTime @default(now()) @map(\"signed_at\")\n\n  rn     User   @relation(fields: [rnId], references: [id])\n  tenant Tenant @relation(fields: [tenantId], references: [id])\n  visit  Visit  @relation(fields: [visitId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"daily_audit_signoffs\")\n}\n\nmodel WellnessPulse {\n  id        String   @id @default(uuid())\n  userId    String   @map(\"user_id\")\n  pswId     String?  @map(\"psw_id\")\n  tenantId  String   @map(\"tenant_id\")\n  status    String // great, okay, struggling, burnout\n  score     Int?     @default(5) // 1-10 wellness score\n  note      String?\n  createdAt DateTime @default(now()) @map(\"created_at\")\n\n  user   User   @relation(fields: [userId], references: [id])\n  tenant Tenant @relation(fields: [tenantId], references: [id])\n\n  @@index([pswId])\n  @@index([tenantId])\n  @@map(\"wellness_pulses\")\n}\n\n// ==========================================\n// FINANCIAL ENGINE MODELS (Bank-Level)\n// ==========================================\n\nmodel Invoice {\n  id              String        @id @default(uuid())\n  clientId        String        @map(\"client_id\")\n  status          String?       @default(\"draft\")\n  currency        String?       @default(\"CAD\")\n  subtotal        Decimal?\n  tax             Decimal?\n  total           Decimal?\n  stripeInvoiceId String?       @map(\"stripe_invoice_id\")\n  createdAt       DateTime      @default(now()) @map(\"created_at\")\n  updatedAt       DateTime      @updatedAt @map(\"updated_at\")\n  tenantId        String        @map(\"tenant_id\")\n  client          ClientProfile @relation(fields: [clientId], references: [id])\n  tenant          Tenant        @relation(fields: [tenantId], references: [id])\n  payments        Payment[]\n\n  @@index([tenantId])\n  @@index([tenantId, status])\n  @@map(\"invoices\")\n}\n\nmodel Payment {\n  id                    String   @id @default(uuid())\n  invoiceId             String   @map(\"invoice_id\")\n  stripePaymentIntentId String?  @map(\"stripe_payment_intent_id\")\n  amount                Decimal?\n  status                String?\n  createdAt             DateTime @default(now()) @map(\"created_at\")\n  updatedAt             DateTime @updatedAt @map(\"updated_at\")\n  invoice               Invoice  @relation(fields: [invoiceId], references: [id])\n\n  @@map(\"payments\")\n}\n\nmodel InsuranceProvider {\n  id           String   @id @default(uuid())\n  tenantId     String   @map(\"tenant_id\")\n  name         String\n  networkId    String?  @map(\"network_id\")\n  contactPhone String?  @map(\"contact_phone\")\n  claimsEmail  String?  @map(\"claims_email\")\n  createdAt    DateTime @default(now()) @map(\"created_at\")\n\n  tenant Tenant  @relation(fields: [tenantId], references: [id])\n  claims Claim[]\n\n  @@index([tenantId])\n  @@map(\"insurance_providers\")\n}\n\nmodel Claim {\n  id           String   @id @default(uuid())\n  tenantId     String   @map(\"tenant_id\")\n  patientId    String   @map(\"patient_id\")\n  providerId   String   @map(\"provider_id\") // InsuranceProvider ID\n  serviceDate  DateTime @map(\"service_date\")\n  amount       Float\n  status       String   @default(\"draft\") // draft, submitted, pending, paid, denied\n  denialReason String?  @map(\"denial_reason\")\n  createdAt    DateTime @default(now()) @map(\"created_at\")\n\n  tenant   Tenant            @relation(fields: [tenantId], references: [id])\n  patient  ClientProfile     @relation(fields: [patientId], references: [id])\n  provider InsuranceProvider @relation(fields: [providerId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"claims\")\n}\n\nmodel BillingCode {\n  id          String @id @default(uuid())\n  code        String @unique\n  description String\n  category    String // HCPCS, CPT, ICD-10\n  defaultRate Float  @map(\"default_rate\")\n\n  @@map(\"billing_codes\")\n}\n\nmodel Payout {\n  id          String    @id @default(uuid())\n  pswId       String    @map(\"psw_id\")\n  tenantId    String    @map(\"tenant_id\")\n  amount      Decimal\n  currency    String    @default(\"CAD\")\n  status      String    @default(\"pending\") // pending, paid, failed\n  notes       String?\n  processedAt DateTime? @map(\"processed_at\")\n  createdAt   DateTime  @default(now()) @map(\"created_at\")\n\n  psw    PswProfile @relation(fields: [pswId], references: [id])\n  tenant Tenant     @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"payouts\")\n}\n\nmodel MileageLog {\n  id                  String   @id @default(uuid())\n  pswId               String   @map(\"psw_id\")\n  date                DateTime\n  fromVisitId         String?  @map(\"from_visit_id\")\n  toVisitId           String?  @map(\"to_visit_id\")\n  fromAddress         String?  @map(\"from_address\")\n  toAddress           String?  @map(\"to_address\")\n  distanceKm          Float    @map(\"distance_km\")\n  travelMinutes       Int?     @map(\"travel_minutes\")\n  reimbursementRate   Float    @default(0.70) @map(\"reimbursement_rate\") // CRA 2025 rate\n  reimbursementAmount Float?   @map(\"reimbursement_amount\")\n  status              String   @default(\"pending\") // pending, approved, paid\n  createdAt           DateTime @default(now()) @map(\"created_at\")\n  tenantId            String   @map(\"tenant_id\")\n\n  psw    PswProfile @relation(fields: [pswId], references: [id])\n  tenant Tenant     @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@index([pswId])\n  @@map(\"mileage_logs\")\n}\n\nmodel ChartOfAccount {\n  id        String   @id @default(uuid())\n  code      String // e.g., '1000', '2000'\n  name      String // e.g., 'Cash', 'Accounts Receivable'\n  type      String\n  status    String   @default(\"active\")\n  tenantId  String   @map(\"tenant_id\")\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  updatedAt DateTime @updatedAt @map(\"updated_at\")\n\n  tenant         Tenant         @relation(fields: [tenantId], references: [id])\n  journalEntries JournalEntry[]\n\n  @@unique([tenantId, code])\n  @@index([tenantId])\n  @@map(\"financial_accounts\")\n}\n\nmodel FinancialTransaction {\n  id          String   @id @default(uuid())\n  type        String // INVOICE, PAYMENT, PAYROLL, EXPENSE\n  referenceId String?  @map(\"reference_id\") // ID of linked document\n  amount      Decimal\n  currency    String   @default(\"CAD\")\n  status      String   @default(\"draft\")\n  tenantId    String   @map(\"tenant_id\")\n  createdAt   DateTime @default(now()) @map(\"created_at\")\n  updatedAt   DateTime @updatedAt @map(\"updated_at\")\n\n  tenant          Tenant                    @relation(fields: [tenantId], references: [id])\n  journalEntries  JournalEntry[]\n  reconciliations FinancialReconciliation[]\n\n  @@index([tenantId])\n  @@index([referenceId])\n  @@map(\"financial_transactions\")\n}\n\nmodel JournalEntry {\n  id            String   @id @default(uuid())\n  transactionId String   @map(\"transaction_id\")\n  accountId     String   @map(\"account_id\")\n  debit         Decimal  @default(0)\n  paidOutAmount Decimal? @map(\"paid_out_amount\")\n  currency      String   @default(\"CAD\")\n  balanceBefore Decimal  @default(0) @map(\"balance_before\")\n  balanceAfter  Decimal  @default(0) @map(\"balance_after\")\n  tenantId      String   @map(\"tenant_id\")\n  createdAt     DateTime @default(now()) @map(\"created_at\")\n\n  transaction FinancialTransaction @relation(fields: [transactionId], references: [id])\n  account     ChartOfAccount       @relation(fields: [accountId], references: [id])\n  tenant      Tenant               @relation(fields: [tenantId], references: [id])\n\n  @@index([transactionId])\n  @@index([accountId])\n  @@index([tenantId])\n  @@map(\"financial_journal_entries\")\n}\n\nmodel FinancialReconciliation {\n  id                String    @id @default(uuid())\n  transactionId     String    @map(\"transaction_id\")\n  bankTransactionId String?   @map(\"bank_transaction_id\")\n  status            String    @default(\"pending\") // pending, matched, reconciled\n  matchedAt         DateTime? @map(\"matched_at\")\n  tenantId          String    @map(\"tenant_id\")\n\n  transaction     FinancialTransaction @relation(fields: [transactionId], references: [id])\n  bankTransaction BankTransaction?     @relation(fields: [bankTransactionId], references: [id])\n  tenant          Tenant               @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"financial_reconciliations\")\n}\n\nmodel BankTransaction {\n  id          String   @id @default(uuid())\n  bankDate    DateTime @map(\"bank_date\")\n  description String\n  amount      Decimal\n  currency    String   @default(\"CAD\")\n  externalRef String?  @map(\"external_ref\")\n  status      String   @default(\"unreconciled\") // unreconciled, reconciled, ignored\n  tenantId    String   @map(\"tenant_id\")\n  createdAt   DateTime @default(now()) @map(\"created_at\")\n\n  tenant          Tenant                    @relation(fields: [tenantId], references: [id])\n  reconciliations FinancialReconciliation[]\n\n  @@index([tenantId])\n  @@map(\"financial_bank_transactions\")\n}\n\n// ─── Immutable Transaction Ledger ─────────────────────────────────────\n// Append-only financial entries with SHA-256 hash chaining.\n// NO updatedAt — records are NEVER modified. Corrections are reversal entries.\nmodel TransactionLedger {\n  id               String   @id @default(uuid())\n  tenantId         String   @map(\"tenant_id\")\n  transactionType  String   @map(\"transaction_type\") // PAYMENT, REFUND, ADJUSTMENT, REVERSAL, PAYOUT\n  referenceType    String   @map(\"reference_type\") // Invoice, Payout, Claim\n  referenceId      String   @map(\"reference_id\")\n  debitAccount     String   @map(\"debit_account\") // e.g. \"accounts_receivable\", \"cash\"\n  creditAccount    String   @map(\"credit_account\") // e.g. \"revenue\", \"refund_payable\"\n  amount           Decimal\n  currency         String   @default(\"CAD\")\n  description      String?\n  actorUserId      String?  @map(\"actor_user_id\")\n  ipAddress        String?  @map(\"ip_address\")\n  checksum         String   @default(\"\") // SHA-256 of this entry\n  previousChecksum String?  @map(\"previous_checksum\") // SHA-256 of previous entry\n  status           String   @default(\"sealed\") // sealed = immutable, voided = reversed by another entry\n  voidedByEntryId  String?  @map(\"voided_by_entry_id\") // links to the reversal entry\n  createdAt        DateTime @default(now()) @map(\"created_at\")\n  // NO updatedAt — records are immutable\n\n  tenant Tenant @relation(fields: [tenantId], references: [id])\n  actor  User?  @relation(\"LedgerActor\", fields: [actorUserId], references: [id])\n\n  @@index([tenantId])\n  @@index([referenceType, referenceId])\n  @@index([createdAt])\n  @@map(\"transaction_ledger\")\n}\n\n// ==========================================\n// EXTENSION MODULES\n// ==========================================\n\nmodel BlogPost {\n  id                String    @id @default(uuid())\n  title             String\n  slug              String    @unique\n  excerpt           String?\n  contentHtml       String?   @map(\"content_html\")\n  status            String?   @default(\"draft\")\n  publishedAt       DateTime? @map(\"published_at\")\n  authorUserId      String?   @map(\"author_user_id\")\n  featureImageDocId String?   @map(\"feature_image_doc_id\")\n  seoTitle          String?   @map(\"seo_title\")\n  seoDescription    String?   @map(\"seo_description\")\n  canonicalUrl      String?   @map(\"canonical_url\")\n  createdAt         DateTime  @default(now()) @map(\"created_at\")\n  updatedAt         DateTime  @updatedAt @map(\"updated_at\")\n  author            User?     @relation(fields: [authorUserId], references: [id])\n  targetRole        String?   @map(\"target_role\")\n  category          String?   @default(\"announcement\")\n\n  @@map(\"blog_posts\")\n}\n\nmodel Feedback {\n  id        String        @id @default(uuid())\n  clientId  String        @map(\"client_id\")\n  visitId   String?       @map(\"visit_id\")\n  rating    Int\n  comment   String?\n  status    String?       @default(\"pending\") // pending, reviewed, archived\n  createdAt DateTime      @default(now()) @map(\"created_at\")\n  updatedAt DateTime      @updatedAt @map(\"updated_at\")\n  tenantId  String        @map(\"tenant_id\")\n  client    ClientProfile @relation(fields: [clientId], references: [id])\n  tenant    Tenant        @relation(fields: [tenantId], references: [id])\n  visit     Visit?        @relation(fields: [visitId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"feedbacks\")\n}\n\nmodel TrainingModule {\n  id          String               @id @default(uuid())\n  title       String\n  description String?\n  category    String?\n  videoUrl    String?              @map(\"video_url\")\n  createdAt   DateTime             @default(now()) @map(\"created_at\")\n  updatedAt   DateTime             @updatedAt @map(\"updated_at\")\n  tenantId    String               @map(\"tenant_id\")\n  tenant      Tenant               @relation(fields: [tenantId], references: [id])\n  assignments TrainingAssignment[]\n\n  @@index([tenantId])\n  @@map(\"training_modules\")\n}\n\nmodel TrainingAssignment {\n  id          String         @id @default(uuid())\n  pswId       String?        @map(\"psw_id\")\n  staffId     String?        @map(\"staff_id\")\n  moduleId    String         @map(\"module_id\")\n  status      String         @default(\"assigned\") // assigned, completed\n  completedAt DateTime?      @map(\"completed_at\")\n  assignedAt  DateTime       @default(now()) @map(\"assigned_at\")\n  dueDate     DateTime?      @map(\"due_date\")\n  module      TrainingModule @relation(fields: [moduleId], references: [id])\n\n  @@map(\"training_assignments\")\n}\n\nmodel Survey {\n  id         String           @id @default(uuid())\n  title      String\n  targetRole String?          @map(\"target_role\")\n  questions  Json             @map(\"questions_json\")\n  isActive   Boolean          @default(true) @map(\"is_active\")\n  createdAt  DateTime         @default(now()) @map(\"created_at\")\n  tenantId   String           @map(\"tenant_id\")\n  tenant     Tenant           @relation(fields: [tenantId], references: [id])\n  responses  SurveyResponse[]\n\n  @@index([tenantId])\n  @@map(\"surveys\")\n}\n\nmodel SurveyResponse {\n  id        String   @id @default(uuid())\n  surveyId  String   @map(\"survey_id\")\n  userId    String   @map(\"user_id\")\n  answers   Json     @map(\"answers_json\")\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  survey    Survey   @relation(fields: [surveyId], references: [id])\n\n  @@map(\"survey_responses\")\n}\n\nmodel Region {\n  id        String           @id @default(uuid())\n  name      String           @unique\n  city      String\n  province  String\n  boundary  String?          @map(\"boundary_json\")\n  status    String           @default(\"active\")\n  createdAt DateTime         @default(now()) @map(\"created_at\")\n  tenantId  String           @map(\"tenant_id\")\n  tenant    Tenant           @relation(fields: [tenantId], references: [id])\n  stats     BranchCapacity[]\n\n  @@index([tenantId])\n  @@map(\"regions\")\n}\n\nmodel BranchCapacity {\n  id              String   @id @default(uuid())\n  regionId        String   @map(\"region_id\")\n  totalStaff      Int      @default(0) @map(\"total_staff\")\n  availableStaff  Int      @default(0) @map(\"available_staff\")\n  activeVisits    Int      @default(0) @map(\"active_visits\")\n  pendingBookings Int      @default(0) @map(\"pending_bookings\")\n  utilizationRate Float?   @map(\"utilization_rate\")\n  timestamp       DateTime @default(now())\n  region          Region   @relation(fields: [regionId], references: [id])\n\n  @@map(\"branch_capacity\")\n}\n\nmodel BranchStat {\n  id              String   @id @default(uuid())\n  date            DateTime @default(now())\n  utilization     Float\n  revenue         Float\n  churnRate       Float    @map(\"churn_rate\")\n  activeClients   Int      @map(\"active_clients\")\n  activeProviders Int      @map(\"active_providers\")\n  tenantId        String   @map(\"tenant_id\")\n  tenant          Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"branch_stats\")\n}\n\nmodel ComplianceRecord {\n  id         String   @id @default(uuid())\n  type       String // e.g., \"document_audit\", \"training_completion\"\n  status     String   @default(\"pending\") // pending, compliant, non_compliant\n  score      Float?\n  notes      String?\n  lastSyncAt DateTime @default(now()) @map(\"last_sync_at\")\n  tenantId   String   @map(\"tenant_id\")\n  tenant     Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"compliance_records\")\n}\n\nmodel Franchise {\n  id          String   @id @default(uuid())\n  name        String\n  resellerId  String   @map(\"reseller_id\") // The tenant that acts as reseller\n  ownerUserId String   @map(\"owner_user_id\")\n  status      String   @default(\"active\") // active, suspended, terminated\n  createdAt   DateTime @default(now()) @map(\"created_at\")\n  updatedAt   DateTime @updatedAt @map(\"updated_at\")\n\n  reseller   Tenant              @relation(\"ResellerTenants\", fields: [resellerId], references: [id])\n  agreements ResellerAgreement[]\n  clients    ClientProfile[]\n\n  @@map(\"franchises\")\n}\n\nmodel ResellerAgreement {\n  id            String    @id @default(uuid())\n  franchiseId   String    @map(\"franchise_id\")\n  terms         String\n  feePercentage Float     @map(\"fee_percentage\")\n  startDate     DateTime  @map(\"start_date\")\n  endDate       DateTime? @map(\"end_date\")\n  status        String    @default(\"active\")\n\n  franchise Franchise @relation(fields: [franchiseId], references: [id])\n\n  @@map(\"reseller_agreements\")\n}\n\nmodel Supplier {\n  id             String          @id @default(uuid())\n  name           String\n  contactName    String?         @map(\"contact_name\")\n  email          String?\n  phone          String?\n  category       String // MEDICAL_DEVICES, CONSUMABLES, PHARMACEUTICALS\n  status         String          @default(\"active\")\n  createdAt      DateTime        @default(now()) @map(\"created_at\")\n  purchaseOrders PurchaseOrder[]\n\n  @@map(\"suppliers\")\n}\n\nmodel InventoryItem {\n  id              String         @id @default(uuid())\n  name            String\n  sku             String         @unique\n  category        String\n  quantity        Int            @default(0)\n  reorderPoint    Int            @default(10) @map(\"reorder_point\")\n  unitPrice       Float          @map(\"unit_price\")\n  tenantId        String         @map(\"tenant_id\")\n  createdAt       DateTime       @default(now()) @map(\"created_at\")\n  updatedAt       DateTime       @updatedAt @map(\"updated_at\")\n  tenant          Tenant         @relation(fields: [tenantId], references: [id])\n  ClientProfile   ClientProfile? @relation(fields: [clientProfileId], references: [id])\n  clientProfileId String?\n\n  @@index([tenantId])\n  @@map(\"inventory_items\")\n}\n\nmodel PurchaseOrder {\n  id              String         @id @default(uuid())\n  poNumber        String         @unique @map(\"po_number\")\n  supplierId      String         @map(\"supplier_id\")\n  tenantId        String         @map(\"tenant_id\")\n  totalAmount     Float          @map(\"total_amount\")\n  status          String         @default(\"draft\") // draft, sent, received, cancelled\n  createdAt       DateTime       @default(now()) @map(\"created_at\")\n  supplier        Supplier       @relation(fields: [supplierId], references: [id])\n  tenant          Tenant         @relation(fields: [tenantId], references: [id])\n  ClientProfile   ClientProfile? @relation(fields: [clientProfileId], references: [id])\n  clientProfileId String?\n\n  @@index([tenantId])\n  @@map(\"purchase_orders\")\n}\n\nmodel TelehealthSession {\n  id          String    @id @default(uuid())\n  tenantId    String    @map(\"tenant_id\")\n  patientId   String    @map(\"patient_id\") // ClientProfile ID\n  providerId  String    @map(\"provider_id\") // User ID (RN, PSW, etc.)\n  startTime   DateTime  @map(\"start_time\")\n  endTime     DateTime? @map(\"end_time\")\n  meetingLink String?   @map(\"meeting_link\")\n  status      String    @default(\"scheduled\") // scheduled, in-progress, completed, cancelled\n  createdAt   DateTime  @default(now()) @map(\"created_at\")\n\n  tenant   Tenant        @relation(fields: [tenantId], references: [id])\n  patient  ClientProfile @relation(fields: [patientId], references: [id])\n  provider User          @relation(fields: [providerId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"telehealth_sessions\")\n}\n\nmodel MarketplaceListing {\n  id          String   @id @default(uuid())\n  title       String\n  description String\n  total       Decimal\n  category    String\n  providerId  String   @map(\"provider_id\")\n  tenantId    String?  @map(\"tenant_id\")\n  createdAt   DateTime @default(now()) @map(\"created_at\")\n  updatedAt   DateTime @updatedAt @map(\"updated_at\")\n  tenant      Tenant?  @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"marketplace_listings\")\n}\n\nmodel TenantSLA {\n  id                 String   @id @default(uuid())\n  uptimeTarget       Float    @default(99.9) @map(\"uptime_target\")\n  responseTimeTarget Int      @default(500) @map(\"response_time_target\") // ms\n  supportTier        String   @default(\"STANDARD\") @map(\"support_tier\") // BRONZE, SILVER, GOLD, PLATINUM\n  status             String   @default(\"compliant\")\n  lastAuditAt        DateTime @default(now()) @map(\"last_audit_at\")\n  tenantId           String   @unique @map(\"tenant_id\")\n  tenant             Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@map(\"tenant_slas\")\n}\n\nmodel AIRecommendation {\n  id        String   @id @default(uuid())\n  type      String // e.g., 'Staffing', 'Clinical', 'Financial'\n  priority  String // LOW, MEDIUM, HIGH, CRITICAL\n  content   String\n  isApplied Boolean  @default(false) @map(\"is_applied\")\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  tenantId  String   @map(\"tenant_id\")\n  tenant    Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"ai_recommendations\")\n}\n\nmodel SentimentAnalysis {\n  id        String   @id @default(uuid())\n  source    String // 'VisitNote', 'SupportChat', 'Survey'\n  sourceId  String   @map(\"source_id\")\n  score     Float // -1.0 to 1.0\n  magnitude Float\n  entities  String?\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  tenantId  String   @map(\"tenant_id\")\n  tenant    Tenant   @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"sentiment_analysis\")\n}\n\nmodel SecurityThreat {\n  id          String    @id @default(uuid())\n  type        String // e.g., 'BRUTE_FORCE', 'SQL_INJECTION', 'ANOMALOUS_LOGON'\n  severity    String // LOW, MEDIUM, HIGH, CRITICAL\n  status      String    @default(\"detected\") // detected, mitigating, resolved\n  description String\n  source      String? // IP address or user ID\n  detectedAt  DateTime  @default(now()) @map(\"detected_at\")\n  resolvedAt  DateTime? @map(\"resolved_at\")\n  tenantId    String    @map(\"tenant_id\")\n  tenant      Tenant    @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"security_threats\")\n}\n\nmodel TechnicalAudit {\n  id            String   @id @default(uuid())\n  type          String   @map(\"audit_type\") // LINK_REGISTRY, BUTTON_REGISTRY, etc.\n  status        String   @default(\"success\")\n  summary       String\n  issuesCount   Int      @default(0) @map(\"issues_count\")\n  details       String?\n  performedById String?  @map(\"performed_by_id\")\n  performedAt   DateTime @default(now()) @map(\"performed_at\")\n  tenantId      String?  @map(\"tenant_id\")\n\n  performedBy User?   @relation(\"PerformedAudits\", fields: [performedById], references: [id])\n  tenant      Tenant? @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"technical_audits\")\n}\n\nmodel FamilyNotification {\n  id        String        @id @default(uuid())\n  clientId  String        @map(\"client_id\")\n  type      String // VISIT_STARTED, ALERT, BILLING\n  message   String\n  isRead    Boolean       @default(false) @map(\"is_read\")\n  createdAt DateTime      @default(now()) @map(\"created_at\")\n  client    ClientProfile @relation(fields: [clientId], references: [id])\n  tenantId  String        @map(\"tenant_id\")\n  tenant    Tenant        @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"family_notifications\")\n}\n\nmodel CareFeedback {\n  id              String        @id @default(uuid())\n  clientId        String        @map(\"client_id\")\n  visitId         String        @map(\"visit_id\")\n  rating          Int\n  comment         String?\n  triageStatus    String        @default(\"pending\") @map(\"triage_status\")\n  resolutionNotes String?       @map(\"resolution_notes\")\n  createdAt       DateTime      @default(now()) @map(\"created_at\")\n  client          ClientProfile @relation(fields: [clientId], references: [id])\n  visit           Visit         @relation(fields: [visitId], references: [id])\n  tenantId        String        @map(\"tenant_id\")\n  tenant          Tenant        @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"care_feedbacks\")\n}\n\nmodel Referral {\n  id                String    @id @default(uuid())\n  clientName        String    @map(\"client_name\")\n  clientPhone       String?   @map(\"client_phone\")\n  clientEmail       String?   @map(\"client_email\")\n  referrerName      String    @map(\"referrer_name\")\n  referrerOrg       String?   @map(\"referrer_org\") // hospital, LHIN, CCAC, physician\n  referrerType      String    @default(\"external\") @map(\"referrer_type\") // internal, external, self\n  serviceNeeded     String?   @map(\"service_needed\")\n  urgency           String    @default(\"routine\") // routine, urgent, emergent\n  clinicalNotes     String?   @map(\"clinical_notes\")\n  status            String    @default(\"pending\") // pending, accepted, waitlisted, converted, declined\n  convertedClientId String?   @map(\"converted_client_id\")\n  convertedAt       DateTime? @map(\"converted_at\")\n  createdAt         DateTime  @default(now()) @map(\"created_at\")\n  updatedAt         DateTime  @updatedAt @map(\"updated_at\")\n  tenantId          String    @map(\"tenant_id\")\n\n  tenant Tenant @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@index([status])\n  @@map(\"referrals\")\n}\n\nmodel FamilyMember {\n  id           String   @id @default(uuid())\n  clientId     String   @map(\"client_id\")\n  name         String\n  email        String?\n  phone        String?\n  relationship String // spouse, child, sibling, parent, guardian, other\n  accessLevel  String   @default(\"view_only\") @map(\"access_level\") // view_only, care_updates, full\n  linkedUserId String?  @map(\"linked_user_id\") // optional link to User account\n  isEmergency  Boolean  @default(false) @map(\"is_emergency\")\n  notifyVisits Boolean  @default(true) @map(\"notify_visits\")\n  notifyCare   Boolean  @default(true) @map(\"notify_care\")\n  createdAt    DateTime @default(now()) @map(\"created_at\")\n  updatedAt    DateTime @updatedAt @map(\"updated_at\")\n  tenantId     String   @map(\"tenant_id\")\n\n  client ClientProfile @relation(fields: [clientId], references: [id])\n  tenant Tenant        @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@index([clientId])\n  @@map(\"family_members\")\n}\n\nmodel PerformanceReview {\n  id             String    @id @default(uuid())\n  pswId          String    @map(\"psw_id\")\n  reviewerId     String    @map(\"reviewer_id\")\n  periodStart    DateTime  @map(\"period_start\")\n  periodEnd      DateTime  @map(\"period_end\")\n  overallRating  Float?    @map(\"overall_rating\") // 1.0 - 5.0\n  kpis           String? // { onTimeRate, satisfactionScore, incidentRate, completionRate }\n  goals          String? // [{ description, status, dueDate }]\n  strengths      String?\n  improvements   String?\n  notes          String?\n  status         String    @default(\"draft\") // draft, submitted, acknowledged\n  acknowledgedAt DateTime? @map(\"acknowledged_at\")\n  createdAt      DateTime  @default(now()) @map(\"created_at\")\n  updatedAt      DateTime  @updatedAt @map(\"updated_at\")\n  tenantId       String    @map(\"tenant_id\")\n\n  psw      PswProfile @relation(fields: [pswId], references: [id])\n  reviewer User       @relation(\"ReviewAuthor\", fields: [reviewerId], references: [id])\n  tenant   Tenant     @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@index([pswId])\n  @@map(\"performance_reviews\")\n}\n\nmodel WebhookEndpoint {\n  id              String    @id @default(uuid())\n  url             String\n  events          String // visit.completed, incident.created, invoice.paid, etc.\n  secret          String // HMAC signing secret\n  status          String    @default(\"active\") // active, paused, disabled\n  lastDeliveredAt DateTime? @map(\"last_delivered_at\")\n  failureCount    Int       @default(0) @map(\"failure_count\")\n  createdAt       DateTime  @default(now()) @map(\"created_at\")\n  updatedAt       DateTime  @updatedAt @map(\"updated_at\")\n  tenantId        String    @map(\"tenant_id\")\n\n  deliveries WebhookDelivery[]\n  tenant     Tenant            @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"webhook_endpoints\")\n}\n\nmodel WebhookDelivery {\n  id           String   @id @default(uuid())\n  endpointId   String   @map(\"endpoint_id\")\n  event        String // e.g., visit.completed\n  payload      String\n  statusCode   Int?     @map(\"status_code\")\n  responseBody String?  @map(\"response_body\")\n  retryCount   Int      @default(0) @map(\"retry_count\")\n  deliveredAt  DateTime @default(now()) @map(\"delivered_at\")\n\n  endpoint WebhookEndpoint @relation(fields: [endpointId], references: [id])\n\n  @@index([endpointId])\n  @@map(\"webhook_deliveries\")\n}\n\nmodel IoTEvent {\n  id         String   @id @default(uuid())\n  deviceId   String   @map(\"device_id\")\n  deviceType String   @map(\"device_type\")\n  payload    String\n  status     String   @default(\"processed\")\n  userId     String?  @map(\"user_id\")\n  tenantId   String?  @map(\"tenant_id\")\n  createdAt  DateTime @default(now()) @map(\"created_at\")\n\n  tenant Tenant? @relation(fields: [tenantId], references: [id])\n  user   User?   @relation(fields: [userId], references: [id])\n\n  @@index([tenantId])\n  @@index([deviceId])\n  @@map(\"iot_events\")\n}\n\nmodel AppNotification {\n  id        String   @id @default(uuid())\n  userId    String   @map(\"user_id\")\n  title     String\n  message   String\n  type      String   @default(\"info\") // info, warning, success, error\n  isRead    Boolean  @default(false) @map(\"is_read\")\n  link      String?\n  tenantId  String?  @map(\"tenant_id\")\n  createdAt DateTime @default(now()) @map(\"created_at\")\n\n  tenant Tenant? @relation(fields: [tenantId], references: [id])\n  user   User    @relation(fields: [userId], references: [id])\n\n  @@index([tenantId])\n  @@index([userId])\n  @@map(\"app_notifications\")\n}\n\nmodel GamificationProfile {\n  id             String   @id @default(uuid())\n  userId         String   @unique @map(\"user_id\")\n  careCoins      Int      @default(0) @map(\"care_coins\")\n  currentTier    String   @default(\"Bronze\") @map(\"current_tier\")\n  lifetimePoints Int      @default(0) @map(\"lifetime_points\")\n  tenantId       String?  @map(\"tenant_id\")\n  updatedAt      DateTime @updatedAt @map(\"updated_at\")\n\n  tenant Tenant? @relation(fields: [tenantId], references: [id])\n  user   User    @relation(fields: [userId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"gamification_profiles\")\n}\n\nmodel AIInference {\n  id              String   @id @default(uuid())\n  modelName       String   @map(\"model_name\") // e.g., lead_scorer, no_show_predictor\n  targetId        String   @map(\"target_id\") // e.g., leadId, visitId\n  targetType      String   @map(\"target_type\")\n  confidenceScore Float    @map(\"confidence_score\")\n  predictionData  String   @map(\"prediction_data_json\") // JSON string of the inference result\n  tenantId        String?  @map(\"tenant_id\")\n  createdAt       DateTime @default(now()) @map(\"created_at\")\n\n  tenant Tenant? @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@index([targetId, targetType])\n  @@map(\"ai_inferences\")\n}\n\nmodel CommunicationLog {\n  id         String   @id @default(uuid())\n  direction  String   @default(\"outbound\") // inbound, outbound\n  channel    String // sms, email, voice, social\n  recipient  String?\n  sender     String?\n  subject    String?\n  bodyText   String?  @map(\"body_text\")\n  status     String   @default(\"sent\") // queued, sent, failed, delivered\n  externalId String?  @map(\"external_id\") // Twilio SID, SendGrid ID\n  tenantId   String?  @map(\"tenant_id\")\n  createdAt  DateTime @default(now()) @map(\"created_at\")\n\n  tenant Tenant? @relation(fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"communication_logs\")\n}\n\nmodel DailyActivity {\n  id          String   @id @default(uuid())\n  tenantId    String   @map(\"tenant_id\")\n  userId      String   @map(\"user_id\")\n  role        String\n  title       String\n  description String\n  status      String   @default(\"PENDING\")\n  dueDate     DateTime @map(\"due_date\")\n  createdAt   DateTime @default(now()) @map(\"created_at\")\n  updatedAt   DateTime @updatedAt @map(\"updated_at\")\n\n  tenant Tenant @relation(fields: [tenantId], references: [id])\n  user   User   @relation(fields: [userId], references: [id])\n\n  @@index([tenantId])\n  @@index([userId])\n  @@index([role])\n  @@map(\"daily_activities\")\n}\n\n// ==========================================\n// TRACKING MATRIX MODULE\n// ==========================================\n\nmodel PlatformScreen {\n  id          String  @id @default(uuid())\n  roleId      String  @map(\"role_id\")\n  name        String // e.g., \"PSW Live Visit\"\n  route       String // e.g., \"/psw/live-visit/:id\"\n  status      String  @default(\"pending\") // pending, in-progress, completed\n  description String? @db.Text\n  orderIndex  Int     @default(0) @map(\"order_index\")\n\n  role      PlatformRole          @relation(fields: [roleId], references: [id])\n  functions ScreenFunctionality[]\n\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  updatedAt DateTime @updatedAt @map(\"updated_at\")\n\n  @@index([roleId])\n  @@map(\"platform_screens\")\n}\n\nmodel ScreenFunctionality {\n  id              String  @id @default(uuid())\n  screenId        String  @map(\"screen_id\")\n  title           String // e.g., \"Submit GPS EVV Data\"\n  isCore          Boolean @default(true) @map(\"is_core\")\n  status          String  @default(\"unimplemented\") // unimplemented, wired_to_api, fully_tested\n  apiEndpoint     String? @map(\"api_endpoint\") // e.g., \"POST /v1/activities/evv\"\n  dataEntryFields String? @map(\"data_entry_fields\") // e.g., \"lat, lng, photoId\"\n  justification   String? @db.Text // Why is this feature enough? (MVP logic)\n  notes           String?\n  orderIndex      Int     @default(0) @map(\"order_index\")\n\n  screen PlatformScreen @relation(fields: [screenId], references: [id], onDelete: Cascade)\n\n  createdAt DateTime @default(now()) @map(\"created_at\")\n  updatedAt DateTime @updatedAt @map(\"updated_at\")\n\n  @@index([screenId])\n  @@map(\"screen_functionalities\")\n}\n\n// ==========================================\n// 09_PSW_FORMS (13-Form Clinical Standard)\n// ==========================================\n\n// 1. Shift Check-In / Check-Out Form\nmodel PswShiftLog {\n  id           String    @id @default(uuid())\n  pswId        String    @map(\"psw_id\")\n  clientId     String    @map(\"client_id\")\n  tenantId     String    @map(\"tenant_id\")\n  date         DateTime  @default(now())\n  startTime    DateTime  @map(\"start_time\")\n  endTime      DateTime? @map(\"end_time\")\n  gpsLat       Float?    @map(\"gps_lat\")\n  gpsLng       Float?    @map(\"gps_lng\")\n  shiftStatus  String    @default(\"STARTED\") // STARTED, COMPLETED, MISSED\n  signatureUrl String?   @map(\"signature_url\")\n\n  psw    User          @relation(\"UserShiftLogs\", fields: [pswId], references: [id])\n  client ClientProfile @relation(\"ClientShiftLogs\", fields: [clientId], references: [id])\n  tenant Tenant        @relation(\"TenantShiftLogs\", fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@index([clientId])\n  @@map(\"psw_shift_logs\")\n}\n\n// 2. Client Daily Care Log (ADL Record)\nmodel AdlCareLog {\n  id       String @id @default(uuid())\n  pswId    String @map(\"psw_id\")\n  clientId String @map(\"client_id\")\n  tenantId String @map(\"tenant_id\")\n\n  hygiene     String? // Bathing / Grooming / Oral care\n  dressing    String? // Assistance level\n  toileting   String? // Assistance level\n  mobility    String? // Walk / Transfer / Bed mobility\n  feeding     String? // Meal support / % eaten\n  fluidIntake Int?    @map(\"fluid_intake_ml\")\n  sleepStatus String? @map(\"sleep_status\")\n  notes       String?\n\n  createdAt DateTime @default(now()) @map(\"created_at\")\n\n  psw    User          @relation(\"UserAdlLogs\", fields: [pswId], references: [id])\n  client ClientProfile @relation(\"ClientAdlLogs\", fields: [clientId], references: [id])\n  tenant Tenant        @relation(\"TenantAdlLogs\", fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"adl_care_logs\")\n}\n\n// 3. Vital Signs & Health Monitoring (Dedicated PSW schema)\nmodel PswVitalSign {\n  id       String @id @default(uuid())\n  pswId    String @map(\"psw_id\")\n  clientId String @map(\"client_id\")\n  tenantId String @map(\"tenant_id\")\n\n  temperature   Float?\n  pulse         Int?\n  respiration   Int?\n  bloodPressure String? @map(\"blood_pressure\") // e.g. \"120/80\"\n  spO2          Int?    @map(\"sp_o2\")\n  painLevel     Int?    @map(\"pain_level\") // 0-10\n\n  recordedAt DateTime @default(now()) @map(\"recorded_at\")\n\n  psw    User          @relation(\"UserPswVitals\", fields: [pswId], references: [id])\n  client ClientProfile @relation(\"ClientPswVitals\", fields: [clientId], references: [id])\n  tenant Tenant        @relation(\"TenantPswVitals\", fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"psw_vital_signs\")\n}\n\n// 6. Behavior & Mental Status Notes\nmodel BehaviorNote {\n  id       String @id @default(uuid())\n  pswId    String @map(\"psw_id\")\n  clientId String @map(\"client_id\")\n  tenantId String @map(\"tenant_id\")\n\n  mood            String? // Calm / Agitated / Confused\n  orientation     String? // Person / Place / Time\n  behaviorChanges String? @map(\"behavior_changes\")\n  communication   String? // Communication ability\n\n  recordedAt DateTime @default(now()) @map(\"recorded_at\")\n\n  psw    User          @relation(\"UserBehaviorNotes\", fields: [pswId], references: [id])\n  client ClientProfile @relation(\"ClientBehaviorNotes\", fields: [clientId], references: [id])\n  tenant Tenant        @relation(\"TenantBehaviorNotes\", fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"behavior_notes\")\n}\n\n// 7. Nutrition & Hydration Record\nmodel NutritionRecord {\n  id       String @id @default(uuid())\n  pswId    String @map(\"psw_id\")\n  clientId String @map(\"client_id\")\n  tenantId String @map(\"tenant_id\")\n\n  mealsTakenPct Int?    @map(\"meals_taken_pct\")\n  snacks        String?\n  fluidIntakeMl Int?    @map(\"fluid_intake_ml\")\n  appetiteLevel String? @map(\"appetite_level\")\n\n  recordedAt DateTime @default(now()) @map(\"recorded_at\")\n\n  psw    User          @relation(\"UserNutrition\", fields: [pswId], references: [id])\n  client ClientProfile @relation(\"ClientNutrition\", fields: [clientId], references: [id])\n  tenant Tenant        @relation(\"TenantNutrition\", fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"nutrition_records\")\n}\n\n// 8. Mobility & Exercise Log\nmodel MobilityLog {\n  id       String @id @default(uuid())\n  pswId    String @map(\"psw_id\")\n  clientId String @map(\"client_id\")\n  tenantId String @map(\"tenant_id\")\n\n  movementType    String? @map(\"movement_type\") // Walk / Transfer / Exercise\n  distanceOrDur   String? @map(\"distance_or_duration\")\n  assistanceLevel String? @map(\"assistance_level\") // Independent / Assist / Full support\n  painDuring      Boolean @default(false) @map(\"pain_during_movement\")\n\n  recordedAt DateTime @default(now()) @map(\"recorded_at\")\n\n  psw    User          @relation(\"UserMobility\", fields: [pswId], references: [id])\n  client ClientProfile @relation(\"ClientMobility\", fields: [clientId], references: [id])\n  tenant Tenant        @relation(\"TenantMobility\", fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"mobility_logs\")\n}\n\n// 9. Infection Control Checklist\nmodel InfectionControlChecklist {\n  id       String @id @default(uuid())\n  pswId    String @map(\"psw_id\")\n  clientId String @map(\"client_id\")\n  tenantId String @map(\"tenant_id\")\n\n  handHygieneDone  Boolean @default(false) @map(\"hand_hygiene_done\")\n  ppeUsed          Boolean @default(false) @map(\"ppe_used\")\n  equipmentCleaned Boolean @default(false) @map(\"equipment_cleaned\")\n  wasteDisposed    Boolean @default(false) @map(\"waste_disposed\")\n\n  recordedAt DateTime @default(now()) @map(\"recorded_at\")\n\n  psw    User          @relation(\"UserInfectionControl\", fields: [pswId], references: [id])\n  client ClientProfile @relation(\"ClientInfectionControl\", fields: [clientId], references: [id])\n  tenant Tenant        @relation(\"TenantInfectionControl\", fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"infection_control_checklists\")\n}\n\n// 10. Progress Notes (Narrative)\nmodel NarrativeProgressNote {\n  id       String @id @default(uuid())\n  pswId    String @map(\"psw_id\")\n  clientId String @map(\"client_id\")\n  tenantId String @map(\"tenant_id\")\n\n  whatWasDone     String  @map(\"what_was_done\") @db.Text\n  clientResponse  String  @map(\"client_response\") @db.Text\n  changesObserved String? @map(\"changes_observed\") @db.Text\n  planForNext     String? @map(\"plan_for_next_visit\") @db.Text\n\n  recordedAt DateTime @default(now()) @map(\"recorded_at\")\n\n  psw    User          @relation(\"UserNarrativeNotes\", fields: [pswId], references: [id])\n  client ClientProfile @relation(\"ClientNarrativeNotes\", fields: [clientId], references: [id])\n  tenant Tenant        @relation(\"TenantNarrativeNotes\", fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"narrative_progress_notes\")\n}\n\n// 11. Care Plan Follow-Up Form\nmodel CarePlanFollowUp {\n  id       String @id @default(uuid())\n  pswId    String @map(\"psw_id\")\n  clientId String @map(\"client_id\")\n  tenantId String @map(\"tenant_id\")\n\n  tasksAssigned  String? @map(\"tasks_assigned\") @db.Text\n  tasksCompleted String? @map(\"tasks_completed\") @db.Text\n  notCompleted   String? @map(\"tasks_not_completed\") @db.Text\n  reasonNotDone  String? @map(\"reason_not_completed\") @db.Text\n\n  recordedAt DateTime @default(now()) @map(\"recorded_at\")\n\n  psw    User          @relation(\"UserCarePlanFollowUp\", fields: [pswId], references: [id])\n  client ClientProfile @relation(\"ClientCarePlanFollowUp\", fields: [clientId], references: [id])\n  tenant Tenant        @relation(\"TenantCarePlanFollowUp\", fields: [tenantId], references: [id])\n\n  @@index([tenantId])\n  @@map(\"care_plan_follow_ups\")\n}\n\nmodel Clinic {\n  id              String    @id @default(uuid())\n  name            String\n  location        String\n  patientVolume   Int\n  efficiencyScore Float\n  revenue         Float\n  status          String    @default(\"ACTIVE\")\n  createdAt       DateTime  @default(now())\n  updatedAt       DateTime  @updatedAt\n  patients        Patient[]\n}\n\nmodel Patient {\n  id        String   @id @default(uuid())\n  firstName String\n  lastName  String\n  age       Int\n  gender    String\n  status    String   @default(\"ACTIVE\") // ACTIVE, DISCHARGED\n  avatarUrl String?\n  clinicId  String\n  clinic    Clinic   @relation(fields: [clinicId], references: [id], onDelete: Cascade)\n  createdAt DateTime @default(now())\n  updatedAt DateTime @updatedAt\n}\n\nmodel FinancialRecord {\n  id        String   @id @default(uuid())\n  month     String // e.g. \"Jan\", \"Feb\"\n  revenue   Float\n  expenses  Float\n  clinicId  String?\n  createdAt DateTime @default(now())\n}\n\n// 11_family_portal.prisma\n// Extends the core data model to explicitly support Family App dashboard metrics\n\nmodel FamilyAppointment {\n  id          String   @id @default(uuid())\n  title       String\n  patientName String\n  doctorName  String\n  date        DateTime\n  time        String\n  location    String\n  status      String   @default(\"PLANNED\") // PLANNED, COMPLETED, CANCELLED\n  createdAt   DateTime @default(now())\n  updatedAt   DateTime @updatedAt\n}\n\nmodel FamilyCarePlanTask {\n  id          String   @id @default(uuid())\n  patientName String\n  taskName    String\n  category    String   @default(\"MEDICATION\") // MEDICATION, VITALS, ACTIVITY\n  timeSlot    String\n  isCompleted Boolean  @default(false)\n  completedBy String?\n  createdAt   DateTime @default(now())\n  updatedAt   DateTime @updatedAt\n}\n\nmodel FamilyClinicalMessage {\n  id         String   @id @default(uuid())\n  threadId   String\n  senderName String\n  senderRole String // DOCTOR, NURSE, PSW, FAMILY\n  content    String\n  timestamp  DateTime @default(now())\n  isRead     Boolean  @default(false)\n}\n\nmodel PatientIntake {\n  id            String    @id @default(uuid())\n  tenantId      String\n  patientName   String\n  status        String // PENDING, SCHEDULED, IN_PROGRESS, APPROVED, DRAFT\n  priority      String // LOW, MED, HIGH\n  franchiseCity String\n  coordinatorId String?\n  scheduledDate DateTime?\n  scheduledTime String?\n  createdAt     DateTime  @default(now())\n  updatedAt     DateTime  @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel IntakeReferralMetric {\n  id              String   @id @default(uuid())\n  tenantId        String\n  sourceName      String\n  conversionCount Int      @default(0)\n  totalLeads      Int      @default(0)\n  createdAt       DateTime @default(now())\n  updatedAt       DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel JobOpening {\n  id               String   @id @default(uuid())\n  tenantId         String\n  title            String\n  department       String\n  location         String\n  status           String // ACTIVE, DRAFT, CLOSED\n  applicationCount Int      @default(0)\n  postedDate       DateTime @default(now())\n  createdAt        DateTime @default(now())\n  updatedAt        DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel JobCandidate {\n  id            String   @id @default(uuid())\n  tenantId      String\n  candidateName String\n  appliedRole   String\n  department    String\n  source        String\n  status        String // SCREENING, SHORTLISTED, INTERVIEW, OFFER\n  rating        Int      @default(0)\n  createdAt     DateTime @default(now())\n  updatedAt     DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel InterviewEvent {\n  id            String   @id @default(uuid())\n  tenantId      String\n  candidateName String\n  roleTarget    String\n  managerName   String\n  scheduledDate DateTime\n  scheduledTime String\n  status        String // SCHEDULED, COMPLETED, CANCELLED\n  createdAt     DateTime @default(now())\n  updatedAt     DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel InvoiceRecord {\n  id             String   @id @default(uuid())\n  tenantId       String\n  invoiceId      String   @unique\n  patientName    String\n  clinicLocation String\n  amount         Float\n  status         String // Paid, Pending, Overdue\n  issueDate      DateTime @default(now())\n  createdAt      DateTime @default(now())\n  updatedAt      DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel InsuranceClaim {\n  id             String   @id @default(uuid())\n  tenantId       String\n  claimCode      String   @unique\n  patientName    String\n  provider       String\n  status         String // Submission, Review, Reimbursed, Denied\n  denialReason   String?\n  amount         Float\n  submissionDate DateTime @default(now())\n  createdAt      DateTime @default(now())\n  updatedAt      DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel FinancialGoal {\n  id            String   @id @default(uuid())\n  tenantId      String\n  month         Int\n  year          Int\n  label         String\n  targetRevenue Float\n  actualRevenue Float\n  createdAt     DateTime @default(now())\n  updatedAt     DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel FacilityNode {\n  id           String   @id @default(uuid())\n  tenantId     String\n  facilityName String\n  location     String\n  managerName  String\n  status       String // Operational, Review, Issue\n  satisfaction Float\n  dailyVisits  Int\n  createdAt    DateTime @default(now())\n  updatedAt    DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel StaffUtilization {\n  id            String   @id @default(uuid())\n  tenantId      String\n  staffName     String\n  role          String\n  totalHours    Float\n  clinicalHours Float\n  adminHours    Float\n  status        String // Optimized, Overworked, Underutilized\n  createdAt     DateTime @default(now())\n  updatedAt     DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel OpsIssueTicket {\n  id           String   @id @default(uuid())\n  tenantId     String\n  title        String\n  description  String\n  facilityName String\n  severity     String // Critical, High, Medium, Low\n  status       String // Reported, Dispatched, Resolved\n  createdAt    DateTime @default(now())\n  updatedAt    DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel IncidentReportNode {\n  id           String   @id @default(uuid())\n  tenantId     String\n  incidentType String\n  severity     String // Critical, High, Low\n  franchise    String\n  description  String\n  status       String // Open, Under Investigation, Closed\n  createdAt    DateTime @default(now())\n  updatedAt    DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel AuditLogNode {\n  id            String   @id @default(uuid())\n  tenantId      String\n  franchise     String\n  auditDate     DateTime @default(now())\n  auditorName   String\n  score         Float\n  compliancePct Float\n  status        String // Passed, Failed, Warning\n  createdAt     DateTime @default(now())\n  updatedAt     DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel PatientSatisfactionNode {\n  id        String   @id @default(uuid())\n  tenantId  String\n  franchise String\n  score     Float\n  comments  String?\n  type      String // Commendation, Complaint, Neutral\n  createdAt DateTime @default(now())\n  updatedAt DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel SalesDealNode {\n  id             String   @id @default(uuid())\n  tenantId       String\n  dealName       String\n  facilityTarget String\n  amount         Float\n  stage          String // Discovery, Evaluation, Proposal, Closed Won\n  repName        String\n  createdAt      DateTime @default(now())\n  updatedAt      DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel KeyAccountNode {\n  id             String   @id @default(uuid())\n  tenantId       String\n  accountName    String\n  contactName    String\n  stage          String\n  potentialValue Float\n  probability    Int\n  createdAt      DateTime @default(now())\n  updatedAt      DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel RepPerformanceNode {\n  id            String   @id @default(uuid())\n  tenantId      String\n  repName       String\n  quota         Float\n  attainment    Float\n  meetings      Int\n  pipelineValue Float\n  createdAt     DateTime @default(now())\n  updatedAt     DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel MarketingCampaignNode {\n  id           String   @id @default(uuid())\n  tenantId     String\n  campaignName String\n  platform     String // Google Ads, Social, Email\n  spend        Float\n  revenue      Float\n  leads        Int\n  status       String // Active, Paused, Completed\n  createdAt    DateTime @default(now())\n  updatedAt    DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel LocalGrowthNode {\n  id             String   @id @default(uuid())\n  tenantId       String\n  regionName     String\n  patientAcqCost Float\n  newPatients    Int\n  totalRevenue   Float\n  createdAt      DateTime @default(now())\n  updatedAt      DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel ContentAssetNode {\n  id           String   @id @default(uuid())\n  tenantId     String\n  assetName    String\n  assetType    String // Banner, Email, Print\n  author       String\n  status       String // Draft, Review, Live\n  thumbnailUrl String?\n  createdAt    DateTime @default(now())\n  updatedAt    DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel PatientAdmissionNode {\n  id            String   @id @default(uuid())\n  tenantId      String\n  patientName   String\n  priority      String // Critical, High, Normal\n  condition     String\n  location      String\n  attendingPhys String\n  status        String\n  createdAt     DateTime @default(now())\n  updatedAt     DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel ClinicalShiftNode {\n  id           String   @id @default(uuid())\n  tenantId     String\n  providerName String\n  role         String // RN, RPN, PSW\n  startTime    DateTime\n  endTime      DateTime\n  facility     String\n  createdAt    DateTime @default(now())\n  updatedAt    DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel MedicalAuditNode {\n  id              String   @id @default(uuid())\n  tenantId        String\n  regionCode      String // NY, IL, CA\n  survivalRate    Float\n  readmissionRate Float\n  averageWaitTime Int\n  createdAt       DateTime @default(now())\n  updatedAt       DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel SupportTicketNode {\n  id            String   @id @default(uuid())\n  tenantId      String\n  franchiseName String\n  patientRef    String\n  issueType     String\n  status        String\n  assignedTo    String\n  createdAt     DateTime @default(now())\n  updatedAt     DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel PatientFeedbackNode {\n  id            String   @id @default(uuid())\n  tenantId      String\n  patientName   String\n  franchiseName String\n  rating        Int // 1 to 5\n  comments      String\n  status        String // Reviewed, Pending\n  createdAt     DateTime @default(now())\n  updatedAt     DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel SystemTelemetryNode {\n  id            String   @id @default(uuid())\n  tenantId      String\n  serviceName   String // DB Edge, API Gateway, Worker\n  uptimePercent Float\n  latencyMs     Int\n  status        String // Operational, Degraded, Down\n  createdAt     DateTime @default(now())\n  updatedAt     DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel CurriculumNode {\n  id            String   @id @default(uuid())\n  tenantId      String\n  programName   String\n  department    String\n  status        String\n  completionPct Int\n  createdAt     DateTime @default(now())\n  updatedAt     DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel InstructorNode {\n  id              String   @id @default(uuid())\n  tenantId        String\n  facilitatorName String\n  assignedCourse  String\n  status          String\n  createdAt       DateTime @default(now())\n  updatedAt       DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel CertificationNode {\n  id           String   @id @default(uuid())\n  tenantId     String\n  staffName    String\n  clinicalRole String\n  certName     String\n  expiresAt    DateTime\n  status       String // Compliant, Expiring, Expired\n  createdAt    DateTime @default(now())\n  updatedAt    DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel FranchiseRevenueNode {\n  id            String   @id @default(uuid())\n  tenantId      String\n  monthYear     String\n  revenueAmt    Int\n  patientVisits Int\n  growthPct     Float\n  status        String // On Track, At Risk\n  createdAt     DateTime @default(now())\n  updatedAt     DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel ClinicPerformanceNode {\n  id           String   @id @default(uuid())\n  tenantId     String\n  locationName String\n  managerName  String\n  revenue      String\n  visits       Int\n  growth       String\n  status       String\n  createdAt    DateTime @default(now())\n  updatedAt    DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel FranchiseBookingNode {\n  id              String   @id @default(uuid())\n  tenantId        String\n  patientName     String\n  clinicAssigned  String\n  appointmentType String\n  scheduledTime   String\n  status          String\n  createdAt       DateTime @default(now())\n  updatedAt       DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel OutreachEventNode {\n  id              String   @id @default(uuid())\n  tenantId        String\n  eventName       String\n  location        String\n  scheduledDate   DateTime\n  status          String // Upcoming, Completed, Active\n  participantGoal Int\n  createdAt       DateTime @default(now())\n  updatedAt       DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel ParticipantMetricNode {\n  id              String   @id @default(uuid())\n  tenantId        String\n  metricDate      String\n  totalReached    Int\n  engagementScore Float\n  healthScreened  Int\n  createdAt       DateTime @default(now())\n  updatedAt       DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel OutreachBudgetNode {\n  id             String   @id @default(uuid())\n  tenantId       String\n  projectName    String\n  allocatedFunds Int\n  fundsUsed      Int\n  sponsor        String\n  status         String\n  createdAt      DateTime @default(now())\n  updatedAt      DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel LocalNetworkNode {\n  id              String   @id @default(uuid())\n  tenantId        String\n  locationName    String\n  occupancyRate   Float\n  serverLoadScore Float\n  staffActive     Int\n  status          String\n  createdAt       DateTime @default(now())\n  updatedAt       DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel LocalFinanceNode {\n  id           String   @id @default(uuid())\n  tenantId     String\n  monthLabel   String\n  grossRevenue Float\n  netMargin    Float\n  growthYoY    Float\n  createdAt    DateTime @default(now())\n  updatedAt    DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel LocalActivityNode {\n  id         String   @id @default(uuid())\n  tenantId   String\n  eventTitle String\n  eventType  String\n  eventTime  String\n  createdAt  DateTime @default(now())\n  updatedAt  DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel LocalMarketingAnalyticNode {\n  id         String   @id @default(uuid())\n  tenantId   String\n  metricType String\n  value      Float\n  growthYoY  Float\n  createdAt  DateTime @default(now())\n  updatedAt  DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel LocalCampaignNode {\n  id           String   @id @default(uuid())\n  tenantId     String\n  campaignName String\n  managerName  String\n  roiFactor    Float\n  status       String\n  createdAt    DateTime @default(now())\n  updatedAt    DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel LocalContentNode {\n  id           String   @id @default(uuid())\n  tenantId     String\n  assetTitle   String\n  assetType    String\n  deployedDate String\n  createdAt    DateTime @default(now())\n  updatedAt    DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel SupportAgentNode {\n  id            String   @id @default(uuid())\n  tenantId      String\n  agentName     String\n  shiftTime     String\n  activeTickets Int\n  status        String\n  createdAt     DateTime @default(now())\n  updatedAt     DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel TicketVolumeNode {\n  id            String   @id @default(uuid())\n  tenantId      String\n  hourlyMark    String\n  inboundCount  Int\n  resolvedCount Int\n  createdAt     DateTime @default(now())\n  updatedAt     DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel ResolutionFeedbackNode {\n  id           String   @id @default(uuid())\n  tenantId     String\n  patientName  String\n  csatScore    Float\n  feedbackText String\n  createdAt    DateTime @default(now())\n  updatedAt    DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel ClientTrendNode {\n  id            String   @id @default(uuid())\n  tenantId      String\n  monthLabel    String\n  revenueAmount Float\n  apptCount     Int\n  createdAt     DateTime @default(now())\n  updatedAt     DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel ClientClinicNode {\n  id            String   @id @default(uuid())\n  tenantId      String\n  clinicName    String\n  starRating    Int\n  revenueString String\n  rank          Int\n  createdAt     DateTime @default(now())\n  updatedAt     DateTime @updatedAt\n\n  @@index([tenantId])\n}\n\nmodel ClientDemographicNode {\n  id          String   @id @default(uuid())\n  tenantId    String\n  cohortGroup String\n  percentage  Float\n  createdAt   DateTime @default(now())\n  updatedAt   DateTime @updatedAt\n\n  @@index([tenantId])\n}\n",
  "inlineSchemaHash": "d8a8b8df6c1c94ad541fd570fda4247952036696b6111ea17fa6441d39b668e7",
  "copyEngine": true
}
config.dirname = '/'

config.runtimeDataModel = JSON.parse("{\"models\":{\"User\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"email\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"phone\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"passwordHash\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"password_hash\"},{\"name\":\"osmId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"osm_id\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"resetToken\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"resetTokenExpiry\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"lastLoginAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_login_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"roles\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"auditLogs\",\"kind\":\"object\",\"type\":\"AuditLog\",\"relationName\":\"AuditLogToUser\"},{\"name\":\"blogPosts\",\"kind\":\"object\",\"type\":\"BlogPost\",\"relationName\":\"BlogPostToUser\"},{\"name\":\"clientProfile\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToUser\"},{\"name\":\"DailyEntry\",\"kind\":\"object\",\"type\":\"DailyEntry\",\"relationName\":\"DailyEntryToUser\"},{\"name\":\"reportedIncidents\",\"kind\":\"object\",\"type\":\"Incident\",\"relationName\":\"Reporter\"},{\"name\":\"sentMessages\",\"kind\":\"object\",\"type\":\"Message\",\"relationName\":\"MessageToUser\"},{\"name\":\"verifiedDocs\",\"kind\":\"object\",\"type\":\"PswDocument\",\"relationName\":\"VerifiedBy\"},{\"name\":\"pswProfile\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswProfileToUser\"},{\"name\":\"reviewedTimesheets\",\"kind\":\"object\",\"type\":\"Timesheet\",\"relationName\":\"ReviewedBy\"},{\"name\":\"telehealthSessions\",\"kind\":\"object\",\"type\":\"TelehealthSession\",\"relationName\":\"TelehealthSessionToUser\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToUser\"},{\"name\":\"VisitCheckEvent\",\"kind\":\"object\",\"type\":\"VisitCheckEvent\",\"relationName\":\"UserToVisitCheckEvent\"},{\"name\":\"StaffGroupMember\",\"kind\":\"object\",\"type\":\"StaffGroupMember\",\"relationName\":\"StaffGroupMemberToUser\"},{\"name\":\"assignedTasks\",\"kind\":\"object\",\"type\":\"StaffTask\",\"relationName\":\"AssignedTasks\"},{\"name\":\"carePlansAuthored\",\"kind\":\"object\",\"type\":\"CarePlan\",\"relationName\":\"CarePlanAuthor\"},{\"name\":\"ledgerEntries\",\"kind\":\"object\",\"type\":\"TransactionLedger\",\"relationName\":\"LedgerActor\"},{\"name\":\"assessments\",\"kind\":\"object\",\"type\":\"ClinicalAssessment\",\"relationName\":\"ClinicalAssessmentToUser\"},{\"name\":\"medicationRecons\",\"kind\":\"object\",\"type\":\"MedicationRecon\",\"relationName\":\"MedicationReconToUser\"},{\"name\":\"supervisionLogs\",\"kind\":\"object\",\"type\":\"SupervisionLog\",\"relationName\":\"SupervisionLogToUser\"},{\"name\":\"acknowledgedIncidents\",\"kind\":\"object\",\"type\":\"Incident\",\"relationName\":\"Acknowledger\"},{\"name\":\"performedAudits\",\"kind\":\"object\",\"type\":\"TechnicalAudit\",\"relationName\":\"PerformedAudits\"},{\"name\":\"dailyAuditSignOffs\",\"kind\":\"object\",\"type\":\"DailyAuditSignOff\",\"relationName\":\"DailyAuditSignOffToUser\"},{\"name\":\"wellnessPulses\",\"kind\":\"object\",\"type\":\"WellnessPulse\",\"relationName\":\"UserToWellnessPulse\"},{\"name\":\"devices\",\"kind\":\"object\",\"type\":\"UserDevice\",\"relationName\":\"UserToUserDevice\"},{\"name\":\"systemEvents\",\"kind\":\"object\",\"type\":\"SystemEvent\",\"relationName\":\"SystemEventToUser\"},{\"name\":\"performanceReviewsAuthored\",\"kind\":\"object\",\"type\":\"PerformanceReview\",\"relationName\":\"ReviewAuthor\"},{\"name\":\"iotEvents\",\"kind\":\"object\",\"type\":\"IoTEvent\",\"relationName\":\"IoTEventToUser\"},{\"name\":\"appNotifications\",\"kind\":\"object\",\"type\":\"AppNotification\",\"relationName\":\"AppNotificationToUser\"},{\"name\":\"gamificationProfile\",\"kind\":\"object\",\"type\":\"GamificationProfile\",\"relationName\":\"GamificationProfileToUser\"},{\"name\":\"reputation\",\"kind\":\"object\",\"type\":\"UserReputation\",\"relationName\":\"UserToUserReputation\"},{\"name\":\"DailyActivity\",\"kind\":\"object\",\"type\":\"DailyActivity\",\"relationName\":\"DailyActivityToUser\"},{\"name\":\"shiftCheckIns\",\"kind\":\"object\",\"type\":\"PswShiftLog\",\"relationName\":\"UserShiftLogs\"},{\"name\":\"adlCareLogs\",\"kind\":\"object\",\"type\":\"AdlCareLog\",\"relationName\":\"UserAdlLogs\"},{\"name\":\"pswVitals\",\"kind\":\"object\",\"type\":\"PswVitalSign\",\"relationName\":\"UserPswVitals\"},{\"name\":\"behaviorNotes\",\"kind\":\"object\",\"type\":\"BehaviorNote\",\"relationName\":\"UserBehaviorNotes\"},{\"name\":\"nutritionRecords\",\"kind\":\"object\",\"type\":\"NutritionRecord\",\"relationName\":\"UserNutrition\"},{\"name\":\"mobilityLogs\",\"kind\":\"object\",\"type\":\"MobilityLog\",\"relationName\":\"UserMobility\"},{\"name\":\"infectionLogs\",\"kind\":\"object\",\"type\":\"InfectionControlChecklist\",\"relationName\":\"UserInfectionControl\"},{\"name\":\"narrativeNotes\",\"kind\":\"object\",\"type\":\"NarrativeProgressNote\",\"relationName\":\"UserNarrativeNotes\"},{\"name\":\"carePlanFollowUps\",\"kind\":\"object\",\"type\":\"CarePlanFollowUp\",\"relationName\":\"UserCarePlanFollowUp\"}],\"dbName\":\"users\"},\"Tenant\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"slug\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"auditLogs\",\"kind\":\"object\",\"type\":\"AuditLog\",\"relationName\":\"AuditLogToTenant\"},{\"name\":\"bookings\",\"kind\":\"object\",\"type\":\"Booking\",\"relationName\":\"BookingToTenant\"},{\"name\":\"clientProfiles\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToTenant\"},{\"name\":\"dailyEntries\",\"kind\":\"object\",\"type\":\"DailyEntry\",\"relationName\":\"DailyEntryToTenant\"},{\"name\":\"incidents\",\"kind\":\"object\",\"type\":\"Incident\",\"relationName\":\"IncidentToTenant\"},{\"name\":\"invoices\",\"kind\":\"object\",\"type\":\"Invoice\",\"relationName\":\"InvoiceToTenant\"},{\"name\":\"messageThreads\",\"kind\":\"object\",\"type\":\"MessageThread\",\"relationName\":\"MessageThreadToTenant\"},{\"name\":\"pswAvailability\",\"kind\":\"object\",\"type\":\"PswAvailability\",\"relationName\":\"PswAvailabilityToTenant\"},{\"name\":\"pswProfiles\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswProfileToTenant\"},{\"name\":\"services\",\"kind\":\"object\",\"type\":\"Service\",\"relationName\":\"ServiceToTenant\"},{\"name\":\"shiftAssignments\",\"kind\":\"object\",\"type\":\"ShiftAssignment\",\"relationName\":\"ShiftAssignmentToTenant\"},{\"name\":\"timesheets\",\"kind\":\"object\",\"type\":\"Timesheet\",\"relationName\":\"TenantToTimesheet\"},{\"name\":\"staffTasks\",\"kind\":\"object\",\"type\":\"StaffTask\",\"relationName\":\"StaffTaskToTenant\"},{\"name\":\"leads\",\"kind\":\"object\",\"type\":\"Lead\",\"relationName\":\"LeadToTenant\"},{\"name\":\"users\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"TenantToUser\"},{\"name\":\"checkEvents\",\"kind\":\"object\",\"type\":\"VisitCheckEvent\",\"relationName\":\"TenantToVisitCheckEvent\"},{\"name\":\"visits\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"TenantToVisit\"},{\"name\":\"apiKeys\",\"kind\":\"object\",\"type\":\"ApiKey\",\"relationName\":\"ApiKeyToTenant\"},{\"name\":\"feedbacks\",\"kind\":\"object\",\"type\":\"Feedback\",\"relationName\":\"FeedbackToTenant\"},{\"name\":\"carePlans\",\"kind\":\"object\",\"type\":\"CarePlan\",\"relationName\":\"CarePlanToTenant\"},{\"name\":\"trainingModules\",\"kind\":\"object\",\"type\":\"TrainingModule\",\"relationName\":\"TenantToTrainingModule\"},{\"name\":\"surveys\",\"kind\":\"object\",\"type\":\"Survey\",\"relationName\":\"SurveyToTenant\"},{\"name\":\"regions\",\"kind\":\"object\",\"type\":\"Region\",\"relationName\":\"RegionToTenant\"},{\"name\":\"clinicalRecords\",\"kind\":\"object\",\"type\":\"ClinicalRecord\",\"relationName\":\"ClinicalRecordToTenant\"},{\"name\":\"fhirSyncLogs\",\"kind\":\"object\",\"type\":\"FhirSyncLog\",\"relationName\":\"FhirSyncLogToTenant\"},{\"name\":\"aiRecommendations\",\"kind\":\"object\",\"type\":\"AIRecommendation\",\"relationName\":\"AIRecommendationToTenant\"},{\"name\":\"sentimentAnalyses\",\"kind\":\"object\",\"type\":\"SentimentAnalysis\",\"relationName\":\"SentimentAnalysisToTenant\"},{\"name\":\"securityThreats\",\"kind\":\"object\",\"type\":\"SecurityThreat\",\"relationName\":\"SecurityThreatToTenant\"},{\"name\":\"slas\",\"kind\":\"object\",\"type\":\"TenantSLA\",\"relationName\":\"TenantToTenantSLA\"},{\"name\":\"telehealthSessions\",\"kind\":\"object\",\"type\":\"TelehealthSession\",\"relationName\":\"TelehealthSessionToTenant\"},{\"name\":\"patientAlerts\",\"kind\":\"object\",\"type\":\"PatientAlert\",\"relationName\":\"PatientAlertToTenant\"},{\"name\":\"insuranceProviders\",\"kind\":\"object\",\"type\":\"InsuranceProvider\",\"relationName\":\"InsuranceProviderToTenant\"},{\"name\":\"visitMatches\",\"kind\":\"object\",\"type\":\"VisitMatch\",\"relationName\":\"TenantToVisitMatch\"},{\"name\":\"waitlistEntries\",\"kind\":\"object\",\"type\":\"WaitlistEntry\",\"relationName\":\"TenantToWaitlistEntry\"},{\"name\":\"claims\",\"kind\":\"object\",\"type\":\"Claim\",\"relationName\":\"ClaimToTenant\"},{\"name\":\"prescriptions\",\"kind\":\"object\",\"type\":\"Prescription\",\"relationName\":\"PrescriptionToTenant\"},{\"name\":\"branchStats\",\"kind\":\"object\",\"type\":\"BranchStat\",\"relationName\":\"BranchStatToTenant\"},{\"name\":\"complianceRecords\",\"kind\":\"object\",\"type\":\"ComplianceRecord\",\"relationName\":\"ComplianceRecordToTenant\"},{\"name\":\"familyNotifications\",\"kind\":\"object\",\"type\":\"FamilyNotification\",\"relationName\":\"FamilyNotificationToTenant\"},{\"name\":\"careFeedbacks\",\"kind\":\"object\",\"type\":\"CareFeedback\",\"relationName\":\"CareFeedbackToTenant\"},{\"name\":\"technicalAudits\",\"kind\":\"object\",\"type\":\"TechnicalAudit\",\"relationName\":\"TechnicalAuditToTenant\"},{\"name\":\"bookingRequests\",\"kind\":\"object\",\"type\":\"BookingRequest\",\"relationName\":\"BookingRequestToTenant\"},{\"name\":\"dailyAuditSignOffs\",\"kind\":\"object\",\"type\":\"DailyAuditSignOff\",\"relationName\":\"DailyAuditSignOffToTenant\"},{\"name\":\"wellnessPulses\",\"kind\":\"object\",\"type\":\"WellnessPulse\",\"relationName\":\"TenantToWellnessPulse\"},{\"name\":\"systemTouchpoints\",\"kind\":\"object\",\"type\":\"SystemTouchpoint\",\"relationName\":\"SystemTouchpointToTenant\"},{\"name\":\"iotEvents\",\"kind\":\"object\",\"type\":\"IoTEvent\",\"relationName\":\"IoTEventToTenant\"},{\"name\":\"appNotifications\",\"kind\":\"object\",\"type\":\"AppNotification\",\"relationName\":\"AppNotificationToTenant\"},{\"name\":\"gamificationProfiles\",\"kind\":\"object\",\"type\":\"GamificationProfile\",\"relationName\":\"GamificationProfileToTenant\"},{\"name\":\"aiInferences\",\"kind\":\"object\",\"type\":\"AIInference\",\"relationName\":\"AIInferenceToTenant\"},{\"name\":\"communicationLogs\",\"kind\":\"object\",\"type\":\"CommunicationLog\",\"relationName\":\"CommunicationLogToTenant\"},{\"name\":\"transactionLedger\",\"kind\":\"object\",\"type\":\"TransactionLedger\",\"relationName\":\"TenantToTransactionLedger\"},{\"name\":\"businessNumber\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"business_number\"},{\"name\":\"supportEmail\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"support_email\"},{\"name\":\"logoUrl\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"logo_url\"},{\"name\":\"taxSettings\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"tax_settings\"},{\"name\":\"brandingConfig\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"branding_config\"},{\"name\":\"stripeAccountId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"stripe_account_id\"},{\"name\":\"onboardingStep\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"onboarding_step\"},{\"name\":\"allowedVpnRanges\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"allowed_vpn_ranges\"},{\"name\":\"enforceVpn\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"enforce_vpn\"},{\"name\":\"requireDeviceApproval\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"require_device_approval\"},{\"name\":\"maxDevicesPerUser\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"max_devices_per_user\"},{\"name\":\"corsAllowedOrigins\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"cors_allowed_origins\"},{\"name\":\"corsAllowedMethods\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"cors_allowed_methods\"},{\"name\":\"corsAllowedHeaders\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"cors_allowed_headers\"},{\"name\":\"taxPercentage\",\"kind\":\"scalar\",\"type\":\"Decimal\",\"dbName\":\"tax_percentage\"},{\"name\":\"parentTenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"parent_tenant_id\"},{\"name\":\"parentTenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantHierarchy\"},{\"name\":\"childTenants\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantHierarchy\"},{\"name\":\"franchises\",\"kind\":\"object\",\"type\":\"Franchise\",\"relationName\":\"ResellerTenants\"},{\"name\":\"marketplaceListings\",\"kind\":\"object\",\"type\":\"MarketplaceListing\",\"relationName\":\"MarketplaceListingToTenant\"},{\"name\":\"handovers\",\"kind\":\"object\",\"type\":\"ShiftHandover\",\"relationName\":\"ShiftHandoverToTenant\"},{\"name\":\"availabilityOverrides\",\"kind\":\"object\",\"type\":\"AvailabilityOverride\",\"relationName\":\"AvailabilityOverrideToTenant\"},{\"name\":\"payouts\",\"kind\":\"object\",\"type\":\"Payout\",\"relationName\":\"PayoutToTenant\"},{\"name\":\"clinicalAssessments\",\"kind\":\"object\",\"type\":\"ClinicalAssessment\",\"relationName\":\"ClinicalAssessmentToTenant\"},{\"name\":\"medicationRecons\",\"kind\":\"object\",\"type\":\"MedicationRecon\",\"relationName\":\"MedicationReconToTenant\"},{\"name\":\"supervisionLogs\",\"kind\":\"object\",\"type\":\"SupervisionLog\",\"relationName\":\"SupervisionLogToTenant\"},{\"name\":\"inventoryItems\",\"kind\":\"object\",\"type\":\"InventoryItem\",\"relationName\":\"InventoryItemToTenant\"},{\"name\":\"purchaseOrders\",\"kind\":\"object\",\"type\":\"PurchaseOrder\",\"relationName\":\"PurchaseOrderToTenant\"},{\"name\":\"systemEvents\",\"kind\":\"object\",\"type\":\"SystemEvent\",\"relationName\":\"SystemEventToTenant\"},{\"name\":\"financialAccounts\",\"kind\":\"object\",\"type\":\"ChartOfAccount\",\"relationName\":\"ChartOfAccountToTenant\"},{\"name\":\"financialTransactions\",\"kind\":\"object\",\"type\":\"FinancialTransaction\",\"relationName\":\"FinancialTransactionToTenant\"},{\"name\":\"financialJournalEntries\",\"kind\":\"object\",\"type\":\"JournalEntry\",\"relationName\":\"JournalEntryToTenant\"},{\"name\":\"financialReconciliations\",\"kind\":\"object\",\"type\":\"FinancialReconciliation\",\"relationName\":\"FinancialReconciliationToTenant\"},{\"name\":\"bankTransactions\",\"kind\":\"object\",\"type\":\"BankTransaction\",\"relationName\":\"BankTransactionToTenant\"},{\"name\":\"registries\",\"kind\":\"object\",\"type\":\"Registry\",\"relationName\":\"RegistryToTenant\"},{\"name\":\"evvRecords\",\"kind\":\"object\",\"type\":\"EVVRecord\",\"relationName\":\"EVVRecordToTenant\"},{\"name\":\"serviceAuthorizations\",\"kind\":\"object\",\"type\":\"ServiceAuthorization\",\"relationName\":\"ServiceAuthorizationToTenant\"},{\"name\":\"consentForms\",\"kind\":\"object\",\"type\":\"ConsentForm\",\"relationName\":\"ConsentFormToTenant\"},{\"name\":\"mileageLogs\",\"kind\":\"object\",\"type\":\"MileageLog\",\"relationName\":\"MileageLogToTenant\"},{\"name\":\"referrals\",\"kind\":\"object\",\"type\":\"Referral\",\"relationName\":\"ReferralToTenant\"},{\"name\":\"familyMembers\",\"kind\":\"object\",\"type\":\"FamilyMember\",\"relationName\":\"FamilyMemberToTenant\"},{\"name\":\"performanceReviews\",\"kind\":\"object\",\"type\":\"PerformanceReview\",\"relationName\":\"PerformanceReviewToTenant\"},{\"name\":\"webhookEndpoints\",\"kind\":\"object\",\"type\":\"WebhookEndpoint\",\"relationName\":\"TenantToWebhookEndpoint\"},{\"name\":\"staffGroups\",\"kind\":\"object\",\"type\":\"StaffGroup\",\"relationName\":\"StaffGroupToTenant\"},{\"name\":\"platformRoles\",\"kind\":\"object\",\"type\":\"PlatformRole\",\"relationName\":\"PlatformRoleToTenant\"},{\"name\":\"DailyActivity\",\"kind\":\"object\",\"type\":\"DailyActivity\",\"relationName\":\"DailyActivityToTenant\"},{\"name\":\"shiftCheckIns\",\"kind\":\"object\",\"type\":\"PswShiftLog\",\"relationName\":\"TenantShiftLogs\"},{\"name\":\"adlCareLogs\",\"kind\":\"object\",\"type\":\"AdlCareLog\",\"relationName\":\"TenantAdlLogs\"},{\"name\":\"pswVitals\",\"kind\":\"object\",\"type\":\"PswVitalSign\",\"relationName\":\"TenantPswVitals\"},{\"name\":\"behaviorNotes\",\"kind\":\"object\",\"type\":\"BehaviorNote\",\"relationName\":\"TenantBehaviorNotes\"},{\"name\":\"nutritionRecords\",\"kind\":\"object\",\"type\":\"NutritionRecord\",\"relationName\":\"TenantNutrition\"},{\"name\":\"mobilityLogs\",\"kind\":\"object\",\"type\":\"MobilityLog\",\"relationName\":\"TenantMobility\"},{\"name\":\"infectionLogs\",\"kind\":\"object\",\"type\":\"InfectionControlChecklist\",\"relationName\":\"TenantInfectionControl\"},{\"name\":\"narrativeNotes\",\"kind\":\"object\",\"type\":\"NarrativeProgressNote\",\"relationName\":\"TenantNarrativeNotes\"},{\"name\":\"carePlanFollowUps\",\"kind\":\"object\",\"type\":\"CarePlanFollowUp\",\"relationName\":\"TenantCarePlanFollowUp\"}],\"dbName\":\"tenants\"},\"Registry\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"key\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"value\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"section\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"metadata\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"RegistryToTenant\"}],\"dbName\":\"registries\"},\"ApiKey\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"key\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"lastUsedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_used_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ApiKeyToTenant\"}],\"dbName\":\"api_keys\"},\"AuditLog\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"actorUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"actor_user_id\"},{\"name\":\"action\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"resourceType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"resource_type\"},{\"name\":\"resourceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"resource_id\"},{\"name\":\"metadata\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"metadata_json\"},{\"name\":\"deviceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"device_id\"},{\"name\":\"ipAddress\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"ip_address\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"actor\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"AuditLogToUser\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"AuditLogToTenant\"}],\"dbName\":\"audit_logs\"},\"SystemEvent\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"operation\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"modelName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"model_name\"},{\"name\":\"entityId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"entity_id\"},{\"name\":\"payload\",\"kind\":\"scalar\",\"type\":\"Json\"},{\"name\":\"previousData\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"previous_data\"},{\"name\":\"actorUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"actor_user_id\"},{\"name\":\"deviceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"device_id\"},{\"name\":\"ipAddress\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"ip_address\"},{\"name\":\"checksum\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"previousChecksum\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"previous_checksum\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"SystemEventToTenant\"},{\"name\":\"actor\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"SystemEventToUser\"}],\"dbName\":\"system_events\"},\"Lead\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"fullName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"full_name\"},{\"name\":\"email\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"phone\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"message\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"source\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"serviceInterest\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_interest\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"convertedToUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"converted_to_user_id\"},{\"name\":\"conversionDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"conversion_date\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"LeadToTenant\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"}],\"dbName\":\"leads\"},\"FAQ\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"question\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"answer\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"}],\"dbName\":\"faqs\"},\"UserDevice\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"deviceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"device_id\"},{\"name\":\"deviceName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"device_name\"},{\"name\":\"deviceType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"device_type\"},{\"name\":\"lastIp\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"last_ip\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"isAuthorized\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_authorized\"},{\"name\":\"authorizedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"authorized_at\"},{\"name\":\"isTemporary\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_temporary\"},{\"name\":\"expiresAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"expires_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"lastActiveAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_active_at\"},{\"name\":\"user\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"UserToUserDevice\"}],\"dbName\":\"user_devices\"},\"SystemPolicy\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"code\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"value\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"isEnforced\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_enforced\"},{\"name\":\"version\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"}],\"dbName\":\"system_policies\"},\"ResponseBotAudit\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"summary\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"details\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"durationMs\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"duration_ms\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"}],\"dbName\":\"response_bot_audits\"},\"SystemTouchpoint\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"touchpointId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"touchpoint_id\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"role\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"module\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"label\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"path\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"errorDetail\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"error_detail\"},{\"name\":\"isOverridden\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_overridden\"},{\"name\":\"overrideValue\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"override_value\"},{\"name\":\"lastChecked\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_checked\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"SystemTouchpointToTenant\"}],\"dbName\":\"system_touchpoints\"},\"RegistryEntry\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"externalId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"external_id\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"label\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"role\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"module\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"action\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"targetPath\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"target_path\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"lastChecked\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_checked\"},{\"name\":\"errorCount\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"error_count\"},{\"name\":\"metadata\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"}],\"dbName\":\"registry_entries\"},\"MessageThread\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"threadType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"thread_type\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"messages\",\"kind\":\"object\",\"type\":\"Message\",\"relationName\":\"MessageToMessageThread\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToMessageThread\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToThreads\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"MessageThreadToTenant\"}],\"dbName\":\"messages_threads\"},\"Message\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"threadId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"thread_id\"},{\"name\":\"senderUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"sender_user_id\"},{\"name\":\"bodyText\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"body_text\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"sender\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"MessageToUser\"},{\"name\":\"thread\",\"kind\":\"object\",\"type\":\"MessageThread\",\"relationName\":\"MessageToMessageThread\"}],\"dbName\":\"messages\"},\"PlatformRole\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"isCustom\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_custom\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"PlatformRoleToTenant\"},{\"name\":\"screenAccess\",\"kind\":\"object\",\"type\":\"RoleScreenAccess\",\"relationName\":\"PlatformRoleToRoleScreenAccess\"},{\"name\":\"resolutions\",\"kind\":\"object\",\"type\":\"ProtocolResolution\",\"relationName\":\"EscalationRoles\"},{\"name\":\"screens\",\"kind\":\"object\",\"type\":\"PlatformScreen\",\"relationName\":\"PlatformRoleToPlatformScreen\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"}],\"dbName\":\"platform_roles\"},\"RoleScreenAccess\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"roleId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"role_id\"},{\"name\":\"screenRoute\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"screen_route\"},{\"name\":\"canRead\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"can_read\"},{\"name\":\"canWrite\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"can_write\"},{\"name\":\"role\",\"kind\":\"object\",\"type\":\"PlatformRole\",\"relationName\":\"PlatformRoleToRoleScreenAccess\"}],\"dbName\":\"role_screen_access\"},\"CrisisProtocol\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"scenarioName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"scenario_name\"},{\"name\":\"triggerEvent\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"trigger_event\"},{\"name\":\"severity\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"isActive\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_active\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"resolutions\",\"kind\":\"object\",\"type\":\"ProtocolResolution\",\"relationName\":\"CrisisProtocolToProtocolResolution\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"}],\"dbName\":\"crisis_protocols\"},\"ProtocolResolution\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"protocolId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"protocol_id\"},{\"name\":\"actionType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"action_type\"},{\"name\":\"escalateToRoleId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"escalate_to_role_id\"},{\"name\":\"uiOverrideKey\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"ui_override_key\"},{\"name\":\"orderIndex\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"order_index\"},{\"name\":\"protocol\",\"kind\":\"object\",\"type\":\"CrisisProtocol\",\"relationName\":\"CrisisProtocolToProtocolResolution\"},{\"name\":\"escalateToRole\",\"kind\":\"object\",\"type\":\"PlatformRole\",\"relationName\":\"EscalationRoles\"}],\"dbName\":\"protocol_resolutions\"},\"EcosystemStateOverride\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"globalStateMacro\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"global_state_macro\"},{\"name\":\"isActive\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_active\"},{\"name\":\"payMultiplier\",\"kind\":\"scalar\",\"type\":\"Decimal\",\"dbName\":\"pay_multiplier\"},{\"name\":\"forceOfflineMode\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"force_offline_mode\"},{\"name\":\"filterTriageOnly\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"filter_triage_only\"},{\"name\":\"activatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"activated_at\"},{\"name\":\"activatedByUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"activated_by_user_id\"}],\"dbName\":\"ecosystem_state_overrides\"},\"UserReputation\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"points\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"eliteStatus\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"elite_status\"},{\"name\":\"permanentMultiplier\",\"kind\":\"scalar\",\"type\":\"Decimal\",\"dbName\":\"permanent_multiplier\"},{\"name\":\"crisesResolved\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"crises_resolved\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"user\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"UserToUserReputation\"}],\"dbName\":\"user_reputations\"},\"EcosystemAutopilotConfig\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"isActive\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_active\"},{\"name\":\"maxDailySurgeBudget\",\"kind\":\"scalar\",\"type\":\"Decimal\",\"dbName\":\"max_daily_surge_budget\"},{\"name\":\"currentDailySurgeSpend\",\"kind\":\"scalar\",\"type\":\"Decimal\",\"dbName\":\"current_daily_surge_spend\"},{\"name\":\"marginFreezeThreshold\",\"kind\":\"scalar\",\"type\":\"Decimal\",\"dbName\":\"margin_freeze_threshold\"},{\"name\":\"lastCronRun\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_cron_run\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"}],\"dbName\":\"ecosystem_autopilot_configs\"},\"HospitalTarget\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"hospitalName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"hospital_name\"},{\"name\":\"dischargePlanner\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"discharge_planner\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"lastTouchpointAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_touchpoint_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"pipelines\",\"kind\":\"object\",\"type\":\"ReferralPipeline\",\"relationName\":\"HospitalTargetToReferralPipeline\"}],\"dbName\":\"hospital_targets\"},\"ReferralPipeline\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"hospitalId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"hospital_id\"},{\"name\":\"patientName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"patient_name\"},{\"name\":\"referralValue\",\"kind\":\"scalar\",\"type\":\"Decimal\",\"dbName\":\"referral_value\"},{\"name\":\"isConverted\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_converted\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"hospital\",\"kind\":\"object\",\"type\":\"HospitalTarget\",\"relationName\":\"HospitalTargetToReferralPipeline\"}],\"dbName\":\"referral_pipelines\"},\"SupplyForecastMetrics\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"targetDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"target_date\"},{\"name\":\"geographyZone\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"geography_zone\"},{\"name\":\"predictedDemand\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"predicted_demand\"},{\"name\":\"physicalSupply\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"physical_supply\"},{\"name\":\"deficitWarning\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"deficit_warning\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"}],\"dbName\":\"supply_forecast_metrics\"},\"ClientProfile\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"fullName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"full_name\"},{\"name\":\"dob\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"addressLine1\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"address_line1\"},{\"name\":\"addressLine2\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"address_line2\"},{\"name\":\"city\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"province\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"postalCode\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"postal_code\"},{\"name\":\"lat\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"lng\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"emergencyName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"emergency_contact_name\"},{\"name\":\"emergencyPhone\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"emergency_contact_phone\"},{\"name\":\"preferences\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"preferences_json\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"bookings\",\"kind\":\"object\",\"type\":\"Booking\",\"relationName\":\"BookingToClientProfile\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ClientProfileToTenant\"},{\"name\":\"user\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"ClientProfileToUser\"},{\"name\":\"DailyEntry\",\"kind\":\"object\",\"type\":\"DailyEntry\",\"relationName\":\"ClientProfileToDailyEntry\"},{\"name\":\"invoices\",\"kind\":\"object\",\"type\":\"Invoice\",\"relationName\":\"ClientProfileToInvoice\"},{\"name\":\"messageThreads\",\"kind\":\"object\",\"type\":\"MessageThread\",\"relationName\":\"ClientProfileToMessageThread\"},{\"name\":\"visits\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"ClientProfileToVisit\"},{\"name\":\"feedbacks\",\"kind\":\"object\",\"type\":\"Feedback\",\"relationName\":\"ClientProfileToFeedback\"},{\"name\":\"franchise\",\"kind\":\"object\",\"type\":\"Franchise\",\"relationName\":\"ClientProfileToFranchise\"},{\"name\":\"franchiseId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"franchise_id\"},{\"name\":\"inventoryItems\",\"kind\":\"object\",\"type\":\"InventoryItem\",\"relationName\":\"ClientProfileToInventoryItem\"},{\"name\":\"purchaseOrders\",\"kind\":\"object\",\"type\":\"PurchaseOrder\",\"relationName\":\"ClientProfileToPurchaseOrder\"},{\"name\":\"telehealthSessions\",\"kind\":\"object\",\"type\":\"TelehealthSession\",\"relationName\":\"ClientProfileToTelehealthSession\"},{\"name\":\"vitalSigns\",\"kind\":\"object\",\"type\":\"VitalSign\",\"relationName\":\"ClientProfileToVitalSign\"},{\"name\":\"patientAlerts\",\"kind\":\"object\",\"type\":\"PatientAlert\",\"relationName\":\"ClientProfileToPatientAlert\"},{\"name\":\"claims\",\"kind\":\"object\",\"type\":\"Claim\",\"relationName\":\"ClaimToClientProfile\"},{\"name\":\"prescriptions\",\"kind\":\"object\",\"type\":\"Prescription\",\"relationName\":\"ClientProfileToPrescription\"},{\"name\":\"marEntries\",\"kind\":\"object\",\"type\":\"MAR_Entry\",\"relationName\":\"ClientProfileToMAR_Entry\"},{\"name\":\"carePlans\",\"kind\":\"object\",\"type\":\"CarePlan\",\"relationName\":\"CarePlanToClientProfile\"},{\"name\":\"assessments\",\"kind\":\"object\",\"type\":\"ClinicalAssessment\",\"relationName\":\"ClientProfileToClinicalAssessment\"},{\"name\":\"medicationRecons\",\"kind\":\"object\",\"type\":\"MedicationRecon\",\"relationName\":\"ClientProfileToMedicationRecon\"},{\"name\":\"waitlistEntries\",\"kind\":\"object\",\"type\":\"WaitlistEntry\",\"relationName\":\"ClientProfileToWaitlistEntry\"},{\"name\":\"familyNotifications\",\"kind\":\"object\",\"type\":\"FamilyNotification\",\"relationName\":\"ClientProfileToFamilyNotification\"},{\"name\":\"careFeedbacks\",\"kind\":\"object\",\"type\":\"CareFeedback\",\"relationName\":\"CareFeedbackToClientProfile\"},{\"name\":\"bookingRequests\",\"kind\":\"object\",\"type\":\"BookingRequest\",\"relationName\":\"BookingRequestToClientProfile\"},{\"name\":\"serviceAuthorizations\",\"kind\":\"object\",\"type\":\"ServiceAuthorization\",\"relationName\":\"ClientProfileToServiceAuthorization\"},{\"name\":\"consentForms\",\"kind\":\"object\",\"type\":\"ConsentForm\",\"relationName\":\"ClientProfileToConsentForm\"},{\"name\":\"familyMembers\",\"kind\":\"object\",\"type\":\"FamilyMember\",\"relationName\":\"ClientProfileToFamilyMember\"},{\"name\":\"shiftCheckIns\",\"kind\":\"object\",\"type\":\"PswShiftLog\",\"relationName\":\"ClientShiftLogs\"},{\"name\":\"adlCareLogs\",\"kind\":\"object\",\"type\":\"AdlCareLog\",\"relationName\":\"ClientAdlLogs\"},{\"name\":\"pswVitals\",\"kind\":\"object\",\"type\":\"PswVitalSign\",\"relationName\":\"ClientPswVitals\"},{\"name\":\"behaviorNotes\",\"kind\":\"object\",\"type\":\"BehaviorNote\",\"relationName\":\"ClientBehaviorNotes\"},{\"name\":\"nutritionRecords\",\"kind\":\"object\",\"type\":\"NutritionRecord\",\"relationName\":\"ClientNutrition\"},{\"name\":\"mobilityLogs\",\"kind\":\"object\",\"type\":\"MobilityLog\",\"relationName\":\"ClientMobility\"},{\"name\":\"infectionLogs\",\"kind\":\"object\",\"type\":\"InfectionControlChecklist\",\"relationName\":\"ClientInfectionControl\"},{\"name\":\"narrativeNotes\",\"kind\":\"object\",\"type\":\"NarrativeProgressNote\",\"relationName\":\"ClientNarrativeNotes\"},{\"name\":\"carePlanFollowUps\",\"kind\":\"object\",\"type\":\"CarePlanFollowUp\",\"relationName\":\"ClientCarePlanFollowUp\"}],\"dbName\":\"client_profiles\"},\"PswProfile\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"fullName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"full_name\"},{\"name\":\"bio\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"languages\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"serviceAreas\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_areas\"},{\"name\":\"availabilityJson\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"availability_json\"},{\"name\":\"isApproved\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_approved\"},{\"name\":\"approvedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"approved_at\"},{\"name\":\"trustScore\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"trust_score\"},{\"name\":\"hasCompletedInduction\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"has_completed_induction\"},{\"name\":\"isLockedForRetraining\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_locked_for_retraining\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"address\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"avatarUrl\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"avatar_url\"},{\"name\":\"skills\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"messageThreads\",\"kind\":\"object\",\"type\":\"MessageThread\",\"relationName\":\"PswToThreads\"},{\"name\":\"availability\",\"kind\":\"object\",\"type\":\"PswAvailability\",\"relationName\":\"PswToAvailability\"},{\"name\":\"documents\",\"kind\":\"object\",\"type\":\"PswDocument\",\"relationName\":\"PswToDocuments\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"PswProfileToTenant\"},{\"name\":\"user\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"PswProfileToUser\"},{\"name\":\"assignments\",\"kind\":\"object\",\"type\":\"ShiftAssignment\",\"relationName\":\"PswToAssignments\"},{\"name\":\"timesheets\",\"kind\":\"object\",\"type\":\"Timesheet\",\"relationName\":\"PswToTimesheets\"},{\"name\":\"checkEvents\",\"kind\":\"object\",\"type\":\"VisitCheckEvent\",\"relationName\":\"PswToCheckEvents\"},{\"name\":\"checklists\",\"kind\":\"object\",\"type\":\"VisitChecklist\",\"relationName\":\"PswToChecklists\"},{\"name\":\"notes\",\"kind\":\"object\",\"type\":\"VisitNote\",\"relationName\":\"PswToNotes\"},{\"name\":\"assignedVisits\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"PswToVisits\"},{\"name\":\"handovers\",\"kind\":\"object\",\"type\":\"ShiftHandover\",\"relationName\":\"PswProfileToShiftHandover\"},{\"name\":\"overrides\",\"kind\":\"object\",\"type\":\"AvailabilityOverride\",\"relationName\":\"AvailabilityOverrideToPswProfile\"},{\"name\":\"payouts\",\"kind\":\"object\",\"type\":\"Payout\",\"relationName\":\"PayoutToPswProfile\"},{\"name\":\"fleetStatus\",\"kind\":\"object\",\"type\":\"FleetStatus\",\"relationName\":\"FleetStatusToPswProfile\"},{\"name\":\"supervisionLogs\",\"kind\":\"object\",\"type\":\"SupervisionLog\",\"relationName\":\"PswProfileToSupervisionLog\"},{\"name\":\"matches\",\"kind\":\"object\",\"type\":\"VisitMatch\",\"relationName\":\"VisitMatches\"},{\"name\":\"mileageLogs\",\"kind\":\"object\",\"type\":\"MileageLog\",\"relationName\":\"MileageLogToPswProfile\"},{\"name\":\"performanceReviews\",\"kind\":\"object\",\"type\":\"PerformanceReview\",\"relationName\":\"PerformanceReviewToPswProfile\"}],\"dbName\":\"psw_profiles\"},\"Visit\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"serviceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_id\"},{\"name\":\"requestedStartAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"requested_start_at\"},{\"name\":\"durationMinutes\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"duration_minutes\"},{\"name\":\"recurrenceRuleString\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"recurrence_rule_string\"},{\"name\":\"recurrenceEndDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"recurrence_end_date\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"assignedPswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"assigned_psw_id\"},{\"name\":\"serviceAddressLine1\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_address_line1\"},{\"name\":\"serviceAddressLine2\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_address_line2\"},{\"name\":\"serviceCity\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_city\"},{\"name\":\"serviceProvince\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_province\"},{\"name\":\"servicePostalCode\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_postal_code\"},{\"name\":\"serviceLat\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"service_lat\"},{\"name\":\"serviceLng\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"service_lng\"},{\"name\":\"clientNotes\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_notes\"},{\"name\":\"coordinatorNotes\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"coordinator_notes\"},{\"name\":\"cancellationReason\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"cancellation_reason\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"bookingId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"booking_id\"},{\"name\":\"crisisMode\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"crisis_mode\"},{\"name\":\"priority\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"managementNotes\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"management_notes\"},{\"name\":\"requiredSkills\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"required_skills\"},{\"name\":\"isSurgeActive\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_surge_active\"},{\"name\":\"surgeMultiplier\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"surge_multiplier\"},{\"name\":\"DailyEntry\",\"kind\":\"object\",\"type\":\"DailyEntry\",\"relationName\":\"DailyEntryToVisit\"},{\"name\":\"incidents\",\"kind\":\"object\",\"type\":\"Incident\",\"relationName\":\"IncidentToVisit\"},{\"name\":\"assignments\",\"kind\":\"object\",\"type\":\"ShiftAssignment\",\"relationName\":\"ShiftAssignmentToVisit\"},{\"name\":\"timesheetItems\",\"kind\":\"object\",\"type\":\"TimesheetItem\",\"relationName\":\"TimesheetItemToVisit\"},{\"name\":\"checkEvents\",\"kind\":\"object\",\"type\":\"VisitCheckEvent\",\"relationName\":\"VisitToVisitCheckEvent\"},{\"name\":\"checklists\",\"kind\":\"object\",\"type\":\"VisitChecklist\",\"relationName\":\"VisitToVisitChecklist\"},{\"name\":\"notes\",\"kind\":\"object\",\"type\":\"VisitNote\",\"relationName\":\"VisitToVisitNote\"},{\"name\":\"feedbacks\",\"kind\":\"object\",\"type\":\"Feedback\",\"relationName\":\"FeedbackToVisit\"},{\"name\":\"matches\",\"kind\":\"object\",\"type\":\"VisitMatch\",\"relationName\":\"VisitToVisitMatch\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToVisits\"},{\"name\":\"booking\",\"kind\":\"object\",\"type\":\"Booking\",\"relationName\":\"BookingToVisit\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToVisit\"},{\"name\":\"service\",\"kind\":\"object\",\"type\":\"Service\",\"relationName\":\"ServiceToVisit\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToVisit\"},{\"name\":\"handovers\",\"kind\":\"object\",\"type\":\"ShiftHandover\",\"relationName\":\"ShiftHandoverToVisit\"},{\"name\":\"careFeedbacks\",\"kind\":\"object\",\"type\":\"CareFeedback\",\"relationName\":\"CareFeedbackToVisit\"},{\"name\":\"dailyAuditSignOff\",\"kind\":\"object\",\"type\":\"DailyAuditSignOff\",\"relationName\":\"DailyAuditSignOffToVisit\"}],\"dbName\":\"visits\"},\"Service\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"slug\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"baseRateHourly\",\"kind\":\"scalar\",\"type\":\"Decimal\",\"dbName\":\"base_rate_hourly\"},{\"name\":\"providerRateHourly\",\"kind\":\"scalar\",\"type\":\"Decimal\",\"dbName\":\"provider_rate_hourly\"},{\"name\":\"isActive\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_active\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"isFeatured\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_featured\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ServiceToTenant\"},{\"name\":\"visits\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"ServiceToVisit\"},{\"name\":\"waitlistEntries\",\"kind\":\"object\",\"type\":\"WaitlistEntry\",\"relationName\":\"ServiceToWaitlistEntry\"}],\"dbName\":\"services\"},\"VisitCheckEvent\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"eventType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"event_type\"},{\"name\":\"lat\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"lng\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"accuracyM\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"accuracy_m\"},{\"name\":\"computedDistanceM\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"computed_distance_m\"},{\"name\":\"deviceTimeIso\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"device_time_iso\"},{\"name\":\"serverTime\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"server_time\"},{\"name\":\"result\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"rejectReason\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"reject_reason\"},{\"name\":\"isOverride\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_override\"},{\"name\":\"overrideByUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"override_by_user_id\"},{\"name\":\"overrideReason\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"override_reason\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"overriddenBy\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"UserToVisitCheckEvent\"},{\"name\":\"pswProfile\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToCheckEvents\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToVisitCheckEvent\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"VisitToVisitCheckEvent\"}],\"dbName\":\"visit_check_events\"},\"VisitNote\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"noteText\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"note_text\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToNotes\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"VisitToVisitNote\"}],\"dbName\":\"visit_notes\"},\"VisitChecklist\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"checklist\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"checklist_json\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToChecklists\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"VisitToVisitChecklist\"}],\"dbName\":\"visit_checklists\"},\"Incident\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"reporterUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"reporter_user_id\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"resolutionNotes\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"resolution_notes\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"severity\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"reportedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"reported_at\"},{\"name\":\"acknowledgedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"acknowledged_at\"},{\"name\":\"acknowledgedBy\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"acknowledged_by\"},{\"name\":\"acknowledger\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"Acknowledger\"},{\"name\":\"reporter\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"Reporter\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"IncidentToTenant\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"IncidentToVisit\"}],\"dbName\":\"incidents\"},\"DailyEntry\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"staffId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"staff_id\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"adlData\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"adl_data\"},{\"name\":\"medication\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"mood\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"vitals\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"signature\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToDailyEntry\"},{\"name\":\"staff\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"DailyEntryToUser\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"DailyEntryToTenant\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"DailyEntryToVisit\"}],\"dbName\":\"daily_entries\"},\"Booking\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"branchId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"branch_id\"},{\"name\":\"startAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"start_at\"},{\"name\":\"endAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"end_at\"},{\"name\":\"serviceType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_type\"},{\"name\":\"priority\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"recurrenceRule\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"recurrence_rule\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"BookingToClientProfile\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"BookingToTenant\"},{\"name\":\"visits\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"BookingToVisit\"}],\"dbName\":\"bookings\"},\"PswAvailability\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"dayOfWeek\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"day_of_week\"},{\"name\":\"startTime\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"start_time\"},{\"name\":\"endTime\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"end_time\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToAvailability\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"PswAvailabilityToTenant\"}],\"dbName\":\"psw_availability\"},\"PswDocument\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"docType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"doc_type\"},{\"name\":\"fileKey\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"file_key\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"expiryDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"expiry_date\"},{\"name\":\"verifiedBy\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"verified_by\"},{\"name\":\"verifiedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"verified_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToDocuments\"},{\"name\":\"verifier\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"VerifiedBy\"}],\"dbName\":\"psw_documents\"},\"ShiftAssignment\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"score\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"assignedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"assigned_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToAssignments\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ShiftAssignmentToTenant\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"ShiftAssignmentToVisit\"}],\"dbName\":\"shift_assignments\"},\"Timesheet\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"weekId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"week_id\"},{\"name\":\"totalMinutes\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"total_minutes\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"submittedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"submitted_at\"},{\"name\":\"reviewedBy\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"reviewed_by\"},{\"name\":\"reviewedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"reviewed_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"items\",\"kind\":\"object\",\"type\":\"TimesheetItem\",\"relationName\":\"TimesheetToTimesheetItem\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswToTimesheets\"},{\"name\":\"reviewer\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"ReviewedBy\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToTimesheet\"}],\"dbName\":\"timesheets\"},\"TimesheetItem\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"timesheetId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"timesheet_id\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"minutes\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"timesheet\",\"kind\":\"object\",\"type\":\"Timesheet\",\"relationName\":\"TimesheetToTimesheetItem\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"TimesheetItemToVisit\"}],\"dbName\":\"timesheet_items\"},\"ShiftHandover\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"handoverNotes\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"handover_notes\"},{\"name\":\"safetyConcerns\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"safety_concerns\"},{\"name\":\"suppliesNeeded\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"supplies_needed\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswProfileToShiftHandover\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"ShiftHandoverToVisit\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ShiftHandoverToTenant\"}],\"dbName\":\"shift_handovers\"},\"AvailabilityOverride\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"date\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"startTime\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"start_time\"},{\"name\":\"endTime\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"end_time\"},{\"name\":\"isAvailable\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_available\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"AvailabilityOverrideToPswProfile\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"AvailabilityOverrideToTenant\"}],\"dbName\":\"psw_availability_overrides\"},\"VisitMatch\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"score\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"VisitToVisitMatch\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"VisitMatches\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToVisitMatch\"}],\"dbName\":\"visit_matches\"},\"WaitlistEntry\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"serviceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_id\"},{\"name\":\"priority\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"requestedStartAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"requested_start_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToWaitlistEntry\"},{\"name\":\"service\",\"kind\":\"object\",\"type\":\"Service\",\"relationName\":\"ServiceToWaitlistEntry\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToWaitlistEntry\"}],\"dbName\":\"waitlist_entries\"},\"StaffTask\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"priority\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"dueDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"due_date\"},{\"name\":\"assigneeId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"assignee_id\"},{\"name\":\"groupId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"group_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"StaffTaskToTenant\"},{\"name\":\"group\",\"kind\":\"object\",\"type\":\"StaffGroup\",\"relationName\":\"StaffGroupToStaffTask\"},{\"name\":\"assignee\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"AssignedTasks\"}],\"dbName\":\"staff_tasks\"},\"StaffGroup\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"StaffGroupToTenant\"},{\"name\":\"members\",\"kind\":\"object\",\"type\":\"StaffGroupMember\",\"relationName\":\"StaffGroupToStaffGroupMember\"},{\"name\":\"tasks\",\"kind\":\"object\",\"type\":\"StaffTask\",\"relationName\":\"StaffGroupToStaffTask\"}],\"dbName\":\"staff_groups\"},\"StaffGroupMember\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"groupId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"group_id\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"role\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"group\",\"kind\":\"object\",\"type\":\"StaffGroup\",\"relationName\":\"StaffGroupToStaffGroupMember\"},{\"name\":\"user\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"StaffGroupMemberToUser\"}],\"dbName\":\"staff_group_members\"},\"BookingRequest\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"serviceType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_type\"},{\"name\":\"preferredDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"preferred_date\"},{\"name\":\"preferredTime\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"preferred_time\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"BookingRequestToClientProfile\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"BookingRequestToTenant\"}],\"dbName\":\"booking_requests\"},\"FleetStatus\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"lat\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"lng\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"batteryLevel\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"battery_level\"},{\"name\":\"lastHeartbeatAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_heartbeat_at\"},{\"name\":\"currentVisitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"current_visit_id\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"FleetStatusToPswProfile\"}],\"dbName\":\"fleet_status\"},\"CarePlan\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"diagnoses\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clinicalGoals\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"clinical_goals\"},{\"name\":\"interventions\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"interventions\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"reviewDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"review_date\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"CarePlanToClientProfile\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"CarePlanToTenant\"},{\"name\":\"authorId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"author_id\"},{\"name\":\"version\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"isArchived\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_archived\"},{\"name\":\"outcomeNotes\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"outcome_notes\"},{\"name\":\"author\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"CarePlanAuthor\"}],\"dbName\":\"care_plans\"},\"ClinicalRecord\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"data\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"data_json\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ClinicalRecordToTenant\"}],\"dbName\":\"clinical_records\"},\"ClinicalAssessment\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"rnId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"rn_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"assessmentData\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"assessment_data\"},{\"name\":\"score\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"recommendations\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToClinicalAssessment\"},{\"name\":\"rn\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"ClinicalAssessmentToUser\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ClinicalAssessmentToTenant\"}],\"dbName\":\"clinical_assessments\"},\"MedicationRecon\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"rnId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"rn_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"reconData\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"recon_data\"},{\"name\":\"discrepancies\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToMedicationRecon\"},{\"name\":\"rn\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"MedicationReconToUser\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"MedicationReconToTenant\"}],\"dbName\":\"medication_reconciliations\"},\"SupervisionLog\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"rnId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"rn_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"competencies\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"isSatisfactory\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_satisfactory\"},{\"name\":\"feedback\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PswProfileToSupervisionLog\"},{\"name\":\"rn\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"SupervisionLogToUser\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"SupervisionLogToTenant\"}],\"dbName\":\"supervision_logs\"},\"HealthID\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"did\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"publicKey\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"public_key\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"}],\"dbName\":\"health_ids\"},\"FhirSyncLog\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"direction\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"resourceType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"resource_type\"},{\"name\":\"externalId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"external_id\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"error\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"timestamp\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"FhirSyncLogToTenant\"}],\"dbName\":\"fhir_sync_logs\"},\"VitalSign\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"patientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"patient_id\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"value\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"unit\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"source\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"recordedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"recorded_at\"},{\"name\":\"patient\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToVitalSign\"}],\"dbName\":\"vital_signs\"},\"PatientAlert\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"patientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"patient_id\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"severity\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"message\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"PatientAlertToTenant\"},{\"name\":\"patient\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToPatientAlert\"}],\"dbName\":\"patient_alerts\"},\"Medication\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"genericName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"generic_name\"},{\"name\":\"dosageForm\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"dosage_form\"},{\"name\":\"strength\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"instructions\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"prescriptions\",\"kind\":\"object\",\"type\":\"Prescription\",\"relationName\":\"MedicationToPrescription\"}],\"dbName\":\"medications\"},\"Prescription\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"patientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"patient_id\"},{\"name\":\"medicationId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"medication_id\"},{\"name\":\"prescriberId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"prescriber_id\"},{\"name\":\"dosage\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"frequency\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"route\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"startDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"start_date\"},{\"name\":\"endDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"end_date\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"PrescriptionToTenant\"},{\"name\":\"patient\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToPrescription\"},{\"name\":\"medication\",\"kind\":\"object\",\"type\":\"Medication\",\"relationName\":\"MedicationToPrescription\"},{\"name\":\"marEntries\",\"kind\":\"object\",\"type\":\"MAR_Entry\",\"relationName\":\"MAR_EntryToPrescription\"}],\"dbName\":\"prescriptions\"},\"MAR_Entry\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"patientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"patient_id\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"prescriptionId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"prescription_id\"},{\"name\":\"administerId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"administer_id\"},{\"name\":\"administeredById\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"administered_by_id\"},{\"name\":\"adminTime\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"admin_time\"},{\"name\":\"scheduledTime\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"scheduled_time\"},{\"name\":\"administeredAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"administered_at\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"medicationName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"medication_name\"},{\"name\":\"dosage\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"route\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"patient\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToMAR_Entry\"},{\"name\":\"prescription\",\"kind\":\"object\",\"type\":\"Prescription\",\"relationName\":\"MAR_EntryToPrescription\"}],\"dbName\":\"mar_entries\"},\"EVVRecord\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"checkType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"check_type\"},{\"name\":\"lat\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"lng\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"accuracy\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"verificationMethod\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"verification_method\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"overrideById\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"override_by_id\"},{\"name\":\"overrideReason\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"override_reason\"},{\"name\":\"rawData\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"raw_data\"},{\"name\":\"capturedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"captured_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"EVVRecordToTenant\"}],\"dbName\":\"evv_records\"},\"ServiceAuthorization\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"serviceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_id\"},{\"name\":\"fundingSource\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"funding_source\"},{\"name\":\"authorizedHours\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"authorized_hours\"},{\"name\":\"usedHours\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"used_hours\"},{\"name\":\"startDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"start_date\"},{\"name\":\"endDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"end_date\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"authCode\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"auth_code\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToServiceAuthorization\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ServiceAuthorizationToTenant\"}],\"dbName\":\"service_authorizations\"},\"ConsentForm\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"formType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"form_type\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"signatureDataUrl\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"signature_data_url\"},{\"name\":\"signedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"signed_at\"},{\"name\":\"expiresAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"expires_at\"},{\"name\":\"documentKey\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"document_key\"},{\"name\":\"witnessName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"witness_name\"},{\"name\":\"templateVersion\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"template_version\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToConsentForm\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ConsentFormToTenant\"}],\"dbName\":\"consent_forms\"},\"DailyAuditSignOff\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"rnId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"rn_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"clinicalComment\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"clinical_comment\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"signedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"signed_at\"},{\"name\":\"rn\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"DailyAuditSignOffToUser\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"DailyAuditSignOffToTenant\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"DailyAuditSignOffToVisit\"}],\"dbName\":\"daily_audit_signoffs\"},\"WellnessPulse\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"score\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"note\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"user\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"UserToWellnessPulse\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToWellnessPulse\"}],\"dbName\":\"wellness_pulses\"},\"Invoice\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"currency\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"subtotal\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"tax\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"total\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"stripeInvoiceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"stripe_invoice_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToInvoice\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"InvoiceToTenant\"},{\"name\":\"payments\",\"kind\":\"object\",\"type\":\"Payment\",\"relationName\":\"InvoiceToPayment\"}],\"dbName\":\"invoices\"},\"Payment\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"invoiceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"invoice_id\"},{\"name\":\"stripePaymentIntentId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"stripe_payment_intent_id\"},{\"name\":\"amount\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"invoice\",\"kind\":\"object\",\"type\":\"Invoice\",\"relationName\":\"InvoiceToPayment\"}],\"dbName\":\"payments\"},\"InsuranceProvider\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"networkId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"network_id\"},{\"name\":\"contactPhone\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"contact_phone\"},{\"name\":\"claimsEmail\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"claims_email\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"InsuranceProviderToTenant\"},{\"name\":\"claims\",\"kind\":\"object\",\"type\":\"Claim\",\"relationName\":\"ClaimToInsuranceProvider\"}],\"dbName\":\"insurance_providers\"},\"Claim\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"patientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"patient_id\"},{\"name\":\"providerId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"provider_id\"},{\"name\":\"serviceDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"service_date\"},{\"name\":\"amount\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"denialReason\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"denial_reason\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ClaimToTenant\"},{\"name\":\"patient\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClaimToClientProfile\"},{\"name\":\"provider\",\"kind\":\"object\",\"type\":\"InsuranceProvider\",\"relationName\":\"ClaimToInsuranceProvider\"}],\"dbName\":\"claims\"},\"BillingCode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"code\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"defaultRate\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"default_rate\"}],\"dbName\":\"billing_codes\"},\"Payout\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"amount\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"currency\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"processedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"processed_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PayoutToPswProfile\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"PayoutToTenant\"}],\"dbName\":\"payouts\"},\"MileageLog\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"date\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"fromVisitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"from_visit_id\"},{\"name\":\"toVisitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"to_visit_id\"},{\"name\":\"fromAddress\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"from_address\"},{\"name\":\"toAddress\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"to_address\"},{\"name\":\"distanceKm\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"distance_km\"},{\"name\":\"travelMinutes\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"travel_minutes\"},{\"name\":\"reimbursementRate\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"reimbursement_rate\"},{\"name\":\"reimbursementAmount\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"reimbursement_amount\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"MileageLogToPswProfile\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"MileageLogToTenant\"}],\"dbName\":\"mileage_logs\"},\"ChartOfAccount\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"code\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ChartOfAccountToTenant\"},{\"name\":\"journalEntries\",\"kind\":\"object\",\"type\":\"JournalEntry\",\"relationName\":\"ChartOfAccountToJournalEntry\"}],\"dbName\":\"financial_accounts\"},\"FinancialTransaction\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"referenceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"reference_id\"},{\"name\":\"amount\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"currency\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"FinancialTransactionToTenant\"},{\"name\":\"journalEntries\",\"kind\":\"object\",\"type\":\"JournalEntry\",\"relationName\":\"FinancialTransactionToJournalEntry\"},{\"name\":\"reconciliations\",\"kind\":\"object\",\"type\":\"FinancialReconciliation\",\"relationName\":\"FinancialReconciliationToFinancialTransaction\"}],\"dbName\":\"financial_transactions\"},\"JournalEntry\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"transactionId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"transaction_id\"},{\"name\":\"accountId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"account_id\"},{\"name\":\"debit\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"paidOutAmount\",\"kind\":\"scalar\",\"type\":\"Decimal\",\"dbName\":\"paid_out_amount\"},{\"name\":\"currency\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"balanceBefore\",\"kind\":\"scalar\",\"type\":\"Decimal\",\"dbName\":\"balance_before\"},{\"name\":\"balanceAfter\",\"kind\":\"scalar\",\"type\":\"Decimal\",\"dbName\":\"balance_after\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"transaction\",\"kind\":\"object\",\"type\":\"FinancialTransaction\",\"relationName\":\"FinancialTransactionToJournalEntry\"},{\"name\":\"account\",\"kind\":\"object\",\"type\":\"ChartOfAccount\",\"relationName\":\"ChartOfAccountToJournalEntry\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"JournalEntryToTenant\"}],\"dbName\":\"financial_journal_entries\"},\"FinancialReconciliation\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"transactionId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"transaction_id\"},{\"name\":\"bankTransactionId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"bank_transaction_id\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"matchedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"matched_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"transaction\",\"kind\":\"object\",\"type\":\"FinancialTransaction\",\"relationName\":\"FinancialReconciliationToFinancialTransaction\"},{\"name\":\"bankTransaction\",\"kind\":\"object\",\"type\":\"BankTransaction\",\"relationName\":\"BankTransactionToFinancialReconciliation\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"FinancialReconciliationToTenant\"}],\"dbName\":\"financial_reconciliations\"},\"BankTransaction\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"bankDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"bank_date\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"amount\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"currency\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"externalRef\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"external_ref\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"BankTransactionToTenant\"},{\"name\":\"reconciliations\",\"kind\":\"object\",\"type\":\"FinancialReconciliation\",\"relationName\":\"BankTransactionToFinancialReconciliation\"}],\"dbName\":\"financial_bank_transactions\"},\"TransactionLedger\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"transactionType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"transaction_type\"},{\"name\":\"referenceType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"reference_type\"},{\"name\":\"referenceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"reference_id\"},{\"name\":\"debitAccount\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"debit_account\"},{\"name\":\"creditAccount\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"credit_account\"},{\"name\":\"amount\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"currency\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"actorUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"actor_user_id\"},{\"name\":\"ipAddress\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"ip_address\"},{\"name\":\"checksum\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"previousChecksum\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"previous_checksum\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"voidedByEntryId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"voided_by_entry_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToTransactionLedger\"},{\"name\":\"actor\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"LedgerActor\"}],\"dbName\":\"transaction_ledger\"},\"BlogPost\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"slug\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"excerpt\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"contentHtml\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"content_html\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"publishedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"published_at\"},{\"name\":\"authorUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"author_user_id\"},{\"name\":\"featureImageDocId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"feature_image_doc_id\"},{\"name\":\"seoTitle\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"seo_title\"},{\"name\":\"seoDescription\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"seo_description\"},{\"name\":\"canonicalUrl\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"canonical_url\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"author\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"BlogPostToUser\"},{\"name\":\"targetRole\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"target_role\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"}],\"dbName\":\"blog_posts\"},\"Feedback\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"rating\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"comment\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToFeedback\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"FeedbackToTenant\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"FeedbackToVisit\"}],\"dbName\":\"feedbacks\"},\"TrainingModule\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"videoUrl\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"video_url\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToTrainingModule\"},{\"name\":\"assignments\",\"kind\":\"object\",\"type\":\"TrainingAssignment\",\"relationName\":\"TrainingAssignmentToTrainingModule\"}],\"dbName\":\"training_modules\"},\"TrainingAssignment\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"staffId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"staff_id\"},{\"name\":\"moduleId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"module_id\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"completedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"completed_at\"},{\"name\":\"assignedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"assigned_at\"},{\"name\":\"dueDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"due_date\"},{\"name\":\"module\",\"kind\":\"object\",\"type\":\"TrainingModule\",\"relationName\":\"TrainingAssignmentToTrainingModule\"}],\"dbName\":\"training_assignments\"},\"Survey\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"targetRole\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"target_role\"},{\"name\":\"questions\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"questions_json\"},{\"name\":\"isActive\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_active\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"SurveyToTenant\"},{\"name\":\"responses\",\"kind\":\"object\",\"type\":\"SurveyResponse\",\"relationName\":\"SurveyToSurveyResponse\"}],\"dbName\":\"surveys\"},\"SurveyResponse\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"surveyId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"survey_id\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"answers\",\"kind\":\"scalar\",\"type\":\"Json\",\"dbName\":\"answers_json\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"survey\",\"kind\":\"object\",\"type\":\"Survey\",\"relationName\":\"SurveyToSurveyResponse\"}],\"dbName\":\"survey_responses\"},\"Region\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"city\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"province\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"boundary\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"boundary_json\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"RegionToTenant\"},{\"name\":\"stats\",\"kind\":\"object\",\"type\":\"BranchCapacity\",\"relationName\":\"BranchCapacityToRegion\"}],\"dbName\":\"regions\"},\"BranchCapacity\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"regionId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"region_id\"},{\"name\":\"totalStaff\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"total_staff\"},{\"name\":\"availableStaff\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"available_staff\"},{\"name\":\"activeVisits\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"active_visits\"},{\"name\":\"pendingBookings\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"pending_bookings\"},{\"name\":\"utilizationRate\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"utilization_rate\"},{\"name\":\"timestamp\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"region\",\"kind\":\"object\",\"type\":\"Region\",\"relationName\":\"BranchCapacityToRegion\"}],\"dbName\":\"branch_capacity\"},\"BranchStat\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"date\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"utilization\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"revenue\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"churnRate\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"churn_rate\"},{\"name\":\"activeClients\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"active_clients\"},{\"name\":\"activeProviders\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"active_providers\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"BranchStatToTenant\"}],\"dbName\":\"branch_stats\"},\"ComplianceRecord\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"score\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"lastSyncAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_sync_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ComplianceRecordToTenant\"}],\"dbName\":\"compliance_records\"},\"Franchise\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"resellerId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"reseller_id\"},{\"name\":\"ownerUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"owner_user_id\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"reseller\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ResellerTenants\"},{\"name\":\"agreements\",\"kind\":\"object\",\"type\":\"ResellerAgreement\",\"relationName\":\"FranchiseToResellerAgreement\"},{\"name\":\"clients\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToFranchise\"}],\"dbName\":\"franchises\"},\"ResellerAgreement\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"franchiseId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"franchise_id\"},{\"name\":\"terms\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"feePercentage\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"fee_percentage\"},{\"name\":\"startDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"start_date\"},{\"name\":\"endDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"end_date\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"franchise\",\"kind\":\"object\",\"type\":\"Franchise\",\"relationName\":\"FranchiseToResellerAgreement\"}],\"dbName\":\"reseller_agreements\"},\"Supplier\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"contactName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"contact_name\"},{\"name\":\"email\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"phone\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"purchaseOrders\",\"kind\":\"object\",\"type\":\"PurchaseOrder\",\"relationName\":\"PurchaseOrderToSupplier\"}],\"dbName\":\"suppliers\"},\"InventoryItem\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"sku\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"quantity\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"reorderPoint\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"reorder_point\"},{\"name\":\"unitPrice\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"unit_price\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"InventoryItemToTenant\"},{\"name\":\"ClientProfile\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToInventoryItem\"},{\"name\":\"clientProfileId\",\"kind\":\"scalar\",\"type\":\"String\"}],\"dbName\":\"inventory_items\"},\"PurchaseOrder\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"poNumber\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"po_number\"},{\"name\":\"supplierId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"supplier_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"totalAmount\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"total_amount\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"supplier\",\"kind\":\"object\",\"type\":\"Supplier\",\"relationName\":\"PurchaseOrderToSupplier\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"PurchaseOrderToTenant\"},{\"name\":\"ClientProfile\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToPurchaseOrder\"},{\"name\":\"clientProfileId\",\"kind\":\"scalar\",\"type\":\"String\"}],\"dbName\":\"purchase_orders\"},\"TelehealthSession\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"patientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"patient_id\"},{\"name\":\"providerId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"provider_id\"},{\"name\":\"startTime\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"start_time\"},{\"name\":\"endTime\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"end_time\"},{\"name\":\"meetingLink\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"meeting_link\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TelehealthSessionToTenant\"},{\"name\":\"patient\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToTelehealthSession\"},{\"name\":\"provider\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"TelehealthSessionToUser\"}],\"dbName\":\"telehealth_sessions\"},\"MarketplaceListing\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"total\",\"kind\":\"scalar\",\"type\":\"Decimal\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"providerId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"provider_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"MarketplaceListingToTenant\"}],\"dbName\":\"marketplace_listings\"},\"TenantSLA\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"uptimeTarget\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"uptime_target\"},{\"name\":\"responseTimeTarget\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"response_time_target\"},{\"name\":\"supportTier\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"support_tier\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"lastAuditAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_audit_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToTenantSLA\"}],\"dbName\":\"tenant_slas\"},\"AIRecommendation\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"priority\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"content\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"isApplied\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_applied\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"AIRecommendationToTenant\"}],\"dbName\":\"ai_recommendations\"},\"SentimentAnalysis\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"source\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"sourceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"source_id\"},{\"name\":\"score\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"magnitude\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"entities\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"SentimentAnalysisToTenant\"}],\"dbName\":\"sentiment_analysis\"},\"SecurityThreat\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"severity\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"source\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"detectedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"detected_at\"},{\"name\":\"resolvedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"resolved_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"SecurityThreatToTenant\"}],\"dbName\":\"security_threats\"},\"TechnicalAudit\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"audit_type\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"summary\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"issuesCount\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"issues_count\"},{\"name\":\"details\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"performedById\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"performed_by_id\"},{\"name\":\"performedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"performed_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"performedBy\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"PerformedAudits\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TechnicalAuditToTenant\"}],\"dbName\":\"technical_audits\"},\"FamilyNotification\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"message\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"isRead\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_read\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToFamilyNotification\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"FamilyNotificationToTenant\"}],\"dbName\":\"family_notifications\"},\"CareFeedback\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"visitId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"visit_id\"},{\"name\":\"rating\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"comment\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"triageStatus\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"triage_status\"},{\"name\":\"resolutionNotes\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"resolution_notes\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"CareFeedbackToClientProfile\"},{\"name\":\"visit\",\"kind\":\"object\",\"type\":\"Visit\",\"relationName\":\"CareFeedbackToVisit\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"CareFeedbackToTenant\"}],\"dbName\":\"care_feedbacks\"},\"Referral\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_name\"},{\"name\":\"clientPhone\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_phone\"},{\"name\":\"clientEmail\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_email\"},{\"name\":\"referrerName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"referrer_name\"},{\"name\":\"referrerOrg\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"referrer_org\"},{\"name\":\"referrerType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"referrer_type\"},{\"name\":\"serviceNeeded\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"service_needed\"},{\"name\":\"urgency\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clinicalNotes\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"clinical_notes\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"convertedClientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"converted_client_id\"},{\"name\":\"convertedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"converted_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"ReferralToTenant\"}],\"dbName\":\"referrals\"},\"FamilyMember\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"email\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"phone\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"relationship\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"accessLevel\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"access_level\"},{\"name\":\"linkedUserId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"linked_user_id\"},{\"name\":\"isEmergency\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_emergency\"},{\"name\":\"notifyVisits\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"notify_visits\"},{\"name\":\"notifyCare\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"notify_care\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientProfileToFamilyMember\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"FamilyMemberToTenant\"}],\"dbName\":\"family_members\"},\"PerformanceReview\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"reviewerId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"reviewer_id\"},{\"name\":\"periodStart\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"period_start\"},{\"name\":\"periodEnd\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"period_end\"},{\"name\":\"overallRating\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"overall_rating\"},{\"name\":\"kpis\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"goals\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"strengths\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"improvements\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"acknowledgedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"acknowledged_at\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"PswProfile\",\"relationName\":\"PerformanceReviewToPswProfile\"},{\"name\":\"reviewer\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"ReviewAuthor\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"PerformanceReviewToTenant\"}],\"dbName\":\"performance_reviews\"},\"WebhookEndpoint\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"url\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"events\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"secret\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"lastDeliveredAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"last_delivered_at\"},{\"name\":\"failureCount\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"failure_count\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"deliveries\",\"kind\":\"object\",\"type\":\"WebhookDelivery\",\"relationName\":\"WebhookDeliveryToWebhookEndpoint\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantToWebhookEndpoint\"}],\"dbName\":\"webhook_endpoints\"},\"WebhookDelivery\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"endpointId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"endpoint_id\"},{\"name\":\"event\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"payload\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"statusCode\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"status_code\"},{\"name\":\"responseBody\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"response_body\"},{\"name\":\"retryCount\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"retry_count\"},{\"name\":\"deliveredAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"delivered_at\"},{\"name\":\"endpoint\",\"kind\":\"object\",\"type\":\"WebhookEndpoint\",\"relationName\":\"WebhookDeliveryToWebhookEndpoint\"}],\"dbName\":\"webhook_deliveries\"},\"IoTEvent\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"deviceId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"device_id\"},{\"name\":\"deviceType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"device_type\"},{\"name\":\"payload\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"IoTEventToTenant\"},{\"name\":\"user\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"IoTEventToUser\"}],\"dbName\":\"iot_events\"},\"AppNotification\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"message\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"isRead\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_read\"},{\"name\":\"link\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"AppNotificationToTenant\"},{\"name\":\"user\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"AppNotificationToUser\"}],\"dbName\":\"app_notifications\"},\"GamificationProfile\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"careCoins\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"care_coins\"},{\"name\":\"currentTier\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"current_tier\"},{\"name\":\"lifetimePoints\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"lifetime_points\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"GamificationProfileToTenant\"},{\"name\":\"user\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"GamificationProfileToUser\"}],\"dbName\":\"gamification_profiles\"},\"AIInference\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"modelName\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"model_name\"},{\"name\":\"targetId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"target_id\"},{\"name\":\"targetType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"target_type\"},{\"name\":\"confidenceScore\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"confidence_score\"},{\"name\":\"predictionData\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"prediction_data_json\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"AIInferenceToTenant\"}],\"dbName\":\"ai_inferences\"},\"CommunicationLog\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"direction\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"channel\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"recipient\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"sender\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"subject\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"bodyText\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"body_text\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"externalId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"external_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"CommunicationLogToTenant\"}],\"dbName\":\"communication_logs\"},\"DailyActivity\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"userId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"user_id\"},{\"name\":\"role\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"dueDate\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"due_date\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"DailyActivityToTenant\"},{\"name\":\"user\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"DailyActivityToUser\"}],\"dbName\":\"daily_activities\"},\"PlatformScreen\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"roleId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"role_id\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"route\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"orderIndex\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"order_index\"},{\"name\":\"role\",\"kind\":\"object\",\"type\":\"PlatformRole\",\"relationName\":\"PlatformRoleToPlatformScreen\"},{\"name\":\"functions\",\"kind\":\"object\",\"type\":\"ScreenFunctionality\",\"relationName\":\"PlatformScreenToScreenFunctionality\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"}],\"dbName\":\"platform_screens\"},\"ScreenFunctionality\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"screenId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"screen_id\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"isCore\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"is_core\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"apiEndpoint\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"api_endpoint\"},{\"name\":\"dataEntryFields\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"data_entry_fields\"},{\"name\":\"justification\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"orderIndex\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"order_index\"},{\"name\":\"screen\",\"kind\":\"object\",\"type\":\"PlatformScreen\",\"relationName\":\"PlatformScreenToScreenFunctionality\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"updated_at\"}],\"dbName\":\"screen_functionalities\"},\"PswShiftLog\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"date\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"startTime\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"start_time\"},{\"name\":\"endTime\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"end_time\"},{\"name\":\"gpsLat\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"gps_lat\"},{\"name\":\"gpsLng\",\"kind\":\"scalar\",\"type\":\"Float\",\"dbName\":\"gps_lng\"},{\"name\":\"shiftStatus\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"signatureUrl\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"signature_url\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"UserShiftLogs\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientShiftLogs\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantShiftLogs\"}],\"dbName\":\"psw_shift_logs\"},\"AdlCareLog\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"hygiene\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"dressing\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"toileting\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"mobility\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"feeding\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"fluidIntake\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"fluid_intake_ml\"},{\"name\":\"sleepStatus\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"sleep_status\"},{\"name\":\"notes\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"created_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"UserAdlLogs\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientAdlLogs\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantAdlLogs\"}],\"dbName\":\"adl_care_logs\"},\"PswVitalSign\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"temperature\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"pulse\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"respiration\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"bloodPressure\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"blood_pressure\"},{\"name\":\"spO2\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"sp_o2\"},{\"name\":\"painLevel\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"pain_level\"},{\"name\":\"recordedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"recorded_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"UserPswVitals\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientPswVitals\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantPswVitals\"}],\"dbName\":\"psw_vital_signs\"},\"BehaviorNote\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"mood\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"orientation\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"behaviorChanges\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"behavior_changes\"},{\"name\":\"communication\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"recordedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"recorded_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"UserBehaviorNotes\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientBehaviorNotes\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantBehaviorNotes\"}],\"dbName\":\"behavior_notes\"},\"NutritionRecord\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"mealsTakenPct\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"meals_taken_pct\"},{\"name\":\"snacks\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"fluidIntakeMl\",\"kind\":\"scalar\",\"type\":\"Int\",\"dbName\":\"fluid_intake_ml\"},{\"name\":\"appetiteLevel\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"appetite_level\"},{\"name\":\"recordedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"recorded_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"UserNutrition\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientNutrition\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantNutrition\"}],\"dbName\":\"nutrition_records\"},\"MobilityLog\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"movementType\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"movement_type\"},{\"name\":\"distanceOrDur\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"distance_or_duration\"},{\"name\":\"assistanceLevel\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"assistance_level\"},{\"name\":\"painDuring\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"pain_during_movement\"},{\"name\":\"recordedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"recorded_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"UserMobility\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientMobility\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantMobility\"}],\"dbName\":\"mobility_logs\"},\"InfectionControlChecklist\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"handHygieneDone\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"hand_hygiene_done\"},{\"name\":\"ppeUsed\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"ppe_used\"},{\"name\":\"equipmentCleaned\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"equipment_cleaned\"},{\"name\":\"wasteDisposed\",\"kind\":\"scalar\",\"type\":\"Boolean\",\"dbName\":\"waste_disposed\"},{\"name\":\"recordedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"recorded_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"UserInfectionControl\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientInfectionControl\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantInfectionControl\"}],\"dbName\":\"infection_control_checklists\"},\"NarrativeProgressNote\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"whatWasDone\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"what_was_done\"},{\"name\":\"clientResponse\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_response\"},{\"name\":\"changesObserved\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"changes_observed\"},{\"name\":\"planForNext\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"plan_for_next_visit\"},{\"name\":\"recordedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"recorded_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"UserNarrativeNotes\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientNarrativeNotes\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantNarrativeNotes\"}],\"dbName\":\"narrative_progress_notes\"},\"CarePlanFollowUp\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"pswId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"psw_id\"},{\"name\":\"clientId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"client_id\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tenant_id\"},{\"name\":\"tasksAssigned\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tasks_assigned\"},{\"name\":\"tasksCompleted\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tasks_completed\"},{\"name\":\"notCompleted\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"tasks_not_completed\"},{\"name\":\"reasonNotDone\",\"kind\":\"scalar\",\"type\":\"String\",\"dbName\":\"reason_not_completed\"},{\"name\":\"recordedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\",\"dbName\":\"recorded_at\"},{\"name\":\"psw\",\"kind\":\"object\",\"type\":\"User\",\"relationName\":\"UserCarePlanFollowUp\"},{\"name\":\"client\",\"kind\":\"object\",\"type\":\"ClientProfile\",\"relationName\":\"ClientCarePlanFollowUp\"},{\"name\":\"tenant\",\"kind\":\"object\",\"type\":\"Tenant\",\"relationName\":\"TenantCarePlanFollowUp\"}],\"dbName\":\"care_plan_follow_ups\"},\"Clinic\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"name\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"location\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"patientVolume\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"efficiencyScore\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"revenue\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"patients\",\"kind\":\"object\",\"type\":\"Patient\",\"relationName\":\"ClinicToPatient\"}],\"dbName\":null},\"Patient\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"firstName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"lastName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"age\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"gender\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"avatarUrl\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clinicId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clinic\",\"kind\":\"object\",\"type\":\"Clinic\",\"relationName\":\"ClinicToPatient\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"FinancialRecord\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"month\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"revenue\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"expenses\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"clinicId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"FamilyAppointment\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"patientName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"doctorName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"date\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"time\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"location\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"FamilyCarePlanTask\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"patientName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"taskName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"category\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"timeSlot\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"isCompleted\",\"kind\":\"scalar\",\"type\":\"Boolean\"},{\"name\":\"completedBy\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"FamilyClinicalMessage\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"threadId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"senderName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"senderRole\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"content\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"timestamp\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"isRead\",\"kind\":\"scalar\",\"type\":\"Boolean\"}],\"dbName\":null},\"PatientIntake\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"patientName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"priority\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"franchiseCity\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"coordinatorId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"scheduledDate\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"scheduledTime\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"IntakeReferralMetric\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"sourceName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"conversionCount\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"totalLeads\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"JobOpening\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"department\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"location\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"applicationCount\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"postedDate\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"JobCandidate\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"candidateName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"appliedRole\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"department\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"source\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"rating\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"InterviewEvent\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"candidateName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"roleTarget\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"managerName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"scheduledDate\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"scheduledTime\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"InvoiceRecord\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"invoiceId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"patientName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clinicLocation\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"amount\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"issueDate\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"InsuranceClaim\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"claimCode\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"patientName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"provider\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"denialReason\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"amount\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"submissionDate\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"FinancialGoal\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"month\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"year\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"label\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"targetRevenue\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"actualRevenue\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"FacilityNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"facilityName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"location\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"managerName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"satisfaction\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"dailyVisits\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"StaffUtilization\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"staffName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"role\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"totalHours\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"clinicalHours\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"adminHours\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"OpsIssueTicket\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"title\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"facilityName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"severity\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"IncidentReportNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"incidentType\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"severity\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"franchise\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"description\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"AuditLogNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"franchise\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"auditDate\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"auditorName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"score\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"compliancePct\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"PatientSatisfactionNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"franchise\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"score\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"comments\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"type\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"SalesDealNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"dealName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"facilityTarget\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"amount\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"stage\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"repName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"KeyAccountNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"accountName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"contactName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"stage\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"potentialValue\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"probability\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"RepPerformanceNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"repName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"quota\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"attainment\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"meetings\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"pipelineValue\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"MarketingCampaignNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"campaignName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"platform\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"spend\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"revenue\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"leads\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"LocalGrowthNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"regionName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"patientAcqCost\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"newPatients\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"totalRevenue\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"ContentAssetNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"assetName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"assetType\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"author\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"thumbnailUrl\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"PatientAdmissionNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"patientName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"priority\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"condition\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"location\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"attendingPhys\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"ClinicalShiftNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"providerName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"role\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"startTime\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"endTime\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"facility\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"MedicalAuditNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"regionCode\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"survivalRate\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"readmissionRate\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"averageWaitTime\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"SupportTicketNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"franchiseName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"patientRef\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"issueType\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"assignedTo\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"PatientFeedbackNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"patientName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"franchiseName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"rating\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"comments\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"SystemTelemetryNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"serviceName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"uptimePercent\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"latencyMs\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"CurriculumNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"programName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"department\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"completionPct\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"InstructorNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"facilitatorName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"assignedCourse\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"CertificationNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"staffName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clinicalRole\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"certName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"expiresAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"FranchiseRevenueNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"monthYear\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"revenueAmt\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"patientVisits\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"growthPct\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"ClinicPerformanceNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"locationName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"managerName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"revenue\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"visits\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"growth\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"FranchiseBookingNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"patientName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clinicAssigned\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"appointmentType\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"scheduledTime\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"OutreachEventNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"eventName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"location\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"scheduledDate\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"participantGoal\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"ParticipantMetricNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"metricDate\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"totalReached\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"engagementScore\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"healthScreened\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"OutreachBudgetNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"projectName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"allocatedFunds\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"fundsUsed\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"sponsor\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"LocalNetworkNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"locationName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"occupancyRate\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"serverLoadScore\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"staffActive\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"LocalFinanceNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"monthLabel\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"grossRevenue\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"netMargin\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"growthYoY\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"LocalActivityNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"eventTitle\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"eventType\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"eventTime\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"LocalMarketingAnalyticNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"metricType\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"value\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"growthYoY\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"LocalCampaignNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"campaignName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"managerName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"roiFactor\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"LocalContentNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"assetTitle\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"assetType\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"deployedDate\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"SupportAgentNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"agentName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"shiftTime\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"activeTickets\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"status\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"TicketVolumeNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"hourlyMark\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"inboundCount\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"resolvedCount\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"ResolutionFeedbackNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"patientName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"csatScore\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"feedbackText\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"ClientTrendNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"monthLabel\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"revenueAmount\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"apptCount\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"ClientClinicNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"clinicName\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"starRating\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"revenueString\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"rank\",\"kind\":\"scalar\",\"type\":\"Int\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null},\"ClientDemographicNode\":{\"fields\":[{\"name\":\"id\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"tenantId\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"cohortGroup\",\"kind\":\"scalar\",\"type\":\"String\"},{\"name\":\"percentage\",\"kind\":\"scalar\",\"type\":\"Float\"},{\"name\":\"createdAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"},{\"name\":\"updatedAt\",\"kind\":\"scalar\",\"type\":\"DateTime\"}],\"dbName\":null}},\"enums\":{},\"types\":{}}")
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

