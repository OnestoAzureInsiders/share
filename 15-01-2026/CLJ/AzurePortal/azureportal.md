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

## Nye features i Azure Portal (ny-ish)

<br>

---

<br>

### Features
<span style="font-size:70%">Resource Manager</span>
    <span style="font-size:60%">• Service groups</span>
    <span style="font-size:60%">• Resource Explorer</span>
    <span style="font-size:60%">• ARM API playground</span>
<br>

---

<br>

### Resource Manager 
<span style="font-size:60%">Ny samling af ressourcerelaterede features som vi bruger tit</span>
<img src="resourcemanager.png" alt="image" width="400" height="300"><br>

<br>

---

<br>

#### Service groups
<span style="font-size:60%">Ny governance feature</span>
<span style="font-size:50%">• Ressourcegruppering på tværs af subscriptions (funktionelt view)</span>
<span style="font-size:50%">• Kan tildeles roller således at least-privilege brugere se de grupperede ressourcer</span>
<span style="font-size:50%">• Preview - Monitoring</span>
    <span style="font-size:40%">- Issues | Application Maps (Application Insights) | Monitoring coverage and recommendations (VM og AKS)</span>


<img src="multiple-service-group.png" alt="image" width="300" height="175">
<img src="servicegroupsfacts.png" alt="image" width="250" height="75">


<br>

---

<br>

#### Service groups
<span style="font-size:60%">Kan ikke bruges til:</span>
    <span style="font-size:50%">• Som deployment scope</span>
    <span style="font-size:50%">• Policy scope</span>
    <span style="font-size:50%">• Role assignment scope</span>
<span style="font-size:60%">Kan bruges til tværgående health monitoring</span>
<br>

---

<br>

#### Service groups
<span style="font-size:60%">Azure Health Model</span>
    
<img src="sample-health-model.png" alt="image" width="700" height="400">
<br>

---

<br>

### DEMO 

<br>

---

<br>

#### Resource Explorer
<span style="font-size:60%">Azure Resource Manager REST API (JSON view)</span>
<img src="resourceexplorer.png" alt="image" width="700" height="300"><br>
<br>

---

<br>

#### ARM API playground
<span style="font-size:60%">Direkte interaktion med management.azure.com ARM‑API’er</span>
<span style="font-size:60%">Mulighed for at udføre live GET/LIST/POST/PUT/PATCH/DELETE‑kald i et sandbox UI</span>
<img src="armapiplayground.png" alt="image" width="600" height="400"><br>
<br>

---

<br>

### DEMO 

<br>