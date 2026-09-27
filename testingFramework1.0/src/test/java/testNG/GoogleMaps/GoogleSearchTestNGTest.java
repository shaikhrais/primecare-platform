package testNG.GoogleMaps;

import org.testng.annotations.Test;
import pageobjects.GoogleMaps.GoogleSearch;
import base.baseTest;

public class GoogleSearchTestNGTest extends baseTest {

	// private GoogleMapsPage googleMapsPage;
	private GoogleSearch googleSearch;

	@Test
	public void testGoogleMapsDataScraping() throws InterruptedException {
		// googleMapsPage= new GoogleMapsPage();
		// googleMapsPage.SearchQuary("restaurants near me");
		googleSearch = new GoogleSearch();
		googleSearch.SearchQuary("restaurants near me");
		googleSearch.redirectToBusinessList();
		// googleSearch.ReadBusinessList();
		googleSearch.saveBusinessData();
	}
}
