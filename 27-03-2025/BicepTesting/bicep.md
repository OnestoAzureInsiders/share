---
marp: true
theme: gaia
_class: lead
paginate: false
font-size: 10pt
backgroundColor: #fff
backgroundImage: url("background.png")

---

<div style="text-align: right; font-size:70%">27.03.2025</div>
<br>
<br>

## Bicep Testing

---

<br>

### Bicep Testing
<span style="font-size:70%"> • Linting</span>
<span style="font-size:70%"> • Validation</span>
<span style="font-size:70%"> • What-If</span>

---

<br>

#### Linting

- VS Code extension (Bicep VS Code extension)


- Kan fange syntaksfejl, ubrugte variabler, manglende parametre og andre problemer.

---

<br>

#### Linting

## DEMO

---

<br>

#### Validation

- Azure CLI (az bicep build --file <filename>) / (az deployment xxx validate --template-file <filename>)

- Validerer at Bicep-filen kan konverteres til ARM JSON og at den er syntaktisk korrekt.

---

<br>

#### Validation

## DEMO

---

<br>

#### What-If

- Azure CLI (az deployment group what-if --resource-group <rg> --template-file <filename>) / (Get-AzDeploymentWhatIfResult -TemplateFile <filename>)

- Kan bruges til at se hvad der vil ske hvis deployment køres. Hvilke resources der vil blive oprettet, ændret eller slettet.

---

<br>

#### What-If

## DEMO