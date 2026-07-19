package utilities;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateClass {

	public static int DateDifference(String date1String, String date2String) {
//        String date1String = "11/06/2022"; // MM/DD/YYYY format
//        String date2String = "10/31/2023"; // MM/DD/YYYY format

		SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
		Date date1, date2;
		long differenceInMillis;

		try {
			// Parse the input dates
			date1 = dateFormat.parse(date1String);
			date2 = dateFormat.parse(date2String);

			// Calculate the difference in milliseconds
			differenceInMillis = date2.getTime() - date1.getTime();

			// Calculate days difference
			long daysDifference = differenceInMillis / (1000 * 60 * 60 * 24);

			// Print the result
//			System.out.println("Date 1: " + date1String);
//			System.out.println("Date 2: " + date2String);
			System.out.println("Date Difference (in MM/DD/YYYY format): " + daysDifference + " days");
			return (int) daysDifference;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return 0;
	}

}
