--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: buildings; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE buildings (
    bldg_id integer NOT NULL,
    place_id character varying(64),
    rank integer,
    status character varying(64),
    building_name character varying(128),
    city_id integer NOT NULL,
    lat double precision,
    lng double precision,
    height_m double precision,
    height_ft double precision,
    floors integer,
    completed_yr integer,
    material character varying(64),
    use character varying(64)
);


ALTER TABLE public.buildings OWNER TO vagrant;

--
-- Name: buildings_bldg_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE buildings_bldg_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.buildings_bldg_id_seq OWNER TO vagrant;

--
-- Name: buildings_bldg_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE buildings_bldg_id_seq OWNED BY buildings.bldg_id;


--
-- Name: cards; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE cards (
    card_id integer NOT NULL,
    user_id integer,
    bldg_id integer NOT NULL
);


ALTER TABLE public.cards OWNER TO vagrant;

--
-- Name: cards_card_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE cards_card_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cards_card_id_seq OWNER TO vagrant;

--
-- Name: cards_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE cards_card_id_seq OWNED BY cards.card_id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE cities (
    city_id integer NOT NULL,
    rank integer,
    city character varying(64),
    country character varying(64),
    bldg_count integer
);


ALTER TABLE public.cities OWNER TO vagrant;

--
-- Name: cities_city_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE cities_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cities_city_id_seq OWNER TO vagrant;

--
-- Name: cities_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE cities_city_id_seq OWNED BY cities.city_id;


--
-- Name: tenants; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE tenants (
    tenant_id integer NOT NULL,
    tenant character varying(128),
    place_id character varying(64),
    bldg_id integer NOT NULL
);


ALTER TABLE public.tenants OWNER TO vagrant;

--
-- Name: tenants_tenant_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE tenants_tenant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tenants_tenant_id_seq OWNER TO vagrant;

--
-- Name: tenants_tenant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE tenants_tenant_id_seq OWNED BY tenants.tenant_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE users (
    user_id integer NOT NULL,
    username character varying(64),
    password character varying(64),
    card_id integer
);


ALTER TABLE public.users OWNER TO vagrant;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO vagrant;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: bldg_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY buildings ALTER COLUMN bldg_id SET DEFAULT nextval('buildings_bldg_id_seq'::regclass);


--
-- Name: card_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY cards ALTER COLUMN card_id SET DEFAULT nextval('cards_card_id_seq'::regclass);


--
-- Name: city_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY cities ALTER COLUMN city_id SET DEFAULT nextval('cities_city_id_seq'::regclass);


--
-- Name: tenant_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY tenants ALTER COLUMN tenant_id SET DEFAULT nextval('tenants_tenant_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Data for Name: buildings; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY buildings (bldg_id, place_id, rank, status, building_name, city_id, lat, lng, height_m, height_ft, floors, completed_yr, material, use) FROM stdin;
1	ChIJWdUJpGOAhYARfBVi2TE8daI	1	under construction	Salesforce Tower	41	37.7904906999999994	-122.397125000000003	326.100000000000023	1070	61	2018	composite	office
2	ChIJK5Rpz39hmoARKjcL9JTUw2E	2	proposed	Oceanwide Center Tower 1	41	37.7892050000000026	-122.403442200000001	275.800000000000011	905	61	\N		residential / office
3	ChIJ_93im4qAhYARsKujPnb5xsg	3	completed	Transamerica Pyramid	41	37.7950008999999909	-122.401768799999999	260	853	48	1972	composite	office
4	ChIJIzwEpmSAhYARyJjkUb1b2tM	4	under construction	181 Fremont	41	37.7896124999999969	-122.395433600000004	244.400000000000006	802	54	2017	steel	residential / office
5	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5	completed	555 California Street	41	37.7939999999999969	-122.397400000000005	237.400000000000006	779	52	1969	steel	office
6	ChIJEyzd7mGAhYARzbd5wQvA2GQ	6	completed	345 California Center	41	37.7927497999999886	-122.400434099999998	211.800000000000011	695	48	1986	steel	hotel / office
7	ChIJLe1rfmOAhYARKuIQxc6bKkg	7	completed	Millennium Tower	41	37.7903870000000026	-122.396166399999998	196.599999999999994	645	58	2009	concrete	residential
8	ChIJu2l-LmWAhYARd6vFwem_PuY	8	proposed	Oceanwide Center Tower 2	41	37.7953395999999984	-122.402803700000007	190.5	625	54	\N		residential / hotel
9	ChIJY4PC02SAhYAR6ehorQSCczA	9	under construction	Park Tower at Transbay	41	37.7898911999999996	-122.393366400000005	184.5	605	43	2018		office
10	ChIJz4aeMHqAhYAR0JaNQ-sxdQc	10	completed	One Rincon Hill South Tower	41	37.7864381999999992	-122.392148000000006	184.400000000000006	605	54	2008	concrete	residential
11	ChIJEdx312OAhYARPJiwVTe_XCI	11	completed	101 California Street	41	37.7928917999999996	-122.3981019	183	600	48	1982	steel	office
12	ChIJTyjAdGOAhYARsvCXCz_fUgA	12	completed	50 Fremont Center	41	37.7888949999999966	-122.396192999999997	183	600	43	1985	steel	office
13	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13	completed	Chevron Tower	41	37.7905057999999983	-122.3961611	174.599999999999994	573	40	1975	steel	office
14	ChIJjYcmD2GAhYARFxqer3Qkwrc	14	completed	Four Embarcadero Center	41	37.7945605999999898	-122.398148300000003	173.699999999999989	570	45	1984	steel	office
15	ChIJLRXtdix-j4AR42x4ds2JLYw	15	completed	One Embarcadero Center	41	37.7946586000000124	-122.3993337	173.400000000000006	569	45	1970	steel	office
16	ChIJARyK0YmAhYARcTjRceuk8Vg	16	completed	44 Montgomery	41	37.7898546999999994	-122.401994400000007	172.300000000000011	565	43	1967	steel	office
17	ChIJZ76fAGGAhYARvNjCUTyZebQ	17	completed	Spear Tower	41	37.7939878999999976	-122.394954100000007	172	564	42	1976	steel	office
18	ChIJve0DjV-AhYARNDnShDr2I3A	18	completed	One Sansome Street	41	37.7904715999999965	-122.401216000000005	168	551	43	1984	steel	office
19	ChIJbfoW2Cd-j4ARpOe_8-SMYaI	19	proposed	400 Folsom	41	37.7723907000000025	-122.412822899999995	167.699999999999989	550	50	\N		residential
20	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	20	proposed	Transbay Center Residential Tower	41	37.7905057999999983	-122.3961611	167.599999999999994	550	\N	\N		residential
21	ChIJz4aeMHqAhYAR0JaNQ-sxdQc	21	completed	One Rincon Hill North Tower	41	37.7864381999999992	-122.392148000000006	165	541	45	2014	steel	residential
22	ChIJgSWpS2KAhYARXyMEvJK1UKM	22	completed	Shaklee Terrace Building	41	37.7913718000000074	-122.398783399999999	164	538	38	1982	steel	office
23	ChIJ4RVMW2KAhYARuLxcGkxzFoo	23	completed	First Market Tower	41	37.7905713999999975	-122.399205499999994	161.199999999999989	529	38	1972	steel	office
24	ChIJoRJoNoiAhYARV9QJx2Op3CQ	23	completed	McKesson Plaza	41	37.7887826999999987	-122.402705400000002	161.199999999999989	529	38	1969	steel	office
25	ChIJh455vWKAhYARDccQOv4qQIU	25	completed	425 Market Street	41	37.7914141999999984	-122.398243300000004	159.699999999999989	524	38	1973	steel	office
26	ChIJw4C_mtB_j4ARbPKH1yLqNec	26	proposed	706 Mission	41	37.7740964999999917	-122.390651000000005	155.5	510	44	2018		residential / office
27	ChIJK5Rpz39hmoARKjcL9JTUw2E	27	completed	Telesis Tower	41	37.7892050000000026	-122.403442200000001	152.400000000000006	500	38	1982	steel	office
28	ChIJhxhwkomAhYARJLhTkLrKoLo	28	completed	333 Bush Street	41	37.7906653000000006	-122.403176999999999	150.900000000000006	495	43	1986	steel	residential / office
29	ChIJJVZ2NoiAhYARslurdlyxrvM	29	completed	Hilton San Francisco Union Square	41	37.7888371000000021	-122.402713399999996	150.300000000000011	493	46	1971	steel	hotel
30	ChIJka2ABnt-j4AR71gZVOGofXw	30	completed	Pacific Gas & Electric Building	41	37.8013787999999877	-122.404522099999994	150	492	34	1971	steel	office
31	ChIJb3G2aGGAhYARA7BvZhAo6cg	31	completed	50 California Street	41	37.7940729000000033	-122.397424099999995	148.400000000000006	487	37	1972	steel	office
32	ChIJfyky1mKAhYARHucC_hp4cE8	32	completed	555 Mission Street	41	37.7884109000000024	-122.398638800000001	148.400000000000006	487	33	2008	steel	office
33	ChIJFzmL9IeAhYARH75pRwnV0sk	33	completed	St. Regis San Francisco	41	37.7862709999999993	-122.401452000000006	147.5	484	42	2005	concrete	residential / hotel
34	ChIJiST-K2KAhYAR4DklRzS9BZg	34	completed	100 Pine Center	41	37.7925394999999966	-122.398978700000001	145.099999999999994	476	34	1972	steel	office
35	ChIJ5cDMKoiAhYARvipFiF6XeVY	35	completed	45 Fremont Center	41	37.789877599999997	-122.402291899999994	145	476	34	1979	steel	office
36	ChIJJSk-9IqAhYARKdysbircd7U	36	completed	333 Market Building	41	37.7907022999999995	-122.403069700000003	144	472	33	1979	steel	office
37	0	37	proposed	5M Development - N1 Tower	41	0	0	143.300000000000011	470	40	\N		residential
38	ChIJWyGdpouAhYARbToYS1QXQYQ	38	completed	650 California Street	41	37.792862999999997	-122.405185000000003	142	466	33	1964	steel	office
39	ChIJ-XJGJGeAhYAR__iKMkNXmuo	39	completed	100 First Plaza	41	37.7895530999999991	-122.397576900000004	136.199999999999989	447	27	1988		office
40	ChIJgQJIqnuAhYARepV1YXAK_BI	40	under construction	340 Fremont Street	41	37.7871884999999992	-122.393137400000001	134.099999999999994	440	40	2016	concrete	residential
41	ChIJg86aD32AhYAR60dU80wVK1E	41	completed	One California	41	37.785853699999997	-122.399052100000006	133.5	438	32	1969	steel	office
42	ChIJcT5nNoaAhYARX2kbn4lKnUA	42	completed	San Francisco Marriott	41	37.7850871999999995	-122.404577500000002	132.900000000000006	436	39	1989	steel	hotel
43	ChIJD3SSEnyAhYARwL2YIjRmDmE	43	completed	140 New Montgomery Street	41	37.7867564000000016	-122.399969299999995	132.699999999999989	435	26	1925	steel	residential / hotel
44	ChIJme4Dv4mAhYAR4I2ng42gdl4	44	completed	Russ Building	41	37.7913964999999976	-122.402876000000006	132.599999999999994	435	32	1927	steel	office
45	0	45	proposed	5M Development - H1 Tower	41	0	0	132.599999999999994	435	23	\N		office
46	ChIJc_ZhUp2AhYARRYPT4OzLxKA	46	completed	Jasper	41	37.774636000000001	-122.412928199999996	131	430	39	2015		residential
47	ChIJEcNX9oqAhYARXebqmM8hXkY	47	completed	505 Montgomery	41	37.7938692999999972	-122.403328500000001	129.5	425	24	1988	steel	office
48	ChIJ3Qt5xnqAhYARuoJLmmzaTIY	48	completed	The Infinity II	41	37.7894261	-122.391225000000006	128	420	41	2009	concrete	residential
49	ChIJfyky1mKAhYARvsSatEOkBDo	49	completed	JPMorgan Chase Building	41	37.7885849999999976	-122.398572000000001	128	420	31	2002	steel	office
50	ChIJvUrVFY-AhYARMKAWQwi90VA	50	completed	The Paramount	41	37.7864606999999921	-122.408727600000006	127.400000000000006	418	40	2002	precast	residential
51	ChIJQbsFj2SAhYARQzP7BCuc0I4	51	completed	Providian Financial Building	41	37.7911256999999878	-122.394906800000001	127	417	30	1983	steel	office
52	ChIJ67Hd_b2AhYAR2e3BfI9QHHk	52	proposed	1481 Post Street	41	37.7848674999999901	-122.424288899999993	126.799999999999997	416	36	\N		residential
53	ChIJievPPmGAhYARFQWSAyr4lC0	53	completed	Three Embarcadero Center	41	37.7948704000000006	-122.397323	126	413	31	1976	steel	office
54	ChIJAwqYD2GAhYARNi_hpZV3rak	53	completed	Two Embarcadero Center	41	37.7947036999999995	-122.398128200000002	126	413	31	1974	steel	office
55	ChIJdT81VCV-j4ARXmxqXSV6xHM	55	completed	350 Mission Street	41	37.7647952000000018	-122.412889699999994	125.900000000000006	413	27	2015		office
56	ChIJ75fLhWKAhYARAWWBdLpaEo0	56	completed	595 Market Street	41	37.7894474000000002	-122.400794899999994	125	410	30	1979	concrete	office
57	ChIJ12HgSoOAhYAREab6pIUCa90	57	completed	123 Mission Building	41	37.7778670000000005	-122.413059599999997	124	407	29	1986		office
58	ChIJYYG_UmGAhYARiifhe842hAA	58	completed	Embarcadero Center West	41	37.7949545000000029	-122.399455200000006	123	404	33	1989		office
59	ChIJ92jhwYmAhYARFMjxN5ivWmA	59	completed	101 Montgomery Street	41	37.7905299999999968	-122.402596700000004	123	404	28	1984		office
60	ChIJV05OkpaAhYAREvO2JfkoQa0	60	completed	100 Van Ness	41	37.7851045000000028	-122.420519400000003	122	400	30	1974	steel	residential
61	ChIJmQGxIp6AhYAR9tYnS4hpHPY	61	proposed	160 Folsom Street	41	37.7726196999999999	-122.419799299999994	121.900000000000006	400	40	\N		residential
62	ChIJAQAAQIyAhYARRN3yIQG4hd4	62	completed	Westin-St. Francis Hotel Tower	41	37.802394900000003	-122.405822200000003	121.900000000000006	400	32	1972		hotel
63	ChIJ0x_HRXqAhYAROhkrk7dEktA	63	under construction	399 Fremont	41	37.7870909999999967	-122.392082500000001	121.900000000000006	400	42	2016	concrete	residential
64	ChIJQcMG82KAhYARiGlS-9UmRug	63	completed	LUMINA I	41	37.7894501999999974	-122.399807600000003	121.900000000000006	400	42	2015		residential
65	ChIJSf2W2NV_j4ARM96mFCVSQmY	65	proposed	655 4th Street	41	37.7777394000000086	-122.395440899999997	121.900000000000006	400	40	\N		residential
66	ChIJRXIt4VmHhYARiAUdGYzMtH8	66	proposed	1500 Mission Street	41	37.7688803000000135	-122.3957774	121.900000000000006	400	39	\N		residential
67	ChIJ32e72JmAhYAR34bUQ0lALK8	67	proposed	One Van Ness	41	37.7812853000000004	-122.420246399999996	121.900000000000006	400	34	\N		residential
68	ChIJmeYT26h_j4ARvlMsdFnLSfc	68	completed	Four Seasons Hotel & Residences	41	37.7462971000000067	-122.392239500000002	121.299999999999997	398	40	2001		residential / hotel
69	ChIJKfK7UWCAhYARgjf4YNG9sps	69	completed	One Maritime Plaza	41	37.7956116000000009	-122.399344600000006	121.299999999999997	398	25	1967	steel	office
70	ChIJX2OhS5yAhYARRNDSSRq_wLk	70	completed	8 Nema	41	37.7755551999999994	-122.417010399999995	118	387	37	2014		residential
71	ChIJK51QnmKAhYARarFwAjNf74w	71	completed	33 New Montgomery	41	37.7885853000000012	-122.401272599999999	116.5	382	21	1986	steel	office
72	ChIJMbi8O4GAhYAR6uFHOxDNwqU	72	under construction	41 Tehama	41	37.7804325000000034	-122.405131600000004	115.799999999999997	380	35	2017		residential
73	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73	completed	535 Mission Street	41	37.7888899999999879	-122.398104000000004	115.400000000000006	379	26	2015	composite	office
74	ChIJn02xaWKAhYARHCE_EkyV1eY	74	completed	Shell Building	41	37.7907182000000006	-122.400268699999998	115.200000000000003	378	29	1929	steel	office
75	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75	completed	456 Montgomery Street	41	37.7936253000000022	-122.402705699999999	115.200000000000003	378	26	1986		office
76	ChIJa-JlzmOAhYART1ULF2xUwwk	76	completed	388 Market Street	41	37.7922737999999967	-122.398029500000007	114.299999999999997	375	26	1985	steel	residential / office
77	ChIJi1J5_0ojh1QRSEAyfPSzO94	77	completed	The Westin San Francisco Market Street	41	37.7878019999999992	-122.408811999999998	114	374	34	1984		hotel
78	ChIJLQnXC3iAhYARAQt74KhME-I	78	completed	222 Second Street	41	37.7808398999999966	-122.391225700000007	112.799999999999997	370	26	2015	steel/concrete	office
79	ChIJJVZ2NoiAhYARslurdlyxrvM	79	completed	San Francisco Hilton Hotel Financial District	41	37.7888371000000021	-122.402713399999996	111.299999999999997	365	28	1971		hotel
80	ChIJOfSsu2SAhYARhNRWAPKs5o0	80	completed	199 Fremont Street	41	37.7898826999999997	-122.394661999999997	111.299999999999997	365	27	2000		office
81	ChIJ2d6zHWSAhYAReacyIjXUKhU	81	completed	Steuart Tower	41	37.7938279999999978	-122.394810000000007	111	364	27	1976	steel	office
82	ChIJc5SPsWOAhYARY9kqZIk2HUo	82	completed	425 California Street	41	37.7913004999999984	-122.398135800000006	109.400000000000006	359	27	1967		office
83	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83	completed	100 Montgomery Street	41	37.7901931999999974	-122.401992500000006	108.5	356	25	1955		office
84	ChIJv01Os46AhYARqB1bbRrTMaY	84	completed	Grand Hyatt San Francisco	41	37.7890603000000027	-122.407350399999999	108.200000000000003	355	35	1972		hotel
85	ChIJsRZCy2KAhYAR_B2MsljZNtU	85	completed	101 Second Street	41	37.7881027999999972	-122.399166800000003	108	354	26	1999	steel	office
86	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86	completed	Fox Plaza	41	37.7774454999999989	-122.416897800000001	107.900000000000006	354	29	1967		residential / office
87	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87	completed	580 California Street	41	37.7930070000000029	-122.404191499999996	107	351	23	1984		office
88	ChIJE-Ngz3qAhYARtYD71r2XTg4	88	completed	LUMINA II	41	37.7881450000000001	-122.391182000000001	106.700000000000003	350	37	2015		residential
89	ChIJrynH24iAhYARkdrJvXrCxUI	89	completed	The Infinity I	41	37.7878089000000017	-122.406121299999995	106.700000000000003	350	35	2008	concrete	office
90	ChIJlzWFioWAhYARuV6Mj92GWJs	90	completed	Parc 55 San Francisco	41	37.7845993999999976	-122.408659599999993	106.700000000000003	350	32	1984		hotel
91	ChIJWQ0_pCB-j4ARHPE0XCT02Mg	91	proposed	Central SOMA Tower	41	37.7718023999999986	-122.419811999999993	106.700000000000003	350	\N	\N		residential
92	ChIJjc-4touAhYARcwiC44cqtvc	92	completed	601 California Street	41	37.7924869000000001	-122.404666000000006	106.400000000000006	349	22	1960	steel	office
93	ChIJJVZ2NoiAhYARslurdlyxrvM	93	completed	Hilton San Francisco Union Square Tower II	41	37.7888371000000021	-122.402713399999996	106	348	23	1987		hotel
94	ChIJqRhcpY6AhYARNFQEwBYAJZM	94	completed	450 Sutter Street	41	37.7897079999999974	-122.4076874	104.599999999999994	343	26	1929		office
95	ChIJ9bxa82SAhYAR9roiR4CNnuk	95	completed	135 Main Street	41	37.7915652999999878	-122.393933799999999	103.599999999999994	340	22	1990		office
96	ChIJQcMG82KAhYARuIEZJSMaGE4	96	completed	71 Stevenson Street	41	37.7895593999999875	-122.399779199999998	103	338	26	1986		office
97	ChIJmVeqb_WAhYARMcQ6BEg4HGM	97	completed	Bridgeview	41	37.7980426000000023	-122.402438500000002	101.400000000000006	333	26	2002	concrete	residential / retail
98	ChIJy8P2womAhYARD8xRTe21iFc	98	completed	55 Second Street	41	37.7905427999999972	-122.402480199999999	100.599999999999994	330	25	2002	steel	office
99	ChIJ29GRie-AhYAR4W50rG_xcLA	99	completed	Royal Towers Apartments	41	37.8021766000000028	-122.414452299999994	100.599999999999994	330	24	1964		residential
100	ChIJWz0hEET3MhURSO_o7ni5jjo	100	completed	150 California Street	41	37.7952865999999972	-122.396235300000001	100.599999999999994	330	23	1999	steel	office
101	ChIJrbjkZo6AhYARZpLDu1Jr2A8	101	completed	San Francisco Marriott Union Square	41	37.788359700000008	-122.410439600000004	100.299999999999997	329	29	1972		hotel
102	ChIJK5Rpz39hmoARKjcL9JTUw2E	102	completed	Bechtel Building	41	37.7892050000000026	-122.403442200000001	100	328	23	1967		office
103	ChIJy-vcCmKAhYARyWyFCn3VDpc	103	completed	225 Bush Street	41	37.7908410000000003	-122.401280200000002	100	328	22	1922	steel	office
104	ChIJC5AJa42AhYAR6Bj5sZHPrUY	104	completed	Fairmont San Francisco	41	37.7919357000000034	-122.411353000000005	99.0999999999999943	325	29	1961		hotel
105	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105	completed	235 Pine Street	41	37.7919284999999974	-122.400362799999996	98.7999999999999972	324	26	1990		office
106	ChIJKfw7pI6AhYARR1XIebuVhgU	106	completed	Hunter-Dulin Building	41	37.7894428000000033	-122.407797200000005	98.2999999999999972	322	22	1926	steel	office
107	ChIJG0BIhWGAhYARR22Le0TVKfY	107	completed	Central Plaza	41	37.7928459999999973	-122.404750199999995	96.9000000000000057	318	23	1987		office
108	ChIJcWfgM2CAhYARD19rCAPLhVU	108	completed	W San Francisco	41	37.7947029999999984	-122.400802999999996	96	315	33	1999		hotel
109	ChIJnx0DmHiAhYARRIpKlJJxQfA	109	completed	The Summit	41	37.7804067999999873	-122.394301999999996	96	315	32	1965	concrete	residential
110	ChIJk6jRv46AhYARbE6mIQ6VDsg	110	completed	Sir Francis Drake Hotel	41	37.7888239999999982	-122.408314000000004	96	315	22	1928		hotel
111	ChIJO3og3_mAhYARcFAaa0Zu2kY	111	completed	353 Sacramento Street	41	37.7941062000000016	-122.399683499999995	95.4000000000000057	313	23	1983		office
112	ChIJ0X_WV5qAhYARN-ZYTWDj2KY	112	completed	McAllister Tower Apartments	41	37.7808684999999969	-122.415629199999998	94.5	310	28	1930	steel	residential
113	ChIJka2ABnt-j4AR71gZVOGofXw	113	completed	PG&E Headquarters	41	37.8013787999999877	-122.404522099999994	93.5	307	18	1925	steel	office
114	ChIJ12HgSoOAhYAREab6pIUCa90	114	completed	Trinity Place Building A	41	37.7778670000000005	-122.413059599999997	93	305	25	2009		residential
115	ChIJY4PC02SAhYAR6ehorQSCczA	115	completed	299 Fremont	41	37.7898911999999996	-122.393366400000005	91.4000000000000057	300	25	2016	concrete	residential
116	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116	completed	Central Tower	41	37.7938403000000065	-122.400248500000004	90.7999999999999972	298	21	1938	steel	office
117	ChIJXy_Z1ImAhYARJGOdimh_r6Y	117	completed	Hobart Building	41	37.7894639000000012	-122.401621000000006	86.9000000000000057	285	21	1914	steel	office
118	ChIJWTGPjmaAhYARnYsfhjHT8JM	118	completed	Le Meridien San Francisco	41	37.7961831000000004	-122.393700100000004	82.9000000000000057	272	25	1988	steel	hotel
119	ChIJE14p_6GAhYARYx61OVL6AYc	119	completed	Cathedral Apartments	41	37.7749736000000027	-122.4251364	78.2999999999999972	257	16	1930		residential
120	ChIJt9gPEJ6AhYAR3JymG4zU-tI	120	proposed	30 Otis Street	41	37.7729598000000024	-122.419054000000003	76.2000000000000028	250	26	\N		residential
121	ChIJX2OhS5yAhYARRNDSSRq_wLk	121	completed	18 Nema	41	37.7755551999999994	-122.417010399999995	74.5999999999999943	245	23	2013		residential
122	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122	completed	San Francisco Federal Building	41	37.7819574999999972	-122.418481700000001	71.2999999999999972	234	18	2007	concrete	office
123	ChIJodb7hoiAhYARR19HT8Us4-s	123	completed	Blu Residences	41	37.7865509000000017	-122.404334300000002	67.4000000000000057	221	21	2009		residential
124	0	124	under construction	San Francisco International Airport FAA Airport Traffic Control Tower (ATCT)	41	0	0	67.4000000000000057	221	12	2015	steel/concrete	air traffic control tower
125	0	125	proposed	5M Development - M2 Tower	41	0	0	67.2000000000000028	220	20	\N		residential
126	ChIJ5zP0FGWAhYARpbpE0gPHiAQ	126	proposed	75 Howard Street	41	37.791556000000007	-122.391693000000004	67	220	20	\N		residential / retail
127	ChIJAQAAQIyAhYARRN3yIQG4hd4	127	completed	Coit Tower	41	37.802394900000003	-122.405822200000003	64	210	13	1933	concrete	observation
128	0	128	proposed	5M Development - N2 Tower	41	0	0	59.3999999999999986	195	11	\N		office
129	ChIJF1lX2oaAhYARelgGaL_UtIc	129	completed	The InterContinental San Francisco	41	37.7819912000000002	-122.404910999999998	\N	\N	40	2008	concrete	hotel
130	0	130	proposed	Waldorf Astoria	41	0	0	\N	\N	21	\N		hotel
131	ChIJv01Os46AhYARqB1bbRrTMaY	131	completed	Hyatt Regency San Francisco	41	37.7890603000000027	-122.407350399999999	\N	\N	20	1973		hotel
132	0	132	completed	Humboldt Bank Building	41	0	0	\N	\N	19	1908	steel	office
\.


--
-- Name: buildings_bldg_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('buildings_bldg_id_seq', 132, true);


--
-- Data for Name: cards; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY cards (card_id, user_id, bldg_id) FROM stdin;
1	1	131
3	1	108
6	1	2
7	1	26
8	4	26
\.


--
-- Name: cards_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('cards_card_id_seq', 8, true);


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY cities (city_id, rank, city, country, bldg_count) FROM stdin;
1	1	Hong Kong	China	682
2	2	New York City	United States	1266
3	3	Dubai	United Arab Emirates	270
4	4	Tokyo	Japan	338
5	5	Shanghai	China	345
6	6	Chicago	United States	425
7	7	Guangzhou	China	146
8	8	Chongqing	China	120
9	9	Shenzhen	China	109
10	10	Singapore	Singapore	186
11	11	Chengdu	China	84
12	11	Seoul	South Korea	143
13	13	Jakarta	Indonesia	345
14	14	Bangkok	Thailand	94
15	14	Shenyang	China	57
16	16	Panama City	Panama	78
17	17	Kuala Lumpur	Malaysia	78
18	18	Busan	South Korea	77
19	19	Nanjing	China	53
20	20	Tianjin	China	47
21	21	Toronto	Canada	449
22	22	Osaka	Japan	74
23	23	Moscow	Russia	165
24	24	Houston	United States	185
25	24	Istanbul	Turkey	77
26	24	Makati	Philippines	54
27	27	Sydney	Australia	356
28	28	Abu Dhabi	United Arab Emirates	55
29	28	Incheon	South Korea	56
30	28	Miami	United States	107
31	31	Dalian	China	54
32	31	Melbourne	Australia	180
33	33	Mumbai	India	105
34	33	Wuhan	China	42
35	35	Beijing	China	95
36	36	Doha	Qatar	104
37	37	Xiamen	China	39
38	38	Hangzhou	China	33
39	38	Los Angeles	United States	81
40	40	Nanchang	China	25
41	40	San Francisco	United States	109
42	42	Dallas	United States	102
43	43	Boston	United States	73
44	44	Macau	China	37
45	45	Atlanta	United States	87
46	45	London	United Kingdom	102
47	45	Qingdao	China	20
48	45	Wuxi	China	24
49	49	Calgary	Canada	84
50	49	Changsha	China	23
51	49	Mexico City	Mexico	92
52	49	Seattle	United States	82
53	49	Suzhou	China	18
54	54	Frankfurt am Main	Germany	42
55	54	Fuzhou	China	23
56	54	Goyang	South Korea	14
57	54	Las Vegas	United States	64
58	54	Mandaluyong	Philippines	14
59	59	Kuwait City	Kuwait	22
60	60	Brisbane	Australia	81
61	60	Courbevoie	France	25
62	60	Hefei	China	15
63	60	Manama	Bahrain	17
64	60	Taipei	Republic of China (Taiwan)	32
65	65	Jinan	China	13
66	65	Nanning	China	14
67	65	Philadelphia	United States	151
68	65	São Paulo	Brazil	68
69	69	Daejeon	South Korea	14
70	69	Pittsburgh	United States	52
71	69	Taichung	Republic of China (Taiwan)	18
72	72	Buenos Aires	Argentina	74
73	72	Minneapolis	United States	47
74	72	Nagoya	Japan	10
75	72	Pattaya	Thailand	16
76	76	Detroit	United States	33
77	76	Jersey City	United States	61
78	76	Sharjah	United Arab Emirates	42
79	76	Shijiazhuang	China	11
80	80	Denver	United States	39
81	80	Dongguan	China	7
82	80	Gold Coast	Australia	92
83	80	Guiyang	China	8
84	80	Hanoi	Vietnam	20
85	80	Mecca	Saudi Arabia	7
86	80	Montreal	Canada	38
87	80	Riyadh	Saudi Arabia	24
88	80	Tel Aviv	Israel	53
89	80	Warsaw	Poland	25
90	80	Yokohama	Japan	37
91	91	Banciao City	Republic of China (Taiwan)	7
92	91	Bogota	Colombia	11
93	91	Charlotte	United States	29
94	91	Daegu	South Korea	10
95	91	Ho Chi Minh City	Vietnam	34
96	91	Kaohsiung	Republic of China (Taiwan)	31
97	91	Kawasaki	Japan	13
98	91	Kobe	Japan	13
99	91	Kunming	China	8
100	91	Monterrey	Mexico	11
101	91	Pasig	Philippines	7
102	91	Sunny Isles Beach	United States	22
103	91	Urumqi	China	8
104	91	Xi An	China	13
105	105	Ankara	Turkey	44
106	105	Balneario Camboriu	Brazil	14
107	105	Columbus	United States	32
108	105	Foshan	China	15
109	105	Madrid	Spain	19
110	105	Manila	Philippines	12
111	105	Ningbo	China	6
112	105	Perth	Australia	59
113	105	Rotterdam	Netherlands	102
114	105	Taguig City	Philippines	16
115	105	Ulsan	South Korea	5
116	105	Wenzhou	China	6
117	117	Baku	Azerbaijan	15
118	117	Caracas	Venezuela	105
119	117	Chiba	Japan	4
120	117	Cleveland	United States	21
121	117	Haikou	China	4
122	117	Harbin	China	4
123	117	Huizhou	China	11
124	117	Hwaseong	South Korea	4
125	117	Jeddah	Saudi Arabia	9
126	117	Kolkata	India	9
127	117	New Orleans	United States	22
128	117	New Taipei City	Republic of China (Taiwan)	5
129	117	Taiyuan	China	4
130	117	Tampa	United States	17
131	117	Tangerang	Indonesia	29
132	117	Tulsa	United States	23
133	117	Zhengzhou	China	5
134	134	Astana	Kazakhstan	13
135	134	Austin	United States	42
136	134	Baltimore	United States	29
137	134	Changchun	China	3
138	134	Changzhou	China	3
139	134	Cincinnati	United States	21
140	134	Fort Worth	United States	21
141	134	Hartford	United States	21
142	134	Indianapolis	United States	18
143	134	Johannesburg	South Africa	18
144	134	Lanzhou	China	4
145	134	Liuzhou	China	4
146	134	Milan	Italy	59
147	134	Oklahoma City	United States	6
148	134	Penang	Malaysia	5
149	134	Portland	United States	11
150	134	Puteaux	France	18
151	134	Ramat Gan	Israel	7
152	134	Rio de Janeiro	Brazil	50
153	134	San Diego	United States	30
154	134	St. Louis	United States	32
155	134	Surabaya (Java)	Indonesia	77
156	134	Vienna	Austria	38
157	134	Wuhu	China	3
158	134	Yantai	China	3
159	134	Yekaterinburg	Russia	140
160	160	Al Fujayrah	United Arab Emirates	2
161	160	Anyang	South Korea	2
162	160	Atlantic City	United States	31
163	160	Auckland	New Zealand	44
164	160	Barcelona	Spain	40
165	160	Barranquilla	Colombia	2
166	160	Benidorm	Spain	29
167	160	Bucheon	South Korea	2
168	160	Cartagena	Colombia	4
169	160	Changwon	South Korea	6
170	160	Colombo	Sri Lanka	6
171	160	Curitiba	Brazil	10
172	160	Da Nang	Vietnam	3
173	160	Dar es Salaam	Tanzania	6
174	160	Huzhou	China	3
175	160	Hyderabad	India	6
176	160	Izmir	Turkey	4
177	160	Jacksonville	United States	7
178	160	Jiangyin	China	2
179	160	Kansas City	United States	16
180	160	Louisville	United States	11
181	160	Luoyang	China	2
182	160	Lyon	France	4
183	160	Medellin	Colombia	8
184	160	Miami Beach	United States	22
185	160	Milwaukee	United States	18
186	160	Mississauga	Canada	44
187	160	Nanterre	France	5
188	160	Nantong	China	2
189	160	Nha Trang	Vietnam	3
190	160	Ordos	China	6
191	160	Pyongyang	North Korea	7
192	160	Quanzhou	China	2
193	160	Saitama	Japan	2
194	160	Sandy Springs	United States	2
195	160	Santiago	Chile	23
196	160	Sendai (Miyagi)	Japan	13
197	160	Vancouver	Canada	207
198	160	Zapopan	Mexico	7
199	160	Zhongshan	China	2
200	200	Ajman	United Arab Emirates	14
\.


--
-- Name: cities_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('cities_city_id_seq', 200, true);


--
-- Data for Name: tenants; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY tenants (tenant_id, tenant, place_id, bldg_id) FROM stdin;
1	Salesforce.com	ChIJWdUJpGOAhYARfBVi2TE8daI	1
2	Millennium Tower San Francisco	ChIJWdUJpGOAhYARfBVi2TE8daI	1
3	50 Fremont Center	ChIJWdUJpGOAhYARfBVi2TE8daI	1
4	One Montgomery Tower	ChIJK5Rpz39hmoARKjcL9JTUw2E	2
5	Transamerica Pyramid	ChIJ_93im4qAhYARsKujPnb5xsg	3
6	Transamerica Redwood Park	ChIJ_93im4qAhYARsKujPnb5xsg	3
7	Transamerica Pyramid Center	ChIJ_93im4qAhYARsKujPnb5xsg	3
8	Maynard Cooper & Gale, LLP	ChIJ_93im4qAhYARsKujPnb5xsg	3
9	Northwestern Mutual - Adam Spiegelman	ChIJ_93im4qAhYARsKujPnb5xsg	3
10	PRN	ChIJ_93im4qAhYARsKujPnb5xsg	3
11	Transamerica Realty Services	ChIJ_93im4qAhYARsKujPnb5xsg	3
12	Somo	ChIJIzwEpmSAhYARyJjkUb1b2tM	4
13	KickLabs	ChIJIzwEpmSAhYARyJjkUb1b2tM	4
14	Jay Paul Co	ChIJIzwEpmSAhYARyJjkUb1b2tM	4
15	Waysgo Corporation.	ChIJIzwEpmSAhYARyJjkUb1b2tM	4
16	TripAlertz	ChIJIzwEpmSAhYARyJjkUb1b2tM	4
17	PeopleConnect San Francisco Recruiters	ChIJIzwEpmSAhYARyJjkUb1b2tM	4
18	Heller Manus Architects	ChIJIzwEpmSAhYARyJjkUb1b2tM	4
19	Brilliant You	ChIJIzwEpmSAhYARyJjkUb1b2tM	4
20	Swiftbot Inc.	ChIJIzwEpmSAhYARyJjkUb1b2tM	4
21	Gunshot Digital	ChIJIzwEpmSAhYARyJjkUb1b2tM	4
22	Web Chalet, Inc.	ChIJIzwEpmSAhYARyJjkUb1b2tM	4
23	Podio	ChIJIzwEpmSAhYARyJjkUb1b2tM	4
24	Voices.com	ChIJIzwEpmSAhYARyJjkUb1b2tM	4
25	Justinmind	ChIJIzwEpmSAhYARyJjkUb1b2tM	4
26	Lifesta, Inc.	ChIJIzwEpmSAhYARyJjkUb1b2tM	4
27	Razoo	ChIJIzwEpmSAhYARyJjkUb1b2tM	4
28	555 California Street Building	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
29	Servcorp - 555 California Street	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
30	555 California Garage	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
31	FedEx Office Ship Center	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
32	Bright Horizons	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
33	California Parking Inc.	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
34	Kirkland & Ellis LLP	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
35	McKinsey & Company Inc	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
36	U.S. Trust	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
37	UBS Financial Services Inc.	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
38	Wells Fargo Advisors	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
39	Fenwick & West	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
40	Merrill Lynch Wealth Management	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
41	Barclays	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
42	Bay Club Financial District	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
43	Morgan Stanley	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
44	Parthenon-EY	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
45	UBS Financial Services Inc.	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
46	Dodge & Cox	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
47	Bank of America Financial Center	ChIJ6UC5C2KAhYARyC3_PRDFeRY	5
48	Central Parking	ChIJEyzd7mGAhYARzbd5wQvA2GQ	6
49	Right Management	ChIJEyzd7mGAhYARzbd5wQvA2GQ	6
50	Experis	ChIJEyzd7mGAhYARzbd5wQvA2GQ	6
51	Cushman & Wakefield Inc	ChIJEyzd7mGAhYARzbd5wQvA2GQ	6
52	Bank of Marin	ChIJEyzd7mGAhYARzbd5wQvA2GQ	6
53	Chevron Tci Inc	ChIJEyzd7mGAhYARzbd5wQvA2GQ	6
54	Marsh	ChIJEyzd7mGAhYARzbd5wQvA2GQ	6
55	Embarcadero Center	ChIJEyzd7mGAhYARzbd5wQvA2GQ	6
56	Banner Uniform Center	ChIJEyzd7mGAhYARzbd5wQvA2GQ	6
57	California Pacific Medical Center Research Institute: Sutter Health Affiliate	ChIJEyzd7mGAhYARzbd5wQvA2GQ	6
58	Us Bank	ChIJEyzd7mGAhYARzbd5wQvA2GQ	6
59	Millennium Tower San Francisco	ChIJLe1rfmOAhYARKuIQxc6bKkg	7
60	Millennium Partners	ChIJLe1rfmOAhYARKuIQxc6bKkg	7
61	Millennium Partners Management LLC	ChIJLe1rfmOAhYARKuIQxc6bKkg	7
62	Heller Manus Architects	ChIJu2l-LmWAhYARd6vFwem_PuY	8
63	Temporary Transbay Terminal	ChIJY4PC02SAhYAR6ehorQSCczA	9
64	One Rincon Hill	ChIJz4aeMHqAhYAR0JaNQ-sxdQc	10
65	Jasper	ChIJz4aeMHqAhYAR0JaNQ-sxdQc	10
66	The Infinity Towers	ChIJz4aeMHqAhYAR0JaNQ-sxdQc	10
67	Tower Two at One Rincon Hill	ChIJz4aeMHqAhYAR0JaNQ-sxdQc	10
68	101 California	ChIJEdx312OAhYARPJiwVTe_XCI	11
69	Servcorp - 101 California Street	ChIJEdx312OAhYARPJiwVTe_XCI	11
70	101 California Garage	ChIJEdx312OAhYARPJiwVTe_XCI	11
71	ATM U.S. Bank 101 California	ChIJEdx312OAhYARPJiwVTe_XCI	11
72	101 California Building Garage	ChIJEdx312OAhYARPJiwVTe_XCI	11
73	PABU Izakaya	ChIJEdx312OAhYARPJiwVTe_XCI	11
74	The Plant Cafe Organic	ChIJEdx312OAhYARPJiwVTe_XCI	11
75	U.S. Bank	ChIJEdx312OAhYARPJiwVTe_XCI	11
76	Cooley LLP	ChIJEdx312OAhYARPJiwVTe_XCI	11
77	Greenstreets Cleaners & Tailors	ChIJEdx312OAhYARPJiwVTe_XCI	11
78	The Ramen Bar	ChIJEdx312OAhYARPJiwVTe_XCI	11
79	Yoppi Yogurt	ChIJEdx312OAhYARPJiwVTe_XCI	11
80	Winston & Strawn: Enns Krista M	ChIJEdx312OAhYARPJiwVTe_XCI	11
81	The Salkin Du Borg Group at Morgan Stanley	ChIJEdx312OAhYARPJiwVTe_XCI	11
82	Deutsche Bank	ChIJEdx312OAhYARPJiwVTe_XCI	11
83	Merrill Lynch Wealth Management	ChIJEdx312OAhYARPJiwVTe_XCI	11
84	Premier Business Centers	ChIJEdx312OAhYARPJiwVTe_XCI	11
85	Russell Reynolds Associates	ChIJEdx312OAhYARPJiwVTe_XCI	11
86	Lawrence Law Firm	ChIJEdx312OAhYARPJiwVTe_XCI	11
87	CBRE San Francisco	ChIJEdx312OAhYARPJiwVTe_XCI	11
88	50 Fremont Center	ChIJTyjAdGOAhYARsvCXCz_fUgA	12
89	Salesforce West	ChIJTyjAdGOAhYARsvCXCz_fUgA	12
90	Fifty Fremont Street Building	ChIJTyjAdGOAhYARsvCXCz_fUgA	12
91	US Small Business Administration (US Export Assistance Center)	ChIJTyjAdGOAhYARsvCXCz_fUgA	12
92	Mellon Capital Management Corporation	ChIJTyjAdGOAhYARsvCXCz_fUgA	12
93	Sorrento Catering	ChIJTyjAdGOAhYARsvCXCz_fUgA	12
94	McCabe Mediation & Facilitation	ChIJTyjAdGOAhYARsvCXCz_fUgA	12
95	Rosen Bien Galvan & Grunfeld LLP	ChIJTyjAdGOAhYARsvCXCz_fUgA	12
96	Force by Design	ChIJTyjAdGOAhYARsvCXCz_fUgA	12
97	SCOTT & SALMANOWITZ LLP	ChIJTyjAdGOAhYARsvCXCz_fUgA	12
98	Atlas Cloud Solutions	ChIJTyjAdGOAhYARsvCXCz_fUgA	12
99	La Capra Coffee	ChIJTyjAdGOAhYARsvCXCz_fUgA	12
100	Cello Kebob & Pizza	ChIJTyjAdGOAhYARsvCXCz_fUgA	12
101	City National Bank Banking Office	ChIJTyjAdGOAhYARsvCXCz_fUgA	12
102	Univision KDTV 14	ChIJTyjAdGOAhYARsvCXCz_fUgA	12
103	FedEx Office Print & Ship Center	ChIJTyjAdGOAhYARsvCXCz_fUgA	12
104	Tower Car Wash	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
105	ATM (Tower Car Wash)	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
106	Market Center	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
107	Chevron	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
108	Chevron	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
109	Chevron	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
110	Chevron	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
111	Chevron	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
112	Chevron	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
113	Chevron	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
114	Chevron San Francisco	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
115	Chevron Tci Inc	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
116	Shell	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
117	Shell	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
118	Shell	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
119	Performance Shell	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
120	Shell	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
121	Baskin Robbins	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
122	Millennium Tower San Francisco	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
123	Embarcadero Center	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
124	Embarcadero Center Parking Garage	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
125	Embarcadero Conference Center	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
126	Onigilly Express	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
127	Peninsula Beauty	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
128	Embarcadero 4 Dental	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
129	Impark (Parking)	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
130	See's Candies Chocolate Shops	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
131	Genstar Capital	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
132	One Medical Group	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
133	Sheppard Mullin	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
134	Landmark Theaters Embarcadero Center Cinema	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
135	Sens	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
136	Ladle & Leaf	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
137	Crystal Jade Jiang Nan	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
138	Carr Workplaces - Embarcadero Center	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
139	Eye Carumba Optometry	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
140	One Medical Group	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
141	Pillsbury Winthrop Shaw Pittman LLP	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
142	Banana Republic	ChIJjYcmD2GAhYARFxqer3Qkwrc	14
143	Embarcadero Center	ChIJLRXtdix-j4AR42x4ds2JLYw	15
144	One Medical Group	ChIJLRXtdix-j4AR42x4ds2JLYw	15
145	One Medical Group	ChIJLRXtdix-j4AR42x4ds2JLYw	15
146	Embarcadero One Dentistry: Thatcher Samuel C DDS	ChIJLRXtdix-j4AR42x4ds2JLYw	15
147	Embarcadero One Dentistry: Williams Cynthia A DDS	ChIJLRXtdix-j4AR42x4ds2JLYw	15
148	Dr. Tamer Fakhouri	ChIJLRXtdix-j4AR42x4ds2JLYw	15
149	Embarcadero Center Parking Garage	ChIJLRXtdix-j4AR42x4ds2JLYw	15
150	Landmark Theaters Embarcadero Center Cinema	ChIJLRXtdix-j4AR42x4ds2JLYw	15
151	Regus San Francisco	ChIJLRXtdix-j4AR42x4ds2JLYw	15
152	Beckett & Robb	ChIJLRXtdix-j4AR42x4ds2JLYw	15
153	TherapydiaSF - One Embarcadero	ChIJLRXtdix-j4AR42x4ds2JLYw	15
154	Thrive Juicery	ChIJLRXtdix-j4AR42x4ds2JLYw	15
155	Embarcadero Conference Center	ChIJLRXtdix-j4AR42x4ds2JLYw	15
156	Active Sports Clubs	ChIJLRXtdix-j4AR42x4ds2JLYw	15
157	T-Mobile	ChIJLRXtdix-j4AR42x4ds2JLYw	15
158	Fuzio Universal Bistro	ChIJLRXtdix-j4AR42x4ds2JLYw	15
159	Wheel House	ChIJLRXtdix-j4AR42x4ds2JLYw	15
160	Gap	ChIJLRXtdix-j4AR42x4ds2JLYw	15
161	Embarcadero Dentistry	ChIJLRXtdix-j4AR42x4ds2JLYw	15
162	Ritz Jewelers	ChIJLRXtdix-j4AR42x4ds2JLYw	15
163	Seagate Properties	ChIJARyK0YmAhYARcTjRceuk8Vg	16
164	Starbucks	ChIJARyK0YmAhYARcTjRceuk8Vg	16
165	Nichols Research Inc	ChIJARyK0YmAhYARcTjRceuk8Vg	16
166	The Advisory Group	ChIJARyK0YmAhYARcTjRceuk8Vg	16
167	Krausz Co Inc	ChIJARyK0YmAhYARcTjRceuk8Vg	16
168	First Republic Bank	ChIJARyK0YmAhYARcTjRceuk8Vg	16
169	Esquire Deposition Solutions	ChIJARyK0YmAhYARcTjRceuk8Vg	16
170	Union Bank	ChIJARyK0YmAhYARcTjRceuk8Vg	16
171	U.S. Legal Support (Court Reporting Location)	ChIJARyK0YmAhYARcTjRceuk8Vg	16
172	AppleOne Employment Services	ChIJARyK0YmAhYARcTjRceuk8Vg	16
173	Accounting Principals	ChIJARyK0YmAhYARcTjRceuk8Vg	16
174	AlphaGraphics San Francisco - Sansome St.	ChIJARyK0YmAhYARcTjRceuk8Vg	16
175	Mintz Levin	ChIJARyK0YmAhYARcTjRceuk8Vg	16
176	SunEdison	ChIJARyK0YmAhYARcTjRceuk8Vg	16
177	LeClairRyan - San Francisco, CA	ChIJARyK0YmAhYARcTjRceuk8Vg	16
178	A Businessman's Haircut	ChIJARyK0YmAhYARcTjRceuk8Vg	16
179	Lester Marc w OD	ChIJARyK0YmAhYARcTjRceuk8Vg	16
180	Montgomery St. Station	ChIJARyK0YmAhYARcTjRceuk8Vg	16
181	Michael Papuc, Attorney at Law	ChIJARyK0YmAhYARcTjRceuk8Vg	16
182	Carroll, Burdick & McDonough LLP	ChIJARyK0YmAhYARcTjRceuk8Vg	16
183	One Market Garage	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
184	One Market Street	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
185	Regus San Francisco	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
186	BMO Capital Markets	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
187	One Market Restaurant	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
188	Ishii Robert T	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
189	Morgan Lewis & Bockius: Lorelei A Craig	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
190	The Infinity Towers	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
191	LeadLander	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
192	Emerging Blue	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
193	Morgan Lewis & Bockius: Spicer Amy M	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
194	Dentons	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
195	Molly Duggan Associates	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
196	Alice's Registry, Inc.	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
197	CASA | Culinary Apprenticeship School of the Arts	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
198	McCauley Family Foundation for Education	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
199	Lord Bertram, P.C.	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
200	Morgan Lewis & Bockius: Kim Patricia S	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
201	Wilson Sonsini Goodrich Rosati: Chin Roger J	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
202	Warburg Pincus LLC	ChIJZ76fAGGAhYARvNjCUTyZebQ	17
203	Citigroup Center	ChIJve0DjV-AhYARNDnShDr2I3A	18
204	One Sansome Property LLC	ChIJve0DjV-AhYARNDnShDr2I3A	18
205	Premier Business Centers	ChIJve0DjV-AhYARNDnShDr2I3A	18
206	Houlihan Lokey	ChIJve0DjV-AhYARNDnShDr2I3A	18
207	CITIBANK Atm	ChIJve0DjV-AhYARNDnShDr2I3A	18
208	American Arbitration Association	ChIJve0DjV-AhYARNDnShDr2I3A	18
209	ONLC Training Centers	ChIJve0DjV-AhYARNDnShDr2I3A	18
210	Law Office of Jonathan M. Rutledge	ChIJve0DjV-AhYARNDnShDr2I3A	18
211	Bradshaw & Associates, P.C.	ChIJve0DjV-AhYARNDnShDr2I3A	18
212	FactSet Research Systems Inc	ChIJve0DjV-AhYARNDnShDr2I3A	18
213	U.S. Department of Housing & Urban Development	ChIJve0DjV-AhYARNDnShDr2I3A	18
214	The Law Office of N. William Metke	ChIJve0DjV-AhYARNDnShDr2I3A	18
215	Real Staffing	ChIJve0DjV-AhYARNDnShDr2I3A	18
216	Glass Lewis & Co LLC	ChIJve0DjV-AhYARNDnShDr2I3A	18
217	Aetna	ChIJve0DjV-AhYARNDnShDr2I3A	18
218	Moolicious-Sansome	ChIJve0DjV-AhYARNDnShDr2I3A	18
219	AlphaSense	ChIJve0DjV-AhYARNDnShDr2I3A	18
220	Dan Edelman Law	ChIJve0DjV-AhYARNDnShDr2I3A	18
221	Guitar Cities - San Francisco	ChIJve0DjV-AhYARNDnShDr2I3A	18
222	Industry Capital Advisors, LLC	ChIJve0DjV-AhYARNDnShDr2I3A	18
223	Demandbase	ChIJbfoW2Cd-j4ARpOe_8-SMYaI	19
224	Transbay Temporary Terminal Station	ChIJbfoW2Cd-j4ARpOe_8-SMYaI	19
225	DEEP INSTINCT	ChIJbfoW2Cd-j4ARpOe_8-SMYaI	19
226	Temporary Transbay Terminal	ChIJbfoW2Cd-j4ARpOe_8-SMYaI	19
227	California Parking	ChIJbfoW2Cd-j4ARpOe_8-SMYaI	19
228	Transbay Joint Powers Authority	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
229	Millennium Tower San Francisco	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	13
230	One Rincon Hill	ChIJz4aeMHqAhYAR0JaNQ-sxdQc	10
231	Jasper	ChIJz4aeMHqAhYAR0JaNQ-sxdQc	10
232	The Infinity Towers	ChIJz4aeMHqAhYAR0JaNQ-sxdQc	10
233	303 Second Street Plaza	ChIJz4aeMHqAhYAR0JaNQ-sxdQc	10
234	Tower Two at One Rincon Hill	ChIJz4aeMHqAhYAR0JaNQ-sxdQc	10
235	Shaklee Terraces	ChIJgSWpS2KAhYARXyMEvJK1UKM	22
236	California Parking Inc.	ChIJ4RVMW2KAhYARuLxcGkxzFoo	23
237	Central Tower Market	ChIJ4RVMW2KAhYARuLxcGkxzFoo	23
238	Regus San Francisco	ChIJ4RVMW2KAhYARuLxcGkxzFoo	23
239	Stock Exchange Tower	ChIJ4RVMW2KAhYARuLxcGkxzFoo	23
240	Towers Watson	ChIJ4RVMW2KAhYARuLxcGkxzFoo	23
241	McKesson Plaza	ChIJoRJoNoiAhYARV9QJx2Op3CQ	24
242	McKesson Corporation	ChIJoRJoNoiAhYARV9QJx2Op3CQ	24
243	Specialty's Cafe & Bakery	ChIJoRJoNoiAhYARV9QJx2Op3CQ	24
244	Payne & Fears LLP - San Francisco	ChIJoRJoNoiAhYARV9QJx2Op3CQ	24
245	DCI-Engineers	ChIJoRJoNoiAhYARV9QJx2Op3CQ	24
246	Crocker Plaza Co	ChIJoRJoNoiAhYARV9QJx2Op3CQ	24
247	McKesson	ChIJoRJoNoiAhYARV9QJx2Op3CQ	24
248	McKesson Ventures	ChIJoRJoNoiAhYARV9QJx2Op3CQ	24
249	Mc Kesson Employee CU	ChIJoRJoNoiAhYARV9QJx2Op3CQ	24
250	BBVA Compass Loan Production Office (LPO)	ChIJoRJoNoiAhYARV9QJx2Op3CQ	24
251	Bini's Kitchen	ChIJoRJoNoiAhYARV9QJx2Op3CQ	24
252	Roof Eidam & Maycock	ChIJoRJoNoiAhYARV9QJx2Op3CQ	24
253	Barringer James A	ChIJoRJoNoiAhYARV9QJx2Op3CQ	24
254	Champlain Capital Partners	ChIJoRJoNoiAhYARV9QJx2Op3CQ	24
255	PURE Insurance	ChIJoRJoNoiAhYARV9QJx2Op3CQ	24
256	Champlain Capital	ChIJoRJoNoiAhYARV9QJx2Op3CQ	24
257	Palace Hotel Ghirardelli Chocolate	ChIJoRJoNoiAhYARV9QJx2Op3CQ	24
258	425 Market Street Building	ChIJh455vWKAhYARDccQOv4qQIU	25
259	Regus San Francisco	ChIJh455vWKAhYARDccQOv4qQIU	25
260	AT&T	ChIJh455vWKAhYARDccQOv4qQIU	25
261	Morrison & Foerster LLP	ChIJh455vWKAhYARDccQOv4qQIU	25
262	Six Degrees	ChIJh455vWKAhYARDccQOv4qQIU	25
263	Office Building	ChIJh455vWKAhYARDccQOv4qQIU	25
264	New York Life Insurance Company	ChIJh455vWKAhYARDccQOv4qQIU	25
265	Thomson Reuters	ChIJh455vWKAhYARDccQOv4qQIU	25
266	Hanson Bridgett LLP	ChIJh455vWKAhYARDccQOv4qQIU	25
267	Cushman & Wakefield Inc	ChIJh455vWKAhYARDccQOv4qQIU	25
268	High Street Partners Inc	ChIJh455vWKAhYARDccQOv4qQIU	25
269	Litwin & Smith, A Law Corporation	ChIJh455vWKAhYARDccQOv4qQIU	25
270	IBM	ChIJh455vWKAhYARDccQOv4qQIU	25
271	Grove Street Advisors	ChIJh455vWKAhYARDccQOv4qQIU	25
272	InterDyn BMI	ChIJh455vWKAhYARDccQOv4qQIU	25
273	The Prescott Companies	ChIJh455vWKAhYARDccQOv4qQIU	25
274	Hanson Bridgett LLP	ChIJh455vWKAhYARDccQOv4qQIU	25
275	MetLife	ChIJh455vWKAhYARDccQOv4qQIU	25
276	Hanson Bridgett LLP	ChIJh455vWKAhYARDccQOv4qQIU	25
277	Adrienne Ng - State Farm Insurance Agent	ChIJh455vWKAhYARDccQOv4qQIU	25
278	Millennium Partners Management LLC	ChIJw4C_mtB_j4ARbPKH1yLqNec	26
279	Architectural Foundation-SF	ChIJw4C_mtB_j4ARbPKH1yLqNec	26
280	Millennium Tower San Francisco	ChIJw4C_mtB_j4ARbPKH1yLqNec	26
281	1190 Mission at Trinity Place	ChIJw4C_mtB_j4ARbPKH1yLqNec	26
282	City College of San Francisco - Mission Center	ChIJw4C_mtB_j4ARbPKH1yLqNec	26
283	Union Square	ChIJw4C_mtB_j4ARbPKH1yLqNec	26
284	San Francisco Planning Department	ChIJw4C_mtB_j4ARbPKH1yLqNec	26
285	Mission Pet Hospital	ChIJw4C_mtB_j4ARbPKH1yLqNec	26
286	Channel Mission Bay	ChIJw4C_mtB_j4ARbPKH1yLqNec	26
287	One Montgomery Tower	ChIJK5Rpz39hmoARKjcL9JTUw2E	2
288	333 Bush Street	ChIJhxhwkomAhYARJLhTkLrKoLo	28
289	Hilton San Francisco Union Square	ChIJJVZ2NoiAhYARslurdlyxrvM	29
290	Parc 55 San Francisco - A Hilton Hotel	ChIJJVZ2NoiAhYARslurdlyxrvM	29
291	Hilton San Francisco Financial District	ChIJJVZ2NoiAhYARslurdlyxrvM	29
292	FedEx Office Print & Ship Center	ChIJJVZ2NoiAhYARslurdlyxrvM	29
293	Urban Tavern	ChIJJVZ2NoiAhYARslurdlyxrvM	29
294	Union Square	ChIJJVZ2NoiAhYARslurdlyxrvM	29
295	Hotel Union Square	ChIJJVZ2NoiAhYARslurdlyxrvM	29
296	Union Square Sports Bar	ChIJJVZ2NoiAhYARslurdlyxrvM	29
297	Hampton Inn San Francisco Downtown/Convention Center	ChIJJVZ2NoiAhYARslurdlyxrvM	29
298	The Westin St. Francis San Francisco on Union Square	ChIJJVZ2NoiAhYARslurdlyxrvM	29
299	The Old Siam Thai Restaurant	ChIJJVZ2NoiAhYARslurdlyxrvM	29
300	Alamo Rent A Car	ChIJJVZ2NoiAhYARslurdlyxrvM	29
301	Cityscape Bar & Restaurant	ChIJJVZ2NoiAhYARslurdlyxrvM	29
302	Doubletree by Hilton	ChIJJVZ2NoiAhYARslurdlyxrvM	29
303	Pacific Gas and Electric Company	ChIJka2ABnt-j4AR71gZVOGofXw	30
304	PG&E Pacific Energy Center	ChIJka2ABnt-j4AR71gZVOGofXw	30
305	Pacific Gas and Electric Company	ChIJka2ABnt-j4AR71gZVOGofXw	30
306	Pacific Gas and Electric Company Customer Service Office	ChIJka2ABnt-j4AR71gZVOGofXw	30
307	Pacific Gas and Electric Company	ChIJka2ABnt-j4AR71gZVOGofXw	30
308	Pacific Gas & Electric Co	ChIJka2ABnt-j4AR71gZVOGofXw	30
309	Pacific Gas and Electric Company	ChIJka2ABnt-j4AR71gZVOGofXw	30
310	Pacific Gas and Electric Company	ChIJka2ABnt-j4AR71gZVOGofXw	30
311	PG&E Corporation	ChIJka2ABnt-j4AR71gZVOGofXw	30
312	Pacific Gas & Electric Co	ChIJka2ABnt-j4AR71gZVOGofXw	30
313	Regus San Francisco	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
314	Bank of America Financial Center	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
315	OfficeTeam	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
316	Robert Half Legal	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
317	Chipotle Mexican Grill	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
318	The Creative Group	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
319	Holland & Knight LLP	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
320	Recology	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
321	YMCA	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
322	Accountemps	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
323	Robert Half Technology	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
324	Piper Jaffray & Co	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
325	Eichstaedt & Lervold, LLP	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
326	Nossaman LLP	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
327	Nob Hill Notary Mobile & In-House Services	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
328	Robert Half Finance & Accounting	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
329	Frank Sandoval - HomeStreet Bank	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
330	PhoneNumberGuy, Inc.	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
331	Robert Half Management Resources	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
332	Huntsman Architectural Group	ChIJb3G2aGGAhYARA7BvZhAo6cg	31
333	Deloitte	ChIJfyky1mKAhYARHucC_hp4cE8	32
334	Standard Parking	ChIJfyky1mKAhYARHucC_hp4cE8	32
335	Silicon Valley Bank	ChIJfyky1mKAhYARHucC_hp4cE8	32
336	Chase Bank	ChIJfyky1mKAhYARHucC_hp4cE8	32
337	Novak Druce Connolly Bove + Quigg LLP	ChIJfyky1mKAhYARHucC_hp4cE8	32
338	HEYDAY - Organic Cafe and Bakery	ChIJfyky1mKAhYARHucC_hp4cE8	32
339	DLA Piper	ChIJfyky1mKAhYARHucC_hp4cE8	32
340	Gibson Dunn & Crutcher	ChIJfyky1mKAhYARHucC_hp4cE8	32
341	CNA San Francisco Branch	ChIJfyky1mKAhYARHucC_hp4cE8	32
342	A.T. Kearney, Inc.	ChIJfyky1mKAhYARHucC_hp4cE8	32
343	BNY Mellon Wealth Management San Francisco	ChIJfyky1mKAhYARHucC_hp4cE8	32
344	Vinson & Elkins LLP	ChIJfyky1mKAhYARHucC_hp4cE8	32
345	Tishman Speyer	ChIJfyky1mKAhYARHucC_hp4cE8	32
346	Allianz Global Investors	ChIJfyky1mKAhYARHucC_hp4cE8	32
347	DLA Piper Us LLP: Sekimura Gerald	ChIJfyky1mKAhYARHucC_hp4cE8	32
348	Crowley Theresa	ChIJfyky1mKAhYARHucC_hp4cE8	32
349	DLA Piper: Mc Donald Roy K	ChIJfyky1mKAhYARHucC_hp4cE8	32
350	Dla Piper: Hurley James	ChIJfyky1mKAhYARHucC_hp4cE8	32
351	Strata Apartments	ChIJfyky1mKAhYARHucC_hp4cE8	32
352	Gibson Dunn & Crutcher: Blenkhorn Lindsey E	ChIJfyky1mKAhYARHucC_hp4cE8	32
353	The St. Regis San Francisco	ChIJFzmL9IeAhYARH75pRwnV0sk	33
354	100 Pine	ChIJiST-K2KAhYAR4DklRzS9BZg	34
355	Intelligent Office	ChIJiST-K2KAhYAR4DklRzS9BZg	34
356	SRS Real Estate Partners - San Francisco	ChIJiST-K2KAhYAR4DklRzS9BZg	34
357	Mommy Makeover of San Francisco	ChIJiST-K2KAhYAR4DklRzS9BZg	34
358	LensCrafters	ChIJiST-K2KAhYAR4DklRzS9BZg	34
359	METI International	ChIJiST-K2KAhYAR4DklRzS9BZg	34
360	Heidi Hoch, Commercial Broker	ChIJiST-K2KAhYAR4DklRzS9BZg	34
361	Law Offices of Cody Jaffe	ChIJiST-K2KAhYAR4DklRzS9BZg	34
362	CapAccel	ChIJiST-K2KAhYAR4DklRzS9BZg	34
363	Software Progressions Corporation	ChIJiST-K2KAhYAR4DklRzS9BZg	34
364	Impact Community Capital	ChIJiST-K2KAhYAR4DklRzS9BZg	34
365	NEXT UP RESEARCH	ChIJiST-K2KAhYAR4DklRzS9BZg	34
366	Overcoming the Challenge	ChIJiST-K2KAhYAR4DklRzS9BZg	34
367	SP+ Parking @ 100 Pine Street Parking Facility	ChIJiST-K2KAhYAR4DklRzS9BZg	34
368	Shorenstein Company	ChIJ5cDMKoiAhYARvipFiF6XeVY	35
369	Wells Fargo Insurance Services	ChIJ5cDMKoiAhYARvipFiF6XeVY	35
370	50 Fremont Center	ChIJ5cDMKoiAhYARvipFiF6XeVY	35
371	Fremont St & Market St	ChIJ5cDMKoiAhYARvipFiF6XeVY	35
372	Mission St & First St	ChIJ5cDMKoiAhYARvipFiF6XeVY	35
373	24 Hour Fitness Super Sport	ChIJ5cDMKoiAhYARvipFiF6XeVY	35
374	333 Market	ChIJJSk-9IqAhYARKdysbircd7U	36
375	Wells Fargo Bank	ChIJJSk-9IqAhYARKdysbircd7U	36
376	455 Market Street	ChIJJSk-9IqAhYARKdysbircd7U	36
377	Starbucks	ChIJJSk-9IqAhYARKdysbircd7U	36
378	Russell's Convenience	ChIJJSk-9IqAhYARKdysbircd7U	36
379	Ace Parking	ChIJJSk-9IqAhYARKdysbircd7U	36
380	Hines	ChIJJSk-9IqAhYARKdysbircd7U	36
381	650 California St LLC	ChIJWyGdpouAhYARbToYS1QXQYQ	38
382	Thornton Tomasetti	ChIJWyGdpouAhYARbToYS1QXQYQ	38
383	Credit Suisse AG (Investment Banking)	ChIJWyGdpouAhYARbToYS1QXQYQ	38
384	Walkup, Melodia, Kelly & Schoenberger	ChIJWyGdpouAhYARbToYS1QXQYQ	38
385	AppDirect	ChIJWyGdpouAhYARbToYS1QXQYQ	38
386	Standard Parking	ChIJ-XJGJGeAhYAR__iKMkNXmuo	39
387	Oasis Grill	ChIJ-XJGJGeAhYAR__iKMkNXmuo	39
388	Kilroy Realty Corporation	ChIJ-XJGJGeAhYAR__iKMkNXmuo	39
389	Roof Garden	ChIJ-XJGJGeAhYAR__iKMkNXmuo	39
390	Starbucks	ChIJ-XJGJGeAhYAR__iKMkNXmuo	39
391	340 Fremont Apartments	ChIJgQJIqnuAhYARepV1YXAK_BI	40
392	Exam One	ChIJg86aD32AhYAR60dU80wVK1E	41
393	One Medical Group	ChIJg86aD32AhYAR60dU80wVK1E	41
394	AppleOne Employment Services	ChIJg86aD32AhYAR60dU80wVK1E	41
395	Capital One Café	ChIJg86aD32AhYAR60dU80wVK1E	41
396	One Market Street	ChIJg86aD32AhYAR60dU80wVK1E	41
397	One Medical Group	ChIJg86aD32AhYAR60dU80wVK1E	41
398	One Maritime Plaza	ChIJg86aD32AhYAR60dU80wVK1E	41
399	One Workplace	ChIJg86aD32AhYAR60dU80wVK1E	41
400	One Sansome Property LLC	ChIJg86aD32AhYAR60dU80wVK1E	41
401	One Medical Group	ChIJg86aD32AhYAR60dU80wVK1E	41
402	Wells Fargo Bank	ChIJg86aD32AhYAR60dU80wVK1E	41
403	One Medical Group	ChIJg86aD32AhYAR60dU80wVK1E	41
404	One Bush Plaza	ChIJg86aD32AhYAR60dU80wVK1E	41
405	One Medical Group	ChIJg86aD32AhYAR60dU80wVK1E	41
406	One Market Restaurant	ChIJg86aD32AhYAR60dU80wVK1E	41
407	Climate One	ChIJg86aD32AhYAR60dU80wVK1E	41
408	One Medical Group	ChIJg86aD32AhYAR60dU80wVK1E	41
409	One Medical Group	ChIJg86aD32AhYAR60dU80wVK1E	41
410	One Medical Group	ChIJg86aD32AhYAR60dU80wVK1E	41
411	One Hawthorne Sales Center	ChIJg86aD32AhYAR60dU80wVK1E	41
412	San Francisco Marriott Marquis	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
413	San Francisco Marriott Union Square	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
414	JW Marriott San Francisco Union Square	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
415	SF Marriott Massage & Fitness Center	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
416	Courtyard San Francisco Downtown	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
417	The View	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
418	Courtyard San Francisco Union Square	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
419	Bin 55	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
420	Hertz	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
421	Hotel Adagio, Autograph Collection	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
422	bin 480	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
423	Level III Restaurant	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
424	City Park	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
425	Bridges From School To Work	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
426	AMA Conference Center San Francisco	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
427	Union Square	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
428	San Francisco Marriott	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
429	marriott	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
430	marriott	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
431	Mission Grille	ChIJcT5nNoaAhYARX2kbn4lKnUA	42
432	Yelp	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
433	Bloomberg Tech	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
434	Mourad	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
435	Trou Normand	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
436	Knoll	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
437	Bre New Montgomery LLC	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
438	Software AG	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
439	AmWINS Insurance Brokerage of California	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
440	Apcera	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
441	G2 Insurance	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
442	Lumos Labs, Inc.	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
443	SeatMe	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
444	Walgreens	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
445	Crunch - New Montgomery	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
446	Specialty's Cafe & Bakery	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
447	The UPS Store	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
448	Starbucks	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
449	Bank of America Financial Center	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
450	Chipotle Mexican Grill	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
451	AT&T	ChIJD3SSEnyAhYARwL2YIjRmDmE	43
452	Russ Building Garage	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
453	San Francisco Chamber of Commerce	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
454	Shorenstein Co	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
455	Phollies Russ Murphy Inc	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
456	Cooper John L	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
457	Farella Braun & Martel Llp: Ancar Katina	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
458	BluePrint Research Group	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
459	Pollak & Pollak Wealth Management, a Private Wealth Advisory practive of Ameriprise Financial Services, Inc.	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
460	Joel Siegal Attorney	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
461	Peet's Coffee	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
462	Liuzzi Murphy Solomon Churton & Hale: Hale Michael	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
463	Aberdare Ventures	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
464	Latino Community Foundation	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
465	Joel H Siegal	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
466	Sipree Inc	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
467	Stinson Capital Management LLC	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
468	Committee On Jobs	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
469	Linear Blue Inc.	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
470	ZwillGen Law	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
471	Law Offices of Sara M. Taylor	ChIJme4Dv4mAhYAR4I2ng42gdl4	44
472	Jasper	ChIJc_ZhUp2AhYARRYPT4OzLxKA	46
473	Jasper's Corner Tap & Kitchen	ChIJc_ZhUp2AhYARRYPT4OzLxKA	46
474	Charles S. Jasper, PHD	ChIJc_ZhUp2AhYARRYPT4OzLxKA	46
475	Jasper Sinclaire Media Productions Group	ChIJc_ZhUp2AhYARRYPT4OzLxKA	46
476	Jasper Schmidt, MD	ChIJc_ZhUp2AhYARRYPT4OzLxKA	46
477	505 Montgomery Garage	ChIJEcNX9oqAhYARXebqmM8hXkY	47
478	Regus San Francisco	ChIJEcNX9oqAhYARXebqmM8hXkY	47
479	BookATailor San Francisco Showroom	ChIJEcNX9oqAhYARXebqmM8hXkY	47
480	Latham & Watkins: Lutz Samuel B	ChIJEcNX9oqAhYARXebqmM8hXkY	47
481	Palio Caffe	ChIJEcNX9oqAhYARXebqmM8hXkY	47
482	Latham & Watkins LLP	ChIJEcNX9oqAhYARXebqmM8hXkY	47
483	Davis Wright Tremaine LLP	ChIJEcNX9oqAhYARXebqmM8hXkY	47
484	Bank of the West	ChIJEcNX9oqAhYARXebqmM8hXkY	47
485	Payroll Resourcesce Group	ChIJEcNX9oqAhYARXebqmM8hXkY	47
486	Portcullis, Inc.	ChIJEcNX9oqAhYARXebqmM8hXkY	47
487	Intertrust Sanfrancisco	ChIJEcNX9oqAhYARXebqmM8hXkY	47
488	Beacon Hill Staffing Group	ChIJEcNX9oqAhYARXebqmM8hXkY	47
489	UIS Technology Partners	ChIJEcNX9oqAhYARXebqmM8hXkY	47
490	Davis Wright Tremaine LLP: Hsue James	ChIJEcNX9oqAhYARXebqmM8hXkY	47
491	Davis Wright Tremaine: Fanger Gwen L	ChIJEcNX9oqAhYARXebqmM8hXkY	47
492	Davis Wright Tremaine: Dawood Sam N	ChIJEcNX9oqAhYARXebqmM8hXkY	47
493	Davis Wright Tremaine: Fumia Mark J	ChIJEcNX9oqAhYARXebqmM8hXkY	47
494	Davis Wright Tremaine: Gex Robert B	ChIJEcNX9oqAhYARXebqmM8hXkY	47
495	Latham & Watkins: Mayer Katherine	ChIJEcNX9oqAhYARXebqmM8hXkY	47
496	Venable LLP, San Francisco, CA	ChIJEcNX9oqAhYARXebqmM8hXkY	47
497	The Infinity Towers	ChIJ3Qt5xnqAhYARuoJLmmzaTIY	48
498	JPMorgan Chase	ChIJfyky1mKAhYARvsSatEOkBDo	49
499	JPMorgan Chase	ChIJfyky1mKAhYARvsSatEOkBDo	49
500	JPMorgan Chase	ChIJfyky1mKAhYARvsSatEOkBDo	49
501	JPMorgan Chase	ChIJfyky1mKAhYARvsSatEOkBDo	49
502	JPMorgan Chase	ChIJfyky1mKAhYARvsSatEOkBDo	49
503	Chase Bank	ChIJfyky1mKAhYARvsSatEOkBDo	49
504	The Paramount Luxury Apartments	ChIJvUrVFY-AhYARMKAWQwi90VA	50
505	Paramount Student Housing - The Park	ChIJvUrVFY-AhYARMKAWQwi90VA	50
506	Paramount Student Housing - The Herbert	ChIJvUrVFY-AhYARMKAWQwi90VA	50
507	Valet De Paramount	ChIJvUrVFY-AhYARMKAWQwi90VA	50
508	Paramount Student Housing - The Spaulding	ChIJvUrVFY-AhYARMKAWQwi90VA	50
509	Seal Software	ChIJQbsFj2SAhYARQzP7BCuc0I4	51
510	Varden Pacific LLC	ChIJQbsFj2SAhYARQzP7BCuc0I4	51
511	Navolio & Tallman, LLP	ChIJQbsFj2SAhYARQzP7BCuc0I4	51
512	Propel Venture Partners	ChIJQbsFj2SAhYARQzP7BCuc0I4	51
513	Silicon Legal Strategy	ChIJQbsFj2SAhYARQzP7BCuc0I4	51
514	Spring Studio	ChIJQbsFj2SAhYARQzP7BCuc0I4	51
515	Clustrix Inc	ChIJQbsFj2SAhYARQzP7BCuc0I4	51
516	Procore	ChIJQbsFj2SAhYARQzP7BCuc0I4	51
517	Concepcion Enterprises, LLC	ChIJQbsFj2SAhYARQzP7BCuc0I4	51
518	Adco Group	ChIJ67Hd_b2AhYAR2e3BfI9QHHk	52
519	S F Building & Construction Trades	ChIJ67Hd_b2AhYAR2e3BfI9QHHk	52
520	Cathedral Hill Tower	ChIJ67Hd_b2AhYAR2e3BfI9QHHk	52
521	Embarcadero Center Parking Garage	ChIJievPPmGAhYARFQWSAyr4lC0	53
522	Embarcadero Center	ChIJievPPmGAhYARFQWSAyr4lC0	53
523	Hyegraph Invitations & Calligraphy	ChIJievPPmGAhYARFQWSAyr4lC0	53
524	Kirimachi Ramen	ChIJievPPmGAhYARFQWSAyr4lC0	53
525	Goodwin Procter	ChIJievPPmGAhYARFQWSAyr4lC0	53
526	PricewaterhouseCoopers LLP	ChIJievPPmGAhYARFQWSAyr4lC0	53
527	Black Tie Tuxedos and Couture Menswear	ChIJievPPmGAhYARFQWSAyr4lC0	53
528	Gap	ChIJievPPmGAhYARFQWSAyr4lC0	53
529	See's Candies Chocolate Shops	ChIJievPPmGAhYARFQWSAyr4lC0	53
530	FedEx Office Ship Center	ChIJievPPmGAhYARFQWSAyr4lC0	53
531	The Bar Method	ChIJievPPmGAhYARFQWSAyr4lC0	53
532	Ann Taylor	ChIJievPPmGAhYARFQWSAyr4lC0	53
533	Naturalizer	ChIJievPPmGAhYARFQWSAyr4lC0	53
534	Stoel Rives LLP	ChIJievPPmGAhYARFQWSAyr4lC0	53
535	Ropes & Gray	ChIJievPPmGAhYARFQWSAyr4lC0	53
536	Polsinelli LLP	ChIJievPPmGAhYARFQWSAyr4lC0	53
537	Vanity Beauty Lounge	ChIJievPPmGAhYARFQWSAyr4lC0	53
538	Pro-Style Barber Shop	ChIJievPPmGAhYARFQWSAyr4lC0	53
539	Green Bar restaurant and catering	ChIJievPPmGAhYARFQWSAyr4lC0	53
540	Bridal Galleria	ChIJievPPmGAhYARFQWSAyr4lC0	53
541	Embarcadero Center	ChIJAwqYD2GAhYARNi_hpZV3rak	54
542	Embarcadero Center Parking Garage	ChIJAwqYD2GAhYARNi_hpZV3rak	54
543	One Medical Group	ChIJAwqYD2GAhYARNi_hpZV3rak	54
544	Landmark Theaters Embarcadero Center Cinema	ChIJAwqYD2GAhYARNi_hpZV3rak	54
545	Blanc Et Rouge	ChIJAwqYD2GAhYARNi_hpZV3rak	54
546	Embarcadero Dentistry	ChIJAwqYD2GAhYARNi_hpZV3rak	54
547	Robert L. Brown	ChIJAwqYD2GAhYARNi_hpZV3rak	54
548	Embarcadero Conference Center	ChIJAwqYD2GAhYARNi_hpZV3rak	54
549	FedEx Office Ship Center	ChIJAwqYD2GAhYARNi_hpZV3rak	54
550	Carr Workplaces - Embarcadero Center	ChIJAwqYD2GAhYARNi_hpZV3rak	54
551	Gap	ChIJAwqYD2GAhYARNi_hpZV3rak	54
552	One Medical Group	ChIJAwqYD2GAhYARNi_hpZV3rak	54
553	Embarcadero Dentistry: Facchino Curt C DDS	ChIJAwqYD2GAhYARNi_hpZV3rak	54
554	Active Sports Clubs	ChIJAwqYD2GAhYARNi_hpZV3rak	54
555	Onigilly Express	ChIJAwqYD2GAhYARNi_hpZV3rak	54
556	Comerica Bank	ChIJAwqYD2GAhYARNi_hpZV3rak	54
557	T-Mobile	ChIJAwqYD2GAhYARNi_hpZV3rak	54
558	Embarcadero 4 Dental: Jethani Nisha DDS	ChIJAwqYD2GAhYARNi_hpZV3rak	54
559	Crosslink Capital	ChIJAwqYD2GAhYARNi_hpZV3rak	54
560	Blue Hawaii Açaí Café	ChIJAwqYD2GAhYARNi_hpZV3rak	54
561	San Francisco Public Works	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
562	Francisco Teresita	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
563	Mina Group, LLC	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
564	UCSF OB GYN at Mission Bay - Owens Street	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
565	Owens Street Garage - UCSF Medical Center at Mission Bay	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
566	Mission St & 3rd St	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
567	One Medical Group	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
568	Avalon at Mission Bay	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
569	City Park	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
570	Montgomery St. Station	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
571	Skidmore, Owings & Merrill LLP (SOM)	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
572	San Francisco Planning Department	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
573	560 Mission Street Plaza	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
574	Mission Neighborhood Health Center	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
575	City College of San Francisco - Mission Center	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
576	Mission-Bartlett Garage	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
577	Mission Police Station	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
578	Mission Bowling Club	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
579	St. Francis Living Room	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
580	Yoga Mayu - Mission	ChIJdT81VCV-j4ARXmxqXSV6xHM	55
581	Uno Dos Tacos	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
582	Creative Circle	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
583	Chase Bank	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
584	Consumer Credit Counseling Service of San Francisco	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
585	Consulate General of Singapore	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
586	Calypso Technology	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
587	FinancialForce.com	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
588	Sunrun	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
589	Consulate General of Colombia	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
590	BALANCE	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
591	Nelson	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
592	RemX Financial Staffing	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
593	Chapman & Cutler: Tierney Renee	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
594	RemX IT Staffing	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
595	Chapman & Cutler: Thill David W	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
596	Chapman & Cutler: Casconcellos J Brent	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
597	Chapman & Cutler: Reimers Johanna L	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
598	Chapman & Cutler: Pelleriti Vincent W	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
599	H5	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
600	SelectQuote Insurance Services	ChIJ75fLhWKAhYARAWWBdLpaEo0	56
601	123 Mission Street Building Garage	ChIJ12HgSoOAhYAREab6pIUCa90	57
602	Arup	ChIJ12HgSoOAhYAREab6pIUCa90	57
603	Starbucks	ChIJ12HgSoOAhYAREab6pIUCa90	57
604	1190 Mission at Trinity Place	ChIJ12HgSoOAhYAREab6pIUCa90	57
605	Embarcadero Center	ChIJYYG_UmGAhYARiifhe842hAA	58
606	See's Candies Chocolate Shops	ChIJYYG_UmGAhYARiifhe842hAA	58
607	Bingham Mccutchen: West Colin	ChIJYYG_UmGAhYARiifhe842hAA	58
608	Mc Cutchen Doyle Brown Enersen: West Derek A	ChIJYYG_UmGAhYARiifhe842hAA	58
609	Andersen Bakery Inc.	ChIJYYG_UmGAhYARiifhe842hAA	58
610	Julia West, RN	ChIJYYG_UmGAhYARiifhe842hAA	58
611	FedEx Office Ship Center	ChIJYYG_UmGAhYARiifhe842hAA	58
612	Embarcadero Center Parking Garage	ChIJYYG_UmGAhYARiifhe842hAA	58
613	Embarcadero Cleaners	ChIJYYG_UmGAhYARiifhe842hAA	58
614	Boston Properties	ChIJYYG_UmGAhYARiifhe842hAA	58
615	Landmark Theaters Embarcadero Center Cinema	ChIJYYG_UmGAhYARiifhe842hAA	58
616	Hyatt Regency San Francisco	ChIJYYG_UmGAhYARiifhe842hAA	58
617	One Medical Group	ChIJYYG_UmGAhYARiifhe842hAA	58
618	Crystal Jade Jiang Nan	ChIJYYG_UmGAhYARiifhe842hAA	58
619	First American Title	ChIJYYG_UmGAhYARiifhe842hAA	58
620	Osha Thai Restaurant & Lounge	ChIJYYG_UmGAhYARiifhe842hAA	58
621	Kilpatrick Townsend and Stockton LLP: Garrett-Wackow Euginia	ChIJYYG_UmGAhYARiifhe842hAA	58
622	Rubio's	ChIJYYG_UmGAhYARiifhe842hAA	58
623	Avis Car Rental	ChIJYYG_UmGAhYARiifhe842hAA	58
624	USPS	ChIJYYG_UmGAhYARiifhe842hAA	58
625	Specialty's Cafe & Bakery	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
626	Coffee Bar Montgomery	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
627	Calfox, Inc.	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
628	Navera	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
629	Chase Bank	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
630	Icon Dental	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
631	Veritext Legal Solutions	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
632	Terreno Realty Corporation	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
633	La Fromagerie Cheese Shop	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
634	MassMutual Northern California	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
635	Martinkovic Milford Architects	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
636	The Trust for Public Land	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
637	Enterprise Community Partners	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
638	PROS, Inc.	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
639	North Highland Co	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
640	Marcum LLP	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
641	True Capital Management: Bond Jacob	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
642	Pacific Research Institute	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
643	Canaccord Genuity	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
644	MassMutual Financial Group: Dennis Nix	ChIJ92jhwYmAhYARFMjxN5ivWmA	59
645	100 Van Ness	ChIJV05OkpaAhYAREvO2JfkoQa0	60
646	Corridor Cafe	ChIJV05OkpaAhYAREvO2JfkoQa0	60
647	Subway	ChIJV05OkpaAhYAREvO2JfkoQa0	60
648	U-Haul Downtown Box Store	ChIJV05OkpaAhYAREvO2JfkoQa0	60
649	Transportation Authority	ChIJV05OkpaAhYAREvO2JfkoQa0	60
650	Emerald Fund	ChIJV05OkpaAhYAREvO2JfkoQa0	60
651	Sperry Van Ness	ChIJV05OkpaAhYAREvO2JfkoQa0	60
652	Sperry Van Ness Commercial Real Estate	ChIJV05OkpaAhYAREvO2JfkoQa0	60
653	Sperry Van Ness | SV Advisors	ChIJV05OkpaAhYAREvO2JfkoQa0	60
654	Market St & South Van Ness Ave	ChIJV05OkpaAhYAREvO2JfkoQa0	60
655	Van Ness Ave & Turk St	ChIJV05OkpaAhYAREvO2JfkoQa0	60
656	Van Ness Ave & Grove St	ChIJV05OkpaAhYAREvO2JfkoQa0	60
657	Hayes St & Van Ness Ave	ChIJV05OkpaAhYAREvO2JfkoQa0	60
658	Van Ness Ave & Oak St	ChIJV05OkpaAhYAREvO2JfkoQa0	60
659	RentSFNow	ChIJV05OkpaAhYAREvO2JfkoQa0	60
660	AMC Van Ness 14	ChIJV05OkpaAhYAREvO2JfkoQa0	60
661	Walgreens	ChIJV05OkpaAhYAREvO2JfkoQa0	60
662	Bank of America Financial Center	ChIJV05OkpaAhYAREvO2JfkoQa0	60
663	South Van Ness Manor	ChIJV05OkpaAhYAREvO2JfkoQa0	60
664	1000 Van Ness	ChIJV05OkpaAhYAREvO2JfkoQa0	60
665	Rincon Park	ChIJmQGxIp6AhYAR9tYnS4hpHPY	61
666	San Francisco Housing Action	ChIJmQGxIp6AhYAR9tYnS4hpHPY	61
667	The Westin St. Francis San Francisco on Union Square	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
668	Hilton San Francisco Union Square	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
669	Fairmont San Francisco	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
670	Palace Hotel, a Luxury Collection Hotel, San Francisco	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
671	Hilton San Francisco Financial District	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
672	The Park Central San Francisco	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
673	Grand Hyatt San Francisco	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
674	W San Francisco	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
675	Union Square	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
676	St Francis Hotel Spa	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
677	Clock Bar	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
678	Millennium Tower San Francisco	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
679	Clay Park Tower Apartments	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
680	Trinity Towers Apartments	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
681	Sutro Tower	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
682	Transamerica Pyramid	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
683	Clocktower Lofts Owners Association	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
684	Doubletree by Hilton	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
685	Coit Tower	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
686	399 Fremont	ChIJ0x_HRXqAhYAROhkrk7dEktA	63
687	LUMINA Sales Gallery	ChIJQcMG82KAhYARiGlS-9UmRug	64
688	LUMINA	ChIJQcMG82KAhYARiGlS-9UmRug	64
689	Lend Lease Lumina Project	ChIJQcMG82KAhYARiGlS-9UmRug	64
690	Astro Gaming	ChIJSf2W2NV_j4ARM96mFCVSQmY	65
691	Waterfall	ChIJSf2W2NV_j4ARM96mFCVSQmY	65
692	Layer	ChIJSf2W2NV_j4ARM96mFCVSQmY	65
693	Yes to Inc	ChIJSf2W2NV_j4ARM96mFCVSQmY	65
694	Prime Loan Advisors	ChIJSf2W2NV_j4ARM96mFCVSQmY	65
695	UCSF OB GYN at Mission Bay - Owens Street	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
696	Goodwill Industries	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
697	City Park	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
698	UCSF Orthopaedic Institute	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
699	UCSF Mission Bay	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
700	UCSF Orthotic & Prosthetic	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
701	Oda Restaurant	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
702	Goodwill	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
703	Salvation Army Drop Off Location	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
704	Goodwill	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
705	Industrial Growth Partners	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
706	Goodwill Donation Only	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
707	Goodwill Drop–Off	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
708	UCSF Sports Medicine Center	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
709	Owens Street Garage - UCSF Medical Center at Mission Bay	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
710	Salvation Army Family Store	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
711	Related California	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
712	UCSF Physical Therapy Clinic	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
713	Salvation Army Rehab Center	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
714	UCSF Multiple Sclerosis Center	ChIJRXIt4VmHhYARiAUdGYzMtH8	66
715	Van Ness Market	ChIJ32e72JmAhYAR34bUQ0lALK8	67
716	K-One Fitness	ChIJ32e72JmAhYAR34bUQ0lALK8	67
717	100 Van Ness	ChIJ32e72JmAhYAR34bUQ0lALK8	67
718	Market St & South Van Ness Ave	ChIJ32e72JmAhYAR34bUQ0lALK8	67
719	1000 Van Ness	ChIJ32e72JmAhYAR34bUQ0lALK8	67
720	AMC Van Ness 14	ChIJ32e72JmAhYAR34bUQ0lALK8	67
721	24 Hour Fitness Sport	ChIJ32e72JmAhYAR34bUQ0lALK8	67
722	Sperry Van Ness	ChIJ32e72JmAhYAR34bUQ0lALK8	67
723	Sperry Van Ness Commercial Real Estate	ChIJ32e72JmAhYAR34bUQ0lALK8	67
724	Sperry Van Ness | SV Advisors	ChIJ32e72JmAhYAR34bUQ0lALK8	67
725	Public Storage	ChIJ32e72JmAhYAR34bUQ0lALK8	67
726	First Republic Bank	ChIJ32e72JmAhYAR34bUQ0lALK8	67
727	San Francisco Department of Human Resources	ChIJ32e72JmAhYAR34bUQ0lALK8	67
728	Walgreens	ChIJ32e72JmAhYAR34bUQ0lALK8	67
729	South Van Ness Manor	ChIJ32e72JmAhYAR34bUQ0lALK8	67
730	Van Ness Family Dentistry	ChIJ32e72JmAhYAR34bUQ0lALK8	67
731	566 South Van Ness HOA	ChIJ32e72JmAhYAR34bUQ0lALK8	67
732	FedEx Office Print & Ship Center	ChIJ32e72JmAhYAR34bUQ0lALK8	67
733	McDonald's	ChIJ32e72JmAhYAR34bUQ0lALK8	67
734	Four Seasons Hotel San Francisco	ChIJmeYT26h_j4ARvlMsdFnLSfc	68
735	Four Seasons San Francisco Worldwide Sales Office	ChIJmeYT26h_j4ARvlMsdFnLSfc	68
736	Four Season Wedding	ChIJmeYT26h_j4ARvlMsdFnLSfc	68
737	One Maritime Plaza	ChIJKfK7UWCAhYARgjf4YNG9sps	69
738	4 Maritime Plaza	ChIJKfK7UWCAhYARgjf4YNG9sps	69
739	GCA Advisors, LLC	ChIJKfK7UWCAhYARgjf4YNG9sps	69
740	Cowen and Company	ChIJKfK7UWCAhYARgjf4YNG9sps	69
741	Qatalyst Partners LLP	ChIJKfK7UWCAhYARgjf4YNG9sps	69
742	Golden Gateway Garage	ChIJKfK7UWCAhYARgjf4YNG9sps	69
743	Pisces Foundation	ChIJKfK7UWCAhYARgjf4YNG9sps	69
744	Algert Global LLC	ChIJKfK7UWCAhYARgjf4YNG9sps	69
745	Pisces Inc	ChIJKfK7UWCAhYARgjf4YNG9sps	69
746	Le Petit Cafe	ChIJKfK7UWCAhYARgjf4YNG9sps	69
747	Farallon Capital Management, LLC	ChIJKfK7UWCAhYARgjf4YNG9sps	69
748	NEMA - San Francisco Luxury Apartments	ChIJX2OhS5yAhYARRNDSSRq_wLk	70
749	NEMA Parking Lot	ChIJX2OhS5yAhYARRNDSSRq_wLk	70
750	Bank of America Financial Center	ChIJK51QnmKAhYARarFwAjNf74w	71
751	Bank of America ATM	ChIJK51QnmKAhYARarFwAjNf74w	71
752	Insight Global	ChIJK51QnmKAhYARarFwAjNf74w	71
753	Learn IT	ChIJK51QnmKAhYARarFwAjNf74w	71
754	GLB 33 New Montgomery LP	ChIJK51QnmKAhYARarFwAjNf74w	71
755	Workbridge Associates	ChIJK51QnmKAhYARarFwAjNf74w	71
756	Jobspring Partners	ChIJK51QnmKAhYARarFwAjNf74w	71
757	Selman Breitman LLP	ChIJK51QnmKAhYARarFwAjNf74w	71
758	Bre New Montgomery LLC	ChIJK51QnmKAhYARarFwAjNf74w	71
759	ReTargeter	ChIJK51QnmKAhYARarFwAjNf74w	71
760	Shen Milsom & Wilke LLC	ChIJK51QnmKAhYARarFwAjNf74w	71
761	Starwood Global Sales Office	ChIJK51QnmKAhYARarFwAjNf74w	71
762	Adknowledge - San Francisco	ChIJK51QnmKAhYARarFwAjNf74w	71
763	Ten Group	ChIJK51QnmKAhYARarFwAjNf74w	71
764	Lifewatch Services	ChIJK51QnmKAhYARarFwAjNf74w	71
765	U.S. Customs and Border Protection	ChIJK51QnmKAhYARarFwAjNf74w	71
766	Skane Wilcox	ChIJK51QnmKAhYARarFwAjNf74w	71
767	Starboard TCN Worldwide Commercial Real Estate	ChIJK51QnmKAhYARarFwAjNf74w	71
768	Black Letter Discovery	ChIJK51QnmKAhYARarFwAjNf74w	71
769	AnyPerk	ChIJK51QnmKAhYARarFwAjNf74w	71
770	Temporary Transbay Terminal	ChIJMbi8O4GAhYAR6uFHOxDNwqU	72
771	Hines	ChIJMbi8O4GAhYAR6uFHOxDNwqU	72
772	MFLA. Marta Fry Landscape Associates	ChIJMbi8O4GAhYAR6uFHOxDNwqU	72
773	WeWork Transbay	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
774	One Medical Group	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
775	The Ottinger Firm, P.C.	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
776	LaSalle Network	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
777	TriNet Group, Inc	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
778	HackerOne	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
779	Talkdesk	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
780	MENO design	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
781	Appthority	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
782	Pacifica Digital	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
783	Citrine Capital	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
784	Shearman & Sterling LLP	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
785	Alvis Quashnock and Associates A Professional Law Corporation	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
786	NEO Law Group	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
787	Purpose Generation	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
788	TalentX	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
789	Librato, Inc.	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
790	Kindred Partners LLC	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
791	CSTMR	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
792	Bitmatica	ChIJAcgLdmKAhYARaX0N2BPH_ZM	73
793	Shell Building Barber Shop	ChIJn02xaWKAhYARHCE_EkyV1eY	74
794	Brothers International Corp	ChIJn02xaWKAhYARHCE_EkyV1eY	74
795	Shell	ChIJn02xaWKAhYARHCE_EkyV1eY	74
796	Shell	ChIJn02xaWKAhYARHCE_EkyV1eY	74
797	Performance Shell	ChIJn02xaWKAhYARHCE_EkyV1eY	74
798	Shell	ChIJn02xaWKAhYARHCE_EkyV1eY	74
799	Shell	ChIJn02xaWKAhYARHCE_EkyV1eY	74
800	Shell	ChIJn02xaWKAhYARHCE_EkyV1eY	74
801	Shell	ChIJn02xaWKAhYARHCE_EkyV1eY	74
802	Mills Building	ChIJn02xaWKAhYARHCE_EkyV1eY	74
803	San Francisco Department of Building Inspection	ChIJn02xaWKAhYARHCE_EkyV1eY	74
804	555 California Street Building	ChIJn02xaWKAhYARHCE_EkyV1eY	74
805	Project Frog, Inc	ChIJn02xaWKAhYARHCE_EkyV1eY	74
806	Transamerica Pyramid	ChIJn02xaWKAhYARHCE_EkyV1eY	74
807	Blue Shell Games	ChIJn02xaWKAhYARHCE_EkyV1eY	74
808	Phillip Burton Federal Building	ChIJn02xaWKAhYARHCE_EkyV1eY	74
809	San Francisco Federal Building	ChIJn02xaWKAhYARHCE_EkyV1eY	74
810	425 Market Street Building	ChIJn02xaWKAhYARHCE_EkyV1eY	74
811	600 Townsend	ChIJn02xaWKAhYARHCE_EkyV1eY	74
812	One Bush Plaza	ChIJn02xaWKAhYARHCE_EkyV1eY	74
813	Kwan Henmi Architecture Planning Inc.	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
814	Equity Risk Partners Inc	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
815	Consulate General of Israel	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
816	Financial District Barbershop	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
817	Grace Image Photography Studio	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
818	Consulate General of Switzerland in San Francisco	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
819	Marc Harrison Lai, DDS	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
820	Beveridge & Diamond: Smith Gary J	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
821	Beveridge & Diamond, P.C.	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
822	International Emissions Trading Association	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
823	Montgomery Land Inc	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
824	Scott Price & Co	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
825	Moza Easy Shop	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
826	Righetti Glugoski, P.C.	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
827	Yee Catherine	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
828	Vogl & Meredith: Meredith Samuel E	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
829	Cardionet Inc	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
830	Hersh Family Law Practice	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
831	Vogl & Meredith	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
832	Sonen Capital	ChIJ-XWCEvWAhYAR94cJ0Nf_6Gc	75
833	Raven Office Centers	ChIJa-JlzmOAhYART1ULF2xUwwk	76
834	Market Street Chiropractic	ChIJa-JlzmOAhYART1ULF2xUwwk	76
835	Dr. Ivan D. Melean, DC QME	ChIJa-JlzmOAhYART1ULF2xUwwk	76
836	Dunhill Partners West	ChIJa-JlzmOAhYART1ULF2xUwwk	76
837	Dr. Diane Michael DC QME	ChIJa-JlzmOAhYART1ULF2xUwwk	76
838	Subway	ChIJa-JlzmOAhYART1ULF2xUwwk	76
839	Miss Tomato Sandwich Shop	ChIJa-JlzmOAhYART1ULF2xUwwk	76
840	First Republic Bank	ChIJa-JlzmOAhYART1ULF2xUwwk	76
841	Lasertorium Printer - Copier - Scanner Repair	ChIJa-JlzmOAhYART1ULF2xUwwk	76
842	Jack's Shoe Services	ChIJa-JlzmOAhYART1ULF2xUwwk	76
843	Sushirrito - FIDI Market	ChIJa-JlzmOAhYART1ULF2xUwwk	76
844	San Francisco Immigration Attorney - Reeves & Associates	ChIJa-JlzmOAhYART1ULF2xUwwk	76
845	Allied Offices	ChIJa-JlzmOAhYART1ULF2xUwwk	76
846	Davinci Meeting Rooms	ChIJa-JlzmOAhYART1ULF2xUwwk	76
847	Davinci Virtual Office Solutions	ChIJa-JlzmOAhYART1ULF2xUwwk	76
848	Layfield & Barrett	ChIJa-JlzmOAhYART1ULF2xUwwk	76
849	Law Offices of Nate Kelly	ChIJa-JlzmOAhYART1ULF2xUwwk	76
850	P M Realty Group	ChIJa-JlzmOAhYART1ULF2xUwwk	76
851	Wilshire Law Firm	ChIJa-JlzmOAhYART1ULF2xUwwk	76
852	Air Worldwide	ChIJa-JlzmOAhYART1ULF2xUwwk	76
853	The Park Central San Francisco	ChIJi1J5_0ojh1QRSEAyfPSzO94	77
854	The Westin St. Francis San Francisco on Union Square	ChIJi1J5_0ojh1QRSEAyfPSzO94	77
855	Tishman Speyer	ChIJLQnXC3iAhYARAQt74KhME-I	78
856	Crêperie Saint-Germain	ChIJLQnXC3iAhYARAQt74KhME-I	78
857	Equator Coffees & Teas	ChIJLQnXC3iAhYARAQt74KhME-I	78
858	Heller Manus Architects	ChIJLQnXC3iAhYARAQt74KhME-I	78
859	Linkedin	ChIJLQnXC3iAhYARAQt74KhME-I	78
860	222 Front Street Building	ChIJLQnXC3iAhYARAQt74KhME-I	78
861	Montgomery St. Station	ChIJLQnXC3iAhYARAQt74KhME-I	78
862	ABM Parking Services	ChIJLQnXC3iAhYARAQt74KhME-I	78
863	Zayo Group	ChIJLQnXC3iAhYARAQt74KhME-I	78
864	24 Hour Fitness Sport	ChIJLQnXC3iAhYARAQt74KhME-I	78
865	Courtyard San Francisco Downtown	ChIJLQnXC3iAhYARAQt74KhME-I	78
866	WeWork California Street	ChIJLQnXC3iAhYARAQt74KhME-I	78
867	Andersen Bakery	ChIJLQnXC3iAhYARAQt74KhME-I	78
868	UBM Tech	ChIJLQnXC3iAhYARAQt74KhME-I	78
869	Starbucks	ChIJLQnXC3iAhYARAQt74KhME-I	78
870	San Francisco Planning Department	ChIJLQnXC3iAhYARAQt74KhME-I	78
871	RadiumOne	ChIJLQnXC3iAhYARAQt74KhME-I	78
872	WeWork Soma	ChIJLQnXC3iAhYARAQt74KhME-I	78
873	Juice Shop	ChIJLQnXC3iAhYARAQt74KhME-I	78
874	Priority Parking	ChIJLQnXC3iAhYARAQt74KhME-I	78
875	Hilton San Francisco Financial District	ChIJJVZ2NoiAhYARslurdlyxrvM	29
876	Hilton San Francisco Union Square	ChIJJVZ2NoiAhYARslurdlyxrvM	29
877	Parc 55 San Francisco - A Hilton Hotel	ChIJJVZ2NoiAhYARslurdlyxrvM	29
878	750 Restaurant & Bar	ChIJJVZ2NoiAhYARslurdlyxrvM	29
879	Omni San Francisco Hotel	ChIJJVZ2NoiAhYARslurdlyxrvM	29
880	Drumm St & California St	ChIJJVZ2NoiAhYARslurdlyxrvM	29
881	Club Quarters Hotel in San Francisco	ChIJJVZ2NoiAhYARslurdlyxrvM	29
882	Bay Club Financial District	ChIJJVZ2NoiAhYARslurdlyxrvM	29
883	Doubletree by Hilton	ChIJJVZ2NoiAhYARslurdlyxrvM	29
884	Starbucks	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
885	Fremont Group	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
886	City Park	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
887	Aon Hewitt	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
888	Aon Risk Services Inc	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
889	Fremont Public Opportunities	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
890	StubHub	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
891	Leong Dental: Leong Waymond DDS	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
892	Russell's Convenience	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
893	Apollo Education Group Inc	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
894	Jackson Lewis: Boomer Mitchell F	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
895	Jackson Lewis: Brooks Joanna L	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
896	Aon Consulting	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
897	Jackson Lewis: Maylin Kathleen	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
898	Aon Risk Services Inc: Ing-Firmeza Annette	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
899	Jackson Lewis: Allen Jamerson C	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
900	Jackson Lewis: Mullin Patrick C	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
901	Folger Levin LLP	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
902	Leland, Parachini, Steinberg, Matzger & Melnick, LLP	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
903	S. D. Bechtel, Jr. Foundation	ChIJOfSsu2SAhYARhNRWAPKs5o0	80
904	Vector Capital	ChIJ2d6zHWSAhYAReacyIjXUKhU	81
905	RPX Corporation	ChIJ2d6zHWSAhYAReacyIjXUKhU	81
906	One Market Restaurant	ChIJ2d6zHWSAhYAReacyIjXUKhU	81
907	Tucker Ellis LLP	ChIJ2d6zHWSAhYAReacyIjXUKhU	81
908	Duane Morris: Matthews Philip R	ChIJ2d6zHWSAhYAReacyIjXUKhU	81
909	One Market Street	ChIJ2d6zHWSAhYAReacyIjXUKhU	81
910	One Market Garage	ChIJ2d6zHWSAhYAReacyIjXUKhU	81
911	Albertson & Davidson, LLP	ChIJ2d6zHWSAhYAReacyIjXUKhU	81
912	Citi Ventures	ChIJ2d6zHWSAhYAReacyIjXUKhU	81
913	CoveredCo	ChIJ2d6zHWSAhYAReacyIjXUKhU	81
914	Ardian USA San Francisco	ChIJ2d6zHWSAhYAReacyIjXUKhU	81
915	Bradley & Co LLC	ChIJ2d6zHWSAhYAReacyIjXUKhU	81
916	Passport Capital LLC	ChIJ2d6zHWSAhYAReacyIjXUKhU	81
917	Autodesk Gallery	ChIJ2d6zHWSAhYAReacyIjXUKhU	81
918	SAP America Inc. - San Francisco	ChIJ2d6zHWSAhYAReacyIjXUKhU	81
919	MailUp	ChIJ2d6zHWSAhYAReacyIjXUKhU	81
920	Law Firm	ChIJ2d6zHWSAhYAReacyIjXUKhU	81
921	Cahill Contractor's, Inc.	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
922	Merlone Geier Partners	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
923	Bryan Hinshaw, A Professional Corporation	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
924	International Aids Society USA	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
925	Metabiota	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
926	Kaufman Dolowich & Voluck LLP (San Francisco)	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
927	Joseph Pedott Advertising Agency	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
928	Friedman Mc Cubbin Spalding: Montgomery George	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
929	Joseph Enterprises, Inc	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
930	Bryan Hinshaw	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
931	Hennefer Finley & Wood: Wood Joseph	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
932	Friedman Mc Cubbin Spalding	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
933	Jarman Travel Inc	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
934	Walsh Carter & Associates	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
935	Epstein Englert Staley Coffey: Staley Robert H	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
936	Mc Laughlin Michele A CPA	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
937	Worth Thomas	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
938	Derek T Knudsen Law Offices	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
939	Diana M. Hastings	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
940	425 Market Street Building	ChIJc5SPsWOAhYARY9kqZIk2HUo	82
941	Digital Dental Practice: Maryam Tabar, DDS	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
942	San Francisco Immigration Court	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
943	Starbucks	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
944	Enovity	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
945	EC San Francisco	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
946	The OutCast Agency	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
947	Text100 San Francisco	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
948	Summer Street Research Partnership	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
949	Ageless Men's Health	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
950	HelioPower, Inc.	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
951	Starbucks	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
952	RINA accountancy corporation	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
953	RINA Accountancy Corporation: Chiquette Cecile CPA	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
954	Transatlantic Reinsurance Co	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
955	U.S. Bank	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
956	Epsilon	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
957	Hines	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
958	Solution Set	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
959	Law Offices of John F. Vannucci	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
960	The Blueshirt Group	ChIJU4sjZ4qAhYARJtYFPbhkNv4	83
961	Grand Hyatt San Francisco	ChIJv01Os46AhYARqB1bbRrTMaY	84
962	Grand Hyatt Valet Parking	ChIJv01Os46AhYARqB1bbRrTMaY	84
963	Hyatt Regency San Francisco	ChIJv01Os46AhYARqB1bbRrTMaY	84
964	Coffee Bar	ChIJv01Os46AhYARqB1bbRrTMaY	84
965	hyatt	ChIJv01Os46AhYARqB1bbRrTMaY	84
966	OneUP Restaurant and Lounge	ChIJv01Os46AhYARqB1bbRrTMaY	84
967	Union Square	ChIJv01Os46AhYARqB1bbRrTMaY	84
968	Grandviews Restaurant	ChIJv01Os46AhYARqB1bbRrTMaY	84
969	ABM Parking Services	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
970	Moss Adams LLP	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
971	Genesys Works	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
972	Reed Smith LLP	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
973	King & Spalding LLP	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
974	HFF	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
975	Nexant Inc	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
976	Clyde and Co US LLP	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
977	Reed Smith LLP	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
978	Roy's	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
979	Reed Smith Llp: Fogel Paul D	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
980	Reed Smith LLP: Johnson Doyle	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
981	New Relic	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
982	Rowbotham & Company LLP	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
983	California Appellate Project	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
984	Anaplan	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
985	Cardno ChemRisk	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
986	Myers Development Co	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
987	Kris Dunning, CPA	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
988	PRJ Holdings	ChIJsRZCy2KAhYAR_B2MsljZNtU	85
989	Fox Plaza Apartments	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
990	Fox Plaza Apartments	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
991	Essex Fox Plaza	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
992	Fox Plaza Garage	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
993	City Park	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
994	Fox Plaza Security Guard Station	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
995	API Fox Plaza LLC	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
996	Andersen Bakery	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
997	Starbucks	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
998	Marin Day Schools	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
999	Fox Rothschild LLP	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
1000	Amazon Locker - Fox	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
1001	Landmark Theaters	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
1002	Civic Center Plaza	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
1003	US Post Office	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
1004	Fox LSAT	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
1005	The Crafty Fox Ale House	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
1006	Gene McCoy, DDS	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
1007	Fox Plaza Deli	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
1008	United States Post Office	ChIJgZ8LM4-AhYARYxs7AW3U63Q	86
1009	Regus San Francisco	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1010	San Francisco Soup Company	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1011	Ace Parking	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1012	Oppenheimer & Co Inc	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1013	The Northern Trust Company	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1014	Blurb Inc	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1015	Consulate General of Canada	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1016	Freedman Law Firm	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1017	Compass Analytics, LLC	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1018	Recommind Inc	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1019	Osborne Partners Capital Management, LLC	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1020	Akin Gump Strauss Hauer & Feld LLP	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1021	Sarah J Kristmann Law Offices	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1022	Accolade Management	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1023	Law Office of Melissa D. Polk, P.C.	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1024	Elmhurst Immigration Law	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1025	The Law Offices of Benson C. Lai, P.C.	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1026	Strategic Staffing Solutions	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1027	WineGavel	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1028	Pine River Capital Management	ChIJdQnsUoqAhYAR5Q0J1OIKsZo	87
1029	Illumina	ChIJE-Ngz3qAhYARtYD71r2XTg4	88
1030	LUMINA	ChIJE-Ngz3qAhYARtYD71r2XTg4	88
1031	LUMINA Sales Gallery	ChIJE-Ngz3qAhYARtYD71r2XTg4	88
1032	The Infinity Towers	ChIJrynH24iAhYARkdrJvXrCxUI	89
1033	Infinite Martial Arts	ChIJrynH24iAhYARkdrJvXrCxUI	89
1034	Infinite S.F.	ChIJrynH24iAhYARkdrJvXrCxUI	89
1035	Infinite Beauty	ChIJrynH24iAhYARkdrJvXrCxUI	89
1036	Parc 55 San Francisco - A Hilton Hotel	ChIJlzWFioWAhYARuV6Mj92GWJs	90
1037	Kin Khao	ChIJlzWFioWAhYARuV6Mj92GWJs	90
1038	FedEx Office Print & Ship Center	ChIJlzWFioWAhYARuV6Mj92GWJs	90
1039	Barbary Coast Pastry and Coffee	ChIJlzWFioWAhYARuV6Mj92GWJs	90
1040	Hotel Union Square	ChIJlzWFioWAhYARuV6Mj92GWJs	90
1041	Wyndham Canterbury at San Francisco	ChIJlzWFioWAhYARuV6Mj92GWJs	90
1042	EZ Public Parking	ChIJlzWFioWAhYARuV6Mj92GWJs	90
1043	Museum Parc	ChIJlzWFioWAhYARuV6Mj92GWJs	90
1044	farmerbrown	ChIJlzWFioWAhYARuV6Mj92GWJs	90
1045	Peletz & Co Inc	ChIJlzWFioWAhYARuV6Mj92GWJs	90
1046	Cityhouse	ChIJlzWFioWAhYARuV6Mj92GWJs	90
1047	San Francisco Planning Department	ChIJWQ0_pCB-j4ARHPE0XCT02Mg	91
1048	T R 601 California Corporation	ChIJjc-4touAhYARcwiC44cqtvc	92
1049	Fisher Development, Inc.	ChIJjc-4touAhYARcwiC44cqtvc	92
1050	Bledsoe Cathcart Diestel: Van Zandt Peter J	ChIJjc-4touAhYARcwiC44cqtvc	92
1051	Weiss & Weissman	ChIJjc-4touAhYARcwiC44cqtvc	92
1052	Bledsoe, Cathcart, Diestel, Pedersen & Treppa, LLP	ChIJjc-4touAhYARcwiC44cqtvc	92
1053	Bledsoe Cathcart Diestel: Crane Allison M	ChIJjc-4touAhYARcwiC44cqtvc	92
1054	Bledsoe Cathcart Diestel: Que Ester C	ChIJjc-4touAhYARcwiC44cqtvc	92
1055	Bledsoe Cathcart Diestel: Pedersen L Jay	ChIJjc-4touAhYARcwiC44cqtvc	92
1056	Old Republic Title	ChIJjc-4touAhYARcwiC44cqtvc	92
1057	Fidelity National Title	ChIJjc-4touAhYARcwiC44cqtvc	92
1058	Phacil, Inc	ChIJjc-4touAhYARcwiC44cqtvc	92
1059	Ware Malcomb | San Francisco	ChIJjc-4touAhYARcwiC44cqtvc	92
1060	Alaska National Insurance	ChIJjc-4touAhYARcwiC44cqtvc	92
1061	Avison Young	ChIJjc-4touAhYARcwiC44cqtvc	92
1062	Traver Walter J	ChIJjc-4touAhYARcwiC44cqtvc	92
1063	Chong Hing Bank Ltd	ChIJjc-4touAhYARcwiC44cqtvc	92
1064	Eloqua Corporation	ChIJjc-4touAhYARcwiC44cqtvc	92
1065	Cogent Valuation	ChIJjc-4touAhYARcwiC44cqtvc	92
1066	Hines	ChIJjc-4touAhYARcwiC44cqtvc	92
1067	Yingli Green Energy Americas	ChIJjc-4touAhYARcwiC44cqtvc	92
1068	Hilton San Francisco Union Square	ChIJJVZ2NoiAhYARslurdlyxrvM	29
1069	Hilton San Francisco Financial District	ChIJJVZ2NoiAhYARslurdlyxrvM	29
1070	Grand Hyatt San Francisco	ChIJJVZ2NoiAhYARslurdlyxrvM	29
1071	The Westin St. Francis San Francisco on Union Square	ChIJJVZ2NoiAhYARslurdlyxrvM	29
1072	Parc 55 San Francisco - A Hilton Hotel	ChIJJVZ2NoiAhYARslurdlyxrvM	29
1073	One Rincon Hill	ChIJJVZ2NoiAhYARslurdlyxrvM	29
1074	The Infinity Towers	ChIJJVZ2NoiAhYARslurdlyxrvM	29
1075	JW Marriott San Francisco Union Square	ChIJJVZ2NoiAhYARslurdlyxrvM	29
1076	Union Square	ChIJJVZ2NoiAhYARslurdlyxrvM	29
1077	Coit Tower	ChIJJVZ2NoiAhYARslurdlyxrvM	29
1078	Doubletree by Hilton	ChIJJVZ2NoiAhYARslurdlyxrvM	29
1079	450 Sutter Building	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1080	450 Sutter Garage	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1081	450 Sutter Pharmacy	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1082	David J Mac Gregor Inc	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1083	San Francisco Surgery Center	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1084	San Francisco Women's Health: Chun Stephanie N MD	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1085	Quest Diagnostics San Francisco - Sutter	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1086	San Francisco Women's Health	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1087	Lambert J. Stumpel, DDS	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1088	Sutter Street Cafe	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1089	C Dental X-Ray	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1090	OrthoWorks Orthodontic Group	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1091	Sutter Dental	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1092	Union Square Dermatology	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1093	Barry Kevin R DDS	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1094	San Francisco Otolaryngology	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1095	Downtown Medical	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1096	Ehsan David DDS	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1097	Medical Marijuana Physician Evaluations	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1098	Dr. Lucia R. Tuffanelli, MD	ChIJqRhcpY6AhYARNFQEwBYAJZM	94
1099	Modis	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1100	Babson San Francisco	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1101	MGA Healthcare Staffing - San Francisco	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1102	Rnm Properties	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1103	DZH Phillips	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1104	Special Counsel	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1105	KIPP Foundation	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1106	Catapult Advisors LLC	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1107	EPIC Insurance Brokers and Consultants	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1108	Thornton Tomasetti: Gaddini Stacy	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1109	Interface Engineering Inc	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1110	KIPP Foundation Office	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1111	Thornton Tomasetti: Cardellini Michael	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1112	First Solar Inc	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1113	Antenna	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1114	Liebert Cassidy Whitmore	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1115	KLH & Associates	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1116	Timothy Nott CPA	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1117	Hewins Financial Advisors, LLC	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1118	Walker Parking Consultants	ChIJ9bxa82SAhYAR9roiR4CNnuk	95
1119	Regus San Francisco	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1120	Lending Club	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1121	Central Parking	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1122	ClearScale	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1123	Bare Escentuals Inc	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1124	Law Office of Claudia Choy	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1125	DAE Advertising	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1126	Block Advisors	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1127	Law Offices of Helen Santana	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1128	Dannis Woliver Kelley	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1129	SEBA International	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1130	American Cancer Society	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1131	Jerry Burleson, Shareholder Rights Attorney	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1132	AsTech Consulting	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1133	MEA Forensic Engineers & Scientists - San Francisco	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1134	Juniper Tutors	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1135	Leader's Institute San Francisco	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1136	Black Stone IP, LLC	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1137	Haight Brown & Bonesteel: Nguyen Cindy	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1138	Haight Brown & Bonesteel: Klemens Paula A	ChIJQcMG82KAhYARuIEZJSMaGE4	96
1139	Bridgeview Owners Association	ChIJmVeqb_WAhYARMcQ6BEg4HGM	97
1140	BridgeView CFO	ChIJmVeqb_WAhYARMcQ6BEg4HGM	97
1141	Bridge View Funding Inc	ChIJmVeqb_WAhYARMcQ6BEg4HGM	97
1142	Hines 55 Second Street LP	ChIJy8P2womAhYARD8xRTe21iFc	98
1143	KPMG	ChIJy8P2womAhYARD8xRTe21iFc	98
1144	ABM Parking Services	ChIJy8P2womAhYARD8xRTe21iFc	98
1145	Pacific Loan Company	ChIJy8P2womAhYARD8xRTe21iFc	98
1146	501 Second Street Associates	ChIJy8P2womAhYARD8xRTe21iFc	98
1147	Sutter Health's care center	ChIJy8P2womAhYARD8xRTe21iFc	98
1148	The Playroom at Hotel Zetta	ChIJy8P2womAhYARD8xRTe21iFc	98
1149	Paul Hastings	ChIJy8P2womAhYARD8xRTe21iFc	98
1150	400 Second Street Building Office	ChIJy8P2womAhYARD8xRTe21iFc	98
1151	70 Second Street Medical Cannabis Dispensary	ChIJy8P2womAhYARD8xRTe21iFc	98
1152	KPMG LLP	ChIJy8P2womAhYARD8xRTe21iFc	98
1153	Royal Towers Apartments	ChIJ29GRie-AhYAR4W50rG_xcLA	99
1154	Crystal Tower Apartments	ChIJ29GRie-AhYAR4W50rG_xcLA	99
1155	City National Bank Private Client	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1156	Schlesinger	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1157	Blackstone Technology Group	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1158	Microdesk, Inc.	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1159	Savills Studley	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1160	Wells Fargo Advisors	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1161	Glumac	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1162	Pachulski Stang Ziehl Young: Fried Joshua M	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1163	Pachulski Stang Ziehl Jones: Bertenthal David M	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1164	City National Bank Banking Office	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1165	Pachulski Stang Ziehl Young: Fiero John D	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1166	Pachulski Stang Ziehl & Jones LLP	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1167	BKF Engineers	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1168	Forbes Norris MDA/ALS Research & Treatment Ctr: California Pacific Med Center	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1169	150 Otis St	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1170	Sutter Street Station Postal Retail Store - Passport	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1171	St. Anthony Foundation	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1172	St. Anthony Foundation	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1173	Capital Access Group	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1174	Vista Equity Partners	ChIJWz0hEET3MhURSO_o7ni5jjo	100
1175	San Francisco Marriott Union Square	ChIJrbjkZo6AhYARZpLDu1Jr2A8	101
1176	JW Marriott San Francisco Union Square	ChIJrbjkZo6AhYARZpLDu1Jr2A8	101
1177	Bechtel Group Inc	ChIJK5Rpz39hmoARKjcL9JTUw2E	2
1178	Building Owners & Managers	ChIJK5Rpz39hmoARKjcL9JTUw2E	2
1179	555 California Street Building	ChIJK5Rpz39hmoARKjcL9JTUw2E	2
1180	425 Market Street Building	ChIJK5Rpz39hmoARKjcL9JTUw2E	2
1181	S. D. Bechtel, Jr. Foundation	ChIJK5Rpz39hmoARKjcL9JTUw2E	2
1182	50 Fremont Center	ChIJK5Rpz39hmoARKjcL9JTUw2E	2
1183	Transamerica Pyramid	ChIJK5Rpz39hmoARKjcL9JTUw2E	2
1184	Millennium Tower San Francisco	ChIJK5Rpz39hmoARKjcL9JTUw2E	2
1185	One Montgomery Tower	ChIJK5Rpz39hmoARKjcL9JTUw2E	2
1186	Target	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1187	ProPark	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1188	Coffee Cultures	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1189	CKGS Visa Application Center San Francisco	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1190	India Passport Application Center San Francisco	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1191	General Assembly San Francisco	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1192	CVS Pharmacy	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1193	Benefit Cosmetics HQ	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1194	Meltwater Group	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1195	Ricoh USA	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1196	JVS	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1197	TinyCo, Inc.	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1198	Lithium Technologies	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1199	Flynn Properties	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1200	RocketSpace Inc	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1201	Flynn Restaurant Group	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1202	Nitro PDF	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1203	Klout	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1204	LiveRamp	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1205	Affirm, Inc.	ChIJy-vcCmKAhYARyWyFCn3VDpc	103
1206	Fairmont San Francisco	ChIJC5AJa42AhYAR6Bj5sZHPrUY	104
1207	Mr. Eckhard's Salon	ChIJC5AJa42AhYAR6Bj5sZHPrUY	104
1208	Fairmont Hotel-Beauty Salon	ChIJC5AJa42AhYAR6Bj5sZHPrUY	104
1209	Fairmont Parking Garage	ChIJC5AJa42AhYAR6Bj5sZHPrUY	104
1210	Hotel fairmont	ChIJC5AJa42AhYAR6Bj5sZHPrUY	104
1211	Laurel Court Restaurant & Bar	ChIJC5AJa42AhYAR6Bj5sZHPrUY	104
1212	Tonga Room & Hurricane Bar	ChIJC5AJa42AhYAR6Bj5sZHPrUY	104
1213	The UPS Store	ChIJC5AJa42AhYAR6Bj5sZHPrUY	104
1214	Charisma Crafts	ChIJC5AJa42AhYAR6Bj5sZHPrUY	104
1215	Hertz Rent A Car	ChIJC5AJa42AhYAR6Bj5sZHPrUY	104
1216	Caffe Cento	ChIJC5AJa42AhYAR6Bj5sZHPrUY	104
1217	Intercontinental Mark Hopkins San Francisco	ChIJC5AJa42AhYAR6Bj5sZHPrUY	104
1218	Ornamento	ChIJC5AJa42AhYAR6Bj5sZHPrUY	104
1219	Active Sports Clubs	ChIJC5AJa42AhYAR6Bj5sZHPrUY	104
1220	Pacific-Union Club	ChIJC5AJa42AhYAR6Bj5sZHPrUY	104
1221	Standard Parking	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1222	Diplomatic Security's San Francisco Field Office	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1223	US Bankruptcy Court	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1224	Sharp Partners P.A.	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1225	Development Specialists Inc	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1226	LHH	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1227	Macquarie Capital	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1228	AlvaradoSmith, a Professional Corporation	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1229	Polytech Associates Inc	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1230	Loren M. Lopin, Attorney, Trusts & Estates P.C.	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1231	Cooper & Scully. P.C.	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1232	Bullivant Houser & Bailey	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1233	Lippenber Thompson Welch	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1234	Us Trustee	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1235	Collette Erickson Farmer	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1236	M C Venture Partners	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1237	James W. R Hastings	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1238	Hornstein Law Offices	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1239	Sprim Advanced Life Sciences	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1240	Collette Erickson Farmer: Cohen Kenneth J	ChIJSX-BHmKAhYAR_EaBDNDlsPI	105
1241	Hunter-Dulin Building	ChIJKfw7pI6AhYARR1XIebuVhgU	106
1242	450 Sutter Building	ChIJKfw7pI6AhYARR1XIebuVhgU	106
1243	GNC	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1244	GNC	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1245	GNC	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1246	GNC	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1247	GNC	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1248	Levi's Plaza	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1249	Travelodge San Francisco Central	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1250	SFMTA Central Subway Project Office	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1251	Central Parking	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1252	Central Parking System	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1253	Landmark Theaters	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1254	The Park Central San Francisco	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1255	Market Central	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1256	Plaza Research	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1257	Copy Central	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1258	Copy Central	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1259	Radioshack Mobile	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1260	Hertz Rent A Car	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1261	Central Parking System	ChIJG0BIhWGAhYARR22Le0TVKfY	107
1262	W San Francisco	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1263	Trace	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1264	UPSTAIRS Bar	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1265	Grace Cathedral	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1266	Bliss San Francisco	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1267	Duane Morris: Moppin Timothy W	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1268	Duane Morris LLP Guy W Chambers	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1269	J & W Market	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1270	Wilson Elser Moskowitz Edelman: Johnson Martin W	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1271	Duane Morris: Mc Tarnaghan James W	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1272	Duane Morris: Miller W Andrew	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1273	Dr. Clinton W. Young, MD	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1274	Dr. Michael W. Weiner, MD	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1275	B&W Service Center	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1276	Intercontinental San Francisco	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1277	Fang Restaurant	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1278	JW Marriott San Francisco Union Square	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1279	The St. Regis San Francisco	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1280	William Lee D.D.S.	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1281	Le Méridien San Francisco	ChIJcWfgM2CAhYARD19rCAPLhVU	108
1282	The Summit	ChIJnx0DmHiAhYARRIpKlJJxQfA	109
1283	Summit Furniture	ChIJnx0DmHiAhYARRIpKlJJxQfA	109
1284	Summit Funding, Inc.	ChIJnx0DmHiAhYARRIpKlJJxQfA	109
1285	Morsa Aziz - Summit Funding	ChIJnx0DmHiAhYARRIpKlJJxQfA	109
1286	Summit Defense Attorneys – San Francisco	ChIJnx0DmHiAhYARRIpKlJJxQfA	109
1287	The Kana	ChIJnx0DmHiAhYARRIpKlJJxQfA	109
1288	Summit Consulting Group LLC	ChIJnx0DmHiAhYARRIpKlJJxQfA	109
1289	Security Innovation Network LLC	ChIJnx0DmHiAhYARRIpKlJJxQfA	109
1290	The Summit SF	ChIJnx0DmHiAhYARRIpKlJJxQfA	109
1291	Summit Eating Disorders & Outreach Program	ChIJnx0DmHiAhYARRIpKlJJxQfA	109
1292	Kairos Society HQ	ChIJnx0DmHiAhYARRIpKlJJxQfA	109
1293	Sir Francis Drake, a Kimpton Hotel	ChIJk6jRv46AhYARbE6mIQ6VDsg	110
1294	Drake Hotel	ChIJk6jRv46AhYARbE6mIQ6VDsg	110
1295	The Starlight Room	ChIJk6jRv46AhYARbE6mIQ6VDsg	110
1296	Bar Drake	ChIJk6jRv46AhYARbE6mIQ6VDsg	110
1297	Scala's Bistro	ChIJk6jRv46AhYARbE6mIQ6VDsg	110
1298	Pacific Eagle Holdings	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1299	Bay Area Council Inc	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1300	Telava Wireless	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1301	Berry Appleman & Leiden: Leiden Warren R	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1302	Landmark Corporate Headquarters	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1303	Premier Staffing	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1304	Bal LLP	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1305	Berry Appleman & Leiden: Mao Nancy	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1306	Berry Appleman & Leiden LLP: Appleman Jeff T	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1307	SMCI Inc	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1308	Buck Consultants, A Xerox Company	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1309	Berry Appleman & Leiden: Tarazi Carla V	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1310	Mark Porter - Ameriprise Financial	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1311	Cox Reps	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1312	Oliver Choy - Ameriprise Financial	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1313	Berry Appleman & Leiden LLP: Drumm Larry L	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1314	Berry Appleman & Leiden: Ramsay La Verne	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1315	H&L Partners	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1316	Vernadette Antonio	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1317	Hoffman/Lewis	ChIJO3og3_mAhYARcFAaa0Zu2kY	111
1318	Hastings Tower	ChIJ0X_WV5qAhYARN-ZYTWDj2KY	112
1319	McAllister Tower	ChIJ0X_WV5qAhYARN-ZYTWDj2KY	112
1320	UC Hastings College of the Law	ChIJ0X_WV5qAhYARN-ZYTWDj2KY	112
1321	PG&E Pacific Energy Center	ChIJka2ABnt-j4AR71gZVOGofXw	30
1322	Pacific Gas and Electric Company	ChIJka2ABnt-j4AR71gZVOGofXw	30
1323	PG&E Corporation	ChIJka2ABnt-j4AR71gZVOGofXw	30
1324	Pacific Gas and Electric Company	ChIJka2ABnt-j4AR71gZVOGofXw	30
1325	Pacific Gas and Electric Company Customer Service Office	ChIJka2ABnt-j4AR71gZVOGofXw	30
1326	Pacific Gas & Electric Co	ChIJka2ABnt-j4AR71gZVOGofXw	30
1327	Pacific Gas and Electric Company	ChIJka2ABnt-j4AR71gZVOGofXw	30
1328	Pacific Gas and Electric Company	ChIJka2ABnt-j4AR71gZVOGofXw	30
1329	Pacific Gas and Electric Company	ChIJka2ABnt-j4AR71gZVOGofXw	30
1330	Pacific Gas & Electric Co	ChIJka2ABnt-j4AR71gZVOGofXw	30
1331	1190 Mission at Trinity Place	ChIJ12HgSoOAhYAREab6pIUCa90	57
1332	Solaire	ChIJY4PC02SAhYAR6ehorQSCczA	9
1333	Temporary Transbay Terminal	ChIJY4PC02SAhYAR6ehorQSCczA	9
1334	Central Tower Market	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1335	Central Tower Office Building	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1336	Central Towers Apartments	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1337	Mosser Towers	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1338	Kingdom Hall of Jehovah's Witnesses	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1339	Kingdom Hall of Jehovah's Witnesses	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1340	Kingdom Hall of Jehovah's Witnesses	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1341	San Francisco Towers	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1342	American Tower Corporation	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1343	American Tower Corporation	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1344	American Tower Corporation	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1345	Hilton San Francisco Union Square	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1346	Towers Watson	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1347	Millennium Tower San Francisco	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1348	One Montgomery Tower	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1349	Coit Tower	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1350	The Infinity Towers	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1351	The Park Central San Francisco	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1352	San Francisco Central Seventh-day Adventist Church	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1353	Sensor Tower	ChIJ_ydpJdd_j4ARtnHeczo2b4E	116
1354	Hobart Building Office	ChIJXy_Z1ImAhYARJGOdimh_r6Y	117
1355	Le Méridien San Francisco	ChIJWTGPjmaAhYARnYsfhjHT8JM	118
1356	Park Grill-Le Meridien	ChIJWTGPjmaAhYARnYsfhjHT8JM	118
1357	Bar 333	ChIJWTGPjmaAhYARnYsfhjHT8JM	118
1358	Meridian Management Group	ChIJWTGPjmaAhYARnYsfhjHT8JM	118
1359	Embarcadero Center	ChIJWTGPjmaAhYARnYsfhjHT8JM	118
1360	Wayfare Tavern	ChIJWTGPjmaAhYARnYsfhjHT8JM	118
1361	Perbacco	ChIJWTGPjmaAhYARnYsfhjHT8JM	118
1362	The Slanted Door	ChIJWTGPjmaAhYARnYsfhjHT8JM	118
1363	Cathedral Hill Tower	ChIJE14p_6GAhYARYx61OVL6AYc	119
1364	Nob Hill Place Apartments	ChIJE14p_6GAhYARYx61OVL6AYc	119
1365	Carillon Towers	ChIJE14p_6GAhYARYx61OVL6AYc	119
1366	7-Eleven	ChIJE14p_6GAhYARYx61OVL6AYc	119
1367	7-Eleven	ChIJE14p_6GAhYARYx61OVL6AYc	119
1368	7-Eleven	ChIJE14p_6GAhYARYx61OVL6AYc	119
1369	7-Eleven	ChIJE14p_6GAhYARYx61OVL6AYc	119
1370	7-Eleven	ChIJE14p_6GAhYARYx61OVL6AYc	119
1371	Chpac Inc	ChIJE14p_6GAhYARYx61OVL6AYc	119
1372	Grace Cathedral	ChIJE14p_6GAhYARYx61OVL6AYc	119
1373	Annunciation Greek Orthodox Cathedral	ChIJE14p_6GAhYARYx61OVL6AYc	119
1374	Trinity Towers Apartments	ChIJE14p_6GAhYARYx61OVL6AYc	119
1375	Franklin Apartments	ChIJE14p_6GAhYARYx61OVL6AYc	119
1376	Sacred Heart Cathedral Preparatory	ChIJE14p_6GAhYARYx61OVL6AYc	119
1377	Cathedral of Saint Mary of the Assumption	ChIJE14p_6GAhYARYx61OVL6AYc	119
1378	St Francis Square Apartments	ChIJE14p_6GAhYARYx61OVL6AYc	119
1379	Villa Nob Hill Furnished Apartments	ChIJE14p_6GAhYARYx61OVL6AYc	119
1380	Western Park Apartments	ChIJE14p_6GAhYARYx61OVL6AYc	119
1381	Mercy Terrace Apartments	ChIJE14p_6GAhYARYx61OVL6AYc	119
1382	Avalon Hayes Valley	ChIJE14p_6GAhYARYx61OVL6AYc	119
1383	SaveOn Auto Glass	ChIJt9gPEJ6AhYAR3JymG4zU-tI	120
1384	150 Otis St	ChIJt9gPEJ6AhYAR3JymG4zU-tI	120
1385	Otis St & 12th St	ChIJt9gPEJ6AhYAR3JymG4zU-tI	120
1386	Nema South Tower	ChIJX2OhS5yAhYARRNDSSRq_wLk	70
1387	NEMA - San Francisco Luxury Apartments	ChIJX2OhS5yAhYARRNDSSRq_wLk	70
1388	NEMA Parking Lot	ChIJX2OhS5yAhYARRNDSSRq_wLk	70
1389	San Francisco Federal Building	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1390	Phillip Burton Federal Building & United States Courthouse	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1391	Phillip Burton Federal Building	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1392	Provident Credit Union, San Francisco Community Branch (Federal Building)	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1393	Kids by the Bay	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1394	GSA General Services Administration	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1395	US Post Office	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1396	U.S. Customs and Border Protection - San Francisco Port of Entry	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1397	U.S. General Services Administration	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1398	U.S. Mint - San Francisco	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1399	U.S. General Services Administration - Pacific Rim Region	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1400	San Francisco Federal Credit Union	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1401	Asylum office	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1402	US District Court Clerk	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1403	50 United Nations Plaza Federal Office Building	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1404	Federal Reserve Bank of San Francisco	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1405	Arup	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1406	Federal Fitness Center At 75	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1407	FBI San Francisco	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1408	US Internal Revenue Services	ChIJVcNxG5qAhYARQQ0eKPOZJWg	122
1409	Soma Grand	ChIJodb7hoiAhYARR19HT8Us4-s	123
1410	St Regis Residences	ChIJodb7hoiAhYARR19HT8Us4-s	123
1411	The Ritz-Carlton Club, San Francisco	ChIJodb7hoiAhYARR19HT8Us4-s	123
1412	Blu Condominiums Sales Office	ChIJodb7hoiAhYARR19HT8Us4-s	123
1413	Blu	ChIJodb7hoiAhYARR19HT8Us4-s	123
1414	75 Howard Garage	ChIJ5zP0FGWAhYARpbpE0gPHiAQ	126
1415	L3 Extreme Carwash & Detailing	ChIJ5zP0FGWAhYARpbpE0gPHiAQ	126
1416	Coit Tower	ChIJAQAAQIyAhYARRN3yIQG4hd4	62
1417	Intercontinental San Francisco	ChIJF1lX2oaAhYARelgGaL_UtIc	129
1418	Intercontinental Mark Hopkins San Francisco	ChIJF1lX2oaAhYARelgGaL_UtIc	129
1419	The I Spa San Francisco	ChIJF1lX2oaAhYARelgGaL_UtIc	129
1420	Bar 888	ChIJF1lX2oaAhYARelgGaL_UtIc	129
1421	Top of the Mark	ChIJF1lX2oaAhYARelgGaL_UtIc	129
1422	Luce Restaurant	ChIJF1lX2oaAhYARelgGaL_UtIc	129
1423	Hyatt Regency San Francisco	ChIJv01Os46AhYARqB1bbRrTMaY	84
1424	Budget Car Rental	ChIJv01Os46AhYARqB1bbRrTMaY	84
1425	Grand Hyatt San Francisco	ChIJv01Os46AhYARqB1bbRrTMaY	84
1426	Avis Car Rental	ChIJv01Os46AhYARqB1bbRrTMaY	84
1427	Eclipse Kitchen & Bar	ChIJv01Os46AhYARqB1bbRrTMaY	84
1428	hyatt	ChIJv01Os46AhYARqB1bbRrTMaY	84
1429	The Regency Ballroom	ChIJv01Os46AhYARqB1bbRrTMaY	84
1430	Grand Hyatt Valet Parking	ChIJv01Os46AhYARqB1bbRrTMaY	84
1431	Loews Regency San Francisco	ChIJv01Os46AhYARqB1bbRrTMaY	84
1432	Coffee Bar	ChIJv01Os46AhYARqB1bbRrTMaY	84
1433	Grandviews Restaurant	ChIJv01Os46AhYARqB1bbRrTMaY	84
\.


--
-- Name: tenants_tenant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('tenants_tenant_id_seq', 1433, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY users (user_id, username, password, card_id) FROM stdin;
1	tdiede@gmail.com	password	\N
2	new@gmail.com	new	\N
3	person@gmail.com	person	\N
4	beatrice@gmail.com	beatrice	\N
\.


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('users_user_id_seq', 4, true);


--
-- Name: buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY buildings
    ADD CONSTRAINT buildings_pkey PRIMARY KEY (bldg_id);


--
-- Name: cards_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY cards
    ADD CONSTRAINT cards_pkey PRIMARY KEY (card_id);


--
-- Name: cities_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (city_id);


--
-- Name: tenants_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (tenant_id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users_username_key; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: buildings_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY buildings
    ADD CONSTRAINT buildings_city_id_fkey FOREIGN KEY (city_id) REFERENCES cities(city_id);


--
-- Name: cards_bldg_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY cards
    ADD CONSTRAINT cards_bldg_id_fkey FOREIGN KEY (bldg_id) REFERENCES buildings(bldg_id);


--
-- Name: tenants_bldg_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY tenants
    ADD CONSTRAINT tenants_bldg_id_fkey FOREIGN KEY (bldg_id) REFERENCES buildings(bldg_id);


--
-- Name: users_card_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_card_id_fkey FOREIGN KEY (card_id) REFERENCES cards(card_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

