

LOAD CSV 
WITH HEADERS FROM "http://localhost:8000/data.csv" AS csvLine
MERGE  (faculty:Faculty { name: csvLine.Faculty})
CREATE (website:Websites { site: csvLine.URL, title: csvLine.Title, status: csvLine.Status })
CREATE (department:Department {name: csvLine.Department})
CREATE (faculty)-[:Has]->(department)
CREATE (faculty)-[:Owns]->(website)
MERGE (primary:Primary_Contact {name:csvLine.Primary_Contact})
CREATE (primary)-[:Works_At]->(faculty)
CREATE (website)-[:Contact]->(primary)
MERGE (maintainer:Maintainer {name:Maintainer})
CREATE (website)-[:Maintained_By]->(maintainer)


