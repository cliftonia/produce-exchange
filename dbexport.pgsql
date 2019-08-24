--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4
-- Dumped by pg_dump version 11.4

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

SET default_with_oids = false;

--
-- Name: items; Type: TABLE; Schema: public; Owner: ashley.martin
--

CREATE TABLE public.items (
    id integer NOT NULL,
    title character varying(300),
    description text,
    latitude double precision,
    longitude double precision,
    quantity numeric,
    unit character varying(50),
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.items OWNER TO "ashley.martin";

--
-- Name: items_id_seq; Type: SEQUENCE; Schema: public; Owner: ashley.martin
--

CREATE SEQUENCE public.items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.items_id_seq OWNER TO "ashley.martin";

--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ashley.martin
--

ALTER SEQUENCE public.items_id_seq OWNED BY public.items.id;


--
-- Name: offer_statuses; Type: TABLE; Schema: public; Owner: ashley.martin
--

CREATE TABLE public.offer_statuses (
    id integer NOT NULL,
    stage character varying(100),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.offer_statuses OWNER TO "ashley.martin";

--
-- Name: offer_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: ashley.martin
--

CREATE SEQUENCE public.offer_statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offer_statuses_id_seq OWNER TO "ashley.martin";

--
-- Name: offer_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ashley.martin
--

ALTER SEQUENCE public.offer_statuses_id_seq OWNED BY public.offer_statuses.id;


--
-- Name: offers; Type: TABLE; Schema: public; Owner: ashley.martin
--

CREATE TABLE public.offers (
    id integer NOT NULL,
    proposer_user_id integer,
    proposer_item_id integer,
    proposer_item_qty numeric,
    reviewer_user_id integer,
    reviewer_item_id integer,
    reviewer_item_qty numeric,
    meeting_point character varying(200),
    meeting_point_suburb character varying(200),
    status_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.offers OWNER TO "ashley.martin";

--
-- Name: offers_id_seq; Type: SEQUENCE; Schema: public; Owner: ashley.martin
--

CREATE SEQUENCE public.offers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offers_id_seq OWNER TO "ashley.martin";

--
-- Name: offers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ashley.martin
--

ALTER SEQUENCE public.offers_id_seq OWNED BY public.offers.id;


--
-- Name: photos; Type: TABLE; Schema: public; Owner: ashley.martin
--

CREATE TABLE public.photos (
    id integer NOT NULL,
    item_id integer,
    image_link text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.photos OWNER TO "ashley.martin";

--
-- Name: photos_id_seq; Type: SEQUENCE; Schema: public; Owner: ashley.martin
--

CREATE SEQUENCE public.photos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photos_id_seq OWNER TO "ashley.martin";

--
-- Name: photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ashley.martin
--

ALTER SEQUENCE public.photos_id_seq OWNED BY public.photos.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: ashley.martin
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(300),
    username character varying(100),
    password_digest character varying(400),
    address_line_1 character varying(300),
    suburb character varying(100),
    postcode integer,
    lon double precision,
    lat double precision,
    availability character varying(400),
    avatar text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO "ashley.martin";

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: ashley.martin
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO "ashley.martin";

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ashley.martin
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: items id; Type: DEFAULT; Schema: public; Owner: ashley.martin
--

ALTER TABLE ONLY public.items ALTER COLUMN id SET DEFAULT nextval('public.items_id_seq'::regclass);


--
-- Name: offer_statuses id; Type: DEFAULT; Schema: public; Owner: ashley.martin
--

ALTER TABLE ONLY public.offer_statuses ALTER COLUMN id SET DEFAULT nextval('public.offer_statuses_id_seq'::regclass);


--
-- Name: offers id; Type: DEFAULT; Schema: public; Owner: ashley.martin
--

ALTER TABLE ONLY public.offers ALTER COLUMN id SET DEFAULT nextval('public.offers_id_seq'::regclass);


--
-- Name: photos id; Type: DEFAULT; Schema: public; Owner: ashley.martin
--

ALTER TABLE ONLY public.photos ALTER COLUMN id SET DEFAULT nextval('public.photos_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: ashley.martin
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: ashley.martin
--

COPY public.items (id, title, description, latitude, longitude, quantity, unit, user_id, created_at, updated_at) FROM stdin;
2	strawberries	ashley's stawberries	-37.8004000000000033	144.968099999999993	200.0	g	3	2019-08-24 04:41:17.757835	2019-08-24 04:41:17.757835
3	pears	pam's pears	-37.8333000000000013	145.033299999999997	6.0	pcs	1	2019-08-24 04:42:02.65999	2019-08-24 04:42:02.65999
4	potatoes	pam's potatoes	-37.8333000000000013	145.033299999999997	2.5	kg	1	2019-08-24 04:43:51.871973	2019-08-24 04:43:51.871973
6	tomatoes	clifton's tomatoes	-37.8333000000000013	145	1.0	pcs	2	2019-08-24 04:45:57.427705	2019-08-24 04:47:39.802953
1	grapes	ashley's grapes	-37.8004000000000033	144.968099999999993	0.0	g	3	2019-08-24 04:40:06.634776	2019-08-24 04:47:39.804859
\.


--
-- Data for Name: offer_statuses; Type: TABLE DATA; Schema: public; Owner: ashley.martin
--

COPY public.offer_statuses (id, stage, created_at, updated_at) FROM stdin;
1	pending	2019-08-24 04:37:58.844694	2019-08-24 04:37:58.844694
2	declined	2019-08-24 04:37:58.846262	2019-08-24 04:37:58.846262
3	accepted	2019-08-24 04:37:58.847293	2019-08-24 04:37:58.847293
4	completed	2019-08-24 04:37:58.848332	2019-08-24 04:37:58.848332
\.


--
-- Data for Name: offers; Type: TABLE DATA; Schema: public; Owner: ashley.martin
--

COPY public.offers (id, proposer_user_id, proposer_item_id, proposer_item_qty, reviewer_user_id, reviewer_item_id, reviewer_item_qty, meeting_point, meeting_point_suburb, status_id, created_at, updated_at) FROM stdin;
1	2	6	2.0	3	1	500.0	\N	Richmond	3	2019-08-24 04:46:43.071034	2019-08-24 04:47:39.806184
\.


--
-- Data for Name: photos; Type: TABLE DATA; Schema: public; Owner: ashley.martin
--

COPY public.photos (id, item_id, image_link, created_at, updated_at) FROM stdin;
1	1	b1b99fcf-bcd0-40f3-a537-64ae4db9564d.jpg	2019-08-24 04:40:06.8913	2019-08-24 04:40:06.8913
2	2	a62b784a-b2ca-4697-9878-582e4cad70a6.jpeg	2019-08-24 04:41:18.132697	2019-08-24 04:41:18.132697
3	3	342fae95-d837-4a20-b0fb-34df23d2110b.jpg	2019-08-24 04:42:03.710633	2019-08-24 04:42:03.710633
4	4	8fb8cc2e-0844-44e7-b7e3-68bdb6d24421.jpg	2019-08-24 04:43:53.19495	2019-08-24 04:43:53.19495
6	6	d3841b61-7517-4cb0-b403-67833d1c3891.jpg	2019-08-24 04:45:58.048066	2019-08-24 04:45:58.048066
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: ashley.martin
--

COPY public.users (id, email, username, password_digest, address_line_1, suburb, postcode, lon, lat, availability, avatar, created_at, updated_at) FROM stdin;
1	pam@ga.co	pam	$2a$12$sCEWoIRhEcBKTKNQ7MpumejMaRk17S8MD2PKNZfpXkVNvS0.E5uWq	1 Lollipop Dr	Hawthorn	3122	145.033299999999997	-37.8333000000000013	mon, tues evenings, and weekends	http://www.carderator.com/assets/avatar_placeholder_small.png	2019-08-24 04:37:53.767206	2019-08-24 04:37:53.767206
2	clifton@ga.co	clifton	$2a$12$FS7As68y2OnMeo/.T1MFsONZMNXwVMp.eg.vEAF4zjavbbY4UXJWe	2 Happy Place	Richmond	3121	145	-37.8333000000000013	mon, tues evenings, and weekends	http://www.carderator.com/assets/avatar_placeholder_small.png	2019-08-24 04:37:54.635509	2019-08-24 04:37:54.635509
3	ashley@ga.co	ashley	$2a$12$kMaNahdMxUpGaiGVeSpNoePtxf1NMXkIy8FkVbzhG9SA1IVQ/U9li	65 Whiteboard Rd	Carlton	3053	144.968099999999993	-37.8004000000000033	mon, tues evenings, and weekends	http://www.carderator.com/assets/avatar_placeholder_small.png	2019-08-24 04:37:55.556363	2019-08-24 04:37:55.556363
4	jake@ga.co	jake	$2a$12$i/tyR6sAzK7AzFVKG1QULOakRY4saoOl2RY5Hu1pX538gcgXUXsQa	16 Chair Ave	St Kilda	3182	144.980199999999996	-37.8633000000000024	mon, tues evenings, and weekends	http://www.carderator.com/assets/avatar_placeholder_small.png	2019-08-24 04:37:56.478333	2019-08-24 04:37:56.478333
5	rachel@ga.co	rachel	$2a$12$g4QW6x5HrbjOHvTsDGDg7eBO1Xdq7IzEz19s7m6NpHI9zchAI0z82	11 Frick St	Collingwood	3066	144.983300000000014	-37.7999999999999972	mon, tues evenings, and weekends	http://www.carderator.com/assets/avatar_placeholder_small.png	2019-08-24 04:37:58.832795	2019-08-24 04:37:58.832795
\.


--
-- Name: items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ashley.martin
--

SELECT pg_catalog.setval('public.items_id_seq', 6, true);


--
-- Name: offer_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ashley.martin
--

SELECT pg_catalog.setval('public.offer_statuses_id_seq', 4, true);


--
-- Name: offers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ashley.martin
--

SELECT pg_catalog.setval('public.offers_id_seq', 1, true);


--
-- Name: photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ashley.martin
--

SELECT pg_catalog.setval('public.photos_id_seq', 6, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ashley.martin
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: ashley.martin
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: offer_statuses offer_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: ashley.martin
--

ALTER TABLE ONLY public.offer_statuses
    ADD CONSTRAINT offer_statuses_pkey PRIMARY KEY (id);


--
-- Name: offers offers_pkey; Type: CONSTRAINT; Schema: public; Owner: ashley.martin
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (id);


--
-- Name: photos photos_pkey; Type: CONSTRAINT; Schema: public; Owner: ashley.martin
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: ashley.martin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: items items_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashley.martin
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: offers offers_proposer_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashley.martin
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_proposer_item_id_fkey FOREIGN KEY (proposer_item_id) REFERENCES public.items(id) ON DELETE RESTRICT;


--
-- Name: offers offers_proposer_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashley.martin
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_proposer_user_id_fkey FOREIGN KEY (proposer_user_id) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: offers offers_reviewer_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashley.martin
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_reviewer_item_id_fkey FOREIGN KEY (reviewer_item_id) REFERENCES public.items(id) ON DELETE RESTRICT;


--
-- Name: offers offers_reviewer_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashley.martin
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_reviewer_user_id_fkey FOREIGN KEY (reviewer_user_id) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: offers offers_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashley.martin
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.offer_statuses(id) ON DELETE RESTRICT;


--
-- Name: photos photos_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashley.martin
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

