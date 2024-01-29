+++
title = "Basic AWS concepts"
date = 2024-01-29T23:16:10+09:00
tags = ["AWS", "Cloudcomputing"]
summary = "Becoming familiar with some basic AWS concepts"
+++
> This post was written for `studying`. There maybe a lot wrong going on.

## Auto Scaling

For example, the web server receives more visitors than normal, and its CPU is starting to max out. Auto Scaling would then bring up a new web server automatically, and with a load balancer, route clients between instances as needed to spread the load.

## Auto Healing

Just as the name implies, it means that if the server runs into a problem, it will automatically be "healed," and in the case of cloud computing, this means the instance will be disposed of and recreated from a known good image or template.

### Health check

For example, perhaps you have a pair of web servers hat handle requests from clients. One of them encounters some sort of issue and fails some sort of test that would imply that the server is unreliable. Such a test is a **health check**
With auto healing, a server that fails health checks is considered unhealthy and is deleted.

## Virtual Private Cloud (VPC)

You can think of a VPC as your overall network. In your organization, you may have various routers, gateways, firewalls, virtual machines, printers, or other network-connected devices. Your organization’s network is essentially a VPC in AWS, a software version of a complete network.

## Elastic Compute Cloud (EC2)

EC2 is the service within AWS that your virtual machines will run in. Individual virtual machines within AWS are referred to as EC2 instances. EC2 instances, just like a virtual machine, have memory and CPU allocated to them and run an operating system. 

## Elastic Block Store (EBS)

EBS provides block storage, essentially the same type of storage we’ve been working ‘allows you to have multiple EC2 instances serving your application, and you can create an ELB to route traffic between them. ELB is actually a feature of EC2 and not its own service.

## Identity and Access Management (IAM)

IAM is the tool within AWS that you’ll use to create and manage user accounts, determine user permissions, and even create API keys that can be used to programmatically access and manage AWS. Basically, it’s your one-stop shop for all things related to user privileges, regardless of whether the “user” is a human or a script.

## Route 53

Route 53 will simplify the process of managing DNS entries and also registering new domain names. 

## Simple Storage Service (S3)

Object storage is a new type of storage that is different than a disk (virtual or physical) that you add to your server, format, and mount. While you can still mount S3 on your server, it doesn’t have a filesystem (such as ext4 or STON), nor does it understand permissions. It’s simply a name-object pair, where you store files, and they have a name. With S3, you create “buckets,” and each bucket can have files stored inside. Each bucket name must be unique. S3 is very useful if you want to make downloadable files available to your clients or store backup files.
