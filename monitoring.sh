#/bin/bash
ARCHIT=$(uname -a)
CPU=$(grep "physical id" /proc/cpuinfo | uniq | wc -l) 
VCPU=$(nproc)
RAM_TOTAL=$(free -h | grep "Mem" | awk '{print $2}')
RAM_USED=$(free -h | grep "Mem" | awk '{print $3}')
RAM_PERC=$(free -k | grep "Mem" | awk '{printf("%2.f%%", $3 / $2 * 100)}')
DISC_TOTAL=$(df --total -h | grep "total" | awk '{print $2}')
DISC_USED=$(df --total -h | grep "total" | awk '{print $3}')
DISC_PERC=$(df --total -k | grep "total" | awk '{printf("%2.f%%", $3 / $2 * 100)}')
CPU_LOAD=$(top -bn1 | grep '^%Cpu' | awk '{printf("%.1f%%"), $2 + $4}')
LAST_BOOT=$(who -b | awk '{print $3 " " $4}')
LVM_USAGE=$(if [ $(lsblk | grep lvm | wc -l) -gt 0 ]; then echo yes; else echo no; fi)
CONNS=$(grep TCP /proc/net/sockstat | awk '{print $3}')
USER=$(who | wc -l)
MACADD=$(ip address show | grep "link/ether" | awk {'print $2'})
IPADD=$(hostname -I | tr -d " ")
SUDO=$(grep COMMAND /var/log/sudo/sudo.log | wc -l)

wall "
      #Architecture    : $ARCHIT
      #CPUs physcial   : $CPU
      #Virtual CPUs    : $VCPU
      #Memory Usage    : $RAM_USED/$RAM_TOTAL ($RAM_PERC)
      #Disk Usage      : $DISK_USED/$DISK_TOTAL ($DISK_PERC)
      #CPU Load        : $CPU_LOAD
      #Last Boot       : $LAST_BOOT
      #LVM use         : $LVM_USAGE
      #TCP Connections : $TCP ESTABLISHED
      #Users log       : $USER
      #Network         : $IPADD ($MACADD)
      #Sudo            : $SUDO cmds used
	"
