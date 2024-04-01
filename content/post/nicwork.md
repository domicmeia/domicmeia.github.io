+++
title = "[Networking]OSI layer 1&2: NIC"
date = 2024-03-30T20:03:54+09:00
tags = ["Networking", "Hardware"]
summary = "How NICs work"
+++
> This post was written for `studying`. There maybe a lot wrong going on.

## 목차
* [How NICs work?](#how-nics-work)
* [Switch and Router, What's different?](#switch-and-router-whats-different)
* [L2 Switch vs L3 Switch](#l2-switch-vs-l3-switch)

---

# How NICs work?
You may interest: [Network - LAN Synopsis][link1]

---

NIC stands for Network Interface Card. It's a hardware component that **enables a computer to connect to a network**, such as a local area network (LAN) or the Internet. 

Inside every NIC, burned onto some type of ROM chip, is special firmware containing a unique identifier with a 48-bit value called the media access control address, or MAC address.

## Data Transmission and Reception
When the computer needs to send data over the network, the NIC receives the data from the computer's CPU/RAM and converts it into a **format suitable for transmission** over the network medium. This process involves packetizing the data according to the appropriate network protocol (e.g., TCP/IP for Ethernet networks). The NIC then transmits these packets onto the network medium.

## MAC Address Handling
Each NIC has a unique Media Access Control (MAC) address burned into its hardware. When sending data, the NIC encapsulates it with the MAC addresses of both the source (the computer's NIC) and the destination (the intended recipient's NIC). This addressing ensures that the data reaches the correct destination on the network.

## Protocol Processing
NICs handle various networking protocols according to the communication standards supported by the network. For example, Ethernet NICs handle the Ethernet protocol, while Wi-Fi NICs handle Wi-Fi protocols like IEEE 802.11. The NIC interprets and processes these protocols to ensure that data is transmitted and received correctly.

Overall, **NICs serve as the gateway between a computer and the network**, facilitating the exchange of data and enabling communication with other devices on the network. Their efficient operation is essential for reliable network connectivity and optimal performance of networked applications and services.

---

# Switch and Router, What's different?
---
Switch has a MAC address on its NIC but is set to Promiscuous mode, allowing it to receive **all frames** regardless of MAC address.

A **Router**, unlike a switch, has a MAC address on its NIC and is configured with an IP address as well. Each interface of the router belongs to a different LAN. The Router's NICs function similarly to those of typical IP devices and handle Ethernet frames in the following cases, forwarding them to the upper layers:

1) When the Destination MAC address matches the MAC address of its own interface.
2) When the Destination MAC address is a Broadcast MAC address.
3) When the Destination MAC address is a Multicast MAC address.

There is a Receive mode called **Promiscuous Mode** in the MAC controller. For Window PCs or Linux/Unix Servers, the NIC's Promiscuous Mode is usually **disabled by default.** When using tools like Wireshark or tcpdump to receive packet dumps, **enabling** the tool initiates Promiscuous Mode, allowing the NIC to accept **all incoming frames without filtering** based on MAC address. In L2 Switches, Promiscuous Mode is enabled on all ports. Therefore, the MAC controller accepts and forwards all Ethernet frames without filtering based on MAC addresses. This is why the MAC addresses of switching ports on L2 Switches are rarely used in actual communication, leading some people to occasionally wonder if L2 Switches lack MAC controllers.

Although L2 Switches accept all frames in Promiscuous mode, filtering occurs at the MAC controller level when VLAN Tag filtering is applied. **Untagged ports reject VLAN Tagged frames, and Tagged ports filter frames with unauthorized VLAN tags.**

---

# L2 Switch vs L3 Switch
Reference: [Layer 2, Layer 3 & Layer 4 Switch: What’s the Difference?][link2]

---

Before explicitly configuring it to operate as an L3 Switch, a **Layer 3 (L3) Switch operates as an L2 Switch.** To function as an L2 Switch, the MAC controller's Promiscuous Mode is enabled by default. Cisco L3 Switches can activate Inter-VLAN routing functionality by entering the command "ip routing". By creating Switch Virtual Interfaces (SVIs) for each VLAN, IP routing becomes possible between different VLANs. 

**In an L3 Switch, ports belonging to the same VLAN operate as an L2 Switch, while nodes belonging to different VLANs function as routers.** Even when operating as an L3 Switch by entering the "ip routing" command, ports belonging to the same VLAN can still operate as an L2 Switch. Thus, the MAC controller of the L3 Switch, like that of an L2 Switch, can utilize Promiscuous Mode to pass all Ethernet frames to the Network Processor (NP) and perform MAC filtering at the NP. 

However, depending on the vendor's implementation, Promiscuous Mode may be disabled when a specific port is explicitly configured as a routed port (similar to a router's port, belonging to a single subnet with its own assigned IP address).

![switch23](/images/posts/switch23.png)

결론! L3 Swtich는 VLAN이 같은 port간에는 L2 Switch로 동작하고, 서로 다른 VLAN에 속하는 node들에게는 router로 동작함!

---

# Subnet
Reference:[Networking: OSI layer 3][link3]

---

Mac adresses work for small network, but what happens when the network gets big, like the size of the entire internet? When networks get large, you can't use the MAC addresses anymore. Large networks need a logical addressing method that ignores the hardware and enables you to break up the entire large network into smaller networks called **subnets**

![switch23](/images/posts/subnet.png)

Detach each interface form its host or router, creating "**islands**" of isolated networks each isolated network is **Subnet**

[link1]:https://domicmeia.github.io/post/lan1/
[link2]:https://www.cables-solutions.com/layer-2-layer-3-layer-4-switch-whats-the-difference.html
[link3]:https://domicmeia.github.io/post/osi3/