(: Keelan Matthews 21549967 :)
<html>
{
    for $i in doc("cd.xml")/CATALOG
    let $counter := count($i/CD)
    return <TOTAL>{$counter}</TOTAL>
}
    <ABOVE>
        {
            let $counter := count(
                for $i in doc("cd.xml")/CATALOG/CD
                where $i/PRICE > 9
                return $i
            )
            return <COUNT>{$counter}</COUNT>
        }
        {
            for $i in doc("cd.xml")/CATALOG/CD
            let $title := $i/TITLE
            where $i/PRICE > 9
            order by $i/COUNTRY, $title
            return <TITLE>{$title}</TITLE>
        }
    </ABOVE>
    <BELOW>
        {
            let $counter := count(
                for $i in doc("cd.xml")/CATALOG/CD
                where $i/PRICE < 9
                return $i
            )
            return <COUNT>{$counter}</COUNT>
        }
        {
            for $i in doc("cd.xml")/CATALOG/CD
            let $title := $i/TITLE
            where $i/PRICE < 9
            order by $i/COUNTRY, $title
            return <TITLE>{$title}</TITLE>
        }
    </BELOW>
</html>