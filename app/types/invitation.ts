import { Database } from "./database.types"

export type Invitation = Database["public"]["Tables"]["invitation"]["Row"]

export type InvitationInsert = Database["public"]["Tables"]["invitation"]["Insert"]