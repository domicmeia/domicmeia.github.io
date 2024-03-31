+++
title = "[Networking]OSI 3 layer"
date = 2024-03-31T15:21:44+09:00
tags = ["Networking", "Hardware"]
summary = "What is IP?"
+++
> This post was written for `studying`. There maybe a lot wrong going on.

## 목차
* [IP address](#ip-address)

---

# IP address
---

At the Network layer, L3, contiainers called **packets** get created and addressed so they can go form one network to another.

## MAC address vs IP address

MAC addresses are known as **Physical addresses**
IP addresses are known as **Logical addresses** to distinguish if from the pyhsical address, the MAC address of the NIC.

If need more info, you may interest:  
[Networking: OSI 1&2 Layer: NIC][link1]

Each rotuer srips off the incoming frame, determines where to send the data according to the IP address in the packet, creates a new frame, and then sends the packet within a frame on its merry way. The next frame type will be the appropriate technology for whatever connection technology connects to the next rotuer. 

![router](/images/posts/router.png)

The IP packet, on the other hand, remains **unchanged.** 
Once the packet reaches the destination subnet’s router, that router strips off the incoming frame—**no matter what type**—looks at the **destination IP address**, and then adds a frame with the appropriate **destination MAC address** that **matches** the destination IP address.


[link1]:https://domicmeia.github.io/post/nicwork/