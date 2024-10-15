+++
title = "[OS]Linux Troubleshooting Scenarios"
date = 2024-10-13T19:07:31+09:00
tags = ["Linux", "Troubleshooting"]
summary = "Linux Troubleshooting Scenarios"
+++
> This post was written for `studying`. There maybe a lot wrong going on.

## 목차
* [Filesystem Full, but `df` Shows Free Space](#filesystem-full-but-df-shows-free-space)
* [System Boots to Read-Only Filesystem](#system-boots-to-read-only-filesystem)
* [Process Consumes 100% CPU](#process-consumes-100-cpu)
* [Kernel Panic after System Update](#kernel-panic-after-system-update)
* [Slow Performance on Identical Systems](#slow-performance-on-identical-systems)
* [Disk I/O Bottleneck](#disk-io-bottleneck)
* [Out of Memory (OOM) Killer Triggered](#out-of-memory-oom-killer-triggered)
* [Unresponsive Server](#unresponsive-server)
* [Corrupted Filesystem](#corrupted-filesystem)
* [Permission Denied Errors Despite Correct Permissions](#permission-denied-errors-despite-correct-permissions)
* [NFS Mount Unavailable](#nfs-mount-unavailable)

---

### **Filesystem Full, but `df` Shows Free Space**
   **Scenario**: A system is experiencing errors like "No space left on device," but when you run the `df` command, it shows that there's still free space on the filesystem.
   - **Question**: What could be the cause of this issue, and how would you resolve it?
   - **Answer**:
     - Check for **open file descriptors**: Even though files are deleted, if they are still being accessed by processes, space won't be freed until those processes are terminated (`lsof` to check for open files).
     - Investigate **inodes usage**: `df -i` can show if the system is out of inodes, which can also result in a "No space left" error.
     - Look for files in **hidden directories** like `/tmp` or `/var/tmp`.

### **System Boots to Read-Only Filesystem**
   **Scenario**: Your Linux system boots up, but the root filesystem is mounted as read-only, preventing normal operations.
   - **Question**: What steps would you take to troubleshoot and fix this issue?
   - **Answer**:
     - Check system logs (`dmesg`, `/var/log/messages`) for **disk errors** or signs of filesystem corruption.
     - Run `fsck` on the affected filesystem after booting into single-user mode or using a rescue disk to repair corruption.
     - Verify mount options in `/etc/fstab` and ensure that the filesystem isn't intentionally mounted as read-only.

### **Process Consumes 100% CPU**
   **Scenario**: A system is running slowly, and you notice that one process is consuming 100% of the CPU.
   - **Question**: How would you troubleshoot and resolve the issue?
   - **Answer**:
     - Use `top` or `htop` to identify the process causing the high CPU usage.
     - Investigate the process with `ps` or `strace` to check what it is doing.
     - If it is a runaway process or hung process, consider killing it with `kill` or `kill -9`.
     - Analyze log files related to the process or its service to understand why it is consuming high CPU.
  
### **Kernel Panic after System Update**
   **Scenario**: After performing a system update, your Linux system fails to boot and you encounter a **kernel panic** error.
   - **Question**: How would you troubleshoot and resolve this issue?
   - **Answer**:
     - Boot into a previous working kernel via the **GRUB menu**.
     - Analyze logs such as `/var/log/kern.log` or `journalctl -xe` for details about the panic.
     - Use `kdump` to analyze the core dump if configured.
     - If it's related to the new kernel, roll back the update or reinstall the previous working kernel.

### **Slow Performance on Identical Systems**
   **Scenario**: Two identical servers (same hardware, software, configuration) are set up. However, one server is noticeably slower than the other.
   - **Question**: What steps would you take to identify the cause of the performance issue?
   - **Answer**:
     - Use `top` or `htop` to monitor resource utilization (CPU, memory, disk I/O) on both systems.
     - Check for **disk errors** using `dmesg` or `smartctl` to ensure that hardware failures aren’t causing slow I/O.
     - Compare network configurations (`ifconfig`, `netstat`) and check for any packet loss or interface issues.
     - Ensure that both systems have the same **kernel parameters**, CPU frequency scaling settings, and power management configurations (`cpufreq-info`).
     - Investigate for **overloaded services** or applications on the slower machine using `systemctl` and logs.

### **Disk I/O Bottleneck**
   **Scenario**: A database running on a Linux server is experiencing performance degradation due to high disk I/O.
   - **Question**: How would you identify and mitigate the disk I/O bottleneck?
   - **Answer**:
     - Use `iostat` to monitor I/O operations and identify which disks are experiencing high usage.
     - Check for processes causing high I/O usage with `iotop`.
     - Tune I/O scheduler settings (`cfq`, `deadline`, `noop`) to optimize performance.
     - Verify that the disk subsystem (RAID, SSD) is configured optimally, and consider adding more disks or switching to a faster storage medium (e.g., SSDs).
     - Consider moving the database or data to another storage device or using tools like **LVM** to spread the I/O load across multiple devices.

### **Out of Memory (OOM) Killer Triggered**
   **Scenario**: Your Linux server has terminated a critical process due to the Out-of-Memory (OOM) killer.
   - **Question**: How would you investigate the cause of the OOM event and prevent it from happening again?
   - **Answer**:
     - Review `/var/log/messages` or `dmesg` output for OOM killer logs to see which process was killed and why.
     - Use `free` or `vmstat` to check memory usage and see if the system is running out of RAM.
     - Investigate the memory usage of processes using `top`, `htop`, or `ps aux --sort=-%mem`.
     - Identify and optimize memory-hungry applications.
     - Adjust the `vm.swappiness` kernel parameter or add more swap space if applicable.
     - Protect critical processes from being killed by the OOM killer using `oom_score_adj`.

### **Unresponsive Server**
   **Scenario**: A server has become unresponsive, and you cannot SSH into it. What actions would you take to troubleshoot the issue?
   - **Question**: How would you troubleshoot an unresponsive Linux server remotely or onsite?
   - **Answer**:
     - First, attempt to access the server via **Out-of-Band (OOB) management** like iLO, DRAC, or IPMI.
     - Check the network status and verify if the server is accessible via **ping** or if other services are reachable.
     - If onsite access is possible, connect directly to the console and check the system state with `dmesg` or `journalctl`.
     - Investigate the possibility of high load (`uptime`, `top`), a runaway process, or a full filesystem (`df -h`).
     - Restart any unresponsive services via the console or consider rebooting the server as a last resort.

### **Corrupted Filesystem**
   **Scenario**: A production server is unable to mount a specific partition, and you suspect filesystem corruption.
   - **Question**: How would you proceed to troubleshoot and recover from this issue?
   - **Answer**:
     - Check system logs (`dmesg`, `/var/log/messages`) for any errors related to the filesystem.
     - Use `fsck` to check and repair the filesystem, ensuring the partition is unmounted first (`umount /dev/sdX`).
     - If `fsck` cannot repair the filesystem, consider restoring from backups or mounting the filesystem in read-only mode to recover important data.
     - Investigate the root cause, such as a hardware failure (check with `smartctl`), or improper shutdown.

### **Permission Denied Errors Despite Correct Permissions**
   **Scenario**: A user is reporting "Permission Denied" errors when accessing a file, despite having the correct read/write permissions.
   - **Question**: How would you troubleshoot this issue?
   - **Answer**:
     - Verify file and directory permissions using `ls -l` and `stat`.
     - Check for **ACLs (Access Control Lists)** using `getfacl`.
     - Inspect the **SELinux** or **AppArmor** context using `ls -Z` (SELinux) or `aa-status` (AppArmor) to see if security policies are blocking access.
     - Investigate any **mount options** that might restrict access, such as `noexec` or `nosuid` in `/etc/fstab`.

### **NFS Mount Unavailable**
   **Scenario**: A remote NFS share is mounted on the server but has suddenly become unavailable.
   - **Question**: How would you troubleshoot and restore access to the NFS share?
   - **Answer**:
     - Check network connectivity between the server and NFS server using `ping` or `traceroute`.
     - Verify that the NFS server is up and running, and check if the NFS service is active (`systemctl status nfs-server`).
     - Ensure that the NFS export is properly configured on the server by reviewing `/etc/exports` on the NFS server.
     - Try remounting the NFS share with `mount -a` or manually unmount and remount it (`umount /mnt/nfs`, `mount /mnt/nfs`).
     - Look for errors in logs (`/var/log/messages`, `dmesg`).
