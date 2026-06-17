# Person Enrichment Columns — Clay Pipeline

Full column definitions for the Person Table (31 columns, $3.9/row waterfall enrichment).

## Identity

| Column | Description | Provider |
|--------|-------------|----------|
| `full_name` | Full name | Source / LinkedIn |
| `first_name` | First name | Clay (parsed) |
| `last_name` | Last name | Clay (parsed) |
| `job_title` | Current job title | LinkedIn / Apollo |
| `seniority_level` | C-suite / VP / Director / Manager / IC | Clay classifier |
| `department` | IT / Finance / Operations / HR / etc. | Clay |

## Contact Information

| Column | Description | Provider |
|--------|-------------|----------|
| `work_email` | Verified work email | Waterfall: Apollo → Hunter → Clay |
| `email_confidence` | Confidence score 0–100 | Provider |
| `email_status` | Valid / Risky / Invalid | Clay verify |
| `mobile_phone` | Direct mobile number | Apollo / Clay |
| `work_phone` | Office / direct line | Apollo |

## Professional Profile

| Column | Description | Provider |
|--------|-------------|----------|
| `linkedin_url` | Personal LinkedIn profile URL | LinkedIn / Clay |
| `linkedin_headline` | Current LinkedIn headline | LinkedIn |
| `years_at_company` | Tenure at current company | LinkedIn |
| `years_in_role` | Time in current position | LinkedIn |
| `total_experience_years` | Total career years | LinkedIn |
| `previous_company` | Most recent prior employer | LinkedIn |
| `education` | Highest degree + institution | LinkedIn |
| `location_city` | City of residence | LinkedIn / Clay |
| `location_state` | State of residence | LinkedIn / Clay |

## Company Cross-Reference

| Column | Description | Provider |
|--------|-------------|----------|
| `company_name` | Employer name | Source |
| `company_domain` | Employer domain | Clay |
| `company_employee_count` | Headcount at employer | Clay |
| `company_industry` | Employer industry | Clay |
| `company_linkedin_url` | Employer LinkedIn page | Clay |

## AI-Generated Personalization

| Column | Description | Provider |
|--------|-------------|----------|
| `personalization_snippet` | Opening line for cold email | Claygent (GPT-4) |
| `linkedin_message` | LinkedIn connection request note | Claygent |
| `pain_point_hypothesis` | Inferred pain based on role + industry | Claygent |
| `relevant_case_study` | Suggested ITCPR case study match | Claygent |

## Metadata

| Column | Description | Provider |
|--------|-------------|----------|
| `enriched_at` | Timestamp of enrichment | Clay |
| `campaign_tag` | Assigned outbound campaign | Manual |
| `segment` | Source branch (Healthcare IT FL/PR · Full 558) | Manual |
