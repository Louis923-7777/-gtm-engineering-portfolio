# LinkedIn AutoPost — ITCPR Content Engine v6

Fully automated LinkedIn content system that publishes 3 posts per day across two accounts (company page + personal profile), with AI-generated copy, AI-generated images, and a human approval gate before each post goes live. Built with n8n, Claude, GPT-4o Mini, Kie.ai, and PostgreSQL.

---

## What it does

Every weekday at 9am, 12pm, and 5pm AST, the system:

1. **Selects a topic** from a 60-topic IT catalog, rotated algorithmically — no repeats across slots or accounts
2. **Researches the topic** with Claude Haiku: extracts key ideas, quantitative data points, and a contrarian insight
3. **Structures the content** with GPT-4o Mini: hook → problem → insight → quantitative anchor → example → recommendation → CTA
4. **Writes two posts simultaneously** with Claude Sonnet:
   - Post 1: ITCPR company page — institutional voice, neutral consultant tone
   - Post 2: Luis Rivera personal profile — first-person, CTO reflection style
   - Each post uses a different topic and a different format from 7 rotating templates
5. **Generates a cinematic image** with Kie.ai (Flux-2) — technical subject only, no people, no offices, no logos
6. **Sends approval email** with post preview + image + one-click Approve/Reject buttons
7. **Publishes to LinkedIn** via API on approval, uploads image as native asset
8. **Logs the result** to PostgreSQL

---

## Stack

| Layer | Tool |
|-------|------|
| Workflow orchestration | n8n (self-hosted) |
| Content research | Claude Haiku (`claude-haiku-4-5-20251001`) |
| Content structuring | Claude Haiku |
| Post writing | Claude Sonnet (`claude-sonnet-4-6`) |
| Post refinement | Claude Haiku (separate pass per account) |
| Image generation | Kie.ai — Flux-2 model |
| Approval delivery | Gmail API (OAuth2) |
| Publishing | LinkedIn API v2 (ugcPosts + asset upload) |
| Logging | PostgreSQL |
| Prompt caching | Anthropic prompt-caching-2024-07-31 |

---

## Topic catalog — 60 curated IT topics

Topics are grouped by domain and rotated deterministically (day × slot), ensuring no topic repeats across morning/midday/evening in the same day, and the company page and personal profile always post on different topics.

| Domain | Topics |
|--------|--------|
| Compliance & governance | COSSEC, HIPAA, PCI DSS 4.0, NIST CSF 2.0, 21 CFR Part 11, FERPA, SOC 2, GLBA, ISO 27001, GDPR/CCPA |
| Cybersecurity | Zero Trust, ransomware, threat hunting, identity threats, supply chain attacks, MFA fatigue, OT/IT, cyber insurance, pentesting, AD hardening |
| Infrastructure | SD-WAN, Meraki, hybrid cloud, Kubernetes, mainframe modernization, immutable backup, storage tiering, network observability, edge computing, HCI |
| Continuity & resilience | DRaaS, BCP cooperativas, telecom redundancy, clinical continuity, tabletop exercises |
| Government & public sector | OGP 2026, PRITS, FEMA BRIC, NIST CSF for municipalities, IT procurement |
| Verticals | Healthcare, retail, hospitality, automotive dealers, transportation, construction, education, medical cooperatives, regulated manufacturing |
| Enterprise AI | IBM watsonx, Microsoft Copilot governance, AI governance/EU AI Act, RAG security, AI red teaming, document intelligence, AI FinOps |
| Executive strategy | CIO scorecard, technical debt, cloud repatriation, build/buy/partner, M&A integration, vendor consolidation |

---

## Content formats — 7 rotating templates

Each post uses one of 7 structural formats, selected by day of week × time slot:

| Format | Structure |
|--------|-----------|
| `TESIS_CONTRAINTUITIVA` | Contrarian thesis → evidence with data → executive implication → strategic question |
| `DATO_PRIMERO` | Quantitative data first → meaning for the executive → strategic implication |
| `DISTINCION_CONCEPTUAL` | Separates two commonly confused concepts → precision definition → data anchor → memorable insight |
| `PERSPECTIVA_CFO` | Cost of exposure vs prevention vs inaction → financial argument, not technical |
| `PATRON_SECTORIAL` | Sector pattern observation → aggregate data → most underestimated implication |
| `MARCO_ANALITICO` | Three analytical dimensions → develops the least-discussed → executive recommendation |
| `TENDENCIA_MADURA` | Maturing technology → what changed 2022–2025 → least anticipated consequence |

---

## Visual dictionary — image generation

Images are generated with domain-specific prompts that map each IT topic to a precise visual object. Rules:
- **No people, no executives, no offices, no skylines, no logos, no flags**
- Cinematic photorealistic 3D render or editorial photography style
- Shallow DOF f/1.4–f/2.8, 1:1 aspect ratio
- Each topic maps to a specific color palette

| Domain | Visual |
|--------|--------|
| Network/fiber | Bundle of fiber optic cables, bioluminescent cyan-amber |
| Zero Trust | Layered translucent network segments, crimson-blue perimeter rings |
| Ransomware/SIEM | Digital threat heatmap, red intrusion nodes on dark crimson-black |
| Data center | Premium server blade infrastructure, charcoal and steel-blue |
| AI/GPU | GPU compute cluster macro with neural network overlay, violet-magenta |
| BCP/DR | Twin mirrored data centers with failover replication beam, cold-blue and emergency-amber |
| HIPAA/health | Server infrastructure, sterile white-teal, abstract patient data flow streams |
| COSSEC/cooperativas | Vault-secure encrypted data nodes, amber-gold, financial ledger mesh |

---

## Approval flow

```
Post generated
    │
    ▼
Email with preview → Approve / Reject buttons
    │
    ├── APPROVE → Kie.ai generates image → Upload to LinkedIn → Publish → Confirmation email
    │
    └── REJECT  → Discard email sent, post not published
```

Separate approval flow for company page and personal profile. Retry logic (3 attempts × 90s) for image generation before failing gracefully.

---

## Posting schedule

| UTC | AST | Slot | Content type |
|-----|-----|------|-------------|
| 12:00 | 8:00am | Mañana | Tip técnico |
| 16:00 | 12:00pm | Mediodía | Caso de uso |
| 21:00 | 5:00pm | Tarde | Thought leadership |

Weekdays only (Mon–Fri). 3 posts/day × 2 accounts = up to 6 LinkedIn posts per day.

---

## Architecture

```
Schedule (3x/day, Mon–Fri)
    │
    ▼
Code: Select topic + angle by day/slot (deterministic rotation, no repeats)
    │
    ▼
Claude Haiku: Research — ideas_clave + datos_relevantes + insight_principal
    │
    ▼
Claude Haiku: Structure — hook / problema / insight / ancla_cuantitativa / ejemplo / recomendacion / CTA
    │
    ▼
Claude Sonnet: Write Post 1 (ITCPR) + Post 2 (Personal) + Image Prompt 1 + Image Prompt 2
    │
    ├── Claude Haiku: Refine Post 1 (company voice) ──→ Gmail: Send approval email
    │                                                        │
    │                                                   Approve ──→ Kie.ai: Generate image
    │                                                              ──→ LinkedIn API: Upload + Publish
    │                                                              ──→ Gmail: Confirmation
    │                                                   Reject ──→ Gmail: Discard notice
    │
    └── Claude Haiku: Refine Post 2 (personal voice) ──→ Gmail: Send approval email
                                                              │
                                                         [same approval flow]
```

---

## GTM design decisions

**Why 60 topics rotated deterministically instead of random?**
Random selection risks topic repetition within the same week, which erodes audience trust. Deterministic rotation guarantees maximum topic diversity across slots — morning, midday, and evening in the same day always cover different domains.

**Why 4-model pipeline (Haiku research → Haiku structure → Sonnet writing → Haiku refine)?**
Each model does what it's best at. Haiku extracts and classifies fast. Sonnet writes nuanced, format-aware content. The final Haiku pass applies account-specific tone adjustments without regenerating the full post. Cost per execution is significantly lower than running Sonnet for all steps.

**Why a human approval gate instead of auto-publishing?**
LinkedIn penalizes accounts for content that gets flagged or removed. One bad post can suppress reach for 30+ days. The approval email takes 10 seconds to action and catches hallucinated data, inappropriate tone, or image mismatches before they reach a professional audience.

**Why Kie.ai (Flux-2) instead of DALL-E or Midjourney?**
Flux-2 generates photorealistic 3D renders at 1:1 aspect ratio with precise prompt adherence. The visual dictionary maps each IT topic to a specific technical object — no generic "businessman shaking hands" images. API-accessible, async task model compatible with n8n wait nodes.

**Why prompt caching on Claude Sonnet?**
The system prompt (writing guidelines, visual dictionary, regulatory consonance rules, format definitions) is ~2,000 tokens and identical across all executions. Caching it reduces cost by ~90% on the system prompt tokens and cuts latency on the writing step.

---

## Credentials required

| Credential | Type | Used for |
|------------|------|---------|
| `ANTHROPIC_API_KEY` | HTTP Header Auth | All Claude API calls |
| `KIE_AI_API_KEY` | HTTP Header Auth | Kie.ai image generation |
| `LINKEDIN_ACCESS_TOKEN` | Bearer token | LinkedIn API — company page + personal |
| `Gmail account` | OAuth2 | Approval emails |
| `PostgreSQL` | DB connection | Execution logging |

> All credentials are stored as n8n credential objects — no hardcoded secrets in workflow JSON.

---

## Author

**Luis Rivera** — GTM Engineer
IBM Silver Partner · Microsoft · Cisco · Fortinet · Dell EMC · VMware  
Puerto Rico government, healthcare, and cooperative technology integrator
