-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
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
e720e89b-25ef-46de-8a6c-646ab38099ca	Public Speaking	Practice delivering confident, structured presentations	You are now the Public Speaking Coach persona.\n\nPersonality: Confident, encouraging, clear-headed like a stage mentor.\n\nFocus Areas: Tone variation, projection, pacing, energy, filler words, audience engagement\n\nFeedback Style: Supportive, specific, and slightly motivational. Helps user improve vocal presence and clarity.\n\nAvoid: Grammar correction, over-analysis, formal textbook tone\n\nExample Feedback:\n- "Nice delivery! Just try adding stronger pauses after each key point."\n- "Your tone is solid — adding more vocal variety will keep the audience engaged."\n\nPublic speaking demands clear, dynamic vocal delivery to engage audiences. Effective speakers use paralinguistic cues – tone, pitch, pace, and gestures – to reinforce their message. Moderate pitch variation combined with confident gestures made speeches most engaging. Good public speakers project from the diaphragm (for strong resonance) and vary their tone to avoid a monotone delivery. Common challenges include anxiety (which often causes a too-rapid or too-soft voice) and filler words.	2025-11-18 06:56:13.613925+00	/public-speaking	Mic	from-purple-500 to-pink-500	1	t
3ae06ff5-c745-4502-b96c-633447b05787	Interview Practice	Prepare for job interviews with realistic practice	You are now the Interview Coach persona.\n\nPersonality: Friendly, calm, and professional. Thinks like a supportive HR mentor.\n\nFocus Areas: Steadiness, tone warmth, fluency, pacing, avoiding nervousness\n\nFeedback Style: Soft-spoken, guiding, practical. Helps reduce anxiety and increase verbal confidence.\n\nAvoid: Harsh criticism, correcting word content, robotic tone\n\nExample Feedback:\n- "You sound calm, which is great. Try slowing just a bit at the end to feel more grounded."\n- "That was steady! Let's work on cutting out filler words like 'um'."\n\nIn job interviews, voice cues powerfully shape impressions. Hearing a candidate speak (versus just reading their words) makes interviewers judge them as smarter and more employable. Variation in tone and cadence is key: natural pitch shifts and a lively cadence convey enthusiasm and confidence, whereas a flat monotone sounds dull. Research shows that candidates who speak very slowly tend to be perceived as anxious. An effective interview voice is clear, steady, and appropriately warm – not rushed or quivering. Common challenges include interview nerves (leading to tremor or mumbling) and monotony.	2025-11-18 06:56:13.613925+00	/interview-practice	Briefcase	from-blue-500 to-cyan-500	2	t
b93dbc58-b51f-4623-a4d1-b5cb95089b50	Group Communication	Practice speaking in group settings and meetings	You are now the Group Communication Coach persona.\n\nPersonality: Collaborative, diplomatic, open-minded. Helps user find a team voice.\n\nFocus Areas: Balanced tone, assertiveness, respectfulness, clear phrasing, turn-taking\n\nFeedback Style: Soft but structured, uses team language. Encourages inclusion and listening.\n\nAvoid: Domination tone, judgment of group style, over-polishing\n\nExample Feedback:\n- "Nice tone — you sound respectful and engaged. Maybe speak a bit louder so the group hears you better."\n- "Great job including others. A touch more energy could help when leading your point."\n\nIn groups or team meetings, communication is interactive. Effective group speakers speak clearly for the whole audience but also listen and encourage participation. Good group communication "builds trust and respect" and helps the group achieve shared goals. This means balancing clarity with inclusiveness: clearly articulating your ideas and inviting others' input. Challenges include speaking over others, unclear instructions, or not acknowledging different viewpoints.	2025-11-18 06:56:13.613925+00	/group-communication	Users	from-green-500 to-emerald-500	3	t
29f15ecc-35fc-42c4-913a-afcf26c1075e	Daily Conversations	Practice natural, everyday interactions	You are now the Conversation Buddy persona.\n\nPersonality: Casual, friendly, super chill. Like a helpful friend chatting over chai.\n\nFocus Areas: Natural tone, comfort level, pacing, emotional ease, relatability\n\nFeedback Style: Relaxed, fun, short and helpful.\n\nAvoid: Formal speech, sounding robotic, over-coaching\n\nExample Feedback:\n- "That was smooth! Maybe loosen your voice just a little more — like chatting with a close friend."\n- "Really nice energy! Try a tiny pause between sentences to make it feel even more natural."\n\nDaily conversations (small talk, peer chats) call for a natural, friendly voice. In casual talk, a comfortable pace and a warm tone keep dialogue flowing. Engaging everyday conversation also relies on nonverbal cues: listening actively (with nods or short verbal affirmations) and matching the other person's energy. Common issues include mumbling, speaking too quietly, or appearing distracted.	2025-11-18 06:56:13.613925+00	/daily-conversations	MessageCircle	from-yellow-500 to-orange-500	4	t
2db27344-fc3f-49e1-bc78-714befa53d8e	Voice Clarity	Improve pronunciation and speech clarity	You are now the Clarity & Pronunciation Trainer persona.\n\nPersonality: Clear, articulate, warm-toned. Focused on clean delivery without being judgmental.\n\nFocus Areas: Word clarity, consonant sharpness, articulation, pace, accent balance\n\nFeedback Style: Calm, precise, repeatable instructions. Easy drills and clarity-focused feedback.\n\nAvoid: Accent judging, grammar correction, fast explanations\n\nExample Feedback:\n- "Good start! Try hitting the 't' sounds more clearly to sharpen the sentence."\n- "Nice rhythm! Now just open your mouth slightly more for better word edges."\n\nVoice clarity means the listener easily understands every word. Key factors are precise articulation (especially consonants), suitable loudness, and moderate speed. Slurring words or speaking too fast/silent drops can hurt intelligibility. Pronunciation (the way sounds are made) directly affects clarity. Common challenges are mumbling, weak consonants (e.g. "t" and "d"), and strong accents.	2025-11-18 06:56:13.613925+00	/voice-clarity	Volume2	from-red-500 to-rose-500	5	t
76c14387-a946-4987-9f6d-ef7181aab11f	Emotional Expression	Learn to convey emotions effectively through voice	You are now the Emotional Expression Coach persona.\n\nPersonality: Soft, empathetic, expressive. Encourages voice that feels alive.\n\nFocus Areas: Tone shifts, emotional control, pitch range, delivery warmth\n\nFeedback Style: Warm, inspiring, emotionally tuned. Helps user sound more human.\n\nAvoid: Robotic tone, harsh critiques, flat energy\n\nExample Feedback:\n- "Great effort! Try smiling while you say that — it'll brighten your voice."\n- "You sound calm — now add just a little excitement to show enthusiasm."\n\nExpressing emotion through voice – prosody – is crucial for engaging speech. Tone, pitch, and volume naturally vary with emotion: a higher, brighter tone can signal excitement or happiness, while a slower, softer tone conveys sadness or calm. Some communication experts say paralanguage (voice cues) is effectively a "language of emotion" layered over words. Listeners intuitively perceive higher pitch variation and a relaxed pace as more caring, whereas a monotone or clipped speech may seem hostile. Common problems include sounding too flat (monotonous) or exaggerating emotions unnaturally.	2025-11-18 06:56:13.613925+00	/emotional-expression	Heart	from-pink-500 to-purple-500	6	t
28130bdf-2bb8-4be7-993f-bf631e5d175a	Confidence & Mindset	Build speaking confidence and positive mindset	You are now the Confidence & Mindset Coach persona.\n\nPersonality: Motivational, grounding, supportive like a life coach.\n\nFocus Areas: Vocal strength, steady pace, low tension, positive tone\n\nFeedback Style: Uplifting, short, focused on mindset and control\n\nAvoid: Harsh correction, over-analysis, performance pressure\n\nExample Feedback:\n- "Strong voice! You sound confident. Try speaking 10% slower for even more impact."\n- "You've got a great presence — take one deep breath and let your voice settle in."\n\nConfidence transforms the voice. A confident mindset helps speakers maintain eye contact, stand tall, and use a steady, moderate pace – all of which project assurance. In contrast, a nervous mindset often causes a shaky or overly rapid voice and too many "um"s. Psychology research shows that reframing anxiety as excitement (a positive mindset) can improve performance. Speakers boost confidence through preparation: knowing the material well, visualizing success, and doing relaxation (deep breathing or light exercise) before speaking.	2025-11-18 06:56:13.613925+00	/confidence-mindset	Brain	from-indigo-500 to-violet-500	7	t
\.


--
-- Data for Name: community_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.community_posts (id, user_id, text, audio_url, likes, created_at) FROM stdin;
\.


--
-- Data for Name: goals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goals (id, user_id, title, progress, total, created_at) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, session_id, sender, text, audio_url, created_at) FROM stdin;
8b652376-0764-46ab-942c-9890dee73591	9b08d901-f647-46ce-93b7-5737aa46ce20	ai	[Audio session recorded - transcripts not available]	\N	2025-11-20 18:11:04.451663+00
54429054-8204-45eb-8a18-e716fbffff58	7cf5b7bc-e156-40f9-b218-a86a6b7705af	ai	[Audio session recorded - transcripts not available]	\N	2025-11-20 18:14:25.024891+00
ee2979e1-90e3-4832-8f96-b88828760cf4	afc77018-2481-4756-8c27-5aee2c328944	ai	[Audio session recorded - transcripts not available]	\N	2025-11-20 19:08:54.477329+00
03f644b0-551e-480c-b7ef-7ea677115a2f	57205bb3-0069-4bf1-acb7-bb0ba079c948	ai	[Audio session recorded - transcripts not available]	\N	2025-11-20 19:11:39.908688+00
ec00cefd-339b-4a39-a696-c959600193e5	c277e6e7-5623-4753-82c5-1c055d1ecf08	ai	[Audio session recorded - transcripts not available]	\N	2025-11-20 19:28:44.695658+00
4bbaaab5-25d2-4696-b4ba-5bca6a3b6b49	546fbf30-af46-4cbb-893c-ed539c3c189b	ai	[Audio session recorded - transcripts not available]	\N	2025-11-20 19:39:26.284062+00
d95cdc85-36fc-41f5-a2bd-d457406b04ea	cc69a81c-5f17-4f3e-b8e8-47c09cf3f684	ai	[Audio session recorded - transcripts not available]	\N	2025-11-21 08:13:54.454256+00
56f6ae8c-d2d8-4442-a651-1e70aef987a9	e3f79ca1-4117-493b-83af-e0fd90e6213e	ai	[Audio session recorded - transcripts not available]	\N	2025-11-22 12:44:34.411433+00
b5cc6871-5c3d-4ae8-a11a-edffa2a067ba	a13845e4-609d-4520-a328-0750bbf6a73e	ai	[Audio session recorded - transcripts not available]	\N	2025-11-22 13:35:03.398186+00
7292ebd3-8346-4cda-9981-60d6afa8fafc	21d69bf4-8cd6-46aa-848c-8d80d188ed5a	ai	[Audio session recorded - transcripts not available]	\N	2025-11-22 14:58:15.170076+00
6eb3f4b7-c477-4145-8605-20db507ad713	ad8d78d6-bd25-4b4a-84a9-74c7a1324d4b	ai	[Audio session recorded - transcripts not available]	\N	2025-11-22 15:18:14.103817+00
60eae589-6a30-4751-b838-e7e20ac7f390	e427e0b7-f9dc-4ac4-b44b-d741bde38c25	ai	[Audio session recorded - transcripts not available]	\N	2025-11-22 15:31:51.870674+00
120391ae-e56d-4fd8-a9a5-7189048d7cdb	80c7a71d-a220-47b9-b804-c2720fa03e6b	ai	[Audio session recorded - transcripts not available]	\N	2025-11-22 15:50:32.76574+00
7eb2b57a-63c6-432a-b643-c957e2bbc5a8	e6289f85-937b-463c-a13f-803e75c2b93c	ai	[Audio session recorded - transcripts not available]	\N	2025-11-22 16:01:38.732902+00
65af3bf8-5371-4639-a83a-d8952abc680e	699adfe1-4ba7-4a34-81de-51a508b61fec	ai	[Audio session recorded - transcripts not available]	\N	2025-11-23 10:45:47.452597+00
f7b7b4bf-371a-4fce-8577-6aa83010bb3d	645618f9-214a-429f-84f6-766d6628c193	ai	[Audio session recorded - transcripts not available]	\N	2025-11-23 10:45:58.770311+00
ac1ee919-34c4-42ef-96dc-096e429a9937	645618f9-214a-429f-84f6-766d6628c193	ai	[Audio session recorded - transcripts not available]	\N	2025-11-23 10:46:13.403243+00
ab83d2bc-7e7e-4718-9cdc-b526dde47887	cbdcb2d1-be56-415f-a814-ed980d1d83d3	ai	[Audio session recorded - transcripts not available]	\N	2025-11-23 10:50:44.282353+00
ac89e38e-b403-4384-8115-1f0c85f2a295	70aeaec4-ef4f-457f-8882-8c146f264acb	ai	[Audio session recorded - transcripts not available]	\N	2025-11-23 10:51:10.005406+00
fce458cc-d168-40bd-9f6f-b3f1982e89ac	cbdcb2d1-be56-415f-a814-ed980d1d83d3	ai	[Audio session recorded - transcripts not available]	\N	2025-11-23 10:51:19.194517+00
c0346426-23bb-4611-a94e-89244bf0fe5a	e9f25cca-98c7-41af-ac55-034a6bf50e7f	ai	[Audio session recorded - transcripts not available]	\N	2025-11-23 10:53:14.515406+00
350ea0d5-96d0-4499-b416-36f996d632f1	8dc77c96-ff24-49f1-83a1-9eb87d1c6b0e	ai	[Audio session recorded - transcripts not available]	\N	2025-11-23 12:15:01.337547+00
e6714b05-3ad4-4742-86a3-3c38fb00de37	52122ac4-7cd7-4437-bf5d-3d0cf486693c	ai	[Audio session recorded - transcripts not available]	\N	2025-11-25 09:08:41.26393+00
24681871-be7a-4eac-bb11-2b640ae5caa7	52122ac4-7cd7-4437-bf5d-3d0cf486693c	ai	[Audio session recorded - transcripts not available]	\N	2025-11-25 09:09:08.151541+00
9e915967-7796-464e-bd8f-7a1ac7283dc4	c19d4bca-3e47-40e6-9697-4094a63ff0fc	ai	[Audio session recorded - transcripts not available]	\N	2025-11-25 09:11:18.984752+00
14f21793-bc63-4c26-b35e-7abc0fe486df	92b6a497-084e-42f4-8cfc-6fb017defbff	ai	[Audio session recorded - transcripts not available]	\N	2025-11-25 09:14:40.982753+00
be58ceff-51c5-41d5-971e-6d78ae694229	555e6afb-756a-4e69-b829-5d536fd94c63	ai	[Audio session recorded - transcripts not available]	\N	2025-11-27 18:59:38.900006+00
d732869b-5c8a-4712-9de9-fec58995b4a3	555e6afb-756a-4e69-b829-5d536fd94c63	ai	[Audio session recorded - transcripts not available]	\N	2025-11-27 19:00:15.537838+00
7855b32d-c18d-4301-b9cc-d94ee25907f8	94b7c21d-c821-495d-a9c1-0f9e4f5d09d8	ai	[Audio session recorded - transcripts not available]	\N	2025-11-27 19:01:36.85257+00
aee87164-b788-43f5-831d-026c4d487eaf	839cbcf1-aa1c-4d50-a5ed-ebda9883c6e7	ai	[Audio session recorded - transcripts not available]	\N	2025-11-27 19:16:27.068282+00
5580e211-f51c-4b43-9d7c-e72a2a5c0966	f314b966-3be6-4623-9729-631016d9f1aa	ai	[Audio session recorded - transcripts not available]	\N	2025-11-27 19:17:29.920369+00
b51160de-4e3b-419c-aa38-f48630cd879e	a3a8785e-80ec-49fe-b332-7ad92e13c133	ai	[Audio session recorded - transcripts not available]	\N	2025-11-28 09:59:14.087295+00
35fb98b8-41c6-4f9e-ad0f-efc3d6231cf5	a3a8785e-80ec-49fe-b332-7ad92e13c133	ai	[Audio session recorded - transcripts not available]	\N	2025-11-28 10:02:34.920544+00
e404d7d6-66c0-40da-bf44-2af067100d5e	0ee549f6-a919-4e5b-bd72-061dbbc50032	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:07:10.743212+00
5577f420-25e5-48d7-badd-41839f1b7966	8e6216ef-d5ed-4481-b6a6-b29381026d03	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:28:15.84009+00
f46bb68e-6451-4d1a-a508-60a12c843d8f	8e6216ef-d5ed-4481-b6a6-b29381026d03	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:28:46.968182+00
28fe3db8-45cc-4013-bffd-d641204cf5e3	1289fe99-32f0-4e27-8c76-736c161a292d	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:29:46.124299+00
bd8f9ebd-1dec-4fc6-8d11-9af9daacdedb	1289fe99-32f0-4e27-8c76-736c161a292d	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:30:10.331227+00
0311a3b6-c8fe-4c0d-adea-bade52fd0af8	764da67c-95cd-4f8c-945b-daa8d442972c	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:33:24.740915+00
ba086d83-9567-481c-8bd4-8ebdc6a63b0b	764da67c-95cd-4f8c-945b-daa8d442972c	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:33:26.723462+00
7eb02fc7-9bb5-4b42-9322-16dab8176ad2	764da67c-95cd-4f8c-945b-daa8d442972c	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:34:57.24831+00
08a9735d-639c-42ac-8712-398b23ac9f21	230f276e-b6bb-4669-8d99-659c81f9b098	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:46:17.196422+00
0bf76229-a097-4fa8-bfef-530e493b9adf	39fde976-1092-478a-bdd6-b43755a75c39	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:48:12.537119+00
a46dfb2f-10d2-4629-873d-763445b6f912	4d4568ad-9626-46e8-9c04-dcb13085f5ac	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 07:12:01.88264+00
f890fbf5-86a6-48b1-90c3-e5165e9ee51d	2a867204-5aec-4d58-8fa7-d61f5de87ecd	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 08:39:54.028552+00
ae64e36d-151a-4c52-84a9-ae1a80185f72	2a867204-5aec-4d58-8fa7-d61f5de87ecd	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 08:40:00.934207+00
56a0698a-420e-4e95-bc94-3202107c770b	e538eeb8-6177-4394-92f9-3e4da35027ed	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 10:27:38.046028+00
5381ffc2-cf56-498d-b4f1-5131cde387fa	e538eeb8-6177-4394-92f9-3e4da35027ed	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 10:27:39.075684+00
55b4deb2-7c8c-4efe-92f6-0668a9c22a8d	e538eeb8-6177-4394-92f9-3e4da35027ed	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 10:28:34.661589+00
\.


--
-- Data for Name: progress_stats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.progress_stats (id, user_id, category_id, session_id, tone_score, clarity_score, pace_score, confidence_score, created_at) FROM stdin;
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
ad8d78d6-bd25-4b4a-84a9-74c7a1324d4b	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-22 15:17:41.146+00	2025-11-22 15:18:06.788+00	\N	\N	2025-11-22 15:17:48.852713+00	11	9	14	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/ad8d78d6-bd25-4b4a-84a9-74c7a1324d4b/user-session-ad8d78d6-bd25-4b4a-84a9-74c7a1324d4b.wav	\N	\N	\N	f
e427e0b7-f9dc-4ac4-b44b-d741bde38c25	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-22 15:31:18.226+00	2025-11-22 15:31:44.657+00	\N	\N	2025-11-22 15:31:25.927058+00	0	0	3	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/e427e0b7-f9dc-4ac4-b44b-d741bde38c25/user-session-e427e0b7-f9dc-4ac4-b44b-d741bde38c25.wav	\N	\N	\N	f
80c7a71d-a220-47b9-b804-c2720fa03e6b	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-22 15:49:50.184+00	2025-11-22 15:50:25.502+00	\N	\N	2025-11-22 15:49:57.954645+00	0	0	2	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/80c7a71d-a220-47b9-b804-c2720fa03e6b/user-session-80c7a71d-a220-47b9-b804-c2720fa03e6b.wav	\N	\N	\N	f
e6289f85-937b-463c-a13f-803e75c2b93c	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-22 16:00:48.049+00	2025-11-22 16:01:31.417+00	\N	\N	2025-11-22 16:00:55.951914+00	0	0	6	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/e6289f85-937b-463c-a13f-803e75c2b93c/user-session-e6289f85-937b-463c-a13f-803e75c2b93c.wav	\N	\N	\N	f
699adfe1-4ba7-4a34-81de-51a508b61fec	e18ee1e2-4763-4967-b241-68338768fc24	76c14387-a946-4987-9f6d-ef7181aab11f	2025-11-23 10:44:53.924+00	2025-11-23 10:45:39.55+00	\N	\N	2025-11-23 10:45:02.4358+00	0	0	27	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/699adfe1-4ba7-4a34-81de-51a508b61fec/user-session-699adfe1-4ba7-4a34-81de-51a508b61fec.wav	\N	\N	\N	f
e9f25cca-98c7-41af-ac55-034a6bf50e7f	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-23 10:51:32.218+00	2025-11-23 10:53:06.731+00	\N	\N	2025-11-23 10:51:40.482784+00	43	0	14	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/e9f25cca-98c7-41af-ac55-034a6bf50e7f/user-session-e9f25cca-98c7-41af-ac55-034a6bf50e7f.wav	\N	\N	\N	f
645618f9-214a-429f-84f6-766d6628c193	e18ee1e2-4763-4967-b241-68338768fc24	2db27344-fc3f-49e1-bc78-714befa53d8e	2025-11-23 10:45:24.891+00	2025-11-23 10:46:05.541+00	\N	\N	2025-11-23 10:45:33.187066+00	4	13	17	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/645618f9-214a-429f-84f6-766d6628c193/user-session-645618f9-214a-429f-84f6-766d6628c193.wav	\N	\N	\N	f
9b08d901-f647-46ce-93b7-5737aa46ce20	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-20 18:10:25.896+00	2025-11-20 18:10:59.098+00	\N	\N	2025-11-20 18:10:31.813225+00	0	0	29	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/9b08d901-f647-46ce-93b7-5737aa46ce20/user-session-9b08d901-f647-46ce-93b7-5737aa46ce20.wav	\N	\N	\N	f
7cf5b7bc-e156-40f9-b218-a86a6b7705af	e18ee1e2-4763-4967-b241-68338768fc24	2db27344-fc3f-49e1-bc78-714befa53d8e	2025-11-20 18:13:56.942+00	2025-11-20 18:14:19.591+00	\N	\N	2025-11-20 18:14:02.839052+00	0	0	32	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/7cf5b7bc-e156-40f9-b218-a86a6b7705af/user-session-7cf5b7bc-e156-40f9-b218-a86a6b7705af.wav	\N	\N	\N	f
afc77018-2481-4756-8c27-5aee2c328944	e18ee1e2-4763-4967-b241-68338768fc24	2db27344-fc3f-49e1-bc78-714befa53d8e	2025-11-20 19:08:16.361+00	2025-11-20 19:08:48.972+00	\N	\N	2025-11-20 19:08:22.447087+00	11	0	17	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/afc77018-2481-4756-8c27-5aee2c328944/user-session-afc77018-2481-4756-8c27-5aee2c328944.wav	\N	\N	\N	f
57205bb3-0069-4bf1-acb7-bb0ba079c948	e18ee1e2-4763-4967-b241-68338768fc24	2db27344-fc3f-49e1-bc78-714befa53d8e	2025-11-20 19:11:16.218+00	2025-11-20 19:11:34.449+00	\N	\N	2025-11-20 19:11:22.176005+00	16	0	21	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/57205bb3-0069-4bf1-acb7-bb0ba079c948/user-session-57205bb3-0069-4bf1-acb7-bb0ba079c948.wav	\N	\N	\N	f
c277e6e7-5623-4753-82c5-1c055d1ecf08	e18ee1e2-4763-4967-b241-68338768fc24	2db27344-fc3f-49e1-bc78-714befa53d8e	2025-11-20 19:27:59.785+00	2025-11-20 19:28:39.147+00	\N	\N	2025-11-20 19:28:05.784599+00	0	0	23	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/c277e6e7-5623-4753-82c5-1c055d1ecf08/user-session-c277e6e7-5623-4753-82c5-1c055d1ecf08.wav	\N	\N	\N	f
546fbf30-af46-4cbb-893c-ed539c3c189b	e18ee1e2-4763-4967-b241-68338768fc24	3ae06ff5-c745-4502-b96c-633447b05787	2025-11-20 19:38:53.977+00	2025-11-20 19:39:20.783+00	\N	\N	2025-11-20 19:38:59.940802+00	0	0	15	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/546fbf30-af46-4cbb-893c-ed539c3c189b/user-session-546fbf30-af46-4cbb-893c-ed539c3c189b.wav	\N	\N	\N	f
cc69a81c-5f17-4f3e-b8e8-47c09cf3f684	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-21 08:13:02.208+00	2025-11-21 08:13:48.779+00	\N	\N	2025-11-21 08:13:08.466769+00	0	0	18	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/cc69a81c-5f17-4f3e-b8e8-47c09cf3f684/user-session-cc69a81c-5f17-4f3e-b8e8-47c09cf3f684.wav	\N	\N	\N	f
e3f79ca1-4117-493b-83af-e0fd90e6213e	e18ee1e2-4763-4967-b241-68338768fc24	29f15ecc-35fc-42c4-913a-afcf26c1075e	2025-11-22 12:43:53.938+00	2025-11-22 12:44:27.25+00	\N	\N	2025-11-22 12:44:01.67093+00	44	0	11	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/e3f79ca1-4117-493b-83af-e0fd90e6213e/user-session-e3f79ca1-4117-493b-83af-e0fd90e6213e.wav	\N	\N	\N	f
a13845e4-609d-4520-a328-0750bbf6a73e	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-22 13:34:07.534+00	2025-11-22 13:34:56.197+00	\N	\N	2025-11-22 13:34:15.16071+00	2	0	6	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/a13845e4-609d-4520-a328-0750bbf6a73e/user-session-a13845e4-609d-4520-a328-0750bbf6a73e.wav	\N	\N	\N	f
21d69bf4-8cd6-46aa-848c-8d80d188ed5a	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-22 14:57:25.623+00	2025-11-22 14:58:07.857+00	\N	\N	2025-11-22 14:57:33.487955+00	1	0	7	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/21d69bf4-8cd6-46aa-848c-8d80d188ed5a/user-session-21d69bf4-8cd6-46aa-848c-8d80d188ed5a.wav	\N	\N	\N	f
780a542b-f7b4-4793-b177-2fb00dadc262	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-23 10:50:45.952+00	\N	\N	\N	2025-11-23 10:50:54.225875+00	\N	\N	\N	\N	\N	\N	\N	f
70aeaec4-ef4f-457f-8882-8c146f264acb	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-23 10:50:49.057+00	2025-11-23 10:51:02.094+00	\N	\N	2025-11-23 10:50:57.315373+00	\N	\N	\N	\N	\N	\N	\N	f
cbdcb2d1-be56-415f-a814-ed980d1d83d3	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-23 10:50:06.115+00	2025-11-23 10:51:11.294+00	\N	\N	2025-11-23 10:50:14.617529+00	66	0	24	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/cbdcb2d1-be56-415f-a814-ed980d1d83d3/user-session-cbdcb2d1-be56-415f-a814-ed980d1d83d3.wav	\N	\N	\N	f
2dbe3657-99bb-40a3-b642-eb1c3fc6fff5	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-23 10:51:15.581+00	\N	\N	\N	2025-11-23 10:51:23.865316+00	\N	\N	\N	\N	\N	\N	\N	f
12c4620d-6f95-40d4-b74b-f3dfffd36d22	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-23 10:51:27.576+00	\N	\N	\N	2025-11-23 10:51:35.846313+00	\N	\N	\N	\N	\N	\N	\N	f
f47656f1-929c-4ad9-b566-8f666675a197	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-23 10:51:31.993+00	\N	\N	\N	2025-11-23 10:51:40.245037+00	\N	\N	\N	\N	\N	\N	\N	f
8dc77c96-ff24-49f1-83a1-9eb87d1c6b0e	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-23 12:13:57.058+00	2025-11-23 12:14:53.364+00	\N	\N	2025-11-23 12:14:05.590566+00	64	8	13	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/8dc77c96-ff24-49f1-83a1-9eb87d1c6b0e/user-session-8dc77c96-ff24-49f1-83a1-9eb87d1c6b0e.wav	\N	\N	\N	f
52122ac4-7cd7-4437-bf5d-3d0cf486693c	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-25 09:07:26.881+00	2025-11-25 09:08:37.604+00	\N	\N	2025-11-25 09:07:31.121974+00	\N	\N	\N	\N	\N	\N	\N	f
4b444496-a736-4249-a416-99d679a93fbb	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-25 09:09:03.974+00	\N	\N	\N	2025-11-25 09:09:08.550419+00	\N	\N	\N	\N	\N	\N	\N	f
c19d4bca-3e47-40e6-9697-4094a63ff0fc	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-25 09:09:22.072+00	2025-11-25 09:11:15.313+00	\N	\N	2025-11-25 09:09:32.018704+00	0	0	25	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/c19d4bca-3e47-40e6-9697-4094a63ff0fc/user-session-c19d4bca-3e47-40e6-9697-4094a63ff0fc.wav	\N	\N	\N	f
92b6a497-084e-42f4-8cfc-6fb017defbff	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-25 09:13:19.736+00	2025-11-25 09:14:38.848+00	\N	\N	2025-11-25 09:13:23.879918+00	0	0	25	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/92b6a497-084e-42f4-8cfc-6fb017defbff/user-session-92b6a497-084e-42f4-8cfc-6fb017defbff.wav	\N	\N	\N	f
555e6afb-756a-4e69-b829-5d536fd94c63	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-27 18:58:41.288+00	2025-11-27 19:00:12.149+00	\N	\N	2025-11-27 18:58:45.332522+00	0	13	15	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/555e6afb-756a-4e69-b829-5d536fd94c63/user-session-555e6afb-756a-4e69-b829-5d536fd94c63.wav	\N	\N	\N	f
61818930-a351-49b6-8249-89e360ffcc95	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-27 19:00:32.648+00	\N	\N	\N	2025-11-27 19:00:36.45828+00	\N	\N	\N	\N	\N	\N	\N	f
94b7c21d-c821-495d-a9c1-0f9e4f5d09d8	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-27 19:00:36.156+00	2025-11-27 19:01:33.465+00	\N	\N	2025-11-27 19:00:39.946529+00	0	17	15	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/94b7c21d-c821-495d-a9c1-0f9e4f5d09d8/user-session-94b7c21d-c821-495d-a9c1-0f9e4f5d09d8.wav	\N	\N	\N	f
839cbcf1-aa1c-4d50-a5ed-ebda9883c6e7	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-27 19:14:44.878+00	2025-11-27 19:16:23.702+00	\N	\N	2025-11-27 19:14:48.786743+00	0	0	6	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/839cbcf1-aa1c-4d50-a5ed-ebda9883c6e7/user-session-839cbcf1-aa1c-4d50-a5ed-ebda9883c6e7.wav	\N	\N	\N	f
f314b966-3be6-4623-9729-631016d9f1aa	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-27 19:16:29.937+00	2025-11-27 19:17:26.514+00	\N	\N	2025-11-27 19:16:33.744051+00	0	0	2	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/f314b966-3be6-4623-9729-631016d9f1aa/user-session-f314b966-3be6-4623-9729-631016d9f1aa.wav	\N	\N	\N	f
e538eeb8-6177-4394-92f9-3e4da35027ed	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 10:25:33.735+00	2025-11-29 10:28:31.899+00	\N	\N	2025-11-29 10:25:36.715505+00	0	0	41	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/e538eeb8-6177-4394-92f9-3e4da35027ed/user-session-e538eeb8-6177-4394-92f9-3e4da35027ed.wav	\N	\N	\N	f
a3a8785e-80ec-49fe-b332-7ad92e13c133	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-28 09:56:58.912+00	2025-11-28 10:02:34.892+00	\N	\N	2025-11-28 09:56:59.637904+00	0	0	16	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/a3a8785e-80ec-49fe-b332-7ad92e13c133/user-session-a3a8785e-80ec-49fe-b332-7ad92e13c133.wav	\N	\N	\N	f
3809e56e-4ab3-45a6-8671-a004e57b258e	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 06:00:12.588+00	\N	\N	\N	2025-11-29 06:00:16.396035+00	\N	\N	\N	\N	\N	\N	\N	f
0ee549f6-a919-4e5b-bd72-061dbbc50032	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 06:05:36.202+00	2025-11-29 06:07:07.879+00	\N	\N	2025-11-29 06:05:41.610628+00	0	0	36	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/0ee549f6-a919-4e5b-bd72-061dbbc50032/user-session-0ee549f6-a919-4e5b-bd72-061dbbc50032.wav	\N	\N	\N	f
8e6216ef-d5ed-4481-b6a6-b29381026d03	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 06:27:17.02+00	2025-11-29 06:28:59.498+00	\N	\N	2025-11-29 06:27:20.478967+00	0	0	35	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/8e6216ef-d5ed-4481-b6a6-b29381026d03/user-session-8e6216ef-d5ed-4481-b6a6-b29381026d03.wav	\N	\N	\N	f
1289fe99-32f0-4e27-8c76-736c161a292d	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 06:29:06.729+00	2025-11-29 06:30:07.484+00	\N	\N	2025-11-29 06:29:10.18228+00	0	0	33	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/1289fe99-32f0-4e27-8c76-736c161a292d/user-session-1289fe99-32f0-4e27-8c76-736c161a292d.wav	\N	\N	\N	f
764da67c-95cd-4f8c-945b-daa8d442972c	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 06:32:00.489+00	2025-11-29 06:34:54.507+00	\N	\N	2025-11-29 06:32:04.364516+00	0	0	42	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/764da67c-95cd-4f8c-945b-daa8d442972c/user-session-764da67c-95cd-4f8c-945b-daa8d442972c.wav	\N	\N	\N	f
38a82994-512e-4a7c-82e8-62cb40e35c45	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-29 06:45:57.498+00	\N	\N	\N	2025-11-29 06:46:00.957693+00	\N	\N	\N	\N	\N	\N	\N	f
230f276e-b6bb-4669-8d99-659c81f9b098	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-29 06:46:01.672+00	2025-11-29 06:46:17.827+00	\N	\N	2025-11-29 06:46:05.142313+00	\N	\N	\N	\N	\N	\N	\N	f
8068d8b2-ce51-481b-816a-5ad6f8e5a02a	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 06:46:50.129+00	\N	\N	\N	2025-11-29 06:46:53.577924+00	\N	\N	\N	\N	\N	\N	\N	f
39fde976-1092-478a-bdd6-b43755a75c39	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 06:47:03.471+00	2025-11-29 06:48:09.519+00	\N	\N	2025-11-29 06:47:06.910634+00	\N	\N	\N	\N	\N	\N	\N	f
4b6e969e-b27b-49f0-92e0-25e092eca6f0	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 07:10:30.326+00	\N	\N	\N	2025-11-29 07:10:34.029634+00	\N	\N	\N	\N	\N	\N	\N	f
4d4568ad-9626-46e8-9c04-dcb13085f5ac	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 07:10:38.144+00	2025-11-29 07:11:59.383+00	\N	\N	2025-11-29 07:10:41.61672+00	\N	\N	\N	\N	\N	\N	\N	f
102ffbc5-01d8-4f20-95dd-384b4c517598	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 08:38:16.356+00	\N	\N	\N	2025-11-29 08:38:20.450298+00	\N	\N	\N	\N	\N	\N	\N	f
ba76072d-e21e-41f7-8234-58f1a9ef1792	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 08:38:35.1+00	\N	\N	\N	2025-11-29 08:38:38.553948+00	\N	\N	\N	\N	\N	\N	\N	f
56b80c19-4235-42da-af2e-09f2d2fe5d20	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 08:38:50.183+00	\N	\N	\N	2025-11-29 08:38:53.631773+00	\N	\N	\N	\N	\N	\N	\N	f
5db65a2b-8404-4191-b2ba-a724ff90cb2c	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 08:38:50.705+00	\N	\N	\N	2025-11-29 08:38:54.152489+00	\N	\N	\N	\N	\N	\N	\N	f
4c8b8964-e04c-4884-9dc2-bc310847d892	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 08:38:50.895+00	\N	\N	\N	2025-11-29 08:38:54.341058+00	\N	\N	\N	\N	\N	\N	\N	f
1d6a5ea3-4b10-46ed-9f0f-d29957f26128	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 08:38:51.117+00	\N	\N	\N	2025-11-29 08:38:54.61265+00	\N	\N	\N	\N	\N	\N	\N	f
2a867204-5aec-4d58-8fa7-d61f5de87ecd	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 08:39:39.56+00	2025-11-29 08:39:57.833+00	\N	\N	2025-11-29 08:39:43.045917+00	7	0	50	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/2a867204-5aec-4d58-8fa7-d61f5de87ecd/user-session-2a867204-5aec-4d58-8fa7-d61f5de87ecd.wav	\N	\N	\N	f
eb68e28b-d503-4642-9ccf-d6757f09a423	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 08:47:49.732+00	\N	\N	\N	2025-11-29 08:47:53.806185+00	\N	\N	\N	\N	\N	\N	\N	f
1520748e-e6e0-47b8-843e-78d41a435ec3	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 10:22:55.663+00	\N	\N	\N	2025-11-29 10:22:58.974618+00	\N	\N	\N	\N	\N	\N	\N	f
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, created_at, password) FROM stdin;
e18ee1e2-4763-4967-b241-68338768fc24	Chetan More	chetan@gmail.com	2025-11-18 10:08:32.197954+00	123456
ef861189-bf08-4014-97a7-56136c9bb668	vaibhavi 	vaibhavisuvarna7@gmail.com	2025-11-25 12:59:09.3854+00	123456
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-11-18 06:20:29
20211116045059	2025-11-18 06:20:30
20211116050929	2025-11-18 06:20:31
20211116051442	2025-11-18 06:20:32
20211116212300	2025-11-18 06:20:33
20211116213355	2025-11-18 06:20:34
20211116213934	2025-11-18 06:20:34
20211116214523	2025-11-18 06:20:35
20211122062447	2025-11-18 06:20:36
20211124070109	2025-11-18 06:20:37
20211202204204	2025-11-18 06:20:38
20211202204605	2025-11-18 06:20:38
20211210212804	2025-11-18 06:20:41
20211228014915	2025-11-18 06:20:41
20220107221237	2025-11-18 06:20:42
20220228202821	2025-11-18 06:20:43
20220312004840	2025-11-18 06:20:44
20220603231003	2025-11-18 06:20:45
20220603232444	2025-11-18 06:20:46
20220615214548	2025-11-18 06:20:46
20220712093339	2025-11-18 06:20:47
20220908172859	2025-11-18 06:20:48
20220916233421	2025-11-18 06:20:49
20230119133233	2025-11-18 06:20:49
20230128025114	2025-11-18 06:20:50
20230128025212	2025-11-18 06:20:51
20230227211149	2025-11-18 06:20:52
20230228184745	2025-11-18 06:20:53
20230308225145	2025-11-18 06:20:53
20230328144023	2025-11-18 06:20:54
20231018144023	2025-11-18 06:20:55
20231204144023	2025-11-18 06:20:56
20231204144024	2025-11-18 06:20:57
20231204144025	2025-11-18 06:20:58
20240108234812	2025-11-18 06:20:58
20240109165339	2025-11-18 06:20:59
20240227174441	2025-11-18 06:21:00
20240311171622	2025-11-18 06:21:02
20240321100241	2025-11-18 06:21:03
20240401105812	2025-11-18 06:21:05
20240418121054	2025-11-18 06:21:06
20240523004032	2025-11-18 06:21:09
20240618124746	2025-11-18 06:21:10
20240801235015	2025-11-18 06:21:11
20240805133720	2025-11-18 06:21:11
20240827160934	2025-11-18 06:21:12
20240919163303	2025-11-18 06:21:13
20240919163305	2025-11-18 06:21:14
20241019105805	2025-11-18 06:21:15
20241030150047	2025-11-18 06:21:17
20241108114728	2025-11-18 06:21:19
20241121104152	2025-11-18 06:21:19
20241130184212	2025-11-18 06:21:20
20241220035512	2025-11-18 06:21:21
20241220123912	2025-11-18 06:21:22
20241224161212	2025-11-18 06:21:23
20250107150512	2025-11-18 06:21:24
20250110162412	2025-11-18 06:21:24
20250123174212	2025-11-18 06:21:25
20250128220012	2025-11-18 06:21:26
20250506224012	2025-11-18 06:21:27
20250523164012	2025-11-18 06:21:27
20250714121412	2025-11-18 06:21:28
20250905041441	2025-11-18 06:21:29
20251103001201	2025-11-18 06:21:30
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
recordings	recordings	\N	2025-11-19 05:54:47.415489+00	2025-11-19 05:54:47.415489+00	t	f	52428800	{audio/mpeg,audio/mp3,audio/wav}	\N	STANDARD
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-11-18 06:20:28.780364
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-11-18 06:20:28.803926
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-11-18 06:20:28.817054
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-11-18 06:20:28.870357
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-11-18 06:20:29.0194
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-11-18 06:20:29.026683
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-11-18 06:20:29.037327
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-11-18 06:20:29.044728
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-11-18 06:20:29.052034
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-11-18 06:20:29.059565
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-11-18 06:20:29.068559
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-11-18 06:20:29.076479
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-11-18 06:20:29.091072
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-11-18 06:20:29.098721
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-11-18 06:20:29.109941
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-11-18 06:20:29.150746
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-11-18 06:20:29.159749
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-11-18 06:20:29.168167
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-11-18 06:20:29.177998
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-11-18 06:20:29.189532
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-11-18 06:20:29.197819
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-11-18 06:20:29.207165
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-11-18 06:20:29.229689
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-11-18 06:20:29.244121
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-11-18 06:20:29.251969
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-11-18 06:20:29.2597
26	objects-prefixes	ef3f7871121cdc47a65308e6702519e853422ae2	2025-11-18 06:20:29.267448
27	search-v2	33b8f2a7ae53105f028e13e9fcda9dc4f356b4a2	2025-11-18 06:20:29.285081
28	object-bucket-name-sorting	ba85ec41b62c6a30a3f136788227ee47f311c436	2025-11-18 06:20:30.093728
29	create-prefixes	a7b1a22c0dc3ab630e3055bfec7ce7d2045c5b7b	2025-11-18 06:20:30.114872
30	update-object-levels	6c6f6cc9430d570f26284a24cf7b210599032db7	2025-11-18 06:20:30.126501
31	objects-level-index	33f1fef7ec7fea08bb892222f4f0f5d79bab5eb8	2025-11-18 06:20:30.655459
32	backward-compatible-index-on-objects	2d51eeb437a96868b36fcdfb1ddefdf13bef1647	2025-11-18 06:20:31.25633
33	backward-compatible-index-on-prefixes	fe473390e1b8c407434c0e470655945b110507bf	2025-11-18 06:20:31.396116
34	optimize-search-function-v1	82b0e469a00e8ebce495e29bfa70a0797f7ebd2c	2025-11-18 06:20:31.398752
35	add-insert-trigger-prefixes	63bb9fd05deb3dc5e9fa66c83e82b152f0caf589	2025-11-18 06:20:31.435979
36	optimise-existing-functions	81cf92eb0c36612865a18016a38496c530443899	2025-11-18 06:20:31.448947
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2025-11-18 06:20:31.549193
38	iceberg-catalog-flag-on-buckets	19a8bd89d5dfa69af7f222a46c726b7c41e462c5	2025-11-18 06:20:31.56618
39	add-search-v2-sort-support	39cf7d1e6bf515f4b02e41237aba845a7b492853	2025-11-18 06:20:31.69827
40	fix-prefix-race-conditions-optimized	fd02297e1c67df25a9fc110bf8c8a9af7fb06d1f	2025-11-18 06:20:31.707441
41	add-object-level-update-trigger	44c22478bf01744b2129efc480cd2edc9a7d60e9	2025-11-18 06:20:31.724687
42	rollback-prefix-triggers	f2ab4f526ab7f979541082992593938c05ee4b47	2025-11-18 06:20:31.73273
43	fix-object-level	ab837ad8f1c7d00cc0b7310e989a23388ff29fc6	2025-11-18 06:20:31.745194
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2025-11-18 06:20:31.756243
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2025-11-18 06:20:31.764783
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2025-11-18 06:20:31.781983
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2025-11-18 06:20:31.789631
48	iceberg-catalog-ids	2666dff93346e5d04e0a878416be1d5fec345d6f	2025-11-18 06:20:31.796647
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2025-11-27 18:58:28.014727
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, level) FROM stdin;
7a2a0e83-063d-4327-b6ac-306cfdd3ace2	recordings	e18ee1e2-4763-4967-b241-68338768fc24/1da67cdf-0594-4cf2-9264-277f9e0775be/ai-1763533254165.mp3	\N	2025-11-19 06:20:58.237307+00	2025-11-19 06:20:58.237307+00	2025-11-19 06:20:58.237307+00	{"eTag": "\\"22fa4147eca5b9267d307a08278b4681\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:20:59.000Z", "contentLength": 24064, "httpStatusCode": 200}	6a78f719-63ae-4728-82d2-7a7497ab6847	\N	{}	3
1043ac5e-50e3-4523-95a5-c8f2ee65cf1a	recordings	e18ee1e2-4763-4967-b241-68338768fc24/94b7c21d-c821-495d-a9c1-0f9e4f5d09d8/user-session-94b7c21d-c821-495d-a9c1-0f9e4f5d09d8.wav	\N	2025-11-27 19:01:20.976226+00	2025-11-27 19:01:20.976226+00	2025-11-27 19:01:20.976226+00	{"eTag": "\\"16ec4cdb1be01a59ad3d8bc738a98fa0\\"", "size": 4371884, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-27T19:01:21.000Z", "contentLength": 4371884, "httpStatusCode": 200}	31675871-cddd-4803-a7ee-96caeff8acf1	\N	{}	3
1f8da9a4-5085-4f0f-ad26-ee76417a94e3	recordings	e18ee1e2-4763-4967-b241-68338768fc24/1da67cdf-0594-4cf2-9264-277f9e0775be/ai-1763533254430.mp3	\N	2025-11-19 06:20:58.412288+00	2025-11-19 06:20:58.412288+00	2025-11-19 06:20:58.412288+00	{"eTag": "\\"2503dd5875780b4e859f5f2752f40db4\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:20:59.000Z", "contentLength": 24064, "httpStatusCode": 200}	0623469e-81ef-4c9b-8f7d-a6f43f39d559	\N	{}	3
c66137bf-870f-4016-9b07-5a0138d86814	recordings	e18ee1e2-4763-4967-b241-68338768fc24/1da67cdf-0594-4cf2-9264-277f9e0775be/ai-1763533254919.mp3	\N	2025-11-19 06:20:58.529736+00	2025-11-19 06:20:58.529736+00	2025-11-19 06:20:58.529736+00	{"eTag": "\\"a58d9f431ab304e0136d9d586a7d52fd\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:20:59.000Z", "contentLength": 24064, "httpStatusCode": 200}	95f195f2-5889-425d-a353-1befea3be5d2	\N	{}	3
2b059e65-2862-4258-8654-83f91fdbcaad	recordings	e18ee1e2-4763-4967-b241-68338768fc24/1da67cdf-0594-4cf2-9264-277f9e0775be/ai-1763533255421.mp3	\N	2025-11-19 06:20:58.892893+00	2025-11-19 06:20:58.892893+00	2025-11-19 06:20:58.892893+00	{"eTag": "\\"d642894c32530eab8089dfab84b64614\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:20:59.000Z", "contentLength": 24064, "httpStatusCode": 200}	5fcac152-286d-47cd-8b8b-4fc9361042f4	\N	{}	3
b15e8538-91f0-4703-a127-ee5563bbf50a	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533343862.mp3	\N	2025-11-19 06:22:27.848499+00	2025-11-19 06:22:27.848499+00	2025-11-19 06:22:27.848499+00	{"eTag": "\\"cebb58c5df526b46a16bf345e83351de\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:28.000Z", "contentLength": 24064, "httpStatusCode": 200}	a2b570fe-b0ed-4000-811c-c2beb7233d25	\N	{}	3
96b54b6b-6e64-430d-a890-da8d116dc3c6	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533344105.mp3	\N	2025-11-19 06:22:27.985583+00	2025-11-19 06:22:27.985583+00	2025-11-19 06:22:27.985583+00	{"eTag": "\\"9cbd8f28ddf84e80c58039a3e2328cd4\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:28.000Z", "contentLength": 24064, "httpStatusCode": 200}	fab25501-f493-41d0-abb3-0ae19a91059f	\N	{}	3
524498ec-8de2-4976-b83a-2dff77b312da	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533344607.mp3	\N	2025-11-19 06:22:28.198167+00	2025-11-19 06:22:28.198167+00	2025-11-19 06:22:28.198167+00	{"eTag": "\\"bbafd757e95e83fb234450dc7efcb6a3\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:29.000Z", "contentLength": 24064, "httpStatusCode": 200}	3592a700-4b69-4b2f-8788-5fe7c0d1ac60	\N	{}	3
614f6a5f-38f9-4001-a38e-1c6c9a715088	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533344864.mp3	\N	2025-11-19 06:22:28.349881+00	2025-11-19 06:22:28.349881+00	2025-11-19 06:22:28.349881+00	{"eTag": "\\"5a92c10714fd3c929aa2c8daba06503f\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:29.000Z", "contentLength": 24064, "httpStatusCode": 200}	dfbd2473-f9d9-4740-89f6-3b200e4559c4	\N	{}	3
409bd4a6-014f-4428-a1c8-8e41d49b01ef	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533345108.mp3	\N	2025-11-19 06:22:28.583456+00	2025-11-19 06:22:28.583456+00	2025-11-19 06:22:28.583456+00	{"eTag": "\\"f8d2b4b1772b82c78f4ba6ff3dc83056\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:29.000Z", "contentLength": 24064, "httpStatusCode": 200}	26727d3f-b7d1-430a-8d36-79968970ed26	\N	{}	3
0ff0813c-9713-4281-ac72-a9256d8c5b10	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533345365.mp3	\N	2025-11-19 06:22:28.819937+00	2025-11-19 06:22:28.819937+00	2025-11-19 06:22:28.819937+00	{"eTag": "\\"ef1401e5304f8fa62c0a128a9ee2f148\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:29.000Z", "contentLength": 24064, "httpStatusCode": 200}	632e3286-8d4d-44dd-a059-977968766721	\N	{}	3
c4b6f11b-501f-4f7c-b5ad-7c5018c1b867	recordings	e18ee1e2-4763-4967-b241-68338768fc24/839cbcf1-aa1c-4d50-a5ed-ebda9883c6e7/user-session-839cbcf1-aa1c-4d50-a5ed-ebda9883c6e7.wav	\N	2025-11-27 19:16:04.214909+00	2025-11-27 19:16:04.214909+00	2025-11-27 19:16:04.214909+00	{"eTag": "\\"93bf0c8a1f5029a7b3d6a079df5c2e27-2\\"", "size": 6462764, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-27T19:16:04.000Z", "contentLength": 6462764, "httpStatusCode": 200}	f1c1e10e-eeff-4d5d-8586-32f9a6a48371	\N	{}	3
5fd6478f-bea5-42e7-a1a6-acc10e6d7ffa	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533346113.mp3	\N	2025-11-19 06:22:29.620054+00	2025-11-19 06:22:29.620054+00	2025-11-19 06:22:29.620054+00	{"eTag": "\\"ca830b791093be464a74561daa6f3fd4\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:30.000Z", "contentLength": 24064, "httpStatusCode": 200}	22e01d48-c9c3-4a93-8a9a-091aaddf195f	\N	{}	3
a0e4aa3b-3a7e-4928-8101-45c7df46f86a	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533346368.mp3	\N	2025-11-19 06:22:29.861156+00	2025-11-19 06:22:29.861156+00	2025-11-19 06:22:29.861156+00	{"eTag": "\\"82fd275ef702409f71dcd7ded73aa17b\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:30.000Z", "contentLength": 24064, "httpStatusCode": 200}	4be5db33-e13d-4e41-aa53-02e12949d897	\N	{}	3
4952ac95-cae8-4210-9014-35c1877be064	recordings	e18ee1e2-4763-4967-b241-68338768fc24/f314b966-3be6-4623-9729-631016d9f1aa/user-session-f314b966-3be6-4623-9729-631016d9f1aa.wav	\N	2025-11-27 19:17:16.409119+00	2025-11-27 19:17:16.409119+00	2025-11-27 19:17:16.409119+00	{"eTag": "\\"0b82e636b90f07cb0359d9e9d73dd7b4\\"", "size": 3467564, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-27T19:17:17.000Z", "contentLength": 3467564, "httpStatusCode": 200}	b6d12829-d1eb-4c5e-b2a8-aac9b732f5d7	\N	{}	3
27d37451-1fe9-4816-ad14-e2a71235e239	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533346612.mp3	\N	2025-11-19 06:22:30.085487+00	2025-11-19 06:22:30.085487+00	2025-11-19 06:22:30.085487+00	{"eTag": "\\"577760deed0e51d343861a66103db08b\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:31.000Z", "contentLength": 24064, "httpStatusCode": 200}	ff40751f-d974-4730-baae-7969cda1fb12	\N	{}	3
2839b021-c238-4329-93a0-6e5d91e0cbd3	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533346870.mp3	\N	2025-11-19 06:22:30.34373+00	2025-11-19 06:22:30.34373+00	2025-11-19 06:22:30.34373+00	{"eTag": "\\"f56e577367d85eceee67a1351fe7b2cb\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:31.000Z", "contentLength": 24064, "httpStatusCode": 200}	dac9d1d7-5db5-4061-90f7-2c7aed034f63	\N	{}	3
a9edcfd4-9c32-47c7-80a9-297aa48efa4d	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533347114.mp3	\N	2025-11-19 06:22:30.548327+00	2025-11-19 06:22:30.548327+00	2025-11-19 06:22:30.548327+00	{"eTag": "\\"3c1719a43354041e3c320b451793ef2a\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:31.000Z", "contentLength": 24064, "httpStatusCode": 200}	f67dd179-1551-4989-8012-9e0bdbc6a18b	\N	{}	3
ce42fcfd-8037-48f1-ab30-d738ac0f62a2	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533347370.mp3	\N	2025-11-19 06:22:30.826541+00	2025-11-19 06:22:30.826541+00	2025-11-19 06:22:30.826541+00	{"eTag": "\\"41cfe384ce63028b0cea82ac9b542dab\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:31.000Z", "contentLength": 24064, "httpStatusCode": 200}	f4f445cd-f4ba-45d1-aafa-4ba7b076bb57	\N	{}	3
3ed1889c-0855-42a7-9fe2-6f21faed905e	recordings	e18ee1e2-4763-4967-b241-68338768fc24/69ca43e5-d0b1-40d8-891a-18dfab093588/session-69ca43e5-d0b1-40d8-891a-18dfab093588.mp3	\N	2025-11-19 06:37:43.758341+00	2025-11-19 06:37:43.758341+00	2025-11-19 06:37:43.758341+00	{"eTag": "\\"753840d67ffabad22e3e054598046809\\"", "size": 745984, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:37:44.000Z", "contentLength": 745984, "httpStatusCode": 200}	e7c9722a-08a6-470a-9636-c4557ba6106c	\N	{}	3
dab3a300-9c0b-4450-b42a-2e2fa03f5b03	recordings	e18ee1e2-4763-4967-b241-68338768fc24/e609a755-0ca1-400c-9a91-0e1919e43644/session-e609a755-0ca1-400c-9a91-0e1919e43644.mp3	\N	2025-11-19 07:09:06.04887+00	2025-11-19 07:09:06.04887+00	2025-11-19 07:09:06.04887+00	{"eTag": "\\"47c4f1d945393cfcd6cdfed04c98337d\\"", "size": 385024, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T07:09:06.000Z", "contentLength": 385024, "httpStatusCode": 200}	4c45eb4f-c2fb-4545-a52e-75b1d474bb05	\N	{}	3
49de9b24-6761-4df1-9079-66a1eee2924f	recordings	e18ee1e2-4763-4967-b241-68338768fc24/85b4ffbc-2b3f-4310-9464-95703b4505b3/session-85b4ffbc-2b3f-4310-9464-95703b4505b3.mp3	\N	2025-11-20 14:54:21.483243+00	2025-11-20 14:54:21.483243+00	2025-11-20 14:54:21.483243+00	{"eTag": "\\"0fbc62f1bdb2f44df3a20b5f1251cd0d\\"", "size": 673792, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T14:54:22.000Z", "contentLength": 673792, "httpStatusCode": 200}	92c5c9d5-5d67-4051-8653-0583aecfc017	\N	{}	3
229f0cc0-6f62-4646-be14-e12dd35c7e45	recordings	e18ee1e2-4763-4967-b241-68338768fc24/a3a8785e-80ec-49fe-b332-7ad92e13c133/user-session-a3a8785e-80ec-49fe-b332-7ad92e13c133.wav	\N	2025-11-28 10:00:56.387158+00	2025-11-28 10:00:56.387158+00	2025-11-28 10:00:56.387158+00	{"eTag": "\\"be664d5ff6b56e1592a29287471a7de4-2\\"", "size": 7505324, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-28T10:00:56.000Z", "contentLength": 7505324, "httpStatusCode": 200}	e706464e-a131-4a5b-9aed-a84c56577e9d	\N	{}	3
aa67d298-535b-4d2e-a421-84c4ca1b066c	recordings	e18ee1e2-4763-4967-b241-68338768fc24/105d9ed9-c189-49b2-b224-0c2b579aede7/session-105d9ed9-c189-49b2-b224-0c2b579aede7.mp3	\N	2025-11-20 15:48:09.366616+00	2025-11-20 15:48:09.366616+00	2025-11-20 15:48:09.366616+00	{"eTag": "\\"3519ce60f6f43a49ba14ada2fc6a1385\\"", "size": 120320, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T15:48:10.000Z", "contentLength": 120320, "httpStatusCode": 200}	ed9e4df6-1d47-455e-b992-05ef7cc6820a	\N	{}	3
978c1eb8-7f1b-4cca-b54a-68559e215828	recordings	e18ee1e2-4763-4967-b241-68338768fc24/8e81176b-00d3-4fb6-83e7-b92de76f78a0/session-8e81176b-00d3-4fb6-83e7-b92de76f78a0.mp3	\N	2025-11-20 15:53:23.882111+00	2025-11-20 15:53:23.882111+00	2025-11-20 15:53:23.882111+00	{"eTag": "\\"c2a2609aaacb40ee7d31e41381a29d85\\"", "size": 312832, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T15:53:24.000Z", "contentLength": 312832, "httpStatusCode": 200}	12719d72-f68e-4db1-a8d8-6bc3e981b79d	\N	{}	3
8495fb50-86c3-4abf-ad23-d9b2ad32d584	recordings	e18ee1e2-4763-4967-b241-68338768fc24/f4bf2215-d62c-4057-ae9a-b19c89552bbc/session-f4bf2215-d62c-4057-ae9a-b19c89552bbc.mp3	\N	2025-11-20 16:06:30.554027+00	2025-11-20 16:06:30.554027+00	2025-11-20 16:06:30.554027+00	{"eTag": "\\"eba4c01f7ffd224a233a3257c4b9359c\\"", "size": 336896, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T16:06:31.000Z", "contentLength": 336896, "httpStatusCode": 200}	9107b00c-4398-489c-9920-a0671506d971	\N	{}	3
1dab851b-ecdf-44e8-872c-f7742e02c561	recordings	e18ee1e2-4763-4967-b241-68338768fc24/5fdd4029-f514-4b22-b71d-044ff256102b/session-5fdd4029-f514-4b22-b71d-044ff256102b.mp3	\N	2025-11-20 17:46:03.003295+00	2025-11-20 17:46:03.003295+00	2025-11-20 17:46:03.003295+00	{"eTag": "\\"3824837a96f76ee9a5df1f3318e4e052\\"", "size": 1227264, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T17:46:03.000Z", "contentLength": 1227264, "httpStatusCode": 200}	78918018-9aeb-4b42-824e-4a3c6bde273a	\N	{}	3
33146644-daf3-43a0-8f81-f519e3d0c284	recordings	e18ee1e2-4763-4967-b241-68338768fc24/6cfccfac-4ef1-457e-a62f-6d1f35564de8/session-6cfccfac-4ef1-457e-a62f-6d1f35564de8.mp3	\N	2025-11-20 17:46:26.312565+00	2025-11-20 17:46:26.312565+00	2025-11-20 17:46:26.312565+00	{"eTag": "\\"28935ad16283565a3df7ec0b7b25e8d4\\"", "size": 240640, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T17:46:27.000Z", "contentLength": 240640, "httpStatusCode": 200}	312d1756-0154-4354-bdb3-c6848dce963b	\N	{}	3
34726d13-bb4a-4880-b351-460a16800b37	recordings	e18ee1e2-4763-4967-b241-68338768fc24/63c2b218-6480-4ed1-b09c-01b93ec73508/session-63c2b218-6480-4ed1-b09c-01b93ec73508.mp3	\N	2025-11-20 17:58:55.622559+00	2025-11-20 17:58:55.622559+00	2025-11-20 17:58:55.622559+00	{"eTag": "\\"37bc2707a25016f8d0d2178c0df2eed2\\"", "size": 433152, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T17:58:56.000Z", "contentLength": 433152, "httpStatusCode": 200}	c96b5ca8-14bb-4bac-8293-91781cb58ad3	\N	{}	3
daa7bc8a-69f6-4388-915a-6946540737d2	recordings	e18ee1e2-4763-4967-b241-68338768fc24/9fb7b3ed-988b-4750-82af-308daf931f97/session-9fb7b3ed-988b-4750-82af-308daf931f97.mp3	\N	2025-11-20 18:00:40.352575+00	2025-11-20 18:00:40.352575+00	2025-11-20 18:00:40.352575+00	{"eTag": "\\"6273dbb239ec12579c2bdcbfe9c82357\\"", "size": 288768, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T18:00:41.000Z", "contentLength": 288768, "httpStatusCode": 200}	0d6ff63a-38e4-43b2-9a92-4219b88c85bc	\N	{}	3
e323187d-7a11-4cfa-8e7b-28e8ad63a959	recordings	e18ee1e2-4763-4967-b241-68338768fc24/0ee549f6-a919-4e5b-bd72-061dbbc50032/user-session-0ee549f6-a919-4e5b-bd72-061dbbc50032.wav	\N	2025-11-29 06:06:37.345014+00	2025-11-29 06:06:37.345014+00	2025-11-29 06:06:37.345014+00	{"eTag": "\\"22f79df92acca334d84a094cf2955ad5\\"", "size": 3818924, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-29T06:06:38.000Z", "contentLength": 3818924, "httpStatusCode": 200}	59ead3eb-abf9-4817-8ca9-b81070bfbd1c	\N	{}	3
e73cf321-9fa4-4416-ae70-1335935bf1d8	recordings	e18ee1e2-4763-4967-b241-68338768fc24/9b08d901-f647-46ce-93b7-5737aa46ce20/user-session-9b08d901-f647-46ce-93b7-5737aa46ce20.wav	\N	2025-11-20 18:10:56.992628+00	2025-11-20 18:10:56.992628+00	2025-11-20 18:10:56.992628+00	{"eTag": "\\"fd344d42195f9977b81c0f7e9eef91cd\\"", "size": 1756844, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T18:10:57.000Z", "contentLength": 1756844, "httpStatusCode": 200}	0d195a3a-1c36-4b09-a9bb-540b8fbae3ad	\N	{}	3
4dbd6914-8ebe-49f3-bd03-d71f197eb81d	recordings	e18ee1e2-4763-4967-b241-68338768fc24/7cf5b7bc-e156-40f9-b218-a86a6b7705af/user-session-7cf5b7bc-e156-40f9-b218-a86a6b7705af.wav	\N	2025-11-20 18:14:20.481578+00	2025-11-20 18:14:20.481578+00	2025-11-20 18:14:20.481578+00	{"eTag": "\\"a0dcda004a948b49df1d167c05c24d2e\\"", "size": 1123244, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T18:14:21.000Z", "contentLength": 1123244, "httpStatusCode": 200}	2f70c86c-db14-4b24-83d3-43aed6094aa6	\N	{}	3
945bc56c-5eca-441e-888e-3129eec80754	recordings	e18ee1e2-4763-4967-b241-68338768fc24/ec6d48fd-af18-46d1-a4f4-ce9ab0149048/user-session-ec6d48fd-af18-46d1-a4f4-ce9ab0149048.wav	\N	2025-11-20 18:03:57.145982+00	2025-11-20 18:03:57.145982+00	2025-11-20 18:03:57.145982+00	{"eTag": "\\"327674a6a4bf0273883fffcf1414521e\\"", "size": 2067884, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T18:03:58.000Z", "contentLength": 2067884, "httpStatusCode": 200}	35f70067-9137-4e06-9dad-ce8b13c0a926	\N	{}	3
5f32e769-7f76-4460-b5e7-64fd4dc1f2de	recordings	e18ee1e2-4763-4967-b241-68338768fc24/8e6216ef-d5ed-4481-b6a6-b29381026d03/user-session-8e6216ef-d5ed-4481-b6a6-b29381026d03.wav	\N	2025-11-29 06:28:28.306042+00	2025-11-29 06:28:28.306042+00	2025-11-29 06:28:28.306042+00	{"eTag": "\\"f072022f6d24c9152246ca3841463a5e\\"", "size": 4849964, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-29T06:28:29.000Z", "contentLength": 4849964, "httpStatusCode": 200}	08423bb3-7452-40bb-b3ff-377e2d18d351	\N	{}	3
3350e717-dbe4-4303-be6f-3633df9cf87d	recordings	e18ee1e2-4763-4967-b241-68338768fc24/ec6d48fd-af18-46d1-a4f4-ce9ab0149048/session-ec6d48fd-af18-46d1-a4f4-ce9ab0149048.mp3	\N	2025-11-20 18:04:06.393908+00	2025-11-20 18:04:06.393908+00	2025-11-20 18:04:06.393908+00	{"eTag": "\\"d776688bd6ff3a23a9236b69e5c6bbb8\\"", "size": 240640, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T18:04:07.000Z", "contentLength": 240640, "httpStatusCode": 200}	7f6db161-43c2-423c-b6f2-dc40ca75a9d1	\N	{}	3
dd75900b-ed2a-4caf-9d06-2b0c70b928e2	recordings	e18ee1e2-4763-4967-b241-68338768fc24/afc77018-2481-4756-8c27-5aee2c328944/user-session-afc77018-2481-4756-8c27-5aee2c328944.wav	\N	2025-11-20 19:08:47.483586+00	2025-11-20 19:08:47.483586+00	2025-11-20 19:08:47.483586+00	{"eTag": "\\"54b4c895b52d59af72e41ac0e6e20f38\\"", "size": 1635884, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T19:08:48.000Z", "contentLength": 1635884, "httpStatusCode": 200}	4863e39d-2d12-4751-90f1-0b4a09beb4dc	\N	{}	3
00e95822-7647-4250-8f43-e85a1362033e	recordings	e18ee1e2-4763-4967-b241-68338768fc24/1289fe99-32f0-4e27-8c76-736c161a292d/user-session-1289fe99-32f0-4e27-8c76-736c161a292d.wav	\N	2025-11-29 06:29:58.263132+00	2025-11-29 06:29:58.263132+00	2025-11-29 06:29:58.263132+00	{"eTag": "\\"cb7777b1cd7a79cded81d3535aee1f77\\"", "size": 3110444, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-29T06:29:59.000Z", "contentLength": 3110444, "httpStatusCode": 200}	a9a99945-64c8-4039-8f31-4ac38ea65244	\N	{}	3
15c84a70-0784-4552-b503-3d2877e73b3d	recordings	e18ee1e2-4763-4967-b241-68338768fc24/57205bb3-0069-4bf1-acb7-bb0ba079c948/user-session-57205bb3-0069-4bf1-acb7-bb0ba079c948.wav	\N	2025-11-20 19:11:36.251333+00	2025-11-20 19:11:36.251333+00	2025-11-20 19:11:36.251333+00	{"eTag": "\\"5f42643d06ae69e6900ed281ad8836f9\\"", "size": 817964, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T19:11:37.000Z", "contentLength": 817964, "httpStatusCode": 200}	c15aa654-1e85-45b2-966c-22a9fc5cf315	\N	{}	3
ff9bf48f-0c74-49dd-9063-b4787b26b58b	recordings	e18ee1e2-4763-4967-b241-68338768fc24/c277e6e7-5623-4753-82c5-1c055d1ecf08/user-session-c277e6e7-5623-4753-82c5-1c055d1ecf08.wav	\N	2025-11-20 19:28:36.921899+00	2025-11-20 19:28:36.921899+00	2025-11-20 19:28:36.921899+00	{"eTag": "\\"5e6828b9926171622e4404674dda4c3f\\"", "size": 3571244, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T19:28:37.000Z", "contentLength": 3571244, "httpStatusCode": 200}	878bf0c3-c12e-4152-ac5e-9de5548f6e09	\N	{}	3
ff5aba3d-2da8-40c4-b588-3925312b05bc	recordings	e18ee1e2-4763-4967-b241-68338768fc24/764da67c-95cd-4f8c-945b-daa8d442972c/user-session-764da67c-95cd-4f8c-945b-daa8d442972c.wav	\N	2025-11-29 06:33:46.585258+00	2025-11-29 06:33:46.585258+00	2025-11-29 06:33:46.585258+00	{"eTag": "\\"6fcef2f9ee4e0fdbd55626f85645e633-2\\"", "size": 7159724, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-29T06:33:47.000Z", "contentLength": 7159724, "httpStatusCode": 200}	3a2a1444-f8b4-4c50-b2f2-fd210c83b78d	\N	{}	3
3b0cb576-4607-4143-ab07-765f281363f4	recordings	e18ee1e2-4763-4967-b241-68338768fc24/546fbf30-af46-4cbb-893c-ed539c3c189b/user-session-546fbf30-af46-4cbb-893c-ed539c3c189b.wav	\N	2025-11-20 19:39:20.449185+00	2025-11-20 19:39:20.449185+00	2025-11-20 19:39:20.449185+00	{"eTag": "\\"a844e864d382b27664579ca5bfbdcabf\\"", "size": 1278764, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T19:39:21.000Z", "contentLength": 1278764, "httpStatusCode": 200}	75e4958b-d8aa-441c-ac87-53962372c28b	\N	{}	3
58bbae7f-3f78-43c7-9a89-0cf3c88d61be	recordings	e18ee1e2-4763-4967-b241-68338768fc24/cc69a81c-5f17-4f3e-b8e8-47c09cf3f684/user-session-cc69a81c-5f17-4f3e-b8e8-47c09cf3f684.wav	\N	2025-11-21 08:13:45.146287+00	2025-11-21 08:13:45.146287+00	2025-11-21 08:13:45.146287+00	{"eTag": "\\"8e51643643b6b8ee5b4e85c6e3500546\\"", "size": 1923884, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-21T08:13:46.000Z", "contentLength": 1923884, "httpStatusCode": 200}	b2f4906e-6770-48ac-b153-f03bf3085655	\N	{}	3
00723eb6-2db7-4c22-8545-9f9243fb46c5	recordings	e18ee1e2-4763-4967-b241-68338768fc24/e3f79ca1-4117-493b-83af-e0fd90e6213e/user-session-e3f79ca1-4117-493b-83af-e0fd90e6213e.wav	\N	2025-11-22 12:44:27.242649+00	2025-11-22 12:44:27.242649+00	2025-11-22 12:44:27.242649+00	{"eTag": "\\"30d8359ddf9bc17ab5d5ec48a66847bf\\"", "size": 1941164, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-22T12:44:28.000Z", "contentLength": 1941164, "httpStatusCode": 200}	c77d2b8e-f2d1-409e-aba0-69a376c76eff	\N	{}	3
aa3b30a2-34d6-4159-b0b9-6103e1def340	recordings	e18ee1e2-4763-4967-b241-68338768fc24/a13845e4-609d-4520-a328-0750bbf6a73e/user-session-a13845e4-609d-4520-a328-0750bbf6a73e.wav	\N	2025-11-22 13:34:53.86639+00	2025-11-22 13:34:53.86639+00	2025-11-22 13:34:53.86639+00	{"eTag": "\\"f7bff89fc8f4f74ee86288e53be0fc61\\"", "size": 2355884, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-22T13:34:54.000Z", "contentLength": 2355884, "httpStatusCode": 200}	34918704-67cf-4d47-b5a6-81aac13d91dd	\N	{}	3
482069af-8778-4c72-8687-432d1fbe6098	recordings	e18ee1e2-4763-4967-b241-68338768fc24/2a867204-5aec-4d58-8fa7-d61f5de87ecd/user-session-2a867204-5aec-4d58-8fa7-d61f5de87ecd.wav	\N	2025-11-29 08:39:57.572205+00	2025-11-29 08:39:57.572205+00	2025-11-29 08:39:57.572205+00	{"eTag": "\\"6937ad59d6f0d8dfb02eb3d254393dc9\\"", "size": 668204, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-29T08:39:58.000Z", "contentLength": 668204, "httpStatusCode": 200}	ea301276-42e1-48f6-bd5f-4bce6afa199c	\N	{}	3
b4b4b432-011e-438c-9767-35494cae2499	recordings	e18ee1e2-4763-4967-b241-68338768fc24/21d69bf4-8cd6-46aa-848c-8d80d188ed5a/user-session-21d69bf4-8cd6-46aa-848c-8d80d188ed5a.wav	\N	2025-11-22 14:58:06.325479+00	2025-11-22 14:58:06.325479+00	2025-11-22 14:58:06.325479+00	{"eTag": "\\"a9c2e86a597418b86e8b581f5b346f36\\"", "size": 2632364, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-22T14:58:07.000Z", "contentLength": 2632364, "httpStatusCode": 200}	97616fa6-9c3b-4116-ac0b-00929f82a5ba	\N	{}	3
b764d880-fc7a-4559-b184-34261593c150	recordings	e18ee1e2-4763-4967-b241-68338768fc24/ad8d78d6-bd25-4b4a-84a9-74c7a1324d4b/user-session-ad8d78d6-bd25-4b4a-84a9-74c7a1324d4b.wav	\N	2025-11-22 15:18:08.205436+00	2025-11-22 15:18:08.205436+00	2025-11-22 15:18:08.205436+00	{"eTag": "\\"cb7f4bb434ec9def670ddb32742c8290\\"", "size": 1393964, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-22T15:18:09.000Z", "contentLength": 1393964, "httpStatusCode": 200}	20969cd0-306c-4e4f-8ad7-459b3299697e	\N	{}	3
34a90233-c2af-4955-af40-fe78dda3ee0d	recordings	e18ee1e2-4763-4967-b241-68338768fc24/e427e0b7-f9dc-4ac4-b44b-d741bde38c25/user-session-e427e0b7-f9dc-4ac4-b44b-d741bde38c25.wav	\N	2025-11-22 15:31:46.330194+00	2025-11-22 15:31:46.330194+00	2025-11-22 15:31:46.330194+00	{"eTag": "\\"ae92493f52d2205c6a29b4c3ef86d8a6\\"", "size": 1313324, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-22T15:31:47.000Z", "contentLength": 1313324, "httpStatusCode": 200}	aaadd02e-1829-4447-a0cb-794707635956	\N	{}	3
548d53d3-d6af-4d70-9843-c29ab59aa13b	recordings	e18ee1e2-4763-4967-b241-68338768fc24/80c7a71d-a220-47b9-b804-c2720fa03e6b/user-session-80c7a71d-a220-47b9-b804-c2720fa03e6b.wav	\N	2025-11-22 15:50:24.668293+00	2025-11-22 15:50:24.668293+00	2025-11-22 15:50:24.668293+00	{"eTag": "\\"f9af06c067b5f031783f6653eeacff1c\\"", "size": 1791404, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-22T15:50:25.000Z", "contentLength": 1791404, "httpStatusCode": 200}	6d23032f-cefb-4d78-9561-86b2e7e77801	\N	{}	3
859ed589-686d-475c-801f-476a8ad0c554	recordings	e18ee1e2-4763-4967-b241-68338768fc24/e6289f85-937b-463c-a13f-803e75c2b93c/user-session-e6289f85-937b-463c-a13f-803e75c2b93c.wav	\N	2025-11-22 16:01:29.348385+00	2025-11-22 16:01:29.348385+00	2025-11-22 16:01:29.348385+00	{"eTag": "\\"cdfd42b042495d2f571582a0c2eaf8e6\\"", "size": 2309804, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-22T16:01:30.000Z", "contentLength": 2309804, "httpStatusCode": 200}	112839c5-e045-4585-900d-119a5182d73b	\N	{}	3
9be58f28-d108-4342-99df-e2ce99ce94f6	recordings	e18ee1e2-4763-4967-b241-68338768fc24/699adfe1-4ba7-4a34-81de-51a508b61fec/user-session-699adfe1-4ba7-4a34-81de-51a508b61fec.wav	\N	2025-11-23 10:45:38.136845+00	2025-11-23 10:45:38.136845+00	2025-11-23 10:45:38.136845+00	{"eTag": "\\"639a488c7a7f659184d8bb0cb7f59a37\\"", "size": 2304044, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-23T10:45:39.000Z", "contentLength": 2304044, "httpStatusCode": 200}	1f7f1b63-801f-465d-a414-c1ad07bc3469	\N	{}	3
9fa2eefa-f502-4fdf-a71d-bceb63933f22	recordings	e18ee1e2-4763-4967-b241-68338768fc24/645618f9-214a-429f-84f6-766d6628c193/user-session-645618f9-214a-429f-84f6-766d6628c193.wav	\N	2025-11-23 10:46:03.940504+00	2025-11-23 10:46:03.940504+00	2025-11-23 10:46:03.940504+00	{"eTag": "\\"52a8501df51053970f35a4576fb434a4\\"", "size": 2338604, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-23T10:46:04.000Z", "contentLength": 2338604, "httpStatusCode": 200}	fa2cdd67-6946-4546-9249-932d5c17c232	\N	{}	3
d2ee6490-8d78-4132-81c6-a4fc8a7dc983	recordings	e18ee1e2-4763-4967-b241-68338768fc24/e538eeb8-6177-4394-92f9-3e4da35027ed/user-session-e538eeb8-6177-4394-92f9-3e4da35027ed.wav	\N	2025-11-29 10:28:02.917384+00	2025-11-29 10:28:02.917384+00	2025-11-29 10:28:02.917384+00	{"eTag": "\\"f35065e71d103959d4db7aaafd94e02f-3\\"", "size": 10604204, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-29T10:28:02.000Z", "contentLength": 10604204, "httpStatusCode": 200}	7b1ce071-2098-422e-9198-4708a6f1202f	\N	{}	3
263051e2-e8b5-43e9-92d8-d101da2a8e08	recordings	e18ee1e2-4763-4967-b241-68338768fc24/cbdcb2d1-be56-415f-a814-ed980d1d83d3/user-session-cbdcb2d1-be56-415f-a814-ed980d1d83d3.wav	\N	2025-11-23 10:50:48.321573+00	2025-11-23 10:50:48.321573+00	2025-11-23 10:50:48.321573+00	{"eTag": "\\"8259cd569edb7f7ad1d4dea5638fb447\\"", "size": 2085164, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-23T10:50:49.000Z", "contentLength": 2085164, "httpStatusCode": 200}	4d89e586-a1f4-438f-a48c-cc7776c950c4	\N	{}	3
5d8d8de2-3704-428d-99d2-6e092528dd67	recordings	e18ee1e2-4763-4967-b241-68338768fc24/e9f25cca-98c7-41af-ac55-034a6bf50e7f/user-session-e9f25cca-98c7-41af-ac55-034a6bf50e7f.wav	\N	2025-11-23 10:52:33.535804+00	2025-11-23 10:52:33.535804+00	2025-11-23 10:52:33.535804+00	{"eTag": "\\"44ff6d91222a98daf5cb85f16b9c98f0-2\\"", "size": 9446444, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-23T10:52:33.000Z", "contentLength": 9446444, "httpStatusCode": 200}	b5b11905-5382-492f-80c1-c4d921ebcde0	\N	{}	3
1831ab25-7cd4-44cb-8288-64f7afc213b5	recordings	e18ee1e2-4763-4967-b241-68338768fc24/8dc77c96-ff24-49f1-83a1-9eb87d1c6b0e/user-session-8dc77c96-ff24-49f1-83a1-9eb87d1c6b0e.wav	\N	2025-11-23 12:14:48.510463+00	2025-11-23 12:14:48.510463+00	2025-11-23 12:14:48.510463+00	{"eTag": "\\"ef7601be3a01baac5619f23053561a29\\"", "size": 3450284, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-23T12:14:49.000Z", "contentLength": 3450284, "httpStatusCode": 200}	c4ce6803-59d3-4283-8c57-e41fc6c6c28a	\N	{}	3
d955de70-9e54-45ba-9b6b-8388e07fb26b	recordings	e18ee1e2-4763-4967-b241-68338768fc24/52122ac4-7cd7-4437-bf5d-3d0cf486693c/user-session-52122ac4-7cd7-4437-bf5d-3d0cf486693c.wav	\N	2025-11-25 09:08:51.278657+00	2025-11-25 09:08:51.278657+00	2025-11-25 09:08:51.278657+00	{"eTag": "\\"f88fbbed26bd1f170a28daf45e4cf3e3\\"", "size": 4654124, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-25T09:08:52.000Z", "contentLength": 4654124, "httpStatusCode": 200}	89a43c6e-ac6b-4054-8480-4c6a086f7ba9	\N	{}	3
5bcb2708-d748-456c-8947-86a42ed7ee1a	recordings	e18ee1e2-4763-4967-b241-68338768fc24/c19d4bca-3e47-40e6-9697-4094a63ff0fc/user-session-c19d4bca-3e47-40e6-9697-4094a63ff0fc.wav	\N	2025-11-25 09:10:56.735609+00	2025-11-25 09:10:56.735609+00	2025-11-25 09:10:56.735609+00	{"eTag": "\\"209fdc152a0a3d923491fa818b533da4\\"", "size": 4187564, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-25T09:10:57.000Z", "contentLength": 4187564, "httpStatusCode": 200}	18c1b220-c9fb-4f08-af3b-34a44355bfe5	\N	{}	3
b5d0c4c3-d41f-4b68-a71a-5b98fccc27fe	recordings	e18ee1e2-4763-4967-b241-68338768fc24/92b6a497-084e-42f4-8cfc-6fb017defbff/user-session-92b6a497-084e-42f4-8cfc-6fb017defbff.wav	\N	2025-11-25 09:14:27.759921+00	2025-11-25 09:14:27.759921+00	2025-11-25 09:14:27.759921+00	{"eTag": "\\"dcf5d5d8fae68c51ca3067783c360be0\\"", "size": 3525164, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-25T09:14:28.000Z", "contentLength": 3525164, "httpStatusCode": 200}	7029c617-1344-448d-b531-8612214ca3af	\N	{}	3
39b9a31a-70f2-4b42-a65f-73e2888f8af7	recordings	e18ee1e2-4763-4967-b241-68338768fc24/555e6afb-756a-4e69-b829-5d536fd94c63/user-session-555e6afb-756a-4e69-b829-5d536fd94c63.wav	\N	2025-11-27 18:59:56.495743+00	2025-11-27 18:59:56.495743+00	2025-11-27 18:59:56.495743+00	{"eTag": "\\"26a4a2aa686d102d0a14a66e2b1094f2\\"", "size": 4665644, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-27T18:59:57.000Z", "contentLength": 4665644, "httpStatusCode": 200}	e09e884f-d932-43a7-8dc5-7cf2e06c2c42	\N	{}	3
\.


--
-- Data for Name: prefixes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.prefixes (bucket_id, name, created_at, updated_at) FROM stdin;
recordings	e18ee1e2-4763-4967-b241-68338768fc24	2025-11-19 06:20:58.237307+00	2025-11-19 06:20:58.237307+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/1da67cdf-0594-4cf2-9264-277f9e0775be	2025-11-19 06:20:58.237307+00	2025-11-19 06:20:58.237307+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24	2025-11-19 06:22:27.848499+00	2025-11-19 06:22:27.848499+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/69ca43e5-d0b1-40d8-891a-18dfab093588	2025-11-19 06:37:43.758341+00	2025-11-19 06:37:43.758341+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/e609a755-0ca1-400c-9a91-0e1919e43644	2025-11-19 07:09:06.04887+00	2025-11-19 07:09:06.04887+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/85b4ffbc-2b3f-4310-9464-95703b4505b3	2025-11-20 14:54:21.483243+00	2025-11-20 14:54:21.483243+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/105d9ed9-c189-49b2-b224-0c2b579aede7	2025-11-20 15:48:09.366616+00	2025-11-20 15:48:09.366616+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/8e81176b-00d3-4fb6-83e7-b92de76f78a0	2025-11-20 15:53:23.882111+00	2025-11-20 15:53:23.882111+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/f4bf2215-d62c-4057-ae9a-b19c89552bbc	2025-11-20 16:06:30.554027+00	2025-11-20 16:06:30.554027+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/5fdd4029-f514-4b22-b71d-044ff256102b	2025-11-20 17:46:03.003295+00	2025-11-20 17:46:03.003295+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/6cfccfac-4ef1-457e-a62f-6d1f35564de8	2025-11-20 17:46:26.312565+00	2025-11-20 17:46:26.312565+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/63c2b218-6480-4ed1-b09c-01b93ec73508	2025-11-20 17:58:55.622559+00	2025-11-20 17:58:55.622559+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/9fb7b3ed-988b-4750-82af-308daf931f97	2025-11-20 18:00:40.352575+00	2025-11-20 18:00:40.352575+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/ec6d48fd-af18-46d1-a4f4-ce9ab0149048	2025-11-20 18:03:57.145982+00	2025-11-20 18:03:57.145982+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/9b08d901-f647-46ce-93b7-5737aa46ce20	2025-11-20 18:10:56.992628+00	2025-11-20 18:10:56.992628+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/7cf5b7bc-e156-40f9-b218-a86a6b7705af	2025-11-20 18:14:20.481578+00	2025-11-20 18:14:20.481578+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/afc77018-2481-4756-8c27-5aee2c328944	2025-11-20 19:08:47.483586+00	2025-11-20 19:08:47.483586+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/57205bb3-0069-4bf1-acb7-bb0ba079c948	2025-11-20 19:11:36.251333+00	2025-11-20 19:11:36.251333+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/c277e6e7-5623-4753-82c5-1c055d1ecf08	2025-11-20 19:28:36.921899+00	2025-11-20 19:28:36.921899+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/546fbf30-af46-4cbb-893c-ed539c3c189b	2025-11-20 19:39:20.449185+00	2025-11-20 19:39:20.449185+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/cc69a81c-5f17-4f3e-b8e8-47c09cf3f684	2025-11-21 08:13:45.146287+00	2025-11-21 08:13:45.146287+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/e3f79ca1-4117-493b-83af-e0fd90e6213e	2025-11-22 12:44:27.242649+00	2025-11-22 12:44:27.242649+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/a13845e4-609d-4520-a328-0750bbf6a73e	2025-11-22 13:34:53.86639+00	2025-11-22 13:34:53.86639+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/21d69bf4-8cd6-46aa-848c-8d80d188ed5a	2025-11-22 14:58:06.325479+00	2025-11-22 14:58:06.325479+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/ad8d78d6-bd25-4b4a-84a9-74c7a1324d4b	2025-11-22 15:18:08.205436+00	2025-11-22 15:18:08.205436+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/e427e0b7-f9dc-4ac4-b44b-d741bde38c25	2025-11-22 15:31:46.330194+00	2025-11-22 15:31:46.330194+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/80c7a71d-a220-47b9-b804-c2720fa03e6b	2025-11-22 15:50:24.668293+00	2025-11-22 15:50:24.668293+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/e6289f85-937b-463c-a13f-803e75c2b93c	2025-11-22 16:01:29.348385+00	2025-11-22 16:01:29.348385+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/699adfe1-4ba7-4a34-81de-51a508b61fec	2025-11-23 10:45:38.136845+00	2025-11-23 10:45:38.136845+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/645618f9-214a-429f-84f6-766d6628c193	2025-11-23 10:46:03.940504+00	2025-11-23 10:46:03.940504+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/cbdcb2d1-be56-415f-a814-ed980d1d83d3	2025-11-23 10:50:48.321573+00	2025-11-23 10:50:48.321573+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/e9f25cca-98c7-41af-ac55-034a6bf50e7f	2025-11-23 10:52:33.535804+00	2025-11-23 10:52:33.535804+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/8dc77c96-ff24-49f1-83a1-9eb87d1c6b0e	2025-11-23 12:14:48.510463+00	2025-11-23 12:14:48.510463+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/52122ac4-7cd7-4437-bf5d-3d0cf486693c	2025-11-25 09:08:51.278657+00	2025-11-25 09:08:51.278657+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/c19d4bca-3e47-40e6-9697-4094a63ff0fc	2025-11-25 09:10:56.735609+00	2025-11-25 09:10:56.735609+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/92b6a497-084e-42f4-8cfc-6fb017defbff	2025-11-25 09:14:27.759921+00	2025-11-25 09:14:27.759921+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/555e6afb-756a-4e69-b829-5d536fd94c63	2025-11-27 18:59:56.495743+00	2025-11-27 18:59:56.495743+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/94b7c21d-c821-495d-a9c1-0f9e4f5d09d8	2025-11-27 19:01:20.976226+00	2025-11-27 19:01:20.976226+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/839cbcf1-aa1c-4d50-a5ed-ebda9883c6e7	2025-11-27 19:16:04.214909+00	2025-11-27 19:16:04.214909+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/f314b966-3be6-4623-9729-631016d9f1aa	2025-11-27 19:17:16.409119+00	2025-11-27 19:17:16.409119+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/a3a8785e-80ec-49fe-b332-7ad92e13c133	2025-11-28 10:00:56.387158+00	2025-11-28 10:00:56.387158+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/0ee549f6-a919-4e5b-bd72-061dbbc50032	2025-11-29 06:06:37.345014+00	2025-11-29 06:06:37.345014+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/8e6216ef-d5ed-4481-b6a6-b29381026d03	2025-11-29 06:28:28.306042+00	2025-11-29 06:28:28.306042+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/1289fe99-32f0-4e27-8c76-736c161a292d	2025-11-29 06:29:58.263132+00	2025-11-29 06:29:58.263132+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/764da67c-95cd-4f8c-945b-daa8d442972c	2025-11-29 06:33:46.585258+00	2025-11-29 06:33:46.585258+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/2a867204-5aec-4d58-8fa7-d61f5de87ecd	2025-11-29 08:39:57.572205+00	2025-11-29 08:39:57.572205+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/e538eeb8-6177-4394-92f9-3e4da35027ed	2025-11-29 10:28:02.917384+00	2025-11-29 10:28:02.917384+00
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.schema_migrations (version, statements, name, created_by, idempotency_key, rollback) FROM stdin;
20251118065345	{"-- Enable UUID extension\nCREATE EXTENSION IF NOT EXISTS \\"uuid-ossp\\";\n\n-- Create enum for message sender\nCREATE TYPE message_sender AS ENUM ('user', 'ai');\n\n-- 1. users table\nCREATE TABLE users (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  name TEXT NOT NULL,\n  email TEXT UNIQUE NOT NULL,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- 2. categories table (training modes)\nCREATE TABLE categories (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  name TEXT NOT NULL UNIQUE,\n  description TEXT,\n  base_context TEXT NOT NULL, -- AI instruction for this category\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- 3. sessions table\nCREATE TABLE sessions (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,\n  category_id UUID NOT NULL REFERENCES categories(id) ON DELETE RESTRICT,\n  started_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),\n  ended_at TIMESTAMP WITH TIME ZONE,\n  notes TEXT,\n  ai_summary TEXT,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- 4. messages table (conversation history)\nCREATE TABLE messages (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  session_id UUID NOT NULL REFERENCES sessions(id) ON DELETE CASCADE,\n  sender message_sender NOT NULL,\n  text TEXT NOT NULL,\n  audio_url TEXT, -- Supabase storage path\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- 5. recordings table\nCREATE TABLE recordings (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,\n  session_id UUID REFERENCES sessions(id) ON DELETE SET NULL,\n  audio_url TEXT NOT NULL,\n  duration INTEGER, -- duration in seconds\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- 6. progress_stats table\nCREATE TABLE progress_stats (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,\n  category_id UUID NOT NULL REFERENCES categories(id) ON DELETE RESTRICT,\n  session_id UUID REFERENCES sessions(id) ON DELETE SET NULL,\n  tone_score FLOAT CHECK (tone_score >= 0 AND tone_score <= 100),\n  clarity_score FLOAT CHECK (clarity_score >= 0 AND clarity_score <= 100),\n  pace_score FLOAT CHECK (pace_score >= 0 AND pace_score <= 100),\n  confidence_score FLOAT CHECK (confidence_score >= 0 AND confidence_score <= 100),\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- 7. goals table\nCREATE TABLE goals (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,\n  title TEXT NOT NULL,\n  progress INTEGER DEFAULT 0 CHECK (progress >= 0),\n  total INTEGER NOT NULL CHECK (total > 0),\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- 8. community_posts table (optional future feature)\nCREATE TABLE community_posts (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,\n  text TEXT NOT NULL,\n  audio_url TEXT,\n  likes INTEGER DEFAULT 0 CHECK (likes >= 0),\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- Create indexes for better query performance\nCREATE INDEX idx_sessions_user_id ON sessions(user_id);\nCREATE INDEX idx_sessions_category_id ON sessions(category_id);\nCREATE INDEX idx_sessions_started_at ON sessions(started_at DESC);\nCREATE INDEX idx_messages_session_id ON messages(session_id);\nCREATE INDEX idx_messages_created_at ON messages(created_at DESC);\nCREATE INDEX idx_recordings_user_id ON recordings(user_id);\nCREATE INDEX idx_recordings_session_id ON recordings(session_id);\nCREATE INDEX idx_progress_stats_user_id ON progress_stats(user_id);\nCREATE INDEX idx_progress_stats_category_id ON progress_stats(category_id);\nCREATE INDEX idx_goals_user_id ON goals(user_id);\nCREATE INDEX idx_community_posts_user_id ON community_posts(user_id);\nCREATE INDEX idx_community_posts_created_at ON community_posts(created_at DESC);"}	create_voice_coach_schema	chetanm122004@gmail.com	\N	\N
20251118065553	{"-- Enable RLS on all tables\nALTER TABLE users ENABLE ROW LEVEL SECURITY;\nALTER TABLE categories ENABLE ROW LEVEL SECURITY;\nALTER TABLE sessions ENABLE ROW LEVEL SECURITY;\nALTER TABLE messages ENABLE ROW LEVEL SECURITY;\nALTER TABLE recordings ENABLE ROW LEVEL SECURITY;\nALTER TABLE progress_stats ENABLE ROW LEVEL SECURITY;\nALTER TABLE goals ENABLE ROW LEVEL SECURITY;\nALTER TABLE community_posts ENABLE ROW LEVEL SECURITY;\n\n-- Users can only see and modify their own data\nCREATE POLICY \\"Users can view own profile\\" ON users\n  FOR SELECT USING (auth.uid() = id);\n\nCREATE POLICY \\"Users can update own profile\\" ON users\n  FOR UPDATE USING (auth.uid() = id);\n\n-- Categories are public (read-only for all)\nCREATE POLICY \\"Categories are viewable by everyone\\" ON categories\n  FOR SELECT USING (true);\n\n-- Sessions: users can only access their own sessions\nCREATE POLICY \\"Users can view own sessions\\" ON sessions\n  FOR SELECT USING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can create own sessions\\" ON sessions\n  FOR INSERT WITH CHECK (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can update own sessions\\" ON sessions\n  FOR UPDATE USING (auth.uid() = user_id);\n\n-- Messages: users can only access messages from their sessions\nCREATE POLICY \\"Users can view messages from own sessions\\" ON messages\n  FOR SELECT USING (\n    EXISTS (\n      SELECT 1 FROM sessions \n      WHERE sessions.id = messages.session_id \n      AND sessions.user_id = auth.uid()\n    )\n  );\n\nCREATE POLICY \\"Users can create messages in own sessions\\" ON messages\n  FOR INSERT WITH CHECK (\n    EXISTS (\n      SELECT 1 FROM sessions \n      WHERE sessions.id = messages.session_id \n      AND sessions.user_id = auth.uid()\n    )\n  );\n\n-- Recordings: users can only access their own recordings\nCREATE POLICY \\"Users can view own recordings\\" ON recordings\n  FOR SELECT USING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can create own recordings\\" ON recordings\n  FOR INSERT WITH CHECK (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can delete own recordings\\" ON recordings\n  FOR DELETE USING (auth.uid() = user_id);\n\n-- Progress stats: users can only access their own stats\nCREATE POLICY \\"Users can view own progress stats\\" ON progress_stats\n  FOR SELECT USING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can create own progress stats\\" ON progress_stats\n  FOR INSERT WITH CHECK (auth.uid() = user_id);\n\n-- Goals: users can only access their own goals\nCREATE POLICY \\"Users can view own goals\\" ON goals\n  FOR SELECT USING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can create own goals\\" ON goals\n  FOR INSERT WITH CHECK (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can update own goals\\" ON goals\n  FOR UPDATE USING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can delete own goals\\" ON goals\n  FOR DELETE USING (auth.uid() = user_id);\n\n-- Community posts: everyone can view, users can create/update/delete their own\nCREATE POLICY \\"Community posts are viewable by everyone\\" ON community_posts\n  FOR SELECT USING (true);\n\nCREATE POLICY \\"Users can create own community posts\\" ON community_posts\n  FOR INSERT WITH CHECK (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can update own community posts\\" ON community_posts\n  FOR UPDATE USING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can delete own community posts\\" ON community_posts\n  FOR DELETE USING (auth.uid() = user_id);"}	enable_rls_policies	chetanm122004@gmail.com	\N	\N
20251118065613	{"-- Seed initial categories with base context for AI instructions\nINSERT INTO categories (name, description, base_context) VALUES\n  (\n    'Public Speaking',\n    'Practice delivering confident, structured presentations',\n    'Coach user to sound confident, clear, and structured. Provide feedback on pacing, tone, and clarity. Help them organize their thoughts and speak with authority.'\n  ),\n  (\n    'Interview Practice',\n    'Prepare for job interviews with realistic practice',\n    'Ask interview questions appropriate for the role. Give feedback on tone, confidence, and clarity. Help user articulate their experience and skills professionally. Provide constructive feedback on answers.'\n  ),\n  (\n    'Daily Conversations',\n    'Practice natural, everyday interactions',\n    'Be a casual, friendly, and natural conversation coach. Engage in everyday topics. Help user practice natural flow, appropriate tone, and clear communication in casual settings.'\n  ),\n  (\n    'Voice Clarity',\n    'Improve pronunciation and speech clarity',\n    'Focus on pronunciation, enunciation, and clarity. Help user speak more clearly and be easily understood. Provide specific feedback on articulation and speech patterns.'\n  ),\n  (\n    'Confidence & Mindset',\n    'Build speaking confidence and positive mindset',\n    'Help build user''s confidence in speaking. Provide encouragement and positive reinforcement. Address anxiety and help develop a confident speaking mindset.'\n  ),\n  (\n    'Emotional Expression',\n    'Learn to convey emotions effectively through voice',\n    'Coach user on expressing emotions through tone, pace, and inflection. Help them convey feelings authentically and appropriately in different contexts.'\n  ),\n  (\n    'Group Communication',\n    'Practice speaking in group settings and meetings',\n    'Help user practice contributing to group discussions, managing turn-taking, and speaking effectively in meetings. Provide feedback on participation and communication style.'\n  )\nON CONFLICT (name) DO NOTHING;"}	seed_categories	chetanm122004@gmail.com	\N	\N
20251118074405	{"-- Update categories with detailed persona descriptions\nUPDATE categories SET base_context = \n'You are now the Public Speaking Coach persona.\n\nPersonality: Confident, encouraging, clear-headed like a stage mentor.\n\nFocus Areas: Tone variation, projection, pacing, energy, filler words, audience engagement\n\nFeedback Style: Supportive, specific, and slightly motivational. Helps user improve vocal presence and clarity.\n\nAvoid: Grammar correction, over-analysis, formal textbook tone\n\nExample Feedback:\n- \\"Nice delivery! Just try adding stronger pauses after each key point.\\"\n- \\"Your tone is solid — adding more vocal variety will keep the audience engaged.\\"\n\nPublic speaking demands clear, dynamic vocal delivery to engage audiences. Effective speakers use paralinguistic cues – tone, pitch, pace, and gestures – to reinforce their message. Moderate pitch variation combined with confident gestures made speeches most engaging. Good public speakers project from the diaphragm (for strong resonance) and vary their tone to avoid a monotone delivery. Common challenges include anxiety (which often causes a too-rapid or too-soft voice) and filler words.'\nWHERE name = 'Public Speaking';\n\nUPDATE categories SET base_context = \n'You are now the Interview Coach persona.\n\nPersonality: Friendly, calm, and professional. Thinks like a supportive HR mentor.\n\nFocus Areas: Steadiness, tone warmth, fluency, pacing, avoiding nervousness\n\nFeedback Style: Soft-spoken, guiding, practical. Helps reduce anxiety and increase verbal confidence.\n\nAvoid: Harsh criticism, correcting word content, robotic tone\n\nExample Feedback:\n- \\"You sound calm, which is great. Try slowing just a bit at the end to feel more grounded.\\"\n- \\"That was steady! Let''s work on cutting out filler words like ''um''.\\"\n\nIn job interviews, voice cues powerfully shape impressions. Hearing a candidate speak (versus just reading their words) makes interviewers judge them as smarter and more employable. Variation in tone and cadence is key: natural pitch shifts and a lively cadence convey enthusiasm and confidence, whereas a flat monotone sounds dull. Research shows that candidates who speak very slowly tend to be perceived as anxious. An effective interview voice is clear, steady, and appropriately warm – not rushed or quivering. Common challenges include interview nerves (leading to tremor or mumbling) and monotony.'\nWHERE name = 'Interview Practice';\n\nUPDATE categories SET base_context = \n'You are now the Conversation Buddy persona.\n\nPersonality: Casual, friendly, super chill. Like a helpful friend chatting over chai.\n\nFocus Areas: Natural tone, comfort level, pacing, emotional ease, relatability\n\nFeedback Style: Relaxed, fun, short and helpful.\n\nAvoid: Formal speech, sounding robotic, over-coaching\n\nExample Feedback:\n- \\"That was smooth! Maybe loosen your voice just a little more — like chatting with a close friend.\\"\n- \\"Really nice energy! Try a tiny pause between sentences to make it feel even more natural.\\"\n\nDaily conversations (small talk, peer chats) call for a natural, friendly voice. In casual talk, a comfortable pace and a warm tone keep dialogue flowing. Engaging everyday conversation also relies on nonverbal cues: listening actively (with nods or short verbal affirmations) and matching the other person''s energy. Common issues include mumbling, speaking too quietly, or appearing distracted.'\nWHERE name = 'Daily Conversations';\n\nUPDATE categories SET base_context = \n'You are now the Clarity & Pronunciation Trainer persona.\n\nPersonality: Clear, articulate, warm-toned. Focused on clean delivery without being judgmental.\n\nFocus Areas: Word clarity, consonant sharpness, articulation, pace, accent balance\n\nFeedback Style: Calm, precise, repeatable instructions. Easy drills and clarity-focused feedback.\n\nAvoid: Accent judging, grammar correction, fast explanations\n\nExample Feedback:\n- \\"Good start! Try hitting the ''t'' sounds more clearly to sharpen the sentence.\\"\n- \\"Nice rhythm! Now just open your mouth slightly more for better word edges.\\"\n\nVoice clarity means the listener easily understands every word. Key factors are precise articulation (especially consonants), suitable loudness, and moderate speed. Slurring words or speaking too fast/silent drops can hurt intelligibility. Pronunciation (the way sounds are made) directly affects clarity. Common challenges are mumbling, weak consonants (e.g. \\"t\\" and \\"d\\"), and strong accents.'\nWHERE name = 'Voice Clarity';\n\nUPDATE categories SET base_context = \n'You are now the Confidence & Mindset Coach persona.\n\nPersonality: Motivational, grounding, supportive like a life coach.\n\nFocus Areas: Vocal strength, steady pace, low tension, positive tone\n\nFeedback Style: Uplifting, short, focused on mindset and control\n\nAvoid: Harsh correction, over-analysis, performance pressure\n\nExample Feedback:\n- \\"Strong voice! You sound confident. Try speaking 10% slower for even more impact.\\"\n- \\"You''ve got a great presence — take one deep breath and let your voice settle in.\\"\n\nConfidence transforms the voice. A confident mindset helps speakers maintain eye contact, stand tall, and use a steady, moderate pace – all of which project assurance. In contrast, a nervous mindset often causes a shaky or overly rapid voice and too many \\"um\\"s. Psychology research shows that reframing anxiety as excitement (a positive mindset) can improve performance. Speakers boost confidence through preparation: knowing the material well, visualizing success, and doing relaxation (deep breathing or light exercise) before speaking.'\nWHERE name = 'Confidence & Mindset';\n\nUPDATE categories SET base_context = \n'You are now the Emotional Expression Coach persona.\n\nPersonality: Soft, empathetic, expressive. Encourages voice that feels alive.\n\nFocus Areas: Tone shifts, emotional control, pitch range, delivery warmth\n\nFeedback Style: Warm, inspiring, emotionally tuned. Helps user sound more human.\n\nAvoid: Robotic tone, harsh critiques, flat energy\n\nExample Feedback:\n- \\"Great effort! Try smiling while you say that — it''ll brighten your voice.\\"\n- \\"You sound calm — now add just a little excitement to show enthusiasm.\\"\n\nExpressing emotion through voice – prosody – is crucial for engaging speech. Tone, pitch, and volume naturally vary with emotion: a higher, brighter tone can signal excitement or happiness, while a slower, softer tone conveys sadness or calm. Some communication experts say paralanguage (voice cues) is effectively a \\"language of emotion\\" layered over words. Listeners intuitively perceive higher pitch variation and a relaxed pace as more caring, whereas a monotone or clipped speech may seem hostile. Common problems include sounding too flat (monotonous) or exaggerating emotions unnaturally.'\nWHERE name = 'Emotional Expression';\n\nUPDATE categories SET base_context = \n'You are now the Group Communication Coach persona.\n\nPersonality: Collaborative, diplomatic, open-minded. Helps user find a team voice.\n\nFocus Areas: Balanced tone, assertiveness, respectfulness, clear phrasing, turn-taking\n\nFeedback Style: Soft but structured, uses team language. Encourages inclusion and listening.\n\nAvoid: Domination tone, judgment of group style, over-polishing\n\nExample Feedback:\n- \\"Nice tone — you sound respectful and engaged. Maybe speak a bit louder so the group hears you better.\\"\n- \\"Great job including others. A touch more energy could help when leading your point.\\"\n\nIn groups or team meetings, communication is interactive. Effective group speakers speak clearly for the whole audience but also listen and encourage participation. Good group communication \\"builds trust and respect\\" and helps the group achieve shared goals. This means balancing clarity with inclusiveness: clearly articulating your ideas and inviting others'' input. Challenges include speaking over others, unclear instructions, or not acknowledging different viewpoints.'\nWHERE name = 'Group Communication';"}	update_category_personas	chetanm122004@gmail.com	\N	\N
20251118093150	{"-- Create app_config table for storing application configuration\nCREATE TABLE app_config (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  key TEXT UNIQUE NOT NULL,\n  value TEXT NOT NULL,\n  description TEXT,\n  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- Enable RLS\nALTER TABLE app_config ENABLE ROW LEVEL SECURITY;\n\n-- Allow public read access (config is not sensitive)\nCREATE POLICY \\"App config is viewable by everyone\\" ON app_config\n  FOR SELECT USING (true);\n\n-- Only admins can update (you can restrict this later)\nCREATE POLICY \\"App config can be updated by admins\\" ON app_config\n  FOR UPDATE USING (true);\n\nCREATE POLICY \\"App config can be inserted by admins\\" ON app_config\n  FOR INSERT WITH CHECK (true);"}	create_app_config_table	chetanm122004@gmail.com	\N	\N
20251118093153	{"-- Extend categories table with UI and routing metadata\nALTER TABLE categories ADD COLUMN IF NOT EXISTS route_path TEXT;\nALTER TABLE categories ADD COLUMN IF NOT EXISTS icon_name TEXT;\nALTER TABLE categories ADD COLUMN IF NOT EXISTS gradient TEXT;\nALTER TABLE categories ADD COLUMN IF NOT EXISTS display_order INTEGER DEFAULT 0;\nALTER TABLE categories ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT true;\n\n-- Create index for active categories\nCREATE INDEX IF NOT EXISTS idx_categories_is_active ON categories(is_active);\nCREATE INDEX IF NOT EXISTS idx_categories_display_order ON categories(display_order);"}	extend_categories_table	chetanm122004@gmail.com	\N	\N
20251118093207	{"-- Seed app_config with 11Labs configuration\nINSERT INTO app_config (key, value, description) VALUES\n  (\n    'elevenlabs_agent_id',\n    'agent_4201ka9e1ak5fd3r0wr5fy8w67kr',\n    '11Labs agent ID used for all voice conversations'\n  ),\n  (\n    'elevenlabs_api_key',\n    'sk_5742e5f85b43518a6dd417cd21a53d271167b95d6cf7a2f5',\n    '11Labs API key for authentication'\n  ),\n  (\n    'base_instructions',\n    'You are spkbtr.ai — a friendly, voice-first AI speaking coach.\n\nYour goal is to help users sound more confident, expressive, and clear — no matter what language they speak.\n\nYou are not here to fix grammar or test language knowledge. Your job is to guide the user in how they sound — based on tone, clarity, pace, pitch, and energy.\n\nThe user has selected a specific speaking mode. You must immediately switch to that persona''s coaching style.\n\nYour Behavior Rules (Always Apply):\n- Speak in short, human-like, helpful responses\n- Every reply must include voice + short text\n- Never correct grammar unless the user specifically asks\n- Avoid long explanations — stay focused on *how* the user sounds\n- Be warm, respectful, and empowering\n- Use everyday, easy-to-understand language\n\nIf the user sounds:\n- ✨ Confident → reinforce and celebrate it\n- 😬 Nervous → respond gently, slow the pace\n- 😐 Flat or monotone → suggest more energy with encouragement\n\nYou are here to make users feel safe and improve their speaking ability step by step. Your job is not to grade — it''s to guide.\n\n---\n\nACTIVE PERSONA (Switch to this immediately):',\n    'Base instructions template for 11Labs agent persona switching'\n  )\nON CONFLICT (key) DO UPDATE SET\n  value = EXCLUDED.value,\n  description = EXCLUDED.description,\n  updated_at = NOW();"}	seed_app_config	chetanm122004@gmail.com	\N	\N
20251118093215	{"-- Update categories with route paths, icons, gradients, and display order\nUPDATE categories SET\n  route_path = '/public-speaking',\n  icon_name = 'Mic',\n  gradient = 'from-purple-500 to-pink-500',\n  display_order = 1,\n  is_active = true\nWHERE name = 'Public Speaking';\n\nUPDATE categories SET\n  route_path = '/interview-practice',\n  icon_name = 'Briefcase',\n  gradient = 'from-blue-500 to-cyan-500',\n  display_order = 2,\n  is_active = true\nWHERE name = 'Interview Practice';\n\nUPDATE categories SET\n  route_path = '/group-communication',\n  icon_name = 'Users',\n  gradient = 'from-green-500 to-emerald-500',\n  display_order = 3,\n  is_active = true\nWHERE name = 'Group Communication';\n\nUPDATE categories SET\n  route_path = '/daily-conversations',\n  icon_name = 'MessageCircle',\n  gradient = 'from-yellow-500 to-orange-500',\n  display_order = 4,\n  is_active = true\nWHERE name = 'Daily Conversations';\n\nUPDATE categories SET\n  route_path = '/voice-clarity',\n  icon_name = 'Volume2',\n  gradient = 'from-red-500 to-rose-500',\n  display_order = 5,\n  is_active = true\nWHERE name = 'Voice Clarity';\n\nUPDATE categories SET\n  route_path = '/emotional-expression',\n  icon_name = 'Heart',\n  gradient = 'from-pink-500 to-purple-500',\n  display_order = 6,\n  is_active = true\nWHERE name = 'Emotional Expression';\n\nUPDATE categories SET\n  route_path = '/confidence-mindset',\n  icon_name = 'Brain',\n  gradient = 'from-indigo-500 to-violet-500',\n  display_order = 7,\n  is_active = true\nWHERE name = 'Confidence & Mindset';"}	update_categories_metadata	chetanm122004@gmail.com	\N	\N
20251118100120	{"-- Add password column to users table for simple authentication\nALTER TABLE users ADD COLUMN IF NOT EXISTS password TEXT;\n\n-- Update RLS policy to allow users to update their own password\n-- (The existing policies should already cover this, but we ensure password is included)"}	add_password_to_users	chetanm122004@gmail.com	\N	\N
20251118100333	{"-- Allow anyone to create a user account (for registration)\n-- Drop existing policy if it exists and create new one\nDROP POLICY IF EXISTS \\"Anyone can create a user account\\" ON users;\nCREATE POLICY \\"Anyone can create a user account\\" ON users\n  FOR INSERT WITH CHECK (true);"}	allow_user_registration	chetanm122004@gmail.com	\N	\N
20251118100547	{"-- Drop all existing policies on users table to start fresh\nDROP POLICY IF EXISTS \\"Users can view own profile\\" ON users;\nDROP POLICY IF EXISTS \\"Users can update own profile\\" ON users;\nDROP POLICY IF EXISTS \\"Anyone can create a user account\\" ON users;\n\n-- Allow anyone to SELECT users (needed for login email lookup)\nCREATE POLICY \\"Users table is readable for login\\" ON users\n  FOR SELECT USING (true);\n\n-- Allow anyone to INSERT (for registration)\nCREATE POLICY \\"Anyone can register\\" ON users\n  FOR INSERT WITH CHECK (true);\n\n-- Allow users to UPDATE their own profile\nCREATE POLICY \\"Users can update own profile\\" ON users\n  FOR UPDATE USING (true);"}	fix_users_rls_policies	chetanm122004@gmail.com	\N	\N
20251120160511	{"ALTER TABLE sessions\nADD COLUMN IF NOT EXISTS tone_score INTEGER CHECK (tone_score >= 0 AND tone_score <= 100),\nADD COLUMN IF NOT EXISTS confidence_score INTEGER CHECK (confidence_score >= 0 AND confidence_score <= 100),\nADD COLUMN IF NOT EXISTS fluency_score INTEGER CHECK (fluency_score >= 0 AND fluency_score <= 100),\nADD COLUMN IF NOT EXISTS user_audio_url TEXT;\n\n-- Add comments for documentation\nCOMMENT ON COLUMN sessions.tone_score IS 'Tone score (0-100) calculated from audio analysis';\nCOMMENT ON COLUMN sessions.confidence_score IS 'Confidence score (0-100) calculated from audio analysis';\nCOMMENT ON COLUMN sessions.fluency_score IS 'Fluency score (0-100) calculated from audio analysis';\nCOMMENT ON COLUMN sessions.user_audio_url IS 'URL to user audio recording in Supabase Storage';"}	add_scores_to_sessions	chetanm122004@gmail.com	\N	\N
20251121080426	{"-- Add practice session fields to sessions table\n\nALTER TABLE sessions\nADD COLUMN IF NOT EXISTS transcript TEXT,\nADD COLUMN IF NOT EXISTS gpt_feedback TEXT,\nADD COLUMN IF NOT EXISTS agent_voice_feedback_url TEXT,\nADD COLUMN IF NOT EXISTS is_practice BOOLEAN DEFAULT false;\n\n-- Add comments for documentation\nCOMMENT ON COLUMN sessions.transcript IS 'Full transcript from 11Labs Scribe, stored as context for future reference';\nCOMMENT ON COLUMN sessions.gpt_feedback IS 'GPT-generated detailed feedback text';\nCOMMENT ON COLUMN sessions.agent_voice_feedback_url IS 'URL to 11Labs Agent voice feedback audio in Supabase Storage';\nCOMMENT ON COLUMN sessions.is_practice IS 'Flag to distinguish practice sessions from regular coaching sessions';\n\n-- Create index for practice sessions\nCREATE INDEX IF NOT EXISTS idx_sessions_is_practice ON sessions(is_practice) WHERE is_practice = true;\n"}	add_practice_session_fields	chetanm122004@gmail.com	\N	\N
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

\.


--
