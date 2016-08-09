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
    rank integer,
    status character varying(64),
    building_name character varying(128),
    city character varying(64),
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
-- Name: bldg_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY buildings ALTER COLUMN bldg_id SET DEFAULT nextval('buildings_bldg_id_seq'::regclass);


--
-- Data for Name: buildings; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY buildings (bldg_id, rank, status, building_name, city, height_m, height_ft, floors, completed_yr, material, use) FROM stdin;
1	1	Under Construction	Salesforce Tower	San Francisco	326.1	1070	61	2018	composite	office
2	2	Completed	Transamerica Pyramid	San Francisco	260	853	48	1972	composite	office
3	3	Under Construction	181 Fremont	San Francisco	244.4	802	54	2017	steel	residential / office
4	4	Completed	555 California Street	San Francisco	237.4	779	52	1969	steel	office
5	5	Completed	345 California Center	San Francisco	211.8	695	48	1986	steel	hotel / office
6	6	Completed	Millennium Tower	San Francisco	196.6	645	58	2009	concrete	residential
7	7	Completed	One Rincon Hill South Tower	San Francisco	184.4	605	54	2008	concrete	residential
8	8	Completed	101 California Street	San Francisco	183	600	48	1982	steel	office
9	9	Completed	50 Fremont Center	San Francisco	183	600	43	1985	steel	office
10	10	Completed	Chevron Tower	San Francisco	174.6	573	40	1975	steel	office
11	11	Completed	Four Embarcadero Center	San Francisco	173.7	570	45	1984	steel	office
12	12	Completed	One Embarcadero Center	San Francisco	173.4	569	45	1970	steel	office
13	13	Completed	44 Montgomery	San Francisco	172.3	565	43	1967	steel	office
14	14	Completed	Spear Tower	San Francisco	172	564	42	1976	steel	office
15	15	Completed	One Sansome Street	San Francisco	168	551	43	1984	steel	office
16	16	Completed	One Rincon Hill North Tower	San Francisco	165	541	45	2014	steel	residential
17	17	Completed	Shaklee Terrace Building	San Francisco	164	538	38	1982	steel	office
18	18	Completed	First Market Tower	San Francisco	161.2	529	38	1972	steel	office
19	18	Completed	McKesson Plaza	San Francisco	161.2	529	38	1969	steel	office
20	20	Completed	425 Market Street	San Francisco	159.7	524	38	1973	steel	office
21	21	Completed	Telesis Tower	San Francisco	152.4	500	38	1982	steel	office
22	22	Completed	333 Bush Street	San Francisco	150.9	495	43	1986	steel	residential / office
23	23	Completed	Hilton San Francisco Union Square	San Francisco	150.3	493	46	1971	steel	hotel
24	24	Completed	Pacific Gas & Electric Building	San Francisco	150	492	34	1971	steel	office
25	25	Completed	50 California Street	San Francisco	148.4	487	37	1972	steel	office
26	26	Completed	555 Mission Street	San Francisco	148.4	487	33	2008	steel	office
27	27	Completed	St. Regis San Francisco	San Francisco	147.5	484	42	2005	concrete	residential / hotel
28	28	Completed	100 Pine Center	San Francisco	145.1	476	34	1972	steel	office
29	29	Completed	45 Fremont Center	San Francisco	145	476	34	1979	steel	office
30	30	Completed	333 Market Building	San Francisco	144	472	33	1979	steel	office
31	31	Completed	650 California Street	San Francisco	142	466	33	1964	steel	office
32	32	Under Construction	340 Fremont Street	San Francisco	134.1	440	40	2016	concrete	residential
33	33	Completed	One California	San Francisco	133.5	438	32	1969	steel	office
34	34	Completed	San Francisco Marriott	San Francisco	132.9	436	39	1989	steel	hotel
35	35	Completed	140 New Montgomery Street	San Francisco	132.7	435	26	1925	steel	residential / hotel
36	36	Completed	Russ Building	San Francisco	132.6	435	32	1927	steel	office
37	37	Completed	505 Montgomery	San Francisco	129.5	425	24	1988	steel	office
38	38	Completed	The Infinity II	San Francisco	128	420	41	2009	concrete	residential
39	39	Completed	JPMorgan Chase Building	San Francisco	128	420	31	2002	steel	office
40	40	Completed	The Paramount	San Francisco	127.4	418	40	2002	precast	residential
41	41	Completed	Providian Financial Building	San Francisco	127	417	30	1983	steel	office
42	42	Completed	Three Embarcadero Center	San Francisco	126	413	31	1976	steel	office
43	42	Completed	Two Embarcadero Center	San Francisco	126	413	31	1974	steel	office
44	44	Completed	595 Market Street	San Francisco	125	410	30	1979	concrete	office
45	45	Completed	100 Van Ness	San Francisco	122	400	30	1974	steel	residential
46	46	Under Construction	399 Fremont	San Francisco	121.9	400	42	2016	concrete	residential
47	47	Completed	One Maritime Plaza	San Francisco	121.3	398	25	1967	steel	office
48	48	Completed	33 New Montgomery	San Francisco	116.5	382	21	1986	steel	office
49	49	Completed	535 Mission Street	San Francisco	115.4	379	26	2015	composite	office
50	50	Completed	Shell Building	San Francisco	115.2	378	29	1929	steel	office
51	51	Completed	388 Market Street	San Francisco	114.3	375	26	1985	steel	residential / office
52	52	Completed	222 Second Street	San Francisco	112.8	370	26	2015	steel/concrete	office
53	53	Completed	Steuart Tower	San Francisco	111	364	27	1976	steel	office
54	54	Completed	101 Second Street	San Francisco	108	354	26	1999	steel	office
55	55	Completed	The Infinity I	San Francisco	106.7	350	35	2008	concrete	office
56	56	Completed	601 California Street	San Francisco	106.4	349	22	1960	steel	office
57	57	Completed	Bridgeview	San Francisco	101.4	333	26	2002	concrete	residential / retail
58	58	Completed	55 Second Street	San Francisco	100.6	330	25	2002	steel	office
59	59	Completed	150 California Street	San Francisco	100.6	330	23	1999	steel	office
60	60	Completed	225 Bush Street	San Francisco	100	328	22	1922	steel	office
61	61	Completed	Hunter-Dulin Building	San Francisco	98.3	322	22	1926	steel	office
62	62	Completed	The Summit	San Francisco	96	315	32	1965	concrete	residential
63	63	Completed	Ritz Carlton Residence Club	San Francisco	95.1	312	24	1889	steel	residential / hotel
64	64	Completed	McAllister Tower Apartments	San Francisco	94.5	310	28	1930	steel	residential
65	65	Completed	PG&E Headquarters	San Francisco	93.5	307	18	1925	steel	office
66	66	Completed	299 Fremont	San Francisco	91.4	300	25	2016	concrete	residential
67	67	Completed	Central Tower	San Francisco	90.8	298	21	1938	steel	office
68	68	Completed	Hobart Building	San Francisco	86.9	285	21	1914	steel	office
69	69	Completed	Le Meridien San Francisco	San Francisco	82.9	272	25	1988	steel	hotel
70	70	Completed	Ferry Building	San Francisco	74.7	245	12	1898	steel	office / retail
71	71	Completed	San Francisco Federal Building	San Francisco	71.3	234	18	2007	concrete	office
72	72	Under Construction	San Francisco International Airport FAA Airport Traffic Control Tower (ATCT)	San Francisco	67.4	221	12	2015	steel/concrete	air traffic control tower
73	73	Completed	Coit Tower	San Francisco	64	210	13	1933	concrete	observation
74	74	Vision	Echelon on Rincon Hill	San Francisco	 	 	42	 	concrete	residential
75	75	Completed	The InterContinental San Francisco	San Francisco	 	 	40	2008	concrete	hotel
76	76	Completed	Humboldt Bank Building	San Francisco	 	 	19	1908	steel	office
\.


--
-- Name: buildings_bldg_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('buildings_bldg_id_seq', 1, false);


--
-- Name: buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY buildings
    ADD CONSTRAINT buildings_pkey PRIMARY KEY (bldg_id);


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

