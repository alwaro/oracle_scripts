
ALTER TABLE TIBCO_GG.BUL_TMP DISABLE CONSTRAINT ELEMENTO_SINCRONIZADO_FK ;
ALTER TABLE TIBCO_GG.CLI_TMP DISABLE CONSTRAINT ELEMENTO_SINCRONIZADO_CLI_FK ;
ALTER TABLE TIBCO_GG.CPZ_TMP DISABLE CONSTRAINT ELEMENTO_SINCRONIZADO_CPZ_FK ;
ALTER TABLE TIBCO_GG.DEL_TMP DISABLE CONSTRAINT ELEMENTO_SINCRONIZADO_DEL_FK ;
ALTER TABLE TIBCO_GG.FTI_TMP DISABLE CONSTRAINT ELEMENTO_SINCRONIZADO_FTI_FK ;
ALTER TABLE TIBCO_GG.IDI_TMP DISABLE CONSTRAINT ELEMENTO_SINCRONIZADO_IDI_FK ;
ALTER TABLE TIBCO_GG.IMG_AZKAR_TMP DISABLE CONSTRAINT ELEMENTO_SINC_IMG_AZKAR_FK ;
ALTER TABLE TIBCO_GG.IMG_CLIENTE_TMP DISABLE CONSTRAINT ELEMENTO_SINC_IMG_CLIENTE_FK ;
ALTER TABLE TIBCO_GG.IMG_RECOGIDA_TMP DISABLE CONSTRAINT ELEMENTO_SINC_IMG_RECOGIDA_FK ;
ALTER TABLE TIBCO_GG.PAI_TMP DISABLE CONSTRAINT ELEMENTO_SINCRONIZADO_PAI_FK ;
ALTER TABLE TIBCO_GG.PLA_TMP DISABLE CONSTRAINT ELEMENTO_SINCRONIZADO_PLA_FK ;
ALTER TABLE TIBCO_GG.PROVEEDORES_TMP DISABLE CONSTRAINT ELEMENTO_SINCRONIZADO_PRO_FK ;
ALTER TABLE TIBCO_GG.RCH_TMP DISABLE CONSTRAINT ELEMENTO_SINCRONIZADO_RCH_FK ;
ALTER TABLE TIBCO_GG.RCL_TMP DISABLE CONSTRAINT ELEMENTO_SINCRONIZADO_RCL_FK ;
ALTER TABLE TIBCO_GG.RCO_INCIDENCIAS_TMP DISABLE CONSTRAINT ELEMENTO_SINCRONIZADO_R_INC_FK ;
ALTER TABLE TIBCO_GG.RCO_TMP DISABLE CONSTRAINT ELEMENTO_SINCRONIZADO_RCO_FK ;
ALTER TABLE TIBCO_GG.REF_TMP DISABLE CONSTRAINT ELEMENTO_SINCRONIZADO_REF_FK ;
ALTER TABLE TIBCO_GG.RHO_TMP DISABLE CONSTRAINT ELEMENTO_SINCRONIZADO_RHO_FK ;
ALTER TABLE TIBCO_GG.ZON_TMP DISABLE CONSTRAINT ELEMENTO_SINCRONIZADO_ZON_FK ;
ALTER TABLE TIBCO_GG.BC_HIBERNATION_BIN DISABLE CONSTRAINT BC_HIBREF ;
ALTER TABLE TIBCO_GG.BC_LOGQUERYBIN DISABLE CONSTRAINT BC_LOGQUERY ;
ALTER TABLE TIBCO_GG.BCQUEUE_BIN_TABLE DISABLE CONSTRAINT QUEUE_BIN ;
ALTER TABLE TIBCO_GG.BC_SFWS_TPINFO DISABLE CONSTRAINT BC_SFWS_TPS ;
ALTER TABLE TIBCO_GG.BC_SFWS_ATTACHMENTS_BIN DISABLE CONSTRAINT ATTACHMENTS ;
ALTER TABLE TIBCO_GG.BC_MESSAGES DISABLE CONSTRAINT MESSAGES ;
ALTER TABLE TIBCO_GG.BC_MESSAGES_BIN DISABLE CONSTRAINT MESSAGES_BIN ;
ALTER TABLE TIBCO_GG.BC_RESEND_BIN DISABLE CONSTRAINT RESEND_BIN ;
ALTER TABLE TIBCO_GG.BC_ALERT DISABLE CONSTRAINT BC_ALERT ;
ALTER TABLE TIBCO_GG.BC_UACLOG_DETAIL DISABLE CONSTRAINT UACLOG_DTL ;
ALTER TABLE TIBCO_GG.BC_NR_MESSAGES DISABLE CONSTRAINT NR_MESSAGES ;
ALTER TABLE TIBCO_GG.BC_NR_BIN DISABLE CONSTRAINT BC_NR_BIN_MID ;
ALTER TABLE TIBCO_GG.BC_NR_BIN_SIGNATURE DISABLE CONSTRAINT BC_NR_BIN_SIG_MID ;
ALTER TABLE TIBCO_GG.BC_NR_BIN_VALICERT DISABLE CONSTRAINT BC_NR_BIN_VALICERT_MID ;
ALTER TABLE TIBCO_GG.BC_NR_BIN_SIGCRED DISABLE CONSTRAINT BC_NR_BIN_SIGCRED_MID ;
ALTER TABLE TIBCO_GG.BC_NR_BIN_EDCRED DISABLE CONSTRAINT BC_NR_BIN_EDCRED_MID ;
ALTER TABLE TIBCO_GG.TIBEDI_BATCH_TX DISABLE CONSTRAINT TIBEDI_BCH_TX_FKEY ;
ALTER TABLE TIBCO_GG.TIBEDI_BATCH_TX_BIN DISABLE CONSTRAINT TIBEDI_BCH_TX_BIN ;

TRUNCATE TABLE TIBCO_GG.CLI2_IE_IEC_TMP ;
TRUNCATE TABLE TIBCO_GG.CPZ_TMP ;
TRUNCATE TABLE TIBCO_GG.DACH_TRANSPORT_PLAN_TMP ;
TRUNCATE TABLE TIBCO_GG.DESTINOS_INT_TMP ;
TRUNCATE TABLE TIBCO_GG.DIVISAS_TMP ;
TRUNCATE TABLE TIBCO_GG.ELEMENTOSSINCRONIZADOS_ERR ;
TRUNCATE TABLE TIBCO_GG.ENRUTAMIENTO_INT_TMP ;
TRUNCATE TABLE TIBCO_GG.FTI_TMP ;
TRUNCATE TABLE TIBCO_GG.IDI_TMP ;
TRUNCATE TABLE TIBCO_GG.IMG_AZKAR ;
TRUNCATE TABLE TIBCO_GG.IMG_AZKAR_TMP ;
TRUNCATE TABLE TIBCO_GG.IMG_CLIENTE ;
TRUNCATE TABLE TIBCO_GG.IMG_CLIENTE_TMP ;
TRUNCATE TABLE TIBCO_GG.IMG_RECOGIDA ;
TRUNCATE TABLE TIBCO_GG.IMG_RECOGIDA_TMP ;
TRUNCATE TABLE TIBCO_GG.PAI_TMP ;
TRUNCATE TABLE TIBCO_GG.TOAD_PLAN_SQL ;
TRUNCATE TABLE TIBCO_GG.TOAD_PLAN_TABLE ;
TRUNCATE TABLE TIBCO_GG.TST_TMP ;
TRUNCATE TABLE TIBCO_GG.TSV_TST_PROVE_TMP ;
TRUNCATE TABLE TIBCO_GG.USR_INT_TMP ;
TRUNCATE TABLE TIBCO_GG.HOJ_TMP ;
TRUNCATE TABLE TIBCO_GG.CK_LOG ;
TRUNCATE TABLE TIBCO_GG.BC_DOMAINTYPE ;
TRUNCATE TABLE TIBCO_GG.BC_PCCODE ;
TRUNCATE TABLE TIBCO_GG.BC_SCCODE ;
TRUNCATE TABLE TIBCO_GG.BC_PARTICIPANT ;
TRUNCATE TABLE TIBCO_GG.BC_LOCATION ;
TRUNCATE TABLE TIBCO_GG.BC_DOMAINID ;
TRUNCATE TABLE TIBCO_GG.BC_BIZAGREEMENT ;
TRUNCATE TABLE TIBCO_GG.BC_CONTACT ;
TRUNCATE TABLE TIBCO_GG.BC_SECURITYINFO ;
TRUNCATE TABLE TIBCO_GG.BC_DOCEXCHANGE ;
TRUNCATE TABLE TIBCO_GG.BC_RB ;
TRUNCATE TABLE TIBCO_GG.BC_PB ;
TRUNCATE TABLE TIBCO_GG.BC_PBV ;
TRUNCATE TABLE TIBCO_GG.BC_OPB ;
TRUNCATE TABLE TIBCO_GG.BC_PROTOCOL ;
TRUNCATE TABLE TIBCO_GG.BC_GRAMMAR ;
TRUNCATE TABLE TIBCO_GG.BC_GMAUX_INFO ;
TRUNCATE TABLE TIBCO_GG.BC_ROLE ;
TRUNCATE TABLE TIBCO_GG.BC_INTFCOMPONENT ;
TRUNCATE TABLE TIBCO_GG.BC_MIGRATIONINFO ;
TRUNCATE TABLE TIBCO_GG.BC_ITEMCONSTRAINT ;
TRUNCATE TABLE TIBCO_GG.BC_EMAILMONIKER ;
TRUNCATE TABLE TIBCO_GG.BC_ALERT_INFO ;
TRUNCATE TABLE TIBCO_GG.BC_USER ;
TRUNCATE TABLE TIBCO_GG.BC_GROUP ;
TRUNCATE TABLE TIBCO_GG.BC_USER_GROUP_ASSIGNMENT ;
TRUNCATE TABLE TIBCO_GG.BC_USER_PERM_ASSIGNMENT ;
TRUNCATE TABLE TIBCO_GG.BC_GROUP_PERM_ASSIGNMENT ;
TRUNCATE TABLE TIBCO_GG.BC_QUERYINFO ;
TRUNCATE TABLE TIBCO_GG.BC_PARTNERVIEW ;
TRUNCATE TABLE TIBCO_GG.BC_RT_VERSION ;
TRUNCATE TABLE TIBCO_GG.BC_DB_LOCK ;
TRUNCATE TABLE TIBCO_GG.BC_MDN ;
TRUNCATE TABLE TIBCO_GG.BC_HIBERNATION ;
TRUNCATE TABLE TIBCO_GG.BC_HIBERNATION_BIN ;
TRUNCATE TABLE TIBCO_GG.BC_LOGVIEWQUERY ;
TRUNCATE TABLE TIBCO_GG.BC_AUDIT_VERSION ;
TRUNCATE TABLE TIBCO_GG.META_CLASS ;
TRUNCATE TABLE TIBCO_GG.META_PROPERTY ;
TRUNCATE TABLE TIBCO_GG.META_SUBCLASS ;
TRUNCATE TABLE TIBCO_GG.META_RELATION ;
TRUNCATE TABLE TIBCO_GG.BC_CS_LOCK ;
TRUNCATE TABLE TIBCO_GG.BC_UPLOADEDFILE ;
TRUNCATE TABLE TIBCO_GG.BC_SEQNO ;
TRUNCATE TABLE TIBCO_GG.BC_CHANNELINFO ;
TRUNCATE TABLE TIBCO_GG.BC_SMARTROUTERBASE ;
TRUNCATE TABLE TIBCO_GG.BC_SMARTROUTERITEM ;
TRUNCATE TABLE TIBCO_GG.BC_KEYSTOREITEM ;
TRUNCATE TABLE TIBCO_GG.BC_INSTALL_INFO ;
TRUNCATE TABLE TIBCO_GG.BC_SERVER_INFO ;
TRUNCATE TABLE TIBCO_GG.BC_PLUGIN_INFO ;
TRUNCATE TABLE TIBCO_GG.BC_PROXYINFO ;
TRUNCATE TABLE TIBCO_GG.BC_JDBCINFO ;
TRUNCATE TABLE TIBCO_GG.BC_LDAPINFO ;
TRUNCATE TABLE TIBCO_GG.BC_BOINFO ;
TRUNCATE TABLE TIBCO_GG.BC_DMZINFO ;
TRUNCATE TABLE TIBCO_GG.BC_ICINFO ;
TRUNCATE TABLE TIBCO_GG.BC_MONANDLOG ;
TRUNCATE TABLE TIBCO_GG.BC_DBMAP ;
TRUNCATE TABLE TIBCO_GG.BC_LOGQUERYBIN ;
TRUNCATE TABLE TIBCO_GG.BC_QUEUE ;
TRUNCATE TABLE TIBCO_GG.BCQUEUE_BIN_TABLE ;
TRUNCATE TABLE TIBCO_GG.BC_SCHEDULED_TASK ;
TRUNCATE TABLE TIBCO_GG.BC_SFWS_MESSAGES ;
TRUNCATE TABLE TIBCO_GG.BC_SFWS_TPINFO ;
TRUNCATE TABLE TIBCO_GG.BC_SFWS_ATTACHMENTS_BIN ;
TRUNCATE TABLE TIBCO_GG.TIBEDI_VERSION ;
TRUNCATE TABLE TIBCO_GG.TIBEDI_PLUGININFO ;
TRUNCATE TABLE TIBCO_GG.BC_TRANSACTIONS ;
TRUNCATE TABLE TIBCO_GG.BC_MESSAGES ;
TRUNCATE TABLE TIBCO_GG.BC_MESSAGES_BIN ;
TRUNCATE TABLE TIBCO_GG.BC_RESEND_BIN ;
TRUNCATE TABLE TIBCO_GG.BC_ALERT ;
TRUNCATE TABLE TIBCO_GG.BC_POLLER_INFO ;
TRUNCATE TABLE TIBCO_GG.BC_DUP ;
TRUNCATE TABLE TIBCO_GG.BC_LOGACL_TEMP ;
TRUNCATE TABLE TIBCO_GG.BC_UACLOG ;
TRUNCATE TABLE TIBCO_GG.BC_UACLOG_DETAIL ;
TRUNCATE TABLE TIBCO_GG.BC_NR_VERSION ;
TRUNCATE TABLE TIBCO_GG.BC_NR_TRANSACTIONS ;
TRUNCATE TABLE TIBCO_GG.BC_NR_MESSAGES ;
TRUNCATE TABLE TIBCO_GG.BC_NR_BIN ;
TRUNCATE TABLE TIBCO_GG.BC_NR_BIN_SIGNATURE ;
TRUNCATE TABLE TIBCO_GG.BC_NR_BIN_VALICERT ;
TRUNCATE TABLE TIBCO_GG.BC_NR_BIN_SIGCRED ;
TRUNCATE TABLE TIBCO_GG.BC_NR_BIN_EDCRED ;
TRUNCATE TABLE TIBCO_GG.TIBEDI_CONTROL_NUMBER ;
TRUNCATE TABLE TIBCO_GG.TIBEDI_ACK_RECONCILIATION ;
TRUNCATE TABLE TIBCO_GG.TIBEDI_CSUPDATE_CACHE ;
TRUNCATE TABLE TIBCO_GG.TIBEDI_BATCH_TASK ;
TRUNCATE TABLE TIBCO_GG.TIBEDI_BATCH_TX ;
TRUNCATE TABLE TIBCO_GG.TIBEDI_BATCH_TX_BIN ;
TRUNCATE TABLE TIBCO_GG.HES_TMP ;
TRUNCATE TABLE TIBCO_GG.RHO_TMP ;
TRUNCATE TABLE TIBCO_GG.RCH_TMP ;
TRUNCATE TABLE TIBCO_GG.PLA_TMP ;
TRUNCATE TABLE TIBCO_GG.RCO_INCIDENCIAS_TMP ;
TRUNCATE TABLE TIBCO_GG.TSV_TMP ;
TRUNCATE TABLE TIBCO_GG.BUL_TMP ;
TRUNCATE TABLE TIBCO_GG.FP_COD_TMP ;
TRUNCATE TABLE TIBCO_GG.ELEMENTOSSINCRONIZADOS ;
TRUNCATE TABLE TIBCO_GG.P_ELEMENTOSSINCRONIZADOS ;
TRUNCATE TABLE TIBCO_GG.RCO_TMP ;
TRUNCATE TABLE TIBCO_GG.CLI_TMP ;
TRUNCATE TABLE TIBCO_GG.REF_TMP ;
TRUNCATE TABLE TIBCO_GG.PROVEEDORES_TMP ;
TRUNCATE TABLE TIBCO_GG.ZON_TMP ;
TRUNCATE TABLE TIBCO_GG.RCL_TMP ;
TRUNCATE TABLE TIBCO_GG.DEL_TMP ;

ALTER TABLE TIBCO_GG.BUL_TMP ENABLE CONSTRAINT ELEMENTO_SINCRONIZADO_FK ;
ALTER TABLE TIBCO_GG.CLI_TMP ENABLE CONSTRAINT ELEMENTO_SINCRONIZADO_CLI_FK ;
ALTER TABLE TIBCO_GG.CPZ_TMP ENABLE CONSTRAINT ELEMENTO_SINCRONIZADO_CPZ_FK ;
ALTER TABLE TIBCO_GG.DEL_TMP ENABLE CONSTRAINT ELEMENTO_SINCRONIZADO_DEL_FK ;
ALTER TABLE TIBCO_GG.FTI_TMP ENABLE CONSTRAINT ELEMENTO_SINCRONIZADO_FTI_FK ;
ALTER TABLE TIBCO_GG.IDI_TMP ENABLE CONSTRAINT ELEMENTO_SINCRONIZADO_IDI_FK ;
ALTER TABLE TIBCO_GG.IMG_AZKAR_TMP ENABLE CONSTRAINT ELEMENTO_SINC_IMG_AZKAR_FK ;
ALTER TABLE TIBCO_GG.IMG_CLIENTE_TMP ENABLE CONSTRAINT ELEMENTO_SINC_IMG_CLIENTE_FK ;
ALTER TABLE TIBCO_GG.IMG_RECOGIDA_TMP ENABLE CONSTRAINT ELEMENTO_SINC_IMG_RECOGIDA_FK ;
ALTER TABLE TIBCO_GG.PAI_TMP ENABLE CONSTRAINT ELEMENTO_SINCRONIZADO_PAI_FK ;
ALTER TABLE TIBCO_GG.PLA_TMP ENABLE CONSTRAINT ELEMENTO_SINCRONIZADO_PLA_FK ;
ALTER TABLE TIBCO_GG.PROVEEDORES_TMP ENABLE CONSTRAINT ELEMENTO_SINCRONIZADO_PRO_FK ;
ALTER TABLE TIBCO_GG.RCH_TMP ENABLE CONSTRAINT ELEMENTO_SINCRONIZADO_RCH_FK ;
ALTER TABLE TIBCO_GG.RCL_TMP ENABLE CONSTRAINT ELEMENTO_SINCRONIZADO_RCL_FK ;
ALTER TABLE TIBCO_GG.RCO_INCIDENCIAS_TMP ENABLE CONSTRAINT ELEMENTO_SINCRONIZADO_R_INC_FK ;
ALTER TABLE TIBCO_GG.RCO_TMP ENABLE CONSTRAINT ELEMENTO_SINCRONIZADO_RCO_FK ;
ALTER TABLE TIBCO_GG.REF_TMP ENABLE CONSTRAINT ELEMENTO_SINCRONIZADO_REF_FK ;
ALTER TABLE TIBCO_GG.RHO_TMP ENABLE CONSTRAINT ELEMENTO_SINCRONIZADO_RHO_FK ;
ALTER TABLE TIBCO_GG.ZON_TMP ENABLE CONSTRAINT ELEMENTO_SINCRONIZADO_ZON_FK ;
ALTER TABLE TIBCO_GG.BC_HIBERNATION_BIN ENABLE CONSTRAINT BC_HIBREF ;
ALTER TABLE TIBCO_GG.BC_LOGQUERYBIN ENABLE CONSTRAINT BC_LOGQUERY ;
ALTER TABLE TIBCO_GG.BCQUEUE_BIN_TABLE ENABLE CONSTRAINT QUEUE_BIN ;
ALTER TABLE TIBCO_GG.BC_SFWS_TPINFO ENABLE CONSTRAINT BC_SFWS_TPS ;
ALTER TABLE TIBCO_GG.BC_SFWS_ATTACHMENTS_BIN ENABLE CONSTRAINT ATTACHMENTS ;
ALTER TABLE TIBCO_GG.BC_MESSAGES ENABLE CONSTRAINT MESSAGES ;
ALTER TABLE TIBCO_GG.BC_MESSAGES_BIN ENABLE CONSTRAINT MESSAGES_BIN ;
ALTER TABLE TIBCO_GG.BC_RESEND_BIN ENABLE CONSTRAINT RESEND_BIN ;
ALTER TABLE TIBCO_GG.BC_ALERT ENABLE CONSTRAINT BC_ALERT ;
ALTER TABLE TIBCO_GG.BC_UACLOG_DETAIL ENABLE CONSTRAINT UACLOG_DTL ;
ALTER TABLE TIBCO_GG.BC_NR_MESSAGES ENABLE CONSTRAINT NR_MESSAGES ;
ALTER TABLE TIBCO_GG.BC_NR_BIN ENABLE CONSTRAINT BC_NR_BIN_MID ;
ALTER TABLE TIBCO_GG.BC_NR_BIN_SIGNATURE ENABLE CONSTRAINT BC_NR_BIN_SIG_MID ;
ALTER TABLE TIBCO_GG.BC_NR_BIN_VALICERT ENABLE CONSTRAINT BC_NR_BIN_VALICERT_MID ;
ALTER TABLE TIBCO_GG.BC_NR_BIN_SIGCRED ENABLE CONSTRAINT BC_NR_BIN_SIGCRED_MID ;
ALTER TABLE TIBCO_GG.BC_NR_BIN_EDCRED ENABLE CONSTRAINT BC_NR_BIN_EDCRED_MID ;
ALTER TABLE TIBCO_GG.TIBEDI_BATCH_TX ENABLE CONSTRAINT TIBEDI_BCH_TX_FKEY ;
ALTER TABLE TIBCO_GG.TIBEDI_BATCH_TX_BIN ENABLE CONSTRAINT TIBEDI_BCH_TX_BIN ;

alter table TIBCO_GG.CLI2_IE_IEC_TMP drop primary key cascade;
alter table TIBCO_GG.DESTINOS_INT_TMP drop primary key cascade;
alter table TIBCO_GG.DIVISAS_TMP drop primary key cascade;
alter table TIBCO_GG.ELEMENTOSSINCRONIZADOS drop primary key cascade;
alter table TIBCO_GG.ELEMENTOSSINCRONIZADOS_ERR drop primary key cascade;
alter table TIBCO_GG.ENRUTAMIENTO_INT_TMP drop primary key cascade;
alter table TIBCO_GG.FP_COD_TMP drop primary key cascade;
alter table TIBCO_GG.TST_TMP drop primary key cascade;
alter table TIBCO_GG.TSV_TMP drop primary key cascade;
alter table TIBCO_GG.TSV_TST_PROVE_TMP drop primary key cascade;
alter table TIBCO_GG.USR_INT_TMP drop primary key cascade;
alter table TIBCO_GG.BC_DBMAP drop primary key cascade;
alter table TIBCO_GG.BC_DOMAINTYPE drop primary key cascade;
alter table TIBCO_GG.BC_PCCODE drop primary key cascade;
alter table TIBCO_GG.BC_SCCODE drop primary key cascade;
alter table TIBCO_GG.BC_PARTICIPANT drop primary key cascade;
alter table TIBCO_GG.BC_LOCATION drop primary key cascade;
alter table TIBCO_GG.BC_DOMAINID drop primary key cascade;
alter table TIBCO_GG.BC_BIZAGREEMENT drop primary key cascade;
alter table TIBCO_GG.BC_CONTACT drop primary key cascade;
alter table TIBCO_GG.BC_SECURITYINFO drop primary key cascade;
alter table TIBCO_GG.BC_DOCEXCHANGE drop primary key cascade;
alter table TIBCO_GG.BC_RB drop primary key cascade;
alter table TIBCO_GG.BC_PB drop primary key cascade;
alter table TIBCO_GG.BC_PBV drop primary key cascade;
alter table TIBCO_GG.BC_OPB drop primary key cascade;
alter table TIBCO_GG.BC_PROTOCOL drop primary key cascade;
alter table TIBCO_GG.BC_GRAMMAR drop primary key cascade;
alter table TIBCO_GG.BC_GMAUX_INFO drop primary key cascade;
alter table TIBCO_GG.BC_ROLE drop primary key cascade;
alter table TIBCO_GG.BC_INTFCOMPONENT drop primary key cascade;
alter table TIBCO_GG.BC_MIGRATIONINFO drop primary key cascade;
alter table TIBCO_GG.BC_ITEMCONSTRAINT drop primary key cascade;
alter table TIBCO_GG.BC_EMAILMONIKER drop primary key cascade;
alter table TIBCO_GG.BC_ALERT_INFO drop primary key cascade;
alter table TIBCO_GG.BC_USER drop primary key cascade;
alter table TIBCO_GG.BC_GROUP drop primary key cascade;
alter table TIBCO_GG.BC_USER_GROUP_ASSIGNMENT drop primary key cascade;
alter table TIBCO_GG.BC_USER_PERM_ASSIGNMENT drop primary key cascade;
alter table TIBCO_GG.BC_GROUP_PERM_ASSIGNMENT drop primary key cascade;
alter table TIBCO_GG.BC_QUERYINFO drop primary key cascade;
alter table TIBCO_GG.BC_PARTNERVIEW drop primary key cascade;
alter table TIBCO_GG.BC_DB_LOCK drop primary key cascade;
alter table TIBCO_GG.BC_MDN drop primary key cascade;
alter table TIBCO_GG.BC_HIBERNATION drop primary key cascade;
alter table TIBCO_GG.META_CLASS drop primary key cascade;
alter table TIBCO_GG.META_PROPERTY drop primary key cascade;
alter table TIBCO_GG.META_SUBCLASS drop primary key cascade;
alter table TIBCO_GG.META_RELATION drop primary key cascade;
alter table TIBCO_GG.BC_CS_LOCK drop primary key cascade;
alter table TIBCO_GG.BC_UPLOADEDFILE drop primary key cascade;
alter table TIBCO_GG.BC_SEQNO drop primary key cascade;
alter table TIBCO_GG.BC_CHANNELINFO drop primary key cascade;
alter table TIBCO_GG.BC_SMARTROUTERBASE drop primary key cascade;
alter table TIBCO_GG.BC_SMARTROUTERITEM drop primary key cascade;
alter table TIBCO_GG.BC_KEYSTOREITEM drop primary key cascade;
alter table TIBCO_GG.BC_INSTALL_INFO drop primary key cascade;
alter table TIBCO_GG.BC_SERVER_INFO drop primary key cascade;
alter table TIBCO_GG.BC_PLUGIN_INFO drop primary key cascade;
alter table TIBCO_GG.BC_PROXYINFO drop primary key cascade;
alter table TIBCO_GG.BC_JDBCINFO drop primary key cascade;
alter table TIBCO_GG.BC_LDAPINFO drop primary key cascade;
alter table TIBCO_GG.BC_BOINFO drop primary key cascade;
alter table TIBCO_GG.BC_DMZINFO drop primary key cascade;
alter table TIBCO_GG.BC_ICINFO drop primary key cascade;
alter table TIBCO_GG.BC_MONANDLOG drop primary key cascade;
alter table TIBCO_GG.BC_QUEUE drop primary key cascade;
alter table TIBCO_GG.BC_SCHEDULED_TASK drop primary key cascade;
alter table TIBCO_GG.BC_SFWS_MESSAGES drop primary key cascade;
alter table TIBCO_GG.BC_SFWS_TPINFO drop primary key cascade;
alter table TIBCO_GG.BC_SFWS_ATTACHMENTS_BIN drop primary key cascade;
alter table TIBCO_GG.BC_TRANSACTIONS drop primary key cascade;
alter table TIBCO_GG.BC_MESSAGES_BIN drop primary key cascade;
alter table TIBCO_GG.BC_RESEND_BIN drop primary key cascade;
alter table TIBCO_GG.BC_ALERT drop primary key cascade;
alter table TIBCO_GG.BC_UACLOG drop primary key cascade;
alter table TIBCO_GG.BC_UACLOG_DETAIL drop primary key cascade;
alter table TIBCO_GG.BC_NR_TRANSACTIONS drop primary key cascade;
alter table TIBCO_GG.BC_NR_BIN drop primary key cascade;
alter table TIBCO_GG.BC_NR_BIN_SIGNATURE drop primary key cascade;
alter table TIBCO_GG.BC_NR_BIN_VALICERT drop primary key cascade;
alter table TIBCO_GG.BC_NR_BIN_SIGCRED drop primary key cascade;
alter table TIBCO_GG.BC_NR_BIN_EDCRED drop primary key cascade;
alter table TIBCO_GG.TIBEDI_PLUGININFO drop primary key cascade;
alter table TIBCO_GG.TIBEDI_CONTROL_NUMBER drop primary key cascade;
alter table TIBCO_GG.TIBEDI_ACK_RECONCILIATION drop primary key cascade;
alter table TIBCO_GG.TIBEDI_CSUPDATE_CACHE drop primary key cascade;
alter table TIBCO_GG.TIBEDI_BATCH_TASK drop primary key cascade;
alter table TIBCO_GG.TIBEDI_BATCH_TX drop primary key cascade;

alter table TIBCO_GG.META_PROPERTY drop constraint META_PROPERTY_U_1 cascade;
alter table TIBCO_GG.META_SUBCLASS drop constraint META_SUBCLASS_U_1 cascade;
alter table TIBCO_GG.META_RELATION drop constraint META_RELATION_U_1 cascade;
alter table TIBCO_GG.BC_UPLOADEDFILE drop constraint BC_UPLOADEDFILE_U_1 cascade;
alter table TIBCO_GG.BC_SEQNO drop constraint BC_SEQNO_U_1 cascade;
alter table TIBCO_GG.BC_CHANNELINFO drop constraint BC_CHANNELINFO_U_1 cascade;
alter table TIBCO_GG.BC_KEYSTOREITEM drop constraint BC_KEYSTOREITEM_U_1 cascade;
alter table TIBCO_GG.BC_INSTALL_INFO drop constraint BC_INSTALL_INFO_U_1 cascade;
alter table TIBCO_GG.BC_SERVER_INFO drop constraint BC_SERVER_INFO_U_1 cascade;
alter table TIBCO_GG.BC_PLUGIN_INFO drop constraint BC_PLUGIN_INFO_U_1 cascade;
alter table TIBCO_GG.BC_PROXYINFO drop constraint BC_PROXYINFO_U_1 cascade;
alter table TIBCO_GG.BC_JDBCINFO drop constraint BC_JDBCINFO_U_1 cascade;
alter table TIBCO_GG.BC_LDAPINFO drop constraint BC_LDAPINFO_U_1 cascade;
alter table TIBCO_GG.BC_BOINFO drop constraint BC_BOINFO_U_1 cascade;
alter table TIBCO_GG.BC_DMZINFO drop constraint BC_DMZINFO_U_1 cascade;
alter table TIBCO_GG.BC_ICINFO drop constraint BC_ICINFO_U_1 cascade;
alter table TIBCO_GG.BC_MONANDLOG drop constraint BC_MONANDLOG_U_1 cascade;
alter table TIBCO_GG.BC_DBMAP drop constraint BC_DBMAP_U_1 cascade;
alter table TIBCO_GG.BC_DOMAINTYPE drop constraint BC_DOMAINTYPE_U_1 cascade;
alter table TIBCO_GG.BC_PCCODE drop constraint BC_PCCODE_U_1 cascade;
alter table TIBCO_GG.BC_SCCODE drop constraint BC_SCCODE_U_1 cascade;
alter table TIBCO_GG.BC_PARTICIPANT drop constraint BC_PARTICIPANT_U_1 cascade;
alter table TIBCO_GG.BC_LOCATION drop constraint BC_LOCATION_U_1 cascade;
alter table TIBCO_GG.BC_DOMAINID drop constraint BC_DOMAINID_U_1 cascade;
alter table TIBCO_GG.BC_BIZAGREEMENT drop constraint BC_BIZAGREEMENT_U_1 cascade;
alter table TIBCO_GG.BC_CONTACT drop constraint BC_CONTACT_U_1 cascade;
alter table TIBCO_GG.BC_SECURITYINFO drop constraint BC_SECURITYINFO_U_1 cascade;
alter table TIBCO_GG.BC_DOCEXCHANGE drop constraint BC_DOCEXCHANGE_U_1 cascade;
alter table TIBCO_GG.BC_RB drop constraint BC_RB_U_1 cascade;
alter table TIBCO_GG.BC_PB drop constraint BC_PB_U_1 cascade;
alter table TIBCO_GG.BC_PBV drop constraint BC_PBV_U_1 cascade;
alter table TIBCO_GG.BC_OPB drop constraint BC_OPB_U_1 cascade;
alter table TIBCO_GG.BC_PROTOCOL drop constraint BC_PROTOCOL_U_1 cascade;
alter table TIBCO_GG.BC_GRAMMAR drop constraint BC_GRAMMAR_U_1 cascade;
alter table TIBCO_GG.BC_GMAUX_INFO drop constraint BC_GMAUX_INFO_U_1 cascade;
alter table TIBCO_GG.BC_ROLE drop constraint BC_ROLE_U_1 cascade;
alter table TIBCO_GG.BC_INTFCOMPONENT drop constraint BC_INTFCOMPONENT_U_1 cascade;
alter table TIBCO_GG.BC_MIGRATIONINFO drop constraint BC_MIGRATIONINFO_U_1 cascade;
alter table TIBCO_GG.BC_ITEMCONSTRAINT drop constraint BC_ITEMCONSTRAINT_U_1 cascade;
alter table TIBCO_GG.BC_EMAILMONIKER drop constraint BC_EMAILMONIKER_U_1 cascade;
alter table TIBCO_GG.BC_ALERT_INFO drop constraint BC_ALERT_INFO_U_1 cascade;
alter table TIBCO_GG.BC_PARTNERVIEW drop constraint BC_PARTNERVIEW_U_1 cascade;
alter table TIBCO_GG.BC_HIBERNATION drop constraint SYS_C00994809 cascade;
alter table TIBCO_GG.BC_LOGVIEWQUERY drop constraint SYS_C00994813 cascade;
alter table TIBCO_GG.BC_LOGVIEWQUERY drop constraint BC_QUERY cascade;
alter table TIBCO_GG.BC_MESSAGES drop constraint SYS_C00994837 cascade;
alter table TIBCO_GG.BC_DUP drop constraint BC_DUP_UNIQUE cascade;
alter table TIBCO_GG.BC_NR_MESSAGES drop constraint SYS_C00994860 cascade;

drop table TIBCO_GG.CLI2_IE_IEC_TMP;
drop table TIBCO_GG.CPZ_TMP;
drop table TIBCO_GG.DACH_TRANSPORT_PLAN_TMP;
drop table TIBCO_GG.DESTINOS_INT_TMP;
drop table TIBCO_GG.DIVISAS_TMP;
drop table TIBCO_GG.ELEMENTOSSINCRONIZADOS_ERR;
drop table TIBCO_GG.ENRUTAMIENTO_INT_TMP;
drop table TIBCO_GG.FTI_TMP;
drop table TIBCO_GG.IDI_TMP;
drop table TIBCO_GG.IMG_AZKAR;
drop table TIBCO_GG.IMG_AZKAR_TMP;
drop table TIBCO_GG.IMG_CLIENTE;
drop table TIBCO_GG.IMG_CLIENTE_TMP;
drop table TIBCO_GG.IMG_RECOGIDA;
drop table TIBCO_GG.IMG_RECOGIDA_TMP;
drop table TIBCO_GG.PAI_TMP;
drop table TIBCO_GG.TOAD_PLAN_SQL;
drop table TIBCO_GG.TOAD_PLAN_TABLE;
drop table TIBCO_GG.TST_TMP;
drop table TIBCO_GG.TSV_TST_PROVE_TMP;
drop table TIBCO_GG.USR_INT_TMP;
drop table TIBCO_GG.HOJ_TMP;
drop table TIBCO_GG.CK_LOG;
drop table TIBCO_GG.BC_DOMAINTYPE;
drop table TIBCO_GG.BC_PCCODE;
drop table TIBCO_GG.BC_SCCODE;
drop table TIBCO_GG.BC_PARTICIPANT;
drop table TIBCO_GG.BC_LOCATION;
drop table TIBCO_GG.BC_DOMAINID;
drop table TIBCO_GG.BC_BIZAGREEMENT;
drop table TIBCO_GG.BC_CONTACT;
drop table TIBCO_GG.BC_SECURITYINFO;
drop table TIBCO_GG.BC_DOCEXCHANGE;
drop table TIBCO_GG.BC_RB;
drop table TIBCO_GG.BC_PB;
drop table TIBCO_GG.BC_PBV;
drop table TIBCO_GG.BC_OPB;
drop table TIBCO_GG.BC_PROTOCOL;
drop table TIBCO_GG.BC_GRAMMAR;
drop table TIBCO_GG.BC_GMAUX_INFO;
drop table TIBCO_GG.BC_ROLE;
drop table TIBCO_GG.BC_INTFCOMPONENT;
drop table TIBCO_GG.BC_MIGRATIONINFO;
drop table TIBCO_GG.BC_ITEMCONSTRAINT;
drop table TIBCO_GG.BC_EMAILMONIKER;
drop table TIBCO_GG.BC_ALERT_INFO;
drop table TIBCO_GG.BC_USER;
drop table TIBCO_GG.BC_GROUP;
drop table TIBCO_GG.BC_USER_GROUP_ASSIGNMENT;
drop table TIBCO_GG.BC_USER_PERM_ASSIGNMENT;
drop table TIBCO_GG.BC_GROUP_PERM_ASSIGNMENT;
drop table TIBCO_GG.BC_QUERYINFO;
drop table TIBCO_GG.BC_PARTNERVIEW;
drop table TIBCO_GG.BC_RT_VERSION;
drop table TIBCO_GG.BC_DB_LOCK;
drop table TIBCO_GG.BC_MDN;
drop table TIBCO_GG.BC_HIBERNATION;
drop table TIBCO_GG.BC_HIBERNATION_BIN;
drop table TIBCO_GG.BC_LOGVIEWQUERY;
drop table TIBCO_GG.BC_AUDIT_VERSION;
drop table TIBCO_GG.META_CLASS;
drop table TIBCO_GG.META_PROPERTY;
drop table TIBCO_GG.META_SUBCLASS;
drop table TIBCO_GG.META_RELATION;
drop table TIBCO_GG.BC_CS_LOCK;
drop table TIBCO_GG.BC_UPLOADEDFILE;
drop table TIBCO_GG.BC_SEQNO;
drop table TIBCO_GG.BC_CHANNELINFO;
drop table TIBCO_GG.BC_SMARTROUTERBASE;
drop table TIBCO_GG.BC_SMARTROUTERITEM;
drop table TIBCO_GG.BC_KEYSTOREITEM;
drop table TIBCO_GG.BC_INSTALL_INFO;
drop table TIBCO_GG.BC_SERVER_INFO;
drop table TIBCO_GG.BC_PLUGIN_INFO;
drop table TIBCO_GG.BC_PROXYINFO;
drop table TIBCO_GG.BC_JDBCINFO;
drop table TIBCO_GG.BC_LDAPINFO;
drop table TIBCO_GG.BC_BOINFO;
drop table TIBCO_GG.BC_DMZINFO;
drop table TIBCO_GG.BC_ICINFO;
drop table TIBCO_GG.BC_MONANDLOG;
drop table TIBCO_GG.BC_DBMAP;
drop table TIBCO_GG.BC_LOGQUERYBIN;
drop table TIBCO_GG.BC_QUEUE;
drop table TIBCO_GG.BCQUEUE_BIN_TABLE;
drop table TIBCO_GG.BC_SCHEDULED_TASK;
drop table TIBCO_GG.BC_SFWS_MESSAGES;
drop table TIBCO_GG.BC_SFWS_TPINFO;
drop table TIBCO_GG.BC_SFWS_ATTACHMENTS_BIN;
drop table TIBCO_GG.TIBEDI_VERSION;
drop table TIBCO_GG.TIBEDI_PLUGININFO;
drop table TIBCO_GG.BC_TRANSACTIONS;
drop table TIBCO_GG.BC_MESSAGES;
drop table TIBCO_GG.BC_MESSAGES_BIN;
drop table TIBCO_GG.BC_RESEND_BIN;
drop table TIBCO_GG.BC_ALERT;
drop table TIBCO_GG.BC_POLLER_INFO;
drop table TIBCO_GG.BC_DUP;
drop table TIBCO_GG.BC_LOGACL_TEMP;
drop table TIBCO_GG.BC_UACLOG;
drop table TIBCO_GG.BC_UACLOG_DETAIL;
drop table TIBCO_GG.BC_NR_VERSION;
drop table TIBCO_GG.BC_NR_TRANSACTIONS;
drop table TIBCO_GG.BC_NR_MESSAGES;
drop table TIBCO_GG.BC_NR_BIN;
drop table TIBCO_GG.BC_NR_BIN_SIGNATURE;
drop table TIBCO_GG.BC_NR_BIN_VALICERT;
drop table TIBCO_GG.BC_NR_BIN_SIGCRED;
drop table TIBCO_GG.BC_NR_BIN_EDCRED;
drop table TIBCO_GG.TIBEDI_CONTROL_NUMBER;
drop table TIBCO_GG.TIBEDI_ACK_RECONCILIATION;
drop table TIBCO_GG.TIBEDI_CSUPDATE_CACHE;
drop table TIBCO_GG.TIBEDI_BATCH_TASK;
drop table TIBCO_GG.TIBEDI_BATCH_TX;
drop table TIBCO_GG.TIBEDI_BATCH_TX_BIN;
drop table TIBCO_GG.HES_TMP;
drop table TIBCO_GG.RHO_TMP;
drop table TIBCO_GG.RCH_TMP;
drop table TIBCO_GG.PLA_TMP;
drop table TIBCO_GG.RCO_INCIDENCIAS_TMP;
drop table TIBCO_GG.TSV_TMP;
drop table TIBCO_GG.BUL_TMP;
drop table TIBCO_GG.FP_COD_TMP;
drop table TIBCO_GG.ELEMENTOSSINCRONIZADOS;
drop table TIBCO_GG.P_ELEMENTOSSINCRONIZADOS;
drop table TIBCO_GG.RCO_TMP;
drop table TIBCO_GG.CLI_TMP;
drop table TIBCO_GG.REF_TMP;
drop table TIBCO_GG.PROVEEDORES_TMP;
drop table TIBCO_GG.ZON_TMP;
drop table TIBCO_GG.RCL_TMP;
drop table TIBCO_GG.DEL_TMP;

drop SEQUENCE TIBCO_GG.P_ELEMENTOSSINCRONIZADOS_SEQ;
drop SEQUENCE TIBCO_GG.SINCRONIZACION_SEQUENCE;
drop LOB TIBCO_GG.SYS_LOB0000105101C00036$$;
drop TRIGGER TIBCO_GG.TRG_IMG_AZKAR;
drop TRIGGER TIBCO_GG.TRG_IMG_CLIENTE;
drop TRIGGER TIBCO_GG.TRG_IMG_RECOGIDA;
drop TRIGGER TIBCO_GG.TRI_P_ELEMENTOSSINCRONIZADOS;
drop PROCEDURE TIBCO_GG.PROC_REPROCESAR_ERRONEOS;
drop PROCEDURE TIBCO_GG.PROC_INTEGRACION_ERRONEOS;
drop PACKAGE TIBCO_GG.PCK_INTEGRACION;
drop PACKAGE BODY TIBCO_GG.PCK_INTEGRACION;
drop PACKAGE BODY TIBCO_GG.MANTENIMIENTO_REPROCESO;
drop PACKAGE BODY TIBCO_GG.MANTENIMIENTO_SINCRO;
drop LOB TIBCO_GG.SYS_LOB0000591461C00014$$;
drop LOB TIBCO_GG.SYS_LOB0000591475C00015$$;
drop LOB TIBCO_GG.SYS_LOB0000591485C00016$$;
drop LOB TIBCO_GG.SYS_LOB0000591492C00014$$;
drop LOB TIBCO_GG.SYS_LOB0000591492C00013$$;
drop LOB TIBCO_GG.SYS_LOB0000591492C00012$$;
drop LOB TIBCO_GG.SYS_LOB0000591492C00011$$;
drop LOB TIBCO_GG.SYS_LOB0000591492C00010$$;
drop LOB TIBCO_GG.SYS_LOB0000591513C00014$$;
drop LOB TIBCO_GG.SYS_LOB0000591513C00013$$;
drop LOB TIBCO_GG.SYS_LOB0000591513C00012$$;
drop LOB TIBCO_GG.SYS_LOB0000591522C00008$$;
drop LOB TIBCO_GG.SYS_LOB0000591540C00017$$;
drop LOB TIBCO_GG.SYS_LOB0000591588C00020$$;
drop LOB TIBCO_GG.SYS_LOB0000591588C00010$$;
drop LOB TIBCO_GG.SYS_LOB0000591610C00012$$;
drop LOB TIBCO_GG.SYS_LOB0000591638C00010$$;
drop LOB TIBCO_GG.SYS_LOB0000591645C00021$$;
drop LOB TIBCO_GG.SYS_LOB0000591645C00020$$;
drop LOB TIBCO_GG.SYS_LOB0000591645C00019$$;
drop LOB TIBCO_GG.SYS_LOB0000591656C00016$$;
drop LOB TIBCO_GG.SYS_LOB0000591663C00013$$;
drop LOB TIBCO_GG.SYS_LOB0000591663C00012$$;
drop LOB TIBCO_GG.SYS_LOB0000591663C00011$$;
drop LOB TIBCO_GG.SYS_LOB0000591674C00009$$;
drop LOB TIBCO_GG.SYS_LOB0000591674C00008$$;
drop LOB TIBCO_GG.SYS_LOB0000591694C00010$$;
drop LOB TIBCO_GG.SYS_LOB0000591702C00010$$;
drop LOB TIBCO_GG.SYS_LOB0000591727C00015$$;
drop LOB TIBCO_GG.SYS_LOB0000591739C00007$$;
drop LOB TIBCO_GG.SYS_LOB0000591756C00003$$;
drop SEQUENCE TIBCO_GG.BC_HIBERNATE_TABLE$BININDEX;
drop LOB TIBCO_GG.SYS_LOB0000591764C00003$$;
drop SEQUENCE TIBCO_GG.BC_LOGQUERY$BININDEX;
drop LOB TIBCO_GG.SYS_LOB0000591775C00003$$;
drop SEQUENCE TIBCO_GG.BCQUEUE_TABLE$BININDEX;
drop LOB TIBCO_GG.SYS_LOB0000591792C00020$$;
drop LOB TIBCO_GG.SYS_LOB0000591798C00007$$;
drop LOB TIBCO_GG.SYS_LOB0000591815C00003$$;
drop SEQUENCE TIBCO_GG.BCAUDIT_TABLE$BININDEX;
drop LOB TIBCO_GG.SYS_LOB0000591820C00003$$;
drop LOB TIBCO_GG.SYS_LOB0000591829C00011$$;
drop LOB TIBCO_GG.SYS_LOB0000591846C00004$$;
drop LOB TIBCO_GG.SYS_LOB0000591850C00003$$;
drop LOB TIBCO_GG.SYS_LOB0000591854C00003$$;
drop LOB TIBCO_GG.SYS_LOB0000591858C00003$$;
drop LOB TIBCO_GG.SYS_LOB0000591862C00003$$;
drop SEQUENCE TIBCO_GG.BCNR_TABLE$BININDEX;
drop LOB TIBCO_GG.SYS_LOB0000591805C00004$$;
drop LOB TIBCO_GG.SYS_LOB0000591887C00003$$;
drop SEQUENCE TIBCO_GG.TIBEDIBATCHTX_TABLE$BININDEX;