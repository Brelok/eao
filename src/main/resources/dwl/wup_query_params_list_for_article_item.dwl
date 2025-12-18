%dw 2.0
var erpId = payload.parameterList.ERP_ID
var erpNumber = payload.parameterList.ERP_NUMBER
var erpInventoryOrgId = payload.parameterList.ERP_INVENTORY_ORG_ID
var erpInventoryOrgCode = payload.parameterList.ERP_INVENTORY_ORG_CODE
output application/json  skipNullOn="everywhere"
---
[
  {
    (ERP_ITEM_ID: erpId) if (!(erpId == null or (erpId is String and erpId == ""))),
    (ERP_ITEM_NUMBER: erpNumber) if (!(erpNumber == null or (erpNumber is String and erpNumber == ""))),
    ERP_INVENTORY_ORG_ID: 81,
    (ERP_INVENTORY_ORG_CODE: erpInventoryOrgCode) if (!(erpInventoryOrgCode == null or (erpInventoryOrgCode is String and erpInventoryOrgCode == "")))
  },
  {
    (ERP_ITEM_ID: erpId) if (!(erpId == null or (erpId is String and erpId == ""))),
    (ERP_ITEM_NUMBER: erpNumber) if (!(erpNumber == null or (erpNumber is String and erpNumber == ""))),
    ERP_INVENTORY_ORG_ID: 261,
    (ERP_INVENTORY_ORG_CODE: erpInventoryOrgCode) if (!(erpInventoryOrgCode == null or (erpInventoryOrgCode is String and erpInventoryOrgCode == "")))
  }
]