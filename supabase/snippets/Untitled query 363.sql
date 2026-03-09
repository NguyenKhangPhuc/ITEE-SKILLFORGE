ALTER TABLE invitation
ADD CONSTRAINT unique_group_invitation UNIQUE (group_id, member_email);