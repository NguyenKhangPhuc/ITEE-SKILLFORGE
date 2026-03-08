'use server'
import { SubmissionInsert } from "../types/submission";
import { createClient } from "../utils/supabase/server";

export async function getUserGroups() {
    const supabase = await createClient();

    const { data: user, error: userError } = await supabase.auth.getUser()

    if (!user || userError) {
        return { data: null, error: { message: 'Fail to verify user' } }
    }

    const { data, error } = await supabase.from('group_members').select('*, groups (*, events (*))').eq('member_id', user.user.id);

    return { data, error }
}
