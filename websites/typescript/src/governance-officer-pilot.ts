/** Governance-only introduction. The workspace's existing API projection decides access. */
const introduction = {
  en: 'Review governance activity and available reports.',
  fr: 'Consultez les activités de gouvernance et les rapports disponibles.',
  es: 'Consulta la actividad de gobernanza y los informes disponibles.',
} as const;

export function governanceOfficerIntroduction(
  host: string, route: string, pageCode: string | undefined, role: string, locale: keyof typeof introduction,
): string {
  if (host !== 'primecare-governance.pages.dev' || route !== '/management/governance-officer-dashboard' ||
      pageCode !== 'governance_officer_dashboard' || role !== 'governance') return '';
  return introduction[locale];
}
