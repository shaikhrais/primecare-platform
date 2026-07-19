package base;

import org.testng.Assert;

public abstract class BasePageFunctionalTest
        extends BasePageComponentTest {

    /**
     * Child test class implements the actual functionality.
     */
    protected abstract void executePageFunctions()
            throws Exception;

    protected void executeLevel3FunctionalVerification() {

        /*
         * Functional testing is permitted only after:
         *
         * Level 1: page verified
         * Level 2: components verified
         */
        executeLevel2ComponentVerification();

        long startTime =
                System.currentTimeMillis();

        String status =
                "FAILED";

        String failureMessage =
                "";

        try {

            System.out.println(
                    "\n========== LEVEL 3 FUNCTIONAL TEST =========="
            );

            executePageFunctions();

            status = "PASSED";

            System.out.println(
                    "[LEVEL 3 PASSED] Functional testing passed for "
                            + getPageDefinition().getPageName()
            );

        } catch (Exception exception) {

            failureMessage =
                    exception.getMessage();

            Assert.fail(
                    "LEVEL 3 FUNCTIONAL TEST FAILED"
                            + "\nPage: "
                            + getPageDefinition()
                                    .getPageName()
                            + "\nURL: "
                            + driver.getCurrentUrl()
                            + "\nError: "
                            + exception.getMessage(),
                    exception
            );

        } finally {

            SQLiteFunctionalResultRepository.save(
                    getPageDefinition()
                            .getScreenId(),
                    getPageDefinition()
                            .getPageName(),
                    getClass().getName(),
                    status,
                    failureMessage,
                    System.currentTimeMillis()
                            - startTime
            );
        }
    }
}
