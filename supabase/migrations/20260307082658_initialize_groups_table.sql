
  create table "public"."groups" (
    "id" uuid not null default gen_random_uuid(),
    "group_name" text,
    "event_id" uuid default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now()
      );


alter table "public"."groups" enable row level security;

CREATE UNIQUE INDEX groups_pkey ON public.groups USING btree (id);

alter table "public"."groups" add constraint "groups_pkey" PRIMARY KEY using index "groups_pkey";

alter table "public"."groups" add constraint "groups_event_id_fkey" FOREIGN KEY (event_id) REFERENCES public.events(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."groups" validate constraint "groups_event_id_fkey";

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

grant delete on table "public"."groups" to "anon";

grant insert on table "public"."groups" to "anon";

grant references on table "public"."groups" to "anon";

grant select on table "public"."groups" to "anon";

grant trigger on table "public"."groups" to "anon";

grant truncate on table "public"."groups" to "anon";

grant update on table "public"."groups" to "anon";

grant delete on table "public"."groups" to "authenticated";

grant insert on table "public"."groups" to "authenticated";

grant references on table "public"."groups" to "authenticated";

grant select on table "public"."groups" to "authenticated";

grant trigger on table "public"."groups" to "authenticated";

grant truncate on table "public"."groups" to "authenticated";

grant update on table "public"."groups" to "authenticated";

grant delete on table "public"."groups" to "postgres";

grant insert on table "public"."groups" to "postgres";

grant references on table "public"."groups" to "postgres";

grant select on table "public"."groups" to "postgres";

grant trigger on table "public"."groups" to "postgres";

grant truncate on table "public"."groups" to "postgres";

grant update on table "public"."groups" to "postgres";

grant delete on table "public"."groups" to "service_role";

grant insert on table "public"."groups" to "service_role";

grant references on table "public"."groups" to "service_role";

grant select on table "public"."groups" to "service_role";

grant trigger on table "public"."groups" to "service_role";

grant truncate on table "public"."groups" to "service_role";

grant update on table "public"."groups" to "service_role";

grant delete on table "public"."profiles" to "postgres";

grant insert on table "public"."profiles" to "postgres";

grant references on table "public"."profiles" to "postgres";

grant select on table "public"."profiles" to "postgres";

grant trigger on table "public"."profiles" to "postgres";

grant truncate on table "public"."profiles" to "postgres";

grant update on table "public"."profiles" to "postgres";


