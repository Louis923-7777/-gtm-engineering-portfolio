-- LeadForge AI — Schema v3
-- Ejecutar contra pentestdb: docker exec -i pentest-postgres psql -U pentest -d pentestdb

-- Tabla de prospectos (contacts de email campaign)
CREATE TABLE IF NOT EXISTS prospects (
  id              SERIAL PRIMARY KEY,
  email           TEXT NOT NULL UNIQUE,
  first_name      TEXT DEFAULT '',
  last_name       TEXT DEFAULT '',
  company         TEXT DEFAULT '',
  title           TEXT DEFAULT '',
  sector          TEXT DEFAULT 'general',
  source          TEXT DEFAULT 'csv_import',
  lead_score      INTEGER DEFAULT 50,
  notes           TEXT DEFAULT '',
  status          TEXT DEFAULT 'nuevo',       -- nuevo | contactado | respondio | descartado
  campaign_id     INTEGER,
  email_sent_at   TIMESTAMPTZ,
  email_opened_at TIMESTAMPTZ,
  replied_at      TIMESTAMPTZ,
  followup_d3     TIMESTAMPTZ,
  followup_d7     TIMESTAMPTZ,
  followup_d3_enviado TIMESTAMPTZ,
  followup_d7_enviado TIMESTAMPTZ,
  creado_en       TIMESTAMPTZ DEFAULT NOW(),
  actualizado_en  TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_prospects_email   ON prospects(LOWER(email));
CREATE INDEX IF NOT EXISTS idx_prospects_sector  ON prospects(sector);
CREATE INDEX IF NOT EXISTS idx_prospects_score   ON prospects(lead_score DESC);
CREATE INDEX IF NOT EXISTS idx_prospects_status  ON prospects(status);

-- Lista de supresión (emails que nunca deben recibir emails)
CREATE TABLE IF NOT EXISTS suppression_list (
  id          SERIAL PRIMARY KEY,
  email       TEXT NOT NULL UNIQUE,
  razon       TEXT DEFAULT 'unsubscribe',   -- unsubscribe | bounce | complaint | manual
  creado_en   TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_suppression_email ON suppression_list(LOWER(email));

-- Tabla de campañas de email
CREATE TABLE IF NOT EXISTS email_campaigns (
  id              SERIAL PRIMARY KEY,
  nombre          TEXT NOT NULL,
  asunto          TEXT NOT NULL,
  sector_target   TEXT DEFAULT 'all',
  estado          TEXT DEFAULT 'borrador',   -- borrador | activa | pausada | completada
  total_enviados  INTEGER DEFAULT 0,
  total_abiertos  INTEGER DEFAULT 0,
  total_replies   INTEGER DEFAULT 0,
  creado_en       TIMESTAMPTZ DEFAULT NOW(),
  enviado_en      TIMESTAMPTZ
);
