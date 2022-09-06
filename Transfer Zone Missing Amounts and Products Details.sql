----====================================================-----
select Max(te.ThingId) [MaximumThingID],
       Min(te.ThingId) [MinimumThingID]

from ThingEvent te
join ThingTransaction tt on tt.Id = te.ThingTransactionId 

where tt.CreatedOn >= '2022-03-01 00:00 +06:00'
and tt.CreatedOn < '2022-04-01 00:00 +06:00'
and tt.FromState in (4,1099511627776,4398046511104,17592186044416,35184372088832)
and tt.ToState in (16)
----====================================================-----



Select cast(dbo.tobdt(tt.CreatedOn) as date) [Date],
       w.Id [ID],
	   w.Name [WarehouseName],
	   pv.Id [PVID],
	   pv.Name [Product],
	   sum(t.CostPrice) [MissingAmount]
	   
from thing t
join ThingEvent te on t.id = te.ThingId 
join ThingTransaction tt on tt.Id = te.ThingTransactionId 
join Warehouse w on w.Id = t.WarehouseId 
join ProductVariant pv on pv.Id = t.ProductVariantId 

where tt.CreatedOn >= '2022-03-01 00:00 +06:00'
and tt.CreatedOn < '2022-04-01 00:00 +06:00'
and tt.FromState in (4,1099511627776,4398046511104,17592186044416,35184372088832)
and tt.ToState in (16)
and t.Id >= 99548589 ------ MinimumThingId
and t.Id <= 140000820 ------ MaximumThingId

group by cast(dbo.tobdt(tt.CreatedOn) as date),
         w.Id,
	     w.Name,
	     pv.Id,
	     pv.Name