'use server'

import { revalidatePath } from 'next/cache'
import { redirect } from 'next/navigation'
import { createClient } from '../utils/supabase/server'
import { EventAttributes } from '../types/event'
import { title } from 'process'
import { EVENT_STATUS } from '../types/enum'

export async function createEvent(event: EventAttributes) {
    const supabase = await createClient();

    const { data: user } = await supabase.auth.getUser()

    const { data, error } = await supabase.from("events").insert([
        {
            title: event.title,
            poster_path: event.posterPath,
            short_description: event.shortDescription,
            content: event.content,
            location: event.location,
            max_group_members: event.maxGroupMembers,
            start_date: event.startDate,
            end_date: event.endDate,
            organized_date: event.organizedDate,
            status: EVENT_STATUS.ONGOING,
            owner_id: user.user?.id
        },
    ]).select().single()

    if (error) {
        throw new Error(error.message)
    }

    revalidatePath('/events');
    return data
}