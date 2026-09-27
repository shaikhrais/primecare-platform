package base;

import org.testng.IExecutionListener;

public class TestNGVerificationListener
        implements IExecutionListener {

    private static final String REPORT_DIRECTORY =
            "test-output/primecare-verification";

    @Override
    public void onExecutionStart() {

        SQLiteVerificationDatabase.initializeDatabase();

        System.out.println(
                "[TESTNG] Verification execution started."
        );
    }

    @Override
    public void onExecutionFinish() {

        String excelPath =
                TestNGExcelReportWriter
                        .createExcelReport(
                                REPORT_DIRECTORY
                        );

        ExcelToSQLiteImporter importer =
                new ExcelToSQLiteImporter();

        importer.importExcel(excelPath);

        TestNGHtmlReportWriter.generateDashboardReport(REPORT_DIRECTORY);

        System.out.println(
                "[TESTNG] Executive HTML Dashboard & Excel report generated successfully."
        );
    }
}
