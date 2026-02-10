export { };

declare global {
    namespace Cypress {
        interface SuiteConfigOverrides {
            /**
             * Tags for @cypress/grep filtering
             */
            tags?: string | string[];
        }
        interface TestConfigOverrides {
            /**
             * Tags for @cypress/grep filtering
             */
            tags?: string | string[];
        }
    }
}
