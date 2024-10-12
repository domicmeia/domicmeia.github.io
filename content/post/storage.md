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