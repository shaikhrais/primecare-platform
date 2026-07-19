package utilities;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelFileReader {

	public static Properties readXLSXFile(String filePath, String workbookName) {
		Properties properties = new Properties();

		try (FileInputStream fis = new FileInputStream(filePath); Workbook workbook = new XSSFWorkbook(fis)) {

			Sheet sheet = workbook.getSheet(workbookName); // Use the provided workbook name

			for (Row row : sheet) {
				if (row.getCell(0) != null && row.getCell(1) != null) {
					String key = row.getCell(0).getStringCellValue();
					String value = row.getCell(1).getStringCellValue();
					properties.setProperty(key, value);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return properties;
	}

}
