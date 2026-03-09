import { type NextRequest } from "next/server"
import { updateSession } from "./app/utils/supabase/proxy"
import { registerRoute } from "./app/middleware/register_proxy"
import { submissionRoute } from "./app/middleware/submission_proxy"


export async function proxy(request: NextRequest) {
    const supabaseResponse = await updateSession(request)
    if (supabaseResponse.status !== 200) return supabaseResponse
    const registerRouteCheck = await registerRoute(request)
    if (registerRouteCheck.status !== 200) return registerRouteCheck
    const submissionRouteCheck = await submissionRoute(request)
    if (submissionRouteCheck.status !== 200) return submissionRouteCheck
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