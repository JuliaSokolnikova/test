create or alter procedure dbo.usp_MakeFamilyPurchase
	@FamilySurName varchar(255)
as
begin
	declare @FamilyPurchase decimal(18,2) = (select sum(b.Value) from dbo.Basket as b where b.ID_Family = (select f.ID from dbo.Family as f where f.SurName = @FamilySurName))

	if @FamilySurName not in (select f.SurName from dbo.Family as f where f.SurName = @FamilySurName)
		raiserror('Такой семьи нет', 1, 1)
	else
	begin
		update f
		set BudgetValue = f.BudgetValue - @FamilyPurchase
		from dbo.Family as f
		where f.Surname = @FamilySurName
	end
end
