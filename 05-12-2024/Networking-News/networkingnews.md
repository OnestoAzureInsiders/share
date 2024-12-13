---
marp: true
theme: gaia
_class: lead
paginate: false
font-size: 10pt
backgroundColor: #fff
backgroundImage: url("background.png")

---

## Networking News

---

<br>

<br>

#### - Bastion Premium
#### - Private Subnet
#### - Network Security Perimeter
#### - Azure Virtual Network Gateway SKU consolidation

---

<br>

#### Bastion Premium:

<br>

- RDP og SSH forbindelse til Azure miljøer, via TLS over HTTPS

- Bastion Premium, nu GA (General Availability)

---

<br>

<br>

<img src="comparison.png" alt="Example Image" width="550" height="500">

---

<br>

##### Private-only deployments

<br>

<br>

<img src="private-only-architecture.png" alt="Example Image" width="1000" height="300">

---

<br>

##### Session recording

- Når en session lukkes eller disconnectes - bliver sessionsoptagelsen gemt i en Storage Blob
- Virker ikke med native klienten endnu (altså kun web)
- Samtlige sessioner via Bastion Hosten optages

---

<br>

## DEMO

- Forbind VM via Bastion Premium / Invoke-WebRequest
- Vis session recording
- Husk CORS regler på Blob Storage

---

<br>

#### Private Subnet:

<br>

- Secure by default | kun adgang til outbound i un-peered netværk hvis det er nødvendigt
- "On September 30, 2025, default outbound access for new deployments will be retired."

---

<br>

##### Decision tree ift. behov for default outbound access

<br>

<img src="decision-tree-load-balancer-thumb.png" alt="Example Image" width="450" height="450">

---

<br>

## DEMO

- Forbind VM i private subnet via Bastion Premium / Invoke-WebRequest

---

<br>

#### Network Security Perimeter:

<br>

- Central styring af Public Network Access til PaaS services (data tier services)  

- Gået i Public Preview i november

<img src="nspsupported.png" alt="Example Image" width="500" height="250">

---

<br>

##### Hvordan virker det

<br>

- PaaS services associeres med en Network Security Perimeter ressource

<br>

<img src="nsp.png" alt="Example Image" width="400" height="250">

---

<br>

#### Hvordan virker det

<br>

- Da det er er public preview skal man huske at registrere preview featuren

<br>

<img src="network-security-perimeter-add-preview-feature.png" alt="Example Image" width="650" height="250">

---

<br>

#### Hvordan virker det

<br>

- 2 access modes: Learning og Enforced - defineres pr. resource

<img src="accessmodes.png" alt="Example Image" width="600" height="150">

---

<br>

#### Hvordan virker det

<br>

- Der laves Access Rules for inbound og outbound trafik, associeres med en profil

<br>

- Inbound: skal indeholde tilladte sources enten public IP adresser eller subscriptions
- Outbound: skal indeholde tilladte destinations angivet som FQDN

---

<br>

## DEMO

- Draw.io diagram over setup
- Vis Network Security Perimeter ressource
- PaaS service Public Access ("publicNetworkAccess: 'SecuredByPerimeter'")
- Vis forbindelse via portal (update Access Rule)
- Vis forbindelse til SQL via Private Endpoint / VM i Private Subnet 
- Vis Log Analytics (virker kun i US datacentre)

---

<br>

#### Azure Virtual Network Gateway SKU consolidation

<br>

- Startende fra 1/1-2025 kan der ikke længere laves nye deployments af VpnGw1-5 

- Fra april 2025 til september 2026 vil alle eksisterende non-Az SKU gateways migreres 

---

<br>

##### SKU mapping

<br>

<img src="sku-mapping.png" alt="Example Image" width="450" height="450">
