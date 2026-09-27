package testNG.USdateChecker;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * CSV Logger for appointment search activities
 */
public class AppointmentLogger {

    private static final String LOG_FILE = "C:\\Users\\User\\Desktop\\Test\\" +System.getProperty("username")+ ".csv";
    private static final DateTimeFormatter DATE_FORMAT = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    private static final DateTimeFormatter TIME_FORMAT = DateTimeFormatter.ofPattern("HH:mm:ss");

    private LocalDateTime startTime;
    private int targetDaysFromNow;
    private PrintWriter logWriter;
    private String separator;

    /**
     * Initialize a new logger with target days from now
     * @param targetDaysFromNow The target number of days from today for the appointment
     */
    public AppointmentLogger(int targetDaysFromNow) {
        this.targetDaysFromNow = targetDaysFromNow;
        this.startTime = LocalDateTime.now();
        initializeLogger();
    }

    /**
     * Initialize the log file
     */
    private void initializeLogger() {
        try {
            // Check if file exists to determine if we need to write headers
            boolean fileExists = new File(LOG_FILE).exists();

            // Open file in append mode
            logWriter = new PrintWriter(new FileWriter(LOG_FILE, true));

            // Write header row if file is new
            if (!fileExists) {
                logWriter.println("ExecutionDate,ExecutionTime,TargetDaysFromNow,Location,Status,AppointmentDate,AppointmentTime,DaysFromNow,ExecutionDuration,Rescheduled");
                logWriter.flush();
            }

        } catch (IOException e) {
            System.err.println("Failed to initialize logger: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Log the result of an appointment search
     * @param location Consular location
     * @param status Status (FOUND, NOT_FOUND, SYSTEM_BUSY)
     * @param appointmentDate Date found (or null)
     * @param appointmentTime Time found (or null)
     * @param rescheduled Whether appointment was rescheduled
     */
    public void logResult(String location, String status, String appointmentDate, String appointmentTime, boolean rescheduled) {
        if (logWriter == null) {
			return;
		}

        try {
            LocalDateTime endTime = LocalDateTime.now();
            Duration duration = Duration.between(startTime, endTime);

            // Calculate days from now if appointment date is available
            String daysFromNow = "";
            if (appointmentDate != null && !appointmentDate.isEmpty()) {
                try {
                    // Extract month, year and day from the date string
                    String[] parts = appointmentDate.split(" ");
                    if (parts.length >= 3) {
                        String month = parts[0];
                        String year = parts[1];
                        String day = parts[2];

                        // Parse the date
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM yyyy d");
                        LocalDate apptDate = LocalDate.parse(month + " " + year + " " + day, formatter);

                        // Calculate days from now
                        long days = apptDate.toEpochDay() - LocalDate.now().toEpochDay();
                        daysFromNow = String.valueOf(days);
                    }
                } catch (Exception e) {
                    daysFromNow = "ERROR";
                }
            }

            // Format the CSV line
            separator=",";
            StringBuilder sb = new StringBuilder();
            sb.append(startTime.format(DATE_FORMAT)).append(separator);  // Execution date
            sb.append(startTime.format(TIME_FORMAT)).append(separator);  // Execution time
            sb.append(targetDaysFromNow).append(separator);             // Target days from now
            sb.append(location).append(separator);                      // Location
            sb.append(status).append(separator);                        // Status
            sb.append(appointmentDate == null ? "" : appointmentDate).append(separator); // Appointment date
            sb.append(appointmentTime == null ? "" : appointmentTime).append(separator); // Appointment time
            sb.append(daysFromNow).append(separator);                   // Days from now
            sb.append(formatDuration(duration)).append(separator);      // Execution duration
            sb.append(rescheduled ? "YES" : "NO");                // Whether rescheduled

            // Write the line to the CSV file
            logWriter.println(sb.toString());
            logWriter.flush();

        } catch (Exception e) {
            System.err.println("Error logging result: " + e.getMessage());
        }
    }

    /**
     * Format duration in HH:MM:SS format
     * @param duration The duration to format
     * @return Formatted duration string
     */
    private String formatDuration(Duration duration) {
        long hours = duration.toHours();
        long minutes = duration.toMinutesPart();
        long seconds = duration.toSecondsPart();

        return String.format("%02d:%02d:%02d", hours, minutes, seconds);
    }

    /**
     * Close the logger
     */
    public void close() {
        if (logWriter != null) {
            logWriter.close();
        }
    }
}
