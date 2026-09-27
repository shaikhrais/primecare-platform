package utilities;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;

public class ImageDownloader {

	public static void downloadImage(String imageUrl, String destinationPath) {
		try {
			// Open a connection to the image URL
			URL url = new URL(imageUrl);
			InputStream is = url.openStream();
			OutputStream os = new FileOutputStream(destinationPath);

			// Read the image content and write it to the destination path
			byte[] buffer = new byte[2048];
			int bytesRead;
			while ((bytesRead = is.read(buffer)) != -1) {
				os.write(buffer, 0, bytesRead);
			}

			// Close streams
			is.close();
			os.close();

			System.out.println("Image downloaded and saved to: " + destinationPath);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
