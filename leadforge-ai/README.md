# LeadForge AI

Automated B2B outbound system for IT consulting firms — AI-powered lead scoring, sector segmentation, and multi-cadence email campaigns. Built with n8n, PostgreSQL, and Claude AI.

---

## What it does

LeadForge automates the full outbound motion from raw contact list to personalized email delivery:

1. **Import** — uploads a CSV of prospects via n8n form trigger
2. **Score** — Claude Haiku evaluates each prospect (0–100) and classifies sector
3. **Segment** — routes prospects to sector-specific email tracks (gobierno, salud, municipio, cooperativa, privado)
4. **Send** — delivers personalized emails on a MON/WED/FRI cadence, each with a different angle (educational → case study → offer/CTA)
5. **Track** — logs every send to PostgreSQL, updates prospect sequence step

---

## Stack

| Layer | Tool |
|-------|------|
| Workflow automation | n8n (self-hosted) |
| Database | PostgreSQL 17 |
| AI scoring & copy | Claude Haiku (`claude-haiku-4-5-20251001`) |
| Email delivery | Microsoft 365 SMTP |
| Infra | Docker on EasyPanel VPS |
| DB management | DbGate |

---

## Database schema

```sql
prospects          -- 685 contacts, AI-scored, sector-classified
campaign_topics    -- 9 email topics (MON/WED/FRI × sector)
email_log          -- full send history with status tracking
suppression_list   -- unsubscribes and bounces
v_campaign_eligible -- view: active prospects not over-contacted
```

---

## Email cadence

| Day | Angle | Example sectors |
|-----|-------|----------------|
| Monday | Educational | FEMA BRIC funds for municipalities, COSSEC compliance for cooperativas |
| Wednesday | Case study | FortiGate security eval for gobierno, Microsoft licensing for salud |
| Friday | Offer / CTA | Free cybersecurity assessment, COSSEC compliance diagnostic |

Topics are sector-matched first, then fall back to `general` if no sector-specific topic exists.

---

## Workflows

| File | Function |
|------|----------|
| `02-prospect-import.json` | CSV upload → dedup → Claude Haiku scoring → PostgreSQL insert |
| `03-email-campaign.json` | Schedule trigger → eligible prospects → Claude Haiku email generation → SMTP send → log |
| `05-google-alerts-monitor.json` | Monitors government procurement alerts for trigger events |

---

## Lead scoring logic

Claude Haiku receives prospect data (company, title, sector) and returns:

```json
{
  "lead_score": 74,
  "sector": "gobierno",
  "notes": "Director-level at municipal agency — high fit for FEMA compliance services"
}
```

Scoring factors: title seniority, sector fit for IT consulting, company type, geographic relevance (Puerto Rico government/health/coop ecosystem).

---

## Architecture

```
CSV Upload
    │
    ▼
n8n: Extract + Normalize + Dedup
    │
    ▼
Claude Haiku: Score (0-100) + Classify sector
    │
    ▼
PostgreSQL: prospects table (UPSERT, conflict-safe)
    │
    ▼
Schedule Trigger (MON/WED/FRI 9am)
    │
    ▼
v_campaign_eligible → JOIN campaign_topics (by day_slot + sector)
    │
    ▼
Claude Haiku: Generate personalized subject + body
    │
    ▼
Microsoft 365 SMTP: Send from your-email@company.com
    │
    ▼
PostgreSQL: email_log INSERT + prospects UPDATE (last_email_at, sequence_step)
```

---

## Key GTM decisions

**Why sector-based segmentation instead of one blast?**
Puerto Rico's B2B market segments sharply by vertical — a municipio has FEMA BRIC budget cycles, a cooperativa has COSSEC compliance pressure, a hospital has HIPAA exposure. Generic emails perform poorly. Sector-matched messaging drives reply rates.

**Why MON/WED/FRI cadence?**
Avoids Monday morning inbox saturation (send mid-morning), uses Wednesday as the highest-open-rate day for B2B, closes the week with a low-friction CTA. Classic outbound pattern validated across SaaS GTM playbooks.

**Why Claude Haiku for copy generation instead of templates?**
Templates require manual maintenance per sector × angle × product. Haiku generates contextually relevant copy at runtime using prospect data — scales to any new sector without template updates.

**Why AI scoring before sending?**
Prioritizes high-fit prospects (score 70+) in send order. Protects sender reputation by not burning the domain on low-fit contacts. Feeds future A/B testing by segment.

---

## Setup

### Prerequisites
- n8n (self-hosted or cloud)
- PostgreSQL database named `leadforge`
- Anthropic API key
- Microsoft 365 mailbox with SMTP AUTH enabled

### Database
```bash
# Run against your PostgreSQL instance
psql -U your_user -d leadforge -f n8n-workflows/setup-db-v3.sql
```

### n8n credentials needed
| Credential name | Type | Used for |
|----------------|------|---------|
| `Postgres account 2` | PostgreSQL | All DB queries |
| `Header Auth account` | HTTP Header Auth | Anthropic API (`x-api-key`) |
| `ITCPR Microsoft 365` | SMTP | Email delivery |

### Import workflows
In n8n: **Workflows → Import from file** → select each `.json` in `n8n-workflows/`

---

## Results (685 prospects imported)

| Sector | Prospects | Avg AI Score |
|--------|-----------|-------------|
| gobierno | 172 | 74 |
| salud | 141 | 76 |
| privado | 123 | 49 |
| municipio | 118 | 76 |
| cooperativa | 69 | 67 |
| general | 62 | 37 |

---

## Author

**Luis Rivera** — GTM Engineer
IBM Silver Partner · Microsoft · Cisco · Fortinet · Dell EMC · VMware
