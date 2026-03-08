
  create table "public"."group_challenge" (
    "id" uuid not null default gen_random_uuid(),
    "group_id" uuid,
    "challenge_id" uuid,
    "created_at" timestamp with time zone not null default now(),
    "event_id" uuid
      );


alter table "public"."group_challenge" enable row level security;


  create table "public"."submissions" (
    "id" uuid not null default gen_random_uuid(),
    "group_challenge_id" uuid,
    "group_id" uuid,
    "description" text,
    "github_link" text,
    "youtube_link" text,
    "created_at" timestamp with time zone not null default now()
      );


alter table "public"."submissions" enable row level security;

CREATE UNIQUE INDEX group_challenge_pkey ON public.group_challenge USING btree (id);

CREATE UNIQUE INDEX submissions_pkey ON public.submissions USING btree (id);

alter table "public"."group_challenge" add constraint "group_challenge_pkey" PRIMARY KEY using index "group_challenge_pkey";

alter table "public"."submissions" add constraint "submissions_pkey" PRIMARY KEY using index "submissions_pkey";

alter table "public"."group_challenge" add constraint "group_challenge_challenge_id_fkey" FOREIGN KEY (challenge_id) REFERENCES public.event_challenges(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."group_challenge" validate constraint "group_challenge_challenge_id_fkey";

alter table "public"."group_challenge" add constraint "group_challenge_event_id_fkey" FOREIGN KEY (event_id) REFERENCES public.events(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."group_challenge" validate constraint "group_challenge_event_id_fkey";

alter table "public"."group_challenge" add constraint "group_challenge_group_id_fkey" FOREIGN KEY (group_id) REFERENCES public.groups(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."group_challenge" validate constraint "group_challenge_group_id_fkey";

alter table "public"."submissions" add constraint "submissions_group_challenge_id_fkey" FOREIGN KEY (group_challenge_id) REFERENCES public.group_challenge(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."submissions" validate constraint "submissions_group_challenge_id_fkey";

alter table "public"."submissions" add constraint "submissions_group_id_fkey" FOREIGN KEY (group_id) REFERENCES public.groups(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."submissions" validate constraint "submissions_group_id_fkey";

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

grant delete on table "public"."group_challenge" to "anon";

grant insert on table "public"."group_challenge" to "anon";

grant references on table "public"."group_challenge" to "anon";

grant select on table "public"."group_challenge" to "anon";

grant trigger on table "public"."group_challenge" to "anon";

grant truncate on table "public"."group_challenge" to "anon";

grant update on table "public"."group_challenge" to "anon";

grant delete on table "public"."group_challenge" to "authenticated";

grant insert on table "public"."group_challenge" to "authenticated";

grant references on table "public"."group_challenge" to "authenticated";

grant select on table "public"."group_challenge" to "authenticated";

grant trigger on table "public"."group_challenge" to "authenticated";

grant truncate on table "public"."group_challenge" to "authenticated";

grant update on table "public"."group_challenge" to "authenticated";

grant delete on table "public"."group_challenge" to "postgres";

grant insert on table "public"."group_challenge" to "postgres";

grant references on table "public"."group_challenge" to "postgres";

grant select on table "public"."group_challenge" to "postgres";

grant trigger on table "public"."group_challenge" to "postgres";

grant truncate on table "public"."group_challenge" to "postgres";

grant update on table "public"."group_challenge" to "postgres";

grant delete on table "public"."group_challenge" to "service_role";

grant insert on table "public"."group_challenge" to "service_role";

grant references on table "public"."group_challenge" to "service_role";

grant select on table "public"."group_challenge" to "service_role";

grant trigger on table "public"."group_challenge" to "service_role";

grant truncate on table "public"."group_challenge" to "service_role";

grant update on table "public"."group_challenge" to "service_role";

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

grant delete on table "public"."submissions" to "anon";

grant insert on table "public"."submissions" to "anon";

grant references on table "public"."submissions" to "anon";

grant select on table "public"."submissions" to "anon";

grant trigger on table "public"."submissions" to "anon";

grant truncate on table "public"."submissions" to "anon";

grant update on table "public"."submissions" to "anon";

grant delete on table "public"."submissions" to "authenticated";

grant insert on table "public"."submissions" to "authenticated";

grant references on table "public"."submissions" to "authenticated";

grant select on table "public"."submissions" to "authenticated";

grant trigger on table "public"."submissions" to "authenticated";

grant truncate on table "public"."submissions" to "authenticated";

grant update on table "public"."submissions" to "authenticated";

grant delete on table "public"."submissions" to "postgres";

grant insert on table "public"."submissions" to "postgres";

grant references on table "public"."submissions" to "postgres";

grant select on table "public"."submissions" to "postgres";

grant trigger on table "public"."submissions" to "postgres";

grant truncate on table "public"."submissions" to "postgres";

grant update on table "public"."submissions" to "postgres";

grant delete on table "public"."submissions" to "service_role";

grant insert on table "public"."submissions" to "service_role";

grant references on table "public"."submissions" to "service_role";

grant select on table "public"."submissions" to "service_role";

grant trigger on table "public"."submissions" to "service_role";

grant truncate on table "public"."submissions" to "service_role";

grant update on table "public"."submissions" to "service_role";


  create policy "Enable insert for authenticated users only"
  on "public"."group_challenge"
  as permissive
  for insert
  to authenticated
with check (true);



  create policy "Enable read access for all users"
  on "public"."group_challenge"
  as permissive
  for select
  to authenticated
using (true);



  create policy "Enable insert for authenticated users only"
  on "public"."group_members"
  as permissive
  for insert
  to authenticated
with check (true);



  create policy "Enable read access for all users"
  on "public"."group_members"
  as permissive
  for select
  to authenticated
using (true);



  create policy "Enable insert for authenticated users only"
  on "public"."invitation"
  as permissive
  for insert
  to authenticated
with check (true);



  create policy "Enable read access for all users"
  on "public"."invitation"
  as permissive
  for select
  to authenticated
using (true);



  create policy "Enable insert for authenticated users only"
  on "public"."submissions"
  as permissive
  for insert
  to authenticated
with check (true);



  create policy "Enable read access for all users"
  on "public"."submissions"
  as permissive
  for select
  to authenticated
using (true);



