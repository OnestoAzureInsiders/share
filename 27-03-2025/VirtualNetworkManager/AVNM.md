---
marp: true
theme: gaia
_class: lead
paginate: false
font-size: 10pt
backgroundColor: #fff
backgroundImage: url("./images/background.png")

---

<div style="text-align: right; font-size:70%">27.03.2025</div>
<br>
<br>

## Azure Virtual Network Manager


---


<!-- backgroundImage: "linear-gradient(to bottom,rgb(11, 11, 11),rgb(44, 46, 47))" 
_color: "white"
-->


<br>
<br>

<div style="text-align: center;">

## Introduction to <br> Azure Virtual Network Manager (AVNM)

</div>


---
<!-- 
backgroundImage: url("./images/background.png") 
_color: black
-->

<br>
<br>
<br>

<div style="display: flex; align-items: center;">
  <!-- Left side: Image -->
  <div style="flex: 1; text-align: center;">
    <img src="./images/security.png" alt="AVNM Image" style="max-width: 80%; border: 1px solid #ccc;">
  </div>

<!-- Right side: Bullet points -->
  <div style="flex: 2; padding-left: 20px;">
    <ul>
      <li>Manage connectivity</li>
      <li>Deploy Route table</li>
      <li>create network security rules that override network security group rules</li>
      <li>Supports multiple subscriptions and management groups</li>
    </ul>
  </div>
</div>

---

<!-- 
backgroundImage: "linear-gradient(to bottom,rgb(11, 11, 11),rgb(44, 46, 47))" 
_color: "white"
-->


<br>
<br>
<div style="text-align: center;">

# Install and configure (AVNM)

</div>

---

<!-- 
backgroundImage: url("./images/background.png") 
_color: black
-->

<br>
<br>
<div style="text-align: center;">
<img src="./images/install_basic.png" style="max-width: 50%">
</div>

---

<br>
<br>
<div style="text-align: center;">
<img src="./images/install_managementscope.png" style="max-width: 70%">
</div>

---

<br>
<br>

<!-- 
backgroundImage: "linear-gradient(to bottom,rgb(11, 11, 11),rgb(44, 46, 47))" 
_color: "white"
-->


<br>
<br>

<div style="text-align: center;">

# Peering and Routing

</div>

---

<!-- 
backgroundImage: url("./images/background.png") 
_color: black
-->

<br>
<br>
<div style="text-align: center;">
<img src="./images/Demo-Env.png" style="max-width: 100%">
</div>

---

<br>
<br>
<div style="text-align: center;">
<img src="./images/Demo.png" style="max-width: 50%">
</div>

---


<!-- 
backgroundImage: "linear-gradient(to bottom,rgb(11, 11, 11),rgb(44, 46, 47))" 
_color: "white"
-->


<br>
<br>
<div style="text-align: center;">

# Security admin rules

</div>

---

<!-- 
backgroundImage: url("./images/background.png") 
_color: black
-->

<br>
<br>

<div style="text-align: center;">

#### Security admin rules evaluation:

<br>
<img src="./images/traffic-evaluation.png" style="max-width: 100%">
</div>


---

<br>
<br>

  ####  Security admin rules are not applied to vNet:
  <br>

* Azure SQL Managed Instances
* Azure Databricks
  
---
<br>
<br>

  #### Security admin rules are not applied to subnets:
  * Azure Application Gateway
  * Azure Bastion
  * Azure Firewall
  * Azure Route Server
  * Azure VPN Gateway
  * Azure Virtual WAN
  * Azure ExpressRoute Gateway

---

<br>
<br>
<div style="text-align: center;">
<img src="./images/Demo-sec.png" style="max-width: 50%">
</div>

---

<br>
<br>
<div style="text-align: center;">
<img src="./images/Demo.png" style="max-width: 50%">
</div>

---

<!-- 
backgroundImage: "linear-gradient(to bottom,rgb(11, 11, 11),rgb(44, 46, 47))" 
_color: "white"
-->

<br>
<br>

<div style="text-align: center;">

# Pricing
</div>
<br>

---

<!-- 
backgroundImage: url("./images/background.png") 
_color: black
-->

<br>
<br>
<div style="text-align: center;">
<img src="./images/Pricing.png" style="max-width: 100%">
</div>
