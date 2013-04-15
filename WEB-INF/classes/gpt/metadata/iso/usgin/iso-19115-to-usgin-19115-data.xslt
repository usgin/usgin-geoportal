<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exslt="http://exslt.org/common" xmlns="http://www.isotc211.org/2005/gmd"
    xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco"
    xmlns:gml="http://www.opengis.net/gml" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:csw="http://www.opengis.net/cat/csw/2.0.2"
    xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:gmx="http://www.isotc211.org/2005/gmx"
    xmlns:gmi="http://www.isotc211.org/2005/gmi" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:usgin="http://resources.usgin.org/xslt/ISO2USGINISO"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xsi:schemaLocation="http://www.isotc211.org/2005/gmd http://schemas.opengis.net/csw/2.0.2/profiles/apiso/1.0.0/apiso.xsd">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <!--  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"
        exclude-result-prefixes="fn xs xsi xsl usgin csw"/>
-->    <!-- This xslt transforms an ISO19139 XML metadata record to conform to requirements of USGIN
    catalogs. 
    Leah Musil and Stephen Richard
    2013-03-28 -->

    <xsl:param name="sourceUrl"/>
    <xsl:param name="serviceType"/>
    <xsl:param name="currentDate"/>
  <!--  <xsl:param name="generatedUUID"/>
    <xsl:param name="faxPhone"/>
    <xsl:param name="voicePhone"/>
    <xsl:param name="codeListValue"/>
    <xsl:param name="electronicMailAddress"/> -->
    <!-- use this to document things added or changed by this xslt -->
    <xsl:param name="metadataMaintenanceNote"
        select="'This metadata record has been processed by the iso-19115-to-usgin-19115-data XSLT to ensure that all mandatory content for USGIN profile has been added.'"/>

    <!-- start main processing chain
    <xsl:template match="/">
        <xsl:call-template name="main"/>
    </xsl:template>   -->
    <xsl:template match="gmd:MD_Metadata | gmi:MI_Metadata">
        <xsl:variable name="var_InputRootNode" select="."/>
        <gmd:MD_Metadata xmlns:gco="http://www.isotc211.org/2005/gco"
            xmlns:gml="http://www.opengis.net/gml" xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.isotc211.org/2005/gmd http://schemas.opengis.net/csw/2.0.2/profiles/apiso/1.0.0/apiso.xsd">

            <gmd:fileIdentifier>
                <gco:CharacterString>
                    <xsl:choose>
                        <xsl:when test="$var_InputRootNode/gmd:fileIdentifier">
                            <xsl:value-of
                                select="$var_InputRootNode/gmd:fileIdentifier/gco:CharacterString"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="concat('http://www.opengis.net/def/nil/OGC/0/missing/','2013-04-04T12:00:00Z')"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                </gco:CharacterString>
            </gmd:fileIdentifier>

            <!-- metadata language-->
            <xsl:choose>
                <xsl:when test="$var_InputRootNode/gmd:language">
                    <xsl:copy-of select="$var_InputRootNode/gmd:language"/>
                </xsl:when>
                <xsl:otherwise>
                    <gmd:language>
                        <!--<xsl:comment>no language in source metadata, USGIN XSLT inserted default value</xsl:comment> -->
                        <gmd:LanguageCode
                            codeList="http://www.loc.gov/standards/iso639-2/php/code_list.php"
                            codeListValue="eng">eng</gmd:LanguageCode>
                    </gmd:language>

                </xsl:otherwise>
            </xsl:choose>

            <!-- characterSet defaults to UTF-8 if no character set is specified -->
            <xsl:choose>
                <xsl:when test="$var_InputRootNode/gmd:characterSet">
                    <xsl:copy-of select="$var_InputRootNode/gmd:characterSet"/>
                </xsl:when>
                <xsl:otherwise>
                    <gmd:characterSet>
                     <!--   <xsl:comment>no character set element in source metadata, USGIN XSLT inserted default value</xsl:comment>-->
                        <gmd:MD_CharacterSetCode
                            codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode "
                            codeListValue="utf8">UTF-8</gmd:MD_CharacterSetCode>
                    </gmd:characterSet>
                </xsl:otherwise>
            </xsl:choose>

            <!-- hierarchyLevel defaults to dataset -->
            <xsl:choose>
                <xsl:when test="$var_InputRootNode/gmd:hierarchyLevel">
                    <xsl:copy-of select="$var_InputRootNode/gmd:hierarchyLevel" />
                </xsl:when>
                <xsl:otherwise>
                    <gmd:hierarchyLevel>
                    <!--    <xsl:comment>no hierarchyLevel in source metadata, USGIN XSLT inserted default value</xsl:comment> -->
                        <gmd:MD_ScopeCode
                            codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#MD_ScopeCode"
                            codeListValue="Dataset">dataset</gmd:MD_ScopeCode>
                    </gmd:hierarchyLevel>
                </xsl:otherwise>
            </xsl:choose>
            <!-- copy hierarchyLevelName -->
            <xsl:choose>
                <xsl:when test="$var_InputRootNode/gmd:hierarchyLevelName">
                    <xsl:copy-of select="$var_InputRootNode/gmd:hierarchyLevelName"/>
                </xsl:when>
                <xsl:otherwise>
                    <gmd:hierarchyLevelName>
                   <!--    <xsl:comment>no hierarchyLevelName in source metadata, USGIN XSLT inserted default value</xsl:comment> -->
                        <gco:CharacterString>Missing</gco:CharacterString>
                    </gmd:hierarchyLevelName>
                </xsl:otherwise>
            </xsl:choose>

            <!--        <xsl:apply-templates select="$var_InputRootNode/gmd:contact"/>  -->
            <!--use for multiple contact-->
            <xsl:for-each select="$var_InputRootNode/gmd:contact">
                <gmd:contact>
                    <xsl:call-template name="usgin:ResponsibleParty">
                        <xsl:with-param name="inputParty" select="gmd:CI_ResponsibleParty"/>
                        <xsl:with-param name="defaultRole">
                            <gmd:role>
                                <gmd:CI_RoleCode
                                    codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#CI_RoleCode"
                                    codeListValue="pointOfContact">pointOfContact</gmd:CI_RoleCode>
                            </gmd:role>
                        </xsl:with-param>
                    </xsl:call-template>

                </gmd:contact>
            </xsl:for-each>
            <gmd:dateStamp>
                <gco:DateTime>
                    <xsl:call-template name="usgin:dateFormat">
                        <xsl:with-param name="inputDate" select="$var_InputRootNode/gmd:dateStamp"/>
                    </xsl:call-template>
                </gco:DateTime>
            </gmd:dateStamp>

            <gmd:metadataStandardName>
                <gco:CharacterString>
                    <xsl:value-of select="'ISO-USGIN'"/>
                </gco:CharacterString>
            </gmd:metadataStandardName>

            <gmd:metadataStandardVersion>
                <gco:CharacterString>
                    <xsl:value-of select="'1.2'"/>
                </gco:CharacterString>
            </gmd:metadataStandardVersion>

            <gmd:dataSetURI>
                <gco:CharacterString>
                    <xsl:choose>
                        <xsl:when test="$var_InputRootNode/gmd:datasetURI/gco:CharacterString">
                            <xsl:value-of
                                select="$var_InputRootNode/gmd:datasetURI/gco:CharacterString"/>
                        </xsl:when>
                        <xsl:when
                            test="$var_InputRootNode/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:ISBN">
                         <!--  <xsl:comment>no resource identifier in source metadata, USGIN XSLT uses citation ISBN</xsl:comment> -->
                            <xsl:value-of
                                select="concat('ISBN:',normalize-space(string($var_InputRootNode/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:ISBN)))"
                            />
                        </xsl:when>
                        <xsl:when
                            test="$var_InputRootNode/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:ISSN">
                      <!--      <xsl:comment>no resource identifier in source metadata, USGIN XSLT uses citation ISSN</xsl:comment> -->
                            <xsl:value-of
                                select="concat('ISSN:',normalize-space(string($var_InputRootNode/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:ISSN)))"
                            />
                        </xsl:when>
                        <xsl:when
                            test="$var_InputRootNode/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier">
                        <!--    <xsl:comment>no resource identifier in source metadata, USGIN XSLT uses citation identifier</xsl:comment>-->
                            <xsl:value-of
                                select="normalize-space(string($var_InputRootNode/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier))"
                            />
                        </xsl:when>
                        <xsl:otherwise>
                          <!--  <xsl:comment>no resource identifier in source metadata, USGIN XSLT inserted nil value</xsl:comment>-->
                            <xsl:value-of
                                select="concat('http://www.opengis.net/def/nil/OGC/0/missing/','2013-04-04T12:00:00Z')"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                </gco:CharacterString>
            </gmd:dataSetURI>

            <xsl:copy-of select="$var_InputRootNode/gmd:locale"/>
            <xsl:copy-of select="$var_InputRootNode/gmd:spatialRepresentationInfo"/>
            <xsl:copy-of select="$var_InputRootNode/gmd:referenceSystemInfo"/>
            <!-- there may be multiple identificationInfo elements. Several metadata profiles put service distribution
                information in sv_serviceIdentification elements in the same records as MD_DataIdentification
              The USGIN profile used MD_DataIdentification and puts service-based distribution information in 
              the distributionInformation section.  If there are multiple MD_DataIdentification elements, only
              the first will be processed. SV_ServiceIdentification elements will be parsed in the distributionInfo
            template -->
            <xsl:call-template name="usgin:identificationSection">
                <xsl:with-param name="inputInfo"
                    select="$var_InputRootNode/gmd:identificationInfo/gmd:MD_DataIdentification[1]"
                />
            </xsl:call-template>


            <xsl:call-template name="usgin:distributionSection">
                <xsl:with-param name="inputDistro" select="$var_InputRootNode/gmd:distributionInfo"
                />
            </xsl:call-template>
            <xsl:copy-of select="$var_InputRootNode/gmd:dataQualityInfo"/>
            <xsl:copy-of select="$var_InputRootNode/gmd:portrayalCatalogueInfo"/>
            <xsl:copy-of select="$var_InputRootNode/gmd:metadataConstraints"/>
            <xsl:copy-of select="$var_InputRootNode/gmd:applicationSchemaInfo"/>
            <!--           <xsl:for-each select="$var_InputRootNode/gmd:metadataMaintenance">  -->
            <gmd:metadataMaintenance>
                <gmd:MD_MaintenanceInformation>
                    <xsl:choose>
                        <xsl:when
                            test="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency">
                            <xsl:copy-of
                                select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <gmd:maintenanceAndUpdateFrequency>
                              <!--no update frequency in source metadata, USGIN XSLT inserted 'irregular' as a default -->
                                <gmd:MD_MaintenanceFrequencyCode
                                    codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_MaintenanceFrequencyCode"
                                    codeListValue="IRREGULAR">irregular
                                </gmd:MD_MaintenanceFrequencyCode>
                            </gmd:maintenanceAndUpdateFrequency>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:copy-of
                        select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:dateOfNextUpdate"/>
                    <xsl:copy-of
                        select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:userDefinedMaintenanceFrequency"
                     />
                    <xsl:copy-of
                        select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:updateScope"
                       />
                    <xsl:copy-of
                        select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:updateScopeDescription"
                        />
                    <xsl:copy-of
                        select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceNote"
                        />
                    <!-- add a note that the record has been processed by this xslt -->
                    <gmd:maintenanceNote>
                        <gco:CharacterString>
                            <xsl:value-of
                                select="concat($metadataMaintenanceNote, '2013-04-04T12:00:00')"
                            />
                        </gco:CharacterString>
                    </gmd:maintenanceNote>
                    <xsl:copy-of
                        select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:contact"
                       />
                </gmd:MD_MaintenanceInformation>
            </gmd:metadataMaintenance>
            <!--            </xsl:for-each>  -->
        </gmd:MD_Metadata>
    </xsl:template>

    <!-- Templates Start Here -->
    <!---Metadata contact-->

    <xsl:template name="usgin:ResponsibleParty">
        <!-- parameter should be a CI_ResponsibleParty node -->
        <xsl:param name="inputParty" select="."/>
        <xsl:param name="defaultRole" select="."/>
        <gmd:CI_ResponsibleParty>
            <gmd:individualName>
                <gco:CharacterString>
                    <xsl:choose>
                        <xsl:when test="$inputParty/gmd:individualName/gco:CharacterString">
                            <xsl:value-of
                                select="$inputParty/gmd:individualName/gco:CharacterString"/>
                        </xsl:when>
                        <xsl:otherwise>missing</xsl:otherwise>
                    </xsl:choose>
                </gco:CharacterString>
            </gmd:individualName>
            <gmd:organisationName>
                <gco:CharacterString>
                    <xsl:choose>
                        <xsl:when test="$inputParty/gmd:organisationName/gco:CharacterString">
                            <xsl:value-of
                                select="$inputParty/gmd:organisationName/gco:CharacterString"/>
                        </xsl:when>
                        <xsl:otherwise>missing</xsl:otherwise>
                    </xsl:choose>
                </gco:CharacterString>

            </gmd:organisationName>
            <xsl:copy-of select="$inputParty/gmd:positionName"/>
            <gmd:contactInfo>
                <gmd:CI_Contact>
                    <gmd:phone>
                        <gmd:CI_Telephone>
                            <xsl:choose>
                                <xsl:when
                                    test="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:voice/gco:CharacterString">
                                    <xsl:for-each
                                        select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:voice">
                                        <gmd:voice>
                                            <gco:CharacterString>
                                                <xsl:choose>
                                                  <xsl:when test="gco:CharacterString">
                                                  <xsl:value-of select="gco:CharacterString"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>999-999-9999</xsl:otherwise>
                                                </xsl:choose>
                                            </gco:CharacterString>
                                        </gmd:voice>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>
                                    <gmd:voice>
                                        <gco:CharacterString>999-999-9999</gco:CharacterString>
                                    </gmd:voice>
                                </xsl:otherwise>
                            </xsl:choose>
                            <!-- if there is a voice phone -->
                            <!-- copy any fax numbers -->
                            <xsl:copy-of
                                select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:facsimile"
                            />
                        </gmd:CI_Telephone>
                    </gmd:phone>

                    <gmd:address>
                        <gmd:CI_Address>
                            <xsl:copy-of
                                select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:deliveryPoint"
                               />
                            <xsl:copy-of
                                select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:city"
                            />
                            <xsl:copy-of
                                select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:administrativeArea"
                          />
                            <xsl:copy-of
                                select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:postalCode"
                            />
                            <!-- there will be an e-mail address -->
                            <xsl:choose>
                                <xsl:when
                                    test="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress">
                                    <xsl:for-each
                                        select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress">
                                        <gmd:electronicMailAddress>
                                            <gco:CharacterString>
                                                <xsl:choose>
                                                  <xsl:when test="gco:CharacterString">
                                                  <xsl:value-of select="gco:CharacterString"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>missing@usgin.org</xsl:otherwise>
                                                </xsl:choose>
                                            </gco:CharacterString>
                                        </gmd:electronicMailAddress>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>
                                    <!-- no e-mail address in the source doc -->
                                    <gmd:electronicMailAddress gco:nilReason="missing">
                                     <!--   <xsl:comment>no e-mail address for contact in source metadata, USGIN XSLT inserted nil value</xsl:comment> -->
                                        <gco:CharacterString>missing@usgin.org</gco:CharacterString>
                                    </gmd:electronicMailAddress>
                                </xsl:otherwise>
                            </xsl:choose>

                        </gmd:CI_Address>
                    </gmd:address>
                    <xsl:copy-of
                        select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource"
                       />
                    <xsl:copy-of
                        select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:hoursOfService"
                       />
                    <xsl:copy-of
                        select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:contactInstructions"
                     />
                </gmd:CI_Contact>
            </gmd:contactInfo>

            <xsl:choose>
                <xsl:when test="$inputParty/gmd:role">
                    <xsl:copy-of select="$inputParty/gmd:role"/>

                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="$defaultRole">
                            <xsl:copy-of select="$defaultRole"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <gmd:role>
                                <gmd:CI_RoleCode
                                    codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#CI_RoleCode"
                                    codeListValue="pointOfContact">pointOfContact</gmd:CI_RoleCode>
                            </gmd:role>
                        </xsl:otherwise>
                    </xsl:choose>

                </xsl:otherwise>
            </xsl:choose>
        </gmd:CI_ResponsibleParty>
    </xsl:template>
    <!-- end of ResponsibleParty handler -->

    <!--Identification info - required regardless of repository output-->
    <xsl:template name="usgin:identificationSection">
        <xsl:param name="inputInfo"/>
        <gmd:identificationInfo>
            <gmd:MD_DataIdentification>
                <!-- elements from abstract MD_Identification -->
                <gmd:citation>
                    <gmd:CI_Citation>
                        <gmd:title>
                            <gco:CharacterString><xsl:value-of
                                    select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString"/></gco:CharacterString>
                        </gmd:title>

                        <xsl:copy-of
                            select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:alternateTitle"
                            />

                        <gmd:date>
                            <gmd:CI_Date>
                                <gmd:date>
                                    <gco:DateTime>
                                        <xsl:call-template name="usgin:dateFormat">
                                            <xsl:with-param name="inputDate"
                                                select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date"
                                            />
                                        </xsl:call-template>

                                    </gco:DateTime>
                                </gmd:date>
                                <gmd:dateType>
                                    <gmd:CI_DateTypeCode
                                        codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#CI_DateTypeCode"
                                        codeListValue="publication"
                                        >publication</gmd:CI_DateTypeCode>
                                </gmd:dateType>
                            </gmd:CI_Date>
                        </gmd:date>
                        <xsl:copy-of select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:edition"
                          />
                        <xsl:copy-of
                            select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:editionDate"
                         />
                        <xsl:copy-of select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:identifier"
                           />

                        <!---Responsible Party may not be included in Repo output, yet It is required for USGIN validation.-->
                        <!-- for each statement alows more than one contact to be processed -->
                        <xsl:choose>
                            <xsl:when
                                test="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty">
                                <xsl:for-each
                                    select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty">
                                    <gmd:citedResponsibleParty>
                                        <xsl:call-template name="usgin:ResponsibleParty">
                                            <xsl:with-param name="inputParty"
                                                select="gmd:CI_ResponsibleParty"/>
                                            <xsl:with-param name="defaultRole">
                                                <gmd:role>
                                                  <gmd:CI_RoleCode
                                                  codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#CI_RoleCode"
                                                  codeListValue="originator"
                                                  >originator</gmd:CI_RoleCode>
                                                </gmd:role>
                                            </xsl:with-param>
                                        </xsl:call-template>
                                    </gmd:citedResponsibleParty>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <!-- no responsible party reported, put in minimal missing element -->
                                <gmd:citedResponsibleParty gco:nilReason="missing">
                                    <gmd:CI_ResponsibleParty>
                                        <gmd:individualName>
                                            <gco:CharacterString>missing</gco:CharacterString>
                                        </gmd:individualName>
                                        <gmd:contactInfo>
                                            <gmd:CI_Contact>
                                                <gmd:phone>
                                                  <gmd:CI_Telephone>
                                                  <gmd:voice>
                                                  <gco:CharacterString>999-999-9999</gco:CharacterString>
                                                  </gmd:voice>
                                                  </gmd:CI_Telephone>
                                                </gmd:phone>
                                            </gmd:CI_Contact>
                                        </gmd:contactInfo>
                                        <gmd:role>
                                            <gmd:CI_RoleCode
                                                codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_RoleCode"
                                                codeListValue="originator"
                                                >originatory</gmd:CI_RoleCode>
                                        </gmd:role>
                                    </gmd:CI_ResponsibleParty>
                                </gmd:citedResponsibleParty>
                            </xsl:otherwise>
                        </xsl:choose>

                        <xsl:copy-of
                            select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:presentationForm"
                         />
                        <xsl:copy-of select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:series"
                           />
                        <xsl:copy-of
                            select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:otherCitationDetails"
                            />
                        <xsl:copy-of
                            select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:collectiveTitle"
                          />
                        <xsl:copy-of select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:ISBN"
                        />
                        <xsl:copy-of select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:ISSN"
                           />

                    </gmd:CI_Citation>
                </gmd:citation>

                <xsl:copy-of select="$inputInfo/gmd:abstract"/>
                <xsl:copy-of select="$inputInfo/gmd:purpose"/>
                <xsl:copy-of select="$inputInfo/gmd:credit" />
                <xsl:copy-of select="$inputInfo/gmd:status" />
                <xsl:copy-of select="$inputInfo/gmd:pointOfContact"/>
                <xsl:copy-of select="$inputInfo/gmd:resourceMaintenance"/>
                <!--          USGIN puts format information in distributionFormat 
         <xsl:copy-of select="$inputInfo/gmd:resourceFormat" copy-namespaces="no"/>  -->

                <xsl:copy-of select="$inputInfo/gmd:descriptiveKeywords"/>
                <xsl:choose>
                    <xsl:when
                        test="not($inputInfo/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox)">
                        <!--<xsl:comment>no bounding box in source metadata, USGIN XSLT inserted 'non-geographic' keyword</xsl:comment> -->
                        <gmd:descriptiveKeywords>
                            <gmd:MD_Keywords>
                                <gmd:keyword>
                                    <gco:CharacterString>non-geographic</gco:CharacterString>
                                </gmd:keyword>
                                <gmd:type>
                                    <gmd:MD_KeywordTypeCode
                                        codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_KeywordTypeCode"
                                        codeListValue="place">place</gmd:MD_KeywordTypeCode>
                                </gmd:type>
                            </gmd:MD_Keywords>
                        </gmd:descriptiveKeywords>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if
                            test="not($inputInfo/gmd:descriptiveKeywords/gmd:MD_Keyword/gmd:keyword/gco:CharacterString)">
                            <!--At least one keyword is required -->
                            <gmd:descriptiveKeywords>
                                <gmd:MD_Keywords>
                                    <gmd:keyword>
                                        <gco:CharacterString>missing</gco:CharacterString>
                                    </gmd:keyword>
                                </gmd:MD_Keywords>
                            </gmd:descriptiveKeywords>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>

                <xsl:copy-of select="$inputInfo/gmd:resourceSpecificUsage"  />
                <xsl:copy-of select="$inputInfo/gmd:resourceConstraints"  />
                <xsl:copy-of select="$inputInfo/gmd:aggregationInfo"  />

                <!-- elements from MD_DataIdentification -->
                <xsl:copy-of select="$inputInfo/gmd:spatialRepresentationType"  />
                <xsl:copy-of select="$inputInfo/gmd:spatialResolution"  />
                <xsl:copy-of select="$inputInfo/gmd:language"  />

                <!-- characterSet defaults to UTF-8 if no character set is specified -->
                <xsl:choose>
                    <xsl:when test="$inputInfo/gmd:characterSet">
                        <xsl:copy-of select="$inputInfo/gmd:characterSet"  />
                    </xsl:when>
                    <xsl:otherwise>
                        <gmd:characterSet>
                           <!-- <xsl:comment>no character set element in source metadata, USGIN XSLT inserted default value</xsl:comment> -->
                            <gmd:MD_CharacterSetCode
                                codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode "
                                codeListValue="utf8">UTF-8</gmd:MD_CharacterSetCode>
                        </gmd:characterSet>
                    </xsl:otherwise>
                </xsl:choose>
				 <xsl:choose>
                    <xsl:when test="$inputInfo/gmd:topicCategory/gmd:MD_TopicCategoryCode">
                        <xsl:copy-of select="$inputInfo/gmd:topicCategory"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <gmd:topicCategory>
                           <!-- <xsl:comment>no topic category code in source metadata, USGIN XSLT inserted default value</xsl:comment>-->
                            <gmd:MD_TopicCategoryCode>
                                <xsl:value-of select="'geoscientificInformation'"/>
                            </gmd:MD_TopicCategoryCode>
                        </gmd:topicCategory>
                    </xsl:otherwise>
                </xsl:choose>
				
				
				

                <xsl:copy-of select="$inputInfo/gmd:environmentDescription"  />
                <xsl:copy-of select="$inputInfo/gmd:extent"  />
                <xsl:copy-of select="$inputInfo/gmd:supplementalInformation"  />

               

            </gmd:MD_DataIdentification>
        </gmd:identificationInfo>
    </xsl:template>
    <!-- end processing MD_DataIdentification -->

    <!-- Distribution -->
    <xsl:template name="usgin:distributionSection">
        <xsl:param name="inputDistro"/>
        <!-- context will be distributionInfo -->
        <gmd:distributionInfo>
            <gmd:MD_Distribution>
                <!-- copy over any distribution Formats -->
                <xsl:copy-of select="$inputDistro/gmd:MD_Distribution/gmd:distributionFormat"
                     />
                <!-- if there is a MD_DataIdentification/resourceFormat, put that in here-->
                <xsl:for-each select="//gmd:MD_DataIdentification/gmd:resourceFormat">
                    <gmd:distributionFormat>
                        <xsl:copy-of select="gmd:MD_Format"  />
                    </gmd:distributionFormat>
                </xsl:for-each>

                <xsl:for-each select="$inputDistro/gmd:MD_Distribution/gmd:distributor">
                    <gmd:distributor>
                        <!-- check: may need to check for ID's on distributors used to bind transfer options
                        to distributors if there are multiple distributors and transfer options -->
                        <gmd:MD_Distributor>
                            <gmd:distributorContact>
                                <xsl:call-template name="usgin:ResponsibleParty">
                                    <xsl:with-param name="inputParty"
                                        select="gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty"/>
                                    <xsl:with-param name="defaultRole">
                                        <gmd:role>
                                            <gmd:CI_RoleCode
                                                codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#CI_RoleCode"
                                                codeListValue="distributor"
                                                >distributor</gmd:CI_RoleCode>
                                        </gmd:role>
                                    </xsl:with-param>
                                </xsl:call-template>


                            </gmd:distributorContact>
                            <xsl:copy-of  
                                select="gmd:MD_Distributor/gmd:distributionOrderProcess"/>
                            <xsl:copy-of  
                                select="gmd:MD_Distributor/gmd:distributorFormat"/>
                            <xsl:copy-of  
                                select="gmd:MD_Distributor/gmd:distributorTransferOptions"/>
                        </gmd:MD_Distributor>
                    </gmd:distributor>
                </xsl:for-each>
                <!-- end of iteration over distributors -->
                <!-- accomodate metadata that has all transfer options in distributorTransferOptions
                 put the first TransferOptions link into MD_Distribtuion/gmd:transferOptions -->
                <xsl:choose>
                    <xsl:when test="$inputDistro/gmd:MD_Distribution/gmd:transferOptions">

                        <xsl:copy-of select="$inputDistro/gmd:MD_Distribution/gmd:transferOptions"
                             />
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- copy in the first distributor transfer options -->
                        <xsl:if
                            test="$inputDistro/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorTransferOptions">
                            <gmd:transferOptions>
                               <!-- <xsl:comment>USGIN XSLT copies first distributorTransferOption here for clients that expect transferOptions</xsl:comment> -->
                                <xsl:copy-of
                                    select="$inputDistro/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorTransferOptions[1]/gmd:MD_DigitalTransferOptions"
                                     />
                            </gmd:transferOptions>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
                <!-- accomodate service distributions described in SV_ServiceIdentification sections -->
                <xsl:if test="//srv:serviceType">
                    <xsl:for-each
                        select="/gmi:MI_Metadata/gmd:identificationInfo/srv:SV_ServiceIdentification">
                        <!-- each service is in a separate transferOptions section -->
                        <gmd:transferOptions>
                            <gmd:MD_DigitalTransferOptions>
                              <!--  <xsl:comment>USGIN XSLT copies transfer options from SV_ServiceIdentification element in source metadata</xsl:comment> -->
                                <xsl:for-each
                                    select="srv:containsOperations/srv:SV_OperationMetadata">
                                    <!-- each operation gets a separate CI_OnlineResource link -->
                                    <gmd:onLine>
                                        <gmd:CI_OnlineResource>
                                            <gmd:linkage>
                                                <gmd:URL>
                                                  <xsl:value-of
                                                  select="srv:connectPoint/gmd:CI_OnlineResource/gmd:linkage/gmd:URL"
                                                  />
                                                </gmd:URL>
                                            </gmd:linkage>
                                            <gmd:protocol>
                                                <gco:CharacterString>
                                                  <xsl:value-of
                                                  select="normalize-space(string(ancestor::srv:SV_ServiceIdentification/srv:serviceType))"
                                                  />
                                                </gco:CharacterString>
                                            </gmd:protocol>
                                            <xsl:if test="string-length(string(srv:DCP))>0">
                                                <gmd:applicationProfile>
                                                  <gco:CharacterString>
                                                  <xsl:value-of
                                                  select="normalize-space(string(srv:DCP))"/>
                                                  </gco:CharacterString>
                                                </gmd:applicationProfile>
                                            </xsl:if>
                                            <gmd:name>
                                                <gco:CharacterString>
                                                  <xsl:value-of
                                                  select="concat(srv:connectPoint/gmd:CI_OnlineResource/gmd:name/gco:CharacterString, ' ', srv:operationName/gco:CharacterString)"
                                                  />
                                                </gco:CharacterString>
                                            </gmd:name>
                                            <xsl:copy-of
                                                select="srv:connectPoint/gmd:CI_OnlineResource/gmd:description"
                                                 />
                                            <xsl:copy-of
                                                select="srv:connectPoint/gmd:CI_OnlineResource/gmd:function"
                                                 />

                                        </gmd:CI_OnlineResource>
                                    </gmd:onLine>
                                </xsl:for-each>
                            </gmd:MD_DigitalTransferOptions>
                        </gmd:transferOptions>

                    </xsl:for-each>
                </xsl:if>

            </gmd:MD_Distribution>
        </gmd:distributionInfo>
    </xsl:template>
    <!-- end distributionInformation processing -->


    <!-- utility templates -->
    <xsl:template name="usgin:dateFormat">
        <xsl:param name="inputDate" select="."/>
        <!-- input data should be either a gco:Date or a gco:DateTime node -->
        <!-- USGIN mandates use of DateTime, so will need to add 'T12:00:00Z' to gco:Date string -->
        <xsl:choose>
            <xsl:when test="$inputDate/gco:Date">
                <xsl:value-of
                    select="concat(normalize-space(translate(string($inputDate), '/', '-')),'T12:00:00Z')"
                />
            </xsl:when>
            <xsl:when test="$inputDate/gco:DateTime">
                <xsl:choose>
                    <xsl:when
                        test="(normalize-space(string($inputDate/gco:DateTime))=18)">
                        <xsl:value-of select="$inputDate/gco:DateTime"/>
                    </xsl:when>
                    <xsl:when
                        test="count($inputDate/gco:DateTime)=10">
                        <xsl:value-of select="concat($inputDate/gco:DateTime,'T12:00:00Z')"/>
                    </xsl:when>
                    <xsl:when
                        test="count($inputDate/gco:DateTime)=11">
                        <xsl:value-of
                            select="concat(normalize-space(string($inputDate/gco:DateTime)),'00:00Z')"
                        />
                    </xsl:when>
                    <xsl:when
                        test="count($inputDate/gco:DateTime)=14">
                        <xsl:value-of
                            select="concat($inputDate/gco:DateTime,':00Z')"
                        />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="string('1900-01-01T12:00:00Z')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when> <!-- end of gco:dateTime handler -->
            <xsl:otherwise>
                <xsl:value-of select="string('1900-01-01T12:00:00Z')"/> 
            </xsl:otherwise>
        </xsl:choose> <!-- end of inputDate handler -->
    </xsl:template>
</xsl:stylesheet>

