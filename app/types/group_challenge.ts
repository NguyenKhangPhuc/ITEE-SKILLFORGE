import { Database } from "./database.types";

export type GroupChallengeRelation = Database["public"]["Tables"]["group_challenge"]["Row"]

export type GroupChallengeRelationInsert = Database["public"]["Tables"]["group_challenge"]["Insert"]