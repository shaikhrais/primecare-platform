package baseDataProviders;

import java.io.FileNotFoundException;
import java.util.Properties;

import utilities.ExcelFileReader;

public class ProjectExcelFileData {

	static String mainDataFile = System.getProperty("user.dir") + "\\src\\test\\resources\\testData\\MainData.xlsx";

	public static void main(String[] args) {
		System.out.println("Main Start");
		Properties excelData = ExcelFileReader.readXLSXFile(mainDataFile, "config");

		// Example usage: print properties
		for (String key : excelData.stringPropertyNames()) {
			String value = excelData.getProperty(key);
			System.out.println(key + " = " + value);
		}

	}

	public static String chromeProfilePath() throws FileNotFoundException {
		return MainDataExcelFile().getProperty("chromeProfilePath");
	}

	public static String chromeProfile() throws FileNotFoundException {
		return MainDataExcelFile().getProperty("chromeProfile");
	}

	public static String Browser() throws FileNotFoundException {
		return MainDataExcelFile().getProperty("browser");
	}

	public static String url() throws FileNotFoundException {
		return MainDataExcelFile().getProperty("testUrl");
	}

	public static String testEmail() throws FileNotFoundException {
		return MainDataExcelFile().getProperty("testEmail");
	}

	public static String testPassword() throws FileNotFoundException {
		return MainDataExcelFile().getProperty("testPassword");
	}

	public static Properties MainDataExcelFile() {
		Properties excelData = ExcelFileReader.readXLSXFile(mainDataFile, "config");

		return excelData;
	}

}
