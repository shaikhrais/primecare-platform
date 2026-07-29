package pageobjects.GoogleMaps;

import java.util.List;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import base.Action;
import base.baseTest;

public class PointClickCare extends baseTest {

	Action action = new Action();

	public PointClickCare() {
		PageFactory.initElements(driver, this);

		driver.get("https://login.pointclickcare.com/home/userLogin.xhtml");
	}

	XSSFWorkbook workbook;

	@FindBy(id = "username")
	private WebElement userName;

	@FindBy(id = "id-next")
	private WebElement buttonNext;

	public void Login(String User, String Passcode) {
		userName.sendKeys(User);
		buttonNext.click();

		WebElement textboxPassword = driver.findElement(By.xpath("//*[@id=\"password\"]"));
		textboxPassword.sendKeys(Passcode);

		WebElement buttonSignIn = driver.findElement(By.xpath("//*[@id=\"id-submit\"]"));
		buttonSignIn.click();

		driver.get("https://www60.pointclickcare.com/care/chart/assess/assesslist.jsp?ESOLview=In Progress");

		WebElement selectAssessmentType = driver
				.findElement(By.xpath("/html/body/form/table[2]/tbody/tr[1]/td/select"));
		action.selectByValue(selectAssessmentType, "10834");

	}

	List<WebElement> pageEditButtons;

	public void editButtonExec(String DateOfEntry) {
		pageEditButtons = driver.findElements(By.xpath("//a[@class=\"listbutton\"]"));
		System.err.println("Total Number of Patient's Records Found : " + pageEditButtons.size());
		for (int i = 0; i < pageEditButtons.size(); i++) {
			try {
				System.err.println("Process records" + (i + 1) + "//" + pageEditButtons.size());
				pageEditButtons = driver.findElements(By.xpath("//a[@class=\"listbutton\"]"));

				WebElement element = pageEditButtons.get(i);
				element.click();
				// sleepandwait(3);
				clickAllCheckBox(DateOfEntry);

			} catch (Exception e) {

				System.out.println(e.getMessage());

			}
		}
	}

	List<WebElement> pageCheckBoxs;

	public void clickAllCheckBox(String DateOfEntry) {

		try {
			pageCheckBoxs = driver.findElements(By.xpath("//a[contains(@id, 'linkackCust')]"));
			System.out.println("No of CheckBox Found : " + pageCheckBoxs.size());
			if (pageCheckBoxs.size() == 0) {
				WebElement buttonCancel = driver.findElement(By.xpath("//*[@id=\"cancelbutton\"]"));
				buttonCancel.click();
				System.out.println("Skip The Record............. ");
				return;
			}
			WebElement textboxDate = driver.findElement(By.xpath("//*[@id=\"linkCust___dummy\"]"));
			textboxDate.clear();
			textboxDate.sendKeys(DateOfEntry);

			pageCheckBoxs = driver.findElements(By.xpath("//a[contains(@id, 'linkackCust')]"));
			for (WebElement element : pageCheckBoxs) {
				element.click();
			}

			WebElement buttonSaveAndExit = driver.findElement(By.xpath("//*[@id=\"saveandexitbutton\"]"));
			buttonSaveAndExit.click();
		} catch (Exception e) {
			// TODO: handle exception
			System.err.println("clickAllCheckBox : " + e.getMessage());
		}
		// saveCSVFile(header, data);
	}

	public void sleepandwait(int sec) {
		try {
			Thread.sleep(sec * 1000); // Sleep for 10 seconds
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

}
