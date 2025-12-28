/**
 * Timezone utility functions for Indian Standard Time (IST)
 * IST is UTC+5:30
 */

const IST_OFFSET_MS = 5.5 * 60 * 60 * 1000; // 5 hours 30 minutes in milliseconds

/**
 * Convert a UTC date to Indian Standard Time
 */
export const toIST = (date: Date | string): Date => {
  const utcDate = typeof date === 'string' ? new Date(date) : date;
  return new Date(utcDate.getTime() + IST_OFFSET_MS);
};

/**
 * Get current date in IST
 */
export const getISTDate = (): Date => {
  return toIST(new Date());
};

/**
 * Get start of week (Monday) in IST
 */
export const getWeekStartIST = (date?: Date): Date => {
  const istDate = date ? toIST(date) : getISTDate();
  const day = istDate.getUTCDay(); // 0 = Sunday, 1 = Monday, etc.
  const diff = day === 0 ? 6 : day - 1; // Days to subtract to get to Monday
  const monday = new Date(istDate);
  monday.setUTCDate(istDate.getUTCDate() - diff);
  monday.setUTCHours(0, 0, 0, 0);
  return monday;
};

/**
 * Get end of week (Sunday) in IST
 */
export const getWeekEndIST = (date?: Date): Date => {
  const weekStart = getWeekStartIST(date);
  const weekEnd = new Date(weekStart);
  weekEnd.setUTCDate(weekStart.getUTCDate() + 6);
  weekEnd.setUTCHours(23, 59, 59, 999);
  return weekEnd;
};

/**
 * Format date in IST
 */
export const formatDateIST = (date: Date | string, format: 'date' | 'datetime' | 'time' = 'date'): string => {
  const istDate = typeof date === 'string' ? toIST(new Date(date)) : toIST(date);
  
  if (format === 'date') {
    return istDate.toLocaleDateString('en-IN', {
      timeZone: 'Asia/Kolkata',
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });
  } else if (format === 'datetime') {
    return istDate.toLocaleString('en-IN', {
      timeZone: 'Asia/Kolkata',
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  } else {
    return istDate.toLocaleTimeString('en-IN', {
      timeZone: 'Asia/Kolkata',
      hour: '2-digit',
      minute: '2-digit'
    });
  }
};

/**
 * Get day of week name in IST
 */
export const getDayOfWeekIST = (date: Date | string): string => {
  const istDate = typeof date === 'string' ? toIST(new Date(date)) : toIST(date);
  return istDate.toLocaleDateString('en-IN', {
    timeZone: 'Asia/Kolkata',
    weekday: 'short'
  });
};

/**
 * Get day of week index (0 = Sunday, 1 = Monday, etc.) in IST
 */
export const getDayOfWeekIndexIST = (date: Date | string): number => {
  const istDate = typeof date === 'string' ? toIST(new Date(date)) : toIST(date);
  return istDate.getUTCDay();
};

/**
 * Check if two dates are on the same day in IST
 */
export const isSameDayIST = (date1: Date | string, date2: Date | string): boolean => {
  const ist1 = typeof date1 === 'string' ? toIST(new Date(date1)) : toIST(date1);
  const ist2 = typeof date2 === 'string' ? toIST(new Date(date2)) : toIST(date2);
  
  return ist1.getUTCFullYear() === ist2.getUTCFullYear() &&
         ist1.getUTCMonth() === ist2.getUTCMonth() &&
         ist1.getUTCDate() === ist2.getUTCDate();
};

/**
 * Get date only (without time) in IST
 */
export const getDateOnlyIST = (date: Date | string): Date => {
  const istDate = typeof date === 'string' ? toIST(new Date(date)) : toIST(date);
  const dateOnly = new Date(istDate);
  dateOnly.setUTCHours(0, 0, 0, 0);
  return dateOnly;
};

/**
 * Get days difference between two dates in IST
 */
export const getDaysDifferenceIST = (date1: Date | string, date2: Date | string): number => {
  const ist1 = getDateOnlyIST(date1);
  const ist2 = getDateOnlyIST(date2);
  const diffMs = ist2.getTime() - ist1.getTime();
  return Math.floor(diffMs / (1000 * 60 * 60 * 24));
};

/**
 * Get start of day in IST
 */
export const getStartOfDayIST = (date: Date | string): Date => {
  const istDate = typeof date === 'string' ? toIST(new Date(date)) : toIST(date);
  const start = new Date(istDate);
  start.setUTCHours(0, 0, 0, 0);
  return start;
};

/**
 * Get end of day in IST
 */
export const getEndOfDayIST = (date: Date | string): Date => {
  const istDate = typeof date === 'string' ? toIST(new Date(date)) : toIST(date);
  const end = new Date(istDate);
  end.setUTCHours(23, 59, 59, 999);
  return end;
};

