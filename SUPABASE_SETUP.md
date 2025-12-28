# Supabase Setup Guide

This guide will help you set up the Supabase Storage bucket for audio recordings.

## 1. Create Storage Bucket

1. Go to your Supabase project dashboard
2. Navigate to **Storage** in the left sidebar
3. Click **New bucket**
4. Name it: `recordings`
5. Set it to **Public** (so audio files can be accessed via URLs)
6. Click **Create bucket**

## 2. Set Up Storage Policies

After creating the bucket, you need to set up policies to allow uploads and reads:

1. Go to **Storage** → **Policies** → `recordings` bucket
2. Create the following policies:

### Policy 1: Allow authenticated users to upload
- Policy name: `Allow authenticated uploads`
- Allowed operation: `INSERT`
- Policy definition:
```sql
bucket_id = 'recordings' AND auth.role() = 'authenticated'
```

### Policy 2: Allow public reads
- Policy name: `Allow public reads`
- Allowed operation: `SELECT`
- Policy definition:
```sql
bucket_id = 'recordings'
```

### Policy 3: Allow authenticated users to delete their own files
- Policy name: `Allow authenticated deletes`
- Allowed operation: `DELETE`
- Policy definition:
```sql
bucket_id = 'recordings' AND auth.role() = 'authenticated'
```

**Note:** Since we're using custom auth (not Supabase Auth), you may need to adjust these policies or use the service role key for uploads. For development, you can temporarily make the bucket public with full access.

## 3. Alternative: Simplified Policies for Custom Auth

If you're using custom auth (plain text passwords), you can use these simplified policies:

1. Go to **Storage** → **Policies** → `recordings` bucket
2. Create policies with `true` as the condition (allows all operations):

```sql
-- Allow all operations (for custom auth)
-- In production, you should add proper user_id checks
bucket_id = 'recordings'
```

Or disable RLS on the bucket temporarily for development:
1. Go to **Storage** → **Settings** → `recordings` bucket
2. Toggle off **RLS** (not recommended for production)

## 4. Verify Setup

After setting up the bucket, test by:
1. Starting a voice session in the app
2. Speaking to the AI
3. Checking the Supabase Storage dashboard to see if files are being uploaded
4. Checking the `recordings` and `messages` tables to see if URLs are being saved

## 5. Troubleshooting

If audio uploads fail:
- Check browser console for errors
- Verify the bucket name is exactly `recordings`
- Check that the bucket is public or policies allow your operations
- Verify your Supabase project URL and anon key are correct in `.env`

