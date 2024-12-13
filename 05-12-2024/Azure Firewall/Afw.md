---
marp: true
theme: gaia
_class: lead
paginate: false
font-size: 10pt
backgroundColor: #fff
backgroundImage: url("background.png")

---

<div style="text-align: right; font-size:70%">05.12.2024</div>
<br>
<br>

## Azure Firewall 
####  Secure your cloud infrastructure


---
<br>

#### Agenda:
* What is Azure Firewall?

* Key Features and Editions
  
  * Threat Intelligense
  * Dns Proxy  

* Rule Deployment Options

* Pricing
 
* Monitor




---
<br>

#### What is Azure Firewall?

* Cloud native stateful firewall

* Built-in high availability

* Unrestricted cloud scalability

* Threat intelligence and IDPS

* Application FQDN filtering rules

* DNS proxy 
  
* Web Proxy

--- 
<br>

#### Key Features and Editions

<center> 

![w:850](./afw-sku.png)


---
<br>

#### Threat intelligence 

* Filtering works by leveraging the Microsoft Threat Intelligence feed to identify and block traffic from/to known malicious IP addresses, domains, and URLs. Here's how it operates:

* Alert and Deny Modes: If a rule is triggered, you can choose to log an alert or block the traffic (alert and deny mode). 

* Allowlists: You can configure allowlists to prevent false positives by specifying IP addresses, ranges, or subnets that should not be filtered.

---
<br>

#### DNS Proxy

* Forward DNS to configured DNS Server
* Ensures that DNS requests from clients are resolved consistently
* Azure Firewall caches DNS responses according to the TTL


<center>
  
![w:650](./dns-proxy.jpg)

---
<br>

#### WEB Proxy (Preview)

* By default, Azure Firewall operates in transparent proxy mode
* Azure Firewall can operate in explicit proxy mode, where traffic is sent to the firewall using proxy settings
* Proxy Auto-Configuration (PAC) File
* UDR not needed in explicit proxy mode
  
---

<br>
 

#### Firewall policy update

* Update Policy using Azure Portal
* Update Policy using Bicep, Terraform or Arm
* Decentralized Policy update in Landing Zone Project
_
---
<br>

#### Azure Firewall Policy

<center>

![w:400](./policy.jpg)

---
<br>

#### Azure Firewall Policy Update

<br>
<br>
<center>

![w:500](./branch-simple.jpg)

---

<br>
<center>

<br>
<br>
<br>
<br>

# DEMO
 
---
<br>

#### Pricing

 <center>

<br><br>
 ![w:1200](./afwpricing.jpg)

---
<br>

#### Monitor

<center>

 ![w:1200](./grafana.jpg)

 ---
<br>

#### 

<center>

 ![w:1000](./InsidersDeployment.jpg)
