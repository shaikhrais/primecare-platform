
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
  firstName: 'firstName',
  lastName: 'lastName',
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
  roles: 'roles',
  preferredLanguage: 'preferredLanguage'
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
  baseCurrency: 'baseCurrency',
  parentTenantId: 'parentTenantId',
  subscriptionTier: 'subscriptionTier'
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
  providerId: 'providerId',
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

exports.Prisma.PromoCodeScalarFieldEnum = {
  id: 'id',
  code: 'code',
  discountPercent: 'discountPercent',
  targetTier: 'targetTier',
  maxUses: 'maxUses',
  currentUses: 'currentUses',
  expiresAt: 'expiresAt',
  isActive: 'isActive',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.SubscriptionUpgradeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  promoCodeId: 'promoCodeId',
  oldTier: 'oldTier',
  newTier: 'newTier',
  upgradedAt: 'upgradedAt'
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

exports.Prisma.ProviderProfileScalarFieldEnum = {
  id: 'id',
  userId: 'userId',
  fullName: 'fullName',
  bio: 'bio',
  languages: 'languages',
  serviceAreas: 'serviceAreas',
  availabilityJson: 'availabilityJson',
  providerType: 'providerType',
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
  assignedProviderId: 'assignedProviderId',
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
  providerId: 'providerId',
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
  providerId: 'providerId',
  noteText: 'noteText',
  createdAt: 'createdAt'
};

exports.Prisma.VisitChecklistScalarFieldEnum = {
  id: 'id',
  visitId: 'visitId',
  providerId: 'providerId',
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

exports.Prisma.ProviderAvailabilityScalarFieldEnum = {
  id: 'id',
  providerId: 'providerId',
  dayOfWeek: 'dayOfWeek',
  startTime: 'startTime',
  endTime: 'endTime',
  tenantId: 'tenantId'
};

exports.Prisma.ProviderDocumentScalarFieldEnum = {
  id: 'id',
  providerId: 'providerId',
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
  providerId: 'providerId',
  status: 'status',
  score: 'score',
  assignedAt: 'assignedAt',
  tenantId: 'tenantId'
};

exports.Prisma.TimesheetScalarFieldEnum = {
  id: 'id',
  providerId: 'providerId',
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
  providerId: 'providerId',
  visitId: 'visitId',
  tenantId: 'tenantId',
  handoverNotes: 'handoverNotes',
  safetyConcerns: 'safetyConcerns',
  suppliesNeeded: 'suppliesNeeded',
  createdAt: 'createdAt'
};

exports.Prisma.AvailabilityOverrideScalarFieldEnum = {
  id: 'id',
  providerId: 'providerId',
  tenantId: 'tenantId',
  date: 'date',
  startTime: 'startTime',
  endTime: 'endTime',
  isAvailable: 'isAvailable'
};

exports.Prisma.VisitMatchScalarFieldEnum = {
  id: 'id',
  visitId: 'visitId',
  providerId: 'providerId',
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
  providerId: 'providerId',
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
  providerId: 'providerId',
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
  providerId: 'providerId',
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
  providerId: 'providerId',
  tenantId: 'tenantId',
  status: 'status',
  score: 'score',
  note: 'note',
  createdAt: 'createdAt'
};

exports.Prisma.IntakeAssessmentScalarFieldEnum = {
  id: 'id',
  patientId: 'patientId',
  providerId: 'providerId',
  assessmentData: 'assessmentData',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.ChatSessionScalarFieldEnum = {
  id: 'id',
  userId: 'userId',
  messages: 'messages',
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
  providerId: 'providerId',
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
  providerId: 'providerId',
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
  currency: 'currency',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.FinancialTransactionScalarFieldEnum = {
  id: 'id',
  type: 'type',
  referenceId: 'referenceId',
  amount: 'amount',
  currency: 'currency',
  exchangeRate: 'exchangeRate',
  baseAmount: 'baseAmount',
  status: 'status',
  tenantId: 'tenantId',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  metadata: 'metadata'
};

exports.Prisma.JournalEntryScalarFieldEnum = {
  id: 'id',
  transactionId: 'transactionId',
  accountId: 'accountId',
  debit: 'debit',
  paidOutAmount: 'paidOutAmount',
  currency: 'currency',
  exchangeRate: 'exchangeRate',
  baseAmount: 'baseAmount',
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
  exchangeRate: 'exchangeRate',
  baseAmount: 'baseAmount',
  description: 'description',
  actorUserId: 'actorUserId',
  ipAddress: 'ipAddress',
  checksum: 'checksum',
  previousChecksum: 'previousChecksum',
  status: 'status',
  voidedByEntryId: 'voidedByEntryId',
  metadata: 'metadata',
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
  providerId: 'providerId',
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
  providerId: 'providerId',
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
  auditStatus: 'auditStatus',
  auditDate: 'auditDate',
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

exports.Prisma.ProviderShiftLogScalarFieldEnum = {
  id: 'id',
  providerId: 'providerId',
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
  providerId: 'providerId',
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

exports.Prisma.ProviderVitalSignScalarFieldEnum = {
  id: 'id',
  providerId: 'providerId',
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
  providerId: 'providerId',
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
  providerId: 'providerId',
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
  providerId: 'providerId',
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
  providerId: 'providerId',
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
  providerId: 'providerId',
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
  providerId: 'providerId',
  clientId: 'clientId',
  tenantId: 'tenantId',
  tasksAssigned: 'tasksAssigned',
  tasksCompleted: 'tasksCompleted',
  notCompleted: 'notCompleted',
  reasonNotDone: 'reasonNotDone',
  recordedAt: 'recordedAt'
};

exports.Prisma.DynamicFeatureRecordScalarFieldEnum = {
  id: 'id',
  featureId: 'featureId',
  tenantId: 'tenantId',
  patientId: 'patientId',
  entityType: 'entityType',
  payload: 'payload',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.ScreenConfigurationScalarFieldEnum = {
  id: 'id',
  screenId: 'screenId',
  uiComponentType: 'uiComponentType',
  layoutType: 'layoutType',
  cssStyles: 'cssStyles',
  metadata: 'metadata',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.ImplementationEventScalarFieldEnum = {
  id: 'id',
  featureName: 'featureName',
  version: 'version',
  status: 'status',
  payload: 'payload',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.VerificationLogScalarFieldEnum = {
  id: 'id',
  implementationId: 'implementationId',
  verifiedAt: 'verifiedAt',
  status: 'status',
  anomalyCount: 'anomalyCount',
  details: 'details'
};

exports.Prisma.AnomalyReportScalarFieldEnum = {
  id: 'id',
  logId: 'logId',
  type: 'type',
  severity: 'severity',
  message: 'message',
  createdAt: 'createdAt'
};

exports.Prisma.ArchitecturalLayerScalarFieldEnum = {
  id: 'id',
  name: 'name',
  description: 'description',
  orderIndex: 'orderIndex',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.ComponentPurposeScalarFieldEnum = {
  id: 'id',
  layerId: 'layerId',
  screenId: 'screenId',
  functionalityId: 'functionalityId',
  targetFile: 'targetFile',
  description: 'description',
  implementedWell: 'implementedWell',
  anomaliesDetail: 'anomaliesDetail',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.SystemDomainScalarFieldEnum = {
  id: 'id',
  name: 'name',
  description: 'description',
  owner: 'owner',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.SoftwareSystemScalarFieldEnum = {
  id: 'id',
  domainId: 'domainId',
  name: 'name',
  description: 'description',
  url: 'url',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.SysComponentScalarFieldEnum = {
  id: 'id',
  systemId: 'systemId',
  name: 'name',
  type: 'type',
  language: 'language',
  description: 'description',
  status: 'status',
  repoPath: 'repoPath',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.ApiContractScalarFieldEnum = {
  id: 'id',
  name: 'name',
  type: 'type',
  description: 'description',
  providerId: 'providerId',
  consumerId: 'consumerId',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.UIIntentScalarFieldEnum = {
  id: 'id',
  enumName: 'enumName',
  intentId: 'intentId',
  status: 'status',
  implementationClass: 'implementationClass',
  description: 'description',
  domain: 'domain',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.DataResourceScalarFieldEnum = {
  id: 'id',
  componentId: 'componentId',
  name: 'name',
  type: 'type',
  description: 'description',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.PlatformHealthHistoryScalarFieldEnum = {
  id: 'id',
  timestamp: 'timestamp',
  totalFiles: 'totalFiles',
  totalLoc: 'totalLoc',
  maturityRatio: 'maturityRatio',
  debtCount: 'debtCount',
  velocityRate: 'velocityRate'
};

exports.Prisma.AgentScreenBlueprintScalarFieldEnum = {
  id: 'id',
  screenRoute: 'screenRoute',
  description: 'description',
  reasoning: 'reasoning',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.BlueprintComponentScalarFieldEnum = {
  id: 'id',
  blueprintId: 'blueprintId',
  label: 'label',
  intent: 'intent',
  importance: 'importance',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.BdmLeadScalarFieldEnum = {
  id: 'id',
  title: 'title',
  company: 'company',
  status: 'status',
  contactName: 'contactName',
  contactEmail: 'contactEmail',
  contactPhone: 'contactPhone',
  territory: 'territory',
  expectedValue: 'expectedValue',
  notes: 'notes',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  assignedToUserId: 'assignedToUserId'
};

exports.Prisma.TerritoryExpansionPlanScalarFieldEnum = {
  id: 'id',
  regionName: 'regionName',
  targetDate: 'targetDate',
  status: 'status',
  budget: 'budget',
  demographicNotes: 'demographicNotes',
  competitorNotes: 'competitorNotes',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.PartnershipDealScalarFieldEnum = {
  id: 'id',
  partnerName: 'partnerName',
  partnerType: 'partnerType',
  status: 'status',
  startDate: 'startDate',
  endDate: 'endDate',
  dealValue: 'dealValue',
  terms: 'terms',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt',
  managedByUserId: 'managedByUserId'
};

exports.Prisma.CorporateKpiScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  metricName: 'metricName',
  metricValue: 'metricValue',
  metricTarget: 'metricTarget',
  unit: 'unit',
  recordedAt: 'recordedAt',
  roleFocus: 'roleFocus',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.CorporateReportScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  title: 'title',
  description: 'description',
  reportType: 'reportType',
  fileUrl: 'fileUrl',
  generatedBy: 'generatedBy',
  generatedAt: 'generatedAt',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.CorporateAlertScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  title: 'title',
  severity: 'severity',
  description: 'description',
  isResolved: 'isResolved',
  resolvedAt: 'resolvedAt',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.OrganizationNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  name: 'name',
  title: 'title',
  department: 'department',
  reportsToId: 'reportsToId',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.KpiMetricScalarFieldEnum = {
  id: 'id',
  label: 'label',
  value: 'value',
  category: 'category',
  measuredAt: 'measuredAt',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.FranchiseKpiScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  officeId: 'officeId',
  metricName: 'metricName',
  metricValue: 'metricValue',
  metricTarget: 'metricTarget',
  unit: 'unit',
  recordedAt: 'recordedAt',
  roleFocus: 'roleFocus',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.FranchiseReportScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  officeId: 'officeId',
  title: 'title',
  description: 'description',
  reportType: 'reportType',
  fileUrl: 'fileUrl',
  generatedBy: 'generatedBy',
  generatedAt: 'generatedAt',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.FranchiseAlertScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  officeId: 'officeId',
  title: 'title',
  severity: 'severity',
  description: 'description',
  isResolved: 'isResolved',
  resolvedAt: 'resolvedAt',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.FranchiseStaffNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  officeId: 'officeId',
  name: 'name',
  title: 'title',
  department: 'department',
  reportsToId: 'reportsToId',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.BusinessDevelopmentMetricScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  officeId: 'officeId',
  dealValue: 'dealValue',
  leads: 'leads',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.ClinicMetricScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  officeId: 'officeId',
  patientCount: 'patientCount',
  waitTimes: 'waitTimes',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.SupportTicketScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  officeId: 'officeId',
  status: 'status',
  resolution: 'resolution',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.PremiumFeatureStatusScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  screenId: 'screenId',
  activationDate: 'activationDate',
  expirationDate: 'expirationDate',
  usageCount: 'usageCount',
  isActive: 'isActive',
  metadata: 'metadata'
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

exports.Prisma.HealthNetRevenueNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  quarterLabel: 'quarterLabel',
  revenueValue: 'revenueValue',
  grossMargin: 'grossMargin',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.HealthNetEfficiencyNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  clinicName: 'clinicName',
  efficiencyScore: 'efficiencyScore',
  patientsSeen: 'patientsSeen',
  waitTimesAvg: 'waitTimesAvg',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.HealthNetNetworkNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  regionName: 'regionName',
  clinicCount: 'clinicCount',
  demographicCat: 'demographicCat',
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

exports.Prisma.SchedulerTrendNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  dayLabel: 'dayLabel',
  apptCount: 'apptCount',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.SchedulerRosterNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  providerName: 'providerName',
  specialty: 'specialty',
  shiftTime: 'shiftTime',
  isAvailable: 'isAvailable',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.SchedulerFacilityNodeScalarFieldEnum = {
  id: 'id',
  tenantId: 'tenantId',
  facilityName: 'facilityName',
  occupancyRate: 'occupancyRate',
  status: 'status',
  createdAt: 'createdAt',
  updatedAt: 'updatedAt'
};

exports.Prisma.SystemEventLogScalarFieldEnum = {
  id: 'id',
  eventName: 'eventName',
  sourceDomain: 'sourceDomain',
  tenantId: 'tenantId',
  payload: 'payload',
  timestamp: 'timestamp'
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
  PromoCode: 'PromoCode',
  SubscriptionUpgrade: 'SubscriptionUpgrade',
  ClientProfile: 'ClientProfile',
  ProviderProfile: 'ProviderProfile',
  Visit: 'Visit',
  Service: 'Service',
  VisitCheckEvent: 'VisitCheckEvent',
  VisitNote: 'VisitNote',
  VisitChecklist: 'VisitChecklist',
  Incident: 'Incident',
  DailyEntry: 'DailyEntry',
  Booking: 'Booking',
  ProviderAvailability: 'ProviderAvailability',
  ProviderDocument: 'ProviderDocument',
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
  IntakeAssessment: 'IntakeAssessment',
  ChatSession: 'ChatSession',
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
  ProviderShiftLog: 'ProviderShiftLog',
  AdlCareLog: 'AdlCareLog',
  ProviderVitalSign: 'ProviderVitalSign',
  BehaviorNote: 'BehaviorNote',
  NutritionRecord: 'NutritionRecord',
  MobilityLog: 'MobilityLog',
  InfectionControlChecklist: 'InfectionControlChecklist',
  NarrativeProgressNote: 'NarrativeProgressNote',
  CarePlanFollowUp: 'CarePlanFollowUp',
  DynamicFeatureRecord: 'DynamicFeatureRecord',
  ScreenConfiguration: 'ScreenConfiguration',
  ImplementationEvent: 'ImplementationEvent',
  VerificationLog: 'VerificationLog',
  AnomalyReport: 'AnomalyReport',
  ArchitecturalLayer: 'ArchitecturalLayer',
  ComponentPurpose: 'ComponentPurpose',
  SystemDomain: 'SystemDomain',
  SoftwareSystem: 'SoftwareSystem',
  SysComponent: 'SysComponent',
  ApiContract: 'ApiContract',
  UIIntent: 'UIIntent',
  DataResource: 'DataResource',
  PlatformHealthHistory: 'PlatformHealthHistory',
  AgentScreenBlueprint: 'AgentScreenBlueprint',
  BlueprintComponent: 'BlueprintComponent',
  BdmLead: 'BdmLead',
  TerritoryExpansionPlan: 'TerritoryExpansionPlan',
  PartnershipDeal: 'PartnershipDeal',
  CorporateKpi: 'CorporateKpi',
  CorporateReport: 'CorporateReport',
  CorporateAlert: 'CorporateAlert',
  OrganizationNode: 'OrganizationNode',
  KpiMetric: 'KpiMetric',
  FranchiseKpi: 'FranchiseKpi',
  FranchiseReport: 'FranchiseReport',
  FranchiseAlert: 'FranchiseAlert',
  FranchiseStaffNode: 'FranchiseStaffNode',
  BusinessDevelopmentMetric: 'BusinessDevelopmentMetric',
  ClinicMetric: 'ClinicMetric',
  SupportTicket: 'SupportTicket',
  PremiumFeatureStatus: 'PremiumFeatureStatus',
  FamilyAppointment: 'FamilyAppointment',
  FamilyCarePlanTask: 'FamilyCarePlanTask',
  FamilyClinicalMessage: 'FamilyClinicalMessage',
  Clinic: 'Clinic',
  Patient: 'Patient',
  FinancialRecord: 'FinancialRecord',
  ClientTrendNode: 'ClientTrendNode',
  ClientClinicNode: 'ClientClinicNode',
  ClientDemographicNode: 'ClientDemographicNode',
  HealthNetRevenueNode: 'HealthNetRevenueNode',
  HealthNetEfficiencyNode: 'HealthNetEfficiencyNode',
  HealthNetNetworkNode: 'HealthNetNetworkNode',
  JobOpening: 'JobOpening',
  JobCandidate: 'JobCandidate',
  InterviewEvent: 'InterviewEvent',
  IncidentReportNode: 'IncidentReportNode',
  AuditLogNode: 'AuditLogNode',
  PatientSatisfactionNode: 'PatientSatisfactionNode',
  FranchiseRevenueNode: 'FranchiseRevenueNode',
  ClinicPerformanceNode: 'ClinicPerformanceNode',
  FranchiseBookingNode: 'FranchiseBookingNode',
  LocalNetworkNode: 'LocalNetworkNode',
  LocalFinanceNode: 'LocalFinanceNode',
  LocalActivityNode: 'LocalActivityNode',
  LocalMarketingAnalyticNode: 'LocalMarketingAnalyticNode',
  LocalCampaignNode: 'LocalCampaignNode',
  LocalContentNode: 'LocalContentNode',
  PatientIntake: 'PatientIntake',
  IntakeReferralMetric: 'IntakeReferralMetric',
  InvoiceRecord: 'InvoiceRecord',
  InsuranceClaim: 'InsuranceClaim',
  FinancialGoal: 'FinancialGoal',
  PatientAdmissionNode: 'PatientAdmissionNode',
  ClinicalShiftNode: 'ClinicalShiftNode',
  MedicalAuditNode: 'MedicalAuditNode',
  OutreachEventNode: 'OutreachEventNode',
  ParticipantMetricNode: 'ParticipantMetricNode',
  OutreachBudgetNode: 'OutreachBudgetNode',
  SchedulerTrendNode: 'SchedulerTrendNode',
  SchedulerRosterNode: 'SchedulerRosterNode',
  SchedulerFacilityNode: 'SchedulerFacilityNode',
  SystemEventLog: 'SystemEventLog',
  FacilityNode: 'FacilityNode',
  StaffUtilization: 'StaffUtilization',
  OpsIssueTicket: 'OpsIssueTicket',
  SalesDealNode: 'SalesDealNode',
  KeyAccountNode: 'KeyAccountNode',
  RepPerformanceNode: 'RepPerformanceNode',
  MarketingCampaignNode: 'MarketingCampaignNode',
  LocalGrowthNode: 'LocalGrowthNode',
  ContentAssetNode: 'ContentAssetNode',
  SupportTicketNode: 'SupportTicketNode',
  PatientFeedbackNode: 'PatientFeedbackNode',
  SystemTelemetryNode: 'SystemTelemetryNode',
  SupportAgentNode: 'SupportAgentNode',
  TicketVolumeNode: 'TicketVolumeNode',
  ResolutionFeedbackNode: 'ResolutionFeedbackNode',
  CurriculumNode: 'CurriculumNode',
  InstructorNode: 'InstructorNode',
  CertificationNode: 'CertificationNode'
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
