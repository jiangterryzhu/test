-----Step 3 Update member tier processing date for processing old tier update to new tier
--first day
begin tran
update s_loy_mem_tier
set processed_dt = null
where --member_id = (select row_id from s_loy_member where mem_num = '51Y00000795')
exists (select 1 from tempdb.dbo.zhuj_YSL_CHN_POINT_FINAL_20181109 f where f.member_id=s_loy_mem_tier.member_id)
and active_flg = 'Y'
commit;

--second day
begin tran
update s_loy_mem_tier
set processed_dt = null
where --member_id = (select row_id from s_loy_member where mem_num = '51Y00000795')
member_id in (select row_id from S_LOY_MEMBER where BU_ID='1-3UXGPZJ' and PR_DOM_TIER_ID<>'1-3UXGPZW')
and active_flg = 'Y'
commit;

--check GC with point_type_d_val, point_type_c_val both >0

select *
from s_loy_member
where pr_dom_tier_id='1-3UXGPZW'
and point_type_d_val>0 or point_type_c_val>0
and bu_id='1-3UXGPZJ'