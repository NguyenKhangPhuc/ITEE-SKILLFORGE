'use client'
import Link from "next/link"

const Home = () => {
    return (
        <div className="w-full min-h-screen screen-bg">
            <div className="max-w-4xl mx-auto px-6 flex flex-col p-5 ">
                <Link href={'/events/create'} className="cursor-pointer  w-40 create_button">
                    + Create
                </Link>

            </div>
        </div>
    )
}

export default Home