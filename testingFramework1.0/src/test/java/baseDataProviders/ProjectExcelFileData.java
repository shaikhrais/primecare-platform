package baseDataProviders;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;
import java.nio.file.Path;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ProjectExcelFileData {

	static String mainDataFile = Path.of(
			System.getProperty("user.dir"), "src", "test", "resources", "testData", "MainData.xlsx"
	).toString();

	public static Properties readXLSXFile(String filePath, String workbookName) {
		Properties properties = new Properties();
		try (FileInputStream fis = new FileInputStream(filePath); Workbook workbook = new XSSFWorkbook(fis)) {
			Sheet sheet = workbook.getSheet(workbookName);
			if (sheet != null) {
				for (Row row : sheet) {
					if (row.getCell(0) != null && row.getCell(1) != null) {
						String key = row.getCell(0).getStringCellValue();
						String value = row.getCell(1).getStringCellValue();
						properties.setProperty(key, value);
					}
				}
			}
		} catch (IOException e) {
			System.err.println("[ProjectExcelFileData] Error reading XLSX: " + e.getMessage());
		}
		return properties;
	}

	public static String chromeProfilePath() throws FileNotFoundException {
		return MainDataExcelFile().getProperty("chromeProfilePath");
	}

	public static String chromeProfile() throws FileNotFoundException {
		return MainDataExcelFile().getProperty("chromeProfile");
	}

	public static String Browser() throws FileNotFoundException {
		return MainDataExcelFile().getProperty("browser", System.getProperty("browser", "chrome"));
	}

	public static String url() {
		try {
			return primecare.testing.framework.DatabaseConfig.ensureSemanticsUrl(primecare.testing.framework.DatabaseConfig.getAuthUrl() + "/language");
		} catch (Exception e) {
			return "https://primecare-auth.pages.dev/language?enable-semantics=true";
		}
	}

	public static String testEmail() throws FileNotFoundException {
		return MainDataExcelFile().getProperty("testEmail");
	}

	public static String testPassword() throws FileNotFoundException {
		return MainDataExcelFile().getProperty("testPassword");
	}

	public static Properties MainDataExcelFile() {
		return readXLSXFile(mainDataFile, "config");
	}

}
