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
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<div style='height: 120px; padding-bottom: 5px;'>
   <h:outputText id="gptFooterStatement" escape="false" value="#{gptMsg['catalog.content.footer.statement']}"/>
   <div style='width: 100%; padding-top: 5px;'>
      <table width="100%" cellpadding="0" cellspacing="0">
         <tr>
           <td width="20%" align='left'>
             <h:graphicImage value="/catalog/images/doe_banner_50h.png" 
                     style=''
                     alt="The U.S. Department of Energy under award DE-EE0001120 to Boise State University and under award DE-EE0002850 to the Arizona Geological Survey acting on behalf of the Association of American State Geologists."
                     title="The U.S. Department of Energy under award DE-EE0001120 to Boise State University and under award DE-EE0002850 to the Arizona Geological Survey acting on behalf of the Association of American State Geologists."/>
           </td>
           <td width="80%" align='left'>
             The U.S. Department of Energy under award DE-EE0001120 to Boise State University and under award DE-EE0002850 to the Arizona Geological Survey acting on behalf of the Association of American State Geologists.
           </td>
         </tr>
         <tr>
           <td width="20%" align='left'>
              <h:graphicImage value="/catalog/images/nsf_banner_50h.png" 
                              style='' 
                              alt="The National Science Foundation under EAR-0753154 to the Arizona Geological Survey acting on behalf of the Association of American State Geologists"
                              title="The National Science Foundation under EAR-0753154 to the Arizona Geological Survey acting on behalf of the Association of American State Geologists"/>

           </td>
           <td width="80%" align='left'>
              The National Science Foundation under EAR-0753154 to the Arizona Geological Survey acting on behalf of the Association of American State Geologists
           </td>
         </tr>
      </table>
   </div>
</div>
