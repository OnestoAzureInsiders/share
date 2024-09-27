---
marp: true
theme: gaia
_class: lead
paginate: false
backgroundColor: #fff
backgroundImage: url("../PPTBaggrund.png")
font-size: 10pt

---

# Azure Policy
![bg 85% contain opacity:.3](./png/AzurePolicy_Overview.png)

---
</br>

## Hvorfor har vi brug for Azure Policy?
![bg right height:13cm](./png/white.png)

---
</br>

## Hvorfor har vi brug for Azure Policy?
- Der skal være regler for leg i svømmehallen
![bg right height:13cm](./png/vipper.png)
![bg right height:13cm](./png/white.png)

---
</br>

## Hvorfor har vi brug for Azure Policy?
- Der skal være regler for leg i svømmehallen
![bg right height:13cm](./png/vipper.png)
![bg right height:13cm](./png/badetoej.png)

---
</br>

## Hvorfor har vi brug for Azure Policy?
- Der skal være regler for leg i svømmehallen
- Azure Policy er bademesteren
![bg right height:13cm](./png/vipper.png)
![bg right height:13cm](./png/badetoej.png)

---
</br>

## Hvorfor har vi brug for Azure Policy?
- Der skal være regler for leg i svømmehallen
- Azure Policy er bademesteren
  - Og bademesteren siger...
![bg right height:13cm](./png/vippenlukket.png)

---
</br>

## Hvorfor har vi brug for Azure Policy?
- Eller sagt på en anden måde...
![bg right height:13cm](./png/white.png)

---
</br>

## Hvorfor har vi brug for Azure Policy?
- Azure Policy er vores "guard rails", som sikrer:
![bg 85% right ](./png/guardrails.jpeg)

---
</br>

## Hvorfor har vi brug for Azure Policy?
- Azure Policy er vores "guard rails", som sikrer:
  - Compliance
![bg 85% right ](./png/guardrails.jpeg)

---
</br>

## Hvorfor har vi brug for Azure Policy?
- Azure Policy er vores "guard rails", som sikrer:
  - Compliance
  - Cost
![bg 85% right ](./png/guardrails.jpeg)

---
</br>

## Hvorfor har vi brug for Azure Policy?
- Azure Policy er vores "guard rails", som sikrer:
  - Compliance
  - Cost
  - Security
![bg 85% right ](./png/guardrails.jpeg)

---
</br>

## Azure Policy - praktiske eksempler
- Security: Deny public IP
![bg 85% contain opacity:.2](./png/AzurePolicy_Overview.png)

---
</br>

## Azure Policy - praktiske eksempler
- Security: Deny public IP
- Security: Enforce logs
![bg 85% contain opacity:.2](./png/AzurePolicy_Overview.png)

---
</br>

## Azure Policy - praktiske eksempler
- Security: Deny public IP
- Security: Enforce logs
- Cost: Deny specific VM types
![bg 85% contain opacity:.2](./png/AzurePolicy_Overview.png)

---
</br>

## Azure Policy - praktiske eksempler
- Security: Deny public IP
- Security: Enforce logs
- Cost: Deny specific VM types
- Compliance: Enforce location (EU GDPR)
![bg 85% contain opacity:.2](./png/AzurePolicy_Overview.png)

---
</br>

## Azure Policy - praktiske eksempler
- Security: Deny public IP
- Security: Enforce logs
- Cost: Deny specific VM types
- Compliance: Enforce location (EU GDPR)
- Management: Enforce tags, inherit tags
![bg 85% contain opacity:.2](./png/AzurePolicy_Overview.png)

---
</br>

## Azure Policy - praktiske eksempler
- Security: Deny public IP
- Security: Enforce logs
- Cost: Deny specific VM types
- Compliance: Enforce location (EU GDPR)
- Management: Enforce tags, inherit tags
- Management: Enforce Backup (DeployIfNotExist)
![bg 85% contain opacity:.2](./png/AzurePolicy_Overview.png)

---
</br>

## Azure Policy - praktiske eksempler
- Security: Deny public IP
- Security: Enforce logs
- Cost: Deny specific VM types
- Compliance: Enforce location (EU GDPR)
- Management: Enforce tags, inherit tags
- Management: Enforce Backup (DeployIfNotExist)
- Management: Audit for irregularities 
              (ex. computername different from VM name)
![bg 85% contain opacity:.2](./png/AzurePolicy_Overview.png)

---
</br>

## Azure Policy - Demo
- Deny public IP
- Enforce location
- Resource Naming
- Backup tag

![bg 85% contain right](./png/demotime.gif)

---
</br>

## Azure Policy demo 
### - byggeklodser
- Policy Definitions
- Policy Initiatives
- Policy Assignments
- Non-compliance messages
- Exclusions
- Exemptions
![bg 85% contain right](./png/excitedkid.jpeg)

---
</br>

## Azure Policy demo 
### - lidt dybere...
- Policy Effects
  - Deny
  - Audit
  - Modify (tags)
  - Append (add properties)
  - DeployIfNotExist
![bg 85% contain right](./png/gettingbored.jpg)

---
</br>

## Azure Policy demo 
### - dybere endnu...
- PolicyRules
- Parameters
  - Strongtypes
  - DefaultValues
  - PortalReview
- Initiative Parameters

![bg 85% contain right](./png/sleeping.jpg)

---
</br>

## Azure Policy demo 
### - tror vi holder her!
- Deployment Scopes
  - ResourceGroup scope
  - Subscription Scope
  - Nested templates
- VsCode Plugin

![bg 85% contain right](./png/gonetofar.jpg)

