%dw 2.0
output application/json skipNullOn = "everywhere"
var erpId = payload.parameterList.ERP_ID
var erpNumber = payload.parameterList.ERP_NUMBER
var erpInventoryOrgId = payload.parameterList.ERP_INVENTORY_ORG_ID
var erpInventoryOrgCode = payload.parameterList.ERP_INVENTORY_ORG_CODE
---
{
    (ERP_ITEM_ID: erpId) if !(erpId == null or (erpId is String and erpId == "")),
    (ERP_ITEM_NUMBER: erpNumber) if !(erpNumber == null or (erpNumber is String and erpNumber == "")),
    (ERP_INVENTORY_ORG_ID: erpInventoryOrgId) if !(erpInventoryOrgId == null or (erpInventoryOrgId is String and erpInventoryOrgId == "")),
    (ERP_INVENTORY_ORG_CODE: erpInventoryOrgCode) if !(erpInventoryOrgCode == null or (erpInventoryOrgCode is String and erpInventoryOrgCode == ""))
}