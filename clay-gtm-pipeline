# 🚀 LeadForge AI v6.0

Full-stack B2B outbound automation engine built with n8n, PostgreSQL, and Claude AI. Deployed in production for Puerto Rico and US continental market campaigns.

---

## What It Does

LeadForge automates the full outbound motion from raw contact list to personalized email delivery:

1. **Import** — upload a CSV of prospects via n8n form trigger
2. **Score** — Claude Haiku evaluates each prospect (0–100) and classifies sector
3. **Segment** — routes prospects to sector-specific email tracks (government, health, municipality, cooperative, private)
4. **Send** — delivers personalized emails on a Mon/Wed/Fri cadence, each with a different angle (educational → case study → offer/CTA)
5. **Track** — logs every send to PostgreSQL, updates prospect sequence step
6. **Listen** — monitors Gmail for replies, bounces, and unsubscribes in real time
7. **Intelligence** — scans ComprasPR and Google Alerts for inbound RFP and market opportunities

---

## System Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                      INBOUND INTELLIGENCE                        │
│  05 ComprasPR Monitor (4x/day)  ──► AI scoring ──► leads DB    │
│  06 Google Alerts RSS (8am)     ──► AI scoring ──► leads DB    │
│  07 Followup Message Generator  ──► AI message ──► your inbox  │
└────────────────────────────┬────────────────────────────────────┘
                             │
┌────────────────────────────▼────────────────────────────────────┐
│                        OUTBOUND ENGINE                           │
│  02 Prospect Import  ──► Haiku scoring ──► prospects DB         │
│  03 Campaign Engine (Mon/Wed/Fri) ──► Sonnet ──► Gmail send    │
│  04 Reply Handler (every 15min) ──► classify ──► suppress/HOT  │
└────────────────────────────┬────────────────────────────────────┘
                             │
┌────────────────────────────▼────────────────────────────────────┐
│                      REPORTING & VISIBILITY                      │
│  08 Weekly Analytics (Saturday 8am) ──► HTML report ──► inbox  │
│  09 Dashboard API (GET /lf6-dashboard) ──► live JSON ──► UI    │
└─────────────────────────────────────────────────────────────────┘
```

---

## Stack

| Layer | Tool |
|-------|------|
| Workflow automation | n8n (self-hosted, Docker) |
| Database | PostgreSQL 17 |
| AI — scoring & classification | Claude Haiku (`claude-haiku-4-5-20251001`) |
| AI — email copywriting | Claude Sonnet (`claude-sonnet-4-6`) |
| Email delivery | Gmail (OAuth2) |
| Infra | Docker on EasyPanel VPS (Hostinger) |
| DB management | DbGate |

---

## Workflows

| # | File | Description |
|---|------|-------------|
| 02 | `02-WF-prospect-import.json` | CSV upload → normalize → Haiku scoring → PostgreSQL |
| 03 | `03-WF-campaign-engine.json` | Mon/Wed/Fri send engine — Sonnet email generation, 45s throttle, CAN-SPAM footer |
| 04 | `04-WF-reply-handler.json` | Polls Gmail every 15min — classifies replies, bounces, and unsubscribes |
| 05 | `05-WF-compraspR-monitor.json` | Scans Gmail 4x/day for ComprasPR RFPs — AI scores and alerts on high-value bids |
| 06 | `06-WF-google-alerts-monitor.json` | Reads 3 RSS feeds daily — scores opportunities and sends morning digest |
| 07 | `07-WF-followup-message-generator.json` | Generates D3/D7/D30 followup messages for qualified leads — delivered to inbox for manual send |
| 08 | `08-WF-weekly-analytics.json` | Saturday report — sends, replies, reply rate, and hot leads by angle |
| 09 | `09-WF-dashboard-api.json` | Authenticated webhook returning live KPIs, 30-day series, and full prospect list |

**Lead scoring output (workflow 02):**
```json
{
  "lead_score": 74,
  "sector": "government",
  "notes": "Director-level at municipal agency — high fit for FEMA compliance services"
}
```

---

## Database

```sql
prospects           -- All contacts, AI-scored and sector-classified
campaign_topics     -- Email topics by day_slot x sector (MON/WED/FRI)
email_log           -- Every send: status, angle, day_slot, message_id
suppression_list    -- Unsubscribes and hard bounces (never emailed again)
leads               -- Inbound opportunities from ComprasPR and Google Alerts
v_campaign_eligible -- View: active prospects eligible for next send
```

---

## Email Cadence

| Day | Angle | Focus |
|-----|-------|-------|
| Monday | Educational | Funding cycles, compliance awareness |
| Wednesday | Case study | Real deployments, measurable outcomes |
| Friday | Offer / CTA | Free assessment, diagnostic offer |

Topics are sector-matched per prospect. Fallback to `general` if no sector-specific topic exists for that slot.

---

## Setup

### Prerequisites
- n8n self-hosted (Docker)
- PostgreSQL 17 — database named `leadforge`
- Anthropic API key
- Gmail account with OAuth2 configured in n8n

### Database
```bash
psql -U your_user -d leadforge -f setup-db-v3.sql
```

### Environment Variables
```env
ANTHROPIC_API_KEY=your_anthropic_key
LF6_DASHBOARD_KEY=your_dashboard_secret_key
```

### n8n Credentials

| Name | Type |
|------|------|
| `LeadForge PostgreSQL` | PostgreSQL |
| `Header Auth account` | HTTP Header Auth (`x-api-key`) |
| `Gmail account 2` | Gmail OAuth2 |

### Import Order
In n8n: **Workflows → Import from file** — import in numerical order (02 → 09).

> **Google Alerts setup (workflow 06):** Create three RSS alerts at [google.com/alerts](https://google.com/alerts) and replace the `REPLACE_WITH_RSS_URL_X` placeholders in the workflow nodes.

---

## Results (Production — 685 Prospects)

| Sector | Prospects | Avg AI Score |
|--------|-----------|-------------|
| Government | 172 | 74 |
| Health | 141 | 76 |
| Private | 123 | 49 |
| Municipality | 118 | 76 |
| Cooperative | 69 | 67 |
| General | 62 | 37 |

---

## Related Projects

| Repo | Description |
|------|-------------|
| [`clay-gtm-pipeline`](../clay-gtm-pipeline) | Clay enrichment pipeline feeding this engine |
| [`linkedin-autopost`](../linkedin-autopost) | AI-powered LinkedIn content automation |

---

## About

Built by **Luis Daniel Rivera** — GTM Engineer & Network Engineer  
📧 danielriverarios@gmail.com
