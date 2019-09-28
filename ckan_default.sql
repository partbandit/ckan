--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.13
-- Dumped by pg_dump version 10.10 (Ubuntu 10.10-1.pgdg18.04+1)

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.activity (
    id text NOT NULL,
    "timestamp" timestamp(6) without time zone,
    user_id text,
    object_id text,
    revision_id text,
    activity_type text,
    data text
);


--
-- Name: activity_detail; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.activity_detail (
    id text NOT NULL,
    activity_id text,
    object_id text,
    object_type text,
    activity_type text,
    data text
);


--
-- Name: authorization_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authorization_group (
    id text NOT NULL,
    name text,
    created timestamp(6) without time zone
);


--
-- Name: authorization_group_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authorization_group_user (
    authorization_group_id text NOT NULL,
    user_id text NOT NULL,
    id text NOT NULL
);


--
-- Name: ckanext_pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ckanext_pages (
    id text NOT NULL,
    title text,
    name text,
    content text,
    lang text,
    "order" text,
    private boolean,
    group_id text,
    user_id text NOT NULL,
    created timestamp(6) without time zone,
    modified timestamp(6) without time zone,
    publish_date timestamp(6) without time zone,
    page_type text,
    extras text
);


--
-- Name: dashboard; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dashboard (
    user_id text NOT NULL,
    activity_stream_last_viewed timestamp(6) without time zone NOT NULL,
    email_last_sent timestamp(6) without time zone DEFAULT ('now'::text)::timestamp without time zone NOT NULL
);


--
-- Name: group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."group" (
    id text NOT NULL,
    name text NOT NULL,
    title text,
    description text,
    created timestamp(6) without time zone,
    state text,
    revision_id text,
    type text NOT NULL,
    approval_status text,
    image_url text,
    is_organization boolean DEFAULT false
);


--
-- Name: group_extra; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_extra (
    id text NOT NULL,
    group_id text,
    key text,
    value text,
    state text,
    revision_id text
);


--
-- Name: group_extra_revision; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_extra_revision (
    id text NOT NULL,
    group_id text,
    key text,
    value text,
    state text,
    revision_id text NOT NULL,
    continuity_id text,
    expired_id text,
    revision_timestamp timestamp(6) without time zone,
    expired_timestamp timestamp(6) without time zone,
    current boolean
);


--
-- Name: group_revision; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_revision (
    id text NOT NULL,
    name text NOT NULL,
    title text,
    description text,
    created timestamp(6) without time zone,
    state text,
    revision_id text NOT NULL,
    continuity_id text,
    expired_id text,
    revision_timestamp timestamp(6) without time zone,
    expired_timestamp timestamp(6) without time zone,
    current boolean,
    type text NOT NULL,
    approval_status text,
    image_url text,
    is_organization boolean DEFAULT false
);


--
-- Name: member; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.member (
    id text NOT NULL,
    table_id text NOT NULL,
    group_id text,
    state text,
    revision_id text,
    table_name text NOT NULL,
    capacity text NOT NULL
);


--
-- Name: member_revision; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.member_revision (
    id text NOT NULL,
    table_id text NOT NULL,
    group_id text,
    state text,
    revision_id text NOT NULL,
    continuity_id text,
    expired_id text,
    revision_timestamp timestamp(6) without time zone,
    expired_timestamp timestamp(6) without time zone,
    current boolean,
    table_name text NOT NULL,
    capacity text NOT NULL
);


--
-- Name: migrate_version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migrate_version (
    repository_id character varying(250) NOT NULL,
    repository_path text,
    version integer
);


--
-- Name: package; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.package (
    id text NOT NULL,
    name character varying(100) NOT NULL,
    title text,
    version character varying(100),
    url text,
    notes text,
    license_id text,
    revision_id text,
    author text,
    author_email text,
    maintainer text,
    maintainer_email text,
    state text,
    type text,
    owner_org text,
    private boolean DEFAULT false,
    metadata_modified timestamp(6) without time zone,
    creator_user_id text,
    metadata_created timestamp(6) without time zone
);


--
-- Name: package_extra; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.package_extra (
    id text NOT NULL,
    package_id text,
    key text,
    value text,
    revision_id text,
    state text
);


--
-- Name: package_extra_revision; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.package_extra_revision (
    id text NOT NULL,
    package_id text,
    key text,
    value text,
    revision_id text NOT NULL,
    continuity_id text,
    state text,
    expired_id text,
    revision_timestamp timestamp(6) without time zone,
    expired_timestamp timestamp(6) without time zone,
    current boolean
);


--
-- Name: package_relationship; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.package_relationship (
    id text NOT NULL,
    subject_package_id text,
    object_package_id text,
    type text,
    comment text,
    revision_id text,
    state text
);


--
-- Name: package_relationship_revision; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.package_relationship_revision (
    id text NOT NULL,
    subject_package_id text,
    object_package_id text,
    type text,
    comment text,
    revision_id text NOT NULL,
    continuity_id text,
    state text,
    expired_id text,
    revision_timestamp timestamp(6) without time zone,
    expired_timestamp timestamp(6) without time zone,
    current boolean
);


--
-- Name: package_revision; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.package_revision (
    id text NOT NULL,
    name character varying(100) NOT NULL,
    title text,
    version character varying(100),
    url text,
    notes text,
    license_id text,
    revision_id text NOT NULL,
    continuity_id text,
    author text,
    author_email text,
    maintainer text,
    maintainer_email text,
    state text,
    expired_id text,
    revision_timestamp timestamp(6) without time zone,
    expired_timestamp timestamp(6) without time zone,
    current boolean,
    type text,
    owner_org text,
    private boolean DEFAULT false,
    metadata_modified timestamp(6) without time zone,
    creator_user_id text,
    metadata_created timestamp(6) without time zone
);


--
-- Name: package_tag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.package_tag (
    id text NOT NULL,
    package_id text,
    tag_id text,
    revision_id text,
    state text
);


--
-- Name: package_tag_revision; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.package_tag_revision (
    id text NOT NULL,
    package_id text,
    tag_id text,
    revision_id text NOT NULL,
    continuity_id text,
    state text,
    expired_id text,
    revision_timestamp timestamp(6) without time zone,
    expired_timestamp timestamp(6) without time zone,
    current boolean
);


--
-- Name: rating; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rating (
    id text NOT NULL,
    user_id text,
    user_ip_address text,
    package_id text,
    rating double precision,
    created timestamp(6) without time zone
);


--
-- Name: resource; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource (
    id text NOT NULL,
    url text NOT NULL,
    format text,
    description text,
    "position" integer,
    revision_id text,
    hash text,
    state text,
    extras text,
    name text,
    resource_type text,
    mimetype text,
    mimetype_inner text,
    size bigint,
    last_modified timestamp(6) without time zone,
    cache_url text,
    cache_last_updated timestamp(6) without time zone,
    webstore_url text,
    webstore_last_updated timestamp(6) without time zone,
    created timestamp(6) without time zone,
    url_type text,
    package_id text DEFAULT ''::text NOT NULL
);


--
-- Name: resource_revision; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_revision (
    id text NOT NULL,
    url text NOT NULL,
    format text,
    description text,
    "position" integer,
    revision_id text NOT NULL,
    continuity_id text,
    hash text,
    state text,
    extras text,
    expired_id text,
    revision_timestamp timestamp(6) without time zone,
    expired_timestamp timestamp(6) without time zone,
    current boolean,
    name text,
    resource_type text,
    mimetype text,
    mimetype_inner text,
    size bigint,
    last_modified timestamp(6) without time zone,
    cache_url text,
    cache_last_updated timestamp(6) without time zone,
    webstore_url text,
    webstore_last_updated timestamp(6) without time zone,
    created timestamp(6) without time zone,
    url_type text,
    package_id text DEFAULT ''::text NOT NULL
);


--
-- Name: resource_view; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_view (
    id text NOT NULL,
    resource_id text,
    title text,
    description text,
    view_type text NOT NULL,
    "order" integer NOT NULL,
    config text
);


--
-- Name: revision; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.revision (
    id text NOT NULL,
    "timestamp" timestamp(6) without time zone,
    author character varying(200),
    message text,
    state text,
    approved_timestamp timestamp(6) without time zone
);


--
-- Name: system_info; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.system_info (
    id integer NOT NULL,
    key character varying(100) NOT NULL,
    value text,
    revision_id text,
    state text DEFAULT 'active'::text NOT NULL
);


--
-- Name: system_info_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.system_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: system_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.system_info_id_seq OWNED BY public.system_info.id;


--
-- Name: system_info_revision; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.system_info_revision (
    id integer NOT NULL,
    key character varying(100) NOT NULL,
    value text,
    revision_id text NOT NULL,
    continuity_id integer,
    state text DEFAULT 'active'::text NOT NULL,
    expired_id text,
    revision_timestamp timestamp(6) without time zone,
    expired_timestamp timestamp(6) without time zone,
    current boolean
);


--
-- Name: tag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tag (
    id text NOT NULL,
    name character varying(100) NOT NULL,
    vocabulary_id character varying(100)
);


--
-- Name: task_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.task_status (
    id text NOT NULL,
    entity_id text NOT NULL,
    entity_type text NOT NULL,
    task_type text NOT NULL,
    key text NOT NULL,
    value text NOT NULL,
    state text,
    error text,
    last_updated timestamp(6) without time zone
);


--
-- Name: term_translation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.term_translation (
    term text NOT NULL,
    term_translation text NOT NULL,
    lang_code text NOT NULL
);


--
-- Name: tracking_raw; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tracking_raw (
    user_key character varying(100) NOT NULL,
    url text NOT NULL,
    tracking_type character varying(10) NOT NULL,
    access_timestamp timestamp(6) without time zone DEFAULT now()
);


--
-- Name: tracking_summary; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tracking_summary (
    url text NOT NULL,
    package_id text,
    tracking_type character varying(10) NOT NULL,
    count integer NOT NULL,
    running_total integer DEFAULT 0 NOT NULL,
    recent_views integer DEFAULT 0 NOT NULL,
    tracking_date date
);


--
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."user" (
    id text NOT NULL,
    name text NOT NULL,
    apikey text,
    created timestamp(6) without time zone,
    about text,
    password text,
    fullname text,
    email text,
    reset_key text,
    sysadmin boolean DEFAULT false,
    activity_streams_email_notifications boolean DEFAULT false,
    state text DEFAULT 'active'::text NOT NULL
);


--
-- Name: user_following_dataset; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_following_dataset (
    follower_id text NOT NULL,
    object_id text NOT NULL,
    datetime timestamp(6) without time zone NOT NULL
);


--
-- Name: user_following_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_following_group (
    follower_id text NOT NULL,
    object_id text NOT NULL,
    datetime timestamp(6) without time zone NOT NULL
);


--
-- Name: user_following_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_following_user (
    follower_id text NOT NULL,
    object_id text NOT NULL,
    datetime timestamp(6) without time zone NOT NULL
);


--
-- Name: vocabulary; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vocabulary (
    id text NOT NULL,
    name character varying(100) NOT NULL
);


--
-- Name: system_info id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_info ALTER COLUMN id SET DEFAULT nextval('public.system_info_id_seq'::regclass);


--
-- Data for Name: activity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.activity (id, "timestamp", user_id, object_id, revision_id, activity_type, data) FROM stdin;
\.


--
-- Data for Name: activity_detail; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.activity_detail (id, activity_id, object_id, object_type, activity_type, data) FROM stdin;
\.


--
-- Data for Name: authorization_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authorization_group (id, name, created) FROM stdin;
\.


--
-- Data for Name: authorization_group_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authorization_group_user (authorization_group_id, user_id, id) FROM stdin;
\.


--
-- Data for Name: ckanext_pages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ckanext_pages (id, title, name, content, lang, "order", private, group_id, user_id, created, modified, publish_date, page_type, extras) FROM stdin;
\.


--
-- Data for Name: dashboard; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.dashboard (user_id, activity_stream_last_viewed, email_last_sent) FROM stdin;
428a2ba6-6250-498a-a9a1-73408163cf6a	2019-09-25 04:52:14.836984	2019-04-25 08:37:52.234399
\.


--
-- Data for Name: group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."group" (id, name, title, description, created, state, revision_id, type, approval_status, image_url, is_organization) FROM stdin;
\.


--
-- Data for Name: group_extra; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_extra (id, group_id, key, value, state, revision_id) FROM stdin;
\.


--
-- Data for Name: group_extra_revision; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_extra_revision (id, group_id, key, value, state, revision_id, continuity_id, expired_id, revision_timestamp, expired_timestamp, current) FROM stdin;
\.


--
-- Data for Name: group_revision; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_revision (id, name, title, description, created, state, revision_id, continuity_id, expired_id, revision_timestamp, expired_timestamp, current, type, approval_status, image_url, is_organization) FROM stdin;
\.


--
-- Data for Name: member; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.member (id, table_id, group_id, state, revision_id, table_name, capacity) FROM stdin;
\.


--
-- Data for Name: member_revision; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.member_revision (id, table_id, group_id, state, revision_id, continuity_id, expired_id, revision_timestamp, expired_timestamp, current, table_name, capacity) FROM stdin;
\.


--
-- Data for Name: migrate_version; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.migrate_version (repository_id, repository_path, version) FROM stdin;
Ckan	/mnt/d/SERVER/PythonProject/ubuntu/ckan-2.8.2-theme/ckan/migration	86
\.


--
-- Data for Name: package; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.package (id, name, title, version, url, notes, license_id, revision_id, author, author_email, maintainer, maintainer_email, state, type, owner_org, private, metadata_modified, creator_user_id, metadata_created) FROM stdin;
\.


--
-- Data for Name: package_extra; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.package_extra (id, package_id, key, value, revision_id, state) FROM stdin;
\.


--
-- Data for Name: package_extra_revision; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.package_extra_revision (id, package_id, key, value, revision_id, continuity_id, state, expired_id, revision_timestamp, expired_timestamp, current) FROM stdin;
\.


--
-- Data for Name: package_relationship; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.package_relationship (id, subject_package_id, object_package_id, type, comment, revision_id, state) FROM stdin;
\.


--
-- Data for Name: package_relationship_revision; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.package_relationship_revision (id, subject_package_id, object_package_id, type, comment, revision_id, continuity_id, state, expired_id, revision_timestamp, expired_timestamp, current) FROM stdin;
\.


--
-- Data for Name: package_revision; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.package_revision (id, name, title, version, url, notes, license_id, revision_id, continuity_id, author, author_email, maintainer, maintainer_email, state, expired_id, revision_timestamp, expired_timestamp, current, type, owner_org, private, metadata_modified, creator_user_id, metadata_created) FROM stdin;
\.


--
-- Data for Name: package_tag; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.package_tag (id, package_id, tag_id, revision_id, state) FROM stdin;
\.


--
-- Data for Name: package_tag_revision; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.package_tag_revision (id, package_id, tag_id, revision_id, continuity_id, state, expired_id, revision_timestamp, expired_timestamp, current) FROM stdin;
\.


--
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rating (id, user_id, user_ip_address, package_id, rating, created) FROM stdin;
\.


--
-- Data for Name: resource; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource (id, url, format, description, "position", revision_id, hash, state, extras, name, resource_type, mimetype, mimetype_inner, size, last_modified, cache_url, cache_last_updated, webstore_url, webstore_last_updated, created, url_type, package_id) FROM stdin;
\.


--
-- Data for Name: resource_revision; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_revision (id, url, format, description, "position", revision_id, continuity_id, hash, state, extras, expired_id, revision_timestamp, expired_timestamp, current, name, resource_type, mimetype, mimetype_inner, size, last_modified, cache_url, cache_last_updated, webstore_url, webstore_last_updated, created, url_type, package_id) FROM stdin;
\.


--
-- Data for Name: resource_view; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_view (id, resource_id, title, description, view_type, "order", config) FROM stdin;
\.


--
-- Data for Name: revision; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.revision (id, "timestamp", author, message, state, approved_timestamp) FROM stdin;
bafd23e3-84a0-433b-87e3-20e9728f4e43	2019-04-25 08:17:48.966945	system	Add versioning to groups, group_extras and package_groups	active	2019-04-25 08:17:48.966945
612a50b7-b617-4ff8-b369-bb462925685a	2019-04-25 08:17:50.153765	admin	Admin: make sure every object has a row in a revision table	active	2019-04-25 08:17:50.153765
ffc64850-a3fd-4a95-b10b-5026512f1ebc	2019-04-25 08:44:51.851581	\N	Set partner1_logo setting in system_info table	active	\N
75d04bd5-10f9-4d5e-8f8f-da2e5fbba869	2019-04-25 08:44:51.873742	\N	Set partner2_logo setting in system_info table	active	\N
f00b2e2d-f047-4404-b982-98072f45c294	2019-04-25 08:44:51.887502	\N	Set twitter_url setting in system_info table	active	\N
480d1272-aa79-4ad8-912e-979bd112ce7e	2019-04-25 08:44:51.89916	\N	Set partner7_link setting in system_info table	active	\N
78d8ee50-04c0-4820-99b7-b0451518c516	2019-04-25 08:44:51.909731	\N	Set partner7_logo setting in system_info table	active	\N
b58da4f7-8ca2-4be3-bcbf-40e38f792c6f	2019-04-25 08:44:51.920586	\N	Set partner4_link setting in system_info table	active	\N
1c64c45f-262e-4fff-bc3d-4b1a7355889f	2019-04-25 08:44:51.942749	\N	Set facebook_url setting in system_info table	active	\N
190adc63-6d3f-44a3-b9ea-8df023ff2e75	2019-04-25 08:44:51.954071	\N	Set partner1_link setting in system_info table	active	\N
1122827a-87dc-4f62-ba55-f72fe6473acf	2019-04-25 08:44:51.967286	\N	Set linkedIn_url setting in system_info table	active	\N
cc676e9d-b74a-4da1-bb76-04e45efc3b05	2019-04-25 08:44:51.97764	\N	Set partner4_logo setting in system_info table	active	\N
c774f2c9-ee15-477b-b8d7-f58da8522ca9	2019-04-25 08:44:51.98852	\N	Set partner5_logo setting in system_info table	active	\N
948dae87-dfc9-4aec-a2be-f981ea95f85b	2019-04-25 08:44:51.999025	\N	Set partner6_logo setting in system_info table	active	\N
b7b56240-a0d9-4cfd-93df-e1d2440c493c	2019-04-25 08:44:52.0093	\N	Set partner8_link setting in system_info table	active	\N
2d84fd72-907a-4366-8f86-32e3849f330e	2019-04-25 08:44:52.021081	\N	Set partner5_link setting in system_info table	active	\N
55f36b86-ccf1-4c10-9828-729957dcebf1	2019-04-25 08:44:52.031359	\N	Set partner3_link setting in system_info table	active	\N
808a5616-6de4-4d05-ad65-6477d5fcbd1c	2019-04-25 08:44:52.042584	\N	Set partner6_link setting in system_info table	active	\N
a5c6825c-81f9-4f6b-9278-e6d5857b1a24	2019-04-25 08:44:52.05892	\N	Set instagram_url setting in system_info table	active	\N
10097652-1a83-4a13-88c9-eb1733b1270f	2019-04-25 08:44:52.06903	\N	Set partner3_logo setting in system_info table	active	\N
f7704f68-9e67-43b3-9795-e1c87e8f007f	2019-04-25 08:44:52.079038	\N	Set partner8_logo setting in system_info table	active	\N
9379f51a-b6e1-4132-9ead-dcf4e63426bf	2019-04-25 08:44:52.089212	\N	Set partner2_link setting in system_info table	active	\N
1f507f35-d754-4284-8c82-590a6c8e520a	2019-04-25 08:44:52.099983	\N	Set ckan.config_update setting in system_info table	active	\N
c3722704-c1ac-47b7-b21c-32d34cdc632e	2019-04-25 08:47:20.294012	\N	Set linkedIn_url setting in system_info table	active	\N
cf2a816e-b5fc-44b1-83b4-f97fbec6d800	2019-04-25 08:47:20.321885	\N	Set ckan.config_update setting in system_info table	active	\N
a97677b9-cef3-4f30-a7fa-93fca8d1ea96	2019-04-25 09:41:02.041419	admin		active	\N
06b7a905-ec4c-4fd4-b99b-2e95af7a3f53	2019-04-25 09:41:02.107268	admin	REST API: Create member object 	active	\N
4ecc24cf-739d-47de-8c85-c4900cf94738	2019-04-25 09:41:48.694388	admin		active	\N
eb8c8592-91bd-417e-850d-f53b3a5309fa	2019-04-25 09:42:34.108063	admin	REST API: Update object data-smk-dan-dunia-industri	active	\N
c3b0b886-55df-4811-83ff-c842fca52939	2019-04-25 09:42:34.565601	admin	REST API: Update object data-smk-dan-dunia-industri	active	\N
6cd03fa3-eaf3-48ec-870c-e0031e0fce6f	2019-05-02 04:52:41.382505	\N	Set ckan.site_custom_css setting in system_info table	active	\N
f535e9e3-fdbe-4b42-a8b6-f4413157e176	2019-05-02 04:52:41.489932	\N	Set ckan.main_css setting in system_info table	active	\N
c14c50a2-2025-4392-b553-62c22ebe5db2	2019-05-02 04:52:41.505063	\N	Set ckan.site_title setting in system_info table	active	\N
74d06c39-f033-46d5-a9e7-aa67560446ef	2019-05-02 04:52:41.518348	\N	Set ckan.site_about setting in system_info table	active	\N
6d50c37d-e44a-4dc4-9ad4-6798c0419800	2019-05-02 04:52:41.531903	\N	Set ckan.site_logo setting in system_info table	active	\N
44baf2c6-f116-4b1a-b3f6-007b0620a4f5	2019-05-02 04:52:41.543056	\N	Set ckan.site_description setting in system_info table	active	\N
8d9010d6-e063-404f-a7c1-2a43b95c38c5	2019-05-02 04:52:41.556838	\N	Set ckan.site_intro_text setting in system_info table	active	\N
2c68fa11-93b2-495a-8274-ae311b61290b	2019-05-02 04:52:41.565697	\N	Set ckan.homepage_style setting in system_info table	active	\N
3543380b-66ab-409e-aa32-9f7987e9a0b9	2019-05-02 04:52:41.578139	\N	Set ckan.config_update setting in system_info table	active	\N
678c15d9-b79d-4498-8cba-cf13a8551d65	2019-05-02 07:19:44.788621	\N	Set ckan.main_css setting in system_info table	active	\N
81504a87-f46f-44ee-a9a1-849362ae0eca	2019-05-02 07:19:44.817007	\N	Set ckan.config_update setting in system_info table	active	\N
637a8881-7627-4eb2-b8b9-e0938f3fd42a	2019-05-02 07:20:03.86913	\N	Set ckan.main_css setting in system_info table	active	\N
5e24e960-0802-459f-a9ae-d356b46cb875	2019-05-02 07:20:03.888659	\N	Set ckan.homepage_style setting in system_info table	active	\N
808bb966-62c6-4abb-99b3-a92009e49df5	2019-05-02 07:20:03.902645	\N	Set ckan.config_update setting in system_info table	active	\N
41053147-b25c-4e4b-b9d1-0ad8894dc1bf	2019-05-02 07:20:25.349874	\N	Set ckan.homepage_style setting in system_info table	active	\N
c15b9b92-3116-4f5d-89b6-155afad37f38	2019-05-02 07:20:25.363294	\N	Set ckan.config_update setting in system_info table	active	\N
6fb1f8b4-9505-4a1c-9bd7-888d056502d4	2019-05-02 08:07:22.903966	admin		active	\N
060b869d-c082-4e67-b46c-17eaefbf3f44	2019-05-02 08:07:23.212819	admin	REST API: Create member object 	active	\N
631b9f64-233a-491b-bed3-6a6d09edd612	2019-05-02 08:18:23.565122	admin		active	\N
94fa82b1-f0d0-42d5-9f06-4c4a2a7c5142	2019-05-02 08:18:23.617236	admin	REST API: Create member object 	active	\N
92fb597a-f7bc-4644-a97a-17678cb89d55	2019-05-02 08:19:36.880743	admin		active	\N
434b1d3a-98cf-4f8f-bd47-fa040c5736e3	2019-05-02 08:19:36.957585	admin	REST API: Create member object 	active	\N
d02970e5-0101-4eca-910f-04da89e2f959	2019-05-02 08:22:55.748858	admin		active	\N
864ef95d-f9fb-4cb2-9c90-a13913de95ce	2019-05-02 08:22:55.785665	admin	REST API: Create member object 	active	\N
2f3aa1fc-fd98-41e5-817e-507af3cb142d	2019-05-02 08:23:12.216795	admin		active	\N
6ee34f5f-28ee-4f4e-b7b1-15c2fa777e9d	2019-05-02 08:23:12.253107	admin	REST API: Create member object 	active	\N
1cdb0216-9ec3-4a23-b599-8621d36b7bdb	2019-05-02 08:24:35.592241	admin		active	\N
bddaf7d7-3fae-4579-84ee-6b36374e7eae	2019-05-02 08:24:35.649665	admin	REST API: Create member object 	active	\N
657b5d3c-23a0-43e7-bcb2-33c03546e491	2019-05-02 08:33:41.059324	admin		active	\N
26187de9-881c-4ae0-8a3f-0eb90a693518	2019-05-02 08:33:57.527266	admin		active	\N
ddbf5e41-f765-4781-9c7e-50091c505def	2019-05-03 03:05:58.479124	\N	Set ckan.homepage_style setting in system_info table	active	\N
9507cb6a-1759-4353-ad68-1b67b9b71f56	2019-05-03 03:05:58.49932	\N	Set ckan.config_update setting in system_info table	active	\N
43e6b56f-4cda-42c6-a236-beaf957dc911	2019-05-03 03:06:13.107412	\N	Set ckan.config_update setting in system_info table	active	\N
d6e9e8e0-8e64-49cd-8f59-e69c4a5010e9	2019-05-03 03:06:13.09456	\N	Set ckan.homepage_style setting in system_info table	active	\N
c4003aec-bef1-4f48-a303-8762ab146302	2019-05-08 04:48:06.866289	admin	REST API: Delete Group: kesehatan	active	\N
c4e3abd2-5d85-4d54-8a7d-172cc2cb1ea2	2019-05-08 04:48:15.922186	admin	REST API: Delete Group: lapangan-kerja	active	\N
a1fc5137-9faf-43d3-affd-60649e8bad82	2019-05-08 04:48:23.473179	admin	REST API: Delete Group: pendidikan	active	\N
3b3ff22f-72a8-435a-9f22-dd8498f4f5cb	2019-05-08 04:48:30.914001	admin	REST API: Delete Group: perkebunan	active	\N
e427b374-31e5-4987-8065-efca1f16d5cf	2019-05-08 04:48:38.245044	admin	REST API: Delete Group: peternakan	active	\N
6fc4ee3c-003e-4f45-98dc-d3a96be42b78	2019-05-08 04:48:46.047713	admin	REST API: Delete Group: transportasi	active	\N
20c8410a-a66a-44fa-a4e4-65bbc7244729	2019-05-08 04:49:28.635675	admin		active	\N
c50e63bb-d245-46d2-84a0-a7255dc05f19	2019-05-08 04:49:28.768524	admin	REST API: Create member object 	active	\N
dae74ab6-8569-4ff0-b18e-01af81b480e1	2019-05-08 04:50:33.17839	admin		active	\N
beb76cc9-be26-4748-b969-4039d858ef45	2019-05-08 04:50:33.215562	admin	REST API: Create member object 	active	\N
1a2744f0-9cb1-4727-8481-d9b10fc21fe8	2019-05-08 04:50:54.769294	admin		active	\N
4fefd117-e6cf-4cdd-b6c3-fb44c6f7c38d	2019-05-08 04:50:54.81281	admin	REST API: Create member object 	active	\N
53b4864c-b13d-4400-ae2f-31314c73e2d0	2019-05-08 04:51:14.179958	admin		active	\N
d7d9f557-870d-4019-8e9c-649d792f63c7	2019-05-08 04:51:14.217034	admin	REST API: Create member object 	active	\N
a523d3dd-4594-4eec-b0a1-9498edebf987	2019-05-08 04:51:29.338143	admin		active	\N
8d7db1ad-5f10-4b3a-9e9e-e54147e223de	2019-05-08 04:51:29.386984	admin	REST API: Create member object 	active	\N
f684e5b1-3b56-4ff8-a86a-1ace6ecd1403	2019-05-08 04:51:43.800093	admin		active	\N
138a56a5-ac63-4303-ad5f-f4744d60936a	2019-05-08 04:51:43.892589	admin	REST API: Create member object 	active	\N
571a1e47-80d8-414a-bf9d-b4e6332df880	2019-05-08 04:51:59.732229	admin		active	\N
19d6337f-2d88-49c0-b123-3cdddce5cc23	2019-05-08 04:51:59.777466	admin	REST API: Create member object 	active	\N
ddc535ed-0fff-4afd-9e42-73d93deac905	2019-05-08 04:52:16.902342	admin		active	\N
55d71743-1a79-4792-8169-e520a4512898	2019-05-08 04:52:16.949453	admin	REST API: Create member object 	active	\N
13192dee-2c2f-48a0-99bf-544fd283bc21	2019-05-08 04:52:34.594819	admin		active	\N
8e425bd7-4087-47ca-a1d9-4475035973f8	2019-05-08 04:52:34.637682	admin	REST API: Create member object 	active	\N
055e5d46-39d8-4caa-b298-d010aa1c4d9f	2019-05-08 04:52:53.027978	admin		active	\N
74751f0c-8fbc-4f30-ac29-d44112649bea	2019-05-08 04:52:53.083657	admin	REST API: Create member object 	active	\N
768f81ba-99ff-4f8a-911d-6cea83d8bc47	2019-05-08 04:53:28.371887	admin		active	\N
5bd96676-10eb-45ab-8952-1c75700b0c8e	2019-05-08 04:53:43.224612	admin		active	\N
a39f917e-e93f-4b73-a9f6-edb5955c267e	2019-05-08 04:54:06.04239	admin		active	\N
7cfc0886-d924-4abc-b632-995a0667389e	2019-05-08 04:54:06.093019	admin	REST API: Create member object 	active	\N
fd597f62-e24e-4c1d-af00-15b00f82f5bf	2019-05-08 07:14:07.80224	admin		active	\N
30cf95ca-594e-4634-8a02-852ed60215f2	2019-05-08 07:14:08.063589	admin	REST API: Create member object 	active	\N
d41d337a-bb9b-442c-9053-041461857110	2019-07-22 07:49:32.041167	admin		active	\N
b354224e-5610-4468-9d00-f29bdb9985e1	2019-07-22 07:53:55.685423	admin	REST API: Update object wilayah-jawa-barat	active	\N
fdc7c0b8-ec66-4928-86f1-2840afa85550	2019-07-22 07:53:55.981726	admin	REST API: Update object wilayah-jawa-barat	active	\N
299491e2-1700-466e-9536-ab8509d111b2	2019-07-23 02:29:14.10558	admin	REST API: Delete Group: administrasi-pemerintahan	active	\N
26e3af8b-a1f9-40fc-966f-7002aba85651	2019-07-23 02:29:51.96728	admin	REST API: Delete Group: pekerjaan-umum	active	\N
2f673f61-c03a-4cce-863e-7379e8498671	2019-07-23 03:18:17.644886	\N	Set ckan.site_title setting in system_info table	active	\N
5eefbd48-a939-477c-b036-fe83d2282523	2019-07-23 03:18:17.706397	\N	Set ckan.config_update setting in system_info table	active	\N
c4940fbd-a120-4e10-a0b8-3b8f63f30685	2019-07-24 03:03:45.327151	admin	REST API: Membuat anggota dari objek 	active	\N
af466f8d-9133-4c6d-ba4b-e65f0616f313	2019-07-25 02:47:53.784523	admin	REST API: Memperbarui objek wilayah-jawa-barat	active	\N
90c9c1bc-7d97-4b30-b052-931f82990dd1	2019-07-25 02:52:19.661335	admin	REST API: Memperbarui objek wilayah-jawa-barat	active	\N
59475291-77d4-471c-be30-1e0420609c64	2019-07-25 03:27:50.194886	admin	REST API: Memperbarui objek wilayah-jawa-barat	active	\N
2e9f5be6-54d5-4096-9962-6c215c30d172	2019-07-25 03:40:26.283505	admin	REST API: Memperbarui objek wilayah-jawa-barat	active	\N
d4c618f1-16c5-4861-a62d-54a3aff0f973	2019-07-25 03:41:07.06732	admin	REST API: Memperbarui objek wilayah-jawa-barat	active	\N
aa94013a-f5e4-4f9b-9461-fe7429ac5246	2019-07-26 08:33:46.20618	admin	REST API: Membuat anggota dari objek 	active	\N
df202d45-eed5-4005-b536-e0fff74f7d79	2019-07-26 08:40:37.125485	admin	REST API: Delete Member: wilayah-jawa-barat	active	\N
b1832daa-0c0f-460d-b6a4-259133a89506	2019-07-26 08:40:39.932411	admin	REST API: Delete Member: wilayah-jawa-barat	active	\N
1e389550-117a-4b3d-a419-5af2b186c879	2019-07-29 08:31:32.481875	admin		active	\N
e4f86fbd-a14d-44bd-985c-5fc20c4fc422	2019-07-31 04:43:47.998491	admin	REST API: Memperbarui objek wilayah-jawa-barat	active	\N
1b5b79f5-3773-4530-b69a-46e48e93ddc0	2019-07-31 05:08:44.826583	admin	REST API: Memperbarui objek wilayah-jawa-barat	active	\N
fde1787e-fba6-4b57-8f75-fa4dea40e9bb	2019-07-31 05:11:11.44279	admin	REST API: Memperbarui objek wilayah-jawa-barat	active	\N
2f9d4ac7-10ef-4eef-a1a6-5b992a72b08b	2019-07-31 06:18:27.711155	admin	REST API: Memperbarui objek wilayah-jawa-barat	active	\N
5357ad50-3c54-4163-ae5a-24e396371273	2019-07-31 06:55:42.247316	admin	REST API: Memperbarui objek wilayah-jawa-barat	active	\N
c2bf82cd-8f89-42df-8bec-6c1031f1fe96	2019-08-09 02:23:12.775348	\N	Set partner4_link setting in system_info table	active	\N
239db10f-821a-4f89-ac84-4fa8bbbb6578	2019-08-09 02:23:12.967455	\N	Set partner4_logo setting in system_info table	active	\N
24d5abe1-b7ee-48ee-95f2-15ae4f7a7fb9	2019-08-09 02:23:13.02817	\N	Set partner3_link setting in system_info table	active	\N
8193657e-a8da-4d8c-a994-c2f347a16dcb	2019-08-09 02:23:13.100621	\N	Set partner3_logo setting in system_info table	active	\N
69367d56-e353-46d6-b662-e55a80fd34a1	2019-08-09 02:23:13.157379	\N	Set ckan.config_update setting in system_info table	active	\N
36ef61f9-de02-4d9c-b51c-8dac4da4dba4	2019-08-09 04:29:32.172335	\N	Set partner3_logo setting in system_info table	active	\N
c5ff31f0-7f39-43e7-bc31-eeb6242a32f2	2019-08-09 04:29:32.222046	\N	Set ckan.config_update setting in system_info table	active	\N
997cf72a-45cf-4994-861b-79cb7ce10a0a	2019-08-09 14:55:11.936201	admin	REST API: Membuat anggota dari objek 	active	\N
2c7d8a95-b29c-4655-98cf-1c9dc3ca059a	2019-09-20 09:16:54.866627	admin	REST API: Memperbarui objek my_dataset_name	active	\N
8264081c-d825-42ee-8e77-5cf54be8e5e6	2019-09-20 08:25:49.958603	admin	REST API: Membuat objek my_dataset_name	active	\N
be71f7aa-1a0a-4caf-b143-fe4d9122552b	2019-09-20 09:15:22.245079	admin	REST API: Memperbarui objek my_dataset_name	active	\N
4ca5f3c2-7eaa-4166-aa34-b91e42ace3b8	2019-09-23 04:09:24.960654	admin	REST API: Membuat objek my_dataset_name	active	\N
4f134269-07cf-478e-aa0a-18abdc0a5142	2019-09-23 04:09:25.049914	admin	REST API: Membuat anggota dari objek 	active	\N
009e0f5f-0b97-4bf5-97d2-344ae5743696	2019-09-23 04:29:06.024792	admin	REST API: Membuat objek name	active	\N
b809dfe1-1f7f-4981-ae37-c1038505916c	2019-09-23 04:29:06.067651	admin	REST API: Membuat anggota dari objek 	active	\N
68d8011f-7837-43a1-bca6-09039e7e8ffd	2019-09-23 04:32:42.121523	admin	REST API: Membuat objek name	active	\N
e56f2dc6-ff1c-4bc6-8178-562c3f109b15	2019-09-23 04:32:42.242126	admin	REST API: Membuat anggota dari objek 	active	\N
976a1b27-2790-4084-bca1-7a6bd9c11523	2019-09-23 04:33:46.653891	admin	REST API: Membuat objek name	active	\N
c736e9ca-aaeb-4942-8035-2c023f547707	2019-09-23 04:33:46.764375	admin	REST API: Membuat anggota dari objek 	active	\N
fded3d23-c62a-4d43-8750-e3ed9edb0906	2019-09-23 05:16:39.474533	admin	REST API: Membuat objek name	active	\N
a22eec4f-31e9-446a-8298-08985337bd4b	2019-09-23 05:16:39.567073	admin	REST API: Membuat anggota dari objek 	active	\N
1b45802c-b834-44be-a9ab-b8cd9746b288	2019-09-23 05:18:12.492945	admin	REST API: Membuat objek name	active	\N
b110eb9a-ccb6-432f-bb4f-cca58860d623	2019-09-23 05:18:12.587861	admin	REST API: Membuat anggota dari objek 	active	\N
6ff7f2b5-0d44-4f59-bf60-70c351719dd3	2019-09-23 05:31:44.372278	admin	REST API: Membuat objek name	active	\N
5c7b0788-fdf5-447f-8b2f-86e48ea830b6	2019-09-23 05:33:14.610178	admin	REST API: Membuat objek name	active	\N
d82d7fef-1a1b-4df3-984a-2fbf260da4fb	2019-09-23 05:42:11.323018	admin	REST API: Memperbarui objek name	active	\N
78c8f89d-1408-4437-bfd5-73edc29911b9	2019-09-24 03:51:24.747147	admin		active	\N
6a3429b5-f815-426a-8d0f-db7865b95600	2019-09-24 03:51:57.84566	admin	REST API: Memperbarui objek test	active	\N
8ceb1170-8ad0-4e2c-a337-a1cda0fdfefb	2019-09-24 03:51:58.018969	admin	REST API: Memperbarui objek test	active	\N
6d851101-8ace-4d4a-80ee-d8ec3ac09dda	2019-09-24 03:53:23.219275	admin		active	\N
\.


--
-- Data for Name: system_info; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.system_info (id, key, value, revision_id, state) FROM stdin;
1	partner1_logo	/base/images/jabar.png	ffc64850-a3fd-4a95-b10b-5026512f1ebc	active
3	twitter_url		f00b2e2d-f047-4404-b982-98072f45c294	active
4	partner7_link		480d1272-aa79-4ad8-912e-979bd112ce7e	active
5	partner7_logo		78d8ee50-04c0-4820-99b7-b0451518c516	active
7	facebook_url	https://www.facebook.com/jabardigitalservice	1c64c45f-262e-4fff-bc3d-4b1a7355889f	active
8	partner1_link	http://jabarprov.go.id	190adc63-6d3f-44a3-b9ea-8df023ff2e75	active
11	partner5_logo		c774f2c9-ee15-477b-b8d7-f58da8522ca9	active
12	partner6_logo		948dae87-dfc9-4aec-a2be-f981ea95f85b	active
13	partner8_link		b7b56240-a0d9-4cfd-93df-e1d2440c493c	active
14	partner5_link		2d84fd72-907a-4366-8f86-32e3849f330e	active
16	partner6_link		808a5616-6de4-4d05-ad65-6477d5fcbd1c	active
17	instagram_url	https://www.instagram.com/jabardigitalservice/	a5c6825c-81f9-4f6b-9278-e6d5857b1a24	active
19	partner8_logo		f7704f68-9e67-43b3-9795-e1c87e8f007f	active
20	partner2_link	http://diskominfo.jabarprov.go.id/	9379f51a-b6e1-4132-9ead-dcf4e63426bf	active
9	linkedIn_url	https://www.linkedin.com/company/jabardigitalservice/	c3722704-c1ac-47b7-b21c-32d34cdc632e	active
22	ckan.site_custom_css		6cd03fa3-eaf3-48ec-870c-e0031e0fce6f	active
25	ckan.site_about		74d06c39-f033-46d5-a9e7-aa67560446ef	active
27	ckan.site_description		44baf2c6-f116-4b1a-b3f6-007b0620a4f5	active
28	ckan.site_intro_text		8d9010d6-e063-404f-a7c1-2a43b95c38c5	active
23	ckan.main_css	/base/css/main.css	637a8881-7627-4eb2-b8b9-e0938f3fd42a	active
29	ckan.homepage_style	1	d6e9e8e0-8e64-49cd-8f59-e69c4a5010e9	active
2	partner2_logo	/base/images/diskominfo_putih.png	75d04bd5-10f9-4d5e-8f8f-da2e5fbba869	active
24	ckan.site_title	Open Data Provinsi Jawa Barat	2f673f61-c03a-4cce-863e-7379e8498671	active
26	ckan.site_logo	/base/images/open-data-kecil.png	6d50c37d-e44a-4dc4-9ad4-6798c0419800	active
6	partner4_link	http://digitalservice.jabarprov.go.id	c2bf82cd-8f89-42df-8bec-6c1031f1fe96	active
10	partner4_logo	/base/images/jds_putih.png	239db10f-821a-4f89-ac84-4fa8bbbb6578	active
15	partner3_link	http://satudata.jabarprov.go.id	24d5abe1-b7ee-48ee-95f2-15ae4f7a7fb9	active
18	partner3_logo	/base/images/satu-data-jabar.png	36ef61f9-de02-4d9c-b51c-8dac4da4dba4	active
21	ckan.config_update	1565324972.22	c5ff31f0-7f39-43e7-bc31-eeb6242a32f2	active
\.


--
-- Data for Name: system_info_revision; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.system_info_revision (id, key, value, revision_id, continuity_id, state, expired_id, revision_timestamp, expired_timestamp, current) FROM stdin;
1	partner1_logo	/base/images/jabar.png	ffc64850-a3fd-4a95-b10b-5026512f1ebc	1	active	\N	2019-04-25 08:44:51.851581	9999-12-31 00:00:00	\N
2	partner2_logo	/base/images/diskominfo.png	75d04bd5-10f9-4d5e-8f8f-da2e5fbba869	2	active	\N	2019-04-25 08:44:51.873742	9999-12-31 00:00:00	\N
3	twitter_url		f00b2e2d-f047-4404-b982-98072f45c294	3	active	\N	2019-04-25 08:44:51.887502	9999-12-31 00:00:00	\N
4	partner7_link		480d1272-aa79-4ad8-912e-979bd112ce7e	4	active	\N	2019-04-25 08:44:51.89916	9999-12-31 00:00:00	\N
5	partner7_logo		78d8ee50-04c0-4820-99b7-b0451518c516	5	active	\N	2019-04-25 08:44:51.909731	9999-12-31 00:00:00	\N
7	facebook_url	https://www.facebook.com/jabardigitalservice	1c64c45f-262e-4fff-bc3d-4b1a7355889f	7	active	\N	2019-04-25 08:44:51.942749	9999-12-31 00:00:00	\N
8	partner1_link	http://jabarprov.go.id	190adc63-6d3f-44a3-b9ea-8df023ff2e75	8	active	\N	2019-04-25 08:44:51.954071	9999-12-31 00:00:00	\N
25	ckan.site_about		74d06c39-f033-46d5-a9e7-aa67560446ef	25	active	\N	2019-05-02 04:52:41.518348	9999-12-31 00:00:00	\N
11	partner5_logo		c774f2c9-ee15-477b-b8d7-f58da8522ca9	11	active	\N	2019-04-25 08:44:51.98852	9999-12-31 00:00:00	\N
12	partner6_logo		948dae87-dfc9-4aec-a2be-f981ea95f85b	12	active	\N	2019-04-25 08:44:51.999025	9999-12-31 00:00:00	\N
13	partner8_link		b7b56240-a0d9-4cfd-93df-e1d2440c493c	13	active	\N	2019-04-25 08:44:52.0093	9999-12-31 00:00:00	\N
14	partner5_link		2d84fd72-907a-4366-8f86-32e3849f330e	14	active	\N	2019-04-25 08:44:52.021081	9999-12-31 00:00:00	\N
16	partner6_link		808a5616-6de4-4d05-ad65-6477d5fcbd1c	16	active	\N	2019-04-25 08:44:52.042584	9999-12-31 00:00:00	\N
17	instagram_url	https://www.instagram.com/jabardigitalservice/	a5c6825c-81f9-4f6b-9278-e6d5857b1a24	17	active	\N	2019-04-25 08:44:52.05892	9999-12-31 00:00:00	\N
19	partner8_logo		f7704f68-9e67-43b3-9795-e1c87e8f007f	19	active	\N	2019-04-25 08:44:52.079038	9999-12-31 00:00:00	\N
20	partner2_link	http://diskominfo.jabarprov.go.id/	9379f51a-b6e1-4132-9ead-dcf4e63426bf	20	active	\N	2019-04-25 08:44:52.089212	9999-12-31 00:00:00	\N
9	linkedIn_url	https://www.linkedin.com/company/jabardigitalservice/	c3722704-c1ac-47b7-b21c-32d34cdc632e	9	active	\N	2019-04-25 08:47:20.294012	9999-12-31 00:00:00	\N
9	linkedIn_url		1122827a-87dc-4f62-ba55-f72fe6473acf	9	active	\N	2019-04-25 08:44:51.967286	2019-04-25 08:47:20.294012	\N
21	ckan.config_update	1556181892.1	1f507f35-d754-4284-8c82-590a6c8e520a	21	active	\N	2019-04-25 08:44:52.099983	2019-04-25 08:47:20.321885	\N
22	ckan.site_custom_css		6cd03fa3-eaf3-48ec-870c-e0031e0fce6f	22	active	\N	2019-05-02 04:52:41.382505	9999-12-31 00:00:00	\N
29	ckan.homepage_style	2	5e24e960-0802-459f-a9ae-d356b46cb875	29	active	\N	2019-05-02 07:20:03.888659	2019-05-02 07:20:25.349874	\N
26	ckan.site_logo	/base/images/logo_open_data.png	6d50c37d-e44a-4dc4-9ad4-6798c0419800	26	active	\N	2019-05-02 04:52:41.531903	9999-12-31 00:00:00	\N
27	ckan.site_description		44baf2c6-f116-4b1a-b3f6-007b0620a4f5	27	active	\N	2019-05-02 04:52:41.543056	9999-12-31 00:00:00	\N
28	ckan.site_intro_text		8d9010d6-e063-404f-a7c1-2a43b95c38c5	28	active	\N	2019-05-02 04:52:41.556838	9999-12-31 00:00:00	\N
21	ckan.config_update	1556852758.5	9507cb6a-1759-4353-ad68-1b67b9b71f56	21	active	\N	2019-05-03 03:05:58.49932	2019-05-03 03:06:13.107412	\N
21	ckan.config_update	1556182040.32	cf2a816e-b5fc-44b1-83b4-f97fbec6d800	21	active	\N	2019-04-25 08:47:20.321885	2019-05-02 04:52:41.578139	\N
23	ckan.main_css	/base/css/main.css	f535e9e3-fdbe-4b42-a8b6-f4413157e176	23	active	\N	2019-05-02 04:52:41.489932	2019-05-02 07:19:44.788621	\N
21	ckan.config_update	1556781603.9	808bb966-62c6-4abb-99b3-a92009e49df5	21	active	\N	2019-05-02 07:20:03.902645	2019-05-02 07:20:25.363294	\N
21	ckan.config_update	1556772761.58	3543380b-66ab-409e-aa32-9f7987e9a0b9	21	active	\N	2019-05-02 04:52:41.578139	2019-05-02 07:19:44.817007	\N
23	ckan.main_css	/base/css/red.css	678c15d9-b79d-4498-8cba-cf13a8551d65	23	active	\N	2019-05-02 07:19:44.788621	2019-05-02 07:20:03.86913	\N
23	ckan.main_css	/base/css/main.css	637a8881-7627-4eb2-b8b9-e0938f3fd42a	23	active	\N	2019-05-02 07:20:03.86913	9999-12-31 00:00:00	\N
29	ckan.homepage_style	1	2c68fa11-93b2-495a-8274-ae311b61290b	29	active	\N	2019-05-02 04:52:41.565697	2019-05-02 07:20:03.888659	\N
21	ckan.config_update	1556781584.82	81504a87-f46f-44ee-a9a1-849362ae0eca	21	active	\N	2019-05-02 07:19:44.817007	2019-05-02 07:20:03.902645	\N
29	ckan.homepage_style	3	41053147-b25c-4e4b-b9d1-0ad8894dc1bf	29	active	\N	2019-05-02 07:20:25.349874	2019-05-03 03:05:58.479124	\N
21	ckan.config_update	1556781625.36	c15b9b92-3116-4f5d-89b6-155afad37f38	21	active	\N	2019-05-02 07:20:25.363294	2019-05-03 03:05:58.49932	\N
29	ckan.homepage_style	2	ddbf5e41-f765-4781-9c7e-50091c505def	29	active	\N	2019-05-03 03:05:58.479124	2019-05-03 03:06:13.09456	\N
29	ckan.homepage_style	1	d6e9e8e0-8e64-49cd-8f59-e69c4a5010e9	29	active	\N	2019-05-03 03:06:13.09456	9999-12-31 00:00:00	\N
24	ckan.site_title	Portal Data Provinsi Jawa Barat	c14c50a2-2025-4392-b553-62c22ebe5db2	24	active	\N	2019-05-02 04:52:41.505063	2019-07-23 03:18:17.644886	\N
24	ckan.site_title	Open Data Provinsi Jawa Barat	2f673f61-c03a-4cce-863e-7379e8498671	24	active	\N	2019-07-23 03:18:17.644886	9999-12-31 00:00:00	\N
18	partner3_logo	/base/images/satudata.png	8193657e-a8da-4d8c-a994-c2f347a16dcb	18	active	\N	2019-08-09 02:23:13.100621	2019-08-09 04:29:32.172335	\N
21	ckan.config_update	1556852773.11	43e6b56f-4cda-42c6-a236-beaf957dc911	21	active	\N	2019-05-03 03:06:13.107412	2019-07-23 03:18:17.706397	\N
6	partner4_link	http://digitalservice.jabarprov.go.id	c2bf82cd-8f89-42df-8bec-6c1031f1fe96	6	active	\N	2019-08-09 02:23:12.775348	9999-12-31 00:00:00	\N
6	partner4_link		b58da4f7-8ca2-4be3-bcbf-40e38f792c6f	6	active	\N	2019-04-25 08:44:51.920586	2019-08-09 02:23:12.775348	\N
10	partner4_logo		cc676e9d-b74a-4da1-bb76-04e45efc3b05	10	active	\N	2019-04-25 08:44:51.97764	2019-08-09 02:23:12.967455	\N
10	partner4_logo	/base/images/jds_putih.png	239db10f-821a-4f89-ac84-4fa8bbbb6578	10	active	\N	2019-08-09 02:23:12.967455	9999-12-31 00:00:00	\N
15	partner3_link	http://digitalservice.jabarprov.go.id	55f36b86-ccf1-4c10-9828-729957dcebf1	15	active	\N	2019-04-25 08:44:52.031359	2019-08-09 02:23:13.02817	\N
15	partner3_link	http://satudata.jabarprov.go.id	24d5abe1-b7ee-48ee-95f2-15ae4f7a7fb9	15	active	\N	2019-08-09 02:23:13.02817	9999-12-31 00:00:00	\N
18	partner3_logo	/base/images/jds.png	10097652-1a83-4a13-88c9-eb1733b1270f	18	active	\N	2019-04-25 08:44:52.06903	2019-08-09 02:23:13.100621	\N
21	ckan.config_update	1563851897.7	5eefbd48-a939-477c-b036-fe83d2282523	21	active	\N	2019-07-23 03:18:17.706397	2019-08-09 02:23:13.157379	\N
18	partner3_logo	/base/images/satu-data-jabar.png	36ef61f9-de02-4d9c-b51c-8dac4da4dba4	18	active	\N	2019-08-09 04:29:32.172335	9999-12-31 00:00:00	\N
21	ckan.config_update	1565324972.22	c5ff31f0-7f39-43e7-bc31-eeb6242a32f2	21	active	\N	2019-08-09 04:29:32.222046	9999-12-31 00:00:00	\N
21	ckan.config_update	1565317393.15	69367d56-e353-46d6-b662-e55a80fd34a1	21	active	\N	2019-08-09 02:23:13.157379	2019-08-09 04:29:32.222046	\N
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tag (id, name, vocabulary_id) FROM stdin;
\.


--
-- Data for Name: task_status; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.task_status (id, entity_id, entity_type, task_type, key, value, state, error, last_updated) FROM stdin;
\.


--
-- Data for Name: term_translation; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.term_translation (term, term_translation, lang_code) FROM stdin;
\.


--
-- Data for Name: tracking_raw; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tracking_raw (user_key, url, tracking_type, access_timestamp) FROM stdin;
\.


--
-- Data for Name: tracking_summary; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tracking_summary (url, package_id, tracking_type, count, running_total, recent_views, tracking_date) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."user" (id, name, apikey, created, about, password, fullname, email, reset_key, sysadmin, activity_streams_email_notifications, state) FROM stdin;
428a2ba6-6250-498a-a9a1-73408163cf6a	administrator	e68fcff1-ecc8-453b-ad4e-46993df7e2ea	2019-04-25 15:37:52.217932		$pbkdf2-sha512$25000$LoWQco7xfq/1/h8DoLTWeg$zQE0Fu.6gI7Fn90GOMuZYR.joCisSua8Bc8Qp9EtX1p7YTQ4jl79o8OUzxcE.dPdCmf9JoB1LpGqj0.O7TktTQ		administrator@email.com	\N	t	f	active
\.


--
-- Data for Name: user_following_dataset; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_following_dataset (follower_id, object_id, datetime) FROM stdin;
\.


--
-- Data for Name: user_following_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_following_group (follower_id, object_id, datetime) FROM stdin;
\.


--
-- Data for Name: user_following_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_following_user (follower_id, object_id, datetime) FROM stdin;
\.


--
-- Data for Name: vocabulary; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vocabulary (id, name) FROM stdin;
\.


--
-- Name: system_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.system_info_id_seq', 31, true);


--
-- Name: activity_detail activity_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_detail
    ADD CONSTRAINT activity_detail_pkey PRIMARY KEY (id);


--
-- Name: activity activity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT activity_pkey PRIMARY KEY (id);


--
-- Name: authorization_group authorization_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authorization_group
    ADD CONSTRAINT authorization_group_pkey PRIMARY KEY (id);


--
-- Name: authorization_group_user authorization_group_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authorization_group_user
    ADD CONSTRAINT authorization_group_user_pkey PRIMARY KEY (id);


--
-- Name: dashboard dashboard_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT dashboard_pkey PRIMARY KEY (user_id);


--
-- Name: group_extra group_extra_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_extra
    ADD CONSTRAINT group_extra_pkey PRIMARY KEY (id);


--
-- Name: group_extra_revision group_extra_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_extra_revision
    ADD CONSTRAINT group_extra_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: group group_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_name_key UNIQUE (name);


--
-- Name: group group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (id);


--
-- Name: group_revision group_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_revision
    ADD CONSTRAINT group_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: member member_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_pkey PRIMARY KEY (id);


--
-- Name: member_revision member_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.member_revision
    ADD CONSTRAINT member_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: migrate_version migrate_version_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrate_version
    ADD CONSTRAINT migrate_version_pkey PRIMARY KEY (repository_id);


--
-- Name: package_extra package_extra_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_extra
    ADD CONSTRAINT package_extra_pkey PRIMARY KEY (id);


--
-- Name: package_extra_revision package_extra_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_extra_revision
    ADD CONSTRAINT package_extra_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: package package_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package
    ADD CONSTRAINT package_name_key UNIQUE (name);


--
-- Name: package package_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package
    ADD CONSTRAINT package_pkey PRIMARY KEY (id);


--
-- Name: package_relationship package_relationship_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_relationship
    ADD CONSTRAINT package_relationship_pkey PRIMARY KEY (id);


--
-- Name: package_relationship_revision package_relationship_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_relationship_revision
    ADD CONSTRAINT package_relationship_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: package_revision package_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_revision
    ADD CONSTRAINT package_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: package_tag package_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_tag
    ADD CONSTRAINT package_tag_pkey PRIMARY KEY (id);


--
-- Name: package_tag_revision package_tag_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_tag_revision
    ADD CONSTRAINT package_tag_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: rating rating_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_pkey PRIMARY KEY (id);


--
-- Name: resource resource_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource
    ADD CONSTRAINT resource_pkey PRIMARY KEY (id);


--
-- Name: resource_revision resource_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_revision
    ADD CONSTRAINT resource_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: resource_view resource_view_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_view
    ADD CONSTRAINT resource_view_pkey PRIMARY KEY (id);


--
-- Name: revision revision_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.revision
    ADD CONSTRAINT revision_pkey PRIMARY KEY (id);


--
-- Name: system_info system_info_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_info
    ADD CONSTRAINT system_info_key_key UNIQUE (key);


--
-- Name: system_info system_info_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_info
    ADD CONSTRAINT system_info_pkey PRIMARY KEY (id);


--
-- Name: system_info_revision system_info_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_info_revision
    ADD CONSTRAINT system_info_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: tag tag_name_vocabulary_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_name_vocabulary_id_key UNIQUE (name, vocabulary_id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: task_status task_status_entity_id_task_type_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_status
    ADD CONSTRAINT task_status_entity_id_task_type_key_key UNIQUE (entity_id, task_type, key);


--
-- Name: task_status task_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_status
    ADD CONSTRAINT task_status_pkey PRIMARY KEY (id);


--
-- Name: user_following_dataset user_following_dataset_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_following_dataset
    ADD CONSTRAINT user_following_dataset_pkey PRIMARY KEY (follower_id, object_id);


--
-- Name: user_following_group user_following_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_following_group
    ADD CONSTRAINT user_following_group_pkey PRIMARY KEY (follower_id, object_id);


--
-- Name: user_following_user user_following_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_following_user
    ADD CONSTRAINT user_following_user_pkey PRIMARY KEY (follower_id, object_id);


--
-- Name: user user_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_name_key UNIQUE (name);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: vocabulary vocabulary_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocabulary
    ADD CONSTRAINT vocabulary_name_key UNIQUE (name);


--
-- Name: vocabulary vocabulary_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocabulary
    ADD CONSTRAINT vocabulary_pkey PRIMARY KEY (id);


--
-- Name: idx_activity_detail_activity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_activity_detail_activity_id ON public.activity_detail USING btree (activity_id);


--
-- Name: idx_activity_object_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_activity_object_id ON public.activity USING btree (object_id, "timestamp");


--
-- Name: idx_activity_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_activity_user_id ON public.activity USING btree (user_id, "timestamp");


--
-- Name: idx_extra_grp_id_pkg_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_extra_grp_id_pkg_id ON public.member USING btree (group_id, table_id);


--
-- Name: idx_extra_id_pkg_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_extra_id_pkg_id ON public.package_extra USING btree (id, package_id);


--
-- Name: idx_extra_pkg_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_extra_pkg_id ON public.package_extra USING btree (package_id);


--
-- Name: idx_group_current; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_current ON public.group_revision USING btree (current);


--
-- Name: idx_group_extra_current; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_extra_current ON public.group_extra_revision USING btree (current);


--
-- Name: idx_group_extra_period; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_extra_period ON public.group_extra_revision USING btree (revision_timestamp, expired_timestamp, id);


--
-- Name: idx_group_extra_period_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_extra_period_group ON public.group_extra_revision USING btree (revision_timestamp, expired_timestamp, group_id);


--
-- Name: idx_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_id ON public."group" USING btree (id);


--
-- Name: idx_group_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_name ON public."group" USING btree (name);


--
-- Name: idx_group_period; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_period ON public.group_revision USING btree (revision_timestamp, expired_timestamp, id);


--
-- Name: idx_group_pkg_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_pkg_id ON public.member USING btree (table_id);


--
-- Name: idx_member_continuity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_member_continuity_id ON public.member_revision USING btree (continuity_id);


--
-- Name: idx_package_continuity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_continuity_id ON public.package_revision USING btree (continuity_id);


--
-- Name: idx_package_creator_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_creator_user_id ON public.package USING btree (creator_user_id);


--
-- Name: idx_package_current; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_current ON public.package_revision USING btree (current);


--
-- Name: idx_package_extra_continuity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_extra_continuity_id ON public.package_extra_revision USING btree (continuity_id);


--
-- Name: idx_package_extra_current; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_extra_current ON public.package_extra_revision USING btree (current);


--
-- Name: idx_package_extra_package_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_extra_package_id ON public.package_extra_revision USING btree (package_id, current);


--
-- Name: idx_package_extra_period; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_extra_period ON public.package_extra_revision USING btree (revision_timestamp, expired_timestamp, id);


--
-- Name: idx_package_extra_period_package; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_extra_period_package ON public.package_extra_revision USING btree (revision_timestamp, expired_timestamp, package_id);


--
-- Name: idx_package_extra_rev_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_extra_rev_id ON public.package_extra_revision USING btree (revision_id);


--
-- Name: idx_package_group_current; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_group_current ON public.member_revision USING btree (current);


--
-- Name: idx_package_group_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_group_group_id ON public.member USING btree (group_id);


--
-- Name: idx_package_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_group_id ON public.member USING btree (id);


--
-- Name: idx_package_group_period_package_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_group_period_package_group ON public.member_revision USING btree (revision_timestamp, expired_timestamp, table_id, group_id);


--
-- Name: idx_package_group_pkg_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_group_pkg_id ON public.member USING btree (table_id);


--
-- Name: idx_package_group_pkg_id_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_group_pkg_id_group_id ON public.member USING btree (group_id, table_id);


--
-- Name: idx_package_period; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_period ON public.package_revision USING btree (revision_timestamp, expired_timestamp, id);


--
-- Name: idx_package_relationship_current; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_relationship_current ON public.package_relationship_revision USING btree (current);


--
-- Name: idx_package_resource_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_resource_id ON public.resource USING btree (id);


--
-- Name: idx_package_resource_rev_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_resource_rev_id ON public.resource_revision USING btree (revision_id);


--
-- Name: idx_package_resource_url; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_resource_url ON public.resource USING btree (url);


--
-- Name: idx_package_tag_continuity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_tag_continuity_id ON public.package_tag_revision USING btree (continuity_id);


--
-- Name: idx_package_tag_current; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_tag_current ON public.package_tag_revision USING btree (current);


--
-- Name: idx_package_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_tag_id ON public.package_tag USING btree (id);


--
-- Name: idx_package_tag_pkg_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_tag_pkg_id ON public.package_tag USING btree (package_id);


--
-- Name: idx_package_tag_pkg_id_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_tag_pkg_id_tag_id ON public.package_tag USING btree (tag_id, package_id);


--
-- Name: idx_package_tag_revision_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_tag_revision_id ON public.package_tag_revision USING btree (id);


--
-- Name: idx_package_tag_revision_pkg_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_tag_revision_pkg_id ON public.package_tag_revision USING btree (package_id);


--
-- Name: idx_package_tag_revision_pkg_id_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_tag_revision_pkg_id_tag_id ON public.package_tag_revision USING btree (tag_id, package_id);


--
-- Name: idx_package_tag_revision_rev_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_tag_revision_rev_id ON public.package_tag_revision USING btree (revision_id);


--
-- Name: idx_package_tag_revision_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_tag_revision_tag_id ON public.package_tag_revision USING btree (tag_id);


--
-- Name: idx_package_tag_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_package_tag_tag_id ON public.package_tag USING btree (tag_id);


--
-- Name: idx_period_package_relationship; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_period_package_relationship ON public.package_relationship_revision USING btree (revision_timestamp, expired_timestamp, object_package_id, subject_package_id);


--
-- Name: idx_period_package_tag; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_period_package_tag ON public.package_tag_revision USING btree (revision_timestamp, expired_timestamp, package_id, tag_id);


--
-- Name: idx_pkg_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pkg_id ON public.package USING btree (id);


--
-- Name: idx_pkg_lname; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pkg_lname ON public.package USING btree (lower((name)::text));


--
-- Name: idx_pkg_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pkg_name ON public.package USING btree (name);


--
-- Name: idx_pkg_rev_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pkg_rev_id ON public.package USING btree (revision_id);


--
-- Name: idx_pkg_revision_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pkg_revision_id ON public.package_revision USING btree (id);


--
-- Name: idx_pkg_revision_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pkg_revision_name ON public.package_revision USING btree (name);


--
-- Name: idx_pkg_revision_rev_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pkg_revision_rev_id ON public.package_revision USING btree (revision_id);


--
-- Name: idx_pkg_sid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pkg_sid ON public.package USING btree (id, state);


--
-- Name: idx_pkg_slname; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pkg_slname ON public.package USING btree (lower((name)::text), state);


--
-- Name: idx_pkg_sname; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pkg_sname ON public.package USING btree (name, state);


--
-- Name: idx_pkg_srev_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pkg_srev_id ON public.package USING btree (revision_id, state);


--
-- Name: idx_pkg_stitle; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pkg_stitle ON public.package USING btree (title, state);


--
-- Name: idx_pkg_suname; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pkg_suname ON public.package USING btree (upper((name)::text), state);


--
-- Name: idx_pkg_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pkg_title ON public.package USING btree (title);


--
-- Name: idx_pkg_uname; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pkg_uname ON public.package USING btree (upper((name)::text));


--
-- Name: idx_rating_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_rating_id ON public.rating USING btree (id);


--
-- Name: idx_rating_package_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_rating_package_id ON public.rating USING btree (package_id);


--
-- Name: idx_rating_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_rating_user_id ON public.rating USING btree (user_id);


--
-- Name: idx_resource_continuity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_resource_continuity_id ON public.resource_revision USING btree (continuity_id);


--
-- Name: idx_resource_current; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_resource_current ON public.resource_revision USING btree (current);


--
-- Name: idx_resource_period; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_resource_period ON public.resource_revision USING btree (revision_timestamp, expired_timestamp, id);


--
-- Name: idx_rev_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_rev_state ON public.revision USING btree (state);


--
-- Name: idx_revision_author; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_revision_author ON public.revision USING btree (author);


--
-- Name: idx_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tag_id ON public.tag USING btree (id);


--
-- Name: idx_tag_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tag_name ON public.tag USING btree (name);


--
-- Name: idx_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_id ON public."user" USING btree (id);


--
-- Name: idx_user_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_name ON public."user" USING btree (name);


--
-- Name: idx_user_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_name_index ON public."user" USING btree ((
CASE
    WHEN ((fullname IS NULL) OR (fullname = ''::text)) THEN name
    ELSE fullname
END));


--
-- Name: term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX term ON public.term_translation USING btree (term);


--
-- Name: term_lang; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX term_lang ON public.term_translation USING btree (term, lang_code);


--
-- Name: tracking_raw_access_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tracking_raw_access_timestamp ON public.tracking_raw USING btree (access_timestamp);


--
-- Name: tracking_raw_url; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tracking_raw_url ON public.tracking_raw USING btree (url);


--
-- Name: tracking_raw_user_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tracking_raw_user_key ON public.tracking_raw USING btree (user_key);


--
-- Name: tracking_summary_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tracking_summary_date ON public.tracking_summary USING btree (tracking_date);


--
-- Name: tracking_summary_package_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tracking_summary_package_id ON public.tracking_summary USING btree (package_id);


--
-- Name: tracking_summary_url; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tracking_summary_url ON public.tracking_summary USING btree (url);


--
-- Name: activity_detail activity_detail_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_detail
    ADD CONSTRAINT activity_detail_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES public.activity(id);


--
-- Name: authorization_group_user authorization_group_user_authorization_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authorization_group_user
    ADD CONSTRAINT authorization_group_user_authorization_group_id_fkey FOREIGN KEY (authorization_group_id) REFERENCES public.authorization_group(id);


--
-- Name: authorization_group_user authorization_group_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authorization_group_user
    ADD CONSTRAINT authorization_group_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: dashboard dashboard_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT dashboard_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: group_extra group_extra_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_extra
    ADD CONSTRAINT group_extra_group_id_fkey FOREIGN KEY (group_id) REFERENCES public."group"(id);


--
-- Name: group_extra_revision group_extra_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_extra_revision
    ADD CONSTRAINT group_extra_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES public.group_extra(id);


--
-- Name: group_extra_revision group_extra_revision_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_extra_revision
    ADD CONSTRAINT group_extra_revision_group_id_fkey FOREIGN KEY (group_id) REFERENCES public."group"(id);


--
-- Name: group_extra group_extra_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_extra
    ADD CONSTRAINT group_extra_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: group_extra_revision group_extra_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_extra_revision
    ADD CONSTRAINT group_extra_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: group_revision group_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_revision
    ADD CONSTRAINT group_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES public."group"(id);


--
-- Name: group group_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: group_revision group_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_revision
    ADD CONSTRAINT group_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: member member_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_group_id_fkey FOREIGN KEY (group_id) REFERENCES public."group"(id);


--
-- Name: member_revision member_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.member_revision
    ADD CONSTRAINT member_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES public.member(id);


--
-- Name: member_revision member_revision_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.member_revision
    ADD CONSTRAINT member_revision_group_id_fkey FOREIGN KEY (group_id) REFERENCES public."group"(id);


--
-- Name: member member_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: member_revision member_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.member_revision
    ADD CONSTRAINT member_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: package_extra package_extra_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_extra
    ADD CONSTRAINT package_extra_package_id_fkey FOREIGN KEY (package_id) REFERENCES public.package(id);


--
-- Name: package_extra_revision package_extra_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_extra_revision
    ADD CONSTRAINT package_extra_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES public.package_extra(id);


--
-- Name: package_extra package_extra_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_extra
    ADD CONSTRAINT package_extra_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: package_extra_revision package_extra_revision_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_extra_revision
    ADD CONSTRAINT package_extra_revision_package_id_fkey FOREIGN KEY (package_id) REFERENCES public.package(id);


--
-- Name: package_extra_revision package_extra_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_extra_revision
    ADD CONSTRAINT package_extra_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: package_relationship package_relationship_object_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_relationship
    ADD CONSTRAINT package_relationship_object_package_id_fkey FOREIGN KEY (object_package_id) REFERENCES public.package(id);


--
-- Name: package_relationship_revision package_relationship_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_relationship_revision
    ADD CONSTRAINT package_relationship_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES public.package_relationship(id);


--
-- Name: package_relationship package_relationship_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_relationship
    ADD CONSTRAINT package_relationship_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: package_relationship_revision package_relationship_revision_object_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_relationship_revision
    ADD CONSTRAINT package_relationship_revision_object_package_id_fkey FOREIGN KEY (object_package_id) REFERENCES public.package(id);


--
-- Name: package_relationship_revision package_relationship_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_relationship_revision
    ADD CONSTRAINT package_relationship_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: package_relationship_revision package_relationship_revision_subject_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_relationship_revision
    ADD CONSTRAINT package_relationship_revision_subject_package_id_fkey FOREIGN KEY (subject_package_id) REFERENCES public.package(id);


--
-- Name: package_relationship package_relationship_subject_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_relationship
    ADD CONSTRAINT package_relationship_subject_package_id_fkey FOREIGN KEY (subject_package_id) REFERENCES public.package(id);


--
-- Name: package_revision package_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_revision
    ADD CONSTRAINT package_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES public.package(id);


--
-- Name: package package_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package
    ADD CONSTRAINT package_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: package_revision package_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_revision
    ADD CONSTRAINT package_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: package_tag package_tag_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_tag
    ADD CONSTRAINT package_tag_package_id_fkey FOREIGN KEY (package_id) REFERENCES public.package(id);


--
-- Name: package_tag_revision package_tag_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_tag_revision
    ADD CONSTRAINT package_tag_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES public.package_tag(id);


--
-- Name: package_tag package_tag_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_tag
    ADD CONSTRAINT package_tag_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: package_tag_revision package_tag_revision_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_tag_revision
    ADD CONSTRAINT package_tag_revision_package_id_fkey FOREIGN KEY (package_id) REFERENCES public.package(id);


--
-- Name: package_tag_revision package_tag_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_tag_revision
    ADD CONSTRAINT package_tag_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: package_tag_revision package_tag_revision_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_tag_revision
    ADD CONSTRAINT package_tag_revision_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tag(id);


--
-- Name: package_tag package_tag_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.package_tag
    ADD CONSTRAINT package_tag_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tag(id);


--
-- Name: rating rating_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_package_id_fkey FOREIGN KEY (package_id) REFERENCES public.package(id);


--
-- Name: rating rating_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: resource_revision resource_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_revision
    ADD CONSTRAINT resource_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES public.resource(id);


--
-- Name: resource resource_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource
    ADD CONSTRAINT resource_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: resource_revision resource_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_revision
    ADD CONSTRAINT resource_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: resource_view resource_view_resource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_view
    ADD CONSTRAINT resource_view_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES public.resource(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: system_info_revision system_info_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_info_revision
    ADD CONSTRAINT system_info_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES public.system_info(id);


--
-- Name: system_info system_info_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_info
    ADD CONSTRAINT system_info_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: system_info_revision system_info_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_info_revision
    ADD CONSTRAINT system_info_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: tag tag_vocabulary_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_vocabulary_id_fkey FOREIGN KEY (vocabulary_id) REFERENCES public.vocabulary(id);


--
-- Name: user_following_dataset user_following_dataset_follower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_following_dataset
    ADD CONSTRAINT user_following_dataset_follower_id_fkey FOREIGN KEY (follower_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_following_dataset user_following_dataset_object_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_following_dataset
    ADD CONSTRAINT user_following_dataset_object_id_fkey FOREIGN KEY (object_id) REFERENCES public.package(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_following_group user_following_group_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_following_group
    ADD CONSTRAINT user_following_group_group_id_fkey FOREIGN KEY (object_id) REFERENCES public."group"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_following_group user_following_group_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_following_group
    ADD CONSTRAINT user_following_group_user_id_fkey FOREIGN KEY (follower_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_following_user user_following_user_follower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_following_user
    ADD CONSTRAINT user_following_user_follower_id_fkey FOREIGN KEY (follower_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_following_user user_following_user_object_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_following_user
    ADD CONSTRAINT user_following_user_object_id_fkey FOREIGN KEY (object_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TABLE activity; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.activity TO ckan_default;


--
-- Name: TABLE activity_detail; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.activity_detail TO ckan_default;


--
-- Name: TABLE authorization_group; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.authorization_group TO ckan_default;


--
-- Name: TABLE authorization_group_user; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.authorization_group_user TO ckan_default;


--
-- Name: TABLE ckanext_pages; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.ckanext_pages TO ckan_default;


--
-- Name: TABLE dashboard; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.dashboard TO ckan_default;


--
-- Name: TABLE "group"; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public."group" TO ckan_default;


--
-- Name: TABLE group_extra; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.group_extra TO ckan_default;


--
-- Name: TABLE group_extra_revision; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.group_extra_revision TO ckan_default;


--
-- Name: TABLE group_revision; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.group_revision TO ckan_default;


--
-- Name: TABLE member; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.member TO ckan_default;


--
-- Name: TABLE member_revision; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.member_revision TO ckan_default;


--
-- Name: TABLE migrate_version; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.migrate_version TO ckan_default;


--
-- Name: TABLE package; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.package TO ckan_default;


--
-- Name: TABLE package_extra; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.package_extra TO ckan_default;


--
-- Name: TABLE package_extra_revision; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.package_extra_revision TO ckan_default;


--
-- Name: TABLE package_relationship; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.package_relationship TO ckan_default;


--
-- Name: TABLE package_relationship_revision; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.package_relationship_revision TO ckan_default;


--
-- Name: TABLE package_revision; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.package_revision TO ckan_default;


--
-- Name: TABLE package_tag; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.package_tag TO ckan_default;


--
-- Name: TABLE package_tag_revision; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.package_tag_revision TO ckan_default;


--
-- Name: TABLE rating; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.rating TO ckan_default;


--
-- Name: TABLE resource; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.resource TO ckan_default;


--
-- Name: TABLE resource_revision; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.resource_revision TO ckan_default;


--
-- Name: TABLE resource_view; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.resource_view TO ckan_default;


--
-- Name: TABLE revision; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.revision TO ckan_default;


--
-- Name: TABLE system_info; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.system_info TO ckan_default;


--
-- Name: TABLE system_info_revision; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.system_info_revision TO ckan_default;


--
-- Name: TABLE tag; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.tag TO ckan_default;


--
-- Name: TABLE task_status; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.task_status TO ckan_default;


--
-- Name: TABLE term_translation; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.term_translation TO ckan_default;


--
-- Name: TABLE tracking_raw; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.tracking_raw TO ckan_default;


--
-- Name: TABLE tracking_summary; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.tracking_summary TO ckan_default;


--
-- Name: TABLE "user"; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public."user" TO ckan_default;


--
-- Name: TABLE user_following_dataset; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.user_following_dataset TO ckan_default;


--
-- Name: TABLE user_following_group; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.user_following_group TO ckan_default;


--
-- Name: TABLE user_following_user; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.user_following_user TO ckan_default;


--
-- Name: TABLE vocabulary; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.vocabulary TO ckan_default;


--
-- PostgreSQL database dump complete
--

