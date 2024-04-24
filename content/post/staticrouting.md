+++
title = "[Networking]Static Routing Synopsis"
date = 2024-04-24T15:21:18+09:00
tags = ["Networking", "Hardware"]
summary = "Static Routing Synopsis"
+++
> This post was written for `studying`. There maybe a lot wrong going on.

## 목차

---

# 
---
In end host devices such as PCs or servers, the IP address of the routing device configured to communicate with other networks is called the **Gateway** In routers, when indirect forwarding through another routing device is required, the IP address of the other routing device that needs to be configured is referred to as the **nexthop**

When considering different approaches for setting up routing on end hosts (PCs or servers) and routers, we have three options:

1) Configuring **only the gateway (for end hosts) or nexthop (for routers).**
2) Configuring **only the interface.**
3) Configuring **both the gateway/nexthop and the interface.**

Each approach has its own characteristics:

- Approach 1) involves **recursive lookup** and doesn't remove entries when the interface is down.
- Approach 2) attempts **direct communication with the target(직접통신)** and performs ARP resolution for all target IPs.
- Approach 3) avoids recursive lookup, automatically removes entries when the interface is down, and performs ARP resolution for only one [gateway|nexthop].

It's evident that Approach 3) is the most ideal. Unless there are specific reasons to use Approach 1) or Approach 2), it's recommended to configure routing using Approach 3).

* Special reasons to use Approach 1): When the device doesn't support configuring both options, and using Approach 2) would result in too many ARP table entries.
* Special reasons to use Approach 2): When communication between peers on different subnet ranges needs to be established.

---

# How to configure Static Routing on router
---

When sending data to a peer directly connected to its own interface, whether it's a host device (PC or server) or a routing device, it's sent as **"Connected,"** hence, no gateway or nexthop is required in the routing table. Gateway or nexthop is only necessary when indirectly forwarding packets to networks not belonging to its own interface.

> The method and commands for configuring static routing differ slightly depending on the network device vendor.

For Cisco routers, when configuring a static route, you can use either the interface or the nexthop, or both. Similar to Linux, if you use only the interface, the router attempts ARP resolution for all destinations to directly forward frames. On the other hand, if you use only the nexthop, recursive lookup occurs in the routing table to find the exit interface.

**Unless there are specific reasons, it's advisable to use both the interface and nexthop.**



....