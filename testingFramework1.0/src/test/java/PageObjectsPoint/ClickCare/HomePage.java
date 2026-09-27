package PageObjectsPoint.ClickCare;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import base.baseTest;

public class HomePage extends baseTest {

	public HomePage() {
		PageFactory.initElements(driver, this);
		driver.get("https://login.pointclickcare.com/home/userLogin.xhtml");
	}

	@FindBy(id = "username")
	private WebElement userName;

	@FindBy(id = "id-next")
	private WebElement buttonNext;

	@FindBy(xpath = "//input[@type='password' and @data-test='login-password-input']")
	private WebElement textboxPassword;

	@FindBy(xpath = "//button[@data-test='login-signIn-button']")
	private WebElement buttonSubmit;

	public void Login(String User, String Passcode) throws InterruptedException {
		userName.clear();
		userName.sendKeys(User);
		buttonNext.click();

		// action.explicitWait(driver, textboxPassword, 10);
		System.out.println("Before Enter Password");
		textboxPassword.clear();
		textboxPassword.sendKeys(Passcode);
		System.out.println("After Enter Password. Next is Click Submit");

		action.explicitWait(driver, buttonSubmit, 10);
		System.out.println("After Wait");
		buttonSubmit.click();
		Thread.sleep(30000);
		//action.explicitWait(driver, buttonSubmit, 10);
		Thread.sleep(5000);
		System.out.println("After Click");

		driver.get("https://www60.pointclickcare.com/care/chart/assess/assesslist.jsp?ESOLview=In Progress");

		System.out.println("After Navigation");
	}

}
