/**
 * Admin Finance Sub-App
 * Financial, payroll, claims, ERP
 */
import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import financialRoutes from '../financial/financial.routes';
import payrollRoutes from '../payroll/payroll.routes';
import claimRoutes from '../claims/claims.routes';
import erpRoutes from '../erp/erp.routes';

const finance = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

finance.route('/financial', financialRoutes);
finance.route('/payroll', payrollRoutes);
finance.route('/claims', claimRoutes);
finance.route('/erp', erpRoutes);

export default finance;
