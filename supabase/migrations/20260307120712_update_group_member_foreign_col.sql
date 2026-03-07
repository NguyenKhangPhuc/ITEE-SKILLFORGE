alter table "public"."group_members" drop constraint "group_members_member_email_fkey";

alter table "public"."group_members" drop column "member_email";

alter table "public"."group_members" add column "member_id" uuid default gen_random_uuid();

alter table "public"."group_members" add constraint "group_members_member_id_fkey" FOREIGN KEY (member_id) REFERENCES public.profiles(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."group_members" validate constraint "group_members_member_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
begin
  insert into public.profiles (id, full_name, avatar_url, email)
  values (
    new.id, 
    new.raw_user_meta_data->>'full_name', 
    new.raw_user_meta_data->>'avatar_url',
    new.raw_user_meta_data->>'email'
    );
  return new;
end;
$function$
;

grant delete on table "public"."event_challenges" to "postgres";

grant insert on table "public"."event_challenges" to "postgres";

grant references on table "public"."event_challenges" to "postgres";

grant select on table "public"."event_challenges" to "postgres";

grant trigger on table "public"."event_challenges" to "postgres";

grant truncate on table "public"."event_challenges" to "postgres";

grant update on table "public"."event_challenges" to "postgres";

grant delete on table "public"."events" to "postgres";

grant insert on table "public"."events" to "postgres";

grant references on table "public"."events" to "postgres";

grant select on table "public"."events" to "postgres";

grant trigger on table "public"."events" to "postgres";

grant truncate on table "public"."events" to "postgres";

grant update on table "public"."events" to "postgres";

grant delete on table "public"."group_members" to "postgres";

grant insert on table "public"."group_members" to "postgres";

grant references on table "public"."group_members" to "postgres";

grant select on table "public"."group_members" to "postgres";

grant trigger on table "public"."group_members" to "postgres";

grant truncate on table "public"."group_members" to "postgres";

grant update on table "public"."group_members" to "postgres";

grant delete on table "public"."groups" to "postgres";

grant insert on table "public"."groups" to "postgres";

grant references on table "public"."groups" to "postgres";

grant select on table "public"."groups" to "postgres";

grant trigger on table "public"."groups" to "postgres";

grant truncate on table "public"."groups" to "postgres";

grant update on table "public"."groups" to "postgres";

grant delete on table "public"."invitation" to "postgres";

grant insert on table "public"."invitation" to "postgres";

grant references on table "public"."invitation" to "postgres";

grant select on table "public"."invitation" to "postgres";

grant trigger on table "public"."invitation" to "postgres";

grant truncate on table "public"."invitation" to "postgres";

grant update on table "public"."invitation" to "postgres";

grant delete on table "public"."profiles" to "postgres";

grant insert on table "public"."profiles" to "postgres";

grant references on table "public"."profiles" to "postgres";

grant select on table "public"."profiles" to "postgres";

grant trigger on table "public"."profiles" to "postgres";

grant truncate on table "public"."profiles" to "postgres";

grant update on table "public"."profiles" to "postgres";


  create policy "Enable insert for authenticated users only"
  on "public"."groups"
  as permissive
  for insert
  to authenticated
with check (true);



  create policy "Enable read access for all users"
  on "public"."groups"
  as permissive
  for select
  to authenticated
using (true);



