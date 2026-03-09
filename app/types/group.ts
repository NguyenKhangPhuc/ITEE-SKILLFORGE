import { Database } from "./database.types";
import { Event, EventInsert } from "./event";

export type Group = Database["public"]["Tables"]["groups"]["Row"]

export type GroupInsert = Database["public"]["Tables"]["groups"]["Insert"]

export type GroupInfo = {
    created_at: string;
    event_id: string | null;
    group_name: string | null;
    id: string;
    group_members: {
        id: string;
        profiles: {
            id: string;
            email: string | null;
        } | null;
    }[];
    events: {
        title: string | null;
        max_group_members: number | null;
    } | null;
} | null