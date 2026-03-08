import { Database } from "./database.types";
import { Event } from "./event";

export type Group = Database["public"]["Tables"]["groups"]["Row"]

export type GroupInsert = Database["public"]["Tables"]["groups"]["Insert"]

export interface GroupWithEvent {
    group: Group,
    event: Event
}