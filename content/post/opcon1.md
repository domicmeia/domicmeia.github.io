+++
title = "[OS Concepts]Chapter 11: Mass Storage EX 11-23"
date = 2024-03-25T18:51:25+09:00
tags = ["OS", "Hardware"]
summary = "EX-45 11.23"
+++

 > Assume that you have a mixed configuration comprising disks organized as RAID 1 and RAID 5 disks. Assume that the system has flexibility in deciding which disk organization to use for storing a particular file. Which files should be stored in the RAID 1 disks and which in the RAID 5 disks in order to optimize performance?

 # RAID 1(Mirroring)

 - RAID 1 provides redundancy by mirroring data across multiple disks. Every write operation is duplicated on both disks in the mirrored pair
 - It offers high read performance as data can be read form either disk in the mirror pair.
 - Files that require high read performance and are critical in terms of availability or reliability should be stored in RAID 1. This includes system fiels, frequently accessed application binaries, and critical DB files.

 # RAID 5(Striping with Parity)
 
 - RAID 5 offers a balance between performance, redundancy, and usable storage capacity. It uses block-level striping with distributed parity across multiple disks.
 - Read performance is generally good, especially for large sequential reads, as data can be read in parallel from multiple disks.
 - Write performance can be slower than RAID 1, particularly for small random writes, due to the need to calculate parity infromation.

 # Based on these consideration:

 - Critical system files, frequently accessed application binaries, and important database file should be sotred on RAID 1 disks to ensure high read performance and redundancy.
 - User files, documents, media files, and less critical application data can be stored on RAID 5 disks to make efficient use of storage capacity while still providing redundancy and acceptable performance. 