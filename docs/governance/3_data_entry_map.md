# Data Entry Map

*This document maps input fields all the way to the database row and tracks the validation chain.*

## 1. User Management: Create User (`CreateUserForm`)

| Field UI Name | UI Validation | API Endpoint | API Validation | Backend Service | DB Table.Column (Prisma) | Verification Method |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| First Name | Required, max 50 | `POST /users` | Zod constraint | `UserService.create` | `User.firstName` | Check DB row after UI submission |
| Last Name | Required, max 50 | `POST /users` | Zod constraint | `UserService.create` | `User.lastName` | Check DB row after UI submission |
| Email | Required, valid email | `POST /users` | Zod email, unique | `UserService.create` | `User.email` | Check DB row after UI submission |
| Role | Required | `POST /users` | Zod enum check | `UserService.create` | `User.role` | Check DB row after UI submission |
| Facility | Required | `POST /users` | Zod uuid check | `UserService.create` | `User.facilityId` | Check DB row after UI submission |

## 1. User Management: Edit User / Deactivate
| Field UI Name | UI Validation | API Endpoint | API Validation | Backend Service | DB Table.Column (Prisma) | Verification Method |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| Full Name | None | None | None | None | `User.firstName/lastName` missing | Update local memory state only |
| Email Address | None | None | None | None | `User.email` | Update local memory state only |
| Role | Select from list | None | None | None | `User.roles` | Update local memory state only |
| Office/Department | Select from list | None | None | None | No direct match in `User`| Update local memory state only |
| Status Toggle | None | None | None | None | `User.status` | Update local memory state only |

## 1. User Management: Password Reset
*(Missing entirely from UI)*
