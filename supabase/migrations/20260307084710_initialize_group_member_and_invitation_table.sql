create type "public"."INVITATION_STATUS" as enum ('pending', 'rejected', 'accepted');


  create table "public"."group_members" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "group_id" uuid default gen_random_uuid(),
    "member_email" text default gen_random_uuid()
      );


alter table "public"."group_members" enable row level security;


  create table "public"."invitation" (
    "id" uuid not null default gen_random_uuid(),
    "group_id" uuid default gen_random_uuid(),
    "member_email" text,
    "invitation_status" public."INVITATION_STATUS",
    "created_at" timestamp with time zone not null default now()
      );


alter table "public"."invitation" enable row level security;

CREATE UNIQUE INDEX group_members_pkey ON public.group_members USING btree (id);

CREATE UNIQUE INDEX invitation_pkey ON public.invitation USING btree (id);

alter table "public"."group_members" add constraint "group_members_pkey" PRIMARY KEY using index "group_members_pkey";

alter table "public"."invitation" add constraint "invitation_pkey" PRIMARY KEY using index "invitation_pkey";

alter table "public"."group_members" add constraint "group_members_group_id_fkey" FOREIGN KEY (group_id) REFERENCES public.groups(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."group_members" validate constraint "group_members_group_id_fkey";

alter table "public"."group_members" add constraint "group_members_member_email_fkey" FOREIGN KEY (member_email) REFERENCES public.profiles(email) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."group_members" validate constraint "group_members_member_email_fkey";

alter table "public"."invitation" add constraint "invitation_group_id_fkey" FOREIGN KEY (group_id) REFERENCES public.groups(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."invitation" validate constraint "invitation_group_id_fkey";

alter table "public"."invitation" add constraint "invitation_member_email_fkey" FOREIGN KEY (member_email) REFERENCES public.profiles(email) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."invitation" validate constraint "invitation_member_email_fkey";

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

grant delete on table "public"."group_members" to "anon";

grant insert on table "public"."group_members" to "anon";

grant references on table "public"."group_members" to "anon";

grant select on table "public"."group_members" to "anon";

grant trigger on table "public"."group_members" to "anon";

grant truncate on table "public"."group_members" to "anon";

grant update on table "public"."group_members" to "anon";

grant delete on table "public"."group_members" to "authenticated";

grant insert on table "public"."group_members" to "authenticated";

grant references on table "public"."group_members" to "authenticated";

grant select on table "public"."group_members" to "authenticated";

grant trigger on table "public"."group_members" to "authenticated";

grant truncate on table "public"."group_members" to "authenticated";

grant update on table "public"."group_members" to "authenticated";

grant delete on table "public"."group_members" to "postgres";

grant insert on table "public"."group_members" to "postgres";

grant references on table "public"."group_members" to "postgres";

grant select on table "public"."group_members" to "postgres";

grant trigger on table "public"."group_members" to "postgres";

grant truncate on table "public"."group_members" to "postgres";

grant update on table "public"."group_members" to "postgres";

grant delete on table "public"."group_members" to "service_role";

grant insert on table "public"."group_members" to "service_role";

grant references on table "public"."group_members" to "service_role";

grant select on table "public"."group_members" to "service_role";

grant trigger on table "public"."group_members" to "service_role";

grant truncate on table "public"."group_members" to "service_role";

grant update on table "public"."group_members" to "service_role";

grant delete on table "public"."groups" to "postgres";

grant insert on table "public"."groups" to "postgres";

grant references on table "public"."groups" to "postgres";

grant select on table "public"."groups" to "postgres";

grant trigger on table "public"."groups" to "postgres";

grant truncate on table "public"."groups" to "postgres";

grant update on table "public"."groups" to "postgres";

grant delete on table "public"."invitation" to "anon";

grant insert on table "public"."invitation" to "anon";

grant references on table "public"."invitation" to "anon";

grant select on table "public"."invitation" to "anon";

grant trigger on table "public"."invitation" to "anon";

grant truncate on table "public"."invitation" to "anon";

grant update on table "public"."invitation" to "anon";

grant delete on table "public"."invitation" to "authenticated";

grant insert on table "public"."invitation" to "authenticated";

grant references on table "public"."invitation" to "authenticated";

grant select on table "public"."invitation" to "authenticated";

grant trigger on table "public"."invitation" to "authenticated";

grant truncate on table "public"."invitation" to "authenticated";

grant update on table "public"."invitation" to "authenticated";

grant delete on table "public"."invitation" to "postgres";

grant insert on table "public"."invitation" to "postgres";

grant references on table "public"."invitation" to "postgres";

grant select on table "public"."invitation" to "postgres";

grant trigger on table "public"."invitation" to "postgres";

grant truncate on table "public"."invitation" to "postgres";

grant update on table "public"."invitation" to "postgres";

grant delete on table "public"."invitation" to "service_role";

grant insert on table "public"."invitation" to "service_role";

grant references on table "public"."invitation" to "service_role";

grant select on table "public"."invitation" to "service_role";

grant trigger on table "public"."invitation" to "service_role";

grant truncate on table "public"."invitation" to "service_role";

grant update on table "public"."invitation" to "service_role";

grant delete on table "public"."profiles" to "postgres";

grant insert on table "public"."profiles" to "postgres";

grant references on table "public"."profiles" to "postgres";

grant select on table "public"."profiles" to "postgres";

grant trigger on table "public"."profiles" to "postgres";

grant truncate on table "public"."profiles" to "postgres";

grant update on table "public"."profiles" to "postgres";


