package PageObjectsPoint.ClickCare;

import java.util.Calendar;
import java.util.List;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import base.Action;
import base.baseTest;

public class PatientsListPage extends baseTest {

	public PatientsListPage() {
		PageFactory.initElements(driver, this);
	}

	@FindBy(xpath = "/html/body/form/table[2]/tbody/tr[1]/td/select")
	private WebElement comboAssessmentType;

	// @FindBy(xpath = "//a[@class=\"listbutton\"]")
	@FindBy(xpath = "//a[text()='edit']")
	private List<WebElement> listEditButton;

	@FindBy(xpath = "//a[@class=\"Next »\"]")
	private WebElement nextButton;

	@FindBy(xpath = "//*[@id=\"msg\"]/table[2]/tbody/tr/td/span/a")
	private List<WebElement> paginationButtons;

	Action action = new Action();

	public void selectPhysiotherapy() {
		action.selectByValue(comboAssessmentType, "10834");
	}

	public void pageNoClick(String DateOfEntry, int PageNumber) {
		try {

			System.out.println("You are in loop of pages \n Page size is .....");
			System.out.println(paginationButtons.size());

			for (int i = 0; i < paginationButtons.size(); i++) {
				paginationButtons.get(i).click();
				System.out.println("Page No " + (i + 1));
				clickEditButton(DateOfEntry, i,true );

				System.out
						.println("Clicked on button " + (i + 1) + ":  Page no : " + paginationButtons.get(i).getText());
				if (i == 0) {
					i++;
				} else if (i == paginationButtons.size() - 2) {
					i++;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();

		}
	}

	public void pageLoop(String DateOfEntry) {
		try {
			boolean isPage = false;

			System.out.println("You are in loop of pages \n Page size is .....");
			System.out.println(paginationButtons.size());
			if (paginationButtons.size() == 0) {
				System.out.println("There is no Page Button ");
				isPage = false;
				clickEditButton(DateOfEntry, 0, false);

			} else {
				isPage = true;
				for (int i = 0; i <= paginationButtons.size(); i++) {

					paginationButtons.get(i).click();
					// Thread.sleep(2000); // Pause for 2 seconds (adjust as necessary)
					System.out.println("Page No " + (i + 1));
					clickEditButton(DateOfEntry, i, true);
					// System.out.println("Clicked on button " + (i + 1) + ": " +
					// driver.getCurrentUrl());
					// System.out.println("Size of Pages :",paginationButtons.size());
					System.out.println(
							"Clicked on button " + (i + 1) + ":  Page no : " + paginationButtons.get(i).getText());
					if (i == 0) {
						i++;
					} else if (i == paginationButtons.size() - 2) {
						i++;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();

		}
	}

	PatientDetailsPage patientDetailsPage;

	public void clickEditButton(String DateOfEntry, int PageNo, boolean isPages) throws InterruptedException {

		patientDetailsPage = new PatientDetailsPage();

		for (int i = 0; i < listEditButton.size(); i++) {
			System.out.println(
					Calendar.getInstance().getTime() + " : Edit Button : " + (i + 1) + "/" + listEditButton.size());
			listEditButton.get(i).click();
			patientDetailsPage.clickButtonAndsave(DateOfEntry);
			if (PageNo != 0 && isPages) {
				paginationButtons.get(PageNo).click();
				Thread.sleep(2000); // Pause for 2 seconds (adjust as necessary)
				System.out.println("Going to page again");
			}
		}
	}

}
