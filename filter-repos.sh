#! /bin/bash
if [ -z "$NEWROOT" ] 
  then
    echo xxx "NEWROOT need to be set to where repositories should be created."
  exit
fi

control_c()
{
  echo -en "\n*** Ouch ! Stopping ***\n"
  exit $?
}
trap control_c SIGINT

ORIGINAL_REPO=jbosstools-full-svn-mirror

GLOBAL_EXCLUDE="^documentation/qa.*|^documentation/development.*|^bpel-old.*|^xulrunner2.*|^vpe/contrib/org.mozilla.xulrunner.gtk.linux.x86_64_1.8.1.4-20080112.jar.*|^documentation/.*wnk|^documentation/.*swf|^deltacloud/plugins/org.jboss.tools.deltacloud.client/target|^hibernate-tools/plugins/org.hibernate.eclipse.libs/target/.*|^hibernateools/plugins/org.jboss.tools.hibernate4_0/target/|^portlet/docs/reference/target/.*|^as/features/org.jboss.ide.eclipse.as.archives.integration.feature/target/.*|^as/features/org.jboss.ide.eclipse.as.jmx.integration.feature/target/.*|^as/features/org.jboss.ide.eclipse.as.server.rse.integration.feature/target/.*|^as/features/org.jboss.ide.eclipse.as.serverAdapter.wtp.feature/target/.*|^as/plugins/org.jboss.ide.eclipse.as.dmr/target/.*|^as/plugins/org.jboss.ide.eclipse.as.jmx.integration/target/.*|^as/plugins/org.jboss.ide.eclipse.as.management.core/target/.*|^as/plugins/org.jboss.ide.eclipse.as.openshift.core/target/.*|^as/plugins/org.jboss.ide.eclipse.as.rse.core/target/.*|^as/plugins/org.jboss.ide.eclipse.as.rse.ui/target/.*|^as/plugins/org.jboss.tools.openshift.express.client/target/.*|^archives/tests/org.jboss.tools.archives.ui.bot.test/bin.*|^as/plugins/org.jboss.ide.eclipse.as.classpath.core/bin.*|^as/plugins/org.jboss.ide.eclipse.as.classpath.ui/bin.*|^as/plugins/org.jboss.ide.eclipse.as.jmx.integration/bin.*|^as/plugins/org.jboss.ide.eclipse.as.management.as7/bin.*|^as/plugins/org.jboss.ide.eclipse.as.ssh/bin.*|^as/tests/org.jboss.ide.eclipse.as.test/bin.*|^cdi/plugins/org.jboss.tools.cdi.solder.core/bin.*|^cdi/tests/org.jboss.tools.cdi.seam3.bot.test/bin.*|^cdi/tests/org.jboss.tools.cdi.solder.core.test/bin.*|^common/plugins/org.jboss.tools.common.ui.sidebyside/bin.*|^deltacloud/plugins/org.jboss.tools.deltacloud.client/bin.*|^plugins/org.eclipse.bpel.apache.ode.deploy.model/bin.*|^plugins/org.eclipse.bpel.apache.ode.deploy.ui/bin.*|^plugins/org.eclipse.bpel.apache.ode.runtime/bin.*|^plugins/org.eclipse.bpel.common.model/bin.*|^plugins/org.eclipse.bpel.common.ui/bin.*|^plugins/org.eclipse.bpel.model/bin.*|^plugins/org.eclipse.bpel.runtimes/bin.*|^plugins/org.eclipse.bpel.ui/bin.*|^plugins/org.eclipse.bpel.validator/bin.*|^plugins/org.eclipse.bpel.wsil.model/bin.*|^plugins/org.eclipse.bpel.xpath10/bin.*|^plugins/org.jboss.tools.bpel.cheatsheet/bin.*|^plugins/org.jboss.tools.jbpm.convert/bin.*|^plugins/org.jboss.tools.neweditor.sidebyside/bin.*|^plugins/org.jboss.tools.ws.core/bin.*|^plugins/org.jboss.tools.ws.ui/bin.*|^tests/org.eclipse.bpel.ui.tests/bin.*|^tests/org.jboss.tools.bpel.ui.bot.test/bin.*|^tests/org.jboss.tools.jbpm.convert.test/bin.*|^tests/org.jboss.tools.jst.ui.bot.test/bin.*|^tests/org.jboss.tools.jst.ui.firstrun.bot.test/bin.*|^tests/org.jboss.tools.jst.web.kb.test/projects/utility/bin.*|^tests/org.jboss.tools.vpe.ui.bot.test/bin.*|^usage/org.jboss.tools.usage.test/bin.*|^usage/org.jboss.tools.usage/bin.*|^usage/plugins/org.jboss.tools.usage/bin.*|^usage/tests/org.jboss.tools.usage.test/bin.*"

FILTER=yes

function cleanuprepo {
 REPO=$1  
 
 echo xxx Cleaning up $REPO 
 
 export GIT_DIR=$REPO/.git
 export GIT_WORK_TREE=$REPO

 echo xxx Checking out master.....
 git checkout master
 
 deleteemptybranches.sh $GIT_WORK_TREE

echo xxx Garbage collecting to remove any non referenced files to speed up cleanup
git reset --hard && git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d && git reflog expire --expire=now --all && git gc --aggressive --prune=now

 echo xxx Removing empty commits....$GIT_WORK_TREE
 cd $GIT_WORK_TREE
 git filter-branch --tag-name-filter cat --prune-empty -- --all
 cd -

 if [[ "$REPO" != *jbosstools-integration-tests ]]
 then
  echo xxx subdirectory filter for repo with just one root directory....
  NOFILES=`ls -a $REPO | wc -l | tr -d ' '`
  if [[ "$NOFILES" == 4 ]]
   then
     DIR=`ls $REPO`
     echo xxx `pwd` $REPO has one file/subdir only - filtering its content on $DIR.
     find $REPO -maxdepth 1 | xargs -n 1 -I {} bash -c "echo {} && cd ./{} && git filter-branch --tag-name-filter cat --prune-empty --subdirectory-filter $DIR -f -- --all"

  fi
 fi
 

 echo xxx Final and complete Garbage collection.....
 git reset --hard && git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d && git reflog expire --expire=now --all && git gc --aggressive --prune=now
  

 
}

function filterrepo {
 REP=$1
 INC=$2
 python filter_repo.py $ORIGINAL_REPO $REP $GLOBAL_EXCLUDE $INC
# cleanuprepo $REP
 #exit
}

if [ "$FILTER" == "yes" ]
then
 echo xxx Running filter_repo for each repository

 #filterrepo $NEWROOT/jbosstools-freemarker "^freemarker/.*"
 #filterrepo $NEWROOT/jbosstools-birt "^birt/.*"

 #filterrepo $NEWROOT/jbosstools-base "^common/.*|^tests/.*|^runtime/.*|^usage/.*"

 filterrepo $NEWROOT/jbosstools-server "^archives/.*|^as/.*|^jmx/.*"
 

 filterrepo $NEWROOT/jbosstools-xulrunner "^xulrunner/.*"
 filterrepo $NEWROOT/jbosstools-jst "^jst.*"
 filterrepo $NEWROOT/jbosstools-vpe "^vpe.*"
 filterrepo $NEWROOT/jbosstools-forge "^forge.*"

 filterrepo $NEWROOT/jbosstools-javaee "^cdi.*|^jsf.*|^seam.*|^struts.*"
 filterrepo $NEWROOT/jbosstools-deltacloud "^deltacloud.*"
 filterrepo $NEWROOT/jbosstools-portlet "^portlet.*"
 filterrepo $NEWROOT/jbosstools-webservices "^ws.*"
 filterrepo $NEWROOT/jbosstools-central "^maven.*|^examples.*|^central.*" 

 filterrepo $NEWROOT/jbosstools-documentation "^documentation.*"
 filterrepo $NEWROOT/jbosstools-gwt "^gwt/.*"
 filterrepo $NEWROOT/jbosstools-bpel "^bpel/.*"

 filterrepo $NEWROOT/jbosstools-jbpm "^jbpm.*|^flow.*"
 filterrepo $NEWROOT/jbosstools-runtime-soa "^runtime-soa.*"

 filterrepo $NEWROOT/jbosstools-maven-plugins "^build/tycho-plugins.*"
 filterrepo $NEWROOT/jbosstools-build "^build/parent.*|^build/target-platform.*|^build/target-platforms.*"
 filterrepo $NEWROOT/jbosstools-build-sites "^build/aggregate.*|^build/results.*"
 filterrepo $NEWROOT/jbosstools-build-ci "^build/util.*|^build/emma.*|^build/jacoco.*"

 filterrepo $NEWROOT/jbosstools-hibernate "^hibernatetools/.*/"

 filterrepo $NEWROOT/jbosstools-esb "^esb/.*"
 filterrepo $NEWROOT/jbosstools-openshift "^openshift/.*"


 filterrepo $NEWROOT/jbosstools-openshift "^openshift/.*"

 filterrepo $NEWROOT/jbosstools-openshift "^openshift/.*"

 filterrepo $NEWROOT/jbosstools-download.jboss.org "^download.jboss.org/.*"

 python filter_tests.py $ORIGINAL_REPO $NEWROOT/jbosstools-integration-tests $GLOBAL_EXCLUDE
 cleanuprepo  $NEWROOT/jbosstools-integration-tests

 filterrepo $NEWROOT/jbosstools-base "^common/.*|^tests/.*|^runtime/.*|^usage/.*"

fi


cd $NEWROOT

find jbosstools-* -maxdepth 0 | while read REPO
do
 cleanuprepo $REPO
done


