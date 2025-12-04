%dw 2.0
output application/json skipNullOn = "everywhere"
var items = (vars.ArticleItem.item default [])
---
items
    // we take only EHQ and ESY
    filter ((it) -> ["EHQ", "ESY"] contains ((it.inventory_org_code default "") as String))
    map (it) -> {
        ERP_ITEM_ID:           it.item_id,
        ERP_ITEM_NUMBER:       it.item_number,
        ERP_INVENTORY_ORG_ID:  it.inventory_org_id,
        ERP_INVENTORY_ORG_CODE: it.inventory_org_code
    }