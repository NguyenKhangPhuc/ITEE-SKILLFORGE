'use server'
import { SubmissionInsert } from "../types/submission";
import { createClient } from "../utils/supabase/server";

export async function getGoupChallengeSubmission({ groupId, groupChallengeId }: { groupId: string, groupChallengeId: string }) {
    const supabase = await createClient();

    const { data, error } = await supabase
        .from('submissions')
        .select('*')
        .eq('group_id', groupId)
        .eq('group_challenge_id', groupChallengeId)
        .maybeSingle()

    if (error) {
        throw new Error(error.message)
    }
    return data
}


export async function saveGroupChallengeSubmission({ submission }: { submission: SubmissionInsert }) {
    const supabase = await createClient()
    const { data, error } = await supabase.from('submissions').upsert(submission, {
        onConflict: 'group_id,group_challenge_id'
    })
    if (error) {
        throw new Error(`Error when save submission: ${error.message}`)
    }
    return data
}