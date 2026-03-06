'use client'
import { useParams } from "next/navigation"

const Home = () => {
    const { id }: { id: string } = useParams()
    return (
        <div>page {id}</div>
    )
}

export default Home