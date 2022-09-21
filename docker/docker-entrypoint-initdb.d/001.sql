-- Adminer 4.8.1 PostgreSQL 14.5 (Debian 14.5-1.pgdg110+1) dump

DROP TABLE IF EXISTS "autori";
DROP SEQUENCE IF EXISTS autori_id_autore_seq;
CREATE SEQUENCE autori_id_autore_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."autori" (
    "id_autore" integer DEFAULT nextval('autori_id_autore_seq') NOT NULL,
    "nome" character varying NOT NULL,
    "data_nascita" date,
    "descrizione" character varying,
    CONSTRAINT "autori_pkey" PRIMARY KEY ("id_autore")
) WITH (oids = false);


DROP TABLE IF EXISTS "editori";
DROP SEQUENCE IF EXISTS editori_id_editore_seq;
CREATE SEQUENCE editori_id_editore_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."editori" (
    "id_editore" integer DEFAULT nextval('editori_id_editore_seq') NOT NULL,
    "telefono" character(15) NOT NULL,
    "nome" character varying(40) NOT NULL,
    "indirizzo" character varying,
    CONSTRAINT "editori_pkey" PRIMARY KEY ("id_editore")
) WITH (oids = false);


DROP TABLE IF EXISTS "funzioni";
CREATE TABLE "public"."funzioni" (
    "nome" character varying(20) NOT NULL,
    "descrizione" character varying NOT NULL,
    CONSTRAINT "funzioni_pk" PRIMARY KEY ("nome")
) WITH (oids = false);

INSERT INTO "funzioni" ("nome", "descrizione") VALUES
('utente.crea',	'utente.crea'),
('utente.modifica',	'utente.modifica'),
('utente.visualizza',	'utente.visualizza'),
('utente.elimina',	'utente.elimina'),
('libri.crea',	'libri.crea'),
('libri.visualizza',	'libri.visualizza'),
('libri.elimina',	'libri.elimina'),
('libri.modifica',	'libri.modifica'),
('ruolo.crea',	'ruolo.crea'),
('ruolo.modifica',	'ruolo.modifica'),
('ruolo.visualizza',	'ruolo.visualizza'),
('ruolo.elimina',	'ruolo.elimina'),
('profilo.crea',	'profilo.crea'),
('profilo.visualizza',	'profilo.visualizza'),
('profilo.elimina',	'profilo.elimina'),
('profilo.modifica',	'profilo.modifica');

DROP TABLE IF EXISTS "libri";
DROP SEQUENCE IF EXISTS libri_id_libro_seq;
CREATE SEQUENCE libri_id_libro_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."libri" (
    "id_libro" integer DEFAULT nextval('libri_id_libro_seq') NOT NULL,
    "titolo" character varying NOT NULL,
    "ean" character varying,
    "prezzo" money NOT NULL,
    "copertina" bytea,
    "id_editore" integer NOT NULL,
    "quantita" integer DEFAULT '0' NOT NULL,
    CONSTRAINT "libri_pkey" PRIMARY KEY ("id_libro")
) WITH (oids = false);


DROP TABLE IF EXISTS "libri_autori";
CREATE TABLE "public"."libri_autori" (
    "id_autore" integer NOT NULL,
    "id_libro" integer NOT NULL,
    CONSTRAINT "libri_autori_pk" PRIMARY KEY ("id_autore", "id_libro")
) WITH (oids = false);


DROP TABLE IF EXISTS "profili";
DROP SEQUENCE IF EXISTS profili_id_profilo_seq;
CREATE SEQUENCE profili_id_profilo_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."profili" (
    "id_profilo" integer DEFAULT nextval('profili_id_profilo_seq') NOT NULL,
    "nome" character varying(20) NOT NULL,
    "descrizione" character varying,
    CONSTRAINT "profili_pkey" PRIMARY KEY ("id_profilo")
) WITH (oids = false);

INSERT INTO "profili" ("id_profilo", "nome", "descrizione") VALUES
(1,	'amministratore',	'amministratore del sistema');

DROP TABLE IF EXISTS "profili_ruoli";
CREATE TABLE "public"."profili_ruoli" (
    "id_profilo" integer NOT NULL,
    "nome_ruolo" character varying(20) NOT NULL,
    CONSTRAINT "profili_ruoli_pk" PRIMARY KEY ("id_profilo", "nome_ruolo")
) WITH (oids = false);

INSERT INTO "profili_ruoli" ("id_profilo", "nome_ruolo") VALUES
(1,	'admin');

DROP TABLE IF EXISTS "ruoli";
CREATE TABLE "public"."ruoli" (
    "nome" character varying(20) NOT NULL,
    "descrizione" character varying NOT NULL,
    CONSTRAINT "ruoli_nome_pk" PRIMARY KEY ("nome")
) WITH (oids = false);

INSERT INTO "ruoli" ("nome", "descrizione") VALUES
('admin',	'admin'),
('gestore',	'gestore'),
('venditore',	'venditore'),
('cliente',	'cliente');

DROP TABLE IF EXISTS "ruoli_funzioni";
CREATE TABLE "public"."ruoli_funzioni" (
    "ruolo" character varying(20) NOT NULL,
    "funzione" character varying(20) NOT NULL,
    CONSTRAINT "ruoli_funzioni_pk" PRIMARY KEY ("ruolo", "funzione")
) WITH (oids = false);

INSERT INTO "ruoli_funzioni" ("ruolo", "funzione") VALUES
('admin',	'utente.crea'),
('admin',	'utente.modifica'),
('admin',	'utente.visualizza'),
('admin',	'utente.elimina');

DROP TABLE IF EXISTS "utenti";
DROP SEQUENCE IF EXISTS utenti_id_utente_seq;
CREATE SEQUENCE utenti_id_utente_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."utenti" (
    "id_utente" integer DEFAULT nextval('utenti_id_utente_seq') NOT NULL,
    "nome" character varying NOT NULL,
    "cognome" character varying NOT NULL,
    "username" character varying(20) NOT NULL,
    "email" character varying,
    "password" character varying NOT NULL,
    "id_profilo" integer NOT NULL,
    CONSTRAINT "utenti_pkey" PRIMARY KEY ("id_utente")
) WITH (oids = false);


ALTER TABLE ONLY "public"."libri" ADD CONSTRAINT "libri_id_editore_fkey" FOREIGN KEY (id_editore) REFERENCES editori(id_editore) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."libri_autori" ADD CONSTRAINT "libri_autori_id_autore_fkey" FOREIGN KEY (id_autore) REFERENCES autori(id_autore) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."libri_autori" ADD CONSTRAINT "libri_autori_id_libro_fkey" FOREIGN KEY (id_libro) REFERENCES libri(id_libro) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."profili_ruoli" ADD CONSTRAINT "profili_ruoli_id_profilo_fkey" FOREIGN KEY (id_profilo) REFERENCES profili(id_profilo) ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "public"."profili_ruoli" ADD CONSTRAINT "profili_ruoli_nome_ruolo_fkey" FOREIGN KEY (nome_ruolo) REFERENCES ruoli(nome) ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "public"."ruoli_funzioni" ADD CONSTRAINT "ruoli_funzioni_funzione_fkey" FOREIGN KEY (funzione) REFERENCES funzioni(nome) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."ruoli_funzioni" ADD CONSTRAINT "ruoli_funzioni_ruolo_fkey" FOREIGN KEY (ruolo) REFERENCES ruoli(nome) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."utenti" ADD CONSTRAINT "utenti_id_profilo_fkey" FOREIGN KEY (id_profilo) REFERENCES profili(id_profilo) NOT DEFERRABLE;

-- 2022-09-16 16:04:45.519227+00