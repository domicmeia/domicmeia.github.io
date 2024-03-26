+++
title = "[OS]Server Troubleshooting"
date = 2024-03-26T17:14:42+09:00
tags = ["Troubleshooting", "OS"]
summary = "OS troubleshooting for No Power, No POST,and No Video issues"
+++
> This post was written for `studying`. There maybe a lot wrong going on.

## 목차
* [Concepts](#concepts)
* [Troubleshooting](#troubleshooting)
  + [No Power](#no-power-1)
  + [No Boot](#no-boot-1)

---

# Concepts
---

## No Power

Once the power button is pressed, no diagnostics LEDs are illuminated. The power button LED is also not illuminated. The system has no signs of power. The fan remains silent as it is not spinning. The iDRAC should not respond to poings. This is the defined as no power.

## No POST(Power On Self-Test)

Your system appears to have power, but deos not complete POST once the power button is pressed. During POST, the system goes through a series of internal checks. If any of these checks should fail, the system shows an error on the LCD if present, or have LEDs illuminated to help indicate the potential problem. This is defiend as no POST.

## NO Boot

Once the system has loaded and finishes the POST checks, the system operation hands over to the operating system. If the operating system does not start for any reason, this is called a No Boot issue. A common symptom is also that there are not any boot device available, and the following error is displayed: "No boot device found". This also occurs if the virtual disks are not online due to hard drive or PERC issue.

## iDRAC
iDRAC stands for Integrated Dell Remote Access Controller. It is a management interface embedded into Dell servers that allows for remote monitoring and management of the server hardware, even when the server is powered off or unresponsive. iDRAC provides features such as remote power management, system monitoring, virtual media access, and remote console access.

With iDRAC, administrators can perform tasks such as powering the server on or off, rebooting the server, viewing hardware health status (such as temperature, fan speed, and power usage), accessing virtual media (such as CD/DVD drives), and even remotely accessing the server's console interface for troubleshooting purposes.

# SMART

In the context of a data center, SMART stands for Self-Monitoring, Analysis, and Reporting Technology. SMART is a feature available on most modern hard disk drives (HDDs) and solid-state drives (SSDs) that monitors various parameters related to the drive's health and performance.

SMART continuously monitors metrics such as temperature, spin-up time, seek error rate, and bad sector count. It uses these metrics to assess the overall health and reliability of the drive. If SMART detects any anomalies or signs of potential failure, it can generate warning messages or notifications to alert system administrators.

For example, SMART might detect an increase in the number of bad sectors on a drive, which could indicate deteriorating drive health. In such cases, SMART can trigger a warning message or flag the drive as at risk of failure. This allows administrators to take proactive measures, such as replacing the drive before it fails completely, to prevent data loss and minimize downtime.

Overall, SMART provides valuable insight into the health and performance of storage drives in a data center environment, enabling administrators to monitor drive reliability, predict potential failures, and implement timely maintenance or replacement strategies.

---

# Troubleshooting
---

**UPDATE THE BIOS AND IDRAC FIRMWARE TO THE LATEST VERSION**
Before starting troubleshooting, you should check the iDRAC logs for additional that can help with troubleshooting.

Log in to the iDRAC to view the log.


## No power

+ First remove both power cables and hold the power button in for ten seconds to drain any residual power.
+ Connect power cables to power supplies bypassing any UPS temporarily if being used. The LED should illuminate on the power supply unit(PSU). Press the PSU BIST.
+ If no PSU BIST LED's illuminate, check using knwon working power cables and wall outlets.

## No Post

> Minimum to POST configuration is the config that has the minimum components required to complete POST. Typically, the minimum to POST configuration for **rack servers** is **PSU1, CPU1, memory module in A1 slot, and the default riser without expansion cards**. For **tower servers**, the minimum to POST configuration is **PSU1, CPU1, and memory module in A1 slot**. For modular servers, the minimum to POST configuration is CPU1 and memory module in A1 slot.

+ Bring the server to minimum configuration for the POST.
+ Reconnect the power and video cable only.
+ Attemp to POST the server
 + plug the components one at a tiime until the defective part is found.

...

## No Boot

After the server completes the power-on self-test (POST) phase, it tries to boot a bootable device. A bootable device is any piece of hardware that can either read the files or contains the files that are required for a system to start. A default bootable media can be selected in the BIOS. By default, the raid controller card (PERC) is selected first. Files available in a bootable device (RAID, USB drive, DVD, ISO file) contain instructions to start the operating system. When these files cannot be found, the error "No Boot Device Available" is displayed.
A few actions can be performed to check what is not working properly.

The first thing to check is which device is selected as the primary boot. To do a quick check, use F11 to launch the manual boot selection.

+ **Restart the system.**
+ Press F11 during POST to enter the **Boot Manager.**
+ Select the correct Hard Disk drive (Virtual Drive), where the operating system is installed.
+ Boot from this device.

If the system now boots into the operating system, the hardware is fine, and there is a boot order conflict in the BIOS settings. The most likely cause for this is that the system is set to boot from CD, DVD, or USB before the drives, which is a logical setting. To resolve this, ensure you do not have a USB or CD or DVD inserted when powering on the system.

You can change the boot order setting permanently in the System Setup to boot from the drive first. To change this:

+ **Restart the system.**
+ Press F2 during system start to enter the System Settings.
+ Change the **Boot Sequence** in the **Boot Settings**.
+ Leave the menu using Exit in the upper right corner of the screen