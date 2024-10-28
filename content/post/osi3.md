+++
title = "[Networking]OSI layer 3"
date = 2024-03-31T15:21:44+09:00
tags = ["Networking", "Hardware"]
summary = "What is IP?"
+++
> This post was written for `studying`. There maybe a lot wrong going on.

## 목차
* [IP address](#ip-address)
* [Routing Table](#routing-table)
  + [How does the Routing table looks like?](#how-does-the-routing-table-looks-like)
  + [Subnet Mask](#subnet-mask)
  + [But, if we set the subnet larger than LAN size..](#but-if-we-set-the-subnet-larger-than-lan-size)

---

# IP address
---

At the Network layer, L3, contiainers called **packets** get created and addressed so they can go form one network to another.

## MAC address vs IP address

MAC addresses are known as **Physical addresses**
IP addresses are known as **Logical addresses** to distinguish if from the pyhsical address, the MAC address of the NIC.

If need more info, you may interest:  
[Networking: OSI Layer 1&2 : NIC][link1]

Each rotuer srips off the incoming frame, determines where to send the data according to the IP address in the packet, creates a new frame, and then sends the packet within a frame on its merry way. The next frame type will be the appropriate technology for whatever connection technology connects to the next rotuer. 

![router](/images/posts/router.png)

The IP packet, on the other hand, remains **unchanged.** 
Once the packet reaches the destination subnet’s router, that router strips off the incoming frame—**no matter what type**—looks at the **destination IP address**, and then adds a frame with the appropriate **destination MAC address** that **matches** the destination IP address.

---

# Subnetting
---

The Network Layer (Layer 3) is responsible for logical addressing, routing, and forwarding of packets between different networks. Subnetting involves defining a subnet mask, which is a bitmask used to **partition an IP address** into network and host portions. This process enables the creation of subnetworks within a larger network, allowing for more efficient use of IP addresses and better network management.

Subnetting is closely related to IP addressing and routing, which are core functions of the Network Layer. By dividing a network into smaller subnets, network administrators can improve network performance, security, and scalability.

### Note
> Other layers of the OSI model, such as the Data Link Layer (Layer 2) and Transport Layer (Layer 4), do not directly handle subnetting. However, they play important roles in data transmission and communication within and between subnets.

Therefore, the relevant layer for subnetting according to the OSI model is the Network Layer (Layer 3).

---

# Routing table
---

## If there is no route in the Routing Table for the destination:

**If information regarding the final destination host network is not registered in the Routing Table, the packet will be dropped.** When a router receives a packet, if the destination belongs to its Interface LAN, it can directly forward the packet. However, if the destination does not belong to its Interface LAN, routing can only occur if there is a route path registered in the Routing Table that leads to the corresponding LAN or if a default route is set. Otherwise, the packet will be discarded.

## One of these conditions must be met.

For a packet to be routed to its destination without being discarded, when each Routing Table is searched, either **1) there must be an entry matching the destination IP**, or if there is no matching entry, **2) there must be a default route set.** If neither condition is met, meaning there is no matching entry for the destination network and no default route set, the packet will be discarded.

### NOTE

> **Direct delivery** refers to communication within the same LAN. Any IP
device, whether it's a PC, server, router, or L3 switch, can **directly
send an ARP request** to peers on its interface-connected LAN (subnet,
network) to obtain their MAC addresses and send messages directly.
Direct delivery is indicated in the Routing Table as **"Connected"** (in
Windows) or **"Directly connected"** (in Cisco Router). **When an IP
address and subnet are configured on an interface, they are
automatically added to the Routing Table**, so there is no need for the
administrator to manually add or delete entries from the Routing Table.

> **Indirect delivery**, on the other hand, refers to communication with peers
on different LANs. Since direct delivery is not possible, the message
must be sent to another router for delivery. Therefore, there must be a
route path in the router's Routing Table to reach the destination
network, and as mentioned earlier, routing is only possible if
conditions **1) or 2) are satisfied.** Hence, when packets need to be
delivered to different LANs, the router must have route paths
configured. There are two methods for configuring route paths: the
administrator can manually add routes using static configurations, or
routes can be added dynamically through routing protocols such as RIP,
OSPF, IS-IS, or BGP.

# How does the Routing table looks like?

1) A target (destination) present on a directly connected LAN (network) - a target reachable via direct ARP request.

2) A target (destination) present on a LAN (network) not directly connected - a target that can only be reached through a router.

3) Default Gateway: A router to which packets are sent when there is no matching entry in the routing table, ensuring connectivity to external networks without exception.

## Subnet Mask

> [As i mensioned before,][link2]
> - **A Subnet specifies the size of the same LAN**, and communication with peers belonging to the same Subnet is via direct transmission.
>- When an IP and Subnet are configured on an interface, a directly connected (connected) route entry is created for the directly reachable LAN.
>- Routers receive and process broadcast packets, but do not forward them to other interfaces, so broadcast packets do not pass through routers.

**A Subnet Mask determines the size of a LAN capable of direct transmission, where MAC addresses can be obtained by sending ARP Requests directly!**

## But, if we set the subnet larger than LAN size..

I stated that the Subnet Mask specifies the size of the directly connected LAN, allowing devices to send ARP requests and receive ARP replies directly within that LAN. However, if a PC is configured with a subnet mask **larger than the actual size** of its LAN, it will believe it can directly send ARP requests and receive ARP replies not only within its own subnet but also to hosts with IPs belonging to other subnets such as 192.168.10.128/26 and 192.168.10.192/26. In this case, what happens? Yes, as previously mentioned, **since Proxy ARP functionality is enabled on the router, the router responds to ARP requests on behalf of those hosts, enabling seamless communication.**

결론! 그럼에도 불구하고..! 서브넷 마스크 설정할 때, 크기에 맞춰서 잘~~설정하자

**Interviewer:** *What are the implications of configuring a subnet larger than the size of the LAN?*

When discussing the implications of configuring a subnet that exceeds the size of the local area network, we need to consider several factors, including address space utilization, network performance, management simplicity, and security risks. 

1. **Address Space Utilization**:
   - Configuring a subnet larger than necessary means that we have more available IP addresses than devices connected to the network. For example, if we use a /24 subnet, we have 256 IP addresses available, but if our LAN only connects 50 devices, this leads to a situation where we have 206 unused IP addresses. This may not be a critical issue in IPv4 due to its limited address space, but it can contribute to inefficient use of the address pool, which is particularly important in scenarios like IPv4 exhaustion.

2. **Broadcast Domain Size**:
   - A larger subnet creates a larger broadcast domain. In a scenario where broadcast traffic (such as ARP requests, DHCP broadcasts, or other network-wide announcements) is prevalent, a single broadcast is sent to all devices in that subnet. This can lead to increased network congestion. For instance, if a large broadcast packet is sent, all devices in that subnet will process that packet, which may lead to performance degradation, especially in networks with heavy broadcast traffic or high device counts.

3. **Management and Scalability**:
   - On the positive side, having a larger subnet simplifies network management. When we need to add new devices, there’s no need to reconfigure the IP addressing scheme, which saves time and effort. This flexibility is beneficial in environments with fluctuating device counts, such as temporary setups or organizations with seasonal demand.
   - For example, if a company anticipates rapid growth, it might prefer to implement a larger subnet to accommodate future expansions without frequent readdressing.

4. **Security Considerations**:
   - One of the drawbacks of larger subnets is the potential increase in security risks. A larger broadcast domain exposes more devices to potential network threats. Broadcast packets can be intercepted, increasing the attack surface. Security practices often recommend limiting broadcast domains for this reason. For instance, by segmenting networks using VLANs, we can enhance security by isolating devices from each other.

[link1]:https://domicmeia.github.io/post/nicwork/
[link2]:https://domicmeia.github.io/post/lan1/