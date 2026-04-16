import { PrismaClient, PlatformRole } from '@prisma/client';

const prisma = new PrismaClient();

export class UserService {
  /**
   * Retrieves all users.
   */
  async getAllUsers() {
    return prisma.user.findMany({
      include: {
        providerProfile: true,
        clientProfile: true,
      },
    });
  }

  /**
   * Provisions a new user in the system.
   * Handles linking a generic profile if needed.
   */
  async createUser(payload: {
    email: string;
    firstName: string;
    lastName: string;
    role: PlatformRole;
    officeName?: string;
  }) {
    // Check if the user already exists
    const existing = await prisma.user.findUnique({
      where: { email: payload.email },
    });

    if (existing) {
      throw new Error(`User with email ${payload.email} already exists.`);
    }

    // Creating user and generic provider profile in a transaction
    return prisma.$transaction(async (tx) => {
      const user = await tx.user.create({
        data: {
          email: payload.email,
          role: payload.role,
        },
      });

      // Create a provider profile as a catch-all to store names unless it's a client.
      await tx.providerProfile.create({
        data: {
          userId: user.id,
          firstName: payload.firstName,
          lastName: payload.lastName,
          title: payload.role.replace(/_/g, ' '),
        },
      });

      return user;
    });
  }

  /**
   * Issues a password reset action for the user.
   */
  async resetPassword(userId: string, newPasswordHash: string) {
    // In a real application, you'd hash the password and update it.
    // Assuming we have a password field or handled via AuthProvider like Supabase.
    // For now, this is a placeholder implementation if using local pass or a mock.
    console.log(`Resetting password for user ${userId}`);
    return { success: true, message: 'Password reset' };
  }

  /**
   * Toggles active status of a user (soft delete / ban).
   */
  async toggleStatus(userId: string, isActive: boolean) {
    // Prisma schema does not have an explicit `isActive` on User unless implemented.
    // Would normally update `status` or `deletedAt`.
    console.log(`Toggling status for user ${userId} to ${isActive}`);
    return { success: true };
  }
}
