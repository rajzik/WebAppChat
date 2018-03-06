--
-- PostgreSQL database dump
--

-- Dumped from database version 10.2
-- Dumped by pg_dump version 10.1

-- Started on 2018-03-07 00:01:59

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2269 (class 1262 OID 16384)
-- Dependencies: 2268
-- Name: webapp; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE webapp IS 'School project';


--
-- TOC entry 1 (class 3079 OID 12278)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2271 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 225 (class 1255 OID 16613)
-- Name: clear_ban(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION clear_ban() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
	IF NEW.banned_timestamp < now() - INTERVAL '5 minute' THEN
		NEW.banned_timestamp = NULL;
	END IF;
	RETURN NEW;
	END;
$$;


ALTER FUNCTION public.clear_ban() OWNER TO postgres;

--
-- TOC entry 216 (class 1255 OID 16580)
-- Name: clear_old_rooms(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION clear_old_rooms() RETURNS void
    LANGUAGE sql
    AS $$DELETE FROM public."Rooms"
	WHERE 
		last_active IS NOT NULL and 
		last_active < now() - INTERVAL '1 hour'
$$;


ALTER FUNCTION public.clear_old_rooms() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 211 (class 1259 OID 16730)
-- Name: Association_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Association_messages" (
    id integer NOT NULL,
    user1_id integer NOT NULL,
    message_id integer NOT NULL,
    user2_id integer NOT NULL
);


ALTER TABLE "Association_messages" OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16728)
-- Name: Association_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Association_messages_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Association_messages_id_seq" OWNER TO postgres;

--
-- TOC entry 2272 (class 0 OID 0)
-- Dependencies: 210
-- Name: Association_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Association_messages_id_seq" OWNED BY "Association_messages".id;


--
-- TOC entry 205 (class 1259 OID 16495)
-- Name: Chats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Chats" (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL,
    "Message" character varying(1000) NOT NULL
);


ALTER TABLE "Chats" OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16493)
-- Name: Chats_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Chats_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Chats_id_seq" OWNER TO postgres;

--
-- TOC entry 2273 (class 0 OID 0)
-- Dependencies: 204
-- Name: Chats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Chats_id_seq" OWNED BY "Chats".id;


--
-- TOC entry 207 (class 1259 OID 16659)
-- Name: Friends; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Friends" (
    id integer NOT NULL,
    user_id integer NOT NULL,
    friend_id integer NOT NULL
);


ALTER TABLE "Friends" OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16657)
-- Name: Friends_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Friends_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Friends_id_seq" OWNER TO postgres;

--
-- TOC entry 2274 (class 0 OID 0)
-- Dependencies: 206
-- Name: Friends_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Friends_id_seq" OWNED BY "Friends".id;


--
-- TOC entry 203 (class 1259 OID 16487)
-- Name: Groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Groups" (
    id integer NOT NULL,
    room_id integer NOT NULL,
    user_id integer NOT NULL,
    last_active timestamp without time zone DEFAULT now() NOT NULL,
    banned_timestamp timestamp with time zone
);


ALTER TABLE "Groups" OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16485)
-- Name: Group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Group_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Group_id_seq" OWNER TO postgres;

--
-- TOC entry 2275 (class 0 OID 0)
-- Dependencies: 202
-- Name: Group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Group_id_seq" OWNED BY "Groups".id;


--
-- TOC entry 209 (class 1259 OID 16694)
-- Name: Messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Messages" (
    id bigint NOT NULL,
    message character(1000) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "Messages" OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16692)
-- Name: Messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Messages_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Messages_id_seq" OWNER TO postgres;

--
-- TOC entry 2276 (class 0 OID 0)
-- Dependencies: 208
-- Name: Messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Messages_id_seq" OWNED BY "Messages".id;


--
-- TOC entry 199 (class 1259 OID 16449)
-- Name: Rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Rooms" (
    id integer NOT NULL,
    room_name character(255) COLLATE pg_catalog."POSIX" NOT NULL,
    admin_id integer NOT NULL,
    is_locked boolean DEFAULT false NOT NULL,
    last_active timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "Rooms" OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16447)
-- Name: Rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Rooms_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Rooms_id_seq" OWNER TO postgres;

--
-- TOC entry 2277 (class 0 OID 0)
-- Dependencies: 198
-- Name: Rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Rooms_id_seq" OWNED BY "Rooms".id;


--
-- TOC entry 197 (class 1259 OID 16401)
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Users" (
    id integer NOT NULL,
    user_name character(255) NOT NULL,
    first_name character(255) NOT NULL,
    last_name character(255) NOT NULL,
    is_super_user boolean DEFAULT false NOT NULL,
    password character(64) NOT NULL
);


ALTER TABLE "Users" OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16399)
-- Name: Users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Users_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Users_id_seq" OWNER TO postgres;

--
-- TOC entry 2278 (class 0 OID 0)
-- Dependencies: 196
-- Name: Users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Users_id_seq" OWNED BY "Users".id;


--
-- TOC entry 201 (class 1259 OID 16479)
-- Name: Whispers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Whispers" (
    id bigint NOT NULL,
    from_user_id bigint NOT NULL,
    to_user_id bigint NOT NULL,
    message character(1000) NOT NULL,
    CONSTRAINT user_ids_check CHECK ((from_user_id <= to_user_id))
);


ALTER TABLE "Whispers" OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16477)
-- Name: Whispers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Whispers_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Whispers_id_seq" OWNER TO postgres;

--
-- TOC entry 2279 (class 0 OID 0)
-- Dependencies: 200
-- Name: Whispers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Whispers_id_seq" OWNED BY "Whispers".id;


--
-- TOC entry 2085 (class 2604 OID 16733)
-- Name: Association_messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Association_messages" ALTER COLUMN id SET DEFAULT nextval('"Association_messages_id_seq"'::regclass);


--
-- TOC entry 2081 (class 2604 OID 16498)
-- Name: Chats id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Chats" ALTER COLUMN id SET DEFAULT nextval('"Chats_id_seq"'::regclass);


--
-- TOC entry 2082 (class 2604 OID 16662)
-- Name: Friends id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Friends" ALTER COLUMN id SET DEFAULT nextval('"Friends_id_seq"'::regclass);


--
-- TOC entry 2079 (class 2604 OID 16490)
-- Name: Groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Groups" ALTER COLUMN id SET DEFAULT nextval('"Group_id_seq"'::regclass);


--
-- TOC entry 2083 (class 2604 OID 16697)
-- Name: Messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Messages" ALTER COLUMN id SET DEFAULT nextval('"Messages_id_seq"'::regclass);


--
-- TOC entry 2074 (class 2604 OID 16452)
-- Name: Rooms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Rooms" ALTER COLUMN id SET DEFAULT nextval('"Rooms_id_seq"'::regclass);


--
-- TOC entry 2072 (class 2604 OID 16404)
-- Name: Users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Users" ALTER COLUMN id SET DEFAULT nextval('"Users_id_seq"'::regclass);


--
-- TOC entry 2077 (class 2604 OID 16482)
-- Name: Whispers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Whispers" ALTER COLUMN id SET DEFAULT nextval('"Whispers_id_seq"'::regclass);


--
-- TOC entry 2263 (class 0 OID 16730)
-- Dependencies: 211
-- Data for Name: Association_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Association_messages" (id, user1_id, message_id, user2_id) FROM stdin;
\.


--
-- TOC entry 2257 (class 0 OID 16495)
-- Dependencies: 205
-- Data for Name: Chats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Chats" (id, user_id, group_id, "Message") FROM stdin;
\.


--
-- TOC entry 2259 (class 0 OID 16659)
-- Dependencies: 207
-- Data for Name: Friends; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Friends" (id, user_id, friend_id) FROM stdin;
\.


--
-- TOC entry 2255 (class 0 OID 16487)
-- Dependencies: 203
-- Data for Name: Groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Groups" (id, room_id, user_id, last_active, banned_timestamp) FROM stdin;
1	1	1	2018-03-04 22:41:49.607403	\N
2	1	2	2018-03-04 22:41:54.880807	\N
\.


--
-- TOC entry 2261 (class 0 OID 16694)
-- Dependencies: 209
-- Data for Name: Messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Messages" (id, message, "timestamp") FROM stdin;
\.


--
-- TOC entry 2251 (class 0 OID 16449)
-- Dependencies: 199
-- Data for Name: Rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Rooms" (id, room_name, admin_id, is_locked, last_active) FROM stdin;
1	test                                                                                                                                                                                                                                                           	1	f	2018-03-04 22:36:13.276888+01
2	test                                                                                                                                                                                                                                                           	1	f	2018-03-04 22:36:18.86155+01
3	test                                                                                                                                                                                                                                                           	1	f	2018-03-04 22:36:19.654722+01
4	test                                                                                                                                                                                                                                                           	1	f	2018-03-04 22:36:20.338554+01
\.


--
-- TOC entry 2249 (class 0 OID 16401)
-- Dependencies: 197
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Users" (id, user_name, first_name, last_name, is_super_user, password) FROM stdin;
1	test1                                                                                                                                                                                                                                                          	test                                                                                                                                                                                                                                                           	test                                                                                                                                                                                                                                                           	f	098f6bcd4621d373cade4e832627b4f6                                
2	test2                                                                                                                                                                                                                                                          	test                                                                                                                                                                                                                                                           	test                                                                                                                                                                                                                                                           	t	098f6bcd4621d373cade4e832627b4f6                                
\.


--
-- TOC entry 2253 (class 0 OID 16479)
-- Dependencies: 201
-- Data for Name: Whispers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Whispers" (id, from_user_id, to_user_id, message) FROM stdin;
13	1	2	Hello?                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
12	1	1	Sup?                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
\.


--
-- TOC entry 2280 (class 0 OID 0)
-- Dependencies: 210
-- Name: Association_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Association_messages_id_seq"', 1, false);


--
-- TOC entry 2281 (class 0 OID 0)
-- Dependencies: 204
-- Name: Chats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Chats_id_seq"', 1, false);


--
-- TOC entry 2282 (class 0 OID 0)
-- Dependencies: 206
-- Name: Friends_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Friends_id_seq"', 1, false);


--
-- TOC entry 2283 (class 0 OID 0)
-- Dependencies: 202
-- Name: Group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Group_id_seq"', 2, true);


--
-- TOC entry 2284 (class 0 OID 0)
-- Dependencies: 208
-- Name: Messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Messages_id_seq"', 1, false);


--
-- TOC entry 2285 (class 0 OID 0)
-- Dependencies: 198
-- Name: Rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Rooms_id_seq"', 4, true);


--
-- TOC entry 2286 (class 0 OID 0)
-- Dependencies: 196
-- Name: Users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Users_id_seq"', 2, true);


--
-- TOC entry 2287 (class 0 OID 0)
-- Dependencies: 200
-- Name: Whispers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Whispers_id_seq"', 13, true);


--
-- TOC entry 2110 (class 2606 OID 16735)
-- Name: Association_messages Association_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Association_messages"
    ADD CONSTRAINT "Association_messages_pkey" PRIMARY KEY (id);


--
-- TOC entry 2100 (class 2606 OID 16500)
-- Name: Chats Chats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Chats"
    ADD CONSTRAINT "Chats_pkey" PRIMARY KEY (id);


--
-- TOC entry 2104 (class 2606 OID 16664)
-- Name: Friends Friends_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Friends"
    ADD CONSTRAINT "Friends_pkey" PRIMARY KEY (id);


--
-- TOC entry 2096 (class 2606 OID 16492)
-- Name: Groups Group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Groups"
    ADD CONSTRAINT "Group_pkey" PRIMARY KEY (id);


--
-- TOC entry 2108 (class 2606 OID 16702)
-- Name: Messages Messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Messages"
    ADD CONSTRAINT "Messages_pkey" PRIMARY KEY (id);


--
-- TOC entry 2089 (class 2606 OID 16457)
-- Name: Rooms Rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Rooms"
    ADD CONSTRAINT "Rooms_pkey" PRIMARY KEY (id);


--
-- TOC entry 2087 (class 2606 OID 16409)
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- TOC entry 2092 (class 2606 OID 16484)
-- Name: Whispers Whispers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Whispers"
    ADD CONSTRAINT "Whispers_pkey" PRIMARY KEY (id);


--
-- TOC entry 2090 (class 1259 OID 16555)
-- Name: fki_admin_id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_admin_id_fkey ON "Rooms" USING btree (admin_id);


--
-- TOC entry 2105 (class 1259 OID 16691)
-- Name: fki_friend_id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_friend_id_fkey ON "Friends" USING btree (friend_id);


--
-- TOC entry 2106 (class 1259 OID 16675)
-- Name: fki_friends_user_id1_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_friends_user_id1_fkey ON "Friends" USING btree (user_id);


--
-- TOC entry 2111 (class 1259 OID 16741)
-- Name: fki_from_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_from_user_id ON "Association_messages" USING btree (user1_id);


--
-- TOC entry 2112 (class 1259 OID 16753)
-- Name: fki_message_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_message_id ON "Association_messages" USING btree (message_id);


--
-- TOC entry 2097 (class 1259 OID 16531)
-- Name: fki_room_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_room_fkey ON "Groups" USING btree (room_id);


--
-- TOC entry 2113 (class 1259 OID 16747)
-- Name: fki_to_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_to_user_id ON "Association_messages" USING btree (user2_id);


--
-- TOC entry 2093 (class 1259 OID 16567)
-- Name: fki_user1_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_user1_fkey ON "Whispers" USING btree (from_user_id);


--
-- TOC entry 2094 (class 1259 OID 16573)
-- Name: fki_user2_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_user2_fkey ON "Whispers" USING btree (to_user_id);


--
-- TOC entry 2101 (class 1259 OID 16537)
-- Name: fki_user_id1_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_user_id1_fkey ON "Chats" USING btree (user_id);


--
-- TOC entry 2102 (class 1259 OID 16543)
-- Name: fki_user_id2_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_user_id2_fkey ON "Chats" USING btree (group_id);


--
-- TOC entry 2098 (class 1259 OID 16549)
-- Name: fki_user_id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_user_id_fkey ON "Groups" USING btree (user_id);


--
-- TOC entry 2126 (class 2620 OID 16616)
-- Name: Groups clear_bans; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER clear_bans BEFORE UPDATE ON "Groups" FOR EACH ROW EXECUTE PROCEDURE clear_ban();


--
-- TOC entry 2114 (class 2606 OID 16550)
-- Name: Rooms admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Rooms"
    ADD CONSTRAINT admin_id_fkey FOREIGN KEY (admin_id) REFERENCES "Users"(id);


--
-- TOC entry 2122 (class 2606 OID 16686)
-- Name: Friends friend_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Friends"
    ADD CONSTRAINT friend_id_fkey FOREIGN KEY (friend_id) REFERENCES "Users"(id);


--
-- TOC entry 2119 (class 2606 OID 16630)
-- Name: Chats group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Chats"
    ADD CONSTRAINT group_id_fkey FOREIGN KEY (group_id) REFERENCES "Groups"(id);


--
-- TOC entry 2123 (class 2606 OID 16748)
-- Name: Association_messages message_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Association_messages"
    ADD CONSTRAINT message_id FOREIGN KEY (message_id) REFERENCES "Messages"(id);


--
-- TOC entry 2117 (class 2606 OID 16526)
-- Name: Groups room_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Groups"
    ADD CONSTRAINT room_fkey FOREIGN KEY (room_id) REFERENCES "Rooms"(id) ON DELETE CASCADE;


--
-- TOC entry 2115 (class 2606 OID 16562)
-- Name: Whispers user1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Whispers"
    ADD CONSTRAINT user1_fkey FOREIGN KEY (from_user_id) REFERENCES "Users"(id);


--
-- TOC entry 2124 (class 2606 OID 16736)
-- Name: Association_messages user1_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Association_messages"
    ADD CONSTRAINT user1_id FOREIGN KEY (user1_id) REFERENCES "Users"(id);


--
-- TOC entry 2116 (class 2606 OID 16568)
-- Name: Whispers user2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Whispers"
    ADD CONSTRAINT user2_fkey FOREIGN KEY (to_user_id) REFERENCES "Users"(id);


--
-- TOC entry 2125 (class 2606 OID 16742)
-- Name: Association_messages user2_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Association_messages"
    ADD CONSTRAINT user2_id FOREIGN KEY (user2_id) REFERENCES "Users"(id);


--
-- TOC entry 2118 (class 2606 OID 16544)
-- Name: Groups user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Groups"
    ADD CONSTRAINT user_id_fkey FOREIGN KEY (user_id) REFERENCES "Users"(id);


--
-- TOC entry 2120 (class 2606 OID 16635)
-- Name: Chats user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Chats"
    ADD CONSTRAINT user_id_fkey FOREIGN KEY (user_id) REFERENCES "Users"(id);


--
-- TOC entry 2121 (class 2606 OID 16681)
-- Name: Friends user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Friends"
    ADD CONSTRAINT user_id_fkey FOREIGN KEY (user_id) REFERENCES "Users"(id);


-- Completed on 2018-03-07 00:01:59

--
-- PostgreSQL database dump complete
--

