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
