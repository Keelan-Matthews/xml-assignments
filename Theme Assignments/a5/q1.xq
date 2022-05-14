(: Keelan Matthews 21549967 :)
fn:round(
    fn:sum(
    for $item in doc("cd.xml")/CATALOG
    return $item/CD/PRICE
    )
)