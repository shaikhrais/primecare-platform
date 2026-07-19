package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic964JournalclubdiscussionboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 964;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'journal_club_discussion_board-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'journal_club_discussion_board-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'journal_club_discussion_board-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'journal_club_discussion_board_textbutton_button_1')]")
	private WebElement journalClubDiscussionBoardTextbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'journal_club_discussion_board_iconbutton_button_1')]")
	private WebElement journalClubDiscussionBoardIconbuttonButton1;

    public Clinic964JournalclubdiscussionboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic964JournalclubdiscussionboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic964JournalclubdiscussionboardscreenScreen", "/generated/journal-club-discussion-board");
    }
}
