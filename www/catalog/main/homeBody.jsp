<% // homeBody.jsp - Home page (JSF body) %>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<f:verbatim>
   <script type="text/javascript">
   /**
   Submits from when on enter.
   @param event The event variable
   @param form The form to be submitted.
   **/
   function hpSubmitForm(event, form) {

     var e = event;
     if (!e) e = window.event;
     var tgt = (e.srcElement) ? e.srcElement : e.target;
     if ((tgt != null) && tgt.id) {
       if (tgt.id == "frmSearchCriteria:mapInput-locate") return;
     }

     if(!GptUtils.exists(event)) {
       GptUtils.logl(GptUtils.log.Level.WARNING,
            "fn submitform: could not get event so as to determine if to submit form ");
       return;
     }
     var code;

     if(GptUtils.exists(event.which)) {
       code = event.which;
     } else if (GptUtils.exists(event.keyCode)) {
       code = event.keyCode;
     } else {
       GptUtils.logl(GptUtils.log.Level.WARNING, "fn submitForm: Could not determine key pressed");
       return;
     }

     if(code == 13) {

       // Getting main search button
       var searchButtonId = "hpFrmSearch:btnDoSearch";
       var searchButton = document.getElementById(searchButtonId);
       if(!GptUtils.exists(searchButton)){
         GptUtils.logl(GptUtils.log.Level.WARNING,
            "Could not find button id = " + searchButtonId);
       } else if (!GptUtils.exists(searchButton.click)) {
         GptUtils.logl(GptUtils.log.Level.WARNING,
            "Could not find click action on id = " + searchButtonId);
       } else {
         searchButton.click();
       }
     } else {
       return true;
     }
   }
   </script>

</f:verbatim>

<h:panelGrid columns="4" summary="#{gptMsg['catalog.general.designOnly']}" width="100%" columnClasses="homeTableColLeft,homeTableColRight">
   <h:panelGrid columns="1" summary="#{gptMsg['catalog.general.designOnly']}" width="100%" columnClasses="homeTableLeft" footerClass="homeTableLeftFooter" headerClass="homeTableLeftHeader" cellpadding="0" cellspacing="0">
      <f:facet name="header">
         <h:column>
            <h:graphicImage id="homeTableLeftHeaderImageL" alt="" styleClass="homeTableLeftHeaderImageL" url="/catalog/images/blank.gif" width="15" height="24"></h:graphicImage>
            <h:graphicImage id="homeTableLeftHeaderImageR" alt="" styleClass="homeTableLeftHeaderImageR" url="/catalog/images/blank.gif" width="48" height="24"></h:graphicImage>
            <h:outputText value="#{gptMsg['catalog.main.home.youCanSimply']}"/>
         </h:column>
      </f:facet>
      <h:column>
         <!--<h:outputText value="#{gptMsg['catalog.main.home.topic.findData']}"/>-->
         <div style='padding-bottom: 10px;'>
           <strong>Starting point to locate resources in the US Geoscience Information Network:</strong>
         </div>
         <f:verbatim><p>&nbsp;</p></f:verbatim>
         <h:panelGrid columns="1" summary="#{gptMsg['catalog.general.designOnly']}" width="90%" styleClass="homeTableCol">
            <h:panelGrid columns="2" id="_pnlKeyword" cellpadding="0" cellspacing="0">

               <h:form id="hpFrmSearch" onkeypress="javascript: hpSubmitForm(event, this);">
               <h:inputText id="itxFilterKeywordText"
                 onkeypress="if (event.keyCode == 13) return false;"
                 value="#{SearchFilterKeyword.searchText}" maxlength="400" style="width: 240px" />

               <h:commandButton id="btnDoSearch"
                 value="#{gptMsg['catalog.search.search.btnSearch']}"
                 action="#{SearchController.getNavigationOutcome}"
                 actionListener="#{SearchController.processAction}"
                 onkeypress="if (event.keyCode == 13) return false;">
                 <f:attribute name="#{SearchController.searchEvent.event}"
                   value="#{SearchController.searchEvent.eventExecuteSearch}" />
               </h:commandButton>
               </h:form>
            </h:panelGrid>
         </h:panelGrid>
         <f:verbatim><p>&nbsp;</p></f:verbatim>
      </h:column>
      <f:facet name="footer">
         <h:column>
            <h:graphicImage id="homeTableLeftFooterImageL" alt="" styleClass="homeTableLeftFooterImageL" url="/catalog/images/blank.gif" width="23" height="16"></h:graphicImage>
            <h:graphicImage id="homeTableLeftFooterImageR" alt="" styleClass="homeTableLeftFooterImageR" url="/catalog/images/blank.gif" width="21" height="16"></h:graphicImage>
         </h:column>
      </f:facet>
   </h:panelGrid>

   <h:panelGrid columns="1"
                summary="#{gptMsg['catalog.general.designOnly']}" columnClasses="homeTableRight"
                width="100%" footerClass="homeTableRightFooter"
                headerClass="homeTableRightHeader" cellpadding="0" cellspacing="0">

      <f:facet name="header">
         <h:column>
            <h:graphicImage id="homeTableRightHeaderImageL" alt="" styleClass="homeTableRightHeaderImageL" url="/catalog/images/blank.gif" width="15" height="24"></h:graphicImage>
            <h:graphicImage id="homeTableRightHeaderImageR" alt="" styleClass="homeTableRightHeaderImageR" url="/catalog/images/blank.gif" width="48" height="24"></h:graphicImage>
            <h:outputText value="What is this site?..."/>
         </h:column>
      </f:facet>

      <h:panelGrid columns='1' style='font-size: .90em; text-align: left; height: 127px;'>
         <h:outputLink value="/geoportal/catalog/identity/login.page#"><h:outputText value="Login - registered user login"/></h:outputLink>
         <h:outputLink value="/geoportal/catalog/identity/userRegistration.page"><h:outputText value="Register - register as a new user"/></h:outputLink>
         <h:outputLink value="/geoportal/catalog/content/about.page"><h:outputText value="About - more information about USGIN"/></h:outputLink>
         <h:outputLink value="/geoportal/catalog/identity/feedback.page"><h:outputText value="Feedback - send us some feedback."/></h:outputLink>
      </h:panelGrid>

      <f:facet name="footer">
         <h:column>
            <h:graphicImage id="homeTableRightFooterImageL" alt="" styleClass="homeTableRightFooterImageL" url="/catalog/images/blank.gif" width="17" height="20"></h:graphicImage>
            <h:graphicImage id="homeTableRightFooterImageR" alt="" styleClass="homeTableRightFooterImageR" url="/catalog/images/blank.gif" width="23" height="20"></h:graphicImage>
         </h:column>
      </f:facet>
   </h:panelGrid>
</h:panelGrid>

<f:verbatim>
   <div style='padding-right: 10px; padding-left: 10px;'>
         <h1>The AASG Geothermal Data Catalog</h1>
         <div style='padding-right: 10px; padding-left: 10px;'>
	         <ul>
	           <li>
	             <strong>Why are you here?</strong> You want to locate some  geoscience resources for a project you are working on or learn more about some topic of interest. Your web search using a commercial search engine yielded 210,026 hits, 90 percent of which are nonsense.
	           </li>
	           <br/>
	           <li>If you are looking for geothermal-related geologic information this is the website for you. <strong>Welcome!!!</strong></li>
	           <br/>
	           <li><strong>How do you use this site?</strong>  The easiest way to get started using this site is to type in a search phrase in the "Find Data" input box above. Titles and brief descriptions of located resources for search results will appear on the right side of your window, along with links to view metadata details, connect directly to the resource or preview it (if applicable), or view the complete xml metadata record.</li>
	           <br/>
	           <li><strong>This site</strong> uses the <a href="http://geoportal.sourceforge.net/">ESRI Geoportal Server open source project (v. 10)</a>
	         </ul>
         </div>
   </div>
</f:verbatim>

<f:verbatim><br/></f:verbatim>

<f:verbatim>
  <div style='padding-right: 10px; padding-left: 10px;'>
    <h1>What is this repository?</h1>
    <div style='padding-left: 10px; padding-right: 10px;'>
      <p>At the heart of the Geoscience Information network is a catalog system that enables data providers to publish metadata for data and services, and for data consumers to discover
      those resources.  The catalog system is based on a federated system of metadata registries (databases that host and manage the metadata) that are accessible for search and
      harvest via public web services. Metadata records in this system are viewed as a public resource. For more information see <a href='http://usgin.org/index.php?option=com_content&view=article&id=50&Itemid=28'>USGIN Catalog Service</a>.</p>
	  <br />
      <p>This site is an access point to search the catalog. We are collecting metadata for geoscience resources, especially those geographically associated with the United States,
      and will be adding continuously to the metadata store. If you have resource metadata you would like to distribute to the community please <a href='http://lab.usgin.org/contact'>contact the USGIN project</a>
      or visit <a href="http://lab.usgin.org/">the USGIN website.</a></p>
    </div>
  </div>
</f:verbatim>e USGIN website.
    </div>
  </div>
</f:verbatim>