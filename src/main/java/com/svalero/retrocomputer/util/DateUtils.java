package com.svalero.retrocomputer.util;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import static com.svalero.retrocomputer.util.Constants.DATE_PATTERN;
import static com.svalero.retrocomputer.util.Constants.USER_DATE_PATTERN;

public class DateUtils {
    public static String format(Date datetime) {
        SimpleDateFormat dateFormat= new SimpleDateFormat(DATE_PATTERN);
        return dateFormat.format(datetime);
    }
    public static String formatUser(Date datetime) {
        SimpleDateFormat dateFormat= new SimpleDateFormat(USER_DATE_PATTERN);
        return dateFormat.format(datetime);
    }

    //para convertir una cadena a fecha
    public static Date parse(String datetime) throws ParseException {
        SimpleDateFormat dateFormat= new SimpleDateFormat(DATE_PATTERN);
        return new Date(dateFormat.parse(datetime).getTime());
    }
}
