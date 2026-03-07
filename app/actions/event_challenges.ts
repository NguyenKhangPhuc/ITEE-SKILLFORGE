'use server'

import { revalidatePath } from 'next/cache'
import { redirect } from 'next/navigation'
import { createClient } from '../utils/supabase/server'



export async function getEventChallenges(id: string) {
    const supabase = await createClient();

    const { data, error } = await supabase.from("event_challenges").select("*").eq("event_id", id);

    return { data, error }
}