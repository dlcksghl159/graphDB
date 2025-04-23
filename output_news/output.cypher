CREATE (:Company {foundationYear: 2000, industry: 'AI 기반 통합 마케팅 자동화 솔루션', customersCount: 100, name: '오브젠'});

CREATE (:Product {productType: '영업관리 전문 솔루션', keyFeatures: 'AI 분석', name: '오브젠 세일즈 클라우드'});

CREATE (:Product {productType: '고객 데이터 관리 솔루션', keyFeatures: '데이터 통합 및 시각화 분석', name: '오브젠 알파벳'});

CREATE (:Market {region: '동남아 시장', name: '베트남'});

MATCH (a), (b)
WHERE a.name = '오브젠' AND b.name = '오브젠 세일즈 클라우드'
CREATE (a)-[:LAUNCHES {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = '오브젠' AND b.name = '오브젠 알파벳'
CREATE (a)-[:LAUNCHES {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = '오브젠' AND b.name = '베트남'
CREATE (a)-[:EXPANDS_INTO {name: a.name + '<->' + b.name}]->(b);