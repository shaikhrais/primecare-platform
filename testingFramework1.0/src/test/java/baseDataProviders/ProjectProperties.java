package baseDataProviders;

import java.io.FileNotFoundException;
import java.util.Properties;

import utilities.PropertyReader;

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
		// TODO Auto-generated method stub
		try {
			Properties myprop = PropertyReader.readPropertyFile(
					System.getProperty("user.dir") + "\\src\\test\\resources\\configFiles\\config.properties");
			System.out.println(myprop);
			return myprop;
		} catch (Exception ex) {

			System.err.println("[Error] : " + ex.getMessage());
		}
		return null;
	}

}
