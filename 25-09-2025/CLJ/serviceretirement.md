---
marp: true
theme: gaia
_class: lead
paginate: false
font-size: 10pt
backgroundColor: #fff
backgroundImage: url("background.png")

---

<div style="text-align: right; font-size:70%">25.09.2025</div>
<br>
<br>

## Service Retirement i Azure

---

<br>

### Service Retirement
<span style="font-size:70%"> • Overblik</span>
<span style="font-size:70%"> • Eksempler på Service Retirements</span>
<span style="font-size:70%"> • Hvordan håndteres de?</span>

---

<br>

#### Overblik   

<span style="font-size:50%">Service Retirement dækker over de Azure Updates, der annoncerer udfasning af specifikke Azure-tjenester eller -funktioner.</span>
<span style="font-size:50%">Azure Updates - https://azure.microsoft.com/en-us/updates?filters=%5B%22Retirements%22%5D</span>

<br>

<img src="serviceupdates.png" alt="image" width="500" height="300">

<br>

---

<br>

#### Overblik

<span style="font-size:50%">Som en del af Azure Advisor - findes Service Retirement workbook</span>
<span style="font-size:50%">https://portal.azure.com/#view/Microsoft_Azure_Expert/AdvisorMenuBlade/~/workbooks</span>

<br>

<img src="serviceretirement.png" alt="image" width="500" height="300">

<br>

---

<br>

#### Eksempler på Service Retirements

<span style="font-size:50%">Basic SKU Public IP - 30/9-2025</span>
<span style="font-size:50%">Basic Load Balancer - 30/9-2025</span>
<span style="font-size:50%">VPN Gateway Standard/Performance - 30/9-2025</span>
<span style="font-size:50%">TLS 1.0/1.1: Storage Account - 1/11-2025</span>
<span style="font-size:50%">TLS 1.0/1.1: Application Gateway - 31/8-2025</span>
<span style="font-size:50%">TLS 1.0/1.1: Azure SQL Database - 31/8-2025</span>

<br>

---

<br>

#### Hvordan håndteres de? - kortsigtet

<span style="font-size:50%">Identificer berørte ressourcer - enten via workbook eller Azure Resource Graph Explorer</span>

<br>

---

<br>

#### Hvordan håndteres de? - kortsigtet - Storage Account

<span style="font-size:50%">TLS 1.0/1.1: Storage Account (1/11-2025) - DEMO</span>

<br>

---

<br>

#### Hvordan håndteres de? - kortsigtet - Storage Account

<span style="font-size:50%">Løsning - Azure Policy - DEMO</span>

<br>

---

<br>

#### Hvordan håndteres de? - kortsigtet - App Services

<span style="font-size:50%">TLS 1.0/1.1: App Services (ikke EOS/EOL endnu, men...) - DEMO</span>

<br>

---

<br>

#### Hvordan håndteres de? - kortsigtet - App Services

<span style="font-size:50%">Løsning - Azure Policy - DEMO</span>

<br>

---

<br>

#### Hvordan håndteres de? - kortsigtet - Basic Public IP

<span style="font-size:50%">Basic Public IP (30/9-2025) - DEMO</span>

<br>

---

<br>

#### Hvordan håndteres de? - kortsigtet - Basic Public IP

<span style="font-size:50%">Løsning - detach Public IP fra ressource, opgradér til Standard SKU (IP adresse fastholdes)</span>

<br>

---

<br>

#### Hvordan håndteres de? - langsigtet - OS Disks

<span style="font-size:50%">Eksempel: OS Disks running Standard HDD - retires 8-9-2028 - kan give service disruption ved konvertering</span>

<br>

---

<br>

#### Hvordan håndteres de? - langsigtet - OS Disks

<span style="font-size:50%">Hindre nye deployments - Deny policy - DEMO</span>

<br>