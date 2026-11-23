/** Local capture data only. No session, token, backend or settings writes. */
type NavigationFixture = {
 version: 1;
 fixtureOnly: true;
 account: {role: string; displayName: string};
 language: string;
 entries: Array<{route: string; label: string; icon: string | null}>;
};
declare global {
 interface Window { __primecareNavigationFixture?: NavigationFixture }
}
export const navigationFixture = window.__primecareNavigationFixture;
export default function useUser() {
 const account = navigationFixture?.account;
 return {
  isGuest: !account,
  data: account ?? null,
  updateUser: async () => null,
  updateUserSettings: async () => null,
  signOut: async () => null,
 };
}
