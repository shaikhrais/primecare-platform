package PageObjectsPoint.ClickCare;

import java.util.List;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import base.baseTest;
import utilities.DateClass;

public class PatientDetailsPage extends baseTest {
	public PatientDetailsPage() {
		PageFactory.initElements(driver, this);
	}

	@FindBy(xpath = "//a[contains(@id, 'linkackCust')]")
	private List<WebElement> listCheckbox;

	@FindBy(xpath = "//*[@id=\"linkCust___dummy\"]")
	private WebElement textboxDate;

	@FindBy(xpath = "//*[@id=\"saveandexitbutton\"]")
	private WebElement buttonSaveAndExit;

	@FindBy(xpath = "//*[@id=\"cancelbutton\"]")
	private WebElement buttonCancel;

	public void clickButtonAndsave(String DateOfEntry) {
		int days = DateClass.DateDifference(textboxDate.getAttribute("value"), DateOfEntry);
		if (days >= 3) {
			textboxDate.clear();
			textboxDate.sendKeys(DateOfEntry);

			System.out.println("CheckBox Button : " + listCheckbox.size());
			System.out.print("Checkbox clicked : ");
			for (int i = 1; i < listCheckbox.size(); i++) {
				System.out.print("," + i);
				try {
					listCheckbox.get(i).click();
				} catch (Exception e) {
					System.out.println("Current record :" + i + " " + e.getMessage());
				}
			}
			buttonSaveAndExit.click();
			System.out.println(" Save and exit clicked");
		} else {
			buttonCancel.click();
			System.out.println(" Save and exit failed,  Cancel clicked");
		}

	}

}
