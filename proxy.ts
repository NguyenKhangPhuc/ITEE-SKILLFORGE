import { type NextRequest } from "next/server"
import { updateSession } from "./app/utils/supabase/proxy"


export async function proxy(request: NextRequest) {
    console.log("URL:", process.env.NEXT_PUBLIC_SUPABASE_URL)
    console.log("KEY:", process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY)
    return await updateSession(request)
}

export const config = {
    matcher: [
        /*
         * Match all request paths except for the ones starting with:
         * - _next/static (static files)
         * - _next/image (image optimization files)
         * - favicon.ico (favicon file)
         * Feel free to modify this pattern to include more paths.
         */
        "/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)",
    ],
}