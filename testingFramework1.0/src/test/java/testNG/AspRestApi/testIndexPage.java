package testNG.AspRestApi;

import org.testng.annotations.Test;
import pageobjects.AspRestApi.ApiIndexPage;
import base.baseTest;

public class testIndexPage extends baseTest {
	ApiIndexPage apiIndexPage;

	@Test
	public void testIndexPageByPageFactory() {
		apiIndexPage = new ApiIndexPage();
		apiIndexPage.clickAllEndPointButtons();
	}

}
