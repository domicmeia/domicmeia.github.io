+++
title = "[Networking]Subnetmask"
date = 2024-04-05T18:32:26+09:00
tags = ["Networking", ""]
summary = "How to calculate the subnetmask"
+++
> This post was written for `studying`. There maybe a lot wrong going on.

## Before reading, read [오리뎅이의 LAN통신 이야기: subnet, subnetmask][link1]

Let's say we have been given the IP address block 192.168.0.0/16 (CIDR notation) for our network, and we need to subnet it to accommodate multiple departments within our organization.

1. **Plan your network**:
   - We need to divide our network into subnets to accommodate different departments: Sales, Marketing, HR, and IT.
   - Each department requires a different number of hosts, as follows:
     - Sales: 100 hosts
     - Marketing: 50 hosts
     - HR: 30 hosts
     - IT: 20 hosts
   - We'll also allocate additional subnets for future growth.

2. **Choose an appropriate subnetting strategy**:
   - Since we have different requirements for each department, we'll use Variable-Length Subnet Masking (VLSM) to allocate subnets of varying sizes.

3. **Calculate the number of bits required for subnetting**:
   - We'll start by determining the number of bits required to accommodate the largest number of hosts, which is for the Sales department (100 hosts). Using the formula 2^n - 2, we find that we need 7 host bits to accommodate 100 hosts per subnet.
   - For Marketing (50 hosts), we need 6 host bits.
   - For HR (30 hosts), we need 5 host bits.
   - For IT (20 hosts), we need 5 host bits as well.
   - We'll also reserve some bits for subnetting, so let's reserve 4 bits for subnetting. 

4. **Choose a subnet mask**:
   - Based on our calculations, the subnet mask for Sales will be /25 (16 + 7), for Marketing it will be /26 (16 + 6), for HR and IT it will be /27 (16 + 5).
   - We'll use /28 for future growth.

5. **Convert the subnet mask to binary**:
   - /25 subnet mask: 11111111.11111111.11111111.10000000 (255.255.255.128)
   - /26 subnet mask: 11111111.11111111.11111111.11000000 (255.255.255.192)
   - /27 subnet mask: 11111111.11111111.11111111.11100000 (255.255.255.224)
   - /28 subnet mask: 11111111.11111111.11111111.11110000 (255.255.255.240)

6. **Implement the subnet mask**:
   - Assign IP addresses within each subnet according to the subnet mask. For example, Sales could use IP addresses ranging from 192.168.0.1 to 192.168.0.126, with a subnet mask of 255.255.255.128.


To solve this problem, we'll follow these steps:

1. **Determine the subnet mask** for 50 subnets.
2. Calculate the network address, assignable IP addresses, and broadcast address for each subnet.

---

# Let's start with the first problem:

### For the subnet 148.45.14.99/16:

1. **Determine the subnet mask** for 50 subnets:

   Since the given IP address is 148.45.14.99/16, it means the first 16 bits are dedicated to the network address, and the remaining 16 bits are for host addresses. To create 50 subnets, we need to borrow additional bits from the host portion. We can find the number of bits needed by calculating \(log_2(50) \approx 5.64\). Since we can't have a fractional number of bits, we'll round up to 6. So, we need 6 additional bits for subnetting.

   The original subnet mask is /16, so we add 6 bits to it, making it /22. Therefore, the subnet mask for the 50 subnets will be 255.255.252.0 (/22 in CIDR notation).

2. **Calculate the network address, assignable IP addresses, and broadcast address for each subnet**:

   - **Subnet Mask**: 255.255.252.0 (/22)

   - **Network Address**:
     To find the network address for each subnet, we'll use the formula:
     ```
     Network Address = Given IP Address AND Subnet Mask
     ```

     For the given IP address 148.45.14.99 and subnet mask 255.255.252.0, the network address will be:
     ```
     148.45.12.0
     ```

   - **Assignable IP Addresses**:
     To find the number of assignable IP addresses, we subtract 2 from the total number of addresses in the subnet. This is because the first address is the network address, and the last address is the broadcast address.

     So, the number of assignable IP addresses will be \(2^{(32 - 22)} - 2 = 1022\).

   - **Broadcast Address**:
     The broadcast address is the address where all the host bits are set to 1.

     ```
     Broadcast Address = Network Address + Assignable IP Addresses - 1
                       = 148.45.12.1023
     ```

Therefore, for the subnet 148.45.14.99/16 with 50 subnets, the details are as follows:

- **Subnet Mask**: 255.255.252.0 (/22)
- **Network Address**: 148.45.12.0
- **Assignable IP Addresses**: 1022 (148.45.12.1 to 148.45.15.1022)
- **Broadcast Address**: 148.45.15.1023

Now, let's move on to the second problem:

### For the subnet 133.172.67.8/24:

Given that the subnet mask is already /24:

- **Subnet Mask**: 255.255.255.0 (/24)

- **Network Address**: 133.172.67.0

- **Assignable IP Addresses**: \(2^{(32 - 24)} - 2 = 254\)

- **Broadcast Address**: 133.172.67.255

Therefore, for the subnet 133.172.67.8/24, the details are as follows:

- **Subnet Mask**: 255.255.255.0 (/24)
- **Network Address**: 133.172.67.0
- **Assignable IP Addresses**: 254 (133.172.67.1 to 133.172.67.254)
- **Broadcast Address**: 133.172.67.255

need more? [Practicing Subnet Mask][link]


[link]:https://www.ranet.co.th/IPsubnet01-eng.php
[link1]:https://blog.naver.com/goduck2/220196781065
