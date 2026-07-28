package baseDataProviders;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Properties;

public class ProjectProperties {

	static String configFile = System.getProperty("user.dir")
			+ "\\src\\test\\resources\\configFiles\\config.properties";

	public static String Browser() throws FileNotFoundException {
		return configFileData().getProperty("browser");
	}

	public static String url() throws FileNotFoundException {
		return configFileData().getProperty("testUrl");
	}

	private static Properties configFileData() throws FileNotFoundException {
		try (FileInputStream fis = new FileInputStream(configFile)) {
			Properties myprop = new Properties();
			myprop.load(fis);
			return myprop;
		} catch (Exception ex) {
			System.err.println("[Error] : " + ex.getMessage());
		}
		return null;
	}

}
