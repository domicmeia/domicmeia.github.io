+++
title = "[Networking]OSI 4 layer"
date = 2024-03-31T16:26:38+09:00
tags = ["Networking", "Hardware"]
summary = "focus on TCP"
+++
> This post was written for `studying`. There maybe a lot wrong going on.

## 목차
* [IP vs TCP/IP](#ip-vs-tcpip)
* [Segmentation](#segementation)
* [TCP and UDP](#tcp-and-udp)
* [Why is there a UDP](#why-is-there-a-udp)
* [Diagonosing TCP/IP Network Issue](#diagonosing-tcpip-network-issue)

---

# IP vs TCP/IP
---

Since IP is strictly a data send/recieve protocol, there is no built-in checking that verifies whether the data packet sent were actually recieved. In contrast to IP, TCP/IP is a higher level smart communications protocol that can do more things. It creates a virtual network when more than one computer is connected to the network and uses the 3 ways handshake model to establish the connection which makes it more reliable.

## TCP 3-Way Handshake

![3wayhandshake](/images/posts/3way.png)

1. The client sends a SYN(synchronize sequence number) packet to the server, which has a random sequence number.
2. The server sends back a SYN-ACK(SYN+1) packet.
3. The client sends an ACK number to the server, acknowledging the server's sequence number.
4. The sequence number on both ends are synchronized. Both can now send and recieve data independently.

## Why the TCP/IP model has only 4 layer compared to the OSI 7 layers?

Overall, the TCP/IP model's four-layer architecture strikes a balance between simplicity, efficiency, and interoperability, making it the foundation of the modern internet and networking infrastructure. While the OSI model provides a more comprehensive theoretical framework, the TCP/IP model's pragmatic approach has proven highly effective in practice.

---

# Segementation
---

TCP breaks down the data stream from the Application Layer into smaller units called segments. These segments are then transmitted individually across the network and reassembled by the receiver into the original data stream. **Segmentation allows TCP to efficiently manage the transmission of data, handle flow control, and recover from network errors.**

While segmentation is a prominent feature of TCP, other transport layer protocols may not necessarily utilize segmentation in the same way. For example, the User Datagram Protocol (UDP), also at the Transport Layer, does not employ segmentation. UDP simply takes the data from the Application Layer and encapsulates it into datagrams, which are then transmitted as is without segmentation or reassembly at the transport layer.

So, while segmentation is a core mechanism in TCP, it's not universally present in all transport layer protocols.

---

# TCP and UDP
---

TCP is not a protocol but is a member of the IP protocol suite. The TCP refers to Trasmission Control Protocol and is a massively used protocol. One of the benefits of TCP is that it establishes the connection **on both ends** before any data start to flow. It is also used to **sync up the data flow** as if a case arrives when the packets arrive out of order, so the receiving system should be able to f**igure out what the puzzle of packets is supposed to look like.**

We can call the UDP the twin of the TCP. The UDP stands for User Datgram Protocol. The UDP doesn't care if somebody is listening on the other end or not, and it is called the connection protocol. Whereas, when we talk about the TCP, it makes everybody stay on the same page. The transmission speed on a **UDP is faster than the transmission speed fo TCP.** The TCP always needs confirmation from the other side that the message is received or not. On the other side, the UDP is like a tv broadcast in which the transmitter doesn't care or know about the person on the other hand.

---

# Why is there a UDP?
---

UDP exists because it eliminates the need for connection establishment, keeping it simple with **no connection state** at the sender or receiver and boasting a small header size. Without congestion control, UDP can blast away as **fast** as desired, functioning **even in the face of congestion.** It's particularly suited for streaming multimedia applications that are **loss-tolerant and rate-sensitive**, as well as for protocols like DNS, SNMP, and HTTP/3.

---

# Diagonosing TCP/IP Network Issue 
---

1. **Diagnose the NIC.** Use the diagnostic tool to see if the NIC is working.
2. **Check your NIC's driver.** Replace it if necessary.
3. **Diagnose locally.** If the NIC's okay, diagnose locally by pinging a few neighboring systems, by both IP address and DNS name. If you can't ping by DNS, check your DNS settings.
    * Reference: [Networking: ping google.com][link1]
4. **Check IP address and subnet mask.** If you're having a problem pinging locally, make sure you have the right IP address and subnet mask. If you're on DHCP, try renewing the lease.
5. **Run `netstat`.** Running `netsatat` with no options shows you all the current connections to your system. 
6. **Run `netstat -s`.** Running with -s option displays several statistics that can help you diagnose problem. For example, if the display shows you are sending but not receiving, you almost certainly have a bad cable with a broken receive wire. 
7. **Diagnose to the gateway.** If you can't get on the Internet, check to see if you can ping the router. If you can't ping the router, either it's down or you're not connected to if. IF you can only ping the near side, something in the router itself is messed up, like the routing table. 
8. If you can ping the router, try to ping something on the internet. If you still can't get through, you can try to locate the problem **using the `traceroute` to identify packet loss.** 
    * Reference: [Networking: traceroute][link]

[link1]:https://domicmeia.github.io/post/google/
[link]:https://domicmeia.github.io/post/traceroute/