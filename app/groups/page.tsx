import { getUser } from "@/app/actions/authentication";
import { getEventChallenges } from "@/app/actions/event_challenges";
import { getSingleEvent } from "@/app/actions/events";
import { getUserGroups } from "../actions/groups";
import { Event } from "../types/event";
import { GroupWithEvent } from "../types/group";


export default async function Home() {
    const { data, error } = await getUserGroups()
    if (error) {
        return <div className="w-full flex items-center justify-center text-red-500">Đã có lỗi xảy ra: {error.message}</div>;
    }
    const groupWithEvents: Array<GroupWithEvent> = data?.map((ele) => {
        return {
            group: ele.groups,
            event: ele.groups?.events
        }
    })
    return (
        <div className="w-full min-h-screen screen-bg font-roboto-mono">
            <div className="max-w-4xl mx-auto px-6 flex flex-col p-5 ">
                <div className="text-2xl font-bold">Your registed groups</div>

            </div>
        </div>
    );
}