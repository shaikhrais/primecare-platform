package testNG.PointClickCare;

import java.time.Duration;

import org.testng.annotations.Test;

import PageObjects.GoogleMaps.PointClickCare;
import PageObjectsPoint.ClickCare.HomePage;
import PageObjectsPoint.ClickCare.PatientsListPage;
import base.baseTest;

public class pointClickCareTest extends baseTest {

	PointClickCare pointClickCare;

	HomePage homePage;
	PatientsListPage patientsListPage;

	@Test
	public void testGoogleMapsDataScraping() throws InterruptedException {
		homePage = new HomePage();


		patientsListPage = new PatientsListPage();

		homePage.Login("roh.rshaikh", "s2452839@R");
		Thread.sleep(Duration.ofSeconds(30));
		//homePage.Login("hgn.ramiz", "22rr");
		// homePage.Login("","");
		patientsListPage.selectPhysiotherapy();
		patientsListPage.pageLoop("07/08/2026");
		//patientsListPage.clickEditButton("11/20/2024")
	}

}
