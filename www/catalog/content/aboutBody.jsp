<%--
 See the NOTICE file distributed with
 this work for additional information regarding copyright ownership.
 Esri Inc. licenses this file to You under the Apache License, Version 2.0
 (the "License"); you may not use this file except in compliance with
 the License.  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
--%>
<% // aboutBody.jsp - About page (JSF body) %>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<strong>The USGIN ESRI geoportal:</strong>

<div style='padding-right: 10px; padding-left: 10px;'>

   <h2>What's in this repository?</h2>
   <p>
      Most of the metadata currently held in the repository local to this server are for AZGS in house resources, developed under
      the auspices of the National Geological and Geophysical Preservation program. We are collecting  metadata for  other geoscience
      resources on the web and will be adding continuously to the metadata store. If you have resource metadata you would like
      to distribute to the community please contact the USGIN project at <a href="http://lab.usgin.org/contact">http://lab.usgin.org/contact</a> or visit the
      <a href="http://lab.usgin.org/">USGIN website.</a>
   </p>
</div>

<br/>

<div style='padding-right: 10px; padding-left: 10px;'>
   <h:outputFormat value="#{gptMsg['catalog.content.about.version']}">
     <f:param value="#{PageContext.version}"/>
   </h:outputFormat>
</div>

<div style='padding-right: 10px; padding-left: 10px;'>
  <br/>
   Last updated: 01/20/2011
</div>