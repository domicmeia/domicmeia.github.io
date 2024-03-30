+++
title = "[OS]Data Storage System"
date = 2024-03-30T14:51:33+09:00
tags = ["OS", "Hardware"]
summary = "All about Data Storage"
+++
> This post was written for `studying`. There maybe a lot wrong going on.

## 목차
* [Ovierview](#overview)
* [HDD and SSD](#hdd-and-ssd)
  + [HDD vs SSD](#hdd-vs-ssd)
* [Interface](#interface)
  + [SATA](#sata)
  + [NVMe](#nvme)
  + [U.2 and M.2](#u2-and-m2)
* [Storage Systems](#storage-systems)
* [(*)File servers](#file-servers)

---

# Overview
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

# Storage Systems 
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

[link]:https://domicmeia.github.io/post/opcon1/