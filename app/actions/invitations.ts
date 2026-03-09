'use server'
import { InvitationInsert } from "../types/invitation";
import { SubmissionInsert } from "../types/submission";
import { createClient } from "../utils/supabase/server";

export async function sendInvitations(invitation: InvitationInsert) {
    const supabase = await createClient();
    console.log(invitation)
    const { data: foundMember, error: foundMemberError } = await supabase.from('group_members')
        .select('*, profiles!inner(*)')
        .eq('group_id', invitation.group_id!).eq('profiles.email', invitation.member_email ?? "").maybeSingle()

    if (foundMemberError) {
        throw new Error(foundMemberError.message)
    }
    console.log(foundMember)
    if (foundMember) {
        throw new Error('Member is already in a team')
    }

    const { data, error } = await supabase.from('invitation').upsert(invitation, { onConflict: 'group_id,member_email' })

    if (error) {
        throw new Error(error.message)
    }
    return data
}
