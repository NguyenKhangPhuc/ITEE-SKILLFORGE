import { EVENT_STATUS } from "./enum";

export interface EventAttributes {
    id?: string;
    title: string;
    posterPath?: string;
    shortDescription: string;
    status?: EVENT_STATUS;
    content?: string;
    location: string;
    maxGroupMembers: number;
    startDate: Date;
    endDate: Date;
    organizedDate: Date;
    createdAt?: Date;
    updatedAt?: Date
    ownerId: string;
}