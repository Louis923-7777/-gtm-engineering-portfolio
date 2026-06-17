# GTM Engineering Portfolio

Production systems that automate revenue operations, customer acquisition, and go-to-market execution — built end-to-end with AI, workflow orchestration, and real databases.

---

## Projects

### [LeadForge AI](https://github.com/danielriverarios/leadforge-ai)

**AI-powered B2B outbound engine**

Full closed-loop outbound system: CSV import → AI lead scoring → vertical segmentation → personalized email sequences → reply detection → procurement intelligence. Ingested 685 contacts, scored each with Claude Haiku, and routed them into sector-specific MON/WED/FRI email cadences with suppression, engagement tracking, and a live dashboard API. 8 active n8n workflows in production.

`n8n` `PostgreSQL` `Claude Haiku` `Claude Sonnet` `Gmail API` `Docker`

---

### [Clay GTM Pipeline](https://github.com/danielriverarios/clay-gtm-pipeline)

**ICP-scored B2B prospecting pipeline**

Multi-source Clay pipeline targeting US companies (10–200 employees) across Healthcare IT, Credit Union, and Municipal verticals. Enriches 558 companies across 26 columns via waterfall enrichment, branches into precision and broad contact segments, and exports 999 enriched contacts into LeadForge AI for outbound sequencing.

`Clay` `LinkedIn Sales Navigator` `Claygent` `n8n` `PostgreSQL`

---

### [LinkedIn AutoPost Engine](https://github.com/danielriverarios/linkedin-autopost)

**Autonomous content system — 6 posts/day across two accounts, zero manual work**

Publishes to both a company page and a personal profile daily, drawing from a 60-topic IT catalog rotated algorithmically to prevent repetition. Each post runs through a 4-model AI pipeline, receives a Kie.ai-generated cinematic image, and requires one-click human approval before publishing via the LinkedIn API.

`n8n` `Claude Sonnet` `Claude Haiku` `GPT-4o Mini` `Kie.ai` `LinkedIn API` `Gmail API` `PostgreSQL`

---

## Stack

```
Orchestration    n8n (self-hosted, Docker)
AI               Claude Sonnet · Claude Haiku · GPT-4o Mini
Enrichment       Clay · LinkedIn Sales Navigator · Apollo · Hunter
Database         PostgreSQL 17
APIs             LinkedIn · Gmail · Anthropic · Kie.ai
Infra            Docker · EasyPanel VPS (Hostinger)
```

---

## About

**Luis Daniel Rivera** — GTM Engineer & Network Engineer  
📧 danielriverarios@gmail.com

