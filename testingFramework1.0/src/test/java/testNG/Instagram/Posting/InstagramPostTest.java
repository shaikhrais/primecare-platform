package testNG.Instagram.Posting;

import java.time.Duration;

import org.testng.annotations.Test;
import pageobjects.Instagram.Posting.InstagramPage;
import base.baseTest;

public class InstagramPostTest extends baseTest {

	private InstagramPage instagramPage;

	@Test
	public void testInstagramPost() {
		instagramPage = new InstagramPage();
		driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));
		instagramPage.navigateToPostCreationPage();
		driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));

		// Replace 'path/to/your/image.jpg' and 'Your post caption' with actual values
		instagramPage.uploadImage("path/to/your/image.jpg");
		instagramPage.enterCaption("Your post caption");

		instagramPage.sharePost();
	}
}
