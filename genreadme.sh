
gen()
{
 perl -p -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : die $1/eg' README-template.md > $1
}

export project="JBoss Tools Base"
export githubproject="jbosstools-base"
export jiracomponent="common/jst/core, runtime detection or usage"
export summary="JBoss Tools Base contains set of base plugins used in many JBoss Tools Eclipse plugins."
gen $NEWROOT/jbosstools-base/README.md

export project="Birt Tools"
export githubproject="jbosstools-birt"
export jiracomponent="birt"
export summary="Birt Tools provides integration between Hibernate and Birt report generation."
gen $NEWROOT/jbosstools-birt/README.md


export project="JBoss BPEL Tools"
export githubproject="jbosstools-bpel"
export jiracomponent="bpel"
export summary="JBoss BPEL Tools are extensions to Eclipse BPEL project."
gen $NEWROOT/jbosstools-bpel/README.md


export project="JBoss Tools Build"
export githubproject="jbosstools-build"
export jiracomponent="build"
export summary="JBoss Tools Build project provides the JBoss Tools parent and Eclipse target platforrms used by JBoss Tools projects."
gen $NEWROOT/jbosstools-build/README.md


export project="JBoss Tools Continous Build"
export githubproject="jbosstools-build-ci"
export jiracomponent="build"
export summary="This repository contains scripts used by the continous builds of JBoss Tools projects."
gen $NEWROOT/jbosstools-build-ci/README.md


export project="JBoss Tools Build Sites"
export githubproject="jbosstools-build-sites"
export jiracomponent="Build sites contains the category and site content for the various updatesites used in JBoss Tools build and release."
export summary=""
gen $NEWROOT/jbosstools-build-sites/README.md


export project="JBoss Central"
export githubproject="jbosstools-central"
export jiracomponent="central, maven or project examples"
export summary="JBoss Central contains the key components/extensions for driving the JBoss Central editor/view and the project examples plus it currently contains the Maven extensions JBoss Tools provides on top of m2e."
gen $NEWROOT/jbosstools-central/README.md

export project="Jboss Tools Documentation"
export githubproject="jbosstools-documentation"
export jiracomponent="documentation"
export summary="JBoss Tools Documentation contains various docs and Whats New and Noteworthy for JBoss Tools"
gen $NEWROOT/jbosstools-documentation/README.md


export project="jbosstools-download.jboss.org"
export githubproject="jbosstools-download.jboss.org"
export jiracomponent="updatesite"
export summary="JBoss Tools download.jboss.org is a temporary repository containing backup/source of content of download.jboss.org/tools."
gen $NEWROOT/jbosstools-download.jboss.org/README.md


export project="ESB Tools"
export githubproject="jbosstools-esb"
export jiracomponent="esb"
export summary="ESB Tools provides tooling to work with JBoss ESB configuration files and deploy ESB projects."
gen $NEWROOT/jbosstools-esb/README.md


export project="Forge Tools"
export githubproject="jbosstools-forge"
export jiracomponent="forge"
export summary="Forge Tools provides easy access and integration with Forge from within a view in Eclipse. You can open this view by pressing Ctrl+4 (Linux/Windows) or Cmd+4 (Mac)."
gen $NEWROOT/jbosstools-forge/README.md


export project="FreeMarker Tools"
export githubproject="jbosstools-freemarker"
export jiracomponent="freemarker"
export summary="FreeMarker Tools provide an editor for FreeMarker .ftl files with code completion and syntax highlighting."
gen $NEWROOT/jbosstools-freemarker/README.md


export project="GWT Tools"
export githubproject="jbosstools-gwt"
export jiracomponent="gwt"
export summary="GWT Tools provides an Eclipse Web Tools Facet for Google Web Toolkit."
gen $NEWROOT/jbosstools-gwt/README.md

export project="Hibernate Eclipse Tools"
export githubproject="jbosstools-hibernate"
export jiracomponent="hibernate"
export summary="Hibernate Tools is a set of Eclipse plugns that provides support for edit hbm.xml, JPA annotations, HQL query prototyping and code generation for Hibernate and JPA projects. "
gen $NEWROOT/jbosstools-hibernate/README.md


export project="JBoss Tools Integration Tests"
export githubproject="jbosstools-integration-tests"
export jiracomponent="build"
export summary="JBoss Tools Integration Test contains SWT Bot test plugins for overall integration testing of JBoss Tools. "
gen $NEWROOT/jbosstools-integration-tests/README.md


export project="JavaEE Tools"
export githubproject="jbosstools-javaee"
export jiracomponent="cdi, seam, struts or jsf"
export summary="JavaEE Tools provides Eclipse plugins for features related to development on JavaEE. This includes CDI, Seam, JSF and Struts. "
gen $NEWROOT/jbosstools-javaee/README.md


export project="jBPM Tools"
export githubproject="jbosstools-jbpm"
export jiracomponent="jbpm"
export summary="jBPM Tools provide tooling for jBPM 3."
gen $NEWROOT/jbosstools-jbpm/README.md


export project="JST Tools"
export githubproject="jbosstools-jst"
export jiracomponent="JST Tools provides shared plugin functionallity between JavaEE Tools and Visual Page Editor related to text editing and validation."
export summary="commont/jst/core"
gen $NEWROOT/jbosstools-jst/README.md


export project="JBoss Tools Maven Plugins"
export githubproject="jbosstools-maven-plugins"
export jiracomponent="build"
export summary="Various Maven/Tycho plugins used by JBoss Tools "
gen $NEWROOT/jbosstools-maven-plugins/README.md


export project="OpenShift Tools"
export githubproject="jbosstools-openshift"
export jiracomponent="openshift"
export summary="OpenShift Tools provides wizards and views for creating and maintaining OpenShift applications. "
gen $NEWROOT/jbosstools-openshift/README.md


export project="Portlet Tools"
export githubproject="jbosstools-portlet"
export jiracomponent="portlet"
export summary="Portlet Tools provides wizards for working with GateIn and JBoss Enterprise Portal Platform."
gen $NEWROOT/jbosstools-portlet/README.md


export project="Runtime Detection for SOA"
export githubproject="jbosstools-runtime-soa"
export jiracomponent="runtime detection"
export summary="Provides plugins to identify and setup SOA related runtimes like ESB, Drools and jBPM."
gen $NEWROOT/jbosstools-runtime-soa/README.md


export project="Server Tools"
export githubproject="jbosstools-server"
export jiracomponent="JBossAS/server"
export summary="Server Tools provide the JBoss Server Adapter for Eclipse WTP, project archive tooling and JMX views."
gen $NEWROOT/jbosstools-server/README.md

export project="JBoss Tools Visual Page Editing"
export githubproject="jbosstools-vpe"
export jiracomponent="Visual Page Editor Core & Templates"
export summary="Visual Page Editing provides an editor that has a source and visual preview for XML based documents, it also contains the BrowserSimulator for editing/viewing your project webpages as mobile browsers would do it. "
gen $NEWROOT/jbosstools-vpe/README.md

export project="Webservices Tools"
export githubproject="jbosstools-webservices"
export jiracomponent="webservices"
export summary="Webservices provides wizards, validation and a webservice tester for JAX-RS and JAX-WS based projects."
gen $NEWROOT/jbosstools-webservices/README.md


export project="XulRunner"
export githubproject="jbosstools-xulrunner"
export jiracomponent="Visual Page Editor Core & Templates"
export summary="The XULRunner component as used in JBoss Tools"
gen $NEWROOT/jbosstools-xulrunner/README.md


