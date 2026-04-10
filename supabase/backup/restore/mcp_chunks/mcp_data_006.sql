\.


--
-- Data for Name: recordings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recordings (id, user_id, session_id, audio_url, duration, created_at) FROM stdin;

\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, category_id, started_at, ended_at, notes, ai_summary, created_at, tone_score, confidence_score, fluency_score, user_audio_url, transcript, gpt_feedback, agent_voice_feedback_url, is_practice) FROM stdin;
