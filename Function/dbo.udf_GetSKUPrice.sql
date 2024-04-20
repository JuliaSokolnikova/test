create or alter function dbo.udf_GetSKUPrice(
	@ID_SKU int
)
returns decimal(18,2)
as
begin
	declare 
		@SumValue decimal(18,2)
		,@SumQuantity decimal(18,2)
		,@Result decimal(18,2)
			
	select @SumValue = SUM(b.Value)
	from dbo.Basket as b
	where b.ID_SKU = @ID_SKU

	select @SumQuantity = SUM(b.Quantity)
	from dbo.Basket as b
	where b.ID_SKU = @ID_SKU

	set @Result = @SumValue/@SumQuantity

	return @Result
end
