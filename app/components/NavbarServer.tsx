import { createClient } from "../utils/supabase/server";
import NavBar from "./Navbar";

const NavbarServer = async () => {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();

    return <NavBar initialUser={user} />;
}

export default NavbarServer