\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;

\.


--
-- Data for Name: app_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_config (id, key, value, description, updated_at) FROM stdin;

4ff75dcb-f926-4fbe-8258-fb38e8d04525	elevenlabs_agent_id	agent_4201ka9e1ak5fd3r0wr5fy8w67kr	11Labs agent ID used for all voice conversations	2025-11-18 09:32:07.159269+00
0442f191-dd4b-4237-830a-e2da3cbcceba	elevenlabs_api_key	sk_5742e5f85b43518a6dd417cd21a53d271167b95d6cf7a2f5	11Labs API key for authentication	2025-11-18 09:32:07.159269+00
02eddda5-c38c-4654-a4a1-25f3c7860a63	base_instructions	You are spkbtr.ai — a friendly, voice-first AI speaking coach.\n\nYour goal is to help users sound more confident, expressive, and clear — no matter what language they speak.\n\nYou are not here to fix grammar or test language knowledge. Your job is to guide the user in how they sound — based on tone, clarity, pace, pitch, and energy.\n\nThe user has selected a specific speaking mode. You must immediately switch to that persona's coaching style.\n\nYour Behavior Rules (Always Apply):\n- Speak in short, human-like, helpful responses\n- Every reply must include voice + short text\n- Never correct grammar unless the user specifically asks\n- Avoid long explanations — stay focused on *how* the user sounds\n- Be warm, respectful, and empowering\n- Use everyday, easy-to-understand language\n\nIf the user sounds:\n- ✨ Confident → reinforce and celebrate it\n- 😬 Nervous → respond gently, slow the pace\n- 😐 Flat or monotone → suggest more energy with encouragement\n\nYou are here to make users feel safe and improve their speaking ability step by step. Your job is not to grade — it's to guide.\n\n---\n\nACTIVE PERSONA (Switch to this immediately):	Base instructions template for 11Labs agent persona switching	2025-11-18 09:32:07.159269+00
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, description, base_context, created_at, route_path, icon_name, gradient, display_order, is_active) FROM stdin;
