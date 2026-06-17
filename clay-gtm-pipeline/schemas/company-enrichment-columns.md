# Company Enrichment Columns — Clay Pipeline

Full column definitions for the Company Table (26 columns, ~$6/row waterfall enrichment).

## Identity

| Column | Description | Provider |
|--------|-------------|----------|
| `company_name` | Legal / trading name | Source |
| `domain` | Primary website domain | Clay built-in |
| `website_url` | Full homepage URL | Clay built-in |
| `linkedin_url` | LinkedIn company page | Clay / Apollo |
| `hq_country` | Headquarters country | Clay |
| `hq_state` | Headquarters state | Clay |
| `hq_city` | Headquarters city | Clay |

## Firmographics

| Column | Description | Provider |
|--------|-------------|----------|
| `employee_count` | Verified headcount | Clay / Crunchbase |
| `employee_range` | Bucketed range (10–50, 51–200) | Clay |
| `revenue_estimate` | Annual revenue estimate USD | Crunchbase / Clay |
| `industry` | Primary industry vertical | Clay / LinkedIn |
| `sub_industry` | Sub-vertical classification | Clay |
| `founded_year` | Year of incorporation | Crunchbase |

## Technology Signals

| Column | Description | Provider |
|--------|-------------|----------|
| `tech_stack` | Detected tools (CRM, EHR, cloud) | BuiltWith via Clay |
| `uses_salesforce` | Boolean — Salesforce detected | BuiltWith |
| `uses_hubspot` | Boolean — HubSpot detected | BuiltWith |
| `cloud_provider` | AWS / Azure / GCP detected | BuiltWith |

## Intent & Hiring Signals

| Column | Description | Provider |
|--------|-------------|----------|
| `open_roles_it` | Active IT job postings count | Clay / LinkedIn |
| `hiring_signal` | Boolean — actively hiring in IT | Clay |
| `funding_stage` | Latest funding round | Crunchbase |
| `last_funding_date` | Date of most recent funding | Crunchbase |

## AI-Generated

| Column | Description | Provider |
|--------|-------------|----------|
| `company_summary_ai` | 2-sentence company description | Claygent (GPT-4) |
| `icp_fit_score` | 1–10 ICP fit score with rationale | Claygent |
| `outreach_angle` | Suggested personalization hook | Claygent |

## Metadata

| Column | Description | Provider |
|--------|-------------|----------|
| `enriched_at` | Timestamp of enrichment run | Clay |
| `source_list` | Source segment name | Manual |
