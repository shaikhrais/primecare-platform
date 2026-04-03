import { Context } from 'hono';

export const handleGetSummary = async (c: Context) => {
  return c.json({ status: 'CARE-PLANS domain operational' });
};
