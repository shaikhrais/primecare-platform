package testNG.GoogleMaps;

import org.testng.annotations.Test;
import pageobjects.GoogleMaps.GoogleMapsPage;
import base.baseTest;

public class GoogleMapsTest extends baseTest {

	GoogleMapsPage googleMapsPage;
	// private GoogleSearch googleSearch;

	@Test
	public void testGoogleMapsDataScraping() throws InterruptedException {

		googleMapsPage = new GoogleMapsPage();
		googleMapsPage.SearchQuary("restaurants near me");
		googleMapsPage.scrollToBottom();
		// googleMapsPage.saveBusinessData();
	}
}
