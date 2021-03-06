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
<% // serviceMonitorBody.jsp - sdi.suite service monitor page (JSF body) %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>
<h:form id="frmSdisuiteServiceMonitor">

<f:verbatim>
<script type="text/javascript" >
function launchSdiSuiteComponent() {
	var sdisuiteUrl = sdisuite.servMon;
  if ((sdisuiteUrl != null) && (sdisuiteUrl.length > 0)) {
	sdisuiteUrl += "?embedded=true";
    var elForm = document.getElementById("frm-sdisuite-launch");
    var elIFrame = document.getElementById("ifrm-sdisuite-launch");
    if ((elForm != null) && (elIFrame != null)) {
      if ((sdisuite.tkn != null) && (sdisuite.tkn.length > 0)) { 
		elForm.ticket.value = sdisuite.tkn;
      }
      elForm.action = sdisuiteUrl;
      elForm.submit();
    }
  }
}
dojo.addOnLoad(launchSdiSuiteComponent);
</script>
<iframe id="ifrm-sdisuite-launch" name="ifrm-sdisuite-launch" 
  width="100%" height="600px" src="" style="border:0px"></iframe>
<form id="frm-sdisuite-launch-tmp"></form>
<form id="frm-sdisuite-launch" name="frm-sdisuite-launch" 
  action="none.html" method="post" target="ifrm-sdisuite-launch">
  <input type="hidden" id="ticket" name="ticket" value=""/>
</form>
</f:verbatim>
  
</h:form>
