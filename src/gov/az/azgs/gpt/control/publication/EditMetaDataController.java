package gov.az.azgs.gpt.control.publication;

import gov.az.azgs.gpt.framework.util.DateProxy;
import com.esri.gpt.framework.util.UuidUtil;
import java.sql.Timestamp;

/**
 * Customized implementation/extension of the com.esri.gpt.control.publication.EditMetadataController
 * @author <a href='mailto:acatejr@gmail.com'>Averill Cate, Jr</a>
 */
public class EditMetaDataController extends com.esri.gpt.control.publication.EditMetadataController
{
   /**
    * The default constructor.  Runs superclass constructor
    */
   public EditMetaDataController()
   {
      super();
   }

   /**
    *
    * Returns the current data in yyyy-MM-ddT00:00:00 format.
    * <br/>
    * Modification made by <a href='mailto:acatejr@gmail.com'>Averill Cate, Jr.</a> - AZGS, 12/2/2010 3:08:19 PM
    * <br/>
    * This method is typically used when binding a default parameter value from
    * the schema definition XML. <br/>
    *  Example: &lt;input type="text" defaultValue="#{EditMetadataController.ISO8601DateTime}"/&gt;
    * <br/>
    * @return current time stamp
    */
   public String getDateTime()
   {
      String isoDate = DateProxy.formatISO8601DateTime(new Timestamp(System.currentTimeMillis()));
      return isoDate;
   }

   /**
    * Creates a UUID with no brackets
    */
   public String getUuid()
   {
      String uuid = UuidUtil.makeUuid(false);
      return uuid;
   }

}
