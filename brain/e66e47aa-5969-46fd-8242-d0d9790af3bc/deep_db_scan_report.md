# PrimeCare Deep Database diagnostic & Saturation Invariant Audit

This deep database diagnosis was dynamically executed against the production Prisma cloud database cluster. It scanned all schema relations, verified table row counts, assessed relational coverage, and isolated operational gaps.

## 📊 High-Level Database Metrics

| Metric | Value | Diagnostic Health Status |
| :--- | :--- | :--- |
| **Database Server** | PostgreSQL (Prisma Cloud Pool) | Connected (Remote/Production) |
| **Total Defined Models** | 221 tables | Complete Schema Integrity |
| **Fully Hydrated Tables** | 200 tables | Row density verified |
| **Empty/Orphan Tables** | 21 tables | ⚠️ Action hook required for saturation |
| **Platform Saturation Rate** | **90.5%** | Optimal operational density achieved |
| **Total Live Database Rows** | **3793** records | Production transactional metrics |

## 🧠 Isolated Saturation Gaps (Empty Tables)

The following structural tables are currently defined in the schema but contain **0 active records**. This indicates they represent pending domain models or features currently operating under mocks:

| Subsystem Domain | Table / Model | Key Columns | Size In Schema | Gaps & Resolution |
| :--- | :--- | :--- | :--- | :--- |
| `INFRASTRUCTURE` | `ApiContract` | `id` | 10 columns | Feature mock-driven. Saturation seeder required for production transition. |
| `GROWTH` | `BdmLead` | `id` | 13 columns | Feature mock-driven. Saturation seeder required for production transition. |
| `INFRASTRUCTURE` | `BusinessDevelopmentMetric` | `id` | 7 columns | Analytics metrics calculated dynamically. Needs background worker calculations active. |
| `INFRASTRUCTURE` | `ChatSession` | `id` | 4 columns | Feature mock-driven. Saturation seeder required for production transition. |
| `GROWTH` | `ClinicMetric` | `id` | 7 columns | Analytics metrics calculated dynamically. Needs background worker calculations active. |
| `INFRASTRUCTURE` | `ComponentPurpose` | `id` | 13 columns | Feature mock-driven. Saturation seeder required for production transition. |
| `INFRASTRUCTURE` | `CorporateAlert` | `id` | 9 columns | No active exceptions triggered. Empty state is normal for operational health. |
| `INFRASTRUCTURE` | `CorporateKpi` | `id` | 10 columns | Analytics metrics calculated dynamically. Needs background worker calculations active. |
| `INFRASTRUCTURE` | `CorporateReport` | `id` | 10 columns | Feature mock-driven. Saturation seeder required for production transition. |
| `INFRASTRUCTURE` | `DataResource` | `id` | 8 columns | Feature mock-driven. Saturation seeder required for production transition. |
| `INFRASTRUCTURE` | `FranchiseAlert` | `id` | 10 columns | No active exceptions triggered. Empty state is normal for operational health. |
| `INFRASTRUCTURE` | `FranchiseKpi` | `id` | 11 columns | Analytics metrics calculated dynamically. Needs background worker calculations active. |
| `INFRASTRUCTURE` | `FranchiseReport` | `id` | 11 columns | Feature mock-driven. Saturation seeder required for production transition. |
| `INFRASTRUCTURE` | `FranchiseStaffNode` | `id` | 9 columns | Feature mock-driven. Saturation seeder required for production transition. |
| `GROWTH` | `IntakeAssessment` | `id` | 7 columns | Feature mock-driven. Saturation seeder required for production transition. |
| `INFRASTRUCTURE` | `KpiMetric` | `id` | 7 columns | Analytics metrics calculated dynamically. Needs background worker calculations active. |
| `INFRASTRUCTURE` | `OrganizationNode` | `id` | 8 columns | Feature mock-driven. Saturation seeder required for production transition. |
| `GROWTH` | `PartnershipDeal` | `id` | 11 columns | Feature mock-driven. Saturation seeder required for production transition. |
| `INFRASTRUCTURE` | `PremiumFeatureStatus` | `id` | 9 columns | Feature mock-driven. Saturation seeder required for production transition. |
| `INFRASTRUCTURE` | `SupportTicket` | `id` | 7 columns | Feature mock-driven. Saturation seeder required for production transition. |
| `INFRASTRUCTURE` | `TerritoryExpansionPlan` | `id` | 9 columns | Feature mock-driven. Saturation seeder required for production transition. |

## 🧬 Core Domain Table Distribution & Volume

### 📂 Domain Category: CLINICAL (Total Rows: 191)

| Table / Model | Row Density | Schema Width | Primary Identifier | Key Status |
| :--- | :--- | :--- | :--- | :--- |
| `CarePlan` | **15 rows** | 17 columns | `id` | ✅ Active |
| `ClinicalRecord` | **15 rows** | 8 columns | `id` | ✅ Active |
| `PatientAlert` | **15 rows** | 10 columns | `id` | ✅ Active |
| `CarePlanFollowUp` | **10 rows** | 12 columns | `id` | ✅ Active |
| `ClinicalAssessment` | **10 rows** | 13 columns | `id` | ✅ Active |
| `ClinicalShiftNode` | **10 rows** | 9 columns | `id` | ✅ Active |
| `FamilyCarePlanTask` | **10 rows** | 9 columns | `id` | ✅ Active |
| `FamilyClinicalMessage` | **10 rows** | 7 columns | `id` | ✅ Active |
| `MAR_Entry` | **10 rows** | 17 columns | `id` | ✅ Active |
| `MedicalAuditNode` | **10 rows** | 8 columns | `id` | ✅ Active |
| `Patient` | **10 rows** | 11 columns | `id` | ✅ Active |
| `PatientAdmissionNode` | **10 rows** | 10 columns | `id` | ✅ Active |
| `PatientFeedbackNode` | **10 rows** | 9 columns | `id` | ✅ Active |
| `PatientIntake` | **10 rows** | 11 columns | `id` | ✅ Active |
| `PatientSatisfactionNode` | **10 rows** | 8 columns | `id` | ✅ Active |
| `Prescription` | **10 rows** | 16 columns | `id` | ✅ Active |
| `ProviderVitalSign` | **10 rows** | 14 columns | `id` | ✅ Active |
| `VitalSign` | **6 rows** | 8 columns | `id` | ✅ Active |

---

### 📂 Domain Category: FINANCE (Total Rows: 337)

| Table / Model | Row Density | Schema Width | Primary Identifier | Key Status |
| :--- | :--- | :--- | :--- | :--- |
| `FinancialTransaction` | **95 rows** | 15 columns | `id` | ✅ Active |
| `TransactionLedger` | **75 rows** | 22 columns | `id` | ✅ Active |
| `JournalEntry` | **50 rows** | 15 columns | `id` | ✅ Active |
| `ChartOfAccount` | **24 rows** | 11 columns | `id` | ✅ Active |
| `Invoice` | **15 rows** | 14 columns | `id` | ✅ Active |
| `BankTransaction` | **10 rows** | 11 columns | `id` | ✅ Active |
| `FinancialGoal` | **10 rows** | 9 columns | `id` | ✅ Active |
| `FinancialReconciliation` | **10 rows** | 9 columns | `id` | ✅ Active |
| `FinancialRecord` | **10 rows** | 6 columns | `id` | ✅ Active |
| `KeyAccountNode` | **10 rows** | 9 columns | `id` | ✅ Active |
| `Payment` | **10 rows** | 8 columns | `id` | ✅ Active |
| `Payout` | **10 rows** | 11 columns | `id` | ✅ Active |
| `InvoiceRecord` | **8 rows** | 10 columns | `id` | ✅ Active |

---

### 📂 Domain Category: LOGISTICS (Total Rows: 254)

| Table / Model | Row Density | Schema Width | Primary Identifier | Key Status |
| :--- | :--- | :--- | :--- | :--- |
| `Visit` | **60 rows** | 46 columns | `id` | ✅ Active |
| `EVVRecord` | **25 rows** | 15 columns | `id` | ✅ Active |
| `VisitChecklist` | **25 rows** | 7 columns | `id` | ✅ Active |
| `ProviderAvailability` | **15 rows** | 8 columns | `id` | ✅ Active |
| `AvailabilityOverride` | **10 rows** | 9 columns | `id` | ✅ Active |
| `ProviderShiftLog` | **10 rows** | 14 columns | `id` | ✅ Active |
| `SchedulerFacilityNode` | **10 rows** | 7 columns | `id` | ✅ Active |
| `SchedulerRosterNode` | **10 rows** | 8 columns | `id` | ✅ Active |
| `SchedulerTrendNode` | **10 rows** | 6 columns | `id` | ✅ Active |
| `Service` | **10 rows** | 14 columns | `id` | ✅ Active |
| `ServiceAuthorization` | **10 rows** | 16 columns | `id` | ✅ Active |
| `ShiftAssignment` | **10 rows** | 10 columns | `id` | ✅ Active |
| `ShiftHandover` | **10 rows** | 11 columns | `id` | ✅ Active |
| `VisitCheckEvent` | **10 rows** | 21 columns | `id` | ✅ Active |
| `VisitMatch` | **10 rows** | 10 columns | `id` | ✅ Active |
| `VisitNote` | **10 rows** | 7 columns | `id` | ✅ Active |
| `FleetStatus` | **9 rows** | 9 columns | `id` | ✅ Active |

---

### 📂 Domain Category: GOVERNANCE (Total Rows: 464)

| Table / Model | Row Density | Schema Width | Primary Identifier | Key Status |
| :--- | :--- | :--- | :--- | :--- |
| `AuditLog` | **189 rows** | 12 columns | `id` | ✅ Active |
| `PlatformRole` | **36 rows** | 11 columns | `id` | ✅ Active |
| `AuditLogNode` | **35 rows** | 10 columns | `id` | ✅ Active |
| `ScreenFunctionality` | **30 rows** | 14 columns | `id` | ✅ Active |
| `RoleScreenAccess` | **22 rows** | 6 columns | `id` | ✅ Active |
| `PlatformScreen` | **14 rows** | 14 columns | `id` | ✅ Active |
| `ComplianceRecord` | **10 rows** | 8 columns | `id` | ✅ Active |
| `DailyAuditSignOff` | **10 rows** | 10 columns | `id` | ✅ Active |
| `EcosystemStateOverride` | **10 rows** | 8 columns | `id` | ✅ Active |
| `HealthID` | **10 rows** | 7 columns | `id` | ✅ Active |
| `HealthNetEfficiencyNode` | **10 rows** | 8 columns | `id` | ✅ Active |
| `HealthNetNetworkNode` | **10 rows** | 7 columns | `id` | ✅ Active |
| `HealthNetRevenueNode` | **10 rows** | 7 columns | `id` | ✅ Active |
| `Registry` | **10 rows** | 10 columns | `id` | ✅ Active |
| `ResponseBotAudit` | **10 rows** | 7 columns | `id` | ✅ Active |
| `SecurityThreat` | **10 rows** | 10 columns | `id` | ✅ Active |
| `SystemPolicy` | **10 rows** | 8 columns | `id` | ✅ Active |
| `TechnicalAudit` | **10 rows** | 11 columns | `id` | ✅ Active |
| `EcosystemAutopilotConfig` | **8 rows** | 9 columns | `id` | ✅ Active |
| `AgentScreenBlueprint` | **4 rows** | 7 columns | `id` | ✅ Active |
| `PlatformHealthHistory` | **4 rows** | 7 columns | `id` | ✅ Active |
| `RegistryEntry` | **1 rows** | 15 columns | `id` | ✅ Active |
| `ScreenConfiguration` | **1 rows** | 8 columns | `id` | ✅ Active |

---

### 📂 Domain Category: GROWTH (Total Rows: 285)

| Table / Model | Row Density | Schema Width | Primary Identifier | Key Status |
| :--- | :--- | :--- | :--- | :--- |
| `Clinic` | **50 rows** | 10 columns | `id` | ✅ Active |
| `Feedback` | **35 rows** | 12 columns | `id` | ✅ Active |
| `IntakeReferralMetric` | **35 rows** | 7 columns | `id` | ✅ Active |
| `SalesDealNode` | **35 rows** | 9 columns | `id` | ✅ Active |
| `JobOpening` | **30 rows** | 10 columns | `id` | ✅ Active |
| `CareFeedback` | **10 rows** | 12 columns | `id` | ✅ Active |
| `ClientClinicNode` | **10 rows** | 8 columns | `id` | ✅ Active |
| `ClinicPerformanceNode` | **10 rows** | 10 columns | `id` | ✅ Active |
| `JobCandidate` | **10 rows** | 10 columns | `id` | ✅ Active |
| `Lead` | **10 rows** | 15 columns | `id` | ✅ Active |
| `LocalCampaignNode` | **10 rows** | 8 columns | `id` | ✅ Active |
| `MarketingCampaignNode` | **10 rows** | 10 columns | `id` | ✅ Active |
| `Referral` | **10 rows** | 17 columns | `id` | ✅ Active |
| `ReferralPipeline` | **10 rows** | 8 columns | `id` | ✅ Active |
| `ResolutionFeedbackNode` | **10 rows** | 7 columns | `id` | ✅ Active |
| `BdmLead` | **0 rows (Empty)** | 13 columns | `id` | ⚠️ Dormant |
| `ClinicMetric` | **0 rows (Empty)** | 7 columns | `id` | ⚠️ Dormant |
| `IntakeAssessment` | **0 rows (Empty)** | 7 columns | `id` | ⚠️ Dormant |
| `PartnershipDeal` | **0 rows (Empty)** | 11 columns | `id` | ⚠️ Dormant |

---

### 📂 Domain Category: INFRASTRUCTURE (Total Rows: 2262)

| Table / Model | Row Density | Schema Width | Primary Identifier | Key Status |
| :--- | :--- | :--- | :--- | :--- |
| `UIIntent` | **527 rows** | 9 columns | `id` | ✅ Active |
| `VerificationLog` | **297 rows** | 6 columns | `id` | ✅ Active |
| `User` | **157 rows** | 56 columns | `id` | ✅ Active |
| `IncidentReportNode` | **90 rows** | 9 columns | `id` | ✅ Active |
| `SupportTicketNode` | **60 rows** | 9 columns | `id` | ✅ Active |
| `ImplementationEvent` | **30 rows** | 7 columns | `id` | ✅ Active |
| `ClientProfile` | **28 rows** | 54 columns | `id` | ✅ Active |
| `DailyEntry` | **25 rows** | 18 columns | `id` | ✅ Active |
| `Tenant` | **18 rows** | 117 columns | `id` | ✅ Active |
| `ProviderDocument` | **15 rows** | 12 columns | `id` | ✅ Active |
| `BlueprintComponent` | **13 rows** | 8 columns | `id` | ✅ Active |
| `AdlCareLog` | **10 rows** | 16 columns | `id` | ✅ Active |
| `AIInference` | **10 rows** | 9 columns | `id` | ✅ Active |
| `AIRecommendation` | **10 rows** | 8 columns | `id` | ✅ Active |
| `AnomalyReport` | **10 rows** | 6 columns | `id` | ✅ Active |
| `ApiKey` | **10 rows** | 8 columns | `id` | ✅ Active |
| `AppNotification` | **10 rows** | 11 columns | `id` | ✅ Active |
| `BehaviorNote` | **10 rows** | 12 columns | `id` | ✅ Active |
| `BillingCode` | **10 rows** | 5 columns | `id` | ✅ Active |
| `BlogPost` | **10 rows** | 17 columns | `id` | ✅ Active |
| `Booking` | **10 rows** | 14 columns | `id` | ✅ Active |
| `BookingRequest` | **10 rows** | 12 columns | `id` | ✅ Active |
| `BranchCapacity` | **10 rows** | 9 columns | `id` | ✅ Active |
| `BranchStat` | **10 rows** | 9 columns | `id` | ✅ Active |
| `CertificationNode` | **10 rows** | 9 columns | `id` | ✅ Active |
| `Claim` | **10 rows** | 12 columns | `id` | ✅ Active |
| `ClientDemographicNode` | **10 rows** | 6 columns | `id` | ✅ Active |
| `ClientTrendNode` | **10 rows** | 7 columns | `id` | ✅ Active |
| `CommunicationLog` | **10 rows** | 12 columns | `id` | ✅ Active |
| `ConsentForm` | **10 rows** | 15 columns | `id` | ✅ Active |
| `ContentAssetNode` | **10 rows** | 9 columns | `id` | ✅ Active |
| `CrisisProtocol` | **10 rows** | 8 columns | `id` | ✅ Active |
| `CurriculumNode` | **10 rows** | 8 columns | `id` | ✅ Active |
| `DailyActivity` | **10 rows** | 12 columns | `id` | ✅ Active |
| `DynamicFeatureRecord` | **10 rows** | 9 columns | `id` | ✅ Active |
| `FacilityNode` | **10 rows** | 10 columns | `id` | ✅ Active |
| `FamilyAppointment` | **10 rows** | 10 columns | `id` | ✅ Active |
| `FamilyMember` | **10 rows** | 16 columns | `id` | ✅ Active |
| `FamilyNotification` | **10 rows** | 9 columns | `id` | ✅ Active |
| `FAQ` | **10 rows** | 6 columns | `id` | ✅ Active |
| `FhirSyncLog` | **10 rows** | 9 columns | `id` | ✅ Active |
| `Franchise` | **10 rows** | 10 columns | `id` | ✅ Active |
| `FranchiseBookingNode` | **10 rows** | 9 columns | `id` | ✅ Active |
| `FranchiseRevenueNode` | **10 rows** | 9 columns | `id` | ✅ Active |
| `GamificationProfile` | **10 rows** | 9 columns | `id` | ✅ Active |
| `HospitalTarget` | **10 rows** | 9 columns | `id` | ✅ Active |
| `InfectionControlChecklist` | **10 rows** | 12 columns | `id` | ✅ Active |
| `InstructorNode` | **10 rows** | 7 columns | `id` | ✅ Active |
| `InsuranceClaim` | **10 rows** | 11 columns | `id` | ✅ Active |
| `InsuranceProvider` | **10 rows** | 9 columns | `id` | ✅ Active |
| `InterviewEvent` | **10 rows** | 10 columns | `id` | ✅ Active |
| `InventoryItem` | **10 rows** | 13 columns | `id` | ✅ Active |
| `IoTEvent` | **10 rows** | 10 columns | `id` | ✅ Active |
| `LocalActivityNode` | **10 rows** | 7 columns | `id` | ✅ Active |
| `LocalContentNode` | **10 rows** | 7 columns | `id` | ✅ Active |
| `LocalFinanceNode` | **10 rows** | 8 columns | `id` | ✅ Active |
| `LocalGrowthNode` | **10 rows** | 8 columns | `id` | ✅ Active |
| `LocalMarketingAnalyticNode` | **10 rows** | 7 columns | `id` | ✅ Active |
| `LocalNetworkNode` | **10 rows** | 9 columns | `id` | ✅ Active |
| `MarketplaceListing` | **10 rows** | 10 columns | `id` | ✅ Active |
| `Medication` | **10 rows** | 8 columns | `id` | ✅ Active |
| `MedicationRecon` | **10 rows** | 11 columns | `id` | ✅ Active |
| `Message` | **10 rows** | 7 columns | `id` | ✅ Active |
| `MessageThread` | **10 rows** | 10 columns | `id` | ✅ Active |
| `MileageLog` | **10 rows** | 16 columns | `id` | ✅ Active |
| `MobilityLog` | **10 rows** | 12 columns | `id` | ✅ Active |
| `NarrativeProgressNote` | **10 rows** | 12 columns | `id` | ✅ Active |
| `NutritionRecord` | **10 rows** | 12 columns | `id` | ✅ Active |
| `OpsIssueTicket` | **10 rows** | 9 columns | `id` | ✅ Active |
| `OutreachBudgetNode` | **10 rows** | 9 columns | `id` | ✅ Active |
| `OutreachEventNode` | **10 rows** | 9 columns | `id` | ✅ Active |
| `ParticipantMetricNode` | **10 rows** | 8 columns | `id` | ✅ Active |
| `PerformanceReview` | **10 rows** | 19 columns | `id` | ✅ Active |
| `PromoCode` | **10 rows** | 11 columns | `id` | ✅ Active |
| `ProtocolResolution` | **10 rows** | 8 columns | `id` | ✅ Active |
| `ProviderProfile` | **10 rows** | 37 columns | `id` | ✅ Active |
| `PurchaseOrder` | **10 rows** | 11 columns | `id` | ✅ Active |
| `Region` | **10 rows** | 10 columns | `id` | ✅ Active |
| `RepPerformanceNode` | **10 rows** | 9 columns | `id` | ✅ Active |
| `ResellerAgreement` | **10 rows** | 8 columns | `id` | ✅ Active |
| `SentimentAnalysis` | **10 rows** | 9 columns | `id` | ✅ Active |
| `StaffGroup` | **10 rows** | 9 columns | `id` | ✅ Active |
| `StaffGroupMember` | **10 rows** | 7 columns | `id` | ✅ Active |
| `StaffTask` | **10 rows** | 14 columns | `id` | ✅ Active |
| `StaffUtilization` | **10 rows** | 10 columns | `id` | ✅ Active |
| `SubscriptionUpgrade` | **10 rows** | 8 columns | `id` | ✅ Active |
| `SupervisionLog` | **10 rows** | 11 columns | `id` | ✅ Active |
| `Supplier` | **10 rows** | 9 columns | `id` | ✅ Active |
| `SupplyForecastMetrics` | **10 rows** | 9 columns | `id` | ✅ Active |
| `SupportAgentNode` | **10 rows** | 8 columns | `id` | ✅ Active |
| `Survey` | **10 rows** | 9 columns | `id` | ✅ Active |
| `SurveyResponse` | **10 rows** | 6 columns | `id` | ✅ Active |
| `SystemEvent` | **10 rows** | 15 columns | `id` | ✅ Active |
| `SystemEventLog` | **10 rows** | 6 columns | `id` | ✅ Active |
| `SystemTelemetryNode` | **10 rows** | 8 columns | `id` | ✅ Active |
| `TelehealthSession` | **10 rows** | 12 columns | `id` | ✅ Active |
| `TicketVolumeNode` | **10 rows** | 7 columns | `id` | ✅ Active |
| `Timesheet` | **10 rows** | 15 columns | `id` | ✅ Active |
| `TimesheetItem` | **10 rows** | 7 columns | `id` | ✅ Active |
| `TrainingAssignment` | **10 rows** | 9 columns | `id` | ✅ Active |
| `TrainingModule` | **10 rows** | 10 columns | `id` | ✅ Active |
| `UserDevice` | **10 rows** | 15 columns | `id` | ✅ Active |
| `UserReputation` | **10 rows** | 9 columns | `id` | ✅ Active |
| `WaitlistEntry` | **10 rows** | 12 columns | `id` | ✅ Active |
| `WebhookDelivery` | **10 rows** | 9 columns | `id` | ✅ Active |
| `WebhookEndpoint` | **10 rows** | 12 columns | `id` | ✅ Active |
| `WellnessPulse` | **10 rows** | 10 columns | `id` | ✅ Active |
| `Incident` | **9 rows** | 18 columns | `id` | ✅ Active |
| `SoftwareSystem` | **9 rows** | 9 columns | `id` | ✅ Active |
| `TenantSLA` | **9 rows** | 8 columns | `id` | ✅ Active |
| `SysComponent` | **6 rows** | 14 columns | `id` | ✅ Active |
| `SystemDomain` | **5 rows** | 7 columns | `id` | ✅ Active |
| `ArchitecturalLayer` | **3 rows** | 7 columns | `id` | ✅ Active |
| `SystemTouchpoint` | **1 rows** | 14 columns | `id` | ✅ Active |
| `ApiContract` | **0 rows (Empty)** | 10 columns | `id` | ⚠️ Dormant |
| `BusinessDevelopmentMetric` | **0 rows (Empty)** | 7 columns | `id` | ⚠️ Dormant |
| `ChatSession` | **0 rows (Empty)** | 4 columns | `id` | ⚠️ Dormant |
| `ComponentPurpose` | **0 rows (Empty)** | 13 columns | `id` | ⚠️ Dormant |
| `CorporateAlert` | **0 rows (Empty)** | 9 columns | `id` | ⚠️ Dormant |
| `CorporateKpi` | **0 rows (Empty)** | 10 columns | `id` | ⚠️ Dormant |
| `CorporateReport` | **0 rows (Empty)** | 10 columns | `id` | ⚠️ Dormant |
| `DataResource` | **0 rows (Empty)** | 8 columns | `id` | ⚠️ Dormant |
| `FranchiseAlert` | **0 rows (Empty)** | 10 columns | `id` | ⚠️ Dormant |
| `FranchiseKpi` | **0 rows (Empty)** | 11 columns | `id` | ⚠️ Dormant |
| `FranchiseReport` | **0 rows (Empty)** | 11 columns | `id` | ⚠️ Dormant |
| `FranchiseStaffNode` | **0 rows (Empty)** | 9 columns | `id` | ⚠️ Dormant |
| `KpiMetric` | **0 rows (Empty)** | 7 columns | `id` | ⚠️ Dormant |
| `OrganizationNode` | **0 rows (Empty)** | 8 columns | `id` | ⚠️ Dormant |
| `PremiumFeatureStatus` | **0 rows (Empty)** | 9 columns | `id` | ⚠️ Dormant |
| `SupportTicket` | **0 rows (Empty)** | 7 columns | `id` | ⚠️ Dormant |
| `TerritoryExpansionPlan` | **0 rows (Empty)** | 9 columns | `id` | ⚠️ Dormant |

---

