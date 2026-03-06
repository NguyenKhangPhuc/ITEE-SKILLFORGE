create type "public"."EVENT_STATUS" as enum ('ongoing', 'finished');


  create table "public"."event_challenges" (
    "id" uuid not null default gen_random_uuid(),
    "company_name" text,
    "title" text,
    "created_at" timestamp with time zone not null default now(),
    "event_id" uuid
      );


alter table "public"."event_challenges" enable row level security;

alter table "public"."events" alter column "status" set data type public."EVENT_STATUS" using "status"::public."EVENT_STATUS";

CREATE UNIQUE INDEX event_challenges_pkey ON public.event_challenges USING btree (id);

alter table "public"."event_challenges" add constraint "event_challenges_pkey" PRIMARY KEY using index "event_challenges_pkey";

alter table "public"."event_challenges" add constraint "event_challenges_event_id_fkey" FOREIGN KEY (event_id) REFERENCES public.events(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."event_challenges" validate constraint "event_challenges_event_id_fkey";

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

grant delete on table "public"."event_challenges" to "anon";

grant insert on table "public"."event_challenges" to "anon";

grant references on table "public"."event_challenges" to "anon";

grant select on table "public"."event_challenges" to "anon";

grant trigger on table "public"."event_challenges" to "anon";

grant truncate on table "public"."event_challenges" to "anon";

grant update on table "public"."event_challenges" to "anon";

grant delete on table "public"."event_challenges" to "authenticated";

grant insert on table "public"."event_challenges" to "authenticated";

grant references on table "public"."event_challenges" to "authenticated";

grant select on table "public"."event_challenges" to "authenticated";

grant trigger on table "public"."event_challenges" to "authenticated";

grant truncate on table "public"."event_challenges" to "authenticated";

grant update on table "public"."event_challenges" to "authenticated";

grant delete on table "public"."event_challenges" to "postgres";

grant insert on table "public"."event_challenges" to "postgres";

grant references on table "public"."event_challenges" to "postgres";

grant select on table "public"."event_challenges" to "postgres";

grant trigger on table "public"."event_challenges" to "postgres";

grant truncate on table "public"."event_challenges" to "postgres";

grant update on table "public"."event_challenges" to "postgres";

grant delete on table "public"."event_challenges" to "service_role";

grant insert on table "public"."event_challenges" to "service_role";

grant references on table "public"."event_challenges" to "service_role";

grant select on table "public"."event_challenges" to "service_role";

grant trigger on table "public"."event_challenges" to "service_role";

grant truncate on table "public"."event_challenges" to "service_role";

grant update on table "public"."event_challenges" to "service_role";

grant delete on table "public"."events" to "postgres";

grant insert on table "public"."events" to "postgres";

grant references on table "public"."events" to "postgres";

grant select on table "public"."events" to "postgres";

grant trigger on table "public"."events" to "postgres";

grant truncate on table "public"."events" to "postgres";

grant update on table "public"."events" to "postgres";

grant delete on table "public"."profiles" to "postgres";

grant insert on table "public"."profiles" to "postgres";

grant references on table "public"."profiles" to "postgres";

grant select on table "public"."profiles" to "postgres";

grant trigger on table "public"."profiles" to "postgres";

grant truncate on table "public"."profiles" to "postgres";

grant update on table "public"."profiles" to "postgres";


  create policy "Enable delete for users based on user_id"
  on "public"."event_challenges"
  as permissive
  for delete
  to authenticated
using ((EXISTS ( SELECT 1
   FROM public.events
  WHERE ((events.id = event_challenges.event_id) AND (events.owner_id = auth.uid())))));



  create policy "Enable insert for authenticated users only"
  on "public"."event_challenges"
  as permissive
  for insert
  to authenticated
with check (true);



  create policy "Enable read access for all users"
  on "public"."event_challenges"
  as permissive
  for select
  to authenticated
using (true);



