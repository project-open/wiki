-- 
-- @author Frank Bergmann (frank.bergmann@project-open.com)
-- @creation-date 2005-08-06
-- @arch-tag: 0d6b6723-0e95-4c00-8a84-cb79b4ad3f9d
-- @cvs-id $Id$
--


select	content_item__delete(item_id)
from	(
	select	content_folder__is_folder(item_id) as folder_p, 
		item_id
	from	cr_items
	where	parent_id in (select folder_id from cr_folders where package_id in (select package_id from apm_packages where package_key = 'wiki'))
	) t
where	folder_p = 'f';


select	content_folder__del(item_id,'t')
from	(
	select	content_folder__is_folder(item_id) as folder_p, 
		item_id
	from	cr_items
	where	parent_id in (select folder_id from cr_folders where package_id in (select package_id from apm_packages where package_key = 'wiki'))
	) t
where	folder_p = 't';




delete from acs_object_context_index
where ancestor_id in (
	select	object_id
	from    acs_objects
	where   context_id in (
                        select  folder_id
                        from    cr_folders
                        where   package_id in (select package_id from apm_packages where package_key = 'wiki')
		)
);

delete from acs_objects
where context_id in (
	select	object_id
	from    acs_objects
	where   context_id in (
                        select  folder_id
                        from    cr_folders
                        where   package_id in (select package_id from apm_packages where package_key = 'wiki')
		)
);


-- Seems right, but causes issue with "acs_object_context_index" acs_obj_context_idx_anc_id_fk
select	content_item__delete(object_id)
from	(
	select	content_folder__is_folder(object_id) as folder_p, 
		object_id
	from    acs_objects
	where   context_id in (
                        select  folder_id
                        from    cr_folders
                        where   package_id in (select package_id from apm_packages where package_key = 'wiki')
		)
	) t
where	folder_p = 'f';





select	content_folder__del(folder_id, 't')
from	cr_folders
where	package_id in (select package_id from apm_packages where package_key = 'wiki');




----------------------------------------------------
-- Folders and FolderTypeMap


delete from cr_folder_type_map
where folder_id in (
	select folder_id
	from cr_folders
	where package_id in (
		select package_id
		from apm_packages
		where package_key = 'wiki'
	)
);


delete from cr_folders
where package_id in (
	select package_id
	from apm_packages
	where package_key = 'wiki'
);



----------------------------------------------------
-- x-openacs-wiki

delete from cr_item_rels
where item_id in (
	select item_id
	from cr_items
	where live_revision in (
			select revision_id
			from cr_revisions
			where mime_type = 'text/x-openacs-wiki'
		) or latest_revision in (
			select revision_id
			from cr_revisions
			where mime_type = 'text/x-openacs-wiki'
		)
	)
;

delete from cr_items
where live_revision in (
		select revision_id
		from cr_revisions
		where mime_type = 'text/x-openacs-wiki'
	) 
	or latest_revision in (
		select revision_id
		from cr_revisions
		where mime_type = 'text/x-openacs-wiki'
	)
;


delete from cr_revisions
where mime_type = 'text/x-openacs-wiki';

delete from cr_mime_types
where label = 'Text - Wiki';


----------------------------------------------------
-- x-openacs-markdown

delete from cr_item_rels
where item_id in (
	select item_id
	from cr_items
	where live_revision in (
			select revision_id
			from cr_revisions
			where mime_type = 'text/x-openacs-markdown'
		) or latest_revision in (
			select revision_id
			from cr_revisions
			where mime_type = 'text/x-openacs-markdown'
		)
	)
;

delete from cr_items
where live_revision in (
		select revision_id
		from cr_revisions
		where mime_type = 'text/x-openacs-markdown'
	) 
	or latest_revision in (
		select revision_id
		from cr_revisions
		where mime_type = 'text/x-openacs-markdown'
	)
;


delete from cr_revisions
where mime_type = 'text/x-openacs-markdown'
;

delete from cr_mime_types
where label = 'Text - Markdown'
;



----------------------------------------------------
-- Package & folders

 
update acs_objects
set context_id = null
where context_id in (
	select	package_id
	from	apm_packages
	where	package_key = 'wiki'
);




----------------------------------------------------
-- 

delete from acs_permissions
where object_id in (
	select package_id from apm_packages where package_key = 'wiki'
);

select apm_package__delete(
       (select package_id from apm_packages where package_key = 'wiki')
);


