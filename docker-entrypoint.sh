#!/usr/bin/env bash
set -e

if [[ ${UID_JENKINS} != 1000 ]]; then
    echo "INFO: set jenkins UID to ${UID_JENKINS}"
    usermod -u ${UID_JENKINS} jenkins
    {
      chown -R jenkins:jenkins /var/jenkins_home
      chown -R jenkins:jenkins /usr/share/jenkins/ref
    } ||
    {
      echo "ERROR: failed chown command"
    }
fi

if [[ ${GID_JENKINS} != 1000 ]]; then
    echo "INFO: set jenkins GID to ${GID_JENKINS}"
    groupmod -g ${GID_JENKINS} jenkins
fi

mkdir -p /etc/sudoers.d
touch /etc/sudoers.d/jenkins
echo "jenkins ALL=(root) NOPASSWD: /usr/bin/docker" > /etc/sudoers.d/jenkins
chmod 0440 /etc/sudoers.d/jenkins

sed -i "s# exec java# exec $(which java)#g" /usr/local/bin/jenkins.sh
su jenkins -c 'cd $HOME; /usr/local/bin/jenkins.sh'
