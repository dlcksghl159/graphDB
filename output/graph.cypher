CREATE CONSTRAINT IF NOT EXISTS FOR (n:Agreement) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:Company) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:Country) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:CrowdfundingPlatform) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:Factory) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:Location) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:MotorVehicle) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:Organization) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:Person) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:Product) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:Region) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:SME) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:Technology) REQUIRE n.name IS UNIQUE;

MERGE (n:Person {name: '김두연'})
  ON CREATE SET n.role = '프레스 업무', n.age = 71
  ON MATCH  SET n.role = '프레스 업무', n.age = 71;

MERGE (n:Product {name: '풀히트 푸드워머'})
  ON CREATE SET n.preheatTime = '10초', n.design = '롤러블 디자인', n.portability = '휴대 간편', n.durability = '내구성 뛰어남', n.temperatureLevels = '60도와 100도', n.safetyFeatures = '잠금 모드와 자동 오프 기능'
  ON MATCH  SET n.preheatTime = '10초', n.design = '롤러블 디자인', n.portability = '휴대 간편', n.durability = '내구성 뛰어남', n.temperatureLevels = '60도와 100도', n.safetyFeatures = '잠금 모드와 자동 오프 기능';

MERGE (n:Company {name: 'Hyundai Livart'})
  ON CREATE SET n.stock_code = '079430', n.type = 'Public', n.industry = 'Furniture', n.annual_revenue = 4378000000
  ON MATCH  SET n.stock_code = '079430', n.type = 'Public', n.industry = 'Furniture', n.annual_revenue = 4378000000;

MERGE (n:Agreement {name: '글로벌 물류 지원 협약'})
  ON CREATE SET n.agreement_date = '2023-10-14', n.agreement_type = '업무협약', n.purpose = '수출 중소벤처기업의 글로벌 물류 지원', n.location = '부산', n.title = '글로벌 물류 지원 협약', n.id = '12345'
  ON MATCH  SET n.agreement_date = '2023-10-14', n.agreement_type = '업무협약', n.purpose = '수출 중소벤처기업의 글로벌 물류 지원', n.location = '부산', n.title = '글로벌 물류 지원 협약', n.id = '12345';

MERGE (n:Factory {name: '안산 공장'})
  ON CREATE SET n.factoryName = '안산 공장', n.location = '경기 안산시 단원구', n.workerCount = 60, n.maxDailyProduction = 1200
  ON MATCH  SET n.factoryName = '안산 공장', n.location = '경기 안산시 단원구', n.workerCount = 60, n.maxDailyProduction = 1200;

MERGE (n:Region {name: 'Spain'});

MERGE (n:Product {name: '케이캡'})
  ON CREATE SET n.category = '위식도역류질환 치료제'
  ON MATCH  SET n.category = '위식도역류질환 치료제';

MERGE (n:Region {name: '인천'});

MERGE (n:Company {name: 'Hanssem'})
  ON CREATE SET n.stock_code = '009240', n.type = 'Public', n.industry = 'Furniture', n.annual_revenue = 4434000000
  ON MATCH  SET n.stock_code = '009240', n.type = 'Public', n.industry = 'Furniture', n.annual_revenue = 4434000000;

MERGE (n:Agreement {name: 'ESG 지원 업무협약'})
  ON CREATE SET n.agreement_date = '2023-09-14', n.agreement_type = '업무협약', n.purpose = 'ESG 지원', n.location = '에이피텍 본사', n.title = 'ESG 지원 업무협약', n.id = 'AG_20230914'
  ON MATCH  SET n.agreement_date = '2023-09-14', n.agreement_type = '업무협약', n.purpose = 'ESG 지원', n.location = '에이피텍 본사', n.title = 'ESG 지원 업무협약', n.id = 'AG_20230914';

MERGE (n:Organization {name: '중소벤처기업부'})
  ON CREATE SET n.category = 'Government', n.type = 'Ministry', n.location = 'South Korea'
  ON MATCH  SET n.category = 'Government', n.type = 'Ministry', n.location = 'South Korea';

MERGE (n:Technology {name: 'Computational Fluid Dynamics'})
  ON CREATE SET n.tech_name = 'Computational Fluid Dynamics', n.category = 'Aerodynamics', n.description = 'Technology used for aerodynamic optimization'
  ON MATCH  SET n.tech_name = 'Computational Fluid Dynamics', n.category = 'Aerodynamics', n.description = 'Technology used for aerodynamic optimization';

MERGE (n:CrowdfundingPlatform {name: '와디즈'});

MERGE (n:Location {name: '경기도'})
  ON CREATE SET n.type = 'Province', n.region = 'South Korea', n.country = 'South Korea'
  ON MATCH  SET n.type = 'Province', n.region = 'South Korea', n.country = 'South Korea';

MERGE (n:Company {name: '삼성바이오로직스'})
  ON CREATE SET n.industry = '제약바이오'
  ON MATCH  SET n.industry = '제약바이오';

MERGE (n:Organization {name: '롯데웰푸드'})
  ON CREATE SET n.type = 'Corporation', n.location = '대한민국', n.industry = 'Food Manufacturing'
  ON MATCH  SET n.type = 'Corporation', n.location = '대한민국', n.industry = 'Food Manufacturing';

MERGE (n:Country {name: 'China'});

MERGE (n:Agreement {name: '협력사 ESG 지원사업 업무협약'})
  ON CREATE SET n.date = '2025', n.purpose = '협력사 ESG 지원', n.location = '인천 송도', n.title = '협력사 ESG 지원사업 업무협약'
  ON MATCH  SET n.date = '2025', n.purpose = '협력사 ESG 지원', n.location = '인천 송도', n.title = '협력사 ESG 지원사업 업무협약';

MERGE (n:Company {name: 'Celltrion'})
  ON CREATE SET n.country = 'South Korea', n.industry = 'Biotechnology', n.annual_revenue = 5000000000
  ON MATCH  SET n.country = 'South Korea', n.industry = 'Biotechnology', n.annual_revenue = 5000000000;

MERGE (n:Organization {name: '한화오션디지털'})
  ON CREATE SET n.industry = '디지털', n.type = '회사', n.location = '한국'
  ON MATCH  SET n.industry = '디지털', n.type = '회사', n.location = '한국';

MERGE (n:SME {name: '에이피텍'})
  ON CREATE SET n.industry = '전자', n.location = '인천 송도', n.partner_since_year = 2025
  ON MATCH  SET n.industry = '전자', n.location = '인천 송도', n.partner_since_year = 2025;

MERGE (n:MotorVehicle {name: 'Body Kit'})
  ON CREATE SET n.category = 'Automotive', n.type = 'Aerodynamic'
  ON MATCH  SET n.category = 'Automotive', n.type = 'Aerodynamic';

MATCH (a:Factory {name: '안산 공장'}),
      (b:_UNSPEC   {name: '창문형 에어컨'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:Company {name: 'Hyundai Livart'}),
      (b:_UNSPEC   {name: 'B2C Sector'})
MERGE (a)-[r:OPERATES_IN]->(b);

MATCH (a:Company {name: 'Celltrion'}),
      (b:_UNSPEC   {name: 'Vegzelma'})
MERGE (a)-[r:OFFERS]->(b);

MATCH (a:Company {name: 'Hanssem'}),
      (b:_UNSPEC   {name: 'B2C Sector'})
MERGE (a)-[r:OPERATES_IN]->(b);

MATCH (a:Company {name: 'Celltrion'}),
      (b:_UNSPEC   {name: 'Europe'})
MERGE (a)-[r:OPERATES_IN]->(b);

MATCH (a:_UNSPEC {name: 'Export Summary'}),
      (b:_UNSPEC   {name: '미국'})
MERGE (a)-[r:EXPORTS_TO]->(b);

MATCH (a:Company {name: 'Celltrion'}),
      (b:_UNSPEC   {name: 'Herzuma'})
MERGE (a)-[r:OFFERS]->(b);

MATCH (a:MotorVehicle {name: 'Body Kit'}),
      (b:_UNSPEC   {name: 'BMW M4'})
MERGE (a)-[r:DESIGNED_FOR]->(b);

MATCH (a:_UNSPEC {name: '셀트리온 스페인 법인'}),
      (b:_UNSPEC   {name: '허쥬마'})
MERGE (a)-[r:SELLS]->(b);

MATCH (a:_UNSPEC {name: '현대이지웰'}),
      (b:_UNSPEC   {name: 'WelfareMall'})
MERGE (a)-[r:OPERATES_IN]->(b);

MATCH (a:_UNSPEC {name: 'Export Summary'}),
      (b:_UNSPEC   {name: '인도네시아'})
MERGE (a)-[r:EXPORTS_TO]->(b);

MATCH (a:_UNSPEC {name: 'Samsung Biologics'}),
      (b:_UNSPEC   {name: 'Biotechnology'})
MERGE (a)-[r:OPERATES_IN]->(b);

MATCH (a:CrowdfundingPlatform {name: '와디즈'}),
      (b:_UNSPEC   {name: '뉴에어론 풀 체어'})
MERGE (a)-[r:OFFERS]->(b);

MATCH (a:_UNSPEC {name: '부산항만공사'}),
      (b:_UNSPEC   {name: 'BPA 해외물류센터'})
MERGE (a)-[r:OPERATES]->(b);