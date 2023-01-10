--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Debian 15.1-1.pgdg110+1)
-- Dumped by pg_dump version 15.1 (Debian 15.1-1.pgdg110+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
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
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: searched_cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.searched_cities (
    id bigint NOT NULL,
    city character varying,
    country character varying,
    region character varying,
    weather_description character varying,
    icon character varying,
    temp double precision,
    latitude double precision,
    longitude double precision,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.searched_cities OWNER TO postgres;

--
-- Name: searched_cities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.searched_cities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.searched_cities_id_seq OWNER TO postgres;

--
-- Name: searched_cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.searched_cities_id_seq OWNED BY public.searched_cities.id;


--
-- Name: subscribers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscribers (
    id bigint NOT NULL,
    email character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    latitude double precision,
    longitude double precision
);


ALTER TABLE public.subscribers OWNER TO postgres;

--
-- Name: subscribers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscribers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscribers_id_seq OWNER TO postgres;

--
-- Name: subscribers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscribers_id_seq OWNED BY public.subscribers.id;


--
-- Name: searched_cities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.searched_cities ALTER COLUMN id SET DEFAULT nextval('public.searched_cities_id_seq'::regclass);


--
-- Name: subscribers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscribers ALTER COLUMN id SET DEFAULT nextval('public.subscribers_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2022-12-29 14:37:25.686608	2022-12-29 14:37:25.686608
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20221207085611
20221209121353
20221209123634
20221209130906
20221212122317
\.


--
-- Data for Name: searched_cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.searched_cities (id, city, country, region, weather_description, icon, temp, latitude, longitude, created_at, updated_at) FROM stdin;
1	London	United Kingdom	United Kingdom	few clouds	02n	2.66	51.5073219	-0.1276474	2023-01-02 20:46:46.215136	2023-01-02 20:46:46.215136
2	London	United Kingdom	United Kingdom	few clouds	02n	2.66	51.5073219	-0.1276474	2023-01-02 20:47:32.392759	2023-01-02 20:47:32.392759
3	Tripoli	Libya	Libya	broken clouds	04n	17.86	32.896672	13.1777923	2023-01-02 20:47:46.81938	2023-01-02 20:47:46.81938
4	New York	United States	United States	clear sky	01d	12.21	40.7127281	-74.0060152	2023-01-02 20:47:58.810422	2023-01-02 20:47:58.810422
5	Basta Tahta	Lebanon	Lebanon	few clouds	02n	16.75	33.88922645	35.50255852895232	2023-01-03 18:41:09.698919	2023-01-03 18:41:09.698919
6	Ankara	Turkey	Turkey	clear sky	01n	1.48	39.9207886	32.8540482	2023-01-03 18:41:31.402878	2023-01-03 18:41:31.402878
7	Washington	United States	United States	broken clouds	04d	18.02	38.8950368	-77.0365427	2023-01-03 18:58:34.530403	2023-01-03 18:58:34.530403
8	Washington	United States	United States	overcast clouds	04d	18.21	38.8950368	-77.0365427	2023-01-03 19:07:41.429939	2023-01-03 19:07:41.429939
\.


--
-- Data for Name: subscribers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscribers (id, email, created_at, updated_at, latitude, longitude) FROM stdin;
1	abounassif.roni@gmail.com	2022-12-29 15:10:24.160237	2022-12-29 15:10:24.160237	33.8933	35.5016
\.


--
-- Name: searched_cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.searched_cities_id_seq', 8, true);


--
-- Name: subscribers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscribers_id_seq', 1, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: searched_cities searched_cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.searched_cities
    ADD CONSTRAINT searched_cities_pkey PRIMARY KEY (id);


--
-- Name: subscribers subscribers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscribers
    ADD CONSTRAINT subscribers_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

