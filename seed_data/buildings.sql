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
    height_m character varying,
    height_ft character varying,
    floors integer,
    completed_yr character varying,
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
    password character varying(64)
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
1	ChIJm_js2XqAhYAR7kiGuH0qUmY	1	Under Construction	Salesforce Tower	41	37.7893387000000018	-122.392480500000005	326.1	1070	61	2018	composite	office
2	ChIJQ-U7wYqAhYAReKjwcBt6SGU	2	Completed	Transamerica Pyramid	41	37.7951775000000083	-122.402778699999999	260	853	48	1972	composite	office
3	ChIJIzwEpmSAhYARFA8d3d73WzI	3	Under Construction	181 Fremont	41	37.7896124999999969	-122.395433600000004	244.4	802	54	2017	steel	residential / office
4	ChIJgVDtsouAhYARvYch9NRWjkI	4	Completed	555 California Street	41	37.7920620000000014	-122.403714800000003	237.4	779	52	1969	steel	office
5	ChIJEyzd7mGAhYAR5sHoK8CXPMQ	5	Completed	345 California Center	41	37.7926135000000016	-122.400413900000004	211.8	695	48	1986	steel	hotel / office
6	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	6	Completed	Millennium Tower	41	37.7905057999999983	-122.3961611	196.6	645	58	2009	concrete	residential
7	ChIJOQ37NHqAhYARkKjCRE6k-hE	7	Completed	One Rincon Hill South Tower	41	37.7857456000000127	-122.392094400000005	184.4	605	54	2008	concrete	residential
8	ChIJKRZgfWGAhYARt1bslE_PWQ8	8	Completed	101 California Street	41	37.7928897999999975	-122.397886	183	600	48	1982	steel	office
9	ChIJWdUJpGOAhYARfBVi2TE8daI	9	Completed	50 Fremont Center	41	37.7904906999999994	-122.397125000000003	183	600	43	1985	steel	office
10	ChIJdwEVAp6AhYARUXTwVWaVwmU	10	Completed	Chevron Tower	41	37.772160300000003	-122.418775199999999	174.6	573	40	1975	steel	office
11	ChIJARA0SmGAhYARaguL-w1luao	11	Completed	Four Embarcadero Center	41	37.7946020999999988	-122.396014899999997	173.7	570	45	1984	steel	office
12	ChIJG4kUEWGAhYARtQwQFYlJCio	12	Completed	One Embarcadero Center	41	37.7950111000000035	-122.397869600000007	173.4	569	45	1970	steel	office
13	ChIJo7HdhWKAhYARp5lDOzOnnK0	13	Completed	44 Montgomery	41	37.789406900000003	-122.401067299999994	172.3	565	43	1967	steel	office
14	ChIJA5Rk94qAhYARL-g2KXuYMh4	14	Completed	Spear Tower	41	37.7933146000000022	-122.394119399999994	172	564	42	1976	steel	office
15	ChIJf9l5BkT3MhUR9bgdwkcE2xo	15	Completed	One Sansome Street	41	37.7904369999999972	-122.401347999999999	168	551	43	1984	steel	office
16	ChIJg9dyCnyAhYARWltNAyFiLnM	16	Completed	One Rincon Hill North Tower	41	37.7852054000000024	-122.395799100000005	165	541	45	2014	steel	residential
17	ChIJgSWpS2KAhYARXyMEvJK1UKM	17	Completed	Shaklee Terrace Building	41	37.7913718000000074	-122.398783399999999	164	538	38	1982	steel	office
18	ChIJ4RVMW2KAhYARuLxcGkxzFoo	18	Completed	First Market Tower	41	37.7905713999999975	-122.399205499999994	161.2	529	38	1972	steel	office
19	ChIJw-fnNoiAhYARkYz7cP25udk	18	Completed	McKesson Plaza	41	37.7888701999999981	-122.402581699999999	161.2	529	38	1969	steel	office
20	ChIJc5SPsWOAhYARY9kqZIk2HUo	20	Completed	425 Market Street	41	37.7913004999999984	-122.398135800000006	159.7	524	38	1973	steel	office
21	ChIJK5Rpz39hmoARKjcL9JTUw2E	21	Completed	Telesis Tower	41	37.7892050000000026	-122.403442200000001	152.4	500	38	1982	steel	office
22	ChIJhxhwkomAhYARJLhTkLrKoLo	22	Completed	333 Bush Street	41	37.7906653000000006	-122.403176999999999	150.9	495	43	1986	steel	residential / office
23	ChIJeSJHoI-AhYARembxZUVcNEk	23	Completed	Hilton San Francisco Union Square	41	37.7856280000000027	-122.410385000000005	150.3	493	46	1971	steel	hotel
24	ChIJka2ABnt-j4AR71gZVOGofXw	24	Completed	Pacific Gas & Electric Building	41	37.8013787999999877	-122.404522099999994	150	492	34	1971	steel	office
25	ChIJMz9haGGAhYAR-HJdMe4mAqg	25	Completed	50 California Street	41	37.7940729000000033	-122.397424099999995	148.4	487	37	1972	steel	office
26	ChIJfyky1mKAhYAR251Q943yzfE	26	Completed	555 Mission Street	41	37.7885987000000014	-122.398835000000005	148.4	487	33	2008	steel	office
27	ChIJFzmL9IeAhYARH75pRwnV0sk	27	Completed	St. Regis San Francisco	41	37.7862709999999993	-122.401452000000006	147.5	484	42	2005	concrete	residential / hotel
28	ChIJh57yKWKAhYARhFKmg6nNvcU	28	Completed	100 Pine Center	41	37.7926074000000014	-122.398984600000006	145.1	476	34	1972	steel	office
29	ChIJNUaYmGOAhYARH8yGnLTcfvI	29	Completed	45 Fremont Center	41	37.7913209000000023	-122.397133699999998	145	476	34	1979	steel	office
30	ChIJexu7D36AhYARfGmEs3pNQIM	30	Completed	333 Market Building	41	37.7918630000000135	-122.397578899999999	144	472	33	1979	steel	office
31	ChIJWyGdpouAhYARbToYS1QXQYQ	31	Completed	650 California Street	41	37.792862999999997	-122.405185000000003	142	466	33	1964	steel	office
32	ChIJgQJIqnuAhYARepV1YXAK_BI	32	Under Construction	340 Fremont Street	41	37.7871884999999992	-122.393137400000001	134.1	440	40	2016	concrete	residential
33	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33	Completed	One California	41	37.7899507999999997	-122.402046400000003	133.5	438	32	1969	steel	office
34	ChIJne1RNoaAhYARQ0LNBX6AFyQ	34	Completed	San Francisco Marriott	41	37.7851379999999892	-122.4041268	132.9	436	39	1989	steel	hotel
35	ChIJ0zD-nWKAhYARkEidg1fyAoQ	35	Completed	140 New Montgomery Street	41	37.7884868000000012	-122.401392799999996	132.7	435	26	1925	steel	residential / hotel
36	ChIJkYbnH4qAhYARE9q5MOy2Sp0	36	Completed	Russ Building	41	37.7910145000000028	-122.402896100000007	132.6	435	32	1927	steel	office
37	ChIJbclv9IqAhYARsIAAErIC5eY	37	Completed	505 Montgomery	41	37.7940260000000023	-122.403135199999994	129.5	425	24	1988	steel	office
38	ChIJ3Qt5xnqAhYARuoJLmmzaTIY	38	Completed	The Infinity II	41	37.7894261	-122.391225000000006	128	420	41	2009	concrete	residential
39	ChIJfyky1mKAhYARvsSatEOkBDo	39	Completed	JPMorgan Chase Building	41	37.7885849999999976	-122.398572000000001	128	420	31	2002	steel	office
40	ChIJW4wwR4mAhYARDSUTkiCTdYY	40	Completed	The Paramount	41	37.7892683000000034	-122.405836600000001	127.4	418	40	2002	precast	residential
41	ChIJVcNxG5qAhYAR_MvGwepvjZE	41	Completed	Providian Financial Building	41	37.7819213000000005	-122.418379799999997	127	417	30	1983	steel	office
42	ChIJj5R7F2GAhYARubN1VnuNZZM	42	Completed	Three Embarcadero Center	41	37.7951890000000006	-122.397354199999995	126	413	31	1976	steel	office
43	ChIJZ76fAGGAhYARX3kjrSwKu8Q	42	Completed	Two Embarcadero Center	41	37.794976400000003	-122.398935600000002	126	413	31	1974	steel	office
44	ChIJUcpwj2KAhYAR7luCzfbMtVk	44	Completed	595 Market Street	41	37.7892815000000013	-122.400859100000005	125	410	30	1979	concrete	office
45	ChIJx8Jssp6AhYAR95lVPh0wmwU	45	Completed	100 Van Ness	41	37.7767309999999981	-122.419251399999993	122	400	30	1974	steel	residential
46	ChIJ0x_HRXqAhYAROhkrk7dEktA	46	Under Construction	399 Fremont	41	37.7870909999999967	-122.392082500000001	121.9	400	42	2016	concrete	residential
47	ChIJLTY_UGCAhYARqvWB2GQTfns	47	Completed	One Maritime Plaza	41	37.7955356999999879	-122.399159699999998	121.3	398	25	1967	steel	office
48	ChIJ0zD-nWKAhYARkEidg1fyAoQ	48	Completed	33 New Montgomery	41	37.7884868000000012	-122.401392799999996	116.5	382	21	1986	steel	office
49	ChIJLwiwJWOAhYARGaOiwPOYeJo	49	Completed	535 Mission Street	41	37.7888897999999998	-122.398103599999999	115.4	379	26	2015	composite	office
50	ChIJcZaNPWKAhYAReio9zTi-GAE	50	Completed	Shell Building	41	37.7915733000000031	-122.399971899999997	115.2	378	29	1929	steel	office
51	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51	Completed	388 Market Street	41	37.7922753000000071	-122.398032599999993	114.3	375	26	1985	steel	residential / office
52	ChIJh2VAamKAhYARsLFItXv13uk	52	Completed	222 Second Street	41	37.7884742999999972	-122.398716199999996	112.8	370	26	2015	steel/concrete	office
53	ChIJH_aEqGaAhYARJ7KJDgLsUCc	53	Completed	Steuart Tower	41	37.793046099999998	-122.394421600000001	111	364	27	1976	steel	office
54	ChIJZ76fAGGAhYARXGFhbxFtl2g	54	Completed	101 Second Street	41	37.7881106999999972	-122.399398300000001	108	354	26	1999	steel	office
55	ChIJ3Qt5xnqAhYARuoJLmmzaTIY	55	Completed	The Infinity I	41	37.7894261	-122.391225000000006	106.7	350	35	2008	concrete	office
56	ChIJjc-4touAhYAR4ofEQYpyAnc	56	Completed	601 California Street	41	37.7924870000000013	-122.404666000000006	106.4	349	22	1960	steel	office
57	ChIJmVeqb_WAhYARMcQ6BEg4HGM	57	Completed	Bridgeview	41	37.7980426000000023	-122.402438500000002	101.4	333	26	2002	concrete	residential / retail
58	ChIJo6k9lmKAhYAR9894kyvnvxU	58	Completed	55 Second Street	41	37.7888090000000005	-122.400362000000001	100.6	330	25	2002	steel	office
59	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59	Completed	150 California Street	41	37.7936462999999989	-122.398510099999996	100.6	330	23	1999	steel	office
60	ChIJZXDI4YmAhYARnAMpXX7zBpU	60	Completed	225 Bush Street	41	37.7909886999999998	-122.401337400000003	100	328	22	1922	steel	office
61	ChIJRV0ZxomAhYAR44NGV4Xa-08	61	Completed	Hunter-Dulin Building	41	37.789816799999997	-122.402550199999993	98.3	322	22	1926	steel	office
62	ChIJawZVGD1-j4ARCe5z3nWjEGY	62	Completed	The Summit	41	37.7605404999999976	-122.421844500000006	96	315	32	1965	concrete	residential
63	ChIJf17NcIyAhYARD9lFyiQWVcg	63	Completed	Ritz Carlton Residence Club	41	37.7882674000000023	-122.403267999999997	95.1	312	24	1889	steel	residential / hotel
64	ChIJe_Jd35qAhYAREiEefhA9oZU	64	Completed	McAllister Tower Apartments	41	37.7809461000000013	-122.4143404	94.5	310	28	1930	steel	residential
65	ChIJBfmZpoyAhYAR3d-DlZfDVco	65	Completed	PG&E Headquarters	41	37.7940107000000012	-122.407428600000003	93.5	307	18	1925	steel	office
66	ChIJvxanInuAhYARwbG9SVp-q3w	66	Completed	299 Fremont	41	37.7883786000000015	-122.393667699999995	91.4	300	25	2016	concrete	residential
67	ChIJF-l7ZYiAhYARKE6JvZNUJPQ	67	Completed	Central Tower	41	37.7872600999999975	-122.403643799999998	90.8	298	21	1938	steel	office
68	ChIJXy_Z1ImAhYARJGOdimh_r6Y	68	Completed	Hobart Building	41	37.7894639000000012	-122.401621000000006	86.9	285	21	1914	steel	office
69	ChIJcWfgM2CAhYARD19rCAPLhVU	69	Completed	Le Meridien San Francisco	41	37.7947028999999972	-122.400803100000005	82.9	272	25	1988	steel	hotel
70	ChIJc5SPsWOAhYARduCXE-uUbKE	70	Completed	Ferry Building	41	37.7958049000000003	-122.393482199999994	74.7	245	12	1898	steel	office / retail
71	ChIJawzOqISAhYARUySdEKzydUI	71	Completed	San Francisco Federal Building	41	37.7791820999999999	-122.412217900000002	71.3	234	18	2007	concrete	office
72	0	72	Under Construction	San Francisco International Airport FAA Airport Traffic Control Tower (ATCT)	41	0	0	67.4	221	12	2015	steel/concrete	air traffic control tower
73	ChIJAQAAQIyAhYARRN3yIQG4hd4	73	Completed	Coit Tower	41	37.802394900000003	-122.405822200000003	64	210	13	1933	concrete	observation
74	ChIJ4-0AFn-AhYAR8U3tZOE1RFs	74	Vision	Echelon on Rincon Hill	41	37.7805399999999878	-122.397255999999999	 	 	42	 	concrete	residential
75	ChIJGYvZq42AhYAR0W1s4P4V9c8	75	Completed	The InterContinental San Francisco	41	37.7915050999999877	-122.410458199999994	 	 	40	2008	concrete	hotel
76	ChIJj3bDaoiAhYAR1w2LBOLmKlw	76	Completed	Humboldt Bank Building	41	37.787821000000001	-122.402942300000007	 	 	19	1908	steel	office
\.


--
-- Name: buildings_bldg_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('buildings_bldg_id_seq', 76, true);


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
1	50 Fremont Center	ChIJm_js2XqAhYAR7kiGuH0qUmY	1
2	Transbay Temporary Terminal Station	ChIJm_js2XqAhYAR7kiGuH0qUmY	1
3	Transamerica Pyramid	ChIJQ-U7wYqAhYAReKjwcBt6SGU	2
4	Millennium Tower San Francisco	ChIJIzwEpmSAhYARFA8d3d73WzI	3
5	Ruth Krishnan, San Francisco Real Estate	ChIJIzwEpmSAhYARFA8d3d73WzI	3
6	AIA San Francisco	ChIJIzwEpmSAhYARFA8d3d73WzI	3
7	Swiftbot Inc.	ChIJIzwEpmSAhYARFA8d3d73WzI	3
8	Temporary Transbay Terminal	ChIJIzwEpmSAhYARFA8d3d73WzI	3
9	Jay Paul Co	ChIJIzwEpmSAhYARFA8d3d73WzI	3
10	Somo	ChIJIzwEpmSAhYARFA8d3d73WzI	3
11	Waysgo Corporation.	ChIJIzwEpmSAhYARFA8d3d73WzI	3
12	KickLabs	ChIJIzwEpmSAhYARFA8d3d73WzI	3
13	Urban Fabrick	ChIJIzwEpmSAhYARFA8d3d73WzI	3
14	Gunshot Digital	ChIJIzwEpmSAhYARFA8d3d73WzI	3
15	Heller Manus Architects	ChIJIzwEpmSAhYARFA8d3d73WzI	3
16	Podio	ChIJIzwEpmSAhYARFA8d3d73WzI	3
17	PeopleConnect San Francisco Recruiters	ChIJIzwEpmSAhYARFA8d3d73WzI	3
18	Voices.com	ChIJIzwEpmSAhYARFA8d3d73WzI	3
19	Lifesta, Inc.	ChIJIzwEpmSAhYARFA8d3d73WzI	3
20	Justinmind	ChIJIzwEpmSAhYARFA8d3d73WzI	3
21	555 California Street Building	ChIJgVDtsouAhYARvYch9NRWjkI	4
22	Central Parking	ChIJEyzd7mGAhYAR5sHoK8CXPMQ	5
23	Cushman & Wakefield Inc	ChIJEyzd7mGAhYAR5sHoK8CXPMQ	5
24	Millennium Tower San Francisco	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	6
25	One Rincon Hill	ChIJOQ37NHqAhYARkKjCRE6k-hE	7
26	101 California	ChIJKRZgfWGAhYARt1bslE_PWQ8	8
27	50 Fremont Center	ChIJWdUJpGOAhYARfBVi2TE8daI	9
28	Market Center	ChIJdwEVAp6AhYARUXTwVWaVwmU	10
29	Tower Car Wash	ChIJdwEVAp6AhYARUXTwVWaVwmU	10
30	Embarcadero Center Parking Garage	ChIJARA0SmGAhYARaguL-w1luao	11
31	Onigilly Express	ChIJARA0SmGAhYARaguL-w1luao	11
32	Embarcadero Center	ChIJG4kUEWGAhYARtQwQFYlJCio	12
33	Seagate Properties	ChIJo7HdhWKAhYARp5lDOzOnnK0	13
34	Starbucks	ChIJo7HdhWKAhYARp5lDOzOnnK0	13
35	First Republic Bank	ChIJo7HdhWKAhYARp5lDOzOnnK0	13
36	Nichols Research Inc	ChIJo7HdhWKAhYARp5lDOzOnnK0	13
37	Montgomery St. Station	ChIJo7HdhWKAhYARp5lDOzOnnK0	13
38	One Market Garage	ChIJA5Rk94qAhYARL-g2KXuYMh4	14
39	One Market Street	ChIJA5Rk94qAhYARL-g2KXuYMh4	14
40	One Sansome Property LLC	ChIJf9l5BkT3MhUR9bgdwkcE2xo	15
41	Premier Business Centers	ChIJf9l5BkT3MhUR9bgdwkcE2xo	15
42	One Rincon Hill	ChIJg9dyCnyAhYARWltNAyFiLnM	16
43	303 Second Street Plaza	ChIJg9dyCnyAhYARWltNAyFiLnM	16
44	Shaklee Terraces	ChIJgSWpS2KAhYARXyMEvJK1UKM	17
45	Office Building	ChIJ4RVMW2KAhYARuLxcGkxzFoo	18
46	Millennium Tower San Francisco	ChIJ4RVMW2KAhYARuLxcGkxzFoo	18
47	Towers Watson	ChIJ4RVMW2KAhYARuLxcGkxzFoo	18
48	McKesson Plaza	ChIJw-fnNoiAhYARkYz7cP25udk	19
49	McKesson Corporation	ChIJw-fnNoiAhYARkYz7cP25udk	19
50	425 Market Street Building	ChIJc5SPsWOAhYARY9kqZIk2HUo	20
51	One Montgomery Tower	ChIJK5Rpz39hmoARKjcL9JTUw2E	21
52	333 Bush Street	ChIJhxhwkomAhYARJLhTkLrKoLo	22
53	Hilton San Francisco Union Square	ChIJeSJHoI-AhYARembxZUVcNEk	23
54	PG&E Pacific Energy Center	ChIJka2ABnt-j4AR71gZVOGofXw	24
55	Pacific Gas and Electric Company	ChIJka2ABnt-j4AR71gZVOGofXw	24
56	Pacific Gas and Electric Company Customer Service Office	ChIJka2ABnt-j4AR71gZVOGofXw	24
57	Pacific Gas & Electric Co	ChIJka2ABnt-j4AR71gZVOGofXw	24
58	Pacific Gas and Electric Company	ChIJka2ABnt-j4AR71gZVOGofXw	24
59	Pacific Gas and Electric Company	ChIJka2ABnt-j4AR71gZVOGofXw	24
60	Pacific Gas & Electric Co	ChIJka2ABnt-j4AR71gZVOGofXw	24
61	Regus San Francisco	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
62	Bank of America Financial Center	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
63	Chipotle Mexican Grill	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
64	OfficeTeam	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
65	Robert Half Legal	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
66	Holland & Knight LLP	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
67	YMCA	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
68	Recology	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
69	Piper Jaffray & Co	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
70	Eichstaedt & Lervold, LLP	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
71	The Creative Group	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
72	Nossaman LLP	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
73	Woodruff-Sawyer & Co	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
74	Kikkoman Sales USA Inc	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
75	Robert Half Technology	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
76	Nob Hill Notary Mobile & In-House Services	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
77	FirstService Residential	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
78	SAS Financial Advisors, LLC	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
79	Accountemps	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
80	Medley Partners LLC	ChIJMz9haGGAhYAR-HJdMe4mAqg	25
81	Standard Parking	ChIJfyky1mKAhYAR251Q943yzfE	26
82	Deloitte	ChIJfyky1mKAhYAR251Q943yzfE	26
83	Silicon Valley Bank	ChIJfyky1mKAhYAR251Q943yzfE	26
84	Chase Bank	ChIJfyky1mKAhYAR251Q943yzfE	26
85	HEYDAY - Organic Cafe and Bakery	ChIJfyky1mKAhYAR251Q943yzfE	26
86	Novak Druce Connolly Bove + Quigg LLP	ChIJfyky1mKAhYAR251Q943yzfE	26
87	A.T. Kearney, Inc.	ChIJfyky1mKAhYAR251Q943yzfE	26
88	CNA San Francisco Branch	ChIJfyky1mKAhYAR251Q943yzfE	26
89	Tishman Speyer	ChIJfyky1mKAhYAR251Q943yzfE	26
90	Financial Technology Partners	ChIJfyky1mKAhYAR251Q943yzfE	26
91	BNY Mellon Wealth Management San Francisco	ChIJfyky1mKAhYAR251Q943yzfE	26
92	Strata Apartments	ChIJfyky1mKAhYAR251Q943yzfE	26
93	DLA Piper	ChIJfyky1mKAhYAR251Q943yzfE	26
94	Gibson Dunn & Crutcher	ChIJfyky1mKAhYAR251Q943yzfE	26
95	CodeFuel	ChIJfyky1mKAhYAR251Q943yzfE	26
96	Gibson Dunn & Crutcher: Cussen Deborah A	ChIJfyky1mKAhYAR251Q943yzfE	26
97	Allianz Global Investors	ChIJfyky1mKAhYAR251Q943yzfE	26
98	Crowley Theresa	ChIJfyky1mKAhYAR251Q943yzfE	26
99	Vinson & Elkins LLP	ChIJfyky1mKAhYAR251Q943yzfE	26
100	DLA Piper Us LLP: Sekimura Gerald	ChIJfyky1mKAhYAR251Q943yzfE	26
101	The St. Regis San Francisco	ChIJFzmL9IeAhYARH75pRwnV0sk	27
102	100 Pine	ChIJh57yKWKAhYARhFKmg6nNvcU	28
103	Shorenstein Company	ChIJNUaYmGOAhYARH8yGnLTcfvI	29
104	50 Fremont Center	ChIJNUaYmGOAhYARH8yGnLTcfvI	29
105	Wells Fargo Insurance Services	ChIJNUaYmGOAhYARH8yGnLTcfvI	29
106	333 Market	ChIJexu7D36AhYARfGmEs3pNQIM	30
107	Wells Fargo Bank	ChIJexu7D36AhYARfGmEs3pNQIM	30
108	Russell's Convenience	ChIJexu7D36AhYARfGmEs3pNQIM	30
109	Ace Parking	ChIJexu7D36AhYARfGmEs3pNQIM	30
110	650 California St LLC	ChIJWyGdpouAhYARbToYS1QXQYQ	31
111	Thornton Tomasetti	ChIJWyGdpouAhYARbToYS1QXQYQ	31
112	Credit Suisse AG (Investment Banking)	ChIJWyGdpouAhYARbToYS1QXQYQ	31
113	AppDirect	ChIJWyGdpouAhYARbToYS1QXQYQ	31
114	340 Fremont Apartments	ChIJgQJIqnuAhYARepV1YXAK_BI	32
115	One Medical Group	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
116	Climate One	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
117	One Workplace	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
118	One Medical Group	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
119	One Market Street	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
120	One Maritime Plaza	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
121	One Montgomery Tower	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
122	One Market Restaurant	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
123	Exam One	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
124	Capital One Café	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
125	San Francisco Soup Company	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
126	One Hawthorne Sales Center	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
127	One Bush Plaza	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
128	One Rincon Hill	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
129	Oakwood Apartments	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
130	Wells Fargo Bank	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
131	One & Co	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
132	One Medical Group	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
133	One Medical Group	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
134	AppleOne Employment Services	ChIJ3c4r0omAhYAR0T06lsxLBOQ	33
135	San Francisco Marriott Marquis	ChIJne1RNoaAhYARQ0LNBX6AFyQ	34
136	San Francisco Marriott Union Square	ChIJne1RNoaAhYARQ0LNBX6AFyQ	34
137	JW Marriott San Francisco Union Square	ChIJne1RNoaAhYARQ0LNBX6AFyQ	34
138	Courtyard San Francisco Downtown	ChIJne1RNoaAhYARQ0LNBX6AFyQ	34
139	Bin 55	ChIJne1RNoaAhYARQ0LNBX6AFyQ	34
140	Courtyard San Francisco Union Square	ChIJne1RNoaAhYARQ0LNBX6AFyQ	34
141	SF Marriott Massage & Fitness Center	ChIJne1RNoaAhYARQ0LNBX6AFyQ	34
142	Yelp	ChIJ0zD-nWKAhYARkEidg1fyAoQ	35
143	Mourad	ChIJ0zD-nWKAhYARkEidg1fyAoQ	35
144	Trou Normand	ChIJ0zD-nWKAhYARkEidg1fyAoQ	35
145	Knoll	ChIJ0zD-nWKAhYARkEidg1fyAoQ	35
146	Bloomberg Tech	ChIJ0zD-nWKAhYARkEidg1fyAoQ	35
147	Apcera	ChIJ0zD-nWKAhYARkEidg1fyAoQ	35
148	AmWINS Insurance Brokerage of California	ChIJ0zD-nWKAhYARkEidg1fyAoQ	35
149	G2 Insurance	ChIJ0zD-nWKAhYARkEidg1fyAoQ	35
150	Lumos Labs, Inc.	ChIJ0zD-nWKAhYARkEidg1fyAoQ	35
151	AT&T	ChIJ0zD-nWKAhYARkEidg1fyAoQ	35
152	Bre New Montgomery LLC	ChIJ0zD-nWKAhYARkEidg1fyAoQ	35
153	Russ Building Garage	ChIJkYbnH4qAhYARE9q5MOy2Sp0	36
154	Regus San Francisco	ChIJbclv9IqAhYARsIAAErIC5eY	37
155	505 Montgomery Garage	ChIJbclv9IqAhYARsIAAErIC5eY	37
156	Bank of the West	ChIJbclv9IqAhYARsIAAErIC5eY	37
157	Palio Caffe	ChIJbclv9IqAhYARsIAAErIC5eY	37
158	Latham & Watkins LLP	ChIJbclv9IqAhYARsIAAErIC5eY	37
159	BookATailor San Francisco Showroom	ChIJbclv9IqAhYARsIAAErIC5eY	37
160	Helen's Place	ChIJbclv9IqAhYARsIAAErIC5eY	37
161	Payroll Resourcesce Group	ChIJbclv9IqAhYARsIAAErIC5eY	37
162	Venable LLP, San Francisco, CA	ChIJbclv9IqAhYARsIAAErIC5eY	37
163	Guarantee Mortgage	ChIJbclv9IqAhYARsIAAErIC5eY	37
164	Low, Ball & Lynch	ChIJbclv9IqAhYARsIAAErIC5eY	37
165	Portcullis, Inc.	ChIJbclv9IqAhYARsIAAErIC5eY	37
166	The Infinity Towers	ChIJ3Qt5xnqAhYARuoJLmmzaTIY	38
167	JPMorgan Chase	ChIJfyky1mKAhYARvsSatEOkBDo	39
168	JPMorgan Chase	ChIJfyky1mKAhYARvsSatEOkBDo	39
169	JPMorgan Chase	ChIJfyky1mKAhYARvsSatEOkBDo	39
170	JPMorgan Chase	ChIJfyky1mKAhYARvsSatEOkBDo	39
171	JPMorgan Chase	ChIJfyky1mKAhYARvsSatEOkBDo	39
172	Chase Bank	ChIJfyky1mKAhYARvsSatEOkBDo	39
173	The Paramount Luxury Apartments	ChIJW4wwR4mAhYARDSUTkiCTdYY	40
174	Paramount Student Housing - The Park	ChIJW4wwR4mAhYARDSUTkiCTdYY	40
175	BBVA San Francisco Rep Office	ChIJVcNxG5qAhYAR_MvGwepvjZE	41
176	Varden Pacific LLC	ChIJVcNxG5qAhYAR_MvGwepvjZE	41
177	Silicon Legal Strategy	ChIJVcNxG5qAhYAR_MvGwepvjZE	41
178	Spring Studio	ChIJVcNxG5qAhYAR_MvGwepvjZE	41
179	Procore	ChIJVcNxG5qAhYAR_MvGwepvjZE	41
180	Seal Software	ChIJVcNxG5qAhYAR_MvGwepvjZE	41
181	Concepcion Enterprises, LLC	ChIJVcNxG5qAhYAR_MvGwepvjZE	41
182	Clustrix Inc	ChIJVcNxG5qAhYAR_MvGwepvjZE	41
183	The Atashi Rang Law Firm PC	ChIJVcNxG5qAhYAR_MvGwepvjZE	41
274	Schlesinger	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
184	Provident Credit Union, San Francisco Community Branch (Federal Building)	ChIJVcNxG5qAhYAR_MvGwepvjZE	41
185	Three Embarcadero Center	ChIJj5R7F2GAhYARubN1VnuNZZM	42
186	Embarcadero Center	ChIJZ76fAGGAhYARX3kjrSwKu8Q	43
187	One Medical Group	ChIJZ76fAGGAhYARX3kjrSwKu8Q	43
188	Chase Bank	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
189	Uno Dos Tacos	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
190	Consumer Credit Counseling Service of San Francisco	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
191	Consulate General of Singapore	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
192	FinancialForce.com	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
193	Creative Circle	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
194	Calypso Technology	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
195	Rockman et al, Inc.	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
196	BALANCE	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
197	Chu & Waters	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
198	Hedani Choy Spalding	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
199	Integrated Benefits Institute	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
200	SelectQuote Insurance Services	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
201	CERA LLP	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
202	Nelson	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
203	Bay Dynamics	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
204	Watts, Cohn and Partners, Inc.	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
205	The Hartford Financial Services Group, Inc.	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
206	Murray, Stok & Company	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
207	Consulate General of Colombia	ChIJUcpwj2KAhYAR7luCzfbMtVk	44
208	100 Van Ness	ChIJx8Jssp6AhYAR95lVPh0wmwU	45
209	399 Fremont	ChIJ0x_HRXqAhYAROhkrk7dEktA	46
210	One Maritime Plaza	ChIJLTY_UGCAhYARqvWB2GQTfns	47
211	Bank of America Financial Center	ChIJ0zD-nWKAhYARkEidg1fyAoQ	35
212	GLB 33 New Montgomery LP	ChIJ0zD-nWKAhYARkEidg1fyAoQ	35
213	Learn IT	ChIJ0zD-nWKAhYARkEidg1fyAoQ	35
214	Insight Global	ChIJ0zD-nWKAhYARkEidg1fyAoQ	35
215	Bre New Montgomery LLC	ChIJ0zD-nWKAhYARkEidg1fyAoQ	35
216	WeWork Transbay	ChIJLwiwJWOAhYARGaOiwPOYeJo	49
217	One Medical Group	ChIJLwiwJWOAhYARGaOiwPOYeJo	49
218	Shell Building Barber Shop	ChIJcZaNPWKAhYAReio9zTi-GAE	50
219	Raven Office Centers	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
220	Dunhill Partners West	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
221	Market Street Chiropractic	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
222	Subway	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
223	Miss Tomato Sandwich Shop	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
224	Sushirrito - FIDI Market	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
225	Davinci Virtual Office Solutions	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
226	Jack's Shoe Services	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
227	Davinci Meeting Rooms	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
228	Allied Offices	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
229	P M Realty Group	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
230	Puri Law	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
231	CGI Carol Gilbert Inc	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
232	Buffington & Aaron: Aaron Diane	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
233	G3 Visas and Passports, Inc.	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
234	Commercial Coverage Insurance Agency	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
235	Pac Ocean Forwarding	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
236	CPIC International	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
237	Dr. Akira Olsen Psychologist	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
238	Quality Planning Corporation	ChIJa-JlzmOAhYAR7rCaTWDGv6Y	51
239	Tishman Speyer	ChIJh2VAamKAhYARsLFItXv13uk	52
240	One Market Garage	ChIJH_aEqGaAhYARJ7KJDgLsUCc	53
241	ABM Parking Services	ChIJZ76fAGGAhYARXGFhbxFtl2g	54
242	Moss Adams LLP	ChIJZ76fAGGAhYARXGFhbxFtl2g	54
243	King & Spalding LLP	ChIJZ76fAGGAhYARXGFhbxFtl2g	54
244	Rowbotham & Company LLP	ChIJZ76fAGGAhYARXGFhbxFtl2g	54
245	HFF	ChIJZ76fAGGAhYARXGFhbxFtl2g	54
246	California Appellate Project	ChIJZ76fAGGAhYARXGFhbxFtl2g	54
247	Reed Smith LLP	ChIJZ76fAGGAhYARXGFhbxFtl2g	54
248	The Infinity Towers	ChIJ3Qt5xnqAhYARuoJLmmzaTIY	38
249	T R 601 California Corporation	ChIJjc-4touAhYAR4ofEQYpyAnc	56
250	Old Republic Title	ChIJjc-4touAhYAR4ofEQYpyAnc	56
251	Fisher Development, Inc.	ChIJjc-4touAhYAR4ofEQYpyAnc	56
252	Fidelity National Title	ChIJjc-4touAhYAR4ofEQYpyAnc	56
253	SKS Partners	ChIJjc-4touAhYAR4ofEQYpyAnc	56
254	Girard Gibbs LLP	ChIJjc-4touAhYAR4ofEQYpyAnc	56
255	Bledsoe, Cathcart, Diestel, Pedersen & Treppa, LLP	ChIJjc-4touAhYAR4ofEQYpyAnc	56
256	Field Research Corporation	ChIJjc-4touAhYAR4ofEQYpyAnc	56
257	Springs & Associates	ChIJjc-4touAhYAR4ofEQYpyAnc	56
258	Weiss & Weissman	ChIJjc-4touAhYAR4ofEQYpyAnc	56
259	Dennis M Sullivan Law Offices	ChIJjc-4touAhYAR4ofEQYpyAnc	56
260	Ware Malcomb | San Francisco	ChIJjc-4touAhYAR4ofEQYpyAnc	56
261	Traver Walter J	ChIJjc-4touAhYAR4ofEQYpyAnc	56
262	Weiss & Weissman: Seher Alan R	ChIJjc-4touAhYAR4ofEQYpyAnc	56
263	Alaska National Insurance	ChIJjc-4touAhYAR4ofEQYpyAnc	56
264	Avison Young	ChIJjc-4touAhYAR4ofEQYpyAnc	56
265	Main Management LLC	ChIJjc-4touAhYAR4ofEQYpyAnc	56
266	Bacchus Capital Management	ChIJjc-4touAhYAR4ofEQYpyAnc	56
267	Family Law Offices of Robert J. Rothman	ChIJjc-4touAhYAR4ofEQYpyAnc	56
268	Newport Asia LLC	ChIJjc-4touAhYAR4ofEQYpyAnc	56
269	BridgeView CFO	ChIJmVeqb_WAhYARMcQ6BEg4HGM	57
270	Bridgeview Owners Association	ChIJmVeqb_WAhYARMcQ6BEg4HGM	57
271	Bridge View Funding Inc	ChIJmVeqb_WAhYARMcQ6BEg4HGM	57
272	Hines 55 Second Street LP	ChIJo6k9lmKAhYAR9894kyvnvxU	58
273	KPMG	ChIJo6k9lmKAhYAR9894kyvnvxU	58
275	City National Bank	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
276	Colchis Capital Management, L.P.	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
277	Vista Equity Partners	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
278	Savills Studley	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
279	Capital Access Group	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
280	Harrington Maureen A	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
281	Blackstone Technology Group	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
282	Field Paoli Architects	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
283	643 Capital Management	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
284	N.F. Stroth & Associates, LLC	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
285	GCA Savvian	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
286	Redwood Energy Co	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
287	Technvison Management	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
288	Puchulski Stang Ziehl Young: Singer Pamela E	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
289	Medigroup Management LP	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
290	Mesirow Financial Administration Corporation	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
291	Pachulski Stang Ziehl Jones: Bertenthal David M	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
292	Glumac	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
293	Microdesk, Inc.	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59
294	Coffee Cultures	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
295	ProPark	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
296	Benefit Cosmetics HQ	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
297	CVS Pharmacy	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
298	General Assembly San Francisco	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
299	Target	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
300	JVS	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
301	TinyCo, Inc.	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
302	Meltwater Group	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
303	Flynn Properties	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
304	CKGS Visa Application Center San Francisco	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
305	India Passport Application Center San Francisco	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
306	Flynn Restaurant Group	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
307	LiveRamp	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
308	Ricoh USA	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
309	Affirm, Inc.	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
310	Groupon	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
311	Nitro PDF	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
312	National Lymphedema Network	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
313	Lendify Financial LLC	ChIJZXDI4YmAhYARnAMpXX7zBpU	60
314	Hunter-Dulin Building	ChIJRV0ZxomAhYAR44NGV4Xa-08	61
315	The Summit	ChIJawZVGD1-j4ARCe5z3nWjEGY	62
316	Summit Furniture	ChIJawZVGD1-j4ARCe5z3nWjEGY	62
317	The Summit SF	ChIJawZVGD1-j4ARCe5z3nWjEGY	62
318	The Ritz-Carlton Club, San Francisco	ChIJf17NcIyAhYARD9lFyiQWVcg	63
319	McAllister Tower	ChIJe_Jd35qAhYAREiEefhA9oZU	64
320	PG&E Pacific Energy Center	ChIJBfmZpoyAhYAR3d-DlZfDVco	65
321	PG&E Corporation	ChIJBfmZpoyAhYAR3d-DlZfDVco	65
322	Pacific Gas and Electric Company	ChIJBfmZpoyAhYAR3d-DlZfDVco	65
323	Pacific Gas and Electric Company Customer Service Office	ChIJBfmZpoyAhYAR3d-DlZfDVco	65
324	Solaire	ChIJvxanInuAhYARwbG9SVp-q3w	66
325	Central Tower Market	ChIJF-l7ZYiAhYARKE6JvZNUJPQ	67
326	Central Towers Apartments	ChIJF-l7ZYiAhYARKE6JvZNUJPQ	67
327	Central Tower Office Building	ChIJF-l7ZYiAhYARKE6JvZNUJPQ	67
328	Hobart Building Office	ChIJXy_Z1ImAhYARJGOdimh_r6Y	68
329	Le Méridien San Francisco	ChIJcWfgM2CAhYARD19rCAPLhVU	69
330	Ferry Building	ChIJc5SPsWOAhYARduCXE-uUbKE	70
331	Ferry Plaza Farmers Market	ChIJc5SPsWOAhYARduCXE-uUbKE	70
332	Blue Bottle Coffee	ChIJc5SPsWOAhYARduCXE-uUbKE	70
333	Cowgirl Creamery Cheese Shop	ChIJc5SPsWOAhYARduCXE-uUbKE	70
334	San Francisco Federal Building	ChIJawzOqISAhYARUySdEKzydUI	71
335	Coit Tower	ChIJAQAAQIyAhYARRN3yIQG4hd4	73
336	First Person, Inc	ChIJ4-0AFn-AhYAR8U3tZOE1RFs	74
337	Intercontinental San Francisco	ChIJGYvZq42AhYAR0W1s4P4V9c8	75
338	Intercontinental Mark Hopkins San Francisco	ChIJGYvZq42AhYAR0W1s4P4V9c8	75
339	The Monadnock Building	ChIJj3bDaoiAhYAR1w2LBOLmKlw	76
\.


--
-- Name: tenants_tenant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('tenants_tenant_id_seq', 339, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY users (user_id, username, password) FROM stdin;
\.


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('users_user_id_seq', 1, false);


--
-- Name: buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY buildings
    ADD CONSTRAINT buildings_pkey PRIMARY KEY (bldg_id);


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
-- Name: buildings_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY buildings
    ADD CONSTRAINT buildings_city_id_fkey FOREIGN KEY (city_id) REFERENCES cities(city_id);


--
-- Name: tenants_bldg_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY tenants
    ADD CONSTRAINT tenants_bldg_id_fkey FOREIGN KEY (bldg_id) REFERENCES buildings(bldg_id);


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

