(: Keelan Matthews 21549967 :)
<list>
{
    for $i in doc("cd.xml")/CATALOG/CD
    where $i/YEAR <= 1987
    return <li>{data($i/TITLE)} by {data($i/ARTIST)} - {data($i/COMPANY)}, {data($i/COUNTRY)}</li>
}
</list>