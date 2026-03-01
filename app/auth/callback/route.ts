import { createClient } from '@/app/utils/supabase/server'
import { NextResponse } from 'next/server'


export async function GET(request: Request) {
    const { searchParams, origin } = new URL(request.url)
    const code = searchParams.get('code')
    // "next" là tham số để biết sau khi login xong thì nên đi đâu (mặc định là /)
    const next = searchParams.get('next') ?? '/'

    if (code) {
        const supabase = await createClient()

        const { error } = await supabase.auth.exchangeCodeForSession(code)

        if (!error) {
            return NextResponse.redirect(`${origin}${next}`)
        }
    }

    return NextResponse.redirect(`${origin}/auth/auth-code-error`)
}