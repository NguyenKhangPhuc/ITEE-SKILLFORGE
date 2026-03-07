'use server'

import { revalidatePath } from 'next/cache'
import { redirect } from 'next/navigation'
import { createClient } from '../utils/supabase/server'
import { Event, EventInsert } from '../types/event'
import { title } from 'process'
import { EVENT_STATUS } from '../types/enum'
import { PostgrestError } from '@supabase/supabase-js'



export async function createEvent(event: EventInsert, challenges: Array<EventInsert>) {
    const supabase = await createClient();

    const { data: user } = await supabase.auth.getUser()

    const { data, error }: { data: Event | null, error: PostgrestError | null } = await supabase.from("events").insert([
        {
            title: event.title,
            poster_path: event.poster_path,
            short_description: event.short_description,
            content: event.content,
            location: event.location,
            max_group_members: event.max_group_members,
            start_date: event.start_date,
            end_date: event.end_date,
            organized_date: event.organized_date,
            status: EVENT_STATUS.ONGOING,
            owner_id: user.user?.id
        },
    ]).select().single()

    if (error) {
        throw new Error(error.message)
    }

    const updatedChallenges = challenges.map(challenge => ({
        ...challenge,
        event_id: data?.id
    }));

    const { error: challengeError } = await supabase.from("event_challenges").insert(updatedChallenges)

    if (challengeError) {
        throw new Error(challengeError.message)
    }

    revalidatePath('/events');
    return data
}

export async function getAllEvents() {
    const supabase = await createClient();

    const { data, error } = await supabase.from("events").select("*");

    return { data, error }
}

export async function getSingleEvent(id: string) {
    const supabase = await createClient();

    const { data, error } = await supabase.from("events").select("*").eq("id", id).single();

    return { data, error }
}