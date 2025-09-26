---
marp: true
theme: gaia
_class: lead
paginate: false
font-size: 10pt
backgroundColor: #fff
backgroundImage: url("pics/background.png")

---

<div style="text-align: right; font-weight: bold;font-size:70%">25.09.2025</div>
<br>
<br>

# Notes from the field 
# (Flewers Rodekasse)

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## TOPICS

- Bicep "Next Level"
  - Graph extension
  - Experimental features
  - Next-level type-declarations
    - @discriminator property
    - resourceInput<'resourceprovider'>
  - Bicep Artifacts (versioning)

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## TOPICS

- VsCode tips
  - VsCode Tasks
  - Devops Pipeline extension
- Azure Devops tips
  - Managed Agent Pools
  - Pull Request template
  - Pull Request Build validations
  - Pipeline & Agent pool security

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## TOPICS

- Azure Devops tips
  - Managed Agent Pools
  - Pull Request Build validations
  - Pipeline & Agent pool security

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## Bicep Next Level

**Graph Extension** (GA nu!)
`extension  
'br:mcr.microsoft.com/bicep/extensions/microsoftgraph/v1.0:1.0.0'`
(line wrapped)
`resource eIdGroup 'Microsoft.Graph/groups@v1.0' = `

Demo:
*entraIdGroup.bicep*
*main.bicep*
*Portal*

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## Bicep Next Level

**Experimental features:**
https://github.com/Azure/bicep/blob/main/docs/experimental-features.md

- Konfigureres i bicepConfig.json

![bicepConfig height:5cm](pics/bicepConfig.png)

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## Bicep Next Level

**@onlyifnotexists decorator**  
- Experimental i dag 
- På vej til GA

Demo:
*keyVault.bicep*
*main.bicep*
*Portal*

![bg right height:8cm](pics/onlyifnotexists-ga.png)

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## Bicep Next Level

**@discriminator decorator**

- Multi-path type-declarations
![discriminator](pics/bicepDiscriminator.png)

Demo: 
*bicepTypes.bicep*
*main.bicep*

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## Bicep Next Level

**resourceInput function**
- Easy type declarations
- Pull from API
`type MyType = resourceInput<'resourceprovider'>.properties`  

Demo:
*main.bicep*

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## Bicep Next Level

**Bicep Artifacts**
- Simpel versionering af Bicep moduler
- Undgå "breaking changes" i kørende pipelines
- Minder om NuGet pakker  

`az artifacts universal`

Demo:
*Create new artifact* (pipeline)
*Download artifact*

![artifacts height:10cm](pics/universalArtifacts.png)

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## VsCode tips

**VsCode Tasks**
- Configure tasks
- `<vscode-start-directory>\.vscode\tasks.json`
- Run commands or scripts
- Use the Run task command

![tasks height:4cm](vscodeTasks.png)

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## VsCode tips

**Azure Devops Pipeline extension**
![pipelinExtension](pipelineTools.png)
![validatePipeline](validatePipeline.png)
Demo:
*buildArtifacts.yaml*

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## Azure Devops tips

**Managed Agent Pools**

- Virtual Network injection
![vnetInjection height:3cm](devopPool.png)
- Agent state
![agentState height:1cm](agentState.png)

Demo:
*buildArtifacts.yaml*

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## Azure Devops tips

**Pull Request Template**

- Markdown template
- Tjekket ind i repo
![prTemplate height:4cm](prTemplate.png)
![bg right height:8cm](prChecklist.png)

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## Azure Devops tips

**Pull Request Build validation**

- Branch policy
![build-validation height:9cm](build-validation.png)

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## Azure Devops tips

**Pull Request Build validation**
- Validering af kode
  - INDEN det tjekkes ind i main
- Eks. Bicep linting

Demo:
*bicep-validation.yaml*
*pull requests -> bicep-artifacts -> abandoned*
*pipelines -> bicep-validation*

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## Azure Devops tips

**Required YAML template**

- Kan sættes som krav på service connections & agent pools
- Kræv extends fra et repo som vi har styr på
- Eks. en Bicep deployment pipeline extend

![bg right height:12cm](requiredTemplate-1.png)

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## Azure Devops tips

**Using pipeline extends**

- Pipeline benytter agent pool og service connection
- Begge er privilegerede
- Pipeline extend kontrollerer præcist, hvad der må afvikles
- Extend ligger i et begrænset repository

![bg right height:12cm](extendedPipeline.png)

---

<div style="text-align: center; vertical-align: top; font-size:90%; color: white; font-weight: bold;"></div>

## Azure Devops tips

**Using pipeline extends**

*Failed template check*
![failedCheck height:8cm](failedTemplateCheck.png)