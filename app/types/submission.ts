import { Database } from "./database.types";

export type Submission = Database["public"]["Tables"]["submissions"]["Row"]

export type SubmissionInsert = Database["public"]["Tables"]["submissions"]["Insert"]