+++
title = "[OS]Issue with linux operating system"
date = 2024-03-25T21:26:07+09:00
tags = ["OS", "Troubleshooting"]
summary = "OS boot process and troubleshooting"
+++
> This post was written for `studying`. There maybe a lot wrong going on.

## 목차
* [Concepts] 
  + [Boot Process](#boot-process)
  + [Questions](#questions)
* [Troubleshooting](#troubleshooting)

---

# Boot Process
---

The boot process, also known a bootstrapping or booting, is the sequence of operations that a computer system perform when it is turned on or restarted. It is the process by which the operating system is loaded into the RAM and becomes available for user interaction.

## Power-On Self-Test(POST)

When the computer is powered on, POST checks various hardware such as the processor, memory, storage, and IO devices to ensure they are functioning correctly.

If any hardware issue are detected during POST, error messages may be displayed, and the boot process may halt.

## Initialization of BIOS and UEFI

After POST, the computer's firmware, either BIOS or UEFI, is initialized.

BIOS or UEFI sets up the system environmet and selects the boot device from which the OP will be loaded.

## Boot Device selection and Loading of Bootloader

The BIOS or UEFI identifiels the bood device specified in its configuration such as a HDD, SSD or network boot server.

The bootloader, which is small program stored on the boot device, is loaded into memory by the BIOS or UEFI.

The bootloader's primary function is to locate and load the operating system kernel into memory.

## Operating System Kernel Initialization

Once the bootloader has loaded the operating system kernel into memory, control is passed to the kernel.

The kernel initializes essential system services, device drivers, and hardware interfaces required for the OS to function.

Depending on the OS, initialization processes such as mounting file system, starting system daemons, and establishing network connection may also occur during this stage.

---

# Questions
---

## What are the minimum parts requires to boot up a server?

The minimum parts required to boot up a server typically include:

1. Moterboard: Provides the foundational circuitry and connections for other components.
2. CPU: Executes instructions and processes data.
3. RAM: Temporarily stores data and instructions needed by the CPU
4. Power Supply Unit: Supplies electrical power to the server components.
5. Storage Device: Conatins the OS and other necessary software. This could be a HDD, SSD or a network boot server in some cases.
6. BIOS or UEFI: Provides firmware to initialize hardware and facilitate the boot process.

## What tests can be run to determine the health of a server?

In a Linux server, administrators can use the syslog facility to monitor system logs for error messages and warnings. For instance, running the command:

```bash
tail -f /var/log/syslog
```

If there's a hardware issue such as disk I/O errors or memory failures, corresponding error messages will be logged here, helping administrators identify and diagnose the underlying problem. 

## How would you determine the health of a RAID array?

Check the health of individual drives in the RAID array. Look for SMART data provided by the drives to identify any signs of potential failure, such as reallocated sectors, pending sectors, or other SMART attributes indicating drive degradation.

---

# Troubleshooting
---

## How would you provision an operating system with and without physical access to a server?
Provisioning an operating system (OS) with and without physical access to a server involves different approaches and tools. Here's how you can do it in both scenarios:

### Provisioning with Physical Access to a Server:

1. **Using Installation Media**:
   - Obtain the installation media (e.g., DVD, USB drive) for the desired OS.
   - Insert the installation media into the server's optical drive or USB port.
   - Boot the server from the installation media.
   - Follow the on-screen prompts to select the installation options, partition the disk, and install the OS.

2. **Network Installation**:
   - Set up a network installation server (e.g., PXE server) on the local network.
   - Configure the server's BIOS or UEFI to boot from the network.
   - Boot the server, and it will obtain the OS installation files and instructions from the network installation server.
   - Follow the on-screen prompts to complete the OS installation.

3. **Remote Hands Assistance**:
   - If physical access to the server is limited but available, you can work with remote hands or on-site personnel to insert installation media, connect cables, and perform initial setup steps.

### Provisioning without Physical Access to a Server:

1. **Remote Installation Tools**:
   - Utilize remote management tools such as iLO (Integrated Lights-Out) for HPE servers, iDRAC (Integrated Dell Remote Access Controller) for Dell servers, or IPMI (Intelligent Platform Management Interface) for generic servers.
   - Connect to the server's remote management interface via a secure network connection.
   - Use virtual media capabilities to mount the OS installation ISO image remotely.
   - Power on the server and boot it from the virtual media.
   - Proceed with the OS installation as if physically present at the server.

2. **Cloud-based Provisioning**:
   - If the server is hosted in a cloud environment, such as AWS, Azure, or Google Cloud Platform, you can provision the OS using cloud management consoles or APIs.
   - Select the desired OS image from the cloud provider's marketplace or repository.
   - Configure the server instance with the desired specifications (e.g., CPU, memory, storage).
   - Initiate the provisioning process, and the cloud platform will automatically deploy the OS to the server instance.

3. **Pre-configured Images**:
   - Use pre-configured OS images provided by the server manufacturer or cloud provider.
   - Deploy these images to the server remotely using management consoles or deployment tools.
   - Customize the OS configuration as needed during the provisioning process.

In both scenarios, ensure that you have proper access credentials, network connectivity, and necessary permissions to perform the OS provisioning tasks effectively. Additionally, follow security best practices to protect sensitive data and maintain system integrity throughout the provisioning process.

## What would you do if a server boots but doesn't load an operating system?

## What would you do if a server doesn't make it past POST?

## What would you do if a server never reaches POST?

--> [Check the article][article]

[article]:https://domicmeia.github.io/post/hwtrouble/
