+++
title = "[OS]Storage"
date = 2024-10-11T12:55:27+09:00
tags = ["OS", "Hardware"]
summary = "Datacenter Storage"
+++
> This post was written for `studying`. There maybe a lot wrong going on.

## 목차
* [Storage Overview](#storage-overview)
* [Storage Systems](#storage-systems)
* [Automatic Data rebuild on New Hardware](#automatic-data-rebuild-on-new-hardware)


---

# Storage Overview
---

Google use a distributed storage architecture where data is not stored in just one location but spread across multiple physical locations. And they leverages different stroage systems depending on the type of data and use cases like block Storage and object Storage. Frequently accessed, high-performance data (like databases or VM disks) is stored on block storage, while less critical, larger datasets (like backups, archives, or media) are stored on object storage.

---

# Storage Systems
---

**Block storage** is used for structured, performance-sensitive data, like virtual machines, databases, and other low-latency applications. One example is persistent disks used for *Google Compute Engine*, which provides block level storage that can be dynamically attached or detached to instances.
  
For block stoarge, Google uses technologies like **RAID**, which spreads data across multiple physical disks and uses parity data to recover from drive failures. This ensures that if one drive in the datacenter fails, the RAID array can rebuild the data using redundant copies stored on other drives. 
  
For large-scale, unstructed data like files, images, backup, or media, Google uses *Google Cloud Storage*. This is an **object storage solution** where data is stored as objects in **buckets**. These buckets can hold any amount of data, and data can be accessed from anywhere globally. GCS data is replicated across multiple zones or regions, ensuring high durability.

---

# Automatic Data rebuild on New Hardware
---

When a disk fails, the RAID controller immediately detects the failure and shifts all read/write operations to the remaining functioning drives. In setups like RAID 5 or RAID 6, the system continues to function, but performance might degrade sligtly as the controller reconstructs data using parity.
  
Once a new drive is inserted to replace the failed one, the RAID system begins the **rebuild process**. They system will use the parity information (RAID 5/6) or mirrored data (RAID 1/10) to recreate the lost data on the new disk.

In a datacenter, hardware components within a **rack** and the **host (server)** play a critical role in computing, networking, and storage operations. Understanding the architecture of these components is essential, especially for roles like a datacenter technician.

### **1. Rack Components in a Datacenter**

A **rack** is a physical framework that houses multiple servers and associated hardware components. Typical racks are 42U in height, where "U" refers to a standard unit of measurement for rack-mounted equipment (1U = 1.75 inches).

#### a. **Servers/Hosts**
   - **Role**: Each server (or host) in the rack handles compute tasks and runs various applications or services. Servers are the most critical component, as they provide the processing power.
   - **Types**: They can be standard rack servers (1U, 2U, or 4U) or blade servers (compact servers mounted in chassis).
   - **Components** (See **Host Components** below for details):
     - CPU, RAM, storage (HDD/SSD), NIC (Network Interface Cards), etc.

#### b. **Top-of-Rack (ToR) Switches**
   - **Role**: ToR switches manage the networking within a rack, connecting each server to the datacenter’s broader network fabric.
   - **Uplink**: ToR switches are connected to spine switches or aggregation switches, typically via high-speed fiber optics.
   - **Switching Capacity**: ToR switches usually support multiple 10G, 25G, or 40G connections to the hosts and multiple uplinks with even higher speeds (40G, 100G) to the core/spine network.

#### c. **Power Distribution Unit (PDU)**
   - **Role**: The PDU distributes electrical power to all the components in the rack, such as servers, switches, and storage devices.
   - **Types**: PDUs can be basic or intelligent, with the latter offering monitoring of power consumption and remote power cycling capabilities.

#### d. **Uninterruptible Power Supply (UPS)**
   - **Role**: The UPS provides backup power in case of a power failure or fluctuations to prevent immediate system crashes.
   - **Duration**: Usually, UPS provides only short-term power, long enough for systems to shut down gracefully or for backup generators to kick in.

#### e. **Rack-Level Cooling (Optional)**
   - **Role**: While datacenters typically use large HVAC systems for cooling, some racks might have built-in cooling components (e.g., liquid cooling systems for high-density racks).
   - **Cooling**: Ensures the hardware stays at an optimal temperature, reducing thermal stress and avoiding system failures.

#### f. **KVM Switch (Keyboard, Video, Mouse)**
   - **Role**: KVM switches allow technicians to manage multiple servers from a single console. It simplifies physical access to the servers in case remote access is unavailable.

#### g. **Storage Arrays (Optional)**
   - **Role**: In some racks, dedicated storage arrays or JBOD (Just a Bunch of Disks) systems provide additional storage. These systems often connect to the hosts via high-speed interfaces such as Fibre Channel or iSCSI.
   - **Types**: Storage systems may consist of HDDs (Hard Disk Drives) or SSDs (Solid State Drives) and are typically part of a SAN (Storage Area Network) or NAS (Network-Attached Storage).

---

### **2. Host (Server) Components**

A **host** or **server** is the fundamental computing unit in a datacenter. It performs processing tasks, runs services, and handles workloads based on specific use cases.

#### a. **Central Processing Unit (CPU)**
   - **Role**: The CPU is the brain of the host. It processes instructions and performs calculations.
   - **Types**: Most servers use multi-core processors, such as Intel Xeon or AMD EPYC, which are designed for high-performance and multi-threaded workloads.
   - **Considerations**: For datacenter use, factors like the number of cores, clock speed, and power efficiency are critical.

#### b. **Memory (RAM)**
   - **Role**: RAM provides temporary storage for data that is actively being used or processed by the CPU.
   - **Types**: Servers typically use ECC (Error-Correcting Code) memory, which can detect and correct data corruption.
   - **Capacity**: RAM capacity can range from a few gigabytes (GB) to several terabytes (TB), depending on the server and its workload.

#### c. **Storage (HDD/SSD)**
   - **Role**: The host uses local storage to store operating systems, applications, and data.
   - **Types**:
     - **HDD (Hard Disk Drive)**: Traditional spinning disk drives, slower but larger capacity.
     - **SSD (Solid-State Drive)**: Faster than HDDs, often used for OS and frequently accessed data.
     - **NVMe (Non-Volatile Memory Express)**: Ultra-fast storage, using PCIe interface, often used for high-performance workloads.
   - **RAID Configuration**: Many servers use RAID (Redundant Array of Independent Disks) to provide redundancy and data protection.

#### d. **Network Interface Cards (NIC)**
   - **Role**: NICs handle the server’s communication with the rest of the network. A host may have multiple NICs for redundancy and increased bandwidth.
   - **Types**:
     - **Ethernet NIC**: Supports 1G, 10G, 25G, 40G, or 100G connections depending on the use case.
     - **Fiber NIC**: Used for high-speed networking (often 40G or 100G connections), common in enterprise datacenters.

#### e. **Motherboard**
   - **Role**: The motherboard connects all the internal components of the server, such as the CPU, RAM, storage, and network interfaces.
   - **Considerations**: In datacenters, server motherboards are designed for reliability, expansion, and remote management.

#### f. **Power Supply Unit (PSU)**
   - **Role**: The PSU provides power to the server components. Redundant PSUs are common in datacenters to ensure the host continues running even if one PSU fails.

#### g. **Cooling Components**
   - **Role**: Servers generate a lot of heat, and they use internal fans or liquid cooling systems to maintain optimal operating temperatures.
   - **Airflow**: Proper airflow is essential, and fans are often arranged to ensure that cool air is pulled from the front and hot air is expelled at the back.

#### h. **Remote Management Tools (BMC/IPMI)**
   - **Role**: Remote management is essential for datacenters. Servers typically have a **Baseboard Management Controller (BMC)** that provides remote access for monitoring, updating firmware, and performing actions like power cycling.
   - **IPMI (Intelligent Platform Management Interface)**: Allows for remote management even when the server’s main OS is down.

#### i. **RAID Controller (Optional)**
   - **Role**: Some servers include RAID controllers for managing the RAID arrays of storage disks, improving redundancy and performance.

#### j. **GPU (Optional)**
   - **Role**: Some servers may include GPUs (Graphics Processing Units) for compute-intensive tasks, such as AI, machine learning, or rendering.
   - **Types**: NVIDIA GPUs (like the Tesla or A100) are commonly used in high-performance computing (HPC) environments.

---

### **3. Host Connectivity and Cabling**
   
#### a. **Network Cabling**
   - **Ethernet Cables**: Typically CAT6 or CAT6a cables are used for network connections within the rack.
   - **Fiber Optic Cables**: For higher-speed uplinks (25G, 40G, 100G), fiber optic cables are used, connecting servers to ToR switches.

#### b. **Power Cables**
   - Servers are powered by connecting to the PDU in the rack via power cables. Redundant power supplies often have separate cables to different PDUs for redundancy.

#### c. **Management/Out-of-Band (OOB) Cables**
   - Separate network cables connect to the server’s BMC/IPMI interface for OOB management, allowing technicians to remotely manage servers even when the main network connection is down.

---

### **Summary**

- **Rack Components**: A typical datacenter rack contains servers, ToR switches, PDUs, and possibly storage arrays. The ToR switch connects servers to the network fabric, while the PDU distributes power.
- **Host (Server) Components**: Each server or host in a rack contains key components like CPU, RAM, storage (HDD/SSD), NICs, and cooling systems. These systems are designed for high performance, reliability, and scalability.
- **Connectivity**: Racks and hosts are connected via high-speed network cabling (Ethernet or fiber optics) and are powered by redundant power systems.
