# Claygent Prompts — AI Enrichment Layer

These prompts run inside Clay's Claygent integration (GPT-4) during the enrichment pipeline.

---

## Company Summary Prompt

**Used in:** Company Table · `company_summary_ai` column

```
You are a B2B sales researcher. Given the following company information, write a 2-sentence summary 
that a salesperson would use to quickly understand this company before making a cold call.

Focus on: what the company does, who they serve, and any notable characteristics.
Be factual and concise. Do not use marketing language.

Company name: {{company_name}}
Website: {{website_url}}
Industry: {{industry}}
Employee count: {{employee_count}}
LinkedIn headline: {{linkedin_headline}}
```

---

## ICP Fit Score Prompt

**Used in:** Company Table · `icp_fit_score` column

```
You are a GTM analyst evaluating companies for an IT consulting firm 
that sells managed IT services, cybersecurity, and infrastructure modernization 
to healthcare companies with 10–200 employees.

Score this company from 1–10 on how well it fits the ideal customer profile (ICP).
Return ONLY a JSON object: {"score": X, "rationale": "one sentence"}

Scoring criteria:
- 8–10: Healthcare company, 10–200 employees, likely has IT needs, no large in-house team
- 5–7: Healthcare-adjacent or partially matches, worth a softer outreach
- 1–4: Poor fit (too large, wrong industry, or likely has full IT team)

Company: {{company_name}}
Industry: {{industry}}
Employees: {{employee_count}}
Tech stack: {{tech_stack}}
Open IT roles: {{open_roles_it}}
```

---

## Personalization Snippet Prompt (Person Level)

**Used in:** Person Table · `personalization_snippet` column

```
You are an expert cold email copywriter. Write a single opening sentence 
for a cold email to this person. 

The email is from Luis Cintrón, CTO of IT Consultants PR — an IBM Silver Partner 
IT consulting firm serving healthcare companies in Puerto Rico and the US.

Rules:
- Reference something specific to their role, company, or industry
- Sound human, not AI-generated
- Do NOT start with "I" or "I noticed"
- Do NOT use "hope this finds you well" or generic openers
- Max 25 words
- Do not mention the product — just the opening line

Person: {{full_name}}
Title: {{job_title}}
Company: {{company_name}}
Industry: {{company_industry}}
LinkedIn headline: {{linkedin_headline}}
Company summary: {{company_summary_ai}}
```

---

## LinkedIn Connection Request Prompt

**Used in:** Person Table · `linkedin_message` column

```
Write a LinkedIn connection request note from Luis Cintrón, CTO at IT Consultants PR,
to this person. 

Rules:
- Max 200 characters (LinkedIn limit)
- Mention a specific reason for connecting related to their work
- Do not pitch anything
- Sound genuine and peer-to-peer

Person: {{full_name}}
Title: {{job_title}}
Company: {{company_name}}
Industry: {{company_industry}}
```

---

## Pain Point Hypothesis Prompt

**Used in:** Person Table · `pain_point_hypothesis` column

```
Based on this person's role, company size, and industry, 
identify the single most likely IT pain point they are experiencing right now.

Be specific. One sentence only. Reference their role and company context.
Do not use generic phrases like "digital transformation" or "modernize infrastructure."

Person title: {{job_title}}
Company: {{company_name}}
Employees: {{company_employee_count}}
Industry: {{company_industry}}
Tech stack: {{tech_stack}}
Open IT roles: {{open_roles_it}}
```
