ALTER TABLE public.recordings OWNER TO postgres;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    category_id uuid NOT NULL,
    started_at timestamp with time zone DEFAULT now(),
    ended_at timestamp with time zone,
    notes text,
    ai_summary text,
    created_at timestamp with time zone DEFAULT now(),
    tone_score integer,
    confidence_score integer,
    fluency_score integer,
    user_audio_url text,
    transcript text,
    gpt_feedback text,
    agent_voice_feedback_url text,
    is_practice boolean DEFAULT false,
    CONSTRAINT sessions_confidence_score_check CHECK (((confidence_score >= 0) AND (confidence_score <= 100))),
    CONSTRAINT sessions_fluency_score_check CHECK (((fluency_score >= 0) AND (fluency_score <= 100))),
    CONSTRAINT sessions_tone_score_check CHECK (((tone_score >= 0) AND (tone_score <= 100)))
);

ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: COLUMN sessions.tone_score; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sessions.tone_score IS 'Tone score (0-100) calculated from audio analysis';

--
-- Name: COLUMN sessions.confidence_score; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sessions.confidence_score IS 'Confidence score (0-100) calculated from audio analysis';

--
-- Name: COLUMN sessions.fluency_score; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sessions.fluency_score IS 'Fluency score (0-100) calculated from audio analysis';

--
-- Name: COLUMN sessions.user_audio_url; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sessions.user_audio_url IS 'URL to user audio recording in Supabase Storage';

--
-- Name: COLUMN sessions.transcript; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sessions.transcript IS 'Full transcript from 11Labs Scribe, stored as context for future reference';

--
-- Name: COLUMN sessions.gpt_feedback; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sessions.gpt_feedback IS 'GPT-generated detailed feedback text';

--
-- Name: COLUMN sessions.agent_voice_feedback_url; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sessions.agent_voice_feedback_url IS 'URL to 11Labs Agent voice feedback audio in Supabase Storage';

--
-- Name: COLUMN sessions.is_practice; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sessions.is_practice IS 'Flag to distinguish practice sessions from regular coaching sessions';

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    password text
);

ALTER TABLE public.users OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);

ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);

ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);

ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';
