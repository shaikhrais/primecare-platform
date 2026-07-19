package PageObjects.Instagram.UserData;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.time.Duration;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import base.baseTest;
import utilities.ImageDownloader;

public class InstagramUserPage extends baseTest {

	@FindBy(xpath = "//svg[@aria-label='Close' and contains(@class, 'x1lliihq x1n2onr6 x9bdzbf')]")
	private WebElement closeButton;

	@FindBy(xpath = "//button[div/span/*[@aria-label='Next']]")
	private WebElement nextButton;

	@FindBy(xpath = "//a[contains(@class, 'x1i10hfl') and contains(@href, '/p/')]")
	private List<WebElement> listOfPost;

	@FindBy(xpath = "//title")
	private WebElement usernameElement;

	@FindBy(xpath = "//h1")
	private WebElement bioElement;

	@FindBy(xpath = "//li[contains(text(), 'posts')]/span/span")
	private WebElement postsCountElement;

	@FindBy(xpath = "//a[contains(text(), 'followers')]/span/span")
	private WebElement followersCountElement;

	@FindBy(xpath = "//a[contains(text(), 'following')]/span/span")
	private WebElement followingCountElement;

	// @FindBy(css = "//img[@alt='Change profile photo']")
	@FindBy(xpath = "//span[contains(@style, 'height: 150px;') and contains(@style, 'width: 150px;')]/img")
	private WebElement profilePicElement;

	 // Page Locators
    @FindBy(css = ".item-class")
	private List<WebElement> itemLocator;


  //h1[contains(@class, '_ap3a')]
    @FindBy(css = "h1._ap3a._aaco._aacu._aacx._aad7._aade")
   private WebElement postTextElement ;

  //time[contains(@class, 'x1p4m5qa')]

    @FindBy(className  = "x1p4m5qa")
   	private WebElement postDatetimeElement ;


    @FindBy(css = "img.x5yr21d.xu96u03.x10l6tqk.x13vifvy.x87ps6o.xh8yej3")
    private WebElement postImageElement;

    @FindBy(xpath = "//button[@aria-label='Toggle audio' and @type='button']")
    private WebElement toggleAudioButton;


    @FindBy(tagName = "article img")
    private List<WebElement> imageElements;

    @FindBy(tagName = "article video")
    private List<WebElement> videoElements;

    @FindBy(css = "article ul[role='presentation'] li")
    private List<WebElement> carouselDots;

	private String profileUrl= "https://www.instagram.com/kubeirkamal/";

	public InstagramUserPage() {
		PageFactory.initElements(driver, this);

		driver.get(profileUrl);
		driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(20));
	}

	public PostInfo getPostInfo() throws InterruptedException {
        // Wait for post to load
//        new WebDriverWait(driver, 10).until(
//            ExpectedConditions.or(
//                ExpectedConditions.presenceOfElementLocated(By.tagName("img")),
//                ExpectedConditions.presenceOfElementLocated(By.tagName("video"))
//            )
//        );
//Thread.sleep(Duration.ofSeconds(5));
        int imageCount = imageElements.size();
        int videoCount = videoElements.size();
        boolean isCarousel = carouselDots.size() > 1;

        String postType;
        if (isCarousel) {
            postType = "Carousel";
        } else if (videoCount > 0) {
            postType = "Video";
        } else if (imageCount > 0) {
            postType = "Image";
        } else {
            postType = "Unknown";
        }

        return new PostInfo(postType, imageCount, videoCount);
    }

	public String getUsername() {
		return usernameElement.getText();
	}

	public String getBio() {
		return bioElement.getAttribute("innerHTML");
	}

	public String getPostsCount() {
		return postsCountElement.getText();
	}

	public String getFollowersCount() {
		return followersCountElement.getText();
	}

	public String getFollowingCount() {
		return followingCountElement.getText();
	}

	public String getProfilePicUrl() {
		return profilePicElement.getAttribute("src");
	}

	public String getUserName() {
		return usernameElement.getText();
	}

	public void printInfo() throws InterruptedException {
		System.out.println("Username: " + driver.getTitle());
		System.out.println("Bio: " + getBio());
		System.out.println("Posts: " + getPostsCount());
		System.out.println("Followers: " + getFollowersCount());
		System.out.println("Following: " + getFollowingCount());
		System.out.println("Profile Picture URL: " + getProfilePicUrl());

		ImageDownloader.downloadImage(getProfilePicUrl(), "c:\\output\\as.jpg");

	}

	String postUrl;
	public void clickOnPosts() throws InterruptedException {
//		printInfo();
		listOfPost.get(0).click();
		System.out.println("Number of post in the list " + listOfPost.size());
		for (int i = 0; i < listOfPost.size(); i++) {
			//listOfPost.get(i).click();
			try{
				nextButton.click();

				postUrl=driver.getCurrentUrl();
				System.out.println("Post URL: " + postUrl);
				System.out.println("Post URL: " + (postUrl.substring(postUrl.lastIndexOf("p/") + 2, postUrl.lastIndexOf("/"))) );

				System.out.println("Post Datetime: " + postDatetimeElement.getAttribute("Datetime"));
				System.out.println("Post Text: " + postTextElement.getAttribute("innerHTML"));

				//System.out.println("Post Type: " + getPostInfo());

				//downloadImage("C:\\Users\\User\\Desktop\\1.jpg");
			}
			catch(Exception e) {
			}
			Thread.sleep(2000);
		}
	}

	String imageUrl;
	public void downloadImage(String destinationPath) {
        try {
            // Step 1: Locate the image element
            //WebElement image = driver.findElement(By.cssSelector(cssSelector));

            // Step 2: Extract the image URL from the 'src' attribute
            imageUrl = postImageElement.getAttribute("src");

            // Step 3: Download and save the image
            URL url = new URL(imageUrl);
            URLConnection conn = url.openConnection();
            conn.setRequestProperty("User-Agent", "Mozilla/5.0");

            try (
                InputStream in = conn.getInputStream();
                OutputStream out = new FileOutputStream(destinationPath)
            ) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            }

            System.out.println("✅ Image saved to: " + destinationPath);

        } catch (Exception e) {
            System.err.println("❌ Failed to download image: " + e.getMessage());
        }
    }
	// 🔁 Page Function: Infinite Scroll
    public void scrollToBottomUntilAllItemsLoad() {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        long lastHeight = (long) js.executeScript("return document.body.scrollHeight");

        while (true) {
        	System.out.println("Number of post in the list " + listOfPost.size());

            js.executeScript("window.scrollTo(0, document.body.scrollHeight);");
            try {
                Thread.sleep(1500); // wait for page to load content
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            long newHeight = (long) js.executeScript("return document.body.scrollHeight");

            if (newHeight == lastHeight) {
                break;
            }
            lastHeight = newHeight;
        }
    }

    // ✅ Optional Page Function: Get All Items After Scroll
    public List<WebElement> getAllLoadedItems() {
        return  (List<WebElement>) driver.findElement(By.cssSelector(".item-class"));
    }

	public void extractFollowersList() {

	}

	public void extractFollowingList() {

	}



	public void extractPostData() {

	}

}
