---
marp: true
theme: gaia
_class: lead
paginate: false
font-size: 10pt
backgroundColor: #fff
backgroundImage: url("background.png")

---

<div style="text-align: right; font-size:70%">15.01.2026</div>
<br>
<br>

## VNET Integration fra Power Platform og Fabric

<br>

---

<br>

#### "vNet support for Power Platform" og "Virtual network data gateways"
<span style="font-size:70%">Er der nogen som allerede bruger det ene eller det andet?</span>

<br>

---

<br>

#### "vNet support for Power Platform" og "Virtual network data gateways"
<span style="font-size:70%">Hvad er det</span>
    <span style="font-size:60%">• Managed (Microsoft) integration ind i Azure VNET</span>
<span style="font-size:40%">vNet support for Power Platform |   Virtual network data gateways</span>
<img src="vnet-support-traffic.png" alt="image" width="500" height="175" title="vNet support for Power Platform">&nbsp;&nbsp;&nbsp;<img src="vnet-overview.png" alt="image" width="500" height="195" title="Virtual network data gateways"><br>


<br>

---

<br>

#### "vNet support for Power Platform" og "Virtual network data gateways"
<span style="font-size:70%">Hvorfor</span>
    <span style="font-size:60%">• Governance krav</span>
    <span style="font-size:60%">• Corp Landing Zones der kun tillader private endpoints</span>
    <span style="font-size:60%">• Styring af netværkstrafik</span>

<br>

---

<br>

#### "vNet support for Power Platform" 
<span style="font-size:70%">Hvordan</span>
    <span style="font-size:60%">• Power Platform kræver et VNET for hver Azure region i en Power Platform region</span>
    <span style="font-size:60%">• Kræver et managed environment</span>

<img src="vnet-support-configurations.png" alt="image" width="500" height="300">&nbsp;&nbsp;&nbsp;&nbsp;<img src="ppsupported.png" alt="image" width="450" height="275">

<br>

---

<!-- <br>

#### "vNet support for Power Platform" 
<span style="font-size:70%">Managed vs Unmanaged environment</span>
    
<br>

<img src="manvsunman.png" alt="image" width="500" height="300">

<br>

--- -->

<br>

#### "Virtual network data gateways"
<span style="font-size:70%">Hvordan</span>
    <span style="font-size:60%">• Kræver Fabric kapacitet</span>

<img src="fablimit.png" alt="image" width="325" height="400">

<br>

---

<br>

#### "Virtual network data gateways"
<span style="font-size:70%">Hvordan</span>
    <span style="font-size:60%">• Kapacitetsforbrug</span>

<img src="fabconsump.png" alt="image" width="450" height="400">

<br>

---

<br>

### DEMO 

<br>