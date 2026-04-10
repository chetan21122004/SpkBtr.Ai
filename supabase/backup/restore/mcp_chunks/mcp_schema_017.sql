--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);

ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';

--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';

--
-- Name: app_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_config (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    key text NOT NULL,
    value text NOT NULL,
    description text,
    updated_at timestamp with time zone DEFAULT now()
);

ALTER TABLE public.app_config OWNER TO postgres;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    description text,
    base_context text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    route_path text,
    icon_name text,
    gradient text,
    display_order integer DEFAULT 0,
    is_active boolean DEFAULT true
);

ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: community_posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.community_posts (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    text text NOT NULL,
    audio_url text,
    likes integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT community_posts_likes_check CHECK ((likes >= 0))
);

ALTER TABLE public.community_posts OWNER TO postgres;

--
-- Name: goals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goals (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    title text NOT NULL,
    progress integer DEFAULT 0,
    total integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT goals_progress_check CHECK ((progress >= 0)),
    CONSTRAINT goals_total_check CHECK ((total > 0))
);

ALTER TABLE public.goals OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    session_id uuid NOT NULL,
    sender public.message_sender NOT NULL,
    text text NOT NULL,
    audio_url text,
    created_at timestamp with time zone DEFAULT now()
);

ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: progress_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.progress_stats (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    category_id uuid NOT NULL,
    session_id uuid,
    tone_score double precision,
    clarity_score double precision,
    pace_score double precision,
    confidence_score double precision,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT progress_stats_clarity_score_check CHECK (((clarity_score >= (0)::double precision) AND (clarity_score <= (100)::double precision))),
    CONSTRAINT progress_stats_confidence_score_check CHECK (((confidence_score >= (0)::double precision) AND (confidence_score <= (100)::double precision))),
    CONSTRAINT progress_stats_pace_score_check CHECK (((pace_score >= (0)::double precision) AND (pace_score <= (100)::double precision))),
    CONSTRAINT progress_stats_tone_score_check CHECK (((tone_score >= (0)::double precision) AND (tone_score <= (100)::double precision)))
);

ALTER TABLE public.progress_stats OWNER TO postgres;

--
-- Name: recordings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recordings (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    session_id uuid,
    audio_url text NOT NULL,
    duration integer,
    created_at timestamp with time zone DEFAULT now()
);
