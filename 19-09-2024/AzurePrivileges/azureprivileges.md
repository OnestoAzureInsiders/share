---
marp: true
theme: gaia
_class: lead
paginate: false
font-size: 10pt
backgroundColor: #fff
backgroundImage: url("background.png")

---

## Elevated Privileges i Azure (External/Internal)

---

<br>

#### External Privileges:

<br>

#### <div style="text-align: left; font-size:70%">Delegated Admin Privileges / Granular Delegated Admin Privileges (DAP / GDAP)</div>


---

<br>

#### <div style="text-align: left; font-size:70%">Hvordan virker det?</div>
##### <div style="text-align: left; font-size:60%">Tildeles på tenant niveau</div>
<br>
<br>
<br>
<br>
<br>
<br>

<div style="text-align: left; font-size:60%">Microsoft Partner Center</div>
<div style="text-align: left; font-size:40%">https://partner.microsoft.com/dashboard/v2/customers/56570c5a-7db7-41e1-8b1d-a5f040b12855/servicemanagementpage</div>

---

<br>

#### <div style="text-align: left; font-size:70%">Hvordan ser vi det?</div>

<br>
<br>
<br>
<br>
<br>
<br>

<div style="text-align: left; font-size:60%">User interface</div>
<div style="text-align: left; font-size:40%">https://admin.microsoft.com/AdminPortal/Home#/partners</div>

<br>

<div style="text-align: left; font-size:60%">Command line</div>

---

<br>

#### External Privileges:

#### <div style="text-align: left; font-size:70%">Admin on behalf of (AOBO)</div>

---

<br>

#### <div style="text-align: left; font-size:70%">Hvordan virker det?</div>
##### <div style="text-align: left; font-size:50%">Tildeles på subscription niveau (typisk ved CSP)</div>
##### <div style="text-align: left; font-size:50%">Ved CSP bør den være der, men med least privilege</div>
<br>
<br>
<br>
<br>
<br>
<br>

<div style="text-align: left; font-size:60%">Microsoft Partner Center</div>
<div style="text-align: left; font-size:40%">https://partner.microsoft.com/dashboard/v2/customers/56570c5a-7db7-41e1-8b1d-a5f040b12855/servicemanagementpage</div>

---

<br>

#### <div style="text-align: left; font-size:70%">Hvordan ser vi det?</div>

<br>
<br>
<br>
<br>
<br>
<br>

<div style="text-align: left; font-size:60%">User interface</div>
<div style="text-align: left; font-size:40%">https://portal.azure.com/#@lenander.name/resource/subscriptions/056b7a12-e544-4435-ae1f-2090b4b7939a/users</div>

<br>

<div style="text-align: left; font-size:60%">Command line</div>

---

<br>

#### External Privileges:

#### <div style="text-align: left; font-size:70%">Azure Lighthouse</div>

---

<br>

#### <div style="text-align: left; font-size:70%">Hvordan virker det?</div>

<br>
<br>
<br>
<br>
<br>
<br>

<div style="text-align: left; font-size:60%">Azure Portal - multi-tenant view</div>
<div style="text-align: left; font-size:40%">https://portal.azure.com/#@svc.onesto.dk/dashboard/private/1a4604a4-6679-437e-8fc9-af5df092b1cf</div>
<div style="text-align: left; font-size:40%">https://portal.azure.com/#view/Microsoft_Azure_CustomerHub/MyCustomersBladeV2/~/customers</div>

---

<br>

#### <div style="text-align: left; font-size:70%">Hvordan ser vi det?</div>

<br>
<br>
<br>
<br>
<br>
<br>

<div style="text-align: left; font-size:60%">User interface</div>
<div style="text-align: left; font-size:40%">https://portal.azure.com/#view/Microsoft_Azure_CustomerHub/ServiceProvidersBladeV2/~/scopeManagement</div>

<br>

<div style="text-align: left; font-size:60%">Command line</div>

---

<br>

#### Internal Privileges:

#### <div style="text-align: left; font-size:70%">User Admin Inheritance</div>

---

<br>

#### <div style="text-align: left; font-size:70%">Hvordan virker det?</div>

<br>
<br>
<br>
<br>
<br>
<br>

<div style="text-align: left; font-size:60%">Azure Portal</div>
<div style="text-align: left; font-size:40%">https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/Properties</div>

---

<br>

#### <div style="text-align: left; font-size:70%">Hvordan ser vi det?</div>

<br>
<br>
<br>
<br>

<div style="text-align: left; font-size:60%">User interface</div>
<div style="text-align: left; font-size:40%">https://portal.azure.com/#view/Microsoft_Azure_Resources/ManagmentGroupDrilldownMenuBlade/~/iam/tenantId/56570c5a-7db7-41e1-8b1d-a5f040b12855/mgId/56570c5a-7db7-41e1-8b1d-a5f040b12855/mgDisplayName/Tenant%20Root%20Group/mgCanAddOrMoveSubscription~/true/mgParentAccessLevel/Not%20Authorized/defaultMenuItemId/overview/drillDownMode~/true</div>

<br>

<div style="text-align: left; font-size:60%">Alerting</div>
<div style="text-align: left; font-size:40%">https://portal.azure.com/#@lenander.name/resource/subscriptions/056b7a12-e544-4435-ae1f-2090b4b7939a/resourceGroups/rg-management-logging-001/providers/Microsoft.OperationalInsights/workspaces/log-lenander-001/logs</div>

<br>

<div style="text-align: left; font-size:60%">Command line</div>