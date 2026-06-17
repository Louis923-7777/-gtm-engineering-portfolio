# ICP Filters — Healthcare IT, FL & PR

LinkedIn Sales Navigator filter configuration used to generate the base company list for this pipeline.

## Account Filters (Company Level)

```
Industry:
  - Hospital & Health Care
  - Health, Wellness and Fitness
  - Medical Devices
  - Biotechnology
  - Pharmaceuticals
  - Insurance (health-adjacent)
  - Information Technology & Services (healthcare clients)

Company Headcount:
  - 10–50 employees
  - 51–200 employees

Geography:
  - United States
    ├── Florida (FL)
    └── Puerto Rico (PR)

Exclude:
  - Staffing & Recruiting firms
  - Companies with "consulting" in name (unless IT-focused)
```

## Lead Filters (Person Level — Branch A)

```
Job Title Keywords (include any):
  - "Chief Information Officer"
  - "CIO"
  - "VP of IT"
  - "VP Information Technology"
  - "Director of IT"
  - "Director of Information Technology"
  - "IT Director"
  - "Head of IT"
  - "Chief Technology Officer"
  - "CTO"

Seniority:
  - Director
  - VP
  - C-Suite
  - Owner
  - Partner

Geography:
  - Florida (FL)
  - Puerto Rico (PR)
```

## Lead Filters (Person Level — Branch B)

```
Job Title Keywords (include any):
  - IT
  - Technology
  - Information Systems
  - Operations
  - Infrastructure
  - Security
  - Network
  - Systems
  - Digital

Seniority:
  - Director
  - VP
  - C-Suite
  - Manager
  - Senior

(No geography filter — full 558 company coverage)
```

## ICP Scoring Criteria (Claygent)

After enrichment, Claygent scores each company 1–10 based on:

| Signal | Weight |
|--------|--------|
| Headcount in target range (10–200) | High |
| Healthcare vertical confirmed | High |
| Active IT hiring signals | Medium |
| No in-house large IT team (signal: <5 IT roles listed) | Medium |
| Tech stack suggests modernization opportunity | Medium |
| Located in FL or PR (Branch A) | High |
| Recent funding or growth signal | Low |

**Threshold for outreach:** Score ≥ 7 for Branch A (precision), ≥ 5 for Branch B (volume)
