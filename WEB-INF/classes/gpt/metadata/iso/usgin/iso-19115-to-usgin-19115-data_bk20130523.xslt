<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="fn azgs1 azgs2 ns2 xs xsi xsl usgin csw"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.isotc211.org/2005/gmd"
	xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco"
	xmlns:gml="http://www.opengis.net/gml" xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:csw="http://www.opengis.net/cat/csw/2.0.2"
	xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:gmx="http://www.isotc211.org/2005/gmx"
	xmlns:gmi="http://www.isotc211.org/2005/gmi"
	xmlns:usgin="http://resources.usgin.org/xslt/ISO2USGINISO"
	xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:ns2="http://azgs.az.gov/2010/metadata/generator"
	xmlns:azgs1="http://azgs.az.gov/2010/metadata/template/v-1-2"
	xmlns:azgs2="http://azgs.az.gov/2010/metadata/source/v-1-3"
	xsi:schemaLocation="http://www.isotc211.org/2005/gmd http://schemas.opengis.net/csw/2.0.2/profiles/apiso/1.0.0/apiso.xsd">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<!--  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"
        exclude-result-prefixes="fn azgs1 azgs2 ns2 xs xsi xsl usgin csw"/>
-->
	<!-- unused namespaces...
          xmlns:exslt="http://exslt.org/common"  xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:usgin="http://resources.usgin.org/xslt/ISO2USGINISO" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ns2="http://azgs.az.gov/2010/metadata/generator" xmlns:azgs1="http://azgs.az.gov/2010/metadata/template/v-1-2" xmlns:azgs2="http://azgs.az.gov/2010/metadata/source/v-1-3"
      -->
	<!-- This xslt transforms an ISO19139 XML metadata record to conform to requirements of USGIN
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
		<gmd:MD_Metadata
			xsi:schemaLocation="http://www.isotc211.org/2005/gmd http://schemas.opengis.net/csw/2.0.2/profiles/apiso/1.0.0/apiso.xsd"
			xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:gml="http://www.opengis.net/gml"
			xmlns:xlink="http://www.w3.org/1999/xlink"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			<!-- exclude-result-prefixes="gco csw xs xsi xsl usgin csw" -->
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
					<xsl:apply-templates select="$var_InputRootNode/gmd:language"
						mode="no-namespaces"/>
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
			<gmd:characterSet>
			   <xsl:comment>no character set element in source metadata, USGIN XSLT inserted default value</xsl:comment>
				<gmd:MD_CharacterSetCode
					codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode "
					codeListValue="utf8">UTF-8</gmd:MD_CharacterSetCode>
			</gmd:characterSet>

			<!-- hierarchyLevel defaults to dataset -->

			<gmd:hierarchyLevel>
				<xsl:comment>no hierarchyLevel in source metadata, USGIN XSLT inserted default value</xsl:comment>
				<gmd:MD_ScopeCode
					codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#MD_ScopeCode"
					codeListValue="Dataset">dataset</gmd:MD_ScopeCode>
			</gmd:hierarchyLevel>
			<!-- copy hierarchyLevelName -->
			<xsl:choose>
				<xsl:when test="$var_InputRootNode/gmd:hierarchyLevelName">
					<xsl:apply-templates select="$var_InputRootNode/gmd:hierarchyLevelName"
						mode="no-namespaces"/>
				</xsl:when>
				<xsl:otherwise>
					<gmd:hierarchyLevelName>
						  <xsl:comment>no hierarchyLevelName in source metadata, USGIN XSLT inserted default value</xsl:comment> 
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
							  <xsl:comment>no resource identifier in source metadata, USGIN XSLT uses citation ISBN</xsl:comment> 
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
			<!-- <xsl:copy-of select="$var_InputRootNode/gmd:locale"/>-->
			<xsl:apply-templates select="$var_InputRootNode/gmd:locale" mode="no-namespaces"/>
			<!--  <xsl:copy-of select="$var_InputRootNode/gmd:spatialRepresentationInfo"/>-->
			<xsl:apply-templates select="$var_InputRootNode/gmd:spatialRepresentationInfo"
				mode="no-namespaces"/>
			<!-- <xsl:copy-of select="$var_InputRootNode/gmd:referenceSystemInfo"/> -->
			<xsl:apply-templates select="$var_InputRootNode/gmd:referenceSystemInfo"
				mode="no-namespaces"/>
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
			<!--   <xsl:copy-of select="$var_InputRootNode/gmd:dataQualityInfo"/>-->
			<xsl:apply-templates select="$var_InputRootNode/gmd:dataQualityInfo"
				mode="no-namespaces"/>
			<!--    <xsl:copy-of select="$var_InputRootNode/gmd:portrayalCatalogueInfo"/>-->
			<xsl:apply-templates select="$var_InputRootNode/gmd:portrayalCatalogueInfo"
				mode="no-namespaces"/>
			<!--    <xsl:copy-of select="$var_InputRootNode/gmd:metadataConstraints"/>-->
			<xsl:apply-templates select="$var_InputRootNode/gmd:metadataConstraints"
				mode="no-namespaces"/>
			<!--  <xsl:copy-of select="$var_InputRootNode/gmd:applicationSchemaInfo"/>-->
			<xsl:apply-templates select="$var_InputRootNode/gmd:applicationSchemaInfo"
				mode="no-namespaces"/>
			<!--           <xsl:for-each select="$var_InputRootNode/gmd:metadataMaintenance">  -->
			<gmd:metadataMaintenance>
				<gmd:MD_MaintenanceInformation>
					<xsl:choose>
						<xsl:when
							test="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency">
							<!--   <xsl:copy-of select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency"/>-->
							<xsl:apply-templates
								select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency"
								mode="no-namespaces"/>
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
					<!--<xsl:copy-of select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:dateOfNextUpdate"/>-->
					<xsl:apply-templates
						select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:dateOfNextUpdate"
						mode="no-namespaces"/>
					<!-- <xsl:copy-of select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:userDefinedMaintenanceFrequency"/>-->
					<xsl:apply-templates
						select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:userDefinedMaintenanceFrequency"
						mode="no-namespaces"/>
					<!-- <xsl:copy-of
                        select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:updateScope"/>-->
					<xsl:apply-templates
						select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:updateScope"
						mode="no-namespaces"/>
					<!--  <xsl:copy-of
                        select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:updateScopeDescription"/>-->
					<xsl:apply-templates
						select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:updateScopeDescription"
						mode="no-namespaces"/>
					<!--<xsl:copy-of select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceNote"/>-->
					<xsl:apply-templates
						select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceNote"
						mode="no-namespaces"/>
					<!-- add a note that the record has been processed by this xslt -->
					<gmd:maintenanceNote>
						<gco:CharacterString>
							<xsl:value-of
								select="concat($metadataMaintenanceNote, '2013-04-04T12:00:00')"/>
						</gco:CharacterString>
					</gmd:maintenanceNote>
					<!--  <xsl:copy-of
                        select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:contact"
                    />-->
					<xsl:apply-templates
						select="$var_InputRootNode/gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:contact"
						mode="no-namespaces"/>
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
			<gmd:positionName>
				<gco:CharacterString>
					<xsl:choose>
						<xsl:when test="$inputParty/gmd:positionName">
							<xsl:value-of select="$inputParty/gmd:positionName/gco:CharacterString"
							/>
						</xsl:when>
						<xsl:otherwise>missing</xsl:otherwise>
					</xsl:choose>
				</gco:CharacterString>
			</gmd:positionName>
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
							<!-- <xsl:copy-of
                                select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:facsimile"
                            />-->
							<xsl:apply-templates
								select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:facsimile/gco:CharacterString"
								mode="no-namespaces"/>
						</gmd:CI_Telephone>
					</gmd:phone>
					<gmd:address>
						<gmd:CI_Address>
							<gmd:deliveryPoint>
								<gco:CharacterString>
									<xsl:choose>
										<xsl:when
											test="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:deliveryPoint/gco:CharacterString">
											<xsl:value-of
												select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:deliveryPoint/gco:CharacterString"/>

										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="Missing"/>
										</xsl:otherwise>
									</xsl:choose>
								</gco:CharacterString>
							</gmd:deliveryPoint>
							<gmd:city>
								<gco:CharacterString>

									<xsl:choose>
										<xsl:when
											test="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:city/gco:CharacterString">
											<xsl:value-of
												select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:city/gco:CharacterString"/>

										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="Missing"/>
										</xsl:otherwise>
									</xsl:choose>
								</gco:CharacterString>
							</gmd:city>
							<gmd:administrativeArea>
								<gco:CharacterString>
									<xsl:choose>
										<xsl:when
											test="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:administrativeArea/gco:CharacterString">
											<xsl:value-of
												select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:administrativeArea/gco:CharacterString"
											/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="Missing"/>
										</xsl:otherwise>
									</xsl:choose>
								</gco:CharacterString>
							</gmd:administrativeArea>
							<gmd:postalCode>
								<gco:CharacterString>
									<xsl:choose>
										<xsl:when
											test="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:postalCode/gco:CharacterString">
											<xsl:value-of
												select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:postalCode/gco:CharacterString"
											/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="Missing"/>
										</xsl:otherwise>
									</xsl:choose>
								</gco:CharacterString>
							</gmd:postalCode>
							<gmd:country>
								<gco:CharacterString>
									<xsl:choose>
										<xsl:when
											test="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:country/gco:CharacterString">
											<xsl:value-of
												select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:country/gco:CharacterString"
											/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="Missing"/>
										</xsl:otherwise>
									</xsl:choose>
								</gco:CharacterString>
							</gmd:country>
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
					<gmd:onlineResource>
						<gmd:CI_OnlineResource>
							<gmd:linkage>
								<gmd:URL>
									<xsl:choose>
										<xsl:when
											test="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL">
											<xsl:value-of
												select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL"
											/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="missing"/>
										</xsl:otherwise>
									</xsl:choose>
								</gmd:URL>
							</gmd:linkage>
						</gmd:CI_OnlineResource>
					</gmd:onlineResource>
					<!-- <xsl:copy-of
                        select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource"/>-->

					<!-- <xsl:copy-of
                        select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:hoursOfService"/>-->
					<xsl:apply-templates
						select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:hoursOfService"
						mode="copy-no-namespaces"/>
					<!--   <xsl:copy-of
                        select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:contactInstructions"
                    />-->
					<xsl:apply-templates
						select="$inputParty/gmd:contactInfo/gmd:CI_Contact/gmd:contactInstructions"
						mode="copy-no-namespaces"/>
				</gmd:CI_Contact>
			</gmd:contactInfo>
			<gmd:role>
				<gmd:CI_RoleCode
					codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#CI_RoleCode"
					codeListValue="pointOfContact">pointOfContact</gmd:CI_RoleCode>
			</gmd:role>


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
							<gco:CharacterString>
								<xsl:value-of
									select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:title"/>
							</gco:CharacterString>
						</gmd:title>
						<!-- Keeping the title from being indented correctly-->

						<!--  <xsl:copy-of
                            select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:alternateTitle"/>-->
						<!--	<xsl:apply-templates select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:alternateTitle" mode="no-namespaces"/>-->
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
						<!-- <xsl:copy-of select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:edition"/>-->
						<xsl:apply-templates
							select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:edition"
							mode="no-namespaces"/>
						<!-- <xsl:copy-of
                            select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:editionDate"/>-->
						<xsl:apply-templates
							select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:editionDate"
							mode="no-namespaces"/>
						<!--   <xsl:copy-of select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:identifier"/>-->
						<xsl:apply-templates
							select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:identifier"
							mode="no-namespaces"/>
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
						<xsl:apply-templates
							select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:presentationForm"
							mode="no-namespaces"/>
						<xsl:apply-templates
							select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:series"
							mode="no-namespaces"/>
						<xsl:apply-templates
							select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:otherCitationDetails"
							mode="no-namespaces"/>
						<xsl:apply-templates
							select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:collectiveTitle"
							mode="no-namespaces"/>
						<xsl:apply-templates
							select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:ISBN"
							mode="no-namespaces"/>
						<xsl:apply-templates
							select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:ISSN"
							mode="no-namespaces"/>
					</gmd:CI_Citation>
				</gmd:citation>
				<!--<xsl:apply-templates select="$inputInfo/gmd:citation/gmd:CI_Citation/gmd:identifier" mode="no-namespaces"/>-->
				<xsl:apply-templates select="$inputInfo/gmd:abstract" mode="no-namespaces"/>
				<xsl:apply-templates select="$inputInfo/gmd:purpose" mode="no-namespaces"/>
				<xsl:apply-templates select="$inputInfo/gmd:credit" mode="no-namespaces"/>
				<xsl:apply-templates select="$inputInfo/gmd:status" mode="no-namespaces"/>
				<xsl:apply-templates select="$inputInfo/gmd:pointOfContact" mode="no-namespaces"/>
				<xsl:apply-templates select="$inputInfo/gmd:resourceMaintenance"
					mode="no-namespaces"/>
				<!--          USGIN puts format information in distributionFormat 
         <xsl:copy-of select="$inputInfo/gmd:resourceFormat" copy-namespaces="no"/>  -->





				<xsl:copy-of select="$inputInfo/gmd:descriptiveKeywords"/>


				<xsl:apply-templates select="$inputInfo/gmd:resourceSpecificUsage"
					mode="no-namespaces"/>
				<xsl:apply-templates select="$inputInfo/gmd:resourceConstraints"
					mode="no-namespaces"/>
				<xsl:apply-templates select="$inputInfo/gmd:aggregationInfo" mode="no-namespaces"/>
				<!-- elements from MD_DataIdentification -->
				<xsl:apply-templates select="$inputInfo/gmd:spatialRepresentationType"
					mode="no-namespaces"/>
				<xsl:apply-templates select="$inputInfo/gmd:spatialResolution" mode="no-namespaces"/>
				<xsl:apply-templates select="$inputInfo/gmd:language" mode="no-namespaces"/>
				<!-- characterSet defaults to UTF-8 if no character set is specified -->
				<xsl:choose>
					<xsl:when test="$inputInfo/gmd:characterSet">
						<xsl:apply-templates select="$inputInfo/gmd:characterSet"
							mode="no-namespaces"/>
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
						<xsl:apply-templates select="$inputInfo/gmd:topicCategory"
							mode="no-namespaces"/>
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
				<xsl:apply-templates select="$inputInfo/gmd:environmentDescription"
					mode="no-namespaces"/>
				<!-- Get all the extent information. Have to make sure temporal extent gml:timePeriod 
                    is used and has gml:id   -->
				<xsl:for-each select="$inputInfo/gmd:extent/gmd:EX_Extent/gmd:geographicElement">
					<!-- might have a description, and a geoboundingbox or a polygon -->
					<gmd:extent>
						<gmd:EX_Extent>
							<xsl:if test="$inputInfo/gmd:extent/gmd:EX_Extent/gmd:description">
								<gmd:description>
									<gco:CharacterString>
										<xsl:value-of
											select="$inputInfo/gmd:extent/gmd:EX_Extent/gmd:description/gco:CharacterString"
										/>
									</gco:CharacterString>
								</gmd:description>
							</xsl:if>
							<!-- probably could be copy-of... -->
							<xsl:if test="gmd:EX_GeographicBoundingBox">
								<gmd:geographicElement>
									<gmd:EX_GeographicBoundingBox>
										<gmd:extentTypeCode>
											<gco:Boolean>
												<xsl:value-of
												select="gmd:EX_GeographicBoundingBox/gmd:extentTypeCode/gco:Boolean"
												/>
											</gco:Boolean>
										</gmd:extentTypeCode>
										<gmd:westBoundLongitude>
											<gco:Decimal>
												<xsl:value-of
												select="gmd:EX_GeographicBoundingBox/gmd:westBoundLongitude/gco:Decimal"
												/>
											</gco:Decimal>
										</gmd:westBoundLongitude>
										<gmd:eastBoundLongitude>
											<gco:Decimal>
												<xsl:value-of
												select="gmd:EX_GeographicBoundingBox/gmd:eastBoundLongitude/gco:Decimal"
												/>
											</gco:Decimal>
										</gmd:eastBoundLongitude>
										<gmd:southBoundLatitude>
											<gco:Decimal>
												<xsl:value-of
												select="gmd:EX_GeographicBoundingBox/gmd:southBoundLatitude/gco:Decimal"
												/>
											</gco:Decimal>
										</gmd:southBoundLatitude>
										<gmd:northBoundLatitude>
											<gco:Decimal>
												<xsl:value-of
												select="gmd:EX_GeographicBoundingBox/gmd:northBoundLatitude/gco:Decimal"
												/>
											</gco:Decimal>
										</gmd:northBoundLatitude>
									</gmd:EX_GeographicBoundingBox>
								</gmd:geographicElement>
							</xsl:if>
							<xsl:if test="gmd:EX_BoundingPolygon">
								<gmd:geographicElement>
									<xsl:apply-templates select="gmd:EX_BoundingPolygon"
										mode="no-namespaces"/>
								</gmd:geographicElement>
							</xsl:if>
						</gmd:EX_Extent>
					</gmd:extent>
				</xsl:for-each>
				<!-- end of geographicElement handler -->
				<!-- gmd:geographicElement/gmd:EX_GeographicDescription code values are copied into the
                keywords.type = 'place' group -->
				<xsl:for-each select="$inputInfo/gmd:extent/gmd:EX_Extent/gmd:temporalElement">
					<xsl:call-template name="usgin:temporalElement">
						<xsl:with-param name="thetempelem" select="."/>
						<xsl:with-param name="gmlid" select="concat('a',string(generate-id()))"/>
					</xsl:call-template>
					<!-- do this with a template because its a mess, and we want it to be reusable -->
				</xsl:for-each>
				<!-- gmd:minvalue maxvalue are required-->
				<xsl:for-each select="$inputInfo/gmd:extent/gmd:EX_Extent/gmd:verticalElement">
				<xsl:if test="(gmd:extent/gmd:EX_Extent/gmd:verticalElement/gmd:minimumValue) and (gmd:extent/gmd:EX_Extent/gmd:verticalElement/gmd:maximumValue)">
					<gmd:extent>
						<gmd:EX_Extent>
							<xsl:apply-templates select="." mode="no-namespaces"/>
							
							<!-- <xsl:copy-of select="."/> -->
						</gmd:EX_Extent>
					</gmd:extent>
					</xsl:if>
				</xsl:for-each>
				
				
				<xsl:apply-templates select="$inputInfo/gmd:supplementalInformation"
					mode="no-namespaces"/>
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
				<xsl:apply-templates
					select="$inputDistro/gmd:MD_Distribution/gmd:distributionFormat"
					mode="no-namespaces"/>
				<!-- if there is a MD_DataIdentification/resourceFormat, put that in here-->
				<xsl:for-each select="//gmd:MD_DataIdentification/gmd:resourceFormat">
					<gmd:distributionFormat>
						<xsl:apply-templates select="gmd:MD_Format" mode="no-namespaces"/>
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
							<xsl:apply-templates
								select="gmd:MD_Distributor/gmd:distributionOrderProcess"
								mode="no-namespaces"/>
							<xsl:apply-templates select="gmd:MD_Distributor/gmd:distributorFormat"
								mode="no-namespaces"/>
							<xsl:apply-templates
								select="gmd:MD_Distributor/gmd:distributorTransferOptions"
								mode="no-namespaces"/>
						</gmd:MD_Distributor>
					</gmd:distributor>
				</xsl:for-each>
				<!-- end of iteration over distributors -->
				<!-- accomodate metadata that has all transfer options in distributorTransferOptions
                 put the first TransferOptions link into MD_Distribtuion/gmd:transferOptions -->
				<xsl:choose>
					<xsl:when test="$inputDistro/gmd:MD_Distribution/gmd:transferOptions">
						<xsl:apply-templates
							select="$inputDistro/gmd:MD_Distribution/gmd:transferOptions"
							mode="no-namespaces"/>
					</xsl:when>
					<xsl:otherwise>
						<!-- copy in the first distributor transfer options -->
						<xsl:if
							test="$inputDistro/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorTransferOptions">
							<gmd:transferOptions>
								<!-- <xsl:comment>USGIN XSLT copies first distributorTransferOption here for clients that expect transferOptions</xsl:comment> -->
								<xsl:apply-templates
									select="$inputDistro/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorTransferOptions[1]/gmd:MD_DigitalTransferOptions"
									mode="no-namespaces"/>
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
												<xsl:value-of select="."/>
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
											<xsl:apply-templates
												select="srv:connectPoint/gmd:CI_OnlineResource/gmd:description"
												mode="no-namespaces"/>
											<xsl:apply-templates
												select="srv:connectPoint/gmd:CI_OnlineResource/gmd:function"
												mode="no-namespaces"/>
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
					<!-- Leah please fix these tests should be string-length(normalize-space(string($inputDate/gco:DateTime))) -->
					<xsl:when test="(normalize-space(string($inputDate/gco:DateTime))&gt;17)">
						<xsl:value-of select="$inputDate/gco:DateTime"/>
					</xsl:when>
					<xsl:when test="string-length($inputDate/gco:DateTime)=10">
						<xsl:value-of select="concat($inputDate/gco:DateTime,'T12:00:00Z')"/>
					</xsl:when>
					<xsl:when
						test="string-length(normalize-space(string($inputDate/gco:DateTime)))=11">
						<xsl:value-of
							select="concat(normalize-space(string($inputDate/gco:DateTime)),'00:00Z')"
						/>
					</xsl:when>
					<xsl:when
						test="string-length(normalize-space(string($inputDate/gco:DateTime)))=14">
						<xsl:value-of select="concat($inputDate/gco:DateTime,':00Z')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="string('1900-01-01T12:00:00Z')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- end of gco:dateTime handler -->
			<xsl:otherwise>
				<xsl:value-of select="string('1900-01-01T12:00:00Z')"/>
			</xsl:otherwise>
		</xsl:choose>
		<!-- end of inputDate handler -->
	</xsl:template>
	<xsl:template name="usgin:temporalElement">
		<xsl:param name="thetempelem"/>
		<xsl:param name="gmlid"/>
		<!-- have to process possible incoming TimeInstant or TimePeriod-->
		<!-- if its a TimeInstant, copy the gml:timePosition into gml:beginPosition and gml:endPosition
    of the gml:TimePeriod
    Also have to make sure that TimePeriod has a gml:id -->
		<gmd:extent>
			<gmd:EX_Extent>
				<gmd:temporalElement>
					<!-- note that a gmd:EX_SpatialTemporalExtent might show up here; we're just going to
                pull the temporal part of that here-->
					<gmd:EX_TemporalExtent>
						<!-- temporal extent could be a gemetric primitive (TimeInstant or TimePeriod
                    or a topologic primitive (TimeNote or TimeEdge); we're not handling topologic time -->
						<xsl:choose>
							<xsl:when test="gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod">
								<gmd:extent>
									<gml:TimePeriod>
										<xsl:choose>
											<xsl:when
												test="gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/@gml:id">
												<xsl:attribute name="gml:id">
													<xsl:value-of select="gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/@gml:id"/>
												</xsl:attribute>
											</xsl:when>
											<xsl:otherwise>
												<xsl:attribute name="gml:id">
												<xsl:value-of select="$gmlid"/>
												</xsl:attribute>
											</xsl:otherwise>
										</xsl:choose>
										<gml:name/>
										<gml:beginPosition>
											<xsl:variable name="btpos">
												<xsl:value-of
												select="gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:beginPosition"
												/>
											</xsl:variable>
											<xsl:choose>
												<xsl:when
												test="(string-length(normalize-space(string($btpos)))&gt;17)">
												<xsl:attribute name="frame">
												<xsl:value-of select="'#ISO-8601'"/>
												</xsl:attribute>
												<xsl:value-of select="$btpos"/>
												</xsl:when>
												<xsl:when
												test="string-length(normalize-space(string($btpos)))=10">
												<xsl:attribute name="frame">
												<xsl:value-of select="'#ISO-8601'"/>
												</xsl:attribute>
												<xsl:value-of select="concat($btpos,'T12:00:00Z')"
												/>
												</xsl:when>
												<xsl:when
												test="string-length(normalize-space(string($btpos)))=11">
												<xsl:attribute name="frame">
												<xsl:value-of select="'#ISO-8601'"/>
												</xsl:attribute>
												<xsl:value-of
												select="concat(normalize-space(string($btpos)),'00:00Z')"
												/>
												</xsl:when>
												<xsl:when
												test="string-length(normalize-space(string($btpos)))=14">
												<xsl:attribute name="frame">
												<xsl:value-of select="'#ISO-8601'"/>
												</xsl:attribute>
												<xsl:value-of select="concat($btpos,':00Z')"/>
												</xsl:when>
												<xsl:otherwise>
												<!-- can't match format with 8601...-->
												<xsl:attribute name="indeterminatePosition">
												<xsl:value-of select="'unknown'"/>
												</xsl:attribute>
												<xsl:value-of
												select="string('1900-01-01T12:00:00Z')"/>
												</xsl:otherwise>
											</xsl:choose>
										</gml:beginPosition>
										<gml:endPosition>
											<xsl:variable name="etpos"
												select="gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:endPosition"/>
											<xsl:choose>
												<xsl:when
												test="(string-length(normalize-space(string($etpos)))&gt;17)">
												<!-- full 8601 with time zone (at least we're guessing that for now... -->
												<xsl:attribute name="frame">
												<xsl:value-of select="'#ISO-8601'"/>
												</xsl:attribute>
												<xsl:value-of select="$etpos"/>
												</xsl:when>
												<xsl:when
												test="string-length(normalize-space(string($etpos)))=10">
												<xsl:attribute name="frame">
												<xsl:value-of select="'#ISO-8601'"/>
												</xsl:attribute>
												<xsl:value-of select="concat($etpos,'T12:00:00Z')"
												/>
												</xsl:when>
												<xsl:when
												test="string-length(normalize-space(string($etpos)))=11">
												<xsl:attribute name="frame">
												<xsl:value-of select="'#ISO-8601'"/>
												</xsl:attribute>
												<xsl:value-of
												select="concat(normalize-space(string($etpos)),'00:00Z')"
												/>
												</xsl:when>
												<xsl:when
												test="string-length(normalize-space(string($etpos)))=14">
												<xsl:attribute name="frame">
												<xsl:value-of select="'#ISO-8601'"/>
												</xsl:attribute>
												<xsl:value-of select="concat($etpos,':00Z')"/>
												</xsl:when>
												<xsl:otherwise>
												<!-- can't match format with 8601...-->
												<xsl:attribute name="indeterminatePosition">
												<xsl:value-of select="'gml:id'"/>
												</xsl:attribute>
												<xsl:value-of
												select="string('1900-01-01T12:00:00Z')"/>
												</xsl:otherwise>
											</xsl:choose>
										</gml:endPosition>
									</gml:TimePeriod>
								</gmd:extent>
							</xsl:when>
							<xsl:when test="gmd:EX_TemporalExtent/gmd:extent/gml:TimeInstant">
								<gmd:extent>
									<gml:TimePeriod>
										<xsl:attribute name="gml:id">
											<xsl:value-of select="$gmlid"/>
										</xsl:attribute>
										<gml:name>Time instant in original data, converted to period
											with same start and end</gml:name>
										<xsl:variable name="tpos">
											<xsl:variable name="tinst">
												<xsl:value-of
												select="gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:timePosition"
												/>
											</xsl:variable>
											<xsl:choose>
												<xsl:when
												test="(string-length(normalize-space(string($tinst)))&gt;18)">
												<xsl:value-of select="$tinst"/>
												</xsl:when>
												<xsl:when
												test="string-length(normalize-space(string($tinst)))=10">
												<xsl:value-of select="concat($tinst,'T12:00:00Z')"
												/>
												</xsl:when>
												<xsl:when
												test="string-length(normalize-space(string($tinst)))=11">
												<xsl:value-of
												select="concat(normalize-space(string($tinst)),'00:00Z')"
												/>
												</xsl:when>
												<xsl:when
												test="string-length(normalize-space(string($tinst)))=14">
												<xsl:value-of select="concat($tinst,':00Z')"/>
												</xsl:when>
												<xsl:otherwise>
												<!-- can't match format with 8601...-->
												<xsl:value-of
												select="string('1900-01-01T12:00:00Z')"/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<gml:beginPosition>
											<xsl:choose>
												<xsl:when test="$tpos ='1900-01-01T12:00:00Z'">
												<xsl:attribute name="indeterminatePosition">
												<xsl:value-of select="'unknown'"/>
												</xsl:attribute>
												</xsl:when>
												<xsl:otherwise>
												<xsl:attribute name="frame">
												<xsl:value-of select="'#ISO-8601'"/>
												</xsl:attribute>
												<xsl:value-of select="$tpos"/>
												</xsl:otherwise>
											</xsl:choose>
										</gml:beginPosition>
										<gml:endPosition>
											<xsl:choose>
												<xsl:when test="$tpos ='1900-01-01T12:00:00Z'">
												<xsl:attribute name="indeterminatePosition">
												<xsl:value-of select="'unknown'"/>
												</xsl:attribute>
												</xsl:when>
												<xsl:otherwise>
												<xsl:attribute name="frame">
												<xsl:value-of select="'#ISO-8601'"/>
												</xsl:attribute>
												<xsl:value-of select="$tpos"/>
												</xsl:otherwise>
											</xsl:choose>
										</gml:endPosition>
									</gml:TimePeriod>
								</gmd:extent>
							</xsl:when>
							<!-- gmd:EX_TemporalExtent/gmd:extent/gml:TimeNode | gmd:EX_TemporalExtent/gmd:extent/gml:TimeEdge 
                        will catch on otherwise-->
							<xsl:otherwise>
								<gmd:extent>
									<xsl:attribute name="gml:nilReason">
										<xsl:value-of select="'Missing'"/>
									</xsl:attribute>
								</gmd:extent>
								<xsl:comment>temporal extent in original metadata specified with gml:TimeNode, gml:TimeEdge, or other unhandled time representation</xsl:comment>
							</xsl:otherwise>
						</xsl:choose>
					</gmd:EX_TemporalExtent>
				</gmd:temporalElement>
			</gmd:EX_Extent>
		</gmd:extent>
	</xsl:template>
	<!-- generate a new element in the same namespace as the matched element,
     copying its attributes, but without copying its unused namespace nodes,
     then continue processing content in the "copy-no-namepaces" mode -->
	<xsl:template match="*" mode="copy-no-namespaces">
		<xsl:element name="{local-name()}" namespace="{namespace-uri()}">
			<xsl:apply-templates select="@*" mode="copy-no-namespaces"/>
			<xsl:apply-templates select="node()" mode="copy-no-namespaces"/>
		</xsl:element>
	</xsl:template>
	<!-- copy element with namespace prefix, don't put any namespace URI's in
	the output, assume all namespace prefixes are declared  -->
	<xsl:template match="*" mode="no-namespaces">
		<xsl:element name="{name()}">
			<xsl:apply-templates select="@*" mode="no-namespaces"/>
			<xsl:apply-templates select="node()" mode="no-namespaces"/>
		</xsl:element>
	</xsl:template>
	<!-- add attributes -->
	<xsl:template match="@*" mode="no-namespaces">
		<xsl:attribute name="{name()}">
			<xsl:value-of select="string(.)"/>
		</xsl:attribute>
	</xsl:template>
	<xsl:template match="comment()| processing-instruction()" mode="no-namespaces">
		<xsl:copy/>
	</xsl:template>
</xsl:stylesheet>
