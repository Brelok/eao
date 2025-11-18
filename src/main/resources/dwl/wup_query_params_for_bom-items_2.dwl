output application/json skipNullOn = "everywhere"
---
{
	"ERP_ITEM_NUMBER" : vars.currentMaterialID,
	"ERP_INVENTORY_ORG_ID": vars.originalPayload.parameterList.ERP_INVENTORY_ORG_ID
}