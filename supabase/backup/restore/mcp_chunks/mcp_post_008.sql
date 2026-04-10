--
-- Name: app_config App config can be inserted by admins; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "App config can be inserted by admins" ON public.app_config FOR INSERT WITH CHECK (true);

--
-- Name: app_config App config can be updated by admins; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "App config can be updated by admins" ON public.app_config FOR UPDATE USING (true);

--
-- Name: app_config App config is viewable by everyone; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "App config is viewable by everyone" ON public.app_config FOR SELECT USING (true);

--
-- Name: categories Categories are viewable by everyone; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Categories are viewable by everyone" ON public.categories FOR SELECT USING (true);

--
-- Name: community_posts Community posts are viewable by everyone; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Community posts are viewable by everyone" ON public.community_posts FOR SELECT USING (true);

--
-- Name: messages Users can create messages in own sessions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create messages in own sessions" ON public.messages FOR INSERT WITH CHECK (true);

--
-- Name: community_posts Users can create own community posts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create own community posts" ON public.community_posts FOR INSERT WITH CHECK ((auth.uid() = user_id));

--
-- Name: goals Users can create own goals; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create own goals" ON public.goals FOR INSERT WITH CHECK ((auth.uid() = user_id));

--
-- Name: progress_stats Users can create own progress stats; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create own progress stats" ON public.progress_stats FOR INSERT WITH CHECK ((auth.uid() = user_id));

--
-- Name: recordings Users can create own recordings; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create own recordings" ON public.recordings FOR INSERT WITH CHECK (true);

--
-- Name: sessions Users can create own sessions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create own sessions" ON public.sessions FOR INSERT WITH CHECK (true);

--
-- Name: community_posts Users can delete own community posts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete own community posts" ON public.community_posts FOR DELETE USING ((auth.uid() = user_id));

--
-- Name: goals Users can delete own goals; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete own goals" ON public.goals FOR DELETE USING ((auth.uid() = user_id));

--
-- Name: recordings Users can delete own recordings; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete own recordings" ON public.recordings FOR DELETE USING (true);

--
-- Name: community_posts Users can update own community posts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own community posts" ON public.community_posts FOR UPDATE USING ((auth.uid() = user_id));

--
-- Name: goals Users can update own goals; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own goals" ON public.goals FOR UPDATE USING ((auth.uid() = user_id));

--
-- Name: users Users can update own profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own profile" ON public.users FOR UPDATE USING (true);

--
-- Name: sessions Users can update own sessions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own sessions" ON public.sessions FOR UPDATE USING (true);

--
-- Name: messages Users can view messages from own sessions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view messages from own sessions" ON public.messages FOR SELECT USING (true);

--
-- Name: goals Users can view own goals; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view own goals" ON public.goals FOR SELECT USING ((auth.uid() = user_id));

--
-- Name: progress_stats Users can view own progress stats; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view own progress stats" ON public.progress_stats FOR SELECT USING ((auth.uid() = user_id));

--
-- Name: recordings Users can view own recordings; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view own recordings" ON public.recordings FOR SELECT USING (true);

--
-- Name: sessions Users can view own sessions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view own sessions" ON public.sessions FOR SELECT USING (true);

--
-- Name: users Users table is readable for login; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users table is readable for login" ON public.users FOR SELECT USING (true);

--
-- Name: app_config; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.app_config ENABLE ROW LEVEL SECURITY;

--
-- Name: categories; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;

--
-- Name: community_posts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.community_posts ENABLE ROW LEVEL SECURITY;

--
-- Name: goals; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.goals ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: messages messages_delete_custom_auth; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY messages_delete_custom_auth ON public.messages FOR DELETE USING (true);
