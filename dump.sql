--
-- PostgreSQL database dump
--

-- Dumped from database version 15.6 (Debian 15.6-1.pgdg120+2)
-- Dumped by pg_dump version 15.6 (Homebrew)

-- Started on 2024-05-03 19:26:17 JST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 7 (class 2615 OID 16387)
-- Name: repmgr; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA repmgr;


ALTER SCHEMA repmgr OWNER TO postgres;

--
-- TOC entry 2 (class 3079 OID 16388)
-- Name: repmgr; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS repmgr WITH SCHEMA repmgr;


--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION repmgr; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION repmgr IS 'Replication manager for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 235 (class 1259 OID 16600)
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16599)
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_attachments_id_seq OWNER TO postgres;

--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 234
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- TOC entry 233 (class 1259 OID 16590)
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16589)
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_blobs_id_seq OWNER TO postgres;

--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 232
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- TOC entry 237 (class 1259 OID 16616)
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16615)
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_variant_records_id_seq OWNER TO postgres;

--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 236
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- TOC entry 223 (class 1259 OID 16520)
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16550)
-- Name: group_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_users (
    id bigint NOT NULL,
    user_id bigint,
    group_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.group_users OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16549)
-- Name: group_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.group_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.group_users_id_seq OWNER TO postgres;

--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 228
-- Name: group_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.group_users_id_seq OWNED BY public.group_users.id;


--
-- TOC entry 227 (class 1259 OID 16541)
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groups (
    id bigint NOT NULL,
    name character varying,
    introduction text,
    teams_behaviour text,
    monthly_target text,
    image_id character varying,
    owner_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    invite_token character varying,
    invite_token_expires_at timestamp(6) without time zone
);


ALTER TABLE public.groups OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16540)
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO postgres;

--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 226
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- TOC entry 231 (class 1259 OID 16569)
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id bigint NOT NULL,
    content text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_id bigint,
    group_id bigint
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16568)
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO postgres;

--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 230
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- TOC entry 243 (class 1259 OID 16668)
-- Name: notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notes (
    id bigint NOT NULL,
    title character varying,
    good text,
    bad text,
    next text,
    user_id bigint,
    group_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.notes OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16667)
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notes_id_seq OWNER TO postgres;

--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 242
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- TOC entry 222 (class 1259 OID 16513)
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16652)
-- Name: sns_credentials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sns_credentials (
    id bigint NOT NULL,
    provider character varying,
    uid character varying,
    user_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.sns_credentials OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16651)
-- Name: sns_credentials_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sns_credentials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sns_credentials_id_seq OWNER TO postgres;

--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 240
-- Name: sns_credentials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sns_credentials_id_seq OWNED BY public.sns_credentials.id;


--
-- TOC entry 225 (class 1259 OID 16528)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    username character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16527)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 224
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 239 (class 1259 OID 16631)
-- Name: videos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.videos (
    id bigint NOT NULL,
    title character varying,
    introduction text,
    user_id bigint,
    group_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.videos OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16630)
-- Name: videos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.videos_id_seq OWNER TO postgres;

--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 238
-- Name: videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.videos_id_seq OWNED BY public.videos.id;


--
-- TOC entry 3311 (class 2604 OID 16603)
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- TOC entry 3310 (class 2604 OID 16593)
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- TOC entry 3312 (class 2604 OID 16619)
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- TOC entry 3308 (class 2604 OID 16553)
-- Name: group_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_users ALTER COLUMN id SET DEFAULT nextval('public.group_users_id_seq'::regclass);


--
-- TOC entry 3307 (class 2604 OID 16544)
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- TOC entry 3309 (class 2604 OID 16572)
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- TOC entry 3315 (class 2604 OID 16671)
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- TOC entry 3314 (class 2604 OID 16655)
-- Name: sns_credentials id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sns_credentials ALTER COLUMN id SET DEFAULT nextval('public.sns_credentials_id_seq'::regclass);


--
-- TOC entry 3304 (class 2604 OID 16531)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3313 (class 2604 OID 16634)
-- Name: videos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videos ALTER COLUMN id SET DEFAULT nextval('public.videos_id_seq'::regclass);


--
-- TOC entry 3528 (class 0 OID 16600)
-- Dependencies: 235
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
3	video	Video	3	3	2024-04-23 03:54:28.690121
\.


--
-- TOC entry 3526 (class 0 OID 16590)
-- Dependencies: 233
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, service_name, byte_size, checksum, created_at) FROM stdin;
3	9na5ucau0dpdf4d4gic5x7it2jpw	vs_倉西.mp4	video/mp4	{"identified":true}	amazon	2421106153	/7xTBZUzCdV39/rl29tm2A==	2024-04-23 03:54:28.569217
\.


--
-- TOC entry 3530 (class 0 OID 16616)
-- Dependencies: 237
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
\.


--
-- TOC entry 3516 (class 0 OID 16520)
-- Dependencies: 223
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2024-04-22 16:10:34.104113	2024-04-22 16:10:34.104113
\.


--
-- TOC entry 3522 (class 0 OID 16550)
-- Dependencies: 229
-- Data for Name: group_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_users (id, user_id, group_id, created_at, updated_at) FROM stdin;
1	1	1	2024-04-22 16:16:31.440221	2024-04-22 16:16:31.440221
2	2	1	2024-04-23 01:30:34.211311	2024-04-23 01:30:34.211311
6	5	1	2024-04-23 02:42:51.727825	2024-04-23 02:42:51.727825
8	6	1	2024-04-23 02:54:09.313451	2024-04-23 02:54:09.313451
\.


--
-- TOC entry 3520 (class 0 OID 16541)
-- Dependencies: 227
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groups (id, name, introduction, teams_behaviour, monthly_target, image_id, owner_id, created_at, updated_at, invite_token, invite_token_expires_at) FROM stdin;
1	米子高専サッカー部	米子高専サッカー部	\N	\N	\N	1	2024-04-22 16:16:31.334039	2024-04-23 02:53:34.035399	e4d9462d6d17792b84c5	2024-04-25 02:53:33.79775
\.


--
-- TOC entry 3524 (class 0 OID 16569)
-- Dependencies: 231
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, content, created_at, updated_at, user_id, group_id) FROM stdin;
\.


--
-- TOC entry 3536 (class 0 OID 16668)
-- Dependencies: 243
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notes (id, title, good, bad, next, user_id, group_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3515 (class 0 OID 16513)
-- Dependencies: 222
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20230812015149
20230812020316
20230812020358
20230812020429
20230817022728
20240121013044
20240121022723
20240224053344
20240331124526
20240414030229
\.


--
-- TOC entry 3534 (class 0 OID 16652)
-- Dependencies: 241
-- Data for Name: sns_credentials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sns_credentials (id, provider, uid, user_id, created_at, updated_at) FROM stdin;
1	google_oauth2	105014678594060399988	1	2024-04-22 16:16:01.838505	2024-04-22 16:16:01.838505
\.


--
-- TOC entry 3518 (class 0 OID 16528)
-- Dependencies: 225
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, username, created_at, updated_at) FROM stdin;
1	minorex15.connect@gmail.com	$2a$12$5KZz8UgmSP4Snn0T02HWyOSDGGYCd2RU52dXpIZ2ht.I6GlwEyKBS	\N	\N	\N	杉村実紀	2024-04-22 16:16:01.307936	2024-04-22 16:16:01.307936
2	yuuki20070528@icloud.con	$2a$12$fR/UMFOlu9bVnSYxpyCDPefdZWxTH9rJL/XoyF3vSSpY55/0wWSFC	\N	\N	\N	河田裕希	2024-04-23 01:30:32.80997	2024-04-23 01:30:32.80997
5	kotcha912@icloud.com	$2a$12$ty4hisI.zFzTnwgV8FWLye4GNOR1BC1DbDDWWiLutiKesRaYDyH5q	\N	\N	\N	kota	2024-04-23 02:42:35.59057	2024-04-23 02:42:35.59057
6	shi.29.izu@gmail.com	$2a$12$QFl1EGthwXoeyGZxoB00Z.bTrhpaC7dpmyL3am3GVZ4JPonX0v/l2	\N	\N	\N	izuki	2024-04-23 02:53:18.182377	2024-04-23 02:53:18.182377
8	macminosp@icloud.com	$2a$12$9JKnHkV0wwtenXDqWSykS.EdVpXQJT90ATUxgrB1bczl2VaY5kTgS	\N	\N	\N	Mino2	2024-04-23 14:21:29.307123	2024-04-23 14:24:12.383423
\.


--
-- TOC entry 3532 (class 0 OID 16631)
-- Dependencies: 239
-- Data for Name: videos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.videos (id, title, introduction, user_id, group_id, created_at, updated_at) FROM stdin;
3	vs_倉吉西-前半	vs_倉吉西-前半	1	1	2024-04-23 03:54:27.599546	2024-04-23 03:54:28.810532
\.


--
-- TOC entry 3297 (class 0 OID 16405)
-- Dependencies: 217
-- Data for Name: events; Type: TABLE DATA; Schema: repmgr; Owner: postgres
--

COPY repmgr.events (node_id, event, successful, event_timestamp, details) FROM stdin;
\.


--
-- TOC entry 3298 (class 0 OID 16412)
-- Dependencies: 218
-- Data for Name: monitoring_history; Type: TABLE DATA; Schema: repmgr; Owner: postgres
--

COPY repmgr.monitoring_history (primary_node_id, standby_node_id, last_monitor_time, last_apply_time, last_wal_primary_location, last_wal_standby_location, replication_lag, apply_lag) FROM stdin;
\.


--
-- TOC entry 3296 (class 0 OID 16389)
-- Dependencies: 216
-- Data for Name: nodes; Type: TABLE DATA; Schema: repmgr; Owner: postgres
--

COPY repmgr.nodes (node_id, upstream_node_id, active, node_name, type, location, priority, conninfo, repluser, slot_name, config_file) FROM stdin;
\.


--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 234
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 3, true);


--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 232
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 3, true);


--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 236
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 228
-- Name: group_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.group_users_id_seq', 9, true);


--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 226
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groups_id_seq', 1, true);


--
-- TOC entry 3558 (class 0 OID 0)
-- Dependencies: 230
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_id_seq', 1, false);


--
-- TOC entry 3559 (class 0 OID 0)
-- Dependencies: 242
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notes_id_seq', 1, false);


--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 240
-- Name: sns_credentials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sns_credentials_id_seq', 4, true);


--
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 224
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 8, true);


--
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 238
-- Name: videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.videos_id_seq', 3, true);


--
-- TOC entry 3342 (class 2606 OID 16607)
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- TOC entry 3339 (class 2606 OID 16597)
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- TOC entry 3346 (class 2606 OID 16623)
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- TOC entry 3323 (class 2606 OID 16526)
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- TOC entry 3331 (class 2606 OID 16555)
-- Name: group_users group_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_users
    ADD CONSTRAINT group_users_pkey PRIMARY KEY (id);


--
-- TOC entry 3329 (class 2606 OID 16548)
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- TOC entry 3337 (class 2606 OID 16576)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- TOC entry 3358 (class 2606 OID 16675)
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- TOC entry 3321 (class 2606 OID 16519)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3354 (class 2606 OID 16659)
-- Name: sns_credentials sns_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sns_credentials
    ADD CONSTRAINT sns_credentials_pkey PRIMARY KEY (id);


--
-- TOC entry 3327 (class 2606 OID 16537)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3351 (class 2606 OID 16638)
-- Name: videos videos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


--
-- TOC entry 3343 (class 1259 OID 16613)
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- TOC entry 3344 (class 1259 OID 16614)
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- TOC entry 3340 (class 1259 OID 16598)
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- TOC entry 3347 (class 1259 OID 16629)
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- TOC entry 3332 (class 1259 OID 16567)
-- Name: index_group_users_on_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_group_users_on_group_id ON public.group_users USING btree (group_id);


--
-- TOC entry 3333 (class 1259 OID 16566)
-- Name: index_group_users_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_group_users_on_user_id ON public.group_users USING btree (user_id);


--
-- TOC entry 3334 (class 1259 OID 16583)
-- Name: index_messages_on_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_messages_on_group_id ON public.messages USING btree (group_id);


--
-- TOC entry 3335 (class 1259 OID 16577)
-- Name: index_messages_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_messages_on_user_id ON public.messages USING btree (user_id);


--
-- TOC entry 3355 (class 1259 OID 16687)
-- Name: index_notes_on_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_notes_on_group_id ON public.notes USING btree (group_id);


--
-- TOC entry 3356 (class 1259 OID 16686)
-- Name: index_notes_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_notes_on_user_id ON public.notes USING btree (user_id);


--
-- TOC entry 3352 (class 1259 OID 16666)
-- Name: index_sns_credentials_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_sns_credentials_on_user_id ON public.sns_credentials USING btree (user_id);


--
-- TOC entry 3324 (class 1259 OID 16538)
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- TOC entry 3325 (class 1259 OID 16539)
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- TOC entry 3348 (class 1259 OID 16650)
-- Name: index_videos_on_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_videos_on_group_id ON public.videos USING btree (group_id);


--
-- TOC entry 3349 (class 1259 OID 16649)
-- Name: index_videos_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_videos_on_user_id ON public.videos USING btree (user_id);


--
-- TOC entry 3359 (class 2606 OID 16556)
-- Name: group_users fk_rails_1486913327; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_users
    ADD CONSTRAINT fk_rails_1486913327 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3361 (class 2606 OID 16578)
-- Name: messages fk_rails_273a25a7a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_rails_273a25a7a6 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3365 (class 2606 OID 16644)
-- Name: videos fk_rails_502549eaab; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT fk_rails_502549eaab FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- TOC entry 3368 (class 2606 OID 16676)
-- Name: notes fk_rails_7f2323ad43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT fk_rails_7f2323ad43 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3362 (class 2606 OID 16584)
-- Name: messages fk_rails_841b0ae6ac; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_rails_841b0ae6ac FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- TOC entry 3369 (class 2606 OID 16681)
-- Name: notes fk_rails_8cc41e22b7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT fk_rails_8cc41e22b7 FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- TOC entry 3364 (class 2606 OID 16624)
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- TOC entry 3360 (class 2606 OID 16561)
-- Name: group_users fk_rails_a9d5f48449; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_users
    ADD CONSTRAINT fk_rails_a9d5f48449 FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- TOC entry 3366 (class 2606 OID 16639)
-- Name: videos fk_rails_ba925d1105; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT fk_rails_ba925d1105 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3363 (class 2606 OID 16608)
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- TOC entry 3367 (class 2606 OID 16660)
-- Name: sns_credentials fk_rails_c5d66654bc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sns_credentials
    ADD CONSTRAINT fk_rails_c5d66654bc FOREIGN KEY (user_id) REFERENCES public.users(id);


-- Completed on 2024-05-03 19:26:21 JST

--
-- PostgreSQL database dump complete
--

