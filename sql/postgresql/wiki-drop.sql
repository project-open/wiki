-- 
-- @author Frank Bergmann (frank.bergmann@project-open.com)
-- @creation-date 2005-08-06
-- @arch-tag: 0d6b6723-0e95-4c00-8a84-cb79b4ad3f9d
-- @cvs-id $Id$
--


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
where mime_type = 'text/x-openacs-wiki'
;

delete from cr_mime_types
where label = 'Text - Wiki'
;


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


