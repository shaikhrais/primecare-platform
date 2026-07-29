package pageobjects.AspRestApi;

import java.util.List;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import base.Action;
import base.baseTest;

public class ApiIndexPage extends baseTest {

	Action action = new Action();

	public ApiIndexPage() {
		PageFactory.initElements(driver, this);

		driver.get("http://localhost:5171/swagger/index.html");
	}

	XSSFWorkbook workbook;

	@FindBy(xpath = "//button[contains(@class,'expand-operation')]")
	private List<WebElement> ListOfControllersButtons;

	@FindBy(xpath = "//button[contains(@aria-label, 'post ') or contains(@aria-label, 'get ')]")
	private List<WebElement> ListOfAllEndPointButtons;

	public void clickAllEndPointButtons() {
		for (WebElement element : ListOfAllEndPointButtons) {
			element.click();
		}

	}

	public void sleepandwait(int sec) {
		try {
			Thread.sleep(sec * 1000); // Sleep for 10 seconds
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

}
