
  create table "public"."events" (
    "id" uuid not null default gen_random_uuid(),
    "poster_path" text,
    "title" text,
    "short_description" text,
    "status" text,
    "content" text,
    "location" text,
    "max_group_members" smallint,
    "start_date" date,
    "end_date" date,
    "organized_date" timestamp with time zone,
    "created_at" timestamp with time zone not null default now(),
    "owner_id" uuid default gen_random_uuid()
      );


alter table "public"."events" enable row level security;

CREATE UNIQUE INDEX events_pkey ON public.events USING btree (id);

alter table "public"."events" add constraint "events_pkey" PRIMARY KEY using index "events_pkey";

alter table "public"."events" add constraint "events_owner_id_fkey" FOREIGN KEY (owner_id) REFERENCES public.profiles(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."events" validate constraint "events_owner_id_fkey";

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

grant delete on table "public"."events" to "anon";

grant insert on table "public"."events" to "anon";

grant references on table "public"."events" to "anon";

grant select on table "public"."events" to "anon";

grant trigger on table "public"."events" to "anon";

grant truncate on table "public"."events" to "anon";

grant update on table "public"."events" to "anon";

grant delete on table "public"."events" to "authenticated";

grant insert on table "public"."events" to "authenticated";

grant references on table "public"."events" to "authenticated";

grant select on table "public"."events" to "authenticated";

grant trigger on table "public"."events" to "authenticated";

grant truncate on table "public"."events" to "authenticated";

grant update on table "public"."events" to "authenticated";

grant delete on table "public"."events" to "postgres";

grant insert on table "public"."events" to "postgres";

grant references on table "public"."events" to "postgres";

grant select on table "public"."events" to "postgres";

grant trigger on table "public"."events" to "postgres";

grant truncate on table "public"."events" to "postgres";

grant update on table "public"."events" to "postgres";

grant delete on table "public"."events" to "service_role";

grant insert on table "public"."events" to "service_role";

grant references on table "public"."events" to "service_role";

grant select on table "public"."events" to "service_role";

grant trigger on table "public"."events" to "service_role";

grant truncate on table "public"."events" to "service_role";

grant update on table "public"."events" to "service_role";

grant delete on table "public"."profiles" to "postgres";

grant insert on table "public"."profiles" to "postgres";

grant references on table "public"."profiles" to "postgres";

grant select on table "public"."profiles" to "postgres";

grant trigger on table "public"."profiles" to "postgres";

grant truncate on table "public"."profiles" to "postgres";

grant update on table "public"."profiles" to "postgres";


  create policy "Enable delete for users based on user_id"
  on "public"."events"
  as permissive
  for delete
  to public
using ((( SELECT auth.uid() AS uid) = owner_id));



  create policy "Enable insert for authenticated users only"
  on "public"."events"
  as permissive
  for insert
  to authenticated
with check (true);



  create policy "Enable read access for all authenticated users"
  on "public"."events"
  as permissive
  for select
  to authenticated
using (true);



