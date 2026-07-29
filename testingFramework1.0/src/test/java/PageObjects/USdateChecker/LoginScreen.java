package pageobjects.USdateChecker;


import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import base.baseTest;

public class LoginScreen extends baseTest {

	public LoginScreen() {
		PageFactory.initElements(driver, this);
		driver.get("https://ais.usvisa-info.com/en-ca/niv/users/sign_in");
	}

	@FindBy(id = "user_email")
	private WebElement userName;


	@FindBy(id = "user_password")
	private WebElement textboxPassword;

	@FindBy(name =  "commit")
	private WebElement buttonSubmit;

	@FindBy(id  = "policy_confirmed")
	private WebElement cbAgree;

	public void Login(String User, String Passcode) throws InterruptedException {
		userName.clear();
		userName.sendKeys(User);
		//buttonNext.click();

		// action.explicitWait(driver, textboxPassword, 10);
		System.out.println("Before Enter Password");
		textboxPassword.clear();
		textboxPassword.sendKeys(Passcode);
		System.out.println("After Enter Password. Next is Click Submit");

		checkICheckbox(cbAgree);

		buttonSubmit.click();
		action.explicitWait(driver, buttonSubmit, 10);
		System.out.println("After Wait");
		//buttonSubmit.click();
		action.explicitWait(driver, buttonSubmit, 10);
		Thread.sleep(5000);
		System.out.println("After Click");

		//driver.get("https://www60.pointclickcare.com/care/chart/assess/assesslist.jsp?ESOLview=In Progress");

		System.out.println("After Navigation");
	}

	public boolean checkICheckbox( WebElement checkbox) {
	    boolean isChecked = false;
	    try {
	        // First check if already selected
	        isChecked = (Boolean) ((JavascriptExecutor) driver)
	            .executeScript("return arguments[0].checked", checkbox);

	        if (!isChecked) {
	            // Try to find and click the parent div (iCheck container)
	            WebElement parentDiv = checkbox.findElement(By.xpath("./.."));
	            parentDiv.click();

	            // Verify if successful
	            isChecked = (Boolean) ((JavascriptExecutor) driver)
	                .executeScript("return arguments[0].checked", checkbox);

	            // If clicking parent didn't work, try JavaScript
	            if (!isChecked) {
	                ((JavascriptExecutor) driver).executeScript(
	                    "arguments[0].checked = true; " +
	                    "let event = new Event('change', { bubbles: true }); " +
	                    "arguments[0].dispatchEvent(event);", checkbox);

	                isChecked = (Boolean) ((JavascriptExecutor) driver)
	                    .executeScript("return arguments[0].checked", checkbox);
	            }
	        }
	        return isChecked;
	    } catch (Exception e) {
	        System.out.println("Error checking iCheck checkbox: " + e.getMessage());
	        return false;
	    }
	}
}
