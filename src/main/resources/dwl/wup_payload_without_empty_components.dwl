%dw 2.0
/*Update removenull function
 * if bom of bom is empty regarding internal movements - component is throwing away
 * if bom of bom had internal movements inside - also is cutting off
*/
import modules::functions
output application/xml

var ignoreData = (vars.results default [] filter (!isEmpty($.numberOfComponents))).MaterialID default []

fun removenull(data) =
    (data default [])
        filter ((c) -> c.MaterialID != null)
        filter ((c) -> ignoreData contains c.MaterialID)
        filter ((c) -> !functions::isInternalMovementComponent(c))
---
root: {
  Article: (vars.preparedArticleWithBom.root.*Article) map ((article) ->
	if (!isEmpty(removenull(article.*Component)))
	((article - "Component") ++ { Component: removenull(article.*Component) })
	else
	(article - "Component")
  )
}