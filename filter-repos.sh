#! /bin/bash
if [ -z "$NEWROOT" ] 
  then
    echo "NEWROOT need to be set to where repositories should be created."
  exit
fi

control_c()
{
  echo -en "\n*** Ouch ! Stopping ***\n"
  exit $?
}
trap control_c SIGINT

ORIGINAL_REPO=jbosstools-full-svn-mirror

GLOBAL_EXCLUDE="^documentation/qa.*|^documentation/development.*|^xulrunner2.*|^vpe/contrib/org.mozilla.xulrunner.gtk.linux.x86_64_1.8.1.4-20080112.jar.*|^documentation/.*wnk|^documentation/.*swf|^deltacloud/plugins/org.jboss.tools.deltacloud.client/target|^hibernate-tools/plugins/org.hibernate.eclipse.libs/target/.*|^hibernateools/plugins/org.jboss.tools.hibernate4_0/target/|^portlet/docs/reference/target/.*|^as/features/org.jboss.ide.eclipse.as.archives.integration.feature/target/.*|^as/features/org.jboss.ide.eclipse.as.jmx.integration.feature/target/.*|^as/features/org.jboss.ide.eclipse.as.server.rse.integration.feature/target/.*|^as/features/org.jboss.ide.eclipse.as.serverAdapter.wtp.feature/target/.*|^as/plugins/org.jboss.ide.eclipse.as.dmr/target/.*|^as/plugins/org.jboss.ide.eclipse.as.jmx.integration/target/.*|^as/plugins/org.jboss.ide.eclipse.as.management.core/target/.*|^as/plugins/org.jboss.ide.eclipse.as.openshift.core/target/.*|^as/plugins/org.jboss.ide.eclipse.as.rse.core/target/.*|^as/plugins/org.jboss.ide.eclipse.as.rse.ui/target/.*|^as/plugins/org.jboss.tools.openshift.express.client/target/.*|^archives/tests/org.jboss.tools.archives.ui.bot.test/bin.*|^as/plugins/org.jboss.ide.eclipse.as.classpath.core/bin.*|^as/plugins/org.jboss.ide.eclipse.as.classpath.ui/bin.*|^as/plugins/org.jboss.ide.eclipse.as.jmx.integration/bin.*|^as/plugins/org.jboss.ide.eclipse.as.management.as7/bin.*|^as/plugins/org.jboss.ide.eclipse.as.ssh/bin.*|^as/tests/org.jboss.ide.eclipse.as.test/bin.*|^cdi/plugins/org.jboss.tools.cdi.solder.core/bin.*|^cdi/tests/org.jboss.tools.cdi.seam3.bot.test/bin.*|^cdi/tests/org.jboss.tools.cdi.solder.core.test/bin.*|^common/plugins/org.jboss.tools.common.ui.sidebyside/bin.*|^deltacloud/plugins/org.jboss.tools.deltacloud.client/bin.*|^plugins/org.eclipse.bpel.apache.ode.deploy.model/bin.*|^plugins/org.eclipse.bpel.apache.ode.deploy.ui/bin.*|^plugins/org.eclipse.bpel.apache.ode.runtime/bin.*|^plugins/org.eclipse.bpel.common.model/bin.*|^plugins/org.eclipse.bpel.common.ui/bin.*|^plugins/org.eclipse.bpel.model/bin.*|^plugins/org.eclipse.bpel.runtimes/bin.*|^plugins/org.eclipse.bpel.ui/bin.*|^plugins/org.eclipse.bpel.validator/bin.*|^plugins/org.eclipse.bpel.wsil.model/bin.*|^plugins/org.eclipse.bpel.xpath10/bin.*|^plugins/org.jboss.tools.bpel.cheatsheet/bin.*|^plugins/org.jboss.tools.jbpm.convert/bin.*|^plugins/org.jboss.tools.neweditor.sidebyside/bin.*|^plugins/org.jboss.tools.ws.core/bin.*|^plugins/org.jboss.tools.ws.ui/bin.*|^tests/org.eclipse.bpel.ui.tests/bin.*|^tests/org.jboss.tools.bpel.ui.bot.test/bin.*|^tests/org.jboss.tools.jbpm.convert.test/bin.*|^tests/org.jboss.tools.jst.ui.bot.test/bin.*|^tests/org.jboss.tools.jst.ui.firstrun.bot.test/bin.*|^tests/org.jboss.tools.jst.web.kb.test/projects/utility/bin.*|^tests/org.jboss.tools.vpe.ui.bot.test/bin.*|^usage/org.jboss.tools.usage.test/bin.*|^usage/org.jboss.tools.usage/bin.*|^usage/plugins/org.jboss.tools.usage/bin.*|^usage/tests/org.jboss.tools.usage.test/bin.*"

FILTER=no

if [ "$FILTER" == "yes" ]
then
 echo Running filter_repo for each repository
 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-base $GLOBAL_EXCLUDE "^common/.*|^tests/.*|^runtime/.*|^usage/.*"

 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-server $GLOBAL_EXCLUDE "^archives/.*|^as/.*|^jmx/.*"

 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-freemarker $GLOBAL_EXCLUDE "^freemarker/.*"
 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-birt $GLOBAL_EXCLUDE "^birt/.*"

 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-xulrunner $GLOBAL_EXCLUDE "^xulrunner/.*"
 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-jst $GLOBAL_EXCLUDE "^jst.*"
 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-vpe $GLOBAL_EXCLUDE "^vpe.*"
 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-forge $GLOBAL_EXCLUDE "^forge.*"

 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-javaee $GLOBAL_EXCLUDE "^cdi.*|^jsf.*|^seam.*|^struts.*"
 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-deltacloud $GLOBAL_EXCLUDE "^deltacloud.*"
 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-portlet $GLOBAL_EXCLUDE "^portlet.*"
 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-webservices $GLOBAL_EXCLUDE "^ws.*"
 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-central $GLOBAL_EXCLUDE "^maven.*|^examples.*|^central.*" 

 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-documentation $GLOBAL_EXCLUDE "^documentation.*"
 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-gwt $GLOBAL_EXCLUDE "^gwt.*"
 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-bpel $GLOBAL_EXCLUDE "^bpel.*"
 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-jbpm $GLOBAL_EXCLUDE "^jbpm.*|^flow.*"
 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-runtime-soa $GLOBAL_EXCLUDE "^runtime-soa.*"

 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-maven-plugins $GLOBAL_EXCLUDE "^build/tycho-plugins.*"
 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-build $GLOBAL_EXCLUDE "^build/parent.*|^build/target-platform.*|^build/target-platforms.*"
 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-build-sites $GLOBAL_EXCLUDE "^build/aggregate.*|^build/results.*"
 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-build-continous $GLOBAL_EXCLUDE "^build/util.*|^build/emma.*|^build/jacoco.*"

 python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-hibernate $GLOBAL_EXCLUDE "^hibernatetools/.*/"
 
 python filter_tests.py $ORIGINAL_REPO $NEWROOT/jbosstools-integration-tests 

fi


cd $NEWROOT

find jbosstools-* -maxdepth 0 | while read REPO
do
 echo Working on $REPO

 export GIT_DIR=$NEWROOT/$REPO/.git
 export GIT_WORK_TREE=$NEWROOT/$REPO

 echo Checking out master.....
 git checkout master

 deleteemptybranches.sh $REPO

 echo Garbage collecting to remove any non referenced files to speed up cleanup
 git reset --hard && git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d && git reflog expire --expire=now --all && git gc --aggressive --prune=now

 echo Removing empty commits....$GIT_WORK_TREE
 cd $GIT_WORK_TREE
 git filter-branch --tag-name-filter cat --prune-empty -- --all
 cd -

 if [[ "$REPO" != *jbosstools-integration-tests ]]
 then
  echo subdirectory filter for repo with just one root directory....
  NOFILES=`ls -a $REPO | wc -l | tr -d ' '`
  if [[ "$NOFILES" == 4 ]]
   then
     DIR=`ls $REPO`
     echo `pwd` $REPO has one file/subdir only - filtering its content on $DIR.
     find $REPO -maxdepth 1 | xargs -n 1 -I {} bash -c "cd {} && git filter-branch --tag-name-filter cat --prune-empty --subdirectory-filter $DIR -f -- --all"
  fi
 fi

 echo Final and complete Garbage collection.....
 git reset --hard && git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d && git reflog expire --expire=now --all && git gc --aggressive --prune=now

done


