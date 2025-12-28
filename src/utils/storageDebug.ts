/**
 * Debug utilities for Supabase Storage
 * These functions can be called from the browser console for debugging
 */

import { supabase } from "@/integrations/supabase/client";

/**
 * Test if the recordings bucket exists and is accessible
 */
export const testBucketAccess = async (bucketName: string = "recordings") => {
  console.log(`🔍 Testing access to bucket: ${bucketName}`);
  
  try {
    const { data, error } = await supabase.storage.from(bucketName).list('', { limit: 1 });
    
    if (error) {
      console.error("❌ Bucket access failed:", error);
      if (error.message?.includes('not found') || error.message?.includes('does not exist')) {
        console.error(`💡 Bucket '${bucketName}' does not exist. Create it in Supabase Dashboard → Storage`);
      } else if (error.message?.includes('permission') || error.message?.includes('policy')) {
        console.error("💡 Permission denied. Check bucket RLS policies.");
      }
      return { success: false, error };
    }
    
    console.log("✅ Bucket is accessible");
    return { success: true, data };
  } catch (error) {
    console.error("❌ Exception testing bucket:", error);
    return { success: false, error };
  }
};

/**
 * List all files in the recordings bucket for a specific user
 */
export const listUserRecordings = async (userId: string, bucketName: string = "recordings") => {
  console.log(`📁 Listing recordings for user: ${userId}`);
  
  try {
    const { data, error } = await supabase.storage
      .from(bucketName)
      .list(userId, { limit: 100, sortBy: { column: 'created_at', order: 'desc' } });
    
    if (error) {
      console.error("❌ Error listing recordings:", error);
      return { success: false, error };
    }
    
    console.log(`✅ Found ${data?.length || 0} items:`, data);
    return { success: true, data };
  } catch (error) {
    console.error("❌ Exception listing recordings:", error);
    return { success: false, error };
  }
};

/**
 * List all files in a specific session folder
 */
export const listSessionFiles = async (
  userId: string,
  sessionId: string,
  bucketName: string = "recordings"
) => {
  const path = `${userId}/${sessionId}`;
  console.log(`📁 Listing files in: ${path}`);
  
  try {
    const { data, error } = await supabase.storage
      .from(bucketName)
      .list(path, { limit: 100 });
    
    if (error) {
      console.error("❌ Error listing session files:", error);
      return { success: false, error };
    }
    
    console.log(`✅ Found ${data?.length || 0} files:`, data);
    return { success: true, data };
  } catch (error) {
    console.error("❌ Exception listing session files:", error);
    return { success: false, error };
  }
};

/**
 * Test uploading a small test file
 */
export const testUpload = async (
  userId: string,
  sessionId: string,
  bucketName: string = "recordings"
) => {
  console.log("🧪 Testing upload...");
  
  // Create a small test audio blob
  const testBlob = new Blob(["test audio data"], { type: "audio/mpeg" });
  const fileName = `test-${Date.now()}.mp3`;
  const filePath = `${userId}/${sessionId}/${fileName}`;
  
  try {
    const { data, error } = await supabase.storage
      .from(bucketName)
      .upload(filePath, testBlob, {
        contentType: "audio/mpeg",
        upsert: true,
      });
    
    if (error) {
      console.error("❌ Upload test failed:", error);
      console.error("Error details:", JSON.stringify(error, null, 2));
      return { success: false, error };
    }
    
    console.log("✅ Upload test successful:", data);
    
    // Get public URL
    const { data: urlData } = supabase.storage
      .from(bucketName)
      .getPublicUrl(filePath);
    
    console.log("🔗 Public URL:", urlData.publicUrl);
    
    return { success: true, data, url: urlData.publicUrl };
  } catch (error) {
    console.error("❌ Exception in upload test:", error);
    return { success: false, error };
  }
};

/**
 * Get public URL for a file
 */
export const getFileUrl = (
  userId: string,
  sessionId: string,
  fileName: string,
  bucketName: string = "recordings"
) => {
  const filePath = `${userId}/${sessionId}/${fileName}`;
  const { data } = supabase.storage
    .from(bucketName)
    .getPublicUrl(filePath);
  
  console.log(`🔗 Public URL for ${filePath}:`, data.publicUrl);
  return data.publicUrl;
};

// Make functions available globally for console debugging
if (typeof window !== 'undefined') {
  (window as any).storageDebug = {
    testBucketAccess,
    listUserRecordings,
    listSessionFiles,
    testUpload,
    getFileUrl,
  };
  
  console.log("🔧 Storage debug utilities available at window.storageDebug");
  console.log("Try: window.storageDebug.testBucketAccess()");
}

