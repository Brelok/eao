%dw 2.0
output application/json skipNullOn = "everywhere"
---
{
	"ERP_ITEM_ID": payload.parameterList.ERP_ID,
	"ERP_ITEM_NUMBER" : payload.parameterList.ERP_NUMBER,
	"ERP_INVENTORY_ORG_ID": payload.parameterList.ERP_INVENTORY_ORG_ID,
	"ERP_INVENTORY_ORG_CODE": payload.parameterList.ERP_INVENTORY_ORG_CODE
}