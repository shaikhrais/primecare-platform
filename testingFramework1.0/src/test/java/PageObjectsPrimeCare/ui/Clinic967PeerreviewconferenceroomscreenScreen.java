package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic967PeerreviewconferenceroomscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 967;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'peer_review_conference_room-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'peer_review_conference_room-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'peer_review_conference_room-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'peer_review_conference_room_outlinedbutton_button_1')]")
	private WebElement peerReviewConferenceRoomOutlinedbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'peer_review_conference_room_iconbutton_button_1')]")
	private WebElement peerReviewConferenceRoomIconbuttonButton1;

    public Clinic967PeerreviewconferenceroomscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic967PeerreviewconferenceroomscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic967PeerreviewconferenceroomscreenScreen", "/generated/peer-review-conference-room");
    }
}
