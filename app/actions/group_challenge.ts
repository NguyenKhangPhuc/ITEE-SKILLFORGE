'use server'
import { createClient } from "../utils/supabase/server";

export async function getGroupChallenges({ groupId, eventId }: { groupId: string, eventId: string }) {
    const supabase = await createClient();

    const { data, error } = await supabase
        .from('group_challenge')
        .select('*, groups (*), event_challenges (*)')
        .eq('group_id', groupId)
        .eq('event_id', eventId)

    return { data, error }
}