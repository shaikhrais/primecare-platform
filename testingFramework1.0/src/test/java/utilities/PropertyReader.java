package utilities;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class PropertyReader {

	public static Properties readPropertyFile(String fileName) throws IOException {
		Properties properties = new Properties();

		// Create a FileInputStream object to read the property file
		FileInputStream fis = new FileInputStream(fileName);

		// Load the property file into the Properties object
		properties.load(fis);

		// Close the FileInputStream object
		fis.close();

		return properties;
	}
}
