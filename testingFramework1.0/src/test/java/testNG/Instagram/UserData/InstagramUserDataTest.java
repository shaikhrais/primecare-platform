package testNG.Instagram.UserData;

import org.testng.annotations.Test;
import pageobjects.Instagram.InstagramLoginPage;
import pageobjects.Instagram.UserData.InstagramUserPage;
import base.baseTest;

public class InstagramUserDataTest extends baseTest {

	private InstagramUserPage userPage;
	private InstagramLoginPage loginPage;

	@Test
	public void testInstagramUserData() throws InterruptedException {

//		loginPage = new  InstagramLoginPage();
//		loginPage.login();
		userPage = new InstagramUserPage();
//Thread.sleep(Duration.ofMinutes(3));
userPage.scrollToBottomUntilAllItemsLoad();
//userPage.printInfo();
userPage.clickOnPosts();
		// userPage.clickOnPosts();

	}
}
