+++
title = "[OS]System Hardware "
date = 2024-03-30T14:51:33+09:00
tags = ["OS"]
summary = "All about Data Storage and Server"
+++
> This post was written for `studying`. There maybe a lot wrong going on.

## 목차
* [Servers](#servers)
  * [Server Hardware Architecture](#server-hardware-architecture)
    + [CPU vs GPU](#cpu-vs-gpu)
* [Data Storage System](#data-storage-system)
  * [HDD and SSD](#hdd-and-ssd)
    + [HDD vs SSD](#hdd-vs-ssd)
  * [Interface](#interface)
    + [SATA](#sata)
    + [NVMe](#nvme)
    + [U.2 and M.2](#u2-and-m2)
  * [Storage Systems](#storage-systems)
  * [(*)File servers](#file-servers)
* [Power System](#power-system)
* [Questions](#questions)

---

# Servers
---

Servers are the workhorses of a data center. They are typically connected to the network through a series of switches, routers, and firewalls, which provide network connectivity and security.

In a data center, servers are organized into racks, which can contain anywhere from a few servers to hundreds or even thousands of servers, depending on the size of the data center. Servers are also available in different from factors, including blade servers, which are designed for high-density computing environments, and rack-mount servers, which are more traditional server designs.

## Rack Server

**A Server designed without an external enclosure**  
Good for limitied space and general-purpose applications. Self-contained, efficient, and cost-effective. Can be easily expanded an hot-swapped. High power usage and maintenace.

## Blade Server

**A circuit board with minimum server components**  
fits into a server enclosure with multiple blades. Good for high-density and intensive computing environments. Space-saving, hot-swappable, and easy to manage. High heat generation and cooling needs.

## Tower Server

**A Server integrated into a desktop computer**  
Good for small and medium-sized businesses or office areas. Highly customizable and optimized for specific needs. More CPU power, memory and expansion options. Space-Consuming and hard to manage.

## Rack Server vs Blade Server 

An organization seeking to run a heterogenous data center might choose rack servers because various makes and models can exist together in a common physical deployment approach. Rack server also offer a range of power connections and network cabling choices. Large rack server also offer extensibility, accommodating additional processors, memory and local storage disks. Blade server, meanwhile, are geared toward single-vendor IT settings that seek to unite compute, storage and networking within a single system. The blade server approach offers the benefits of faster deployment and simplified management. 

---

# Server Hardware Architecture
---

The key components or server hardware architecture include the **motherboard, processor, RAM and storage.**
**The motherboard** resides at the heart of the server, providing the central nexus through which system components are interconnected and external devices are attached.

The processor, or CPU, resides on the motherboard. **CPU components include the arithmetic logic unit, floating point unit, registers and cache memory.** A server might also contain a GPU, which cna support applicaitons such as machine learning and simulations.

RAM microchips also plug into the motherboard, serving as a system's main memory. **RAM holds the OS, applications and in-use data for fast access by the processor.** As for the storage, a server might use a hard disk drive(HDD), a sloid-state drive(SSD), the cloud or a mix. 

## CPU vs GPU

###  CPU

THe CPU is often described as the brain of the computer and is considered the main processor. The CPU uses logic cicurity to interpret, process and execute instructions and commands set to it from the OS, programs or various computer components.

### GPU

GPUs were initially designed to complement the CPU. The units have a lot in common: They're both critical computing engines that can handle data, but GPUs specifically accelerate graphics rendering.
  
Although a CPU can send instructions to a graphics card, CPUs can handle only a few software threads at a time. With multiple processing cores, they're great for serial processing - executing a wide variety of workloads or a series of tasks by focusing on completing individual taks quickly - but image rendering is complex. **A GPU unit contains many more cores than a CPU, which enables it to tackle thousands of operations at once rather than just a handful.**

---

# Data Storage System
---
**Local storage** is directly connected from **within** your system or with an **external expansion** port such as USB, eSATA, or Thunderbolt, while network storage relies on wired (**RJ-45**) or wireless network connections to reach drives on other networked computers or in special **file servers and NAS systems**. Online, we have access to files through cloud storage, **FTP servers**, and direct downloads from web sites. Applications and data storage in the cloud play an important role in having access to the same data and software from multiple devices.

---

# HDD and SSD
---

## HDD
HDDS are more traditional and are used for storing large amounts of data.

## SSD
SSDs are faster and more reliable than HDDs, making them suitable for high-performance computing envrionment.

## HDD vs SSD
SSDs and HDDs differ significantly in terms of their expected life. HDDs, bieng **mechanical devices**, have moving parts that are prone to wear and tear over time. On average, an HDD can last anywhere from 3 to 5 years, depending on usage and environmental factors. However, it's important to note that sudden failures can occur, leading to data loss.
  
On the other hand, SSDs have no moving parts, making them more durable and reliable. They use **flash memory to store data**, resulting in faster access times and imporved performance. The expected life of an SSD is typically around 5 to 7 years.
  
> To check the lifespan of an SSD or HDD on a linux server, we can use the `smartctl`command.

---

# Interface
---

## SATA
While SATA remains a popular interface, it is limited by its slower data transfer speeds and higher latency compared to NVMe and U.2 M.2 interfaces. However, it still offers a **cost-effective** solution for those who prioritize affordability over speed. And now, some servers used them instead of HDD, even if the cost of TB is more for SSD.

## NVMe
NVMe has revolutionized the storgae industry with its **lightening-fast data transfer speeds and low latency**. It maximizes the potential of SSDs, enabling faster boot times, quicker file transfers, and imporved overall system performance.

## U.2 and M.2
U.2 and M.2 combines the benfits of **both SATA and NVMe** interfaces, offering high performance and compatibility with a longer lifespan. Its versatility makes it an ideal choice for both consumer and enterprise applications.

---

# Types of Storage System
---

![storage](/images/posts/storage.jpg)

## DAS(Direct Attached Storage)
DAS system are **attached directly** to a server and provide local storage.

## NAS(Network Attached Storage)
NAS systems are disigned to provide storage to multiple servers over the network, while SAN systems provide block-level storage to servers.

## SAN(Storage Area Networking)
A SAN is a dedicated high-speed computer network that provides block-level access to data storage. You can connect different storage devices to multiple servers.
  
A SAN is a private network connecting servers and storage units.

## SAN vs NAS
A SAN uses a network hardware fabric and switches to connect servers to storage. **SANs are good for block I/O and structured data**, such as relational databases. SANs require either **Fiber Channel networking or Etherent**, such as iSCSI.

NAS, on the other hand, accesses files with a **protocol** and is optimal for remote file serving. NAS operates as a server with its own file server and provides centralized data management. It's best for unstructured data.

---

# File servers
> Technically all Internet-accessed storage is network storage.. 

---

A file server has fast, high-capacity HDDs or SSDs for storing files that multiple users need to access. When users connect to the file server, they can view and edit files that they have permission to use.

### NOTE
> Many file servers use Redundant Array of Inexpensive Disks (RAID) technology, which combines more than one physical drive working together to improve performance or protect against data loss.
  
Check below:
[OS Concepts. Chapter 11: Mass Storage EX 11-23][link]

---

# Power System
Reference: [Understanding Key Elements of Data Center Power Distribution][link3]

---

Lower voltage power is then delivered to the data center via components via UPS, PDUs, and RPPs.

## Uninterruptible Power Supply (UPS)
Power utility issues can be temporarily countered with an uninterruptible power supply (UPS). These devices offer battery backup to cover the time between the detection of utility issues and a generator starting.

## Power Distribution Unit (PDU)
Individual IT equipment racks are served by power distribution units (PDUS) offering both metered and unmetered options. With metered PDUs, organizations can understand more about their power consumption, which enables them to begin taking steps toward optimizing their usage.

## Remote Power Panel (RPP)
Remote power panels (RPPs) are the connectors between the PDUs and the individual IT devices. They can generally be found in the same rack as the IT equipment they are serving.

## Server Rack
Finally, power in the data center reaches the server rack. IT equipment is mounted on these racks with power cords connecting them to PDUs.

![datacenter](/images/posts/datacenter.png)

## Cold Aisles / Hot Aisles

**Cold Aisles** are where the front of servers face the aisle. Here, cooled air from the air conditioning units enters the server racks.  
**Hot Aisles** are where the backs of servers face the aisle. This is where hot air is expelled and then directed towards cooling systems to be reconditioned. 

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


## You may also like

- [OS: Boot Process][link1]
- [테크인포- 노트북 추천, 구매가이드 총 정리글][link2]


[link]:https://domicmeia.github.io/post/opcon1/
[link1]:https://domicmeia.github.io/post/hardwaretroulbe/
[link2]:https://techinfo-112.blogspot.com/2021/11/laptop%20guide.html?gclid=CjwKCAiAp5qsBhAPEiwAP0qeJk3UgnN2MO6MNi-FIxH3tBvyDguZfvYjmeSsUXKlPjgF-A2tLD07XRoCkjwQAvD_BwE&m=1
[link3]:https://www.tierpoint.com/blog/data-center-power-distibution/