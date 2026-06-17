# 🎯 Clay GTM Pipeline — B2B Healthcare IT Outbound

> Multi-source Clay pipeline for ICP-scored outbound targeting US companies (10–200 employees) across Healthcare IT, Credit Union, and Municipal verticals.

Built and deployed as part of **LeadForge AI** — a full-stack outbound automation system integrating Clay → n8n → PostgreSQL → email sequencing.

---

## Pipeline Architecture

```
[LinkedIn Sales Navigator]
         │
         ▼
┌─────────────────────────────────────┐
│  US Companies · 10–200 Employees   │  ← 558 rows · 26 columns enriched
│  Company Table (multi-enrichment)  │  ← ~$6/row · waterfall across 150+ providers
└─────────────────┬───────────────────┘
                  │
        ┌─────────┴──────────┐
        ▼                    ▼
┌───────────────┐    ┌──────────────────────────┐
│ Healthcare IT │    │ Company Contacts          │
│ Execs FL & PR │    │ 558 Companies (full pull) │
│ 3 rows        │    │ 999 rows                  │
└──────┬────────┘    └────────────┬─────────────┘
       ▼                          ▼
┌───────────────┐    ┌──────────────────────────┐
│ Person Table  │    │ Person Table              │
│ 31 columns    │    │ 31 columns                │
│ $3.9/row      │    │ $3.9/row                  │
└───────────────┘    └──────────────────────────┘
        │                         │
        └─────────┬───────────────┘
                  ▼
        [LeadForge AI · n8n + PostgreSQL]
        [Sequenced Email + LinkedIn Outreach]
```

---

## What This Pipeline Does

### Stage 1 — Source & Filter
- Export ICP-matched companies from LinkedIn Sales Navigator (10–200 employees, US, healthcare-adjacent)
- 558 companies ingested as base layer

### Stage 2 — Company Enrichment (26 columns)
Waterfall enrichment across 150+ Clay providers:

| Column | Source |
|--------|--------|
| Website | Clay built-in |
| LinkedIn URL | Clay / Apollo |
| Employee count (verified) | Clay / Crunchbase |
| HQ address | Clay / Google Maps |
| Tech stack signals | BuiltWith via Clay |
| Revenue estimate | Crunchbase / Clay |
| Job posting signals | Clay / LinkedIn |
| AI company summary | Claygent (GPT-4) |

### Stage 3 — Parallel Segmentation
Two branches run simultaneously:

**Branch A — Precision segment (Healthcare IT, FL & PR)**
- Filters for IT decision-makers in Florida and Puerto Rico
- 3 high-fit contacts for hyper-personalized outreach

**Branch B — Broad contact pull (all 558 companies)**
- Full person-level enrichment across entire company list
- 999 contacts with verified email, phone, LinkedIn, seniority

### Stage 4 — Person Enrichment (31 columns per contact)
- Verified work email (3-provider waterfall: Apollo → Hunter → Clay)
- Mobile phone
- LinkedIn profile URL
- Job title + seniority level
- Claygent AI personalization snippet per contact

### Stage 5 — Export to Outbound Engine
- Contacts pushed to LeadForge AI (n8n workflow)
- Stored in PostgreSQL with campaign tagging
- Sequenced via Instantly for email outreach
- LinkedIn touchpoints run in parallel

---

## Key Metrics

| Metric | Value |
|--------|-------|
| Total companies | 558 |
| Total contacts enriched | 999 |
| Company columns | 26 |
| Contact columns | 31 |
| Company enrichment cost | ~$6/row |
| Contact enrichment cost | $3.9/row |
| Est. manual hours saved | 40–60 hrs per run |

---

## Tech Stack

| Layer | Tools |
|-------|-------|
| Prospecting | LinkedIn Sales Navigator |
| Enrichment | Clay (waterfall: Apollo, Hunter, Crunchbase, BuiltWith, Clearbit) |
| AI personalization | Claygent (GPT-4 inside Clay) |
| Automation | n8n |
| Storage | PostgreSQL |
| Sequences | Instantly |
| Outbound engine | LeadForge AI v6.0 |

---

## Verticals Supported

This pipeline template has been adapted for:

- **Healthcare IT** — IT directors, CIOs, VPs of Technology at healthcare SMBs
- **Credit Unions** — Technology and operations decision-makers at credit unions
- **Municipalities** — IT and procurement contacts at US municipal governments
- **US Continental Expansion** — Outbound motion for new market entry

---

## Repository Structure

```
clay-gtm-pipeline/
├── README.md
├── schemas/
│   ├── company-enrichment-columns.md    ← Full column definitions (26 columns)
│   └── person-enrichment-columns.md     ← Full column definitions (31 columns)
├── templates/
│   ├── icp-filters-healthcare-it.md     ← LinkedIn Sales Navigator filter config
│   └── claygent-prompts.md              ← AI prompts for enrichment and personalization
└── exports/
    └── sample-output-schema.json        ← Anonymized sample of enriched output
```

---

## Related Projects

| Repo | Description |
|------|-------------|
| [`leadforge-ai`](../leadforge-ai) | Full outbound automation engine — n8n + PostgreSQL + email sequencing |
| [`linkedin-autopost`](../linkedin-autopost) | AI-powered LinkedIn content automation |

---

## About

Built by **Luis Daniel Rivera** — GTM Engineer & Network Engineer  
📧 danielriverarios@gmail.com
