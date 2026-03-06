import { Database } from "./database.types";

export type EventChallenge = Database["public"]["Tables"]["event_challenges"]["Row"]

export type EventChallengeInsert = Database["public"]["Tables"]["event_challenges"]["Insert"]