CREATE UNIQUE INDEX unique_group_invitation ON public.invitation USING btree (group_id, member_email);

CREATE UNIQUE INDEX unique_group_submission ON public.submissions USING btree (group_id, group_challenge_id);

alter table "public"."invitation" add constraint "unique_group_invitation" UNIQUE using index "unique_group_invitation";

alter table "public"."submissions" add constraint "unique_group_submission" UNIQUE using index "unique_group_submission";

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

grant delete on table "public"."group_challenge" to "postgres";

grant insert on table "public"."group_challenge" to "postgres";

grant references on table "public"."group_challenge" to "postgres";

grant select on table "public"."group_challenge" to "postgres";

grant trigger on table "public"."group_challenge" to "postgres";

grant truncate on table "public"."group_challenge" to "postgres";

grant update on table "public"."group_challenge" to "postgres";

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

grant delete on table "public"."submissions" to "postgres";

grant insert on table "public"."submissions" to "postgres";

grant references on table "public"."submissions" to "postgres";

grant select on table "public"."submissions" to "postgres";

grant trigger on table "public"."submissions" to "postgres";

grant truncate on table "public"."submissions" to "postgres";

grant update on table "public"."submissions" to "postgres";


  create policy "Policy with table joins"
  on "public"."groups"
  as permissive
  for update
  to authenticated
using (true);



  create policy "Policy with table joins"
  on "public"."submissions"
  as permissive
  for update
  to authenticated
using (true);



