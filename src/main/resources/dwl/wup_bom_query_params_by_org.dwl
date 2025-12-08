%dw 2.0
var items = (vars.ArticleItem.item default [])
output application/json  skipNullOn="everywhere"

var item_id = items.item_id[0]
var item_number = items.item_number[0]

---
[{
  ERP_ITEM_ID: item_id,
  ERP_ITEM_NUMBER: item_number,
  ERP_INVENTORY_ORG_ID: "81",
  ERP_INVENTORY_ORG_CODE: "EHQ"
},
{
  ERP_ITEM_ID: item_id,
  ERP_ITEM_NUMBER: item_number,
  ERP_INVENTORY_ORG_ID: "261",
  ERP_INVENTORY_ORG_CODE: "ESY"
}]