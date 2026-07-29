package pageobjects.GoogleMaps;

import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import base.Action;
import base.baseTest;

public class GoogleMapsPage extends baseTest {

	Action action = new Action();

	public GoogleMapsPage() {
		PageFactory.initElements(driver, this);
	}

	XSSFWorkbook workbook;

	@FindBy(id = "searchboxinput")
	private WebElement searchBox;

	@FindBy(css = "//a[@aria-label and contains(@href, 'google.com/maps/place/')]")
	private List<WebElement> businessListItems;

	public void SearchQuary(String searchText) {
		driver.get("https://www.google.com/maps");
		searchBox.clear();
		searchBox.sendKeys(searchText);
		searchBox.sendKeys(Keys.ENTER);

	}

	List<WebElement> elements;

	public int scrollToBottom() {
		elements = driver.findElements(By.xpath("//a[@aria-label and @href]"));
		int counter = 1;
		while (true) {
			try {
				sleepandwait(5);

				elements = driver.findElements(By.xpath("//a[@aria-label and @href]"));

				System.out.println(
						"Current Processing Record No is " + counter + " - Total Records Found " + elements.size());
				WebElement element = elements.get(counter - 1);
				JavascriptExecutor js = (JavascriptExecutor) driver;
				js.executeScript("arguments[0].scrollIntoView();", element);
				element.click();

				counter++;
			} catch (Exception e) {
				counter--;
				System.out.println("Total " + counter + " records are found");
				return counter;
			}
		}

	}

	public void saveBusinessData() {

		elements = driver.findElements(By.xpath("//a[@aria-label and @href]"));
		int counter = elements.size();
		// System.err.println(elements + "\nTotal" + elements.size() + " Business Found
		// ");

		for (int i = elements.size(); i >= 0; i--) {
			elements = driver.findElements(By.xpath("//a[@aria-label and @href]"));
			WebElement element = elements.get(counter - 1);
			element.click();
			System.out.println("Current Processing Records No" + counter + "/" + elements.size());
			System.err.println("System waiting for 5 sec..............");

			getGoogleId();
			counter--;
		}
		// saveCSVFile(header, data);
	}

	public void clickPageNumber(int page, int pages) {
		try {
			WebElement page_button = driver.findElement(By.cssSelector("a[aria-label='Page " + page + "']"));
			page_button.click();
			System.out.println("page click " + page + "/" + pages + " ......wait for 10 seconds...");
			try {
				Thread.sleep(10000); // Sleep for 10 seconds
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		} catch (org.openqa.selenium.NoSuchElementException e) {

		}
	}

	public void sleepandwait(int sec) {
		try {
			Thread.sleep(sec * 1000); // Sleep for 10 seconds
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	public void saveCSVFile(String[] header, List<String[]> data) {
		try {
			FileWriter file = new FileWriter("c:\\gmap.csv");
			file.append(String.join(",", header) + "\n");
			for (String[] row : data) {
				file.append(String.join(",", row) + "\n");
			}
			file.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void getGoogleId() {
		WebElement Share_Button = driver
				.findElement(By.xpath("//button[contains(@aria-label, 'Share') and contains(@data-value, 'Share')]"));
		// System.out.println("Share_Button" + Share_Button);
		Share_Button.click();
		WebElement urlTextBox = driver.findElement(By.xpath("//input[contains(@value, 'https://maps.app.goo.gl/')]"));

		WebElement divElementName = driver.findElement(By.className("TDF87d"));
		WebElement divElementAddress = driver.findElement(By.className("vKmG2c"));

		System.out.println(divElementName.getText() + "\n" + divElementAddress.getText() + "\n"
				+ urlTextBox.getAttribute("value"));
		urlTextBox.sendKeys(Keys.ESCAPE);

	}

	public void scrollDownTheList(WebElement element) {
		JavascriptExecutor js = (JavascriptExecutor) driver;
		js.executeScript("arguments[0].scrollIntoView();", element);
	}

}
