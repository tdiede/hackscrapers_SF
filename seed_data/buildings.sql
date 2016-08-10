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
    city character varying(64),
    lat numeric,
    lng numeric,
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
    place_id character varying(64)
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
-- Data for Name: buildings; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY buildings (bldg_id, place_id, rank, status, building_name, city, lat, lng, height_m, height_ft, floors, completed_yr, material, use) FROM stdin;
1	ChIJm_js2XqAhYAR7kiGuH0qUmY	1	Under Construction	Salesforce Tower	San Francisco	37.7893387	-122.3924805	326.1	1070	61	2018	composite	office
2	ChIJQ-U7wYqAhYAReKjwcBt6SGU	2	Completed	Transamerica Pyramid	San Francisco	37.79517750000001	-122.4027787	260	853	48	1972	composite	office
3	ChIJIzwEpmSAhYARyJjkUb1b2tM	3	Under Construction	181 Fremont	San Francisco	37.7896125	-122.3954336	244.4	802	54	2017	steel	residential / office
4	ChIJmQaMSYqAhYAR1Ozq5rqUAj0	4	Completed	555 California Street	San Francisco	37.7921085	-122.4037631	237.4	779	52	1969	steel	office
5	ChIJEyzd7mGAhYAR5sHoK8CXPMQ	5	Completed	345 California Center	San Francisco	37.7926135	-122.4004139	211.8	695	48	1986	steel	hotel / office
6	ChIJLe1rfmOAhYAR2ACDSr1e4Z8	6	Completed	Millennium Tower	San Francisco	37.7905058	-122.3961611	196.6	645	58	2009	concrete	residential
7	ChIJOQ37NHqAhYARkKjCRE6k-hE	7	Completed	One Rincon Hill South Tower	San Francisco	37.78574560000001	-122.3920944	184.4	605	54	2008	concrete	residential
8	ChIJKRZgfWGAhYARt1bslE_PWQ8	8	Completed	101 California Street	San Francisco	37.7928898	-122.397886	183	600	48	1982	steel	office
9	ChIJWdUJpGOAhYARfBVi2TE8daI	9	Completed	50 Fremont Center	San Francisco	37.7904907	-122.397125	183	600	43	1985	steel	office
10	ChIJdwEVAp6AhYARUXTwVWaVwmU	10	Completed	Chevron Tower	San Francisco	37.7721603	-122.4187752	174.6	573	40	1975	steel	office
11	ChIJpRm_M2GAhYAREu3rUbBzhac	11	Completed	Four Embarcadero Center	San Francisco	37.795402	-122.3960335	173.7	570	45	1984	steel	office
12	ChIJG4kUEWGAhYARtQwQFYlJCio	12	Completed	One Embarcadero Center	San Francisco	37.7950111	-122.3978696	173.4	569	45	1970	steel	office
13	ChIJo7HdhWKAhYARp5lDOzOnnK0	13	Completed	44 Montgomery	San Francisco	37.7894069	-122.4010673	172.3	565	43	1967	steel	office
14	ChIJLdqXpGaAhYAR-LWVk-wWqN4	14	Completed	Spear Tower	San Francisco	37.7934	-122.3942	172	564	42	1976	steel	office
15	ChIJf9l5BkT3MhUR9bgdwkcE2xo	15	Completed	One Sansome Street	San Francisco	37.790437	-122.401348	168	551	43	1984	steel	office
16	ChIJOQ37NHqAhYARkKjCRE6k-hE	16	Completed	One Rincon Hill North Tower	San Francisco	37.78574560000001	-122.3920944	165	541	45	2014	steel	residential
17	ChIJgSWpS2KAhYARXyMEvJK1UKM	17	Completed	Shaklee Terrace Building	San Francisco	37.79137180000001	-122.3987834	164	538	38	1982	steel	office
18	ChIJ4RVMW2KAhYARuLxcGkxzFoo	18	Completed	First Market Tower	San Francisco	37.7905714	-122.3992055	161.2	529	38	1972	steel	office
19	ChIJw-fnNoiAhYARkYz7cP25udk	18	Completed	McKesson Plaza	San Francisco	37.7888702	-122.4025817	161.2	529	38	1969	steel	office
20	ChIJc5SPsWOAhYARY9kqZIk2HUo	20	Completed	425 Market Street	San Francisco	37.7913005	-122.3981358	159.7	524	38	1973	steel	office
21	ChIJK5Rpz39hmoARKjcL9JTUw2E	21	Completed	Telesis Tower	San Francisco	37.789205	-122.4034422	152.4	500	38	1982	steel	office
22	ChIJhxhwkomAhYARJLhTkLrKoLo	22	Completed	333 Bush Street	San Francisco	37.7906653	-122.403177	150.9	495	43	1986	steel	residential / office
23	ChIJeSJHoI-AhYARembxZUVcNEk	23	Completed	Hilton San Francisco Union Square	San Francisco	37.785628	-122.410385	150.3	493	46	1971	steel	hotel
24	ChIJka2ABnt-j4AR71gZVOGofXw	24	Completed	Pacific Gas & Electric Building	San Francisco	37.80137879999999	-122.4045221	150	492	34	1971	steel	office
25	ChIJMz9haGGAhYAR-HJdMe4mAqg	25	Completed	50 California Street	San Francisco	37.7940729	-122.3974241	148.4	487	37	1972	steel	office
26	ChIJfyky1mKAhYARMe-hYlNs-kY	26	Completed	555 Mission Street	San Francisco	37.7885987	-122.398835	148.4	487	33	2008	steel	office
27	ChIJFzmL9IeAhYARH75pRwnV0sk	27	Completed	St. Regis San Francisco	San Francisco	37.786271	-122.401452	147.5	484	42	2005	concrete	residential / hotel
28	ChIJh57yKWKAhYARhFKmg6nNvcU	28	Completed	100 Pine Center	San Francisco	37.7926074	-122.3989846	145.1	476	34	1972	steel	office
29	ChIJNUaYmGOAhYARH8yGnLTcfvI	29	Completed	45 Fremont Center	San Francisco	37.7913209	-122.3971337	145	476	34	1979	steel	office
30	ChIJexu7D36AhYARfGmEs3pNQIM	30	Completed	333 Market Building	San Francisco	37.79186300000001	-122.3975789	144	472	33	1979	steel	office
31	ChIJ7bR-mIuAhYARUeYUUHDVtnM	31	Completed	650 California Street	San Francisco	37.7929201	-122.4053415	142	466	33	1964	steel	office
32	ChIJgQJIqnuAhYARepV1YXAK_BI	32	Under Construction	340 Fremont Street	San Francisco	37.7871885	-122.3931374	134.1	440	40	2016	concrete	residential
33	ChIJNSm-DZ-AhYARTqWLVvtLO7A	33	Completed	One California	San Francisco	37.77392	-122.422182	133.5	438	32	1969	steel	office
34	ChIJne1RNoaAhYARQ0LNBX6AFyQ	34	Completed	San Francisco Marriott	San Francisco	37.78513799999999	-122.4041268	132.9	436	39	1989	steel	hotel
35	ChIJ7_fCtouAhYARg7soTOgic8Q	35	Completed	140 New Montgomery Street	San Francisco	37.7867348	-122.3999144	132.7	435	26	1925	steel	residential / hotel
36	ChIJkYbnH4qAhYARE9q5MOy2Sp0	36	Completed	Russ Building	San Francisco	37.7910145	-122.4028961	132.6	435	32	1927	steel	office
37	ChIJJSk-9IqAhYARe6ED4StsXmE	37	Completed	505 Montgomery	San Francisco	37.79407399999999	-122.4031332	129.5	425	24	1988	steel	office
38	ChIJ3Qt5xnqAhYARuoJLmmzaTIY	38	Completed	The Infinity II	San Francisco	37.7894261	-122.391225	128	420	41	2009	concrete	residential
39	ChIJW4zOCRN-j4ARFWpPmieFHsg	39	Completed	JPMorgan Chase Building	San Francisco	37.7515649	-122.4317592	128	420	31	2002	steel	office
40	ChIJW4wwR4mAhYARDSUTkiCTdYY	40	Completed	The Paramount	San Francisco	37.7892683	-122.4058366	127.4	418	40	2002	precast	residential
41	ChIJVcNxG5qAhYAR_MvGwepvjZE	41	Completed	Providian Financial Building	San Francisco	37.7819213	-122.4183798	127	417	30	1983	steel	office
42	ChIJj5R7F2GAhYARubN1VnuNZZM	42	Completed	Three Embarcadero Center	San Francisco	37.795189	-122.3973542	126	413	31	1976	steel	office
43	ChIJZ76fAGGAhYARX3kjrSwKu8Q	42	Completed	Two Embarcadero Center	San Francisco	37.7949764	-122.3989356	126	413	31	1974	steel	office
44	ChIJ75fLhWKAhYARnKrmO1VBbcU	44	Completed	595 Market Street	San Francisco	37.7892485	-122.4008113	125	410	30	1979	concrete	office
45	ChIJx8Jssp6AhYAR95lVPh0wmwU	45	Completed	100 Van Ness	San Francisco	37.776731	-122.4192514	122	400	30	1974	steel	residential
46	ChIJ0x_HRXqAhYAROhkrk7dEktA	46	Under Construction	399 Fremont	San Francisco	37.787091	-122.3920825	121.9	400	42	2016	concrete	residential
47	ChIJLTY_UGCAhYARqvWB2GQTfns	47	Completed	One Maritime Plaza	San Francisco	37.79553569999999	-122.3991597	121.3	398	25	1967	steel	office
48	ChIJeVXDo0H3MhUR3_X-jhB_VvQ	48	Completed	33 New Montgomery	San Francisco	37.7885963	-122.401405	116.5	382	21	1986	steel	office
49	ChIJLwiwJWOAhYARGaOiwPOYeJo	49	Completed	535 Mission Street	San Francisco	37.7888898	-122.3981036	115.4	379	26	2015	composite	office
50	ChIJcZaNPWKAhYAReio9zTi-GAE	50	Completed	Shell Building	San Francisco	37.7915733	-122.3999719	115.2	378	29	1929	steel	office
51	ChIJa-JlzmOAhYARHQCQh3A5nx8	51	Completed	388 Market Street	San Francisco	37.79227519999999	-122.3980651	114.3	375	26	1985	steel	residential / office
52	ChIJh2VAamKAhYARsLFItXv13uk	52	Completed	222 Second Street	San Francisco	37.7884743	-122.3987162	112.8	370	26	2015	steel/concrete	office
53	ChIJbbVEGGSAhYAR0LLRPNMilwo	53	Completed	Steuart Tower	San Francisco	37.7887247	-122.3993991	111	364	27	1976	steel	office
54	ChIJZ76fAGGAhYARXGFhbxFtl2g	54	Completed	101 Second Street	San Francisco	37.7881107	-122.3993983	108	354	26	1999	steel	office
55	ChIJ3Qt5xnqAhYARuoJLmmzaTIY	55	Completed	The Infinity I	San Francisco	37.7894261	-122.391225	106.7	350	35	2008	concrete	office
56	ChIJjc-4touAhYAR4ofEQYpyAnc	56	Completed	601 California Street	San Francisco	37.792487	-122.404666	106.4	349	22	1960	steel	office
57	ChIJmVeqb_WAhYARMcQ6BEg4HGM	57	Completed	Bridgeview	San Francisco	37.7980426	-122.4024385	101.4	333	26	2002	concrete	residential / retail
58	ChIJo6k9lmKAhYAR9894kyvnvxU	58	Completed	55 Second Street	San Francisco	37.788809	-122.400362	100.6	330	25	2002	steel	office
59	ChIJC2bxnWGAhYARZ8hc-3cWc3E	59	Completed	150 California Street	San Francisco	37.7936463	-122.3985101	100.6	330	23	1999	steel	office
60	ChIJZXDI4YmAhYARnAMpXX7zBpU	60	Completed	225 Bush Street	San Francisco	37.7909887	-122.4013374	100	328	22	1922	steel	office
61	ChIJRV0ZxomAhYAR44NGV4Xa-08	61	Completed	Hunter-Dulin Building	San Francisco	37.7898168	-122.4025502	98.3	322	22	1926	steel	office
62	ChIJawZVGD1-j4ARCe5z3nWjEGY	62	Completed	The Summit	San Francisco	37.7605405	-122.4218445	96	315	32	1965	concrete	residential
63	ChIJf17NcIyAhYARD9lFyiQWVcg	63	Completed	Ritz Carlton Residence Club	San Francisco	37.7882674	-122.403268	95.1	312	24	1889	steel	residential / hotel
64	ChIJtxQY35qAhYARc6Rpc_IHhW8	64	Completed	McAllister Tower Apartments	San Francisco	37.7810605	-122.4139021	94.5	310	28	1930	steel	residential
65	ChIJBfmZpoyAhYAR3d-DlZfDVco	65	Completed	PG&E Headquarters	San Francisco	37.7940107	-122.4074286	93.5	307	18	1925	steel	office
66	ChIJvxanInuAhYARwbG9SVp-q3w	66	Completed	299 Fremont	San Francisco	37.7883901	-122.3935708	91.4	300	25	2016	concrete	residential
67	ChIJF-l7ZYiAhYARKE6JvZNUJPQ	67	Completed	Central Tower	San Francisco	37.7872601	-122.4036438	90.8	298	21	1938	steel	office
68	ChIJXy_Z1ImAhYARJGOdimh_r6Y	68	Completed	Hobart Building	San Francisco	37.7894639	-122.401621	86.9	285	21	1914	steel	office
69	ChIJcWfgM2CAhYARD19rCAPLhVU	69	Completed	Le Meridien San Francisco	San Francisco	37.7947029	-122.4008031	82.9	272	25	1988	steel	hotel
70	ChIJWTGPjmaAhYAR6c9cUJ1axtM	70	Completed	Ferry Building	San Francisco	37.79603360000001	-122.3938396	74.7	245	12	1898	steel	office / retail
71	ChIJawzOqISAhYARUySdEKzydUI	71	Completed	San Francisco Federal Building	San Francisco	37.7791821	-122.4122179	71.3	234	18	2007	concrete	office
72	0	72	Under Construction	San Francisco International Airport FAA Airport Traffic Control Tower (ATCT)	San Francisco	0	0	67.4	221	12	2015	steel/concrete	air traffic control tower
73	ChIJAQAAQIyAhYARRN3yIQG4hd4	73	Completed	Coit Tower	San Francisco	37.8023949	-122.4058222	64	210	13	1933	concrete	observation
74	ChIJ4-0AFn-AhYAR8U3tZOE1RFs	74	Vision	Echelon on Rincon Hill	San Francisco	37.78053999999999	-122.397256	 	 	42	 	concrete	residential
75	ChIJF1lX2oaAhYARuyWPqjE12Oo	75	Completed	The InterContinental San Francisco	San Francisco	37.7819923	-122.4048813	 	 	40	2008	concrete	hotel
76	ChIJj3bDaoiAhYAR1w2LBOLmKlw	76	Completed	Humboldt Bank Building	San Francisco	37.787821	-122.4029423	 	 	19	1908	steel	office
\.


--
-- Name: buildings_bldg_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('buildings_bldg_id_seq', 1, false);


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

SELECT pg_catalog.setval('cities_city_id_seq', 1, false);


--
-- Data for Name: tenants; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY tenants (tenant_id, tenant, place_id) FROM stdin;
1	50 Fremont Center	ChIJm_js2XqAhYAR7kiGuH0qUmY
2	Millennium Tower San Francisco	ChIJm_js2XqAhYAR7kiGuH0qUmY
3	Transbay Temporary Terminal Station	ChIJm_js2XqAhYAR7kiGuH0qUmY
4	Transamerica Pyramid	ChIJQ-U7wYqAhYAReKjwcBt6SGU
5	Jay Paul Co	ChIJIzwEpmSAhYARyJjkUb1b2tM
6	Ruth Krishnan, San Francisco Real Estate	ChIJIzwEpmSAhYARyJjkUb1b2tM
7	Brilliant You	ChIJIzwEpmSAhYARyJjkUb1b2tM
8	Swiftbot Inc.	ChIJIzwEpmSAhYARyJjkUb1b2tM
9	Somo	ChIJIzwEpmSAhYARyJjkUb1b2tM
10	KickLabs	ChIJIzwEpmSAhYARyJjkUb1b2tM
11	Waysgo Corporation.	ChIJIzwEpmSAhYARyJjkUb1b2tM
12	Gunshot Digital	ChIJIzwEpmSAhYARyJjkUb1b2tM
13	Podio	ChIJIzwEpmSAhYARyJjkUb1b2tM
14	Voices.com	ChIJIzwEpmSAhYARyJjkUb1b2tM
15	TripAlertz	ChIJIzwEpmSAhYARyJjkUb1b2tM
16	PeopleConnect San Francisco Recruiters	ChIJIzwEpmSAhYARyJjkUb1b2tM
17	Web Chalet, Inc.	ChIJIzwEpmSAhYARyJjkUb1b2tM
18	Heller Manus Architects	ChIJIzwEpmSAhYARyJjkUb1b2tM
19	Justinmind	ChIJIzwEpmSAhYARyJjkUb1b2tM
20	Lifesta, Inc.	ChIJIzwEpmSAhYARyJjkUb1b2tM
21	Razoo	ChIJIzwEpmSAhYARyJjkUb1b2tM
22	555 California Street Building	ChIJmQaMSYqAhYAR1Ozq5rqUAj0
23	Servcorp - 555 California Street	ChIJmQaMSYqAhYAR1Ozq5rqUAj0
24	Central Parking	ChIJEyzd7mGAhYAR5sHoK8CXPMQ
25	Cushman & Wakefield Inc	ChIJEyzd7mGAhYAR5sHoK8CXPMQ
26	Millennium Tower San Francisco	ChIJLe1rfmOAhYAR2ACDSr1e4Z8
27	One Rincon Hill	ChIJOQ37NHqAhYARkKjCRE6k-hE
28	101 California	ChIJKRZgfWGAhYARt1bslE_PWQ8
29	50 Fremont Center	ChIJWdUJpGOAhYARfBVi2TE8daI
30	Market Center	ChIJdwEVAp6AhYARUXTwVWaVwmU
31	Tower Car Wash	ChIJdwEVAp6AhYARUXTwVWaVwmU
32	Embarcadero Center Parking Garage	ChIJpRm_M2GAhYAREu3rUbBzhac
33	Onigilly Express	ChIJpRm_M2GAhYAREu3rUbBzhac
34	Embarcadero Conference Center	ChIJpRm_M2GAhYAREu3rUbBzhac
35	Peninsula Beauty	ChIJpRm_M2GAhYAREu3rUbBzhac
36	Carr Workplaces - Embarcadero Center	ChIJpRm_M2GAhYAREu3rUbBzhac
37	Embarcadero Center	ChIJpRm_M2GAhYAREu3rUbBzhac
38	Landmark Theaters Embarcadero Center Cinema	ChIJpRm_M2GAhYAREu3rUbBzhac
39	One Medical Group	ChIJpRm_M2GAhYAREu3rUbBzhac
40	Embarcadero Center	ChIJG4kUEWGAhYARtQwQFYlJCio
41	Seagate Properties	ChIJo7HdhWKAhYARp5lDOzOnnK0
42	Starbucks	ChIJo7HdhWKAhYARp5lDOzOnnK0
43	First Republic Bank	ChIJo7HdhWKAhYARp5lDOzOnnK0
44	Montgomery St. Station	ChIJo7HdhWKAhYARp5lDOzOnnK0
45	One Market Street	ChIJLdqXpGaAhYAR-LWVk-wWqN4
46	One Market Restaurant	ChIJLdqXpGaAhYAR-LWVk-wWqN4
47	Regus San Francisco	ChIJLdqXpGaAhYAR-LWVk-wWqN4
48	Ishii Robert T	ChIJLdqXpGaAhYAR-LWVk-wWqN4
49	Pharmalink Consulting	ChIJLdqXpGaAhYAR-LWVk-wWqN4
50	One Sansome Property LLC	ChIJf9l5BkT3MhUR9bgdwkcE2xo
51	Premier Business Centers	ChIJf9l5BkT3MhUR9bgdwkcE2xo
52	One Rincon Hill	ChIJOQ37NHqAhYARkKjCRE6k-hE
53	Shaklee Terraces	ChIJgSWpS2KAhYARXyMEvJK1UKM
54	Office Building	ChIJ4RVMW2KAhYARuLxcGkxzFoo
55	Millennium Tower San Francisco	ChIJ4RVMW2KAhYARuLxcGkxzFoo
56	Towers Watson	ChIJ4RVMW2KAhYARuLxcGkxzFoo
57	McKesson Plaza	ChIJw-fnNoiAhYARkYz7cP25udk
58	McKesson Corporation	ChIJw-fnNoiAhYARkYz7cP25udk
59	425 Market Street Building	ChIJc5SPsWOAhYARY9kqZIk2HUo
60	One Montgomery Tower	ChIJK5Rpz39hmoARKjcL9JTUw2E
61	333 Bush Street	ChIJhxhwkomAhYARJLhTkLrKoLo
62	Hilton San Francisco Union Square	ChIJeSJHoI-AhYARembxZUVcNEk
63	PG&E Pacific Energy Center	ChIJka2ABnt-j4AR71gZVOGofXw
64	Pacific Gas and Electric Company	ChIJka2ABnt-j4AR71gZVOGofXw
65	Pacific Gas and Electric Company Customer Service Office	ChIJka2ABnt-j4AR71gZVOGofXw
66	Pacific Gas & Electric Co	ChIJka2ABnt-j4AR71gZVOGofXw
67	Pacific Gas and Electric Company	ChIJka2ABnt-j4AR71gZVOGofXw
68	Pacific Gas and Electric Company	ChIJka2ABnt-j4AR71gZVOGofXw
69	Pacific Gas & Electric Co	ChIJka2ABnt-j4AR71gZVOGofXw
70	Regus San Francisco	ChIJMz9haGGAhYAR-HJdMe4mAqg
71	Bank of America Financial Center	ChIJMz9haGGAhYAR-HJdMe4mAqg
72	Chipotle Mexican Grill	ChIJMz9haGGAhYAR-HJdMe4mAqg
73	OfficeTeam	ChIJMz9haGGAhYAR-HJdMe4mAqg
74	Robert Half Legal	ChIJMz9haGGAhYAR-HJdMe4mAqg
75	Holland & Knight LLP	ChIJMz9haGGAhYAR-HJdMe4mAqg
76	YMCA	ChIJMz9haGGAhYAR-HJdMe4mAqg
77	Colliers International	ChIJMz9haGGAhYAR-HJdMe4mAqg
78	Piper Jaffray & Co	ChIJMz9haGGAhYAR-HJdMe4mAqg
79	Eichstaedt & Lervold, LLP	ChIJMz9haGGAhYAR-HJdMe4mAqg
80	The Creative Group	ChIJMz9haGGAhYAR-HJdMe4mAqg
81	Recology	ChIJMz9haGGAhYAR-HJdMe4mAqg
82	Nossaman LLP	ChIJMz9haGGAhYAR-HJdMe4mAqg
83	Woodruff-Sawyer & Co	ChIJMz9haGGAhYAR-HJdMe4mAqg
84	Kikkoman Sales USA Inc	ChIJMz9haGGAhYAR-HJdMe4mAqg
85	Nob Hill Notary Mobile & In-House Services	ChIJMz9haGGAhYAR-HJdMe4mAqg
86	Robert Half Technology	ChIJMz9haGGAhYAR-HJdMe4mAqg
87	FirstService Residential	ChIJMz9haGGAhYAR-HJdMe4mAqg
88	Huntsman Architectural Group	ChIJMz9haGGAhYAR-HJdMe4mAqg
89	Medley Partners LLC	ChIJMz9haGGAhYAR-HJdMe4mAqg
90	Standard Parking	ChIJfyky1mKAhYARMe-hYlNs-kY
91	Deloitte	ChIJfyky1mKAhYARMe-hYlNs-kY
92	Chase Bank	ChIJfyky1mKAhYARMe-hYlNs-kY
93	Silicon Valley Bank	ChIJfyky1mKAhYARMe-hYlNs-kY
94	HEYDAY - Organic Cafe and Bakery	ChIJfyky1mKAhYARMe-hYlNs-kY
95	Novak Druce Connolly Bove + Quigg LLP	ChIJfyky1mKAhYARMe-hYlNs-kY
96	A.T. Kearney, Inc.	ChIJfyky1mKAhYARMe-hYlNs-kY
97	Tishman Speyer	ChIJfyky1mKAhYARMe-hYlNs-kY
98	CNA San Francisco Branch	ChIJfyky1mKAhYARMe-hYlNs-kY
99	BNY Mellon Wealth Management San Francisco	ChIJfyky1mKAhYARMe-hYlNs-kY
100	Financial Technology Partners	ChIJfyky1mKAhYARMe-hYlNs-kY
101	Strata Apartments	ChIJfyky1mKAhYARMe-hYlNs-kY
102	DLA Piper	ChIJfyky1mKAhYARMe-hYlNs-kY
103	Gibson Dunn & Crutcher	ChIJfyky1mKAhYARMe-hYlNs-kY
104	Gibson Dunn & Crutcher: Cussen Deborah A	ChIJfyky1mKAhYARMe-hYlNs-kY
105	CodeFuel	ChIJfyky1mKAhYARMe-hYlNs-kY
106	Allianz Global Investors	ChIJfyky1mKAhYARMe-hYlNs-kY
107	Vinson & Elkins LLP	ChIJfyky1mKAhYARMe-hYlNs-kY
108	DLA Piper Us LLP: Sekimura Gerald	ChIJfyky1mKAhYARMe-hYlNs-kY
109	DLA Piper: Doyle Jon F	ChIJfyky1mKAhYARMe-hYlNs-kY
110	The St. Regis San Francisco	ChIJFzmL9IeAhYARH75pRwnV0sk
111	100 Pine	ChIJh57yKWKAhYARhFKmg6nNvcU
112	Shorenstein Company	ChIJNUaYmGOAhYARH8yGnLTcfvI
113	Wells Fargo Insurance Services	ChIJNUaYmGOAhYARH8yGnLTcfvI
114	333 Market	ChIJexu7D36AhYARfGmEs3pNQIM
115	Wells Fargo Bank	ChIJexu7D36AhYARfGmEs3pNQIM
116	Russell's Convenience	ChIJexu7D36AhYARfGmEs3pNQIM
117	Ace Parking	ChIJexu7D36AhYARfGmEs3pNQIM
118	650 California St LLC	ChIJ7bR-mIuAhYARUeYUUHDVtnM
119	Thornton Tomasetti	ChIJ7bR-mIuAhYARUeYUUHDVtnM
120	Credit Suisse AG (Investment Banking)	ChIJ7bR-mIuAhYARUeYUUHDVtnM
121	340 Fremont Apartments	ChIJgQJIqnuAhYARepV1YXAK_BI
122	One Medical Group	ChIJNSm-DZ-AhYARTqWLVvtLO7A
123	Climate One	ChIJNSm-DZ-AhYARTqWLVvtLO7A
124	One Workplace	ChIJNSm-DZ-AhYARTqWLVvtLO7A
125	One Medical Group	ChIJNSm-DZ-AhYARTqWLVvtLO7A
126	One Market Street	ChIJNSm-DZ-AhYARTqWLVvtLO7A
127	One Maritime Plaza	ChIJNSm-DZ-AhYARTqWLVvtLO7A
128	One Montgomery Tower	ChIJNSm-DZ-AhYARTqWLVvtLO7A
129	Embarcadero Center	ChIJNSm-DZ-AhYARTqWLVvtLO7A
130	One Market Restaurant	ChIJNSm-DZ-AhYARTqWLVvtLO7A
131	Capital One Café	ChIJNSm-DZ-AhYARTqWLVvtLO7A
132	Exam One	ChIJNSm-DZ-AhYARTqWLVvtLO7A
133	One Hallidie Plaza	ChIJNSm-DZ-AhYARTqWLVvtLO7A
134	One Hawthorne Sales Center	ChIJNSm-DZ-AhYARTqWLVvtLO7A
135	One Bush Plaza	ChIJNSm-DZ-AhYARTqWLVvtLO7A
136	San Francisco Soup Company	ChIJNSm-DZ-AhYARTqWLVvtLO7A
137	One Rincon Hill	ChIJNSm-DZ-AhYARTqWLVvtLO7A
138	Wells Fargo Bank	ChIJNSm-DZ-AhYARTqWLVvtLO7A
139	Oakwood Apartments	ChIJNSm-DZ-AhYARTqWLVvtLO7A
140	Regus San Francisco	ChIJNSm-DZ-AhYARTqWLVvtLO7A
141	One Medical Group	ChIJNSm-DZ-AhYARTqWLVvtLO7A
142	San Francisco Marriott Marquis	ChIJne1RNoaAhYARQ0LNBX6AFyQ
143	San Francisco Marriott Union Square	ChIJne1RNoaAhYARQ0LNBX6AFyQ
144	JW Marriott San Francisco Union Square	ChIJne1RNoaAhYARQ0LNBX6AFyQ
145	Courtyard San Francisco Downtown	ChIJne1RNoaAhYARQ0LNBX6AFyQ
146	Bin 55	ChIJne1RNoaAhYARQ0LNBX6AFyQ
147	Courtyard San Francisco Union Square	ChIJne1RNoaAhYARQ0LNBX6AFyQ
148	SF Marriott Massage & Fitness Center	ChIJne1RNoaAhYARQ0LNBX6AFyQ
149	Yelp	ChIJ7_fCtouAhYARg7soTOgic8Q
150	Mourad	ChIJ7_fCtouAhYARg7soTOgic8Q
151	Trou Normand	ChIJ7_fCtouAhYARg7soTOgic8Q
152	Bloomberg Tech	ChIJ7_fCtouAhYARg7soTOgic8Q
153	Apcera	ChIJ7_fCtouAhYARg7soTOgic8Q
154	AmWINS Insurance Brokerage of California	ChIJ7_fCtouAhYARg7soTOgic8Q
155	Knoll	ChIJ7_fCtouAhYARg7soTOgic8Q
156	G2 Insurance	ChIJ7_fCtouAhYARg7soTOgic8Q
157	Russ Building Garage	ChIJkYbnH4qAhYARE9q5MOy2Sp0
158	505 Montgomery Garage	ChIJJSk-9IqAhYARe6ED4StsXmE
159	Regus San Francisco	ChIJJSk-9IqAhYARe6ED4StsXmE
160	Bank of the West	ChIJJSk-9IqAhYARe6ED4StsXmE
161	Palio Caffe	ChIJJSk-9IqAhYARe6ED4StsXmE
162	Latham & Watkins LLP	ChIJJSk-9IqAhYARe6ED4StsXmE
163	BookATailor San Francisco Showroom	ChIJJSk-9IqAhYARe6ED4StsXmE
164	Helen's Place	ChIJJSk-9IqAhYARe6ED4StsXmE
165	Payroll Resourcesce Group	ChIJJSk-9IqAhYARe6ED4StsXmE
166	Venable LLP, San Francisco, CA	ChIJJSk-9IqAhYARe6ED4StsXmE
167	Guarantee Mortgage	ChIJJSk-9IqAhYARe6ED4StsXmE
168	Low, Ball & Lynch	ChIJJSk-9IqAhYARe6ED4StsXmE
169	Alderwood Capital LLC	ChIJJSk-9IqAhYARe6ED4StsXmE
170	Portcullis, Inc.	ChIJJSk-9IqAhYARe6ED4StsXmE
171	Regus	ChIJJSk-9IqAhYARe6ED4StsXmE
172	Latham & Watkins: Ogloza Darius	ChIJJSk-9IqAhYARe6ED4StsXmE
173	The Infinity Towers	ChIJ3Qt5xnqAhYARuoJLmmzaTIY
174	JPMorgan Chase	ChIJW4zOCRN-j4ARFWpPmieFHsg
175	JPMorgan Chase	ChIJW4zOCRN-j4ARFWpPmieFHsg
176	JPMorgan Chase	ChIJW4zOCRN-j4ARFWpPmieFHsg
177	JPMorgan Chase	ChIJW4zOCRN-j4ARFWpPmieFHsg
178	Chase Bank	ChIJW4zOCRN-j4ARFWpPmieFHsg
179	JPMorgan Chase	ChIJW4zOCRN-j4ARFWpPmieFHsg
180	The Paramount Luxury Apartments	ChIJW4wwR4mAhYARDSUTkiCTdYY
181	Paramount Student Housing - The Park	ChIJW4wwR4mAhYARDSUTkiCTdYY
182	BBVA San Francisco Rep Office	ChIJVcNxG5qAhYAR_MvGwepvjZE
183	Varden Pacific LLC	ChIJVcNxG5qAhYAR_MvGwepvjZE
184	The Atashi Rang Law Firm PC	ChIJVcNxG5qAhYAR_MvGwepvjZE
185	Silicon Legal Strategy	ChIJVcNxG5qAhYAR_MvGwepvjZE
186	Spring Studio	ChIJVcNxG5qAhYAR_MvGwepvjZE
187	Procore	ChIJVcNxG5qAhYAR_MvGwepvjZE
188	Seal Software	ChIJVcNxG5qAhYAR_MvGwepvjZE
189	Concepcion Enterprises, LLC	ChIJVcNxG5qAhYAR_MvGwepvjZE
190	Clustrix Inc	ChIJVcNxG5qAhYAR_MvGwepvjZE
191	Provident Credit Union, San Francisco Community Branch (Federal Building)	ChIJVcNxG5qAhYAR_MvGwepvjZE
192	Three Embarcadero Center	ChIJj5R7F2GAhYARubN1VnuNZZM
193	Embarcadero Center	ChIJZ76fAGGAhYARX3kjrSwKu8Q
194	One Medical Group	ChIJZ76fAGGAhYARX3kjrSwKu8Q
195	Consumer Credit Counseling Service of San Francisco	ChIJ75fLhWKAhYARnKrmO1VBbcU
196	Chase Bank	ChIJ75fLhWKAhYARnKrmO1VBbcU
197	Uno Dos Tacos	ChIJ75fLhWKAhYARnKrmO1VBbcU
198	Consulate General of Singapore	ChIJ75fLhWKAhYARnKrmO1VBbcU
199	FinancialForce.com	ChIJ75fLhWKAhYARnKrmO1VBbcU
200	Creative Circle	ChIJ75fLhWKAhYARnKrmO1VBbcU
201	Calypso Technology	ChIJ75fLhWKAhYARnKrmO1VBbcU
202	Rockman et al, Inc.	ChIJ75fLhWKAhYARnKrmO1VBbcU
203	BALANCE	ChIJ75fLhWKAhYARnKrmO1VBbcU
204	RemX IT Staffing	ChIJ75fLhWKAhYARnKrmO1VBbcU
205	Hedani Choy Spalding	ChIJ75fLhWKAhYARnKrmO1VBbcU
206	Chu & Waters	ChIJ75fLhWKAhYARnKrmO1VBbcU
207	SelectQuote Insurance Services	ChIJ75fLhWKAhYARnKrmO1VBbcU
208	Integrated Benefits Institute	ChIJ75fLhWKAhYARnKrmO1VBbcU
209	Bay Dynamics	ChIJ75fLhWKAhYARnKrmO1VBbcU
210	CERA LLP	ChIJ75fLhWKAhYARnKrmO1VBbcU
211	Nelson	ChIJ75fLhWKAhYARnKrmO1VBbcU
212	H5	ChIJ75fLhWKAhYARnKrmO1VBbcU
213	Carneghi-Blum & Partners Inc	ChIJ75fLhWKAhYARnKrmO1VBbcU
214	Mc Carthy Johnson & Miller	ChIJ75fLhWKAhYARnKrmO1VBbcU
215	100 Van Ness	ChIJx8Jssp6AhYAR95lVPh0wmwU
216	399 Fremont	ChIJ0x_HRXqAhYAROhkrk7dEktA
217	One Maritime Plaza	ChIJLTY_UGCAhYARqvWB2GQTfns
218	Bank of America Financial Center	ChIJeVXDo0H3MhUR3_X-jhB_VvQ
219	GLB 33 New Montgomery LP	ChIJeVXDo0H3MhUR3_X-jhB_VvQ
220	Learn IT	ChIJeVXDo0H3MhUR3_X-jhB_VvQ
221	Bre New Montgomery LLC	ChIJeVXDo0H3MhUR3_X-jhB_VvQ
222	Insight Global	ChIJeVXDo0H3MhUR3_X-jhB_VvQ
223	WeWork Transbay	ChIJLwiwJWOAhYARGaOiwPOYeJo
224	One Medical Group	ChIJLwiwJWOAhYARGaOiwPOYeJo
225	Shell Building Barber Shop	ChIJcZaNPWKAhYAReio9zTi-GAE
226	Raven Office Centers	ChIJa-JlzmOAhYARHQCQh3A5nx8
227	Dunhill Partners West	ChIJa-JlzmOAhYARHQCQh3A5nx8
228	Subway	ChIJa-JlzmOAhYARHQCQh3A5nx8
229	Market Street Chiropractic	ChIJa-JlzmOAhYARHQCQh3A5nx8
230	Miss Tomato Sandwich Shop	ChIJa-JlzmOAhYARHQCQh3A5nx8
231	Sushirrito - FIDI Market	ChIJa-JlzmOAhYARHQCQh3A5nx8
232	Davinci Virtual Office Solutions	ChIJa-JlzmOAhYARHQCQh3A5nx8
233	Jack's Shoe Services	ChIJa-JlzmOAhYARHQCQh3A5nx8
234	Bittner & Co	ChIJa-JlzmOAhYARHQCQh3A5nx8
235	Davinci Meeting Rooms	ChIJa-JlzmOAhYARHQCQh3A5nx8
236	Sirkin & Associates	ChIJa-JlzmOAhYARHQCQh3A5nx8
237	Allied Offices	ChIJa-JlzmOAhYARHQCQh3A5nx8
238	Puri Law	ChIJa-JlzmOAhYARHQCQh3A5nx8
239	P M Realty Group	ChIJa-JlzmOAhYARHQCQh3A5nx8
240	CGI Carol Gilbert Inc	ChIJa-JlzmOAhYARHQCQh3A5nx8
241	Buffington & Aaron: Aaron Diane	ChIJa-JlzmOAhYARHQCQh3A5nx8
242	Commercial Coverage Insurance Agency	ChIJa-JlzmOAhYARHQCQh3A5nx8
243	G3 Visas and Passports, Inc.	ChIJa-JlzmOAhYARHQCQh3A5nx8
244	CPIC International	ChIJa-JlzmOAhYARHQCQh3A5nx8
245	Dr. Akira Olsen Psychologist	ChIJa-JlzmOAhYARHQCQh3A5nx8
246	Tishman Speyer	ChIJh2VAamKAhYARsLFItXv13uk
247	Vector Capital	ChIJbbVEGGSAhYAR0LLRPNMilwo
248	RPX Corporation	ChIJbbVEGGSAhYAR0LLRPNMilwo
249	One Market Restaurant	ChIJbbVEGGSAhYAR0LLRPNMilwo
250	Citi Ventures	ChIJbbVEGGSAhYAR0LLRPNMilwo
251	Tucker Ellis LLP	ChIJbbVEGGSAhYAR0LLRPNMilwo
252	CoveredCo	ChIJbbVEGGSAhYAR0LLRPNMilwo
253	Bradley & Co LLC	ChIJbbVEGGSAhYAR0LLRPNMilwo
254	Duane Morris: Matthews Philip R	ChIJbbVEGGSAhYAR0LLRPNMilwo
255	Albertson & Davidson, LLP	ChIJbbVEGGSAhYAR0LLRPNMilwo
256	Ardian USA San Francisco	ChIJbbVEGGSAhYAR0LLRPNMilwo
257	SAP America Inc. - San Francisco	ChIJbbVEGGSAhYAR0LLRPNMilwo
258	MailUp	ChIJbbVEGGSAhYAR0LLRPNMilwo
259	ABM Parking Services	ChIJZ76fAGGAhYARXGFhbxFtl2g
260	Moss Adams LLP	ChIJZ76fAGGAhYARXGFhbxFtl2g
261	King & Spalding LLP	ChIJZ76fAGGAhYARXGFhbxFtl2g
262	Rowbotham & Company LLP	ChIJZ76fAGGAhYARXGFhbxFtl2g
263	HFF	ChIJZ76fAGGAhYARXGFhbxFtl2g
264	California Appellate Project	ChIJZ76fAGGAhYARXGFhbxFtl2g
265	Reed Smith LLP	ChIJZ76fAGGAhYARXGFhbxFtl2g
266	The Infinity Towers	ChIJ3Qt5xnqAhYARuoJLmmzaTIY
267	T R 601 California Corporation	ChIJjc-4touAhYAR4ofEQYpyAnc
268	Old Republic Title	ChIJjc-4touAhYAR4ofEQYpyAnc
269	Fidelity National Title	ChIJjc-4touAhYAR4ofEQYpyAnc
270	Fisher Development, Inc.	ChIJjc-4touAhYAR4ofEQYpyAnc
271	SKS Partners	ChIJjc-4touAhYAR4ofEQYpyAnc
272	Girard Gibbs LLP	ChIJjc-4touAhYAR4ofEQYpyAnc
273	Bledsoe, Cathcart, Diestel, Pedersen & Treppa, LLP	ChIJjc-4touAhYAR4ofEQYpyAnc
274	Field Research Corporation	ChIJjc-4touAhYAR4ofEQYpyAnc
275	Dennis M Sullivan Law Offices	ChIJjc-4touAhYAR4ofEQYpyAnc
276	Weiss & Weissman	ChIJjc-4touAhYAR4ofEQYpyAnc
277	Springs & Associates	ChIJjc-4touAhYAR4ofEQYpyAnc
278	Ware Malcomb | San Francisco	ChIJjc-4touAhYAR4ofEQYpyAnc
279	Traver Walter J	ChIJjc-4touAhYAR4ofEQYpyAnc
280	Alaska National Insurance	ChIJjc-4touAhYAR4ofEQYpyAnc
281	Weiss & Weissman: Seher Alan R	ChIJjc-4touAhYAR4ofEQYpyAnc
282	Avison Young	ChIJjc-4touAhYAR4ofEQYpyAnc
283	Main Management LLC	ChIJjc-4touAhYAR4ofEQYpyAnc
284	Family Law Offices of Robert J. Rothman	ChIJjc-4touAhYAR4ofEQYpyAnc
285	Bacchus Capital Management	ChIJjc-4touAhYAR4ofEQYpyAnc
286	Newport Asia LLC	ChIJjc-4touAhYAR4ofEQYpyAnc
287	BridgeView CFO	ChIJmVeqb_WAhYARMcQ6BEg4HGM
288	Bridgeview Owners Association	ChIJmVeqb_WAhYARMcQ6BEg4HGM
289	Bridge View Funding Inc	ChIJmVeqb_WAhYARMcQ6BEg4HGM
290	Hines 55 Second Street LP	ChIJo6k9lmKAhYAR9894kyvnvxU
291	KPMG	ChIJo6k9lmKAhYAR9894kyvnvxU
292	Schlesinger	ChIJC2bxnWGAhYARZ8hc-3cWc3E
293	City National Bank	ChIJC2bxnWGAhYARZ8hc-3cWc3E
294	Wells Fargo Advisors	ChIJC2bxnWGAhYARZ8hc-3cWc3E
295	Colchis Capital Management, L.P.	ChIJC2bxnWGAhYARZ8hc-3cWc3E
296	Vista Equity Partners	ChIJC2bxnWGAhYARZ8hc-3cWc3E
297	Capital Access Group	ChIJC2bxnWGAhYARZ8hc-3cWc3E
298	Savills Studley	ChIJC2bxnWGAhYARZ8hc-3cWc3E
299	Harrington Maureen A	ChIJC2bxnWGAhYARZ8hc-3cWc3E
300	Field Paoli Architects	ChIJC2bxnWGAhYARZ8hc-3cWc3E
301	Blackstone Technology Group	ChIJC2bxnWGAhYARZ8hc-3cWc3E
302	N.F. Stroth & Associates, LLC	ChIJC2bxnWGAhYARZ8hc-3cWc3E
303	GCA Savvian	ChIJC2bxnWGAhYARZ8hc-3cWc3E
304	Redwood Energy Co	ChIJC2bxnWGAhYARZ8hc-3cWc3E
305	Technvison Management	ChIJC2bxnWGAhYARZ8hc-3cWc3E
306	Puchulski Stang Ziehl Young: Singer Pamela E	ChIJC2bxnWGAhYARZ8hc-3cWc3E
307	Medigroup Management LP	ChIJC2bxnWGAhYARZ8hc-3cWc3E
308	Mesirow Financial Administration Corporation	ChIJC2bxnWGAhYARZ8hc-3cWc3E
309	643 Capital Management	ChIJC2bxnWGAhYARZ8hc-3cWc3E
310	Pachulski Stang Ziehl Jones: Bertenthal David M	ChIJC2bxnWGAhYARZ8hc-3cWc3E
311	Microdesk, Inc.	ChIJC2bxnWGAhYARZ8hc-3cWc3E
312	Coffee Cultures	ChIJZXDI4YmAhYARnAMpXX7zBpU
313	ProPark	ChIJZXDI4YmAhYARnAMpXX7zBpU
314	Benefit Cosmetics HQ	ChIJZXDI4YmAhYARnAMpXX7zBpU
315	CVS Pharmacy	ChIJZXDI4YmAhYARnAMpXX7zBpU
316	Target	ChIJZXDI4YmAhYARnAMpXX7zBpU
317	CKGS Visa Application Center San Francisco	ChIJZXDI4YmAhYARnAMpXX7zBpU
318	JVS	ChIJZXDI4YmAhYARnAMpXX7zBpU
319	General Assembly San Francisco	ChIJZXDI4YmAhYARnAMpXX7zBpU
320	TinyCo, Inc.	ChIJZXDI4YmAhYARnAMpXX7zBpU
321	Meltwater Group	ChIJZXDI4YmAhYARnAMpXX7zBpU
322	Flynn Properties	ChIJZXDI4YmAhYARnAMpXX7zBpU
323	Flynn Restaurant Group	ChIJZXDI4YmAhYARnAMpXX7zBpU
324	India Passport Application Center San Francisco	ChIJZXDI4YmAhYARnAMpXX7zBpU
325	LiveRamp	ChIJZXDI4YmAhYARnAMpXX7zBpU
326	Ricoh USA	ChIJZXDI4YmAhYARnAMpXX7zBpU
327	Affirm, Inc.	ChIJZXDI4YmAhYARnAMpXX7zBpU
328	Groupon	ChIJZXDI4YmAhYARnAMpXX7zBpU
329	Nitro PDF	ChIJZXDI4YmAhYARnAMpXX7zBpU
330	National Lymphedema Network	ChIJZXDI4YmAhYARnAMpXX7zBpU
331	Lendify Financial LLC	ChIJZXDI4YmAhYARnAMpXX7zBpU
332	Hunter-Dulin Building	ChIJRV0ZxomAhYAR44NGV4Xa-08
333	The Summit	ChIJawZVGD1-j4ARCe5z3nWjEGY
334	Summit Furniture	ChIJawZVGD1-j4ARCe5z3nWjEGY
335	The Summit SF	ChIJawZVGD1-j4ARCe5z3nWjEGY
336	The Ritz-Carlton Club, San Francisco	ChIJf17NcIyAhYARD9lFyiQWVcg
337	Hastings Tower	ChIJtxQY35qAhYARc6Rpc_IHhW8
338	PG&E Pacific Energy Center	ChIJBfmZpoyAhYAR3d-DlZfDVco
339	PG&E Corporation	ChIJBfmZpoyAhYAR3d-DlZfDVco
340	Pacific Gas and Electric Company	ChIJBfmZpoyAhYAR3d-DlZfDVco
341	Pacific Gas and Electric Company Customer Service Office	ChIJBfmZpoyAhYAR3d-DlZfDVco
342	Solaire	ChIJvxanInuAhYARwbG9SVp-q3w
343	Central Tower Market	ChIJF-l7ZYiAhYARKE6JvZNUJPQ
344	Central Towers Apartments	ChIJF-l7ZYiAhYARKE6JvZNUJPQ
345	Central Tower Office Building	ChIJF-l7ZYiAhYARKE6JvZNUJPQ
346	Hobart Building Office	ChIJXy_Z1ImAhYARJGOdimh_r6Y
347	Le Méridien San Francisco	ChIJcWfgM2CAhYARD19rCAPLhVU
348	Ferry Building	ChIJWTGPjmaAhYAR6c9cUJ1axtM
349	Ferry Plaza Farmers Market	ChIJWTGPjmaAhYAR6c9cUJ1axtM
350	Blue Bottle Coffee	ChIJWTGPjmaAhYAR6c9cUJ1axtM
351	San Francisco Federal Building	ChIJawzOqISAhYARUySdEKzydUI
352	Coit Tower	ChIJAQAAQIyAhYARRN3yIQG4hd4
353	First Person, Inc	ChIJ4-0AFn-AhYAR8U3tZOE1RFs
354	Intercontinental San Francisco	ChIJF1lX2oaAhYARuyWPqjE12Oo
355	The Monadnock Building	ChIJj3bDaoiAhYAR1w2LBOLmKlw
\.


--
-- Name: tenants_tenant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('tenants_tenant_id_seq', 355, true);


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
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

