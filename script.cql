
//data1
LOAD CSV 
WITH HEADERS FROM "http://localhost:8000/data.csv" AS csvLine
MERGE  (faculty:Faculty { name: csvLine.Faculty})
CREATE (website:Websites { site: csvLine.URL, title: csvLine.Title, status: csvLine.Status })
CREATE (faculty)-[:Owns]->(website)
MERGE (department:Department {name: csvLine.Department})
CREATE (faculty)-[:Has]->(department)
MERGE (contact:Person {name:csvLine.Primary_Contact})
MERGE (maintain:Person {name:csvLine.Maintainer})
CREATE (contact)-[: c]->(faculty)
CREATE (website)-[:Maintained_By]->(maintain)
CREATE (website)-[:Contact]->(contact)



Match (x:Person) where x.name="" set x.name='Unknown' return x;
Match (x:Faculty) where x.name=~".*Unknown" set x.name='Unknown'return x;
Match (x:Department) where x.name="" set x.name='Unknown' return x;

//data 2
LOAD CSV 
WITH HEADERS FROM "http://localhost:8000/large_data.csv" AS csvData





