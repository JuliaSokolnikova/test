create or alter trigger dbo.tr_Basket_insert_update
on dbo.Basket
after insert
as
begin
	drop table if exists #InsetredSKU
	select
		count(i.ID_SKU) as cnt
		,i.ID_SKU
	into #InsertedSKU
	from inserted as i
	group by i.ID_SKU

	if 2 <= any (select ins.cnt from #InsertedSKU as ins)
		update b
		set DiscountValue = b.Value * 0.05
		from dbo.Basket as b
		where b.ID_SKU in (select ins.ID_SKU from #InsertedSKU as ins where ins.cnt >= 2)
			and b.ID in (select i.ID from inserted as i)
	else
		update b
		set DiscountValue = 0
		from dbo.Basket as b
		where b.ID_SKU in (select ins.ID_SKU from #InsertedSKU as ins where ins.cnt < 2)
			and b.ID in (select i.ID from inserted as i)
end