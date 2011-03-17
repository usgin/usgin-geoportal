package gov.az.azgs.gpt.framework.util;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;

/**
 * An extension of the com.esri.gpt.framework.util.DateProxy class to provide a ISO compliant timestamp.
 * @author <a href='mailto:acatejr@gmail.com'>Averill Cate, Jr.</a>
 * @see com.esri.gpt.framework.util.DateProxy
 */
public class DateProxy extends com.esri.gpt.framework.util.DateProxy
{
   
   /**
    * Default construct uses super classes constructor
    */
   public DateProxy()
   {
      super();
   }
   
      
   /**
   * Formats a timestamp as "yyyy-MM-dd'T'HH:mm:ss".
   * @param timestamp the timestamp to format ISO8601
   * @return the formatted result
   */
   public static String formatISO8601DateTime(Timestamp timestamp) 
   {
      String sTimestamp = "";
      if (timestamp != null) 
      {
         SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
         sTimestamp = fmt.format(timestamp);
         sTimestamp = sTimestamp.substring(0,sTimestamp.length()-2) + ":" + sTimestamp.substring(sTimestamp.length()-2);
      }
      return sTimestamp;
   }

}
