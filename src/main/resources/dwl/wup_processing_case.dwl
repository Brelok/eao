%dw 2.0
output application/json

var VALID_ORGS = ["81", "261"]

var eventOrgId = (payload.parameterList.ERP_INVENTORY_ORG_ID default "") as String

var articleItems = (vars.ArticleItem.item default []) as Array

fun findItemByOrg(orgIdStr: String) =
    articleItems filter (($.inventory_org_id as String default "") == orgIdStr)

var ehqItem = findItemByOrg("81")
var esyItem = findItemByOrg("261")

var hasEHQ = !isEmpty(ehqItem)
var hasESY = !isEmpty(esyItem)

//is given ArticleItem a pure BUY (trading good)?
fun isBuy(item) =
    if (isEmpty(item)) false
    else ((item.planning_make_buy_code[0] default "") as String) == "Buy"

var ehqIsBuy = isBuy(ehqItem)
var esyIsBuy = isBuy(esyItem)

---
if (!(VALID_ORGS contains eventOrgId)) 
    // Org different than EHQ/ESY → no FORMAT-WUP processing
    "SKIP"
else if ((not hasEHQ) and (not hasESY))
    // No ArticleItem for EHQ/ESY → nothing to do
    "SKIP"
else if (
    // Trading goods (BUY path):
    // 1) Only EHQ exists and is BUY
    (hasEHQ and (not hasESY) and ehqIsBuy) or
    // 2) Only ESY exists and is BUY
    (hasESY and (not hasEHQ) and esyIsBuy) or
    // 3) EHQ and ESY exist and both are BUY
    (hasEHQ and hasESY and ehqIsBuy and esyIsBuy)
)
    "BUY"
else
    // At least one org is NOT BUY → go through BOM path
    // (BOM will be loaded and evaluated in wup-process-with-bom)
    "WITH_BOM"

