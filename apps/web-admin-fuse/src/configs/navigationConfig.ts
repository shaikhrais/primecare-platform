import i18n from '@i18n';
import { FuseNavItemType } from '@fuse/core/FuseNavigation/types/FuseNavItemType';
import ar from './navigation-i18n/ar';
import en from './navigation-i18n/en';
import tr from './navigation-i18n/tr';

i18n.addResourceBundle('en', 'navigation', en);
i18n.addResourceBundle('tr', 'navigation', tr);
i18n.addResourceBundle('ar', 'navigation', ar);

/**
 * The navigationConfig object is an array of navigation items for the Fuse application.
 */
const navigationConfig: FuseNavItemType[] = [
	{
		id: 'dashboard',
		title: 'Dashboard',
		type: 'item',
		icon: 'heroicons-outline:chart-bar',
		url: '/admin/dashboard'
	},
	{
		id: 'users',
		title: 'Users & PSWs',
		type: 'item',
		icon: 'heroicons-outline:users',
		url: '/admin/users'
	},
	{
		id: 'schedule',
		title: 'Schedule',
		type: 'item',
		icon: 'heroicons-outline:calendar',
		url: '/admin/schedule'
	},
	{
		id: 'incidents',
		title: 'Incidents',
		type: 'item',
		icon: 'heroicons-outline:exclamation-circle',
		url: '/admin/incidents'
	},
	{
		id: 'timesheets',
		title: 'Timesheets',
		type: 'item',
		icon: 'heroicons-outline:clock',
		url: '/admin/timesheets'
	},
	{
		id: 'leads',
		title: 'Lead Inquiries',
		type: 'item',
		icon: 'heroicons-outline:inbox-in',
		url: '/admin/leads'
	},
	{
		id: 'services',
		title: 'Services',
		type: 'item',
		icon: 'heroicons-outline:cash',
		url: '/admin/services'
	}
];


export default navigationConfig;
