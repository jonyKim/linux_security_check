#!/bin/bash
# RHEL ( Centos ) version 8 standard

host=`hostname`
date=`date +%y%0m%d`

######### setting #############

apache_home=/apache/httpd

#### su user ######

su_user=admin

#### login massage #####
motd="warning"

###############################

echo "" > "$host"_"$date".txt

echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-01 #######
# ssh root login deny
ssh_c=`cat /etc/ssh/sshd_config | grep 'PermitRootLogin no' | grep -v "^#" | wc -l`
if [ "$ssh_c" -lt 1 ]
then
/usr/bin/cp /etc/ssh/sshd_config /etc/ssh/sshd_config_org
sed -i "s/PermitRootLogin yes/#PermitRootLogin yes\nPermitRootLogin no/g" /etc/ssh/sshd_config
else
 echo ""
fi

echo "ssh root login deny [ U-01 ]" >> "$host"_"$date".txt
cat /etc/ssh/sshd_config | grep 'PermitRootLogin' | grep -v "^#" >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-02 #######
# password complexity 

pwq_c=`cat /etc/security/pwquality.conf | grep 'minlen = 8' | grep -v "^#" | wc -l`
if [ "$pwq_c" -lt 1 ]
then
/usr/bin/cp /etc/security/pwquality.conf /etc/security/pwquality.conf_org
sed -i "s/# minlen = 8/# minlen = 8\nminlen = 8/g" /etc/security/pwquality.conf
sed -i "s/# dcredit = 0/# dcredit = 0\ndcredit = -1/g" /etc/security/pwquality.conf
sed -i "s/# ucredit = 0/# ucredit = 0\nucredit = -1/g" /etc/security/pwquality.conf
sed -i "s/# lcredit = 0/# lcredit = 0\nlcredit = -1/g" /etc/security/pwquality.conf
sed -i "s/# ocredit = 0/# ocredit = 0\nocredit = -1/g" /etc/security/pwquality.conf
else
 echo ""
fi

echo "password complexity [ U-02 ]" >> "$host"_"$date".txt
cat /etc/security/pwquality.conf | grep -E "minlen|dcredit|ucredit|lcredit|ocredit" >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt

##### U-03 #######
# user lock limit 
pwq_c=`cat /etc/security/faillock.conf | grep 'deny' | grep -v "^#" | wc -l`
if [ "$pwq_c" -lt 1 ]
then
/usr/bin/cp /etc/security/faillock.conf /etc/security/faillock.conf_org
authselect current 
authselect enable-feature with-faillock
authselect create-profile -b sssd security-profile
authselect enable-feature with-faillock
sed -i "s/deny = 3/deny = 3\n deny = 5/g" /etc/security/faillock.conf 
authselect apply-changes
else
 echo ""
fi

echo "password complexity [ U-02 ]" >> "$host"_"$date".txt
echo "/etc/security/faillock.conf change config" >> "$host"_"$date".txt
cat /etc/security/faillock.conf  | grep -v '^#' >> "$host"_"$date".txt

echo "command faillock, user lockdown check [ faillock ]" >> "$host"_"$date".txt
echo "command faillock reset [ faillock --reset --user ( ex: admin ) ]" >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-04 #######
# shadow file permit check 

echo "shadow file permit check  [ U-04 ]" >> "$host"_"$date".txt
ls -l /etc/shadow >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-05 #######
# root home, PATH check

echo "root home, PATH check [ U-05 ]" >> "$host"_"$date".txt
echo '/etc/profile' >> "$host"_"$date".txt
cat /etc/profile | grep 'PATH' >> "$host"_"$date".txt
echo '/root/.bash_profile' >> "$host"_"$date".txt
cat /root/.bash_profile | grep 'PATH' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-06 #######
# nouser & nogroup file search 

echo " [nouser & nogroup file search  U-06 ]" >> "$host"_"$date".txt
echo "#### nouser ####" >> "$host"_"$date".txt
find / -nouser 2>/dev/null >> "$host"_"$date".txt
echo "#### nogroup ####" >> "$host"_"$date".txt
find / -nogroup 2>/dev/null >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-07 #######
# passwd file permit check

echo " [passwd file permit check U-07 ]" >> "$host"_"$date".txt
ls -l /etc/passwd >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-08 #######
# shadow file permit check

echo " [shadow file permit check U-08 ]" >> "$host"_"$date".txt
ls -l /etc/shadow >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-09 #######
# hosts permit check & change

echo " [hosts permit check & change U-09 ]" >> "$host"_"$date".txt
echo "#### original ####" >> "$host"_"$date".txt
ls -l /etc/hosts  >> "$host"_"$date".txt
chmod 600 /etc/hosts
echo "#### permit_change ####" >> "$host"_"$date".txt
ls -l /etc/hosts  >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-10 #######
# /etc/xinetd.conf file owner & permit check 

echo "/etc/xinetd.conf file owner & permit check [ U-10 ]" >> "$host"_"$date".txt
ls -la /etc/xinetd.conf >> "$host"_"$date".txt
ls -la /etc/xinetd.conf 2>> "$host"_"$date".txt
ls -la /etc/xinetd.d/ >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-11 #######
# /etc/rsyslog.conf file owner & permit check 

echo "/etc/rsyslog.conf file owner & permit check [ U-11 ]" >> "$host"_"$date".txt
echo "#### original ####" >> "$host"_"$date".txt
ls -l /etc/rsyslog.conf >> "$host"_"$date".txt
chmod 640 /etc/rsyslog.conf
echo "#### permit_change ####" >> "$host"_"$date".txt
ls -l /etc/rsyslog.conf >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-12 #######
# /etc/service file owner & permit check

echo "/etc/service file owner & permit check [ U-12 ]" >> "$host"_"$date".txt
ls -l /etc/services >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-13 #######
# SUID, SGID permit check 

echo "SUID, SGID permit check [ U-13 ]" >> "$host"_"$date".txt
find / -user root -type f \( -perm -4000 -o -perm -2000  \) \( -path '/usr' -prune \) -xdev -exec ls -al {} \; >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-14 #######
# user home directory profile owner & permit check

echo "user home directory profile owner & permit check [ U-14 ]" >> "$host"_"$date".txt
echo "user : root" >> "$host"_"$date".txt
ls -la /root/  >> "$host"_"$date".txt

cat /etc/passwd | awk -F':' '{ if ( $3 >= 1000 ) print $1 }' | grep -v 'nobody' |
while read user
do
echo "=================================" >> "$host"_"$date".txt
echo "user : $user" >> "$host"_"$date".txt
ls -la "/home/$user/" >> "$host"_"$date".txt
done

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-15 #######
# world writable file check

echo "world writable file check [ U-15 ]" >> "$host"_"$date".txt
find / ! \( \( -path '/proc' -o -path '/sys' \) -prune \) -type f -perm -2 -exec ls -l {} \; >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-16 #######
# /dev non-existent device file check

echo "/dev non-existent device file check [ U-16 ]" >> "$host"_"$date".txt
find /dev/ -type f -exec ls -l {} \; >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-17 #######
# /etc/hosts.equiv don`t use

echo "/etc/hosts.equiv dont use [ U-17 ]" >> "$host"_"$date".txt
ls -la /etc/hosts.* >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-18 #######
# access ip and port limit 

echo "access ip and port limit  [ U-18 ]" >> "$host"_"$date".txt

systemctl status firewalld.service >> "$host"_"$date".txt

ls -l /etc/hosts.* >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-19 #######
# finger service disable 

echo "finger service disable [ U-19 ]" >> "$host"_"$date".txt
rpm -qa | grep 'finger' >> "$host"_"$date".txt
ls -l /usr/sbin/ | grep 'fingerd' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-20 #######
# Anonymous FTP disable

echo "Anonymous FTP disable [ U-20 ]" >> "$host"_"$date".txt
rpm -qa | grep 'ftp' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-21 #######
# r-command service disable

echo "r-command service disable [ U-21 ]" >> "$host"_"$date".txt
ls -l /etc/xinetd.d/ >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-22 #######
# crond file owner & permit check

echo "crond file owner & permit check [ U-22 ]" >> "$host"_"$date".txt
touch /etc/cron.allow 
touch /etc/cron.deny
chmod 600 /etc/cron.allow
chmod 600 /etc/cron.deny

ls -l /etc/cron.allow >> "$host"_"$date".txt
ls -l /etc/cron.deny >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-23 #######
# DoS attack weak service disable

echo "DoS attack weak service disable [ U-23 ]" >> "$host"_"$date".txt
ls -la /etc/xinetd.d/ >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-24 #######
# NFS service disable

echo "NFS service disable [ U-24 ]" >> "$host"_"$date".txt
ps -ef | egrep "nfs|statd|lockd" | grep -v "grep" >> "$host"_"$date".txt
systemctl status nfs-server >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-25 #######
# NFS access control

echo "NFS access control [ U-25 ]" >> "$host"_"$date".txt
echo "NFS config file permit" >> "$host"_"$date".txt
ls -l /etc/exports >> "$host"_"$date".txt
echo "NFS config setting" >> "$host"_"$date".txt
cat /etc/exports >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-26 #######
# automountd service disable

echo "automountd service disable [ U-26 ]" >> "$host"_"$date".txt
systemctl status autofs.service >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-27 #######
# RPC service check

echo "RPC service check [ U-27 ]" >> "$host"_"$date".txt
ls -l /etc/xinetd.d/ >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-28 #######
# NIS service check

echo "NIS service check [ U-28 ]" >> "$host"_"$date".txt
ls -l /etc/xinetd.d/ >> "$host"_"$date".txt
ps -ef | egrep "ypserv|ypbind|ypxfrd|rpc.yppasswdd |rpc.ypupdated" >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-29 #######
# tftp, talk service check

echo "tftp, talk service check [ U-29 ]" >> "$host"_"$date".txt

ls -l /etc/xinetd.d/ >> "$host"_"$date".txt
ps -ef | egrep "tftp|talk" >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-30 #######
# sendmail service ( version ) check

echo "sendmail service ( version ) check [ U-30 ]" >> "$host"_"$date".txt
rpm -qa | grep 'sendmail' >> "$host"_"$date".txt
systemctl status sendmail >> "$host"_"$date".txt
systemctl status sendmail 2>> "$host"_"$date".txt
systemctl status postfix >> "$host"_"$date".txt
ss -napt | grep '25' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-31 #######
# sendmail relay limit

echo "sendmail relay limit [ U-31 ]" >> "$host"_"$date".txt
ls -l /etc/mail/sendmail.cf >> "$host"_"$date".txt
ls -l /etc/mail/sendmail.cf 2>> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-32 #######
# normal user sendmail run block

echo "normal user sendmail run block [ U-32 ]" >> "$host"_"$date".txt
ls -l /etc/mail/sendmail.cf >> "$host"_"$date".txt
ls -l /etc/mail/sendmail.cf 2>> "$host"_"$date".txt
ps -ef | grep sendmail | grep -v "grep" >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-33 #######
# bind use check

echo "bind use check [ U-33 ]" >> "$host"_"$date".txt
rpm -qa | grep 'named' >> "$host"_"$date".txt
systemctl status named >> "$host"_"$date".txt
systemctl status named 2>> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-34 #######
# bind zone transfer

echo "bind zone transfer [ U-34 ]" >> "$host"_"$date".txt
ps -ef | grep 'named' >> "$host"_"$date".txt
ls -l /etc/named* >> "$host"_"$date".txt
ls -l /etc/named* 2>> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-35 #######
# apache directory option check

echo "apache directory option check [ U-35 ]" >> "$host"_"$date".txt
grep 'Options' $apache_home/conf/httpd.conf | grep -v '#' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-36 #######
# apache User&Group

echo "apache User&Group [ U-36 ]" >> "$host"_"$date".txt
grep 'User' $apache_home/conf/httpd.conf | grep -v '#' | grep -v 'Log' >> "$host"_"$date".txt
grep 'Group' $apache_home/conf/httpd.conf | grep -v '#' | grep -v 'Log' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-37 #######
# apache AllowOverride check

echo "apache AllowOverride check [ U-37 ]" >> "$host"_"$date".txt
grep 'AllowOverride' $apache_home/conf/httpd.conf | grep -v '#' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-38 #######
# apache unnecessarily file or directory check

echo "apache unnecessarily file or directory check [ U-38 ]" >> "$host"_"$date".txt
ls -ld $apache_home/htdocs/manual >> "$host"_"$date".txt
ls -ld $apache_home/manual >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-39 #######
# apache Symbolic link, aliases use deny

echo "apache Symbolic link, aliases use deny [ U-39 ]" >> "$host"_"$date".txt
grep 'Options' $apache_home/conf/httpd.conf | grep -v '#' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-40 #######
# apache file upload&download limit

echo "apache file upload&download limit [ U-40 ]" >> "$host"_"$date".txt
grep 'LimitRequestBody' $apache_home/conf/httpd.conf | grep -v '#' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-41 #######
# apache DocumentRoot check

echo "apache DocumentRoot check [ U-41 ]" >> "$host"_"$date".txt
grep 'DocumentRoot' $apache_home/conf/httpd.conf | grep -v '#' > apache_DocumentRoot.txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-42 #######
# the newest OS version

echo "the newest OS version [ U-42 ]" >> "$host"_"$date".txt
cat /etc/redhat-release >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-43 #######
# log review and reporting

echo "log review and reporting [ U-43 ]" >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-44 #######
# only root use uid 0

echo "only root use uid 0 [ U-44 ]" >> "$host"_"$date".txt
cat /etc/passwd | awk -F":" '{ if ( 0 == $3 ) print $1 }' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-45 #######
# root su limit

echo "root su limit [ U-45 ]" >> "$host"_"$date".txt

if [ -f "/etc/pam.d/su_org" ] ;
then
echo ""
else
/usr/bin/cp /etc/pam.d/su /etc/pam.d/su_org
fi

cat << EOF > /etc/pam.d/su
#%PAM-1.0
auth            required        pam_env.so
auth            sufficient      pam_rootok.so
# Uncomment the following line to implicitly trust users in the "wheel" group.
#auth           sufficient      pam_wheel.so trust use_uid
# Uncomment the following line to require a user to be in the "wheel" group.
auth           required        pam_wheel.so use_uid
auth            substack        system-auth
auth            include         postlogin
account         sufficient      pam_succeed_if.so uid = 0 use_uid quiet
account         include         system-auth
password        include         system-auth
session         include         system-auth
session         include         postlogin
session         optional        pam_xauth.so
EOF

sed -i "s/wheel:x:10:/wheel:x:10:root,$su_user/g" /etc/group

chown root:wheel /usr/bin/su
chmod 4750 /usr/bin/su

cat /etc/group | grep 'wheel' >> "$host"_"$date".txt
ls -l  /usr/bin/su >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt

if [ -f "/etc/login.defs_org" ] ;
then
echo ""
else
/usr/bin/cp /etc/login.defs /etc/login.defs_org
fi

cat << EOF > /etc/login.defs 
#
# Please note that the parameters in this configuration file control the
# behavior of the tools from the shadow-utils component. None of these
# tools uses the PAM mechanism, and the utilities that use PAM (such as the
# passwd command) should therefore be configured elsewhere. Refer to
# /etc/pam.d/system-auth for more information.
#

# *REQUIRED*
#   Directory where mailboxes reside, _or_ name of file, relative to the
#   home directory.  If you _do_ define both, MAIL_DIR takes precedence.
#   QMAIL_DIR is for Qmail
#
#QMAIL_DIR      Maildir
MAIL_DIR        /var/spool/mail
#MAIL_FILE      .mail

# Default initial "umask" value used by login(1) on non-PAM enabled systems.
# Default "umask" value for pam_umask(8) on PAM enabled systems.
# UMASK is also used by useradd(8) and newusers(8) to set the mode for new
# home directories if HOME_MODE is not set.
# 022 is the default value, but 027, or even 077, could be considered
# for increased privacy. There is no One True Answer here: each sysadmin
# must make up their mind.
UMASK           022

# HOME_MODE is used by useradd(8) and newusers(8) to set the mode for new
# home directories.
# If HOME_MODE is not set, the value of UMASK is used to create the mode.
HOME_MODE       0700

# Password aging controls:
#
#       PASS_MAX_DAYS   Maximum number of days a password may be used.
#       PASS_MIN_DAYS   Minimum number of days allowed between password changes.
#       PASS_MIN_LEN    Minimum acceptable password length.
#       PASS_WARN_AGE   Number of days warning given before a password expires.
#
PASS_MAX_DAYS   90
PASS_MIN_DAYS   1
PASS_MIN_LEN    8
PASS_WARN_AGE   7

#
# Min/max values for automatic uid selection in useradd
#
UID_MIN                  1000
UID_MAX                 60000
# System accounts
SYS_UID_MIN               201
SYS_UID_MAX               999

#
# Min/max values for automatic gid selection in groupadd
#
GID_MIN                  1000
GID_MAX                 60000
# System accounts
SYS_GID_MIN               201
SYS_GID_MAX               999

#
# If defined, this command is run when removing a user.
# It should remove any at/cron/print jobs etc. owned by
# the user to be removed (passed as the first argument).
#
#USERDEL_CMD    /usr/sbin/userdel_local

#
# If useradd should create home directories for users by default
# On RH systems, we do. This option is overridden with the -m flag on
# useradd command line.
#
CREATE_HOME     yes

# This enables userdel to remove user groups if no members exist.
#
USERGROUPS_ENAB yes

# Use SHA512 to encrypt password.
ENCRYPT_METHOD SHA512

EOF
##### U-46 #######
# PASS_MIN_LEN 8
echo "PASS_MIN_LEN [ U-46 ]" >> "$host"_"$date".txt
cat /etc/login.defs | grep "PASS_MIN_LEN" | grep -v '^#' >> "$host"_"$date".txt
##### U-47 #######
# PASS_MAX_DAYS 90
echo "PASS_MAX_USE_DAYS [ U-47 ]" >> "$host"_"$date".txt
cat /etc/login.defs | grep "PASS_MAX_DAYS" | grep -v '^#' >> "$host"_"$date".txt
##### U-48 #######
# PASS_MIN_DAYS 1
echo "PASS_MIN_USE_DAYS [ U-48 ]" >> "$host"_"$date".txt
cat /etc/login.defs | grep "PASS_MIN_DAYS" | grep -v '^#' >> "$host"_"$date".txt


echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-49 #######
# user not use remove

echo "user not use remove [ U-49 ]" >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-50 #######
# admin group minimum user

echo "admin group minimum user [ U-50 ]" >> "$host"_"$date".txt
cat /etc/group | grep 'root' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-51 #######
# Prevent GIDs that do not exist for users

echo "Remove user-free groups [ U-51 ]" >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-52 #######
# user same uid check

echo "user same uid check [ U-52 ]" >> "$host"_"$date".txt
cat /etc/passwd | awk -F":" '{  print $1"-" $3 }' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-53 #######
# user shell check

echo "user shell check [ U-53 ]" >> "$host"_"$date".txt
cat /etc/passwd | grep -v '/sbin/nologin' | grep -v '/bin/false' | grep -v 'sync' | grep -v 'shutdown' | grep -v 'halt' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-54 #######
# Session Timeout setting

echo "Session Timeout setting [ U-54 ]" >> "$host"_"$date".txt



TMO=`cat /etc/profile | grep -i 'TMOUT' | grep -v "^#" | wc -l`
if [ "$TMO" -lt 1 ]
then
cat << EOF >> /etc/profile
##### time out setting ######
TMOUT=600
export TMOUT
EOF
else
 echo ""
fi

cat /etc/profile | grep 'TMOUT' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-55 #######
# hosts.lpd file owner & permit check

echo "hosts.lpd file owner & permit check [ U-55 ]" >> "$host"_"$date".txt
ls -l /etc/hosts.lpd >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-56 #######
# umask check

echo "umask check [ U-56 ]" >> "$host"_"$date".txt
cat /etc/profile | grep -i 'umask' | grep -v '#' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-57 #######
# user home directory owner check

echo "user home directory owner check [ U-57 ]" >> "$host"_"$date".txt

cat /etc/passwd | awk -F':' '{ if ( $3 >= 1000 ) print $1 }' | grep -v 'nobody' |
while read user
do
echo "user : $user" >> "$host"_"$date".txt
ls -ld "/home/$user/" >> "$host"_"$date".txt
done

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-58 #######
# user home & profile home match

echo "user profile home check [ U-58 ]" >> "$host"_"$date".txt
cat /etc/passwd | awk -F':' '{ if ( $3 >= 1000 ) print $1"-"$6 }' | grep -v 'nobody' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-59 #######
# hide file or directory check

echo "hide file or directory check [ U-59 ]" >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-60 #######
# use sshd allow

echo "use sshd allow [ U-60 ]" >> "$host"_"$date".txt
systemctl status sshd >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-61 #######
# use ftp service check

echo "use ftp check [ U-61 ]" >> "$host"_"$date".txt
ps -ef | grep 'ftp' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-62 #######
# ftp user shell check

echo "ftp user shell check [ U-62 ]" >> "$host"_"$date".txt
cat /etc/passwd | grep 'ftp' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-63 #######
# ftpusers file owner check

echo "ftpusers file owner check [ U-63 ]" >> "$host"_"$date".txt
find / -name 'ftpusers' -exec ls -l {} \; >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-64 #######
# ftp service root access

echo "ftp service root access [ U-64 ]" >> "$host"_"$date".txt
ls -la /etc/ftpusers >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-65 #######
# at file permit

echo "at file permit [ U-65 ]" >> "$host"_"$date".txt
touch /etc/at.allow
touch /etc/at.deny
chmod 600 /etc/at.allow
chmod 600 /etc/at.deny

ls -l /etc/at.allow >> "$host"_"$date".txt
ls -l /etc/at.deny >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-66 #######
# snmp use check

echo "snmp use check [ U-66 ]" >> "$host"_"$date".txt
systemctl status snmpd >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-67 #######
# snmp config 

echo "snmp config  [ U-67 ]" >> "$host"_"$date".txt
cat /etc/snmp/snmpd.conf  | grep -v '^#' | sed '/^$/d' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-68 #######
# login warning message

echo "login warning message [ U-68 ]" >> "$host"_"$date".txt
echo "$motd" > /etc/motd
echo "$motd" > /etc/issue
echo "$motd" > /etc/issue.net

echo '#### /etc/motd ####' >> "$host"_"$date".txt
cat /etc/motd >> "$host"_"$date".txt
echo '#### /etc/issue ####' >> "$host"_"$date".txt
cat /etc/issue >> "$host"_"$date".txt
echo '#### /etc/issue.net ####' >> "$host"_"$date".txt
cat /etc/issue.net >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-69 #######
# nfs config permit 

echo "nfs config permit [ U-69 ]" >> "$host"_"$date".txt
ls -l /etc/exports >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-70 #######
# smtp - expn, vrfy deny

echo "smtp - expn, vrfy deny [ U-70 ]" >> "$host"_"$date".txt
ls -l /etc/mail/sendmail.cf >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-71 #######
# apache version hide

echo "apache version hide [ U-71 ]" >> "$host"_"$date".txt
grep 'ServerTokens' $apache_home/conf/httpd.conf | grep -v '#' >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt
##### U-72 #######
# rsyslog config

echo "rsyslog config [ U-72 ]" >> "$host"_"$date".txt
echo '*.alert                                                 /dev/console' >> /etc/rsyslog.conf

echo '#### /etc/rsyslog.conf ####' >> "$host"_"$date".txt
cat /etc/rsyslog.conf >> "$host"_"$date".txt

echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt

##### other #######
# gcc permit check

echo "### gcc permit check ###" >> "$host"_"$date".txt

echo "#### original ####" >> "$host"_"$date".txt
ls -l /usr/bin/gcc >> "$host"_"$date".txt

chmod o-x /usr/bin/gcc

echo "#### permit_change ####" >> "$host"_"$date".txt
ls -l /usr/bin/gcc >> "$host"_"$date".txt


echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt

##### other #######
# system log excessive permit check

echo "### system log excessive permit check ###" >> "$host"_"$date".txt

echo "#### original ####" >> "$host"_"$date".txt
ls -l /var/log | grep -v '^d' >> "$host"_"$date".txt

sed -i "s/664/644/g" /etc/logrotate.d/wtmp 
cat << EOF > /etc/logrotate.d/lastlog
/var/log/lastlog {
    missingok
    monthly
    create 0644 root utmp
    minsize 1M
    rotate 1
}
EOF

find /var/log/ -type f -perm /g=w -exec chmod g-w {} \;

echo "#### permit_change ####" >> "$host"_"$date".txt
ls -l /var/log | grep -v '^d' >> "$host"_"$date".txt


echo "" >> "$host"_"$date".txt
echo "========================================================================================" >> "$host"_"$date".txt
echo "" >> "$host"_"$date".txt