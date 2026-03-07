import { getSingleEvent } from "@/app/actions/events";
import SingleEventClient from "./SingleEventClient";

interface PageProps {
    params: Promise<{ id: string }>;
}

export default async function Home({ params }: PageProps) {
    const { id } = await params;
    const { data: event, error } = await getSingleEvent(id)

    if (error) {
        return <div className="w-full flex items-center justify-center text-red-500">Đã có lỗi xảy ra: {error.message}</div>;
    }
    return (
        <div className="w-full min-h-screen screen-bg font-roboto-mono">
            <div className="max-w-4xl mx-auto px-6 flex flex-col p-5 ">
                <SingleEventClient event={event!} />
            </div>
        </div>
    );
}