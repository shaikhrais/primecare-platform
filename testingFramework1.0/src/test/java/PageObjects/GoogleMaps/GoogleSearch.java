package pageobjects.GoogleMaps;

import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import base.Action;
import base.baseTest;

public class GoogleSearch extends baseTest {
	Action action = new Action();

	public GoogleSearch() {
		PageFactory.initElements(driver, this);
	}

	XSSFWorkbook workbook;

	@FindBy(name = "q")
	private WebElement searchBox;

	@FindBy(tagName = "g-more-link")
	private WebElement MoreButton;

	@FindBy(css = "div#search a[class='vwVdIc wzN8Ac rllt__link a-no-hover-decoration']")
	private List<WebElement> BusinessList;

	public String[] extractDataFromWebelements(WebElement element) {

		String data_cid = element.getAttribute("data-cid");
		element.click();

		try {
			Thread.sleep(5000); // Sleep for 5 seconds
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		// title
		WebElement title = driver.findElement(By.cssSelector("h2[data-attrid='title']"));
		System.out.println("title: " + title.getText());

		// String[] row = {data_cid, title.getText(), address, website, phone, rating,
		// reviews, image, category, timing, description, profiles};
		String[] row = { data_cid, title.getText(), " address", " website", " phone", " rating", " reviews", " image",
				" category", " timing", " description", " profiles" };
		element.clear();
		return row;
	}

	public String[] originalExtractDataFromWebelements(WebElement element) {

		String data_cid = element.getAttribute("data-cid");
		element.click();
		System.out.println("item click... 5 seconds...");
		try {
			Thread.sleep(5000); // Sleep for 5 seconds
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		// title
		WebElement title = driver.findElement(By.cssSelector("h2[data-attrid='title']"));
		System.out.println("title: " + title.getText());

		// address
		String address = "";
		try {
			WebElement temp_obj = driver
					.findElement(By.cssSelector("div[data-attrid='kc:/location/location:address'] span:nth-child(2)"));
			if (temp_obj.getText().length() > 0) {
				address = temp_obj.getText();
			}
		} catch (org.openqa.selenium.NoSuchElementException e) {
			address = "";
		}
		System.out.println("address: " + address);

		// website
		String website = "";
		try {
			WebElement temp_obj = driver
					.findElement(By.cssSelector("div[class='kp-header'] div > div > div:nth-child(2) > div > a"));
			if (temp_obj.getText().equals("Website")) {
				website = temp_obj.getAttribute("href");
			} else {
				website = "";
			}
		} catch (org.openqa.selenium.NoSuchElementException e) {
			website = "";
		}
		System.out.println("website: " + website);

		// phone
		String phone = "";
		try {
			WebElement temp_obj = driver.findElement(By.cssSelector(
					"div[data-attrid='kc:/collection/knowledge_panels/has_phone:phone'] span:nth-child(2) > span > a > span"));
			if (temp_obj.getText().length() > 0) {
				phone = temp_obj.getText();
			}
		} catch (org.openqa.selenium.NoSuchElementException e) {
			phone = "";
		}
		System.out.println("phone: " + phone);

		// rating
		String rating = "";
		try {
			WebElement temp_obj = driver.findElement(By.cssSelector("g-review-stars span"));
			if (temp_obj.getAttribute("aria-label").length() > 0) {
				rating = temp_obj.getAttribute("aria-label");
			}
		} catch (org.openqa.selenium.NoSuchElementException e) {
			rating = "";
		}
		System.out.println("rating: " + rating);

		// total reviews
		String reviews = "";
		try {
			WebElement temp_obj = driver.findElement(By.cssSelector("a[data-async-trigger='reviewDialog'] span"));
			if (temp_obj.getText().length() > 0) {
				reviews = temp_obj.getText();
			}
		} catch (org.openqa.selenium.NoSuchElementException e) {
			reviews = "";
		}
		System.out.println("reviews: " + reviews);

		// image
		String image = "";
		try {
			WebElement temp_obj = driver
					.findElement(By.cssSelector("div[data-attrid='kc:/location/location:media'] > div > a > div"));
			if (temp_obj.getAttribute("style").length() > 0) {
				image = temp_obj.getAttribute("style");
				if (image.contains("background")) {
					image = image.replace("background-image: url(\"", "").replace("\");", "");
				}
			}
		} catch (org.openqa.selenium.NoSuchElementException e) {
			image = "";
		}
		System.out.println("image: " + image);

		// category
		String category = "";
		try {
			WebElement temp_obj = driver
					.findElement(By.cssSelector("div[data-attrid='kc:/local:lu attribute list'] > div > div > span"));
			if (temp_obj.getText().length() > 0) {
				category = temp_obj.getText();
			}
		} catch (org.openqa.selenium.NoSuchElementException e) {
			try {
				WebElement temp_obj = driver
						.findElement(By.cssSelector("div[data-attrid='kc:/local:one line summary'] > div > span"));
				if (temp_obj.getText().length() > 0) {
					category = temp_obj.getText();
				}
			} catch (org.openqa.selenium.NoSuchElementException ex) {
				category = "";
			}
		}
		System.out.println("category: " + category);

		// timing
		String timing = "";
		try {
			WebElement temp_obj = driver.findElement(By.cssSelector(
					"div[data-attrid='kc:/location/location:hours'] > div > div > div:nth-child(2) > div > table"));
			if (temp_obj.getAttribute("innerHTML").length() > 0) {
				timing = "<table>" + temp_obj.getAttribute("innerHTML").replace(" class=\"SKNSIb\"", "") + "</table>";
			}
		} catch (org.openqa.selenium.NoSuchElementException e) {
			timing = "";
		}
		System.out.println("timing: " + timing);

		// description
		String description = "";
		try {
			WebElement temp_obj = driver.findElement(By.cssSelector("div[data-long-text]"));
			if (temp_obj.getAttribute("data-long-text").length() > 0) {
				description = temp_obj.getAttribute("data-long-text");
			}
		} catch (org.openqa.selenium.NoSuchElementException e) {
			description = "";
		}
		System.out.println("description: " + description);

		// social profiles
		String profiles = "";
		for (int s_count = 1; s_count <= 5; s_count++) {
			try {
				WebElement temp_obj = driver.findElement(By.cssSelector(
						"div[data-attrid='kc:/common/topic:social media presence'] div:nth-child(2) > div:nth-child("
								+ s_count + ") > div > g-link > a"));
				String profiles_str = temp_obj.getAttribute("href");
				if (profiles_str.length() > 0) {
					profiles += "<br/>" + profiles_str;
				}
			} catch (org.openqa.selenium.NoSuchElementException e) {
				break;
			}
		}
		System.out.println("profiles: " + profiles);

		String[] row = { data_cid, title.getText(), address, website, phone, rating, reviews, image, category, timing,
				description, profiles };

		return row;
	}

	public void redirectToBusinessList() {
		MoreButton.click();
	}

	public void ReadBusinessList() {
		List<WebElement> elements = driver
				.findElements(By.cssSelector("div#search a[class='vwVdIc wzN8Ac rllt__link a-no-hover-decoration']"));
		System.err.println(elements.size());
		System.err.println(elements);

		// System.err.println(businessListItems);
	}

	public void saveBusinessData() {
		int pages = 2;
		String[] header = { "data_cid", "title", "address", "website", "phone", "rating", "reviews", "image",
				"category", "timing", "description", "profiles" };
		List<String[]> data = new ArrayList<>();

		List<WebElement> pagesElements = driver.findElements(By.xpath("//a[contains(@aria-label, 'Page')]"));
		pages = pagesElements.size() + 1;
		int counter = 1;
		for (int page = 1; page <= pages; page++) {
			List<WebElement> elements = driver.findElements(
					By.cssSelector("div#search a[class='vwVdIc wzN8Ac rllt__link a-no-hover-decoration']"));

			for (WebElement element : elements) {
				System.err.println(
						"Records " + counter + "/" + elements.size() + "data-cid: " + element.getAttribute("data-cid"));
				// data.add( extractDataFromWebelements(element));
				String[] row = { element.getAttribute("data-cid"), "title.getText()", " address", " website", " phone",
						" rating", " reviews", " image", " category", " timing", " description", " profiles" };
				getGoogleId(element);

				data.add(row);
				counter++;
			}
			clickPageNumber(page, pages);
		}
		saveCSVFile(header, data);
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

	public void SearchQuary(String searchText) {

		searchBox.clear();
		searchBox.sendKeys(searchText + Keys.ENTER);

	}

	public void getGoogleId(WebElement element) {
		element.click();
		sleepandwait(10);
		WebElement Share_Button = driver.findElement(By.cssSelector("//span[text()='']"));
		Share_Button.click();
		WebElement urlTextBox = driver.findElement(By.cssSelector("//input[contains(@value, 'Search')]"));
		System.out.println(urlTextBox.getAttribute("value"));
		urlTextBox.sendKeys(Keys.ESCAPE);

	}

}
