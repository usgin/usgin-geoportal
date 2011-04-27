<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gco="http://www.isotc211.org/2005/gco"
                xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:srv="http://www.isotc211.org/2005/srv"
                xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:gml="http://www.opengis.net/gml"
                xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:geonet="http://www.fao.org/geonetwork"
                xmlns:csw="http://www.opengis.net/cat/csw/2.0.2" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://www.isotc211.org/2005/gmd http://schemas.opengis.net/iso/19139/20060504/gmd/gmd.xsd
 http://www.isotc211.org/2005/srv http://schemas.opengis.net/iso/19139/20060504/srv/srv.xsd">

    <xsl:output method="xml" version="1.0" encoding="UTF-8"
                indent="yes"/>
    <xsl:param name="sourceUrl"/>
    <xsl:param name="serviceType"/>
    <xsl:param name="currentDate"/>
    <xsl:param name="generatedUUID"/>
    <!-- *********** -->
    <!-- This style sheet converts ISO 19119 (versions ? to
 ISO (19115(2006), 19119, 19139 metadata that conforms with the USGIN metadata profile.
 See http://lab.usgin.org/profiles/usgin-iso-metadata-profile (http://lab.usgin.org/node/235) -->
    <!-- Lund Wolfe, lund.wolfe@azgs.az.gov -->
    <!-- provided as-is, use at your own risk! -->
    <!-- this program based on ? -->
    <!-- version 1.0 2011-1-25 -->
    <xsl:template match="/">
        <xsl:call-template name="main"/>
    </xsl:template>

    <xsl:template name="main">
        <gmd:MD_Metadata
                xsi:schemaLocation="http://www.isotc211.org/2005/gmd http://schemas.opengis.net/iso/19139/20060504/gmd/gmd.xsd">
            <gmd:fileIdentifier>
                <gco:CharacterString>
                    <xsl:choose>
                        <xsl:when
                                test="string-length(/gmd:MD_Metadata/gmd:fileIdentifier/gco:CharacterString) &lt; 36">
                            <xsl:value-of select="$generatedUUID"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                    select="/gmd:MD_Metadata/gmd:fileIdentifier/gco:CharacterString"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </gco:CharacterString>
            </gmd:fileIdentifier>
            <xsl:copy-of select="/gmd:MD_Metadata/gmd:language"/>
            <gmd:characterSet>
                <gmd:MD_CharacterSetCode
                        codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode"
                        codeListValue="utf8">UTF-8
                </gmd:MD_CharacterSetCode>
            </gmd:characterSet>
            <gmd:hierarchyLevel>
                <gmd:MD_ScopeCode
                        codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#MD_ScopeCode"
                        codeListValue="service">service
                </gmd:MD_ScopeCode>
            </gmd:hierarchyLevel>
            <gmd:hierarchyLevelName>
                <gco:CharacterString>Service</gco:CharacterString>
            </gmd:hierarchyLevelName>

            <xsl:apply-templates select="/gmd:MD_Metadata/gmd:contact"/>
            <xsl:copy-of select="/gmd:MD_Metadata/gmd:dateStamp"/>

            <gmd:metadataStandardName>
                <gco:CharacterString>ISO-NAP-USGIN</gco:CharacterString>
            </gmd:metadataStandardName>
            <!-- (O-M) USGIN profile version -->
            <gmd:metadataStandardVersion>
                <gco:CharacterString>1.1</gco:CharacterString>
            </gmd:metadataStandardVersion>

            <xsl:copy-of select="/gmd:MD_Metadata/gmd:locale"/>
            <xsl:copy-of select="/gmd:MD_Metadata/gmd:spatialRepresentationInfo"/>
            <xsl:choose>
                <xsl:when test="/gmd:MD_Metadata/gmd:referenceSystemInfo">
                    <xsl:apply-templates select="/gmd:MD_Metadata/gmd:referenceSystemInfo"/>
                </xsl:when>
                <xsl:otherwise>
                    <!-- Create single empty required element -->
                    <gmd:referenceSystemInfo>
                        <gmd:MD_ReferenceSystem>
                            <gmd:referenceSystemIdentifier>
                                <gmd:RS_Identifier>
                                    <gmd:code>
                                        <gco:CharacterString></gco:CharacterString>
                                    </gmd:code>
                                    <gmd:codeSpace>
                                        <gco:CharacterString>missing</gco:CharacterString>
                                    </gmd:codeSpace>
                                </gmd:RS_Identifier>
                            </gmd:referenceSystemIdentifier>
                        </gmd:MD_ReferenceSystem>
                    </gmd:referenceSystemInfo>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo"/>
            <xsl:copy-of select="/gmd:MD_Metadata/gmd:distributionInfo"/>

            <gmd:dataQualityInfo>
                <gmd:DQ_DataQuality>
                    <gmd:scope>
                        <gmd:DQ_Scope>
                            <gmd:level>
                                <xsl:choose>
                                    <xsl:when
                                            test="/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode">
                                        <xsl:copy-of
                                                select="/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <gmd:MD_ScopeCode
                                                codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#MD_ScopeCode"
                                                codeListValue="dataset">dataset
                                        </gmd:MD_ScopeCode>
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
                                    <xsl:value-of
                                            select="concat(/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/gco:CharacterString, ' This metadata record harvested from ', $sourceUrl, '. and transformed to USGIN ISO19139 profile using iso_19119_to_usgin_iso_19119.xslt version 1.0')"/>
                                </gco:CharacterString>
                            </gmd:statement>
                            <xsl:copy-of
                                    select="/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:source"/>
                            <xsl:copy-of
                                    select="/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:processStep"/>
                        </gmd:LI_Lineage>
                    </gmd:lineage>
                </gmd:DQ_DataQuality>
            </gmd:dataQualityInfo>

            <xsl:copy-of select="/gmd:MD_Metadata/gmd:portrayalCatalogueInfo"/>
            <xsl:copy-of select="/gmd:MD_Metadata/gmd:metadataConstraints"/>
            <xsl:copy-of select="/gmd:MD_Metadata/gmd:applicationSchemaInfo"/>
            <xsl:copy-of select="/gmd:MD_Metadata/gmd:metadataMaintenance"/>
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
                            <xsl:value-of
                                    select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/@uuid"/>
                        </xsl:attribute>
                        <xsl:copy-of
                                select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone"/>
                        <gmd:address>
                            <gmd:CI_Address>
                                <xsl:copy-of
                                        select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:deliveryPoint"/>
                                <xsl:copy-of
                                        select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:city"/>
                                <xsl:copy-of
                                        select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:administrativeArea"/>
                                <xsl:copy-of
                                        select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:postalCode"/>
                                <xsl:copy-of
                                        select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:country"/>
                                <gmd:electronicMailAddress>
                                    <gco:CharacterString>
                                        <xsl:choose>
                                            <xsl:when
                                                    test="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress">
                                                <xsl:value-of
                                                        select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                missing
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </gco:CharacterString>
                                </gmd:electronicMailAddress>
                            </gmd:CI_Address>
                        </gmd:address>
                        <xsl:copy-of
                                select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource"/>
                        <xsl:copy-of
                                select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:hoursOfService"/>
                        <xsl:copy-of
                                select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:contactInstructions"/>
                    </gmd:CI_Contact>
                </gmd:contactInfo>
                <xsl:copy-of select="gmd:CI_ResponsibleParty/gmd:role"/>
            </gmd:CI_ResponsibleParty>
        </gmd:contact>
    </xsl:template>

    <xsl:template match="/gmd:MD_Metadata/gmd:referenceSystemInfo">
        <gmd:referenceSystemInfo>
            <gmd:MD_ReferenceSystem>
                <gmd:referenceSystemIdentifier>
                    <gmd:RS_Identifier>
                        <gmd:code>
                            <gco:CharacterString>
                                <xsl:choose>
                                    <xsl:when
                                            test="gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:code/gco:CharacterString">
                                        <xsl:value-of
                                                select="gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:code/gco:CharacterString"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </gco:CharacterString>
                        </gmd:code>
                        <gmd:codeSpace>
                            <gco:CharacterString>
                                <xsl:choose>
                                    <xsl:when
                                            test="gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:codeSpace/gco:CharacterString">
                                        <xsl:value-of
                                                select="gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:codeSpace/gco:CharacterString"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </gco:CharacterString>
                        </gmd:codeSpace>
                    </gmd:RS_Identifier>
                </gmd:referenceSystemIdentifier>
            </gmd:MD_ReferenceSystem>
        </gmd:referenceSystemInfo>
    </xsl:template>

    <xsl:template match="/gmd:MD_Metadata/gmd:identificationInfo">
        <gmd:identificationInfo>
            <!-- Resource Service Identification -->
            <srv:SV_ServiceIdentification>
                <xsl:copy-of select="srv:SV_ServiceIdentification/gmd:citation"/>
                <xsl:copy-of select="srv:SV_ServiceIdentification/gmd:abstract"/>
                <xsl:copy-of select="srv:SV_ServiceIdentification/gmd:purpose"/>
                <gmd:status>
                    <xsl:choose>
                        <xsl:when
                                test="srv:SV_ServiceIdentification/gmd:status/gmd:MD_ProgressCode">
                            <xsl:copy-of
                                    select="srv:SV_ServiceIdentification/gmd:status/gmd:MD_ProgressCode"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <gmd:MD_ProgressCode
                                    codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#MD_ProgressCode"
                                    codeListValue="completed">completed
                            </gmd:MD_ProgressCode>
                        </xsl:otherwise>
                    </xsl:choose>
                </gmd:status>
                <xsl:copy-of select="srv:SV_ServiceIdentification/gmd:pointOfContact"/>
                <xsl:copy-of select="srv:SV_ServiceIdentification/gmd:resourceMaintenance"/>
                <xsl:copy-of select="srv:SV_ServiceIdentification/gmd:graphicOverview"/>
                <xsl:copy-of select="srv:SV_ServiceIdentification/gmd:descriptiveKeywords"/>
                <xsl:copy-of
                        select="srv:SV_ServiceIdentification/gmd:resourceSpecificUsage"/>
                <xsl:copy-of select="srv:SV_ServiceIdentification/gmd:resourceConstraints"/>
                <xsl:copy-of select="srv:SV_ServiceIdentification/gmd:aggregationInfo"/>
                <xsl:copy-of select="srv:SV_ServiceIdentification/srv:serviceType"/>
                <xsl:copy-of select="srv:SV_ServiceIdentification/srv:serviceTypeVersion"/>
                <xsl:copy-of select="srv:SV_ServiceIdentification/srv:accessProperties"/>
                <xsl:copy-of select="srv:SV_ServiceIdentification/srv:extent"/>
                <xsl:copy-of select="srv:SV_ServiceIdentification/srv:coupledResource"/>
                <xsl:copy-of select="srv:SV_ServiceIdentification/srv:couplingType"/>
                <xsl:copy-of select="srv:SV_ServiceIdentification/srv:containsOperations"/>
                <xsl:copy-of select="srv:SV_ServiceIdentification/srv:operatesOn"/>
            </srv:SV_ServiceIdentification>
        </gmd:identificationInfo>
    </xsl:template>

</xsl:stylesheet>
			