-- PrimeCare Database Backup
-- Generated on 2026-02-11T21:10:43.267Z

-- Failed to dump user: 
Invalid `prisma[modelName].findMany()` invocation in
C:\Users\User\Projects\psw_app\apps\worker-api\dump_db.js:38:53

  35 for (const modelName of models) {
  36     console.log(`Dumping table for model: ${modelName}...`);
  37     try {
→ 38         const records = await prisma[modelName].findMany(
The column `users.tenant_id` does not exist in the current database.

-- Failed to dump tenant: 
Invalid `prisma[modelName].findMany()` invocation in
C:\Users\User\Projects\psw_app\apps\worker-api\dump_db.js:38:53

  35 for (const modelName of models) {
  36     console.log(`Dumping table for model: ${modelName}...`);
  37     try {
→ 38         const records = await prisma[modelName].findMany(
The table `public.tenants` does not exist in the current database.

-- Failed to dump clientProfile: 
Invalid `prisma[modelName].findMany()` invocation in
C:\Users\User\Projects\psw_app\apps\worker-api\dump_db.js:38:53

  35 for (const modelName of models) {
  36     console.log(`Dumping table for model: ${modelName}...`);
  37     try {
→ 38         const records = await prisma[modelName].findMany(
The column `client_profiles.tenant_id` does not exist in the current database.

-- Failed to dump pswProfile: 
Invalid `prisma[modelName].findMany()` invocation in
C:\Users\User\Projects\psw_app\apps\worker-api\dump_db.js:38:53

  35 for (const modelName of models) {
  36     console.log(`Dumping table for model: ${modelName}...`);
  37     try {
→ 38         const records = await prisma[modelName].findMany(
The column `psw_profiles.tenant_id` does not exist in the current database.

-- Failed to dump visit: 
Invalid `prisma[modelName].findMany()` invocation in
C:\Users\User\Projects\psw_app\apps\worker-api\dump_db.js:38:53

  35 for (const modelName of models) {
  36     console.log(`Dumping table for model: ${modelName}...`);
  37     try {
→ 38         const records = await prisma[modelName].findMany(
The column `visits.tenant_id` does not exist in the current database.

-- Failed to dump service: 
Invalid `prisma[modelName].findMany()` invocation in
C:\Users\User\Projects\psw_app\apps\worker-api\dump_db.js:38:53

  35 for (const modelName of models) {
  36     console.log(`Dumping table for model: ${modelName}...`);
  37     try {
→ 38         const records = await prisma[modelName].findMany(
The column `services.tenant_id` does not exist in the current database.

-- Table for visitCheckEvent is empty

-- Table for visitNote is empty

-- Table for visitChecklist is empty

-- Failed to dump incident: 
Invalid `prisma[modelName].findMany()` invocation in
C:\Users\User\Projects\psw_app\apps\worker-api\dump_db.js:38:53

  35 for (const modelName of models) {
  36     console.log(`Dumping table for model: ${modelName}...`);
  37     try {
→ 38         const records = await prisma[modelName].findMany(
The column `incidents.tenant_id` does not exist in the current database.

-- Failed to dump timesheet: 
Invalid `prisma[modelName].findMany()` invocation in
C:\Users\User\Projects\psw_app\apps\worker-api\dump_db.js:38:53

  35 for (const modelName of models) {
  36     console.log(`Dumping table for model: ${modelName}...`);
  37     try {
→ 38         const records = await prisma[modelName].findMany(
The column `timesheets.tenant_id` does not exist in the current database.

-- Table for timesheetItem is empty

-- Failed to dump invoice: 
Invalid `prisma[modelName].findMany()` invocation in
C:\Users\User\Projects\psw_app\apps\worker-api\dump_db.js:38:53

  35 for (const modelName of models) {
  36     console.log(`Dumping table for model: ${modelName}...`);
  37     try {
→ 38         const records = await prisma[modelName].findMany(
The column `invoices.tenant_id` does not exist in the current database.

-- Table for payment is empty

-- Failed to dump messageThread: 
Invalid `prisma[modelName].findMany()` invocation in
C:\Users\User\Projects\psw_app\apps\worker-api\dump_db.js:38:53

  35 for (const modelName of models) {
  36     console.log(`Dumping table for model: ${modelName}...`);
  37     try {
→ 38         const records = await prisma[modelName].findMany(
The column `messages_threads.tenant_id` does not exist in the current database.

-- Table for message is empty

-- Failed to dump auditLog: 
Invalid `prisma[modelName].findMany()` invocation in
C:\Users\User\Projects\psw_app\apps\worker-api\dump_db.js:38:53

  35 for (const modelName of models) {
  36     console.log(`Dumping table for model: ${modelName}...`);
  37     try {
→ 38         const records = await prisma[modelName].findMany(
The column `audit_logs.tenant_id` does not exist in the current database.

-- Data for table: leads
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('bf430383-f138-4bd0-a4e2-5a38b2843e36', 'Lead Customer 0', 'lead_0_1770576048733@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:40:48.817Z', '2026-02-08T18:40:48.817Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('fbeeb3d6-5a53-4c4f-94a9-70c188a51f5e', 'Lead Customer 0', 'lead_0_1770576101509@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:41:41.592Z', '2026-02-08T18:41:41.592Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('c8ebffa2-ce02-42cf-af77-fa8579e254ba', 'Lead Customer 0', 'lead_0_1770576150704@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:42:30.778Z', '2026-02-08T18:42:30.778Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('5f843c6c-a45b-49cb-80c7-cb2348540ac5', 'Lead Customer 0', 'lead_0_1770576180394@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:43:00.471Z', '2026-02-08T18:43:00.471Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('42b77cba-e5c7-40ad-8fe5-0e6e610862ba', 'Lead Customer 0', 'lead_0_1770576197110@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:43:17.180Z', '2026-02-08T18:43:17.180Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('592b1f7d-6fe7-49db-a7f8-d805f37f740b', 'Lead Customer 0', 'lead_0_1770576723293@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:52:03.378Z', '2026-02-08T18:52:03.378Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('9d7a3ff8-3b9f-48ef-b707-b6f7e582de48', 'Lead Customer 0', 'lead_0_1770576788656@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:53:08.704Z', '2026-02-08T18:53:08.704Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('aef209cf-8cc7-4cf0-bad2-71642f44d302', 'Lead Customer 1', 'lead_1_1770576788774@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:53:08.810Z', '2026-02-08T18:53:08.810Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('bbd0af66-3b65-4317-b476-41505b414238', 'Lead Customer 2', 'lead_2_1770576788871@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:53:08.909Z', '2026-02-08T18:53:08.909Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('09610385-9bbe-4da9-bcc2-fbcb6c5a5647', 'Lead Customer 0', 'lead_0_1770576841503@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:54:01.550Z', '2026-02-08T18:54:01.550Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('4ffb2606-1de0-47e7-ace0-1b2c4a8a4c18', 'Lead Customer 1', 'lead_1_1770576841640@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:54:01.691Z', '2026-02-08T18:54:01.691Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('782112fb-58e5-4a91-9c7d-3d80d00ad88a', 'Lead Customer 2', 'lead_2_1770576841779@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:54:01.810Z', '2026-02-08T18:54:01.810Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('49c75ba0-fc57-4dae-a9e7-b11ada6cba5a', 'Lead Customer 0', 'lead_0_1770577125574@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:58:45.630Z', '2026-02-08T18:58:45.630Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('7bd5d753-53c4-4c22-a28c-554d53763f61', 'Lead Customer 1', 'lead_1_1770577125724@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:58:45.758Z', '2026-02-08T18:58:45.758Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('4e165140-fcbf-4fd8-a94f-687b2ca76ca8', 'Lead Customer 2', 'lead_2_1770577125839@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:58:45.865Z', '2026-02-08T18:58:45.865Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('20ca8958-75d0-4c59-b6be-82e3eac5090b', 'Lead Customer 0', 'lead_0_1770577191498@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:59:51.517Z', '2026-02-08T18:59:51.517Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('bdf2b796-5223-4088-abaf-b194606bba1e', 'Lead Customer 1', 'lead_1_1770577191603@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:59:51.628Z', '2026-02-08T18:59:51.628Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('a5525685-52a3-4734-a2ff-be03e8bb0eba', 'Lead Customer 2', 'lead_2_1770577191711@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T18:59:51.725Z', '2026-02-08T18:59:51.725Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('d7c27b86-5c0c-4d88-90af-1ecf7afb728a', 'Lead Customer 0', 'lead_0_1770577213775@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:00:13.794Z', '2026-02-08T19:00:13.794Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('56bc3153-4a34-4173-b327-f43a34cf1aaf', 'Lead Customer 1', 'lead_1_1770577213883@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:00:13.905Z', '2026-02-08T19:00:13.905Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('19a519bd-ff54-4314-ae35-1433d51e248c', 'Lead Customer 2', 'lead_2_1770577214008@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:00:14.036Z', '2026-02-08T19:00:14.036Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('032b6e93-5fa7-4920-ac41-6dc1a919ec7e', 'Lead Customer 0', 'lead_0_1770577285509@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:01:25.524Z', '2026-02-08T19:01:25.524Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('9bcc72a4-00c7-4d7f-ab28-f5b698f50fad', 'Lead Customer 1', 'lead_1_1770577285613@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:01:25.637Z', '2026-02-08T19:01:25.637Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('9eaa8ce3-f7e4-4698-a4c5-ce8c801863b3', 'Lead Customer 2', 'lead_2_1770577285721@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:01:25.728Z', '2026-02-08T19:01:25.728Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('7ce4f603-5960-4779-9362-c88bb13e9286', 'Lead Customer 0', 'lead_0_1770577369092@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:02:49.099Z', '2026-02-08T19:02:49.099Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('82df6552-923e-4bdb-9dd9-2298b4fcd093', 'Lead Customer 1', 'lead_1_1770577369198@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:02:49.210Z', '2026-02-08T19:02:49.210Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('5a0aa5f5-a104-4081-bce5-5061a12c7dab', 'Lead Customer 2', 'lead_2_1770577369300@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:02:49.304Z', '2026-02-08T19:02:49.304Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('58408d11-4154-4839-9b2d-6b0eec8e3767', 'Lead Customer 0', 'lead_0_1770577636802@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:07:16.806Z', '2026-02-08T19:07:16.806Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('a046b93e-1dff-48c1-9595-e2fd8a668742', 'Lead Customer 1', 'lead_1_1770577636919@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:07:16.921Z', '2026-02-08T19:07:16.921Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('3b11137e-c2a2-4691-9287-326e2a93ab88', 'Lead Customer 2', 'lead_2_1770577637024@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:07:17.027Z', '2026-02-08T19:07:17.027Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('15bc2efa-23d1-4ef2-9898-42e33813e8ef', 'Lead Customer 0', 'lead_0_1770578298243@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:18:18.215Z', '2026-02-08T19:18:18.215Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('5ec884c1-64ba-4a32-93da-3987f7b25d2b', 'Lead Customer 1', 'lead_1_1770578298372@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:18:18.343Z', '2026-02-08T19:18:18.343Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('9f2aefc8-b70a-44eb-821c-8d780ce143b5', 'Lead Customer 2', 'lead_2_1770578298477@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:18:18.451Z', '2026-02-08T19:18:18.451Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('eac5dfe1-6bf1-4509-ae67-8400ac2dfb96', 'Lead Customer 0', 'lead_0_1770580656525@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:57:36.432Z', '2026-02-08T19:57:36.432Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('a54517e9-61fc-4ef6-aaf8-d701f4cdb3ca', 'Lead Customer 0', 'lead_0_1770580768201@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:59:28.195Z', '2026-02-08T19:59:28.195Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('d985ae26-7697-4576-910a-57877776a567', 'Lead Customer 1', 'lead_1_1770580768598@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:59:28.495Z', '2026-02-08T19:59:28.495Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('f393336b-0376-48bc-a0cf-c2099ebf7e41', 'Lead Customer 2', 'lead_2_1770580769717@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T19:59:29.610Z', '2026-02-08T19:59:29.610Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('4e1411b5-4ac9-4bc7-8fe3-45e24b378e05', 'Lead Customer 0', 'lead_0_1770580939399@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T20:02:19.364Z', '2026-02-08T20:02:19.364Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('e6f82da9-8178-4049-aee8-46751a27c0aa', 'Lead Customer 1', 'lead_1_1770580939615@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T20:02:19.521Z', '2026-02-08T20:02:19.521Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('6c04e28e-984f-475f-a277-c48a6ed8d2da', 'Lead Customer 2', 'lead_2_1770580939775@example.com', NULL, 'Looking for daily care services.', 'book_consultation', 'new', '2026-02-08T20:02:19.669Z', '2026-02-08T20:02:19.669Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('e4bf4556-14d1-4f8d-b19a-5cb95f60ae83', 'Scenario Prospect 0', 'lead_0@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:31:37.296Z', '2026-02-08T23:31:37.296Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('34002df3-555c-4474-b6a6-1c732a4bbee5', 'Scenario Prospect 1', 'lead_1@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:31:37.374Z', '2026-02-08T23:31:37.374Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('9f3d563b-515f-47f7-8601-949141d2e5c7', 'Scenario Prospect 2', 'lead_2@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:31:37.429Z', '2026-02-08T23:31:37.429Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('c4a6747b-3f1d-4913-8663-7fcdb9f66df8', 'Scenario Prospect 3', 'lead_3@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:31:37.482Z', '2026-02-08T23:31:37.482Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('69197ee2-c4df-4992-ad09-56df31e5c6a1', 'Scenario Prospect 4', 'lead_4@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:31:37.537Z', '2026-02-08T23:31:37.537Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('affc466b-958a-4e3e-8228-0f71f513131c', 'Scenario Prospect 5', 'lead_5@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:31:37.594Z', '2026-02-08T23:31:37.594Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('ca59493f-3d7f-424d-8a7e-3024c8323162', 'Scenario Prospect 6', 'lead_6@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:31:37.652Z', '2026-02-08T23:31:37.652Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('8995238d-5ab9-44fb-9f1f-899a470f833d', 'Scenario Prospect 7', 'lead_7@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:31:37.705Z', '2026-02-08T23:31:37.705Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('60d4c6e7-14a0-4ba4-80c1-6a9690e65fe6', 'Scenario Prospect 8', 'lead_8@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:31:37.758Z', '2026-02-08T23:31:37.758Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('a89dcee4-3ba1-4c15-9798-20f60460100d', 'Scenario Prospect 9', 'lead_9@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:31:37.817Z', '2026-02-08T23:31:37.817Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('9994b015-1369-4abd-b785-571915429569', 'Scenario Prospect 0', 'lead_0@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-09T00:15:30.466Z', '2026-02-09T00:15:30.466Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('7b56bb84-8aa1-4545-98f7-d4354b564e50', 'Scenario Prospect 1', 'lead_1@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-09T00:15:30.849Z', '2026-02-09T00:15:30.849Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('4b35e86d-1ae5-408d-824b-b69ee2170d60', 'Scenario Prospect 2', 'lead_2@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-09T00:15:30.907Z', '2026-02-09T00:15:30.907Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('45217ecd-4a0f-465f-8b0c-cc8f948e70cd', 'Scenario Prospect 3', 'lead_3@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-09T00:15:30.968Z', '2026-02-09T00:15:30.968Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('1e0ee2e9-a057-47a3-b746-f43799f1cca1', 'Scenario Prospect 4', 'lead_4@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-09T00:15:31.031Z', '2026-02-09T00:15:31.031Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('f4f355d8-c897-4a07-9e96-5b3438c37b6e', 'Scenario Prospect 5', 'lead_5@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-09T00:15:31.096Z', '2026-02-09T00:15:31.096Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('cc4213e7-4ec7-4d00-9cd6-bdd5b7d771d1', 'Scenario Prospect 6', 'lead_6@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-09T00:15:31.154Z', '2026-02-09T00:15:31.154Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('51e97e72-694a-4f0a-ac57-b698af79cd55', 'Scenario Prospect 7', 'lead_7@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-09T00:15:31.214Z', '2026-02-09T00:15:31.214Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('9c4afcd7-8e62-4302-b25f-53e425ff8658', 'Scenario Prospect 8', 'lead_8@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-09T00:15:31.274Z', '2026-02-09T00:15:31.274Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('b815b3cb-317e-4e80-a5f4-00dae4817321', 'Scenario Prospect 9', 'lead_9@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-09T00:15:31.332Z', '2026-02-09T00:15:31.332Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('0f549123-6fc6-47e9-a6c0-e521126fd331', 'Scenario Prospect 0', 'lead_0@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:09:55.541Z', '2026-02-08T23:09:55.541Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('fb3d0793-c9a3-4985-b8b3-321411b174f3', 'Scenario Prospect 1', 'lead_1@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:09:55.943Z', '2026-02-08T23:09:55.943Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('1518eedc-8452-4b7c-876a-088abc681d36', 'Scenario Prospect 2', 'lead_2@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:09:56.008Z', '2026-02-08T23:09:56.008Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('a808f70c-5b9d-46a8-adf6-e9355d629343', 'Scenario Prospect 3', 'lead_3@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:09:56.061Z', '2026-02-08T23:09:56.061Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('1fff527c-ec76-45a8-bdce-2cf04215d79b', 'Scenario Prospect 4', 'lead_4@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:09:56.115Z', '2026-02-08T23:09:56.115Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('903348ee-ba21-4e22-acaa-e8e83abf8dfc', 'Scenario Prospect 5', 'lead_5@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:09:56.174Z', '2026-02-08T23:09:56.174Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('730d1fa2-9cce-406d-b3ce-49478acaa824', 'Scenario Prospect 6', 'lead_6@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:09:56.227Z', '2026-02-08T23:09:56.227Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('34f10550-af92-4d96-8881-4e7e0f1bbefd', 'Scenario Prospect 7', 'lead_7@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:09:56.278Z', '2026-02-08T23:09:56.278Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('f1604519-81c1-47e1-8ba7-27434aa54e7c', 'Scenario Prospect 8', 'lead_8@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:09:56.332Z', '2026-02-08T23:09:56.332Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('36bfd43e-12d7-4442-bf70-852d366292c4', 'Scenario Prospect 9', 'lead_9@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:09:56.385Z', '2026-02-08T23:09:56.385Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('d280cd89-d046-4619-8694-0b6eaa99d11a', 'Scenario Prospect 0', 'lead_0@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:13:02.162Z', '2026-02-08T23:13:02.162Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('020f9e54-ec18-4245-9a5e-b25f530d9acb', 'Scenario Prospect 1', 'lead_1@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:13:02.221Z', '2026-02-08T23:13:02.221Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('aa08efea-c368-468f-ac82-2c619c29381c', 'Scenario Prospect 2', 'lead_2@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:13:02.273Z', '2026-02-08T23:13:02.273Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('e6356b34-9f86-4d61-af95-c528ef8ca491', 'Scenario Prospect 3', 'lead_3@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:13:02.333Z', '2026-02-08T23:13:02.333Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('f92eedf6-c33b-4a3e-87ab-7d07059e21e6', 'Scenario Prospect 4', 'lead_4@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:13:02.397Z', '2026-02-08T23:13:02.397Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('244235c0-7eed-4293-ac34-4ce6bec9f6f5', 'Scenario Prospect 5', 'lead_5@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:13:02.447Z', '2026-02-08T23:13:02.447Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('9f4a29b5-3cfe-487f-bdef-5434ba1d635a', 'Scenario Prospect 6', 'lead_6@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:13:02.497Z', '2026-02-08T23:13:02.497Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('cebfeed2-6278-412b-b17e-e69028ab368c', 'Scenario Prospect 7', 'lead_7@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:13:02.551Z', '2026-02-08T23:13:02.551Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('cd5f9d6a-6b08-47ae-9178-f1194658e967', 'Scenario Prospect 8', 'lead_8@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:13:02.602Z', '2026-02-08T23:13:02.602Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('7ea4f05b-f30d-4748-9e08-3585f67c8eac', 'Scenario Prospect 9', 'lead_9@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:13:02.654Z', '2026-02-08T23:13:02.654Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('0a5bdc91-90b5-4bc1-a771-646e1df0079b', 'Scenario Prospect 0', 'lead_0@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:16:57.777Z', '2026-02-08T23:16:57.777Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('ef61e68a-1715-4673-8b3a-13f40dbf8420', 'Scenario Prospect 1', 'lead_1@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:16:57.852Z', '2026-02-08T23:16:57.852Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('84c645f3-e85e-4543-971f-589e203d18cb', 'Scenario Prospect 2', 'lead_2@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:16:57.905Z', '2026-02-08T23:16:57.905Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('b150b384-a6de-4902-ab06-57aa6e2d32ee', 'Scenario Prospect 3', 'lead_3@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:16:57.955Z', '2026-02-08T23:16:57.955Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('1e485580-ff2f-4da5-bd9e-d00a53243703', 'Scenario Prospect 4', 'lead_4@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:16:58.007Z', '2026-02-08T23:16:58.007Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('07bb0ad0-b7ed-4caf-9ac9-a266101ca964', 'Scenario Prospect 5', 'lead_5@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:16:58.057Z', '2026-02-08T23:16:58.057Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('edac83ed-6574-4531-bddf-dedd90b1c1da', 'Scenario Prospect 6', 'lead_6@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:16:58.101Z', '2026-02-08T23:16:58.101Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('8b1ed245-8729-48e7-adc6-69b7218af412', 'Scenario Prospect 7', 'lead_7@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:16:58.146Z', '2026-02-08T23:16:58.146Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('3a7ee470-ed36-4407-9c14-a47cbeaa9a03', 'Scenario Prospect 8', 'lead_8@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:16:58.194Z', '2026-02-08T23:16:58.194Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('6113a793-7f2f-475f-bf34-512a5e4f1383', 'Scenario Prospect 9', 'lead_9@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:16:58.240Z', '2026-02-08T23:16:58.240Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('76405043-83ac-48cf-ac90-8e7cf82416d5', 'Scenario Prospect 0', 'lead_0@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:21:21.669Z', '2026-02-08T23:21:21.669Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('69804d6f-005d-4354-88f4-da563f08c901', 'Scenario Prospect 1', 'lead_1@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:21:21.726Z', '2026-02-08T23:21:21.726Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('995dd3c3-4250-44a9-97ab-cec87efc7a00', 'Scenario Prospect 2', 'lead_2@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:21:21.786Z', '2026-02-08T23:21:21.786Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('eb85c478-7bb3-49f3-9913-8686c909bafb', 'Scenario Prospect 3', 'lead_3@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:21:21.834Z', '2026-02-08T23:21:21.834Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('aae25a89-92a2-47d7-bcce-c72375b18555', 'Scenario Prospect 4', 'lead_4@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:21:21.892Z', '2026-02-08T23:21:21.892Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('487ddeed-9a05-4d29-9dd7-2c0f9dc1cf82', 'Scenario Prospect 5', 'lead_5@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:21:21.974Z', '2026-02-08T23:21:21.974Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('9eb4fb99-9674-4934-a3ad-d52f95ad1de0', 'Scenario Prospect 6', 'lead_6@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:21:22.038Z', '2026-02-08T23:21:22.038Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('b24c21b6-1135-444e-b830-af80bd53f542', 'Scenario Prospect 7', 'lead_7@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:21:22.106Z', '2026-02-08T23:21:22.106Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('c1491c07-d5b8-4ef4-9e7e-2716bc2da590', 'Scenario Prospect 8', 'lead_8@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:21:22.167Z', '2026-02-08T23:21:22.167Z');
INSERT INTO "leads" ("id", "fullName", "email", "phone", "message", "source", "status", "createdAt", "updatedAt") VALUES ('e7ef673f-132c-497b-b5c1-1c1122fab012', 'Scenario Prospect 9', 'lead_9@prospect.com', NULL, NULL, 'marketing_campaign', 'new', '2026-02-08T23:21:22.218Z', '2026-02-08T23:21:22.218Z');

-- Table for blogPost is empty

-- Table for pswDocument is empty

-- Data for table: faqs
INSERT INTO "faqs" ("id", "question", "answer", "category", "createdAt", "updatedAt") VALUES ('fbf3b3ba-ecb6-45f3-804f-59857a7cfcc0', 'What is PrimeCare?', 'An enterprise home care platform.', 'About', '2026-02-08T22:34:35.544Z', '2026-02-08T22:34:35.544Z');
INSERT INTO "faqs" ("id", "question", "answer", "category", "createdAt", "updatedAt") VALUES ('b837a551-7607-4ddb-9b38-3c7b6aa43d26', 'How to book?', 'Use the mobile app or web portal.', 'Usage', '2026-02-08T22:34:35.693Z', '2026-02-08T22:34:35.693Z');

-- Failed to dump dailyEntry: 
Invalid `prisma[modelName].findMany()` invocation in
C:\Users\User\Projects\psw_app\apps\worker-api\dump_db.js:38:53

  35 for (const modelName of models) {
  36     console.log(`Dumping table for model: ${modelName}...`);
  37     try {
→ 38         const records = await prisma[modelName].findMany(
The table `public.daily_entries` does not exist in the current database.

