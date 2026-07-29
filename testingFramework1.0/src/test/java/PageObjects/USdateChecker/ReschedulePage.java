package pageobjects.USdateChecker;

import java.time.Duration;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;

import base.Action;
import base.baseTest;
import testNG.USdateChecker.AppointmentLogger;

public class ReschedulePage extends baseTest {

    private Action action = new Action();
    private AppointmentLogger logger;
    private int targetDaysFromNow;

    // Locators
    @FindBy(id = "policy_confirmed")
    private WebElement cbAgree;

    @FindBy(id = "appointments_consulate_appointment_date")
    private WebElement dateField;

    
    @FindBy(id = "appointments_consulate_appointment_time")
    private WebElement timeDropdown;

    @FindBy(xpath = "//a[contains(@class, 'ui-datepicker-next')]")
    private WebElement nextMonthButton;

    @FindBy(id = "appointments_consulate_appointment_facility_id")
    private WebElement locationDropdown;

    @FindBy(className = "ui-datepicker-month")
    private WebElement monthElement;

    @FindBy(className = "ui-datepicker-year")
    private WebElement yearElement;

    @FindBy(xpath = "//button[contains(text(), 'Reschedule')]")
    private WebElement rescheduleButton;

    // System busy error message locator
    @FindBy(xpath = "//*[text()='System is busy. Please try again later.']")
    private WebElement systemBusyMessage;

    // Constructor
    public ReschedulePage(int targetDaysFromNow) {
        PageFactory.initElements(driver, this);
        this.targetDaysFromNow = targetDaysFromNow;
        this.logger = new AppointmentLogger(targetDaysFromNow);
    }

    /**
     * Main function to handle the complete appointment booking flow
     * @param location Consular location to select
     * @param maxMonths Maximum months to search for available dates
     * @return Appointment details if successful, null if failed
     */
    public String bookAvailableAppointment(String location, int maxMonths) {
        String result = null;
        String appointmentDate = null;
        String appointmentTime = null;
        boolean rescheduled = false;
        String status = "NOT_FOUND";

        try {
            System.out.println("Starting appointment booking process for location: " + location);

            // Step 1: Select location
            selectLocation(location);

            // Step 2: Check if system is busy - if busy, just return null
            if (isSystemBusy()) {
                System.out.println("System is busy. Please try again later. Aborting booking process.");
                action.screenShot(driver, "system_busy");
                status = "SYSTEM_BUSY";
                return null;
            }

            // Step 3: Find a date with available time slots
            AppointmentInfo appointmentInfo = findDateWithAvailableTimeSlot(location, maxMonths);

            if (appointmentInfo != null) {
                appointmentDate = appointmentInfo.getDate();
                appointmentTime = appointmentInfo.getTime();
                status = "FOUND";

                // Step 4: Decide whether to click reschedule based on date
                boolean shouldReschedule = isWithinTargetRange(appointmentInfo.getDate());

                // Step 5: Click reschedule if the date is within our target range
                if (shouldReschedule && action.isDisplayed(driver, rescheduleButton)) {
                    action.click(driver, rescheduleButton);
                    System.out.println("Clicked reschedule button to confirm appointment");
                    result = "RESCHEDULED: " + appointmentInfo.toString();
                    rescheduled = true;
                } else {
                    System.out.println("Found appointment but NOT rescheduling (outside target range or by user choice)");
                    result = "FOUND BUT NOT RESCHEDULED: " + appointmentInfo.toString();
                }
            }

            return result;

        } catch (Exception e) {
            System.err.println("Error in bookAvailableAppointment: " + e.getMessage());
            e.printStackTrace();
            action.screenShot(driver, "booking_error");
            status = "ERROR";
            return null;
        } finally {
            // Log the result in CSV format
        	System.out.println(location+";" +status+";" + appointmentDate+";" + appointmentTime+";" + rescheduled);
            logger.logResult(location, status, appointmentDate, appointmentTime, rescheduled);
            logger.close();
        }
    }

    /**
     * Check if the system is displaying the "System is busy" message
     * @return true if system is busy, false otherwise
     */
    public boolean isSystemBusy() {
        try {
            // Check for the exact error message text
            List<WebElement> busyMessages = driver.findElements(
                By.xpath("//*[contains(text(), 'System is busy')]"));

            boolean isBusy = !busyMessages.isEmpty();

            if (isBusy) {
                System.out.println("System busy message detected.");
                action.screenShot(driver, "system_busy_detected");
            }

            return isBusy;
        } catch (Exception e) {
            System.err.println("Error checking system busy status: " + e.getMessage());
            return false;
        }
    }

    /**
     * Select a consular location
     * @param location The location to select (e.g., "Toronto")
     * @return true if successful, false otherwise
     */
    public boolean selectLocation(String location) {
        try {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
            wait.until(ExpectedConditions.elementToBeClickable(locationDropdown));

            action.selectByVisibleText(location, locationDropdown);
            System.out.println("Selected location: " + location);

            // Wait for location selection to process
            Thread.sleep(2000);
            return true;
        } catch (Exception e) {
            System.err.println("Error selecting location: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Opens the date picker by clicking on the date field
     * @return true if successful, false if system busy or other error
     */
    public boolean openDatePicker() {
        try {
            
        	// First try with the Action class JSClick
            action.JSClick(driver, dateField);

            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
            wait.until(ExpectedConditions.elementToBeClickable(dateField));

            

            // Wait for the date picker to be visible
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.className("ui-datepicker-calendar")));
            System.out.println("Date picker opened successfully");
            return true;
        } catch (Exception e) {
            System.err.println("Error opening date picker: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Find a date with available time slots
     * @param location Consular location
     * @param maxMonths Maximum number of months to search
     * @return AppointmentInfo object if found, null if not found or system busy
     */
    public AppointmentInfo findDateWithAvailableTimeSlot(String location, int maxMonths) {
        try {
            
        	
            // Open date picker
            if (!openDatePicker()) {
                return null; // Can't open date picker
            }

            int datesChecked = 0;
            int maxDatesToTry = 100;
            int months = 0;

            // Loop through months
            while (months < maxMonths) {
                // Check for system busy message before each month check
                if (isSystemBusy()) {
                    return null;
                }

                String currentMonthYear = getCurrentMonthYear();
                System.out.println("Checking month: " + currentMonthYear);

                // Get all available dates in the current month
                List<WebElement> availableDays = getAvailableDatesInCurrentMonth();
                if (availableDays == null || availableDays.isEmpty()) {
                    System.out.println("No available dates in " + currentMonthYear);

                    // Go to next month
                    if (!goToNextMonth()) {
                        break; // Can't go to next month
                    }
                    months++;
                    continue;
                }

                // Loop through each available date in the current month
                for (WebElement day : availableDays) {
                    // Check for system busy message before each date check
                    if (isSystemBusy()) {
                        return null;
                    }

                    if (datesChecked >= maxDatesToTry) {
                        System.out.println("Reached maximum number of dates to check: " + maxDatesToTry);
                        return null;
                    }

                    String dayText = day.getText();

                    // Select the date
                    selectDate(day);

                    // Check if time slots are available for this date
                    if (hasAvailableTimeSlots()) {
                        // Found a date with available time slots
                        String selectedDate = currentMonthYear + " " + dayText;
                        System.out.println("Found date with available time slots: " + selectedDate);

                        // Select the first available time
                        String selectedTime = selectFirstAvailableTime();

                        if (selectedTime != null) {
                            // Successfully found date and time
                            return new AppointmentInfo(location, selectedDate, selectedTime);
                        }
                    }

                    // If we reach here, no time slots were available for this date
                    System.out.println("No time slots available for " + currentMonthYear + " " + dayText);

                    // Open date picker again to continue checking other dates
                    if (!openDatePicker()) {
                        // If can't open date picker, check for system busy
                        if (isSystemBusy()) {
                            return null;
                        }
                    }

                    datesChecked++;
                }

                // If we've checked all dates in this month and none had available times,
                // go to the next month
                if (!goToNextMonth()) {
                    break; // Can't go to next month
                }
                months++;
            }

            System.out.println("No dates with available time slots found after checking " + months +
                               " months and " + datesChecked + " individual dates");
            return null;

        } catch (Exception e) {
            System.err.println("Error in findDateWithAvailableTimeSlot: " + e.getMessage());
            e.printStackTrace();
            action.screenShot(driver, "booking_error");
            return null;
        }
    }

    /**
     * Check if an appointment date is within the target range
     * @param appointmentDateStr The appointment date string (e.g., "January 2026 15")
     * @return true if the date is within target range, false otherwise
     */
    private boolean isWithinTargetRange(String appointmentDateStr) {
        try {
            // Extract month, year and day from the date string
            String[] parts = appointmentDateStr.split(" ");
            if (parts.length < 3) {
				return false;
			}

            String month = parts[0];
            String year = parts[1];
            String day = parts[2];

            // Parse the date
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM yyyy d");
            LocalDate appointmentDate = LocalDate.parse(month + " " + year + " " + day, formatter);

            // Calculate target date
            LocalDate targetDate = LocalDate.now().plusDays(targetDaysFromNow);

            // Check if appointment date is before or equal to target date
            return !appointmentDate.isAfter(targetDate);

        } catch (Exception e) {
            System.err.println("Error parsing date: " + e.getMessage());
            return false;
        }
    }

    /**
     * Get the current month and year displayed in the date picker
     * @return String representation of month and year (e.g., "January 2026")
     */
    public String getCurrentMonthYear() {
        try {
            return monthElement.getText() + " " + yearElement.getText();
        } catch (Exception e) {
            return "Unknown";
        }
    }

    /**
     * Get all available dates in the current month view
     * @return List of WebElements representing available dates
     */
    public List<WebElement> getAvailableDatesInCurrentMonth() {
        try {
            List<WebElement> availableDays = driver.findElements(
                By.xpath("//table[contains(@class, 'ui-datepicker-calendar')]//td[not(contains(@class, 'ui-datepicker-unselectable'))]//a"));

            System.out.println("Found " + availableDays.size() + " potentially available days in current month");
            return availableDays;
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * Navigate to the next month in the date picker
     * @return true if successful, false if there's no next month or error
     */
    public boolean goToNextMonth() {
        try {
            if (action.isDisplayed(driver, nextMonthButton) &&
                !nextMonthButton.getAttribute("class").contains("ui-state-disabled")) {

                action.click(driver, nextMonthButton);

                // Wait for the calendar to update
                Thread.sleep(1000);
                System.out.println("Navigated to next month");
                return true;
            } else {
                System.out.println("Cannot navigate to next month - button disabled or not found");
                return false;
            }
        } catch (Exception e) {
            System.err.println("Error navigating to next month: " + e.getMessage());
            return false;
        }
    }

    /**
     * Select a specific date in the date picker
     * @param dateElement WebElement representing the date to select
     * @return true if successful, false otherwise
     */
    public boolean selectDate(WebElement dateElement) {
        try {
            String dateText = dateElement.getText();
            System.out.println("Selecting date: " + dateText);

            action.click(driver, dateElement);

            // Wait for any AJAX calls to complete
            Thread.sleep(2000);
            return true;
        } catch (Exception e) {
            System.err.println("Error selecting date: " + e.getMessage());
            return false;
        }
    }

    /**
     * Check if time slots are available for the currently selected date
     * @return true if at least one time slot is available, false otherwise
     */
    public boolean hasAvailableTimeSlots() {
        try {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(5));
            wait.until(ExpectedConditions.visibilityOf(timeDropdown));

            if (!action.isDisplayed(driver, timeDropdown)) {
                return false;
            }

            Select timeSelect = new Select(timeDropdown);
            List<WebElement> options = timeSelect.getOptions();

            // Check if there are any valid time options (more than just the empty default option)
            boolean hasSlots = options.size() > 1 && !options.get(1).getText().trim().isEmpty();

            if (hasSlots) {
                System.out.println("Time slots available: " + (options.size() - 1) + " options");
            } else {
                System.out.println("No time slots available for selected date");
            }

            return hasSlots;
        } catch (Exception e) {
            System.out.println("No time slots available or time dropdown not loaded: " + e.getMessage());
            return false;
        }
    }

    /**
     * Select the first available time slot for the currently selected date
     * @return Selected time as String, or null if no times available
     */
    public String selectFirstAvailableTime() {
        try {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
            wait.until(ExpectedConditions.elementToBeClickable(timeDropdown));

            // Get the time dropdown as a Select element
            Select timeSelect = new Select(timeDropdown);

            // Get all options from the dropdown
            List<WebElement> options = timeSelect.getOptions();

            // Print available times for debugging
            System.out.println("Available times: " + options.size() + " options found");
            for (WebElement option : options) {
                System.out.println(" - " + option.getText());
            }

            // Check if there are any time options (skip the empty/default option)
            if (options.size() > 1 && !options.get(1).getText().trim().isEmpty()) {
                // Select the first non-empty option (index 1 since index 0 is usually blank/default)
                action.selectByIndex(timeDropdown, 1);
                String selectedTime = options.get(1).getText();
                System.out.println("Selected time: " + selectedTime);
                return selectedTime;
            } else {
                System.out.println("No valid time slots available");
                return null;
            }
        } catch (Exception e) {
            System.err.println("Error selecting time slot: " + e.getMessage());
            return null;
        }
    }

    /**
     * Login method (implement as needed)
     */
    public void Login() throws InterruptedException {
        System.out.println("In the login");
        Thread.sleep(20000);
    }

    /**
     * Inner class to store appointment information
     */
    public class AppointmentInfo {
        private String location;
        private String date;
        private String time;

        public AppointmentInfo(String location, String date, String time) {
            this.location = location;
            this.date = date;
            this.time = time;
        }

        public String getLocation() {
            return location;
        }

        public String getDate() {
            return date;
        }

        public String getTime() {
            return time;
        }

        @Override
        public String toString() {
            return "Appointment at " + location + " on " + date + " at " + time;
        }
    }
}