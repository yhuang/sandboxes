#!/usr/bin/env bash

function print_failure {
  echo $1: $2
}

function rpm_not_installed {
  local rpm=$1

  rpm -q $rpm | grep -q "package $rpm is not installed"

  if [[ $? -ne 0 ]]; then
    print_failure $FUNCNAME "package $rpm is installed"
    return 1
  fi
}

function check_service_enabled {
  local service=$1

  systemctl list-unit-files | grep -q $service

  if [[ $? -ne 0 ]]; then
    return
  fi

  systemctl is-enabled $service | grep -q 'enabled'

  if [[ $? -ne 0 ]]; then
    print_failure $FUNCNAME "$service is not enabled"
    return 1
  fi
}

function check_service_not_enabled {
  local service=$1

  systemctl list-unit-files | grep -q $service

  if [[ $? -ne 0 ]]; then
    return 0
  fi

  systemctl is-enabled $service | grep -qv 'enabled'

  if [[ $? -ne 0 ]]; then
    print_failure $FUNCNAME "$service is enabled"
    return 1
  fi
}

function rhel_06_000008 {
  local centos_key='gpg(CentOS-7 Key (CentOS 7 Official Signing Key) <security@centos.org>)'

  rpm -q --queryformat '%{NAME}-%{VERSION}-%{RELEASE}\t%{SUMMARY}\n' gpg-pubkey | grep -q "$centos_key"

  if [[ $? -ne 0 ]]; then
    print_failure $FUNCNAME "Centos 7 official signing key not installed"
    return 1
  fi
}

function rhel_06_000019 {
  local count=0

  if [ -f /etc/hosts.equiv ]; then
    count=$[$count +1]
    print_failure $FUNCNAME "/etc/hosts.equiv exists"
  fi

  for i in `cat /etc/passwd | awk -F":" '{ print $5 }'`; do
    rhosts_file=`eval echo "~$i"`/.rhosts

    if [ -f $rhosts_file ]; then
      count=$[$count +1]
      print_failure $FUNCNAME "$rhosts_file exists"
    fi
  done

  return $count
}

function rhel_06_000030 {
  local count=0

  for i in `ls /etc/pam.d/*`; do
    grep 'nullok' $i > /dev/null

    if [[ $? -eq 0 ]]; then
      count=$[$count +1]
      print_failure $FUNCNAME "$i has nullok"
    fi
  done

  return $count
}

function rhel_06_000206 {
  rpm_not_installed telnet-server
}

function rhel_06_000211 {
  check_service_not_enabled telnet.socket
}

function rhel_06_000213 {
  rpm_not_installed rsh-server
}

function rhel_06_000214 {
  check_service_not_enabled rsh.socket
}

function rhel_06_000216 {
  check_service_not_enabled rexec.socket
}

function rhel_06_000218 {
  check_service_not_enabled rlogin.socket
}

function rhel_06_000227 {
  local sshd_config=/etc/ssh/sshd_config

  grep -v "^#" $sshd_config | grep -q "Protocol 2"

  if [[ $? -ne 0 ]]; then
    print_failure $FUNCNAME "sshd not configured to use only the SSHv2 protocol"
    return 1
  fi
}

function rhel_06_000239 {
  local sshd_config=/etc/ssh/sshd_config

  grep -q -i PermitEmptyPasswords $sshd_config

  if [[ $? -ne 0 ]]; then
    return
  fi

  grep -v "^#" $sshd_config | grep -q -i -E "PermitEmptyPasswords\s+yes"

  if [[ $? -ne 1 ]]; then
    print_failure $FUNCNAME "empty passwords allowed"
    return 1
  fi
}

# function rhel_06_000284 {
# }

function rhel_06_000286 {
  check_service_not_enabled ctrl-alt-del.target
}

function rhel_06_000309 {
  grep insecure_locks /etc/exports > /dev/null

  if [[ $? -eq 0 ]]; then
    print_failure $FUNCNAME "nfs insecure_locks option detected"
    return 1
  fi
}

function rhel_06_000338 {
  local tftp_service=/usr/lib/systemd/system/tftp.service

  if [ ! -f $tftp_service ]; then
    return 0
  fi

  grep -q -i -E "ExecStart=.*tftpd\s+\-s" $tftp_service

  if [[ $? -ne 0 ]]; then
    print_failure $FUNCNAME "tftp is not configured by with the '-s' flag"
    return 1
  fi
}

function rhel_06_000341 {
  local snmpd_conf=/etc/snmp/snmpd.conf

  grep -v "^#" $snmpd_conf | grep -q public

  if [[ $? -eq 0 ]]; then
    print_failure $FUNCNAME "$snmpd_conf uses default password 'public'"
    return 1
  fi
}

function rhel_06_000514 {
  local count=0

  local yum_conf=/etc/yum.conf
  grep -q 'gpgcheck=0' $yum_conf

  if [[ $? -eq 0 ]]; then
    count=$[$count +1]
    print_failure $FUNCNAME "detected gpgcheck=0 in $yum_conf"
  fi

  for i in `ls /etc/yum.repos.d/*`; do
    grep -q 'gpgcheck=0' $i

    if [[ $? -eq 0 ]]; then
      count=$[$count +1]
      print_failure $FUNCNAME "detected gpgcheck=0 in $i"
    fi
  done

  for i in /etc/rpmrc /usr/lib/rpm/rpmrc /usr/lib/rpm/redhat/rpmrc /root/.rpmrc; do
    if [ ! -f $i ]; then
      continue
    fi

    grep -q nosignature $i

    if [[ $? -eq 0 ]]; then
      count=$[$count +1]
      print_failure $FUNCNAME "detected nosignature in $i"
    fi
  done

  return $count
}

function func_wrapper {
  func_name=$1
  shift
  args=$@
  ${func_name} ${args}
  if [[ $? -eq 0 ]]; then
    echo ${func_name} ${args} PASSED
    echo
  else
    echo ${func_name} ${args} FAILED
    echo
  fi
}

function main {
  func_wrapper rhel_06_000008
  func_wrapper rhel_06_000019
  func_wrapper rhel_06_000030
  func_wrapper rhel_06_000206
  func_wrapper rhel_06_000211
  func_wrapper rhel_06_000213
  func_wrapper rhel_06_000214
  func_wrapper rhel_06_000216
  func_wrapper rhel_06_000218
  func_wrapper rhel_06_000227
  func_wrapper rhel_06_000239
  #func_wrapper rhel_06_000284
  func_wrapper rhel_06_000286
  func_wrapper rhel_06_000309
  func_wrapper rhel_06_000338
  func_wrapper rhel_06_000341
  func_wrapper rhel_06_000514
}

main
