+++
title = "[OS]Boot Process and Linux"
date = 2024-03-25T21:26:07+09:00
tags = ["OS", "Linux"]
summary = "OS boot process and troubleshooting"
+++
> This post was written for `studying`. There maybe a lot wrong going on.

## 목차
* Concepts
  + [Boot Process](#general-boot-process)
  + [Linux Boot Process](#linux-boot-process)
     + [GRUB/LILO](#grublilo)
* [Troubleshooting](#troubleshooting)
* [Linux Filesystem]

---

# General Boot Process
---

The boot process is the sequence of operations that a computer system perform when it is turned on or restarted. It is the process by which the operating system is **loaded into the RAM** and becomes available for user interaction.

## Power-On Self-Test(POST)

When the computer is powered on, POST checks various hardware such as the processor, memory, storage, and IO devices to ensure they are functioning correctly. If any hardware issue are detected during POST, error messages may be displayed, and the boot process may halt.

## Initialization of BIOS and UEFI

After POST, the computer's firmware, either BIOS or UEFI, is initialized. BIOS or UEFI sets up the system environmet and selects the boot device from which the OP will be loaded.

## Boot Device selection and Loading of Bootloader

The BIOS or UEFI identifiels the bood device specified in its configuration such as a HDD, SSD or network boot server. The bootloader, which is small program stored on the boot device, is loaded into memory by the BIOS or UEFI. The bootloader's primary function is to locate and load the operating system kernel into memory.

## Operating System Kernel Initialization

Once the bootloader has loaded the operating system kernel into memory, control is passed to the kernel. The kernel initializes essential system services, device drivers, and hardware interfaces required for the OS to function. Depending on the OS, initialization processes such as mounting file system, starting system daemons, and establishing network connection may also occur during this stage.

---

# Linux Boot Process
---

1. **BIOS/UEFI**:
   - When you power on your computer, the BIOS or UEFI firmware is the first code that runs.
   - BIOS has been a standard firmware interface for PCs for many years. UEFI (Unified Extensible Firmware Interface) is a more modern replacement for BIOS, offering advanced features and capabilities.
   - The BIOS/UEFI conducts POST to check the hardware components, including the CPU, memory, storage devices, and peripherals, to ensure they are functioning correctly.
   - It locates and loads the bootloader from a bootable device such as a hard drive, SSD, USB drive, or network interface card (via PXE boot).

2. **Bootloader (GRUB)**:
   - The bootloader, commonly GRUB (Grand Unified Bootloader), is loaded by the BIOS/UEFI from the designated boot device.
   - GRUB presents a menu (if configured) allowing the user to choose which operating system or kernel to boot if multiple options are available.
   - It locates the Linux kernel and its initial RAM disk (initramfs/initrd), which contains essential drivers and utilities needed to mount the root filesystem.
   - GRUB then hands over control to the Linux kernel.

3. **Linux Kernel**:
   - The Linux kernel is loaded into memory by the bootloader.
   - It initializes the hardware components such as CPU, memory, storage devices, and peripherals.
   - The kernel mounts the initial RAM disk (initramfs/initrd) into memory, which contains essential modules and utilities required to mount the root filesystem.
   - It sets up the memory management, scheduler, process management, and other core subsystems of the operating system.
   - Once initialization is complete, the kernel launches the init process.

4. **Init Process**:
   - Traditionally, the init process was responsible for initializing the system and starting system services. However, many modern Linux distributions have replaced the traditional init system with systemd or other alternatives.
   - systemd is a system and service manager that handles the initialization, management, and control of system services and processes.
   - systemd reads configuration files, known as unit files, which define how services, sockets, devices, and other system resources are managed.
   - It starts system services concurrently, improving boot time and system responsiveness.

5. **User Space Initialization**:
   - After the init process or systemd has completed its tasks, the user space is initialized.
   - System daemons, such as networking services, syslog, and time synchronization services, are started.
   - Depending on the configuration, a graphical login manager may be launched to provide a graphical login interface, or a text-based login prompt is presented on the console.

6. **Login**:
   - Once the system is fully initialized, it presents the user with a login prompt.
   - Users can log in with their credentials (username and password) to access the system.
   - After successful authentication, the user is presented with a shell or a graphical desktop environment, depending on the system configuration and user preferences.

## GRUB/LILO
GRUB (GRand Unified Bootloader) and LILO (LInux LOader) are both boot loaders commonly used in Linux-based operating systems to initiate the boot process. They play a crucial role in loading the operating system kernel into memory and transferring control to it during system startup. 

**GRUB (GRand Unified Bootloader)**:
   - GRUB is one of the most widely used boot loaders in the Linux ecosystem.
   - It is flexible and powerful, offering features such as multi-boot support, menu-driven interface, and the ability to load kernels from various file systems including ext4, Btrfs, and others.
   - GRUB supports both BIOS (Legacy) and UEFI firmware interfaces, making it compatible with a wide range of hardware platforms.
   - Configuration for GRUB is typically stored in a file called `grub.cfg` or `menu.lst`, where users can specify boot options, kernel parameters, and boot menu configurations.
   - GRUB can be installed to the Master Boot Record (MBR) or the EFI System Partition (ESP) depending on the system's firmware type.
   - GRUB is actively maintained and regularly updated, making it a reliable choice for managing the boot process in Linux systems.

In summary, while both GRUB and LILO serve the purpose of boot loading in Linux systems, GRUB is the more flexible and feature-rich option, offering support for a wide range of configurations and hardware platforms. LILO, on the other hand, is a simpler boot loader that was popular in the past but has largely been superseded by GRUB in modern Linux distributions.

---

# Troubleshooting
---

In data centers, I may not have physical access to the server. So i have to use the OOB management tools such as a serial console, IMPI, or a KVM swtich to access to console and observe error message during the boot process, particulary kernel panic messages, file system errors, or hardware-related issues.

## What would you do if a server boots but doesn't load an operating system?

## What would you do if a server doesn't make it past POST?

## What would you do if a server never reaches POST?

--> [Check the article][article]

---

# Troubleshooting
---

### inodes
An **inode** is a data structure hat holds metadata about a file such as permissions, timestamps, and file size. Each file has an associated inode. The inode doesn't contain file names, which are stored in directories. Instead, it points to the data blocks where file contents are stored.

### Superblock
The **superblock** contains metadata about the filesystem itself. For example size, block size, number of inodes, etc.. If the superblock is corrupted, the filesystem can fail to mount.

### Journaling
Filesystem like ext4, XFS, and Btrfs support **journaling**, which logs changes before they are committed to the main filesystem. This provides better crash recovery and prevents corruption. Non-journaling filesystems like ext2 don't have this safety mechanism, making them riskier in case of unexpected shutdowns.


[article]:https://domicmeia.github.io/post/hwtrouble/
