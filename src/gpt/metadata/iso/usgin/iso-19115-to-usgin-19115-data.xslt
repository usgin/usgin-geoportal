<?xml version="1.0" encoding="UTF-8"?>
<!--*************************************************************************************************** 
	*** Example ISO 19139 Geospatial Dataset Metadata based on the USGIN v1.1 
	Profile *** by USGIN Standards and Protocols Drafting Team *** U.S. Geoscience 
	Information System (USGIN) - http://lab.usgin.org *** Contributors: Wolfgang 
	Grunberg, Stephen M Richard *** 02/02/2010 *** updated 11/19/2010 correct 
	distribution section ************************************************************************************************** -->
<xsl:stylesheet version="1.0" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
                xmlns="http://www.isotc211.org/2005/gmd"
                xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:gco="http://www.isotc211.org/2005/gco"
                xmlns:gml="http://www.opengis.net/gml"
                xmlns:xlink="http://www.w3.org/1999/xlink"
				xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:gts="http://www.isotc211.org/2005/gts"
                xmlns:geonet="http://www.fao.org/geonetwork"
                xmlns:csw="http://www.opengis.net/cat/csw/2.0.2"
                xmlns:srv="http://www.isotc211.org/2005/srv"
                xmlns:gmx="http://www.isotc211.org/2005/gmx">
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:param name="sourceUrl"/>
    <xsl:param name="serviceType"/>
    <xsl:param name="currentDate"/>
    <xsl:param name="generatedUUID"/>
	
    <!-- *********** -->
    <!-- This style sheet converts ISO 19115 (versions ? to
 ISO (19115(2006), 19119, 19139 metadata that conforms with the USGIN metadata profile.
 See http://lab.usgin.org/profiles/usgin-iso-metadata-profile (http://lab.usgin.org/node/235) -->
    <!-- Lund Wolfe, lund.wolfe@azgs.az.gov -->
    <!-- provided as-is, use at your own risk! -->
    <!-- this program based on ogc-toISO19139.xslt provided with ESRI geoportal software package
and USGIN service metadata example xml document -->
    <!-- version 1.0 2011-1-25 -->
    <xsl:template match="/">
        <xsl:call-template name="main"/>
    </xsl:template>
    <xsl:template name="main">
        <!-- coverts ISO 19115 metadata to USGIN ISO 191115 metadata -->
        <gmd:MD_Metadata
                xsi:schemaLocation="http://www.isotc211.org/2005/gmd http://schemas.opengis.net/csw/2.0.2/profiles/apiso/1.0.0/apiso.xsd">
            <gmd:fileIdentifier>
                <gco:CharacterString>
                    <xsl:choose>
                        <xsl:when test="/gmd:MD_Metadata/gmd:fileIdentifier">
                            <xsl:value-of select="/gmd:MD_Metadata/gmd:fileIdentifier/gco:CharacterString"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$generatedUUID"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </gco:CharacterString>
            </gmd:fileIdentifier>
            <gmd:language>
                <gco:CharacterString>
                    <xsl:choose>
                        <xsl:when test="/gmd:MD_Metadata/gmd:language">
                            <xsl:value-of select="/gmd:MD_Metadata/gmd:language/gco:CharacterString"/>
                        </xsl:when>
                        <xsl:otherwise>eng</xsl:otherwise>
                    </xsl:choose>
                </gco:CharacterString>
            </gmd:language>
            <gmd:characterSet>
                <gmd:MD_CharacterSetCode>
                    <xsl:choose>
                        <xsl:when test="/gmd:MD_Metadata/gmd:characterSet/gmd:MD_CharacterSetCode">
                            <xsl:attribute name="codeList">
                                <xsl:value-of
                                        select="/gmd:MD_Metadata/gmd:characterSet/gmd:MD_CharacterSetCode/@codeList"/>
                            </xsl:attribute>
                            <xsl:attribute name="codeListValue">
                                <xsl:value-of
                                        select="/gmd:MD_Metadata/gmd:characterSet/gmd:MD_CharacterSetCode/@codeListValue"/>
                            </xsl:attribute>
                            <xsl:value-of select="/gmd:MD_Metadata/gmd:characterSet"/>
                        </xsl:when>
                     <xsl:otherwise> <xsl:attribute name="codeList">http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode </xsl:attribute>
                            <xsl:attribute name="codeListValue">utf8</xsl:attribute>UTF-8</xsl:otherwise>
                    </xsl:choose>
                </gmd:MD_CharacterSetCode>
            </gmd:characterSet>
            <gmd:hierarchyLevel>
                <xsl:choose>
                    <xsl:when test="/gmd:MD_Metadata/gmd:hierarchyLevel">
                        <xsl:copy-of select="/gmd:MD_Metadata/gmd:hierarchyLevel/gmd:MD_ScopeCode"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <gmd:MD_ScopeCode
                                codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#MD_ScopeCode"
                                codeListValue="dataset">dataset</gmd:MD_ScopeCode>
                    </xsl:otherwise>
                </xsl:choose>
            </gmd:hierarchyLevel>
            <gmd:hierarchyLevelName>
                <gco:CharacterString>
                    <xsl:choose>
                        <xsl:when test="/gmd:MD_Metadata/gmd:hierarchyLevelName">
                            <xsl:value-of select="/gmd:MD_Metadata/gmd:hierarchyLevelName/gco:CharacterString"/>
                        </xsl:when>
                        <xsl:otherwise>dataset</xsl:otherwise>
                    </xsl:choose>
                </gco:CharacterString>
            </gmd:hierarchyLevelName>

            <xsl:apply-templates select="/gmd:MD_Metadata/gmd:contact"/>

            <gmd:dateStamp>
                <gco:DateTime>
                    <xsl:choose>
                        <xsl:when test="/gmd:MD_Metadata/gmd:dateStamp/gco:Date">
                            <xsl:value-of select="concat(/gmd:MD_Metadata/gmd:dateStamp/gco:Date,'T00:00:00')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="/gmd:MD_Metadata/gmd:dateStamp/gco:DateTime"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </gco:DateTime>
            </gmd:dateStamp>

            <gmd:metadataStandardName>
                <gco:CharacterString>ISO-NAP-USGIN</gco:CharacterString>
            </gmd:metadataStandardName>
            <gmd:metadataStandardVersion>
                <gco:CharacterString>1.1</gco:CharacterString>
            </gmd:metadataStandardVersion>

            <xsl:copy-of select="/gmd:MD_Metadata/gmd:dataSetURI"/>
            <xsl:copy-of select="/gmd:MD_Metadata/gmd:locale"/>
            <xsl:copy-of select="/gmd:MD_Metadata/gmd:spatialRepresentationInfo"/>
            <xsl:copy-of select="/gmd:MD_Metadata/gmd:referenceSystemInfo"/>
            <!-- not used in USGIN <gmd:metadataExtensionInfo/> -->
            <xsl:copy-of select="/gmd:MD_Metadata/gmd:identificationInfo"/>
            <xsl:copy-of select="/gmd:MD_Metadata/gmd:distributionInfo"/>

            <gmd:dataQualityInfo>
                <gmd:DQ_DataQuality>
                    <gmd:scope>
                        <gmd:DQ_Scope>
                            <gmd:level>
                                <xsl:choose>
                                    <xsl:when test="/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode">
                                        <xsl:copy-of select="/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <gmd:MD_ScopeCode
                                                codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#MD_ScopeCode"
                                                codeListValue="dataset">dataset</gmd:MD_ScopeCode>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </gmd:level>
                        </gmd:DQ_Scope>
                    </gmd:scope>
                    <xsl:copy-of select="/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report"/>
                    <gmd:lineage>
                        <gmd:LI_Lineage>
                            <gmd:statement>
                                <gco:CharacterString>
                                    <xsl:value-of select="concat(/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/gco:CharacterString, ' This metadata record harvested from ', $sourceUrl, '. and transformed to USGIN ISO19139 profile using iso-19115-to usgin_19115.xslt version 1.0')"/>
                                </gco:CharacterString>
                            </gmd:statement>
                            <xsl:copy-of select="/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:source"/>
                            <xsl:copy-of select="/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:processStep"/>
                        </gmd:LI_Lineage>
                    </gmd:lineage>
                </gmd:DQ_DataQuality>
            </gmd:dataQualityInfo>

            <xsl:copy-of select="/gmd:MD_Metadata/gmd:portrayalCatalogueInfo"/>
            <xsl:copy-of select="/gmd:MD_Metadata/gmd:metadataConstraints"/>
            <xsl:copy-of select="/gmd:MD_Metadata/gmd:applicationSchemaInfo"/>
            <xsl:copy-of select="/gmd:MD_Metadata/gmd:metadataMaintenance"/>
            <!-- not used in USGIN <gmd:series/> -->
            <!-- not used in USGIN <gmd:describes/> -->
            <!-- not used in USGIN <gmd:propertyType/> -->
            <!-- not used in USGIN <gmd:featureType/> -->
            <!-- not used in USGIN <gmd:featureAttribute/> -->
        </gmd:MD_Metadata>
    </xsl:template>

    <xsl:template match="/gmd:MD_Metadata/gmd:contact">
        <gmd:contact>
            <gmd:CI_ResponsibleParty>
                <xsl:attribute name="uuid">
                    <xsl:value-of select="gmd:CI_ResponsibleParty/@uuid"/>
                </xsl:attribute>
                <xsl:copy-of select="gmd:CI_ResponsibleParty/gmd:individualName"/>
                <xsl:copy-of select="gmd:CI_ResponsibleParty/gmd:organisationName"/>
                <xsl:copy-of select="gmd:CI_ResponsibleParty/gmd:positionName"/>
                <gmd:contactInfo>
                    <gmd:CI_Contact>
                        <xsl:attribute name="uuid">
                            <xsl:value-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/@uuid"/>
                        </xsl:attribute>
                        <xsl:copy-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone"/>
                        <gmd:address>
                            <gmd:CI_Address>
                                <xsl:copy-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:deliveryPoint"/>
                                <xsl:copy-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:city"/>
                                <xsl:copy-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:administrativeArea"/>
                                <xsl:copy-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:postalCode"/>
                                <xsl:copy-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:country"/>
                                <gmd:electronicMailAddress>
                                    <gco:CharacterString>
                                        <xsl:choose>
                                            <xsl:when test="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress">
                                                <xsl:value-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
                                            </xsl:when>
                                            <xsl:otherwise>missing</xsl:otherwise>
                                        </xsl:choose>
                                    </gco:CharacterString>
                                </gmd:electronicMailAddress>
                            </gmd:CI_Address>
                        </gmd:address>
                        <xsl:copy-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource"/>
                        <xsl:copy-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:hoursOfService"/>
                        <xsl:copy-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:contactInstructions"/>
                    </gmd:CI_Contact>
                </gmd:contactInfo>
                <xsl:copy-of select="gmd:CI_ResponsibleParty/gmd:role"/>
            </gmd:CI_ResponsibleParty>
        </gmd:contact>
    </xsl:template>

</xsl:stylesheet>