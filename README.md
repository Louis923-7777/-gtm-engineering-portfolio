# GTM Engineering Portfolio

Production systems that automate revenue operations, customer acquisition, and go-to-market execution — built end-to-end with AI, workflow orchestration, and real databases.

---

## Projects

### [LeadForge AI](./leadforge-ai)
**AI-powered B2B outbound engine**

Automated the full outbound motion for an IT consulting firm: CSV import → AI lead scoring → vertical segmentation → personalized email sequences. Ingested 685 contacts, scored each with Claude Haiku, and routed them into sector-specific MON/WED/FRI email cadences with suppression and engagement tracking.

`n8n` `PostgreSQL` `Claude AI` `Microsoft 365` `Docker`

---

### [LinkedIn AutoPost Engine](./linkedin-autopost)
**Autonomous content system — 6 posts/day across two accounts, zero manual work**

Publishes to both a company page and a personal profile daily, drawing from a 60-topic IT catalog rotated algorithmically to prevent repetition. Each post runs through a 4-model AI pipeline, receives a Kie.ai-generated cinematic image, and requires one-click human approval before publishing via the LinkedIn API.

`n8n` `Claude Sonnet` `Claude Haiku` `GPT-4o Mini` `Kie.ai` `LinkedIn API` `Gmail API` `PostgreSQL`

---

### [Ombraxis AI](./ombraxis-ai)
**Managed pentesting SaaS — AI vulnerability analysis + compliance reporting**

Multi-tenant SaaS platform for security consultants. Orchestrates nmap, nikto, nuclei, and masscan; routes raw output to Claude Sonnet for business-risk narrative; and generates DOCX, PDF, and Excel reports mapped to NIST CSF 2.0, HIPAA, CMMC Level 2, and PCI DSS 4.0. Delivered across 15 sprints — from auth scaffold to scheduled compliance report delivery.

`FastAPI` `PostgreSQL` `Redis` `Docker` `Claude Sonnet` `python-docx` `openpyxl` `JWT` `TOTP MFA`

---

## What I build

I work at the intersection of sales, marketing, and engineering — building the systems that make revenue motions run without manual intervention.

| Capability | What that looks like |
|------------|---------------------|
| **Outbound automation** | Lead scoring, email sequencing, suppression logic, cadence management |
| **AI-powered copy** | Sector-specific email generation, LinkedIn content at scale, runtime personalization |
| **Data pipelines** | CSV ingestion, dedup, normalization, PostgreSQL as CRM source of truth |
| **Revenue ops** | Prospect lifecycle tracking, sequence steps, engagement logging |
| **Content systems** | Multi-account publishing, approval workflows, topic rotation, image generation |
| **Compliance reporting** | NIST, HIPAA, CMMC, PCI DSS — automated gap analysis and executive-ready reports |

---

## Stack

```
Orchestration   n8n SaaS 
AI              Claude Sonnet · Claude Haiku · GPT-4o Mini
Database        PostgreSQL 17
APIs            LinkedIn · Gmail · Anthropic · Microsoft 365 · Kie.ai
Backend         FastAPI (Python)
Infra           Docker · EasyPanel VPS
Reporting       python-docx · openpyxl · matplotlib · LibreOffice
```

---

## Author

**Luis Rivera** — GTM Engineer  
IBM Silver Partner · Microsoft · Cisco · Fortinet · Dell EMC · VMware
