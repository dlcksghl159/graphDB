CREATE CONSTRAINT IF NOT EXISTS FOR (n:AGREEMENT) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:AWARD) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:COMPANY) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:EVENT) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:INDUSTRY) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:INVESTMENT) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:LOCATION) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:ORGANIZATION) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:PERSON) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:PRODUCT) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:PROJECT) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:REPORT) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:TECHNOLOGY) REQUIRE n.name IS UNIQUE;

MERGE (n:LOCATION {name: '경기도'})
  ON CREATE SET n.type = 'Province', n.country = 'South Korea', n.region = '경기', n.aliases = ["경기도"]
  ON MATCH  SET n.type = 'Province', n.country = 'South Korea', n.region = '경기', n.aliases = ["경기도"];

MERGE (n:EVENT {name: '찾아가는 산업재해 예방 교육'})
  ON CREATE SET n.date = '2023', n.type = 'Safety Education', n.description = '산업재해 예방을 위한 교육 프로그램', n.location = '경기도', n.aliases = ["찾아가는 산업재해 예방 교육"]
  ON MATCH  SET n.date = '2023', n.type = 'Safety Education', n.description = '산업재해 예방을 위한 교육 프로그램', n.location = '경기도', n.aliases = ["찾아가는 산업재해 예방 교육"];

MERGE (n:ORGANIZATION {name: '고용노동부'})
  ON CREATE SET n.type = 'Government', n.description = '노동 관련 정책을 담당하는 정부 부처', n.headquarters = 'South Korea', n.aliases = ["고용노동부"]
  ON MATCH  SET n.type = 'Government', n.description = '노동 관련 정책을 담당하는 정부 부처', n.headquarters = 'South Korea', n.aliases = ["고용노동부"];

MERGE (n:ORGANIZATION {name: '직업건강간호협회 직업건강안전연구소'})
  ON CREATE SET n.type = 'Research Institute', n.description = '직업 건강 및 안전 연구를 수행하는 기관', n.headquarters = 'South Korea', n.aliases = ["직업건강간호협회 직업건강안전연구소"]
  ON MATCH  SET n.type = 'Research Institute', n.description = '직업 건강 및 안전 연구를 수행하는 기관', n.headquarters = 'South Korea', n.aliases = ["직업건강간호협회 직업건강안전연구소"];

MERGE (n:PERSON {name: '임용규'})
  ON CREATE SET n.full_name = '임용규', n.role = '노동안전과장', n.nationality = 'South Korean', n.age = '', n.aliases = ["임용규"]
  ON MATCH  SET n.full_name = '임용규', n.role = '노동안전과장', n.nationality = 'South Korean', n.age = '', n.aliases = ["임용규"];

MERGE (n:COMPANY {name: '엘리스그룹'})
  ON CREATE SET n.industry = '교육', n.headquarters = '대한민국', n.founded = '', n.ceo = '김재원', n.aliases = ["엘리스그룹"]
  ON MATCH  SET n.industry = '교육', n.headquarters = '대한민국', n.founded = '', n.ceo = '김재원', n.aliases = ["엘리스그룹"];

MERGE (n:COMPANY {name: '파인디'})
  ON CREATE SET n.industry = '채용 플랫폼', n.headquarters = '일본', n.founded = '2016', n.ceo = '야마다 유이치로', n.aliases = ["파인디"]
  ON MATCH  SET n.industry = '채용 플랫폼', n.headquarters = '일본', n.founded = '2016', n.ceo = '야마다 유이치로', n.aliases = ["파인디"];

MERGE (n:PERSON {name: '김재원'})
  ON CREATE SET n.full_name = '김재원', n.role = '대표', n.nationality = 'South Korean', n.age = '', n.aliases = ["김재원"]
  ON MATCH  SET n.full_name = '김재원', n.role = '대표', n.nationality = 'South Korean', n.age = '', n.aliases = ["김재원"];

MERGE (n:PERSON {name: '야마다유이치로'})
  ON CREATE SET n.full_name = '야마다 유이치로', n.role = '대표', n.nationality = 'Japanese', n.age = '', n.aliases = ["야마다유이치로"]
  ON MATCH  SET n.full_name = '야마다 유이치로', n.role = '대표', n.nationality = 'Japanese', n.age = '', n.aliases = ["야마다유이치로"];

MERGE (n:AGREEMENT {name: '엘리스그룹-파인디 업무 협약'})
  ON CREATE SET n.type = 'Business Agreement', n.date = '2023-10-14', n.description = 'AI 플랫폼 시장 확장 및 서비스 개발 협력', n.aliases = ["엘리스그룹-파인디 업무 협약"]
  ON MATCH  SET n.type = 'Business Agreement', n.date = '2023-10-14', n.description = 'AI 플랫폼 시장 확장 및 서비스 개발 협력', n.aliases = ["엘리스그룹-파인디 업무 협약"];

MERGE (n:PRODUCT {name: '파인디 팀플러스'})
  ON CREATE SET n.category = '서비스', n.description = '엔지니어 조직의 생산성 측정 서비스', n.launch_date = '', n.company = '파인디', n.aliases = ["파인디 팀플러스"]
  ON MATCH  SET n.category = '서비스', n.description = '엔지니어 조직의 생산성 측정 서비스', n.launch_date = '', n.company = '파인디', n.aliases = ["파인디 팀플러스"];

MERGE (n:PERSON {name: ''})
  ON CREATE SET n.role = '대표', n.aliases = [""]
  ON MATCH  SET n.role = '대표', n.aliases = [""];

MERGE (n:PERSON {name: '를비롯'})
  ON CREATE SET n.role = '대표', n.aliases = ["를비롯"]
  ON MATCH  SET n.role = '대표', n.aliases = ["를비롯"];

MERGE (n:PERSON {name: '스그룹'})
  ON CREATE SET n.role = '대표', n.aliases = ["스그룹"]
  ON MATCH  SET n.role = '대표', n.aliases = ["스그룹"];

MERGE (n:PERSON {name: '엘리스그룹'})
  ON CREATE SET n.role = '대표', n.aliases = ["엘리스그룹"]
  ON MATCH  SET n.role = '대표', n.aliases = ["엘리스그룹"];

MERGE (n:PERSON {name: '파인디'})
  ON CREATE SET n.role = '대표', n.aliases = ["파인디"]
  ON MATCH  SET n.role = '대표', n.aliases = ["파인디"];

MERGE (n:COMPANY {name: 'Findy'})
  ON CREATE SET n.aliases = ["Findy"]
  ON MATCH  SET n.aliases = ["Findy"];

MERGE (n:COMPANY {name: 'Findy Team'})
  ON CREATE SET n.aliases = ["Findy Team"]
  ON MATCH  SET n.aliases = ["Findy Team"];

MERGE (n:ORGANIZATION {name: '기술보증기금'})
  ON CREATE SET n.type = 'Financial Institution', n.description = 'Provides financial guarantees and support for technology-based companies.', n.headquarters = '대한민국', n.aliases = ["기술보증기금"]
  ON MATCH  SET n.type = 'Financial Institution', n.description = 'Provides financial guarantees and support for technology-based companies.', n.headquarters = '대한민국', n.aliases = ["기술보증기금"];

MERGE (n:ORGANIZATION {name: '인천지식재산센터'})
  ON CREATE SET n.type = 'Intellectual Property Center', n.description = 'Supports intellectual property initiatives in Incheon.', n.headquarters = '인천', n.aliases = ["인천지식재산센터"]
  ON MATCH  SET n.type = 'Intellectual Property Center', n.description = 'Supports intellectual property initiatives in Incheon.', n.headquarters = '인천', n.aliases = ["인천지식재산센터"];

MERGE (n:AGREEMENT {name: '지식재산공제사업 활성화 협약'})
  ON CREATE SET n.type = 'Business Agreement', n.date = '2023-10-14', n.description = 'Agreement to enhance the intellectual property mutual aid project for joint development.', n.aliases = ["지식재산공제사업 활성화 협약"]
  ON MATCH  SET n.type = 'Business Agreement', n.date = '2023-10-14', n.description = 'Agreement to enhance the intellectual property mutual aid project for joint development.', n.aliases = ["지식재산공제사업 활성화 협약"];

MERGE (n:PROJECT {name: '지식재산공제사업'})
  ON CREATE SET n.description = 'A financial system to support SMEs by reducing intellectual property costs and risks.', n.start_date = '2019', n.status = 'Ongoing', n.aliases = ["지식재산공제사업"]
  ON MATCH  SET n.description = 'A financial system to support SMEs by reducing intellectual property costs and risks.', n.start_date = '2019', n.status = 'Ongoing', n.aliases = ["지식재산공제사업"];

MERGE (n:ORGANIZATION {name: '특허청'})
  ON CREATE SET n.type = 'Government Agency', n.description = 'Responsible for intellectual property rights in South Korea.', n.headquarters = '대한민국', n.aliases = ["특허청"]
  ON MATCH  SET n.type = 'Government Agency', n.description = 'Responsible for intellectual property rights in South Korea.', n.headquarters = '대한민국', n.aliases = ["특허청"];

MERGE (n:COMPANY {name: '롯데웰푸드'})
  ON CREATE SET n.industry = '식품', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["롯데웰푸드"], n.full_name = '롯데웰푸드'
  ON MATCH  SET n.industry = '식품', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["롯데웰푸드"], n.full_name = '롯데웰푸드';

MERGE (n:ORGANIZATION {name: '소상공인시장진흥공단'})
  ON CREATE SET n.type = 'Government Organization', n.description = 'Supports small businesses in South Korea.', n.headquarters = 'South Korea', n.aliases = ["소상공인시장진흥공단"]
  ON MATCH  SET n.type = 'Government Organization', n.description = 'Supports small businesses in South Korea.', n.headquarters = 'South Korea', n.aliases = ["소상공인시장진흥공단"];

MERGE (n:PROJECT {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
  ON CREATE SET n.description = 'Joint project to develop products using traditional recipes.', n.start_date = '2023-03', n.status = '모집 중', n.aliases = ["2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트"]
  ON MATCH  SET n.description = 'Joint project to develop products using traditional recipes.', n.start_date = '2023-03', n.status = '모집 중', n.aliases = ["2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트"];

MERGE (n:PRODUCT {name: '밀키트'})
  ON CREATE SET n.category = '식품', n.description = '백년가게 레시피를 활용한 밀키트', n.launch_date = '', n.company = '롯데웰푸드', n.aliases = ["밀키트"]
  ON MATCH  SET n.category = '식품', n.description = '백년가게 레시피를 활용한 밀키트', n.launch_date = '', n.company = '롯데웰푸드', n.aliases = ["밀키트"];

MERGE (n:PERSON {name: '박성효'})
  ON CREATE SET n.full_name = '박성효', n.role = '이사장', n.nationality = 'South Korean', n.age = '', n.aliases = ["박성효"]
  ON MATCH  SET n.full_name = '박성효', n.role = '이사장', n.nationality = 'South Korean', n.age = '', n.aliases = ["박성효"];

MERGE (n:PRODUCT {name: '식사이론'})
  ON CREATE SET n.category = '식품', n.description = '백년가게의 우수메뉴와 접목한 상품', n.launch_date = '', n.company = '롯데웰푸드', n.aliases = ["식사이론"]
  ON MATCH  SET n.category = '식품', n.description = '백년가게의 우수메뉴와 접목한 상품', n.launch_date = '', n.company = '롯데웰푸드', n.aliases = ["식사이론"];

MERGE (n:PERSON {name: '이은'})
  ON CREATE SET n.role = '사장', n.aliases = ["이은"]
  ON MATCH  SET n.role = '사장', n.aliases = ["이은"];

MERGE (n:PERSON {name: '소진공'})
  ON CREATE SET n.role = '이사', n.aliases = ["소진공"]
  ON MATCH  SET n.role = '이사', n.aliases = ["소진공"];

MERGE (n:COMPANY {name: 'HMR'})
  ON CREATE SET n.aliases = ["HMR"]
  ON MATCH  SET n.aliases = ["HMR"];

MERGE (n:COMPANY {name: 'Theory'})
  ON CREATE SET n.aliases = ["Theory"]
  ON MATCH  SET n.aliases = ["Theory"];

MERGE (n:COMPANY {name: 'SICSA'})
  ON CREATE SET n.aliases = ["SICSA"]
  ON MATCH  SET n.aliases = ["SICSA"];

MERGE (n:COMPANY {name: '현대이지웰'})
  ON CREATE SET n.full_name = '현대이지웰', n.industry = '복지솔루션', n.headquarters = '서울', n.founded = '', n.ceo = '', n.aliases = ["현대이지웰"]
  ON MATCH  SET n.full_name = '현대이지웰', n.industry = '복지솔루션', n.headquarters = '서울', n.founded = '', n.ceo = '', n.aliases = ["현대이지웰"];

MERGE (n:COMPANY {name: '현대백화점그룹'})
  ON CREATE SET n.full_name = '현대백화점그룹', n.industry = '유통', n.headquarters = '서울', n.founded = '', n.ceo = '', n.aliases = ["현대백화점그룹"]
  ON MATCH  SET n.full_name = '현대백화점그룹', n.industry = '유통', n.headquarters = '서울', n.founded = '', n.ceo = '', n.aliases = ["현대백화점그룹"];

MERGE (n:ORGANIZATION {name: '한국중소벤처기업유통원'})
  ON CREATE SET n.type = 'Government Organization', n.description = 'Supports small and medium-sized enterprises in South Korea.', n.headquarters = '대한민국', n.aliases = ["한국중소벤처기업유통원"]
  ON MATCH  SET n.type = 'Government Organization', n.description = 'Supports small and medium-sized enterprises in South Korea.', n.headquarters = '대한민국', n.aliases = ["한국중소벤처기업유통원"];

MERGE (n:LOCATION {name: '안산'})
  ON CREATE SET n.type = 'City', n.country = '대한민국', n.region = '경기', n.aliases = ["안산"]
  ON MATCH  SET n.type = 'City', n.country = '대한민국', n.region = '경기', n.aliases = ["안산"];

MERGE (n:PROJECT {name: '소상공인 온라인쇼핑몰 판매지원사업'})
  ON CREATE SET n.description = 'Supports online sales for small businesses.', n.start_date = '2023', n.status = '진행 중', n.aliases = ["소상공인 온라인쇼핑몰 판매지원사업"]
  ON MATCH  SET n.description = 'Supports online sales for small businesses.', n.start_date = '2023', n.status = '진행 중', n.aliases = ["소상공인 온라인쇼핑몰 판매지원사업"];

MERGE (n:AGREEMENT {name: '다농마트 청년몰 이용 활성화를 위한 업무협약'})
  ON CREATE SET n.type = 'Business Agreement', n.date = '2023', n.description = 'Agreement to promote the use of Danong Mart Youth Mall.', n.aliases = ["다농마트 청년몰 이용 활성화를 위한 업무협약"]
  ON MATCH  SET n.type = 'Business Agreement', n.date = '2023', n.description = 'Agreement to promote the use of Danong Mart Youth Mall.', n.aliases = ["다농마트 청년몰 이용 활성화를 위한 업무협약"];

MERGE (n:ORGANIZATION {name: '중소벤처기업진흥공단'})
  ON CREATE SET n.aliases = ["중소벤처기업진흥공단"], n.type = 'Government Agency', n.description = 'Supports small and medium-sized enterprises in South Korea.', n.headquarters = 'South Korea'
  ON MATCH  SET n.aliases = ["중소벤처기업진흥공단"], n.type = 'Government Agency', n.description = 'Supports small and medium-sized enterprises in South Korea.', n.headquarters = 'South Korea';

MERGE (n:ORGANIZATION {name: '부산항만공사'})
  ON CREATE SET n.type = 'Port Authority', n.description = 'Manages port operations in Busan, South Korea.', n.headquarters = 'Busan, South Korea', n.aliases = ["부산항만공사"]
  ON MATCH  SET n.type = 'Port Authority', n.description = 'Manages port operations in Busan, South Korea.', n.headquarters = 'Busan, South Korea', n.aliases = ["부산항만공사"];

MERGE (n:LOCATION {name: '로스앤젤레스'})
  ON CREATE SET n.type = 'City', n.country = 'USA', n.region = 'California', n.aliases = ["로스앤젤레스"]
  ON MATCH  SET n.type = 'City', n.country = 'USA', n.region = 'California', n.aliases = ["로스앤젤레스"];

MERGE (n:LOCATION {name: '롱비치'})
  ON CREATE SET n.type = 'City', n.country = 'USA', n.region = 'California', n.aliases = ["롱비치"]
  ON MATCH  SET n.type = 'City', n.country = 'USA', n.region = 'California', n.aliases = ["롱비치"];

MERGE (n:PROJECT {name: '중소기업 전용 항공·해운 통합물류 지원 플랫폼'})
  ON CREATE SET n.description = '오피스 기반의 B2B 인테리어 사업 확장', n.start_date = '2025', n.status = '진행 중', n.aliases = ["중소기업 전용 항공·해운 통합물류 지원 플랫폼"]
  ON MATCH  SET n.description = '오피스 기반의 B2B 인테리어 사업 확장', n.start_date = '2025', n.status = '진행 중', n.aliases = ["중소기업 전용 항공·해운 통합물류 지원 플랫폼"];

MERGE (n:AGREEMENT {name: '글로벌 물류 지원 업무협약'})
  ON CREATE SET n.type = 'Business Agreement', n.date = '2023-10-14', n.description = 'Agreement to support global logistics for exporting SMEs.', n.aliases = ["글로벌 물류 지원 업무협약"]
  ON MATCH  SET n.type = 'Business Agreement', n.date = '2023-10-14', n.description = 'Agreement to support global logistics for exporting SMEs.', n.aliases = ["글로벌 물류 지원 업무협약"];

MERGE (n:EVENT {name: '미국의 관세 정책'})
  ON CREATE SET n.date = '2023-03', n.type = 'Trade Policy', n.description = '미국의 25% 관세 부과', n.location = '미국', n.aliases = ["미국의 관세 정책"]
  ON MATCH  SET n.date = '2023-03', n.type = 'Trade Policy', n.description = '미국의 25% 관세 부과', n.location = '미국', n.aliases = ["미국의 관세 정책"];

MERGE (n:PERSON {name: '강석진'})
  ON CREATE SET n.full_name = '강석진', n.role = '이사장', n.nationality = 'South Korean', n.age = '', n.aliases = ["강석진"]
  ON MATCH  SET n.full_name = '강석진', n.role = '이사장', n.nationality = 'South Korean', n.age = '', n.aliases = ["강석진"];

MERGE (n:PERSON {name: '중진공'})
  ON CREATE SET n.role = '이사', n.aliases = ["중진공"]
  ON MATCH  SET n.role = '이사', n.aliases = ["중진공"];

MERGE (n:COMPANY {name: 'BPA'})
  ON CREATE SET n.aliases = ["BPA"]
  ON MATCH  SET n.aliases = ["BPA"];

MERGE (n:COMPANY {name: 'MOU'})
  ON CREATE SET n.aliases = ["MOU"]
  ON MATCH  SET n.aliases = ["MOU"];

MERGE (n:ORGANIZATION {name: '동반성장위원회'})
  ON CREATE SET n.aliases = ["동반성장위원회"], n.type = 'Public Organization', n.description = '중소기업 지원 및 상생협력 촉진', n.headquarters = '대한민국'
  ON MATCH  SET n.aliases = ["동반성장위원회"], n.type = 'Public Organization', n.description = '중소기업 지원 및 상생협력 촉진', n.headquarters = '대한민국';

MERGE (n:COMPANY {name: 'LG이노텍'})
  ON CREATE SET n.industry = '전자', n.aliases = ["LG이노텍"], n.headquarters = '서울', n.full_name = 'LG이노텍', n.founded = '', n.ceo = ''
  ON MATCH  SET n.industry = '전자', n.aliases = ["LG이노텍"], n.headquarters = '서울', n.full_name = 'LG이노텍', n.founded = '', n.ceo = '';

MERGE (n:COMPANY {name: '에이피텍'})
  ON CREATE SET n.industry = '제조', n.description = '핸드폰 카메라 모듈 생산에 필요한 제조설비를 공급', n.aliases = ["에이피텍"], n.headquarters = '인천 송도', n.full_name = '에이피텍', n.founded = '', n.ceo = ''
  ON MATCH  SET n.industry = '제조', n.description = '핸드폰 카메라 모듈 생산에 필요한 제조설비를 공급', n.aliases = ["에이피텍"], n.headquarters = '인천 송도', n.full_name = '에이피텍', n.founded = '', n.ceo = '';

MERGE (n:PERSON {name: '박치형'})
  ON CREATE SET n.role = '운영처장', n.aliases = ["박치형"], n.full_name = '박치형', n.nationality = 'South Korean', n.age = ''
  ON MATCH  SET n.role = '운영처장', n.aliases = ["박치형"], n.full_name = '박치형', n.nationality = 'South Korean', n.age = '';

MERGE (n:PERSON {name: '김준성'})
  ON CREATE SET n.role = '상무', n.aliases = ["김준성"], n.full_name = '김준성', n.nationality = 'South Korean', n.age = ''
  ON MATCH  SET n.role = '상무', n.aliases = ["김준성"], n.full_name = '김준성', n.nationality = 'South Korean', n.age = '';

MERGE (n:PERSON {name: '주재철'})
  ON CREATE SET n.role = '대표', n.aliases = ["주재철"]
  ON MATCH  SET n.role = '대표', n.aliases = ["주재철"];

MERGE (n:LOCATION {name: '인천 송도'})
  ON CREATE SET n.type = 'City', n.country = '대한민국', n.aliases = ["인천 송도"]
  ON MATCH  SET n.type = 'City', n.country = '대한민국', n.aliases = ["인천 송도"];

MERGE (n:AGREEMENT {name: '협력사 ESG 지원 업무협약'})
  ON CREATE SET n.type = 'Business Agreement', n.date = '2023-10-14', n.description = 'ESG 평가지표 공동 개발 및 협력사 지원', n.aliases = ["협력사 ESG 지원 업무협약"]
  ON MATCH  SET n.type = 'Business Agreement', n.date = '2023-10-14', n.description = 'ESG 평가지표 공동 개발 및 협력사 지원', n.aliases = ["협력사 ESG 지원 업무협약"];

MERGE (n:AWARD {name: 'ESG 우수 중소기업 확인서'})
  ON CREATE SET n.date = '', n.type = '인증', n.description = 'ESG 지표 준수율 83.0% 기록', n.aliases = ["ESG 우수 중소기업 확인서"]
  ON MATCH  SET n.date = '', n.type = '인증', n.description = 'ESG 지표 준수율 83.0% 기록', n.aliases = ["ESG 우수 중소기업 확인서"];

MERGE (n:PROJECT {name: '대·중소 자율형 ESG 지원사업'})
  ON CREATE SET n.description = 'ESG 지원 대상 협력사 확대', n.start_date = '2023', n.status = '진행 중', n.aliases = ["대·중소 자율형 ESG 지원사업"]
  ON MATCH  SET n.description = 'ESG 지원 대상 협력사 확대', n.start_date = '2023', n.status = '진행 중', n.aliases = ["대·중소 자율형 ESG 지원사업"];

MERGE (n:PERSON {name: '피텍등이참석'})
  ON CREATE SET n.role = '대표', n.aliases = ["피텍등이참석"]
  ON MATCH  SET n.role = '대표', n.aliases = ["피텍등이참석"];

MERGE (n:PERSON {name: '에이피텍'})
  ON CREATE SET n.role = '대표', n.aliases = ["에이피텍"]
  ON MATCH  SET n.role = '대표', n.aliases = ["에이피텍"];

MERGE (n:COMPANY {name: 'ESG'})
  ON CREATE SET n.aliases = ["ESG"]
  ON MATCH  SET n.aliases = ["ESG"];

MERGE (n:INDUSTRY {name: '화장품'})
  ON CREATE SET n.aliases = ["화장품"]
  ON MATCH  SET n.aliases = ["화장품"];

MERGE (n:INDUSTRY {name: '자동차'})
  ON CREATE SET n.aliases = ["자동차"]
  ON MATCH  SET n.aliases = ["자동차"];

MERGE (n:INDUSTRY {name: '반도체 제조용 장비'})
  ON CREATE SET n.aliases = ["반도체 제조용 장비"]
  ON MATCH  SET n.aliases = ["반도체 제조용 장비"];

MERGE (n:LOCATION {name: '미국'})
  ON CREATE SET n.type = 'Country', n.country = 'USA', n.region = '', n.aliases = ["미국"]
  ON MATCH  SET n.type = 'Country', n.country = 'USA', n.region = '', n.aliases = ["미국"];

MERGE (n:LOCATION {name: '중국'})
  ON CREATE SET n.type = 'Country', n.country = 'China', n.region = '', n.aliases = ["중국"]
  ON MATCH  SET n.type = 'Country', n.country = 'China', n.region = '', n.aliases = ["중국"];

MERGE (n:LOCATION {name: '일본'})
  ON CREATE SET n.type = 'Country', n.country = 'Japan', n.region = '', n.aliases = ["일본"]
  ON MATCH  SET n.type = 'Country', n.country = 'Japan', n.region = '', n.aliases = ["일본"];

MERGE (n:LOCATION {name: '홍콩'})
  ON CREATE SET n.type = 'Region', n.country = 'China', n.region = 'Hong Kong', n.aliases = ["홍콩"]
  ON MATCH  SET n.type = 'Region', n.country = 'China', n.region = 'Hong Kong', n.aliases = ["홍콩"];

MERGE (n:LOCATION {name: '대만'})
  ON CREATE SET n.type = 'Country', n.country = 'Taiwan', n.region = '', n.aliases = ["대만"]
  ON MATCH  SET n.type = 'Country', n.country = 'Taiwan', n.region = '', n.aliases = ["대만"];

MERGE (n:LOCATION {name: '태국'})
  ON CREATE SET n.type = 'Country', n.country = 'Thailand', n.region = '', n.aliases = ["태국"]
  ON MATCH  SET n.type = 'Country', n.country = 'Thailand', n.region = '', n.aliases = ["태국"];

MERGE (n:LOCATION {name: '인도네시아'})
  ON CREATE SET n.type = 'Country', n.country = 'Indonesia', n.region = '', n.aliases = ["인도네시아"]
  ON MATCH  SET n.type = 'Country', n.country = 'Indonesia', n.region = '', n.aliases = ["인도네시아"];

MERGE (n:LOCATION {name: '베트남'})
  ON CREATE SET n.type = 'Country', n.country = 'Vietnam', n.region = '', n.aliases = ["베트남"]
  ON MATCH  SET n.type = 'Country', n.country = 'Vietnam', n.region = '', n.aliases = ["베트남"];

MERGE (n:LOCATION {name: '인도'})
  ON CREATE SET n.type = 'Country', n.country = 'India', n.region = '', n.aliases = ["인도"]
  ON MATCH  SET n.type = 'Country', n.country = 'India', n.region = '', n.aliases = ["인도"];

MERGE (n:LOCATION {name: '멕시코'})
  ON CREATE SET n.type = 'Country', n.country = 'Mexico', n.region = '', n.aliases = ["멕시코"]
  ON MATCH  SET n.type = 'Country', n.country = 'Mexico', n.region = '', n.aliases = ["멕시코"];

MERGE (n:EVENT {name: '미국의 철강·알루미늄 및 파생 상품 관세부과'})
  ON CREATE SET n.date = '2023-03-12', n.type = 'Trade Policy', n.description = '미국의 철강·알루미늄 및 파생 상품에 대한 관세 부과', n.location = '미국', n.aliases = ["미국의 철강·알루미늄 및 파생 상품 관세부과"]
  ON MATCH  SET n.date = '2023-03-12', n.type = 'Trade Policy', n.description = '미국의 철강·알루미늄 및 파생 상품에 대한 관세 부과', n.location = '미국', n.aliases = ["미국의 철강·알루미늄 및 파생 상품 관세부과"];

MERGE (n:PERSON {name: '이순배'})
  ON CREATE SET n.full_name = '이순배', n.role = '글로벌성장정책관', n.nationality = 'South Korean', n.age = '', n.aliases = ["이순배"]
  ON MATCH  SET n.full_name = '이순배', n.role = '글로벌성장정책관', n.nationality = 'South Korean', n.age = '', n.aliases = ["이순배"];

MERGE (n:ORGANIZATION {name: '중소벤처기업부'})
  ON CREATE SET n.type = 'Government', n.description = '중소기업 및 벤처기업 지원을 담당하는 한국 정부 부처', n.headquarters = '서울, 대한민국', n.aliases = ["중소벤처기업부"]
  ON MATCH  SET n.type = 'Government', n.description = '중소기업 및 벤처기업 지원을 담당하는 한국 정부 부처', n.headquarters = '서울, 대한민국', n.aliases = ["중소벤처기업부"];

MERGE (n:LOCATION {name: '부산'})
  ON CREATE SET n.type = 'City', n.country = 'South Korea', n.region = 'Busan', n.aliases = ["부산"]
  ON MATCH  SET n.type = 'City', n.country = 'South Korea', n.region = 'Busan', n.aliases = ["부산"];

MERGE (n:LOCATION {name: '인천'})
  ON CREATE SET n.type = 'City', n.country = 'South Korea', n.region = 'Incheon', n.aliases = ["인천"]
  ON MATCH  SET n.type = 'City', n.country = 'South Korea', n.region = 'Incheon', n.aliases = ["인천"];

MERGE (n:LOCATION {name: '여수 광양'})
  ON CREATE SET n.type = 'City', n.country = 'South Korea', n.region = 'Jeollanam-do', n.aliases = ["여수 광양"]
  ON MATCH  SET n.type = 'City', n.country = 'South Korea', n.region = 'Jeollanam-do', n.aliases = ["여수 광양"];

MERGE (n:PROJECT {name: '스마트트레이드허브'})
  ON CREATE SET n.description = '오피스 기반의 B2B 인테리어 사업 확장', n.start_date = '2025', n.status = '진행 중', n.aliases = ["스마트트레이드허브"]
  ON MATCH  SET n.description = '오피스 기반의 B2B 인테리어 사업 확장', n.start_date = '2025', n.status = '진행 중', n.aliases = ["스마트트레이드허브"];

MERGE (n:COMPANY {name: '에이텀'})
  ON CREATE SET n.industry = '전자', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["에이텀"]
  ON MATCH  SET n.industry = '전자', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["에이텀"];

MERGE (n:COMPANY {name: 'DST'})
  ON CREATE SET n.industry = '조선 및 방산', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["DST"]
  ON MATCH  SET n.industry = '조선 및 방산', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["DST"];

MERGE (n:COMPANY {name: '밸류파인더'})
  ON CREATE SET n.industry = '리서치', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["밸류파인더"]
  ON MATCH  SET n.industry = '리서치', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["밸류파인더"];

MERGE (n:PERSON {name: '이충헌'})
  ON CREATE SET n.full_name = '이충헌', n.role = '연구원', n.nationality = 'South Korean', n.age = '', n.aliases = ["이충헌"]
  ON MATCH  SET n.full_name = '이충헌', n.role = '연구원', n.nationality = 'South Korean', n.age = '', n.aliases = ["이충헌"];

MERGE (n:COMPANY {name: 'Samsung'})
  ON CREATE SET n.industry = '전자', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["Samsung"]
  ON MATCH  SET n.industry = '전자', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["Samsung"];

MERGE (n:COMPANY {name: 'HD현대중공업'})
  ON CREATE SET n.industry = '조선', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["HD현대중공업"]
  ON MATCH  SET n.industry = '조선', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["HD현대중공업"];

MERGE (n:COMPANY {name: 'HD현대마린솔루션'})
  ON CREATE SET n.industry = '조선', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["HD현대마린솔루션"]
  ON MATCH  SET n.industry = '조선', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["HD현대마린솔루션"];

MERGE (n:COMPANY {name: 'STX엔진'})
  ON CREATE SET n.industry = '조선', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["STX엔진"]
  ON MATCH  SET n.industry = '조선', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["STX엔진"];

MERGE (n:PRODUCT {name: 'TA트랜스'})
  ON CREATE SET n.category = '전자', n.description = '휴대용 충전기에 탑재되는 트랜스', n.launch_date = '', n.company = '에이텀', n.aliases = ["TA트랜스"]
  ON MATCH  SET n.category = '전자', n.description = '휴대용 충전기에 탑재되는 트랜스', n.launch_date = '', n.company = '에이텀', n.aliases = ["TA트랜스"];

MERGE (n:PRODUCT {name: 'TV트랜스'})
  ON CREATE SET n.category = '전자', n.description = 'TV에 탑재되는 트랜스', n.launch_date = '', n.company = '에이텀', n.aliases = ["TV트랜스"]
  ON MATCH  SET n.category = '전자', n.description = 'TV에 탑재되는 트랜스', n.launch_date = '', n.company = '에이텀', n.aliases = ["TV트랜스"];

MERGE (n:PRODUCT {name: '전기차용 트랜스'})
  ON CREATE SET n.category = '전자', n.description = '전기차에 사용되는 트랜스', n.launch_date = '', n.company = '에이텀', n.aliases = ["전기차용 트랜스"]
  ON MATCH  SET n.category = '전자', n.description = '전기차에 사용되는 트랜스', n.launch_date = '', n.company = '에이텀', n.aliases = ["전기차용 트랜스"];

MERGE (n:PRODUCT {name: '힘센엔진 실린더'})
  ON CREATE SET n.category = '조선', n.description = '힘센엔진에 사용되는 실린더', n.launch_date = '', n.company = 'DST', n.aliases = ["힘센엔진 실린더"]
  ON MATCH  SET n.category = '조선', n.description = '힘센엔진에 사용되는 실린더', n.launch_date = '', n.company = 'DST', n.aliases = ["힘센엔진 실린더"];

MERGE (n:COMPANY {name: 'HiMSEN'})
  ON CREATE SET n.aliases = ["HiMSEN"]
  ON MATCH  SET n.aliases = ["HiMSEN"];

MERGE (n:COMPANY {name: '에이스침대'})
  ON CREATE SET n.industry = '가구', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["에이스침대"]
  ON MATCH  SET n.industry = '가구', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["에이스침대"];

MERGE (n:EVENT {name: '1분기 실적 발표'})
  ON CREATE SET n.date = '2023-04-14', n.type = 'Financial Report', n.description = '에이스침대의 1분기 매출 및 영업이익 발표', n.location = '', n.aliases = ["1분기 실적 발표"]
  ON MATCH  SET n.date = '2023-04-14', n.type = 'Financial Report', n.description = '에이스침대의 1분기 매출 및 영업이익 발표', n.location = '', n.aliases = ["1분기 실적 발표"];

MERGE (n:ORGANIZATION {name: '사람인'})
  ON CREATE SET n.type = 'Employment Platform', n.description = 'Conducts surveys and provides employment-related services.', n.headquarters = 'South Korea', n.aliases = ["사람인"]
  ON MATCH  SET n.type = 'Employment Platform', n.description = 'Conducts surveys and provides employment-related services.', n.headquarters = 'South Korea', n.aliases = ["사람인"];

MERGE (n:PERSON {name: '김혜미'})
  ON CREATE SET n.full_name = '김혜미', n.role = '기자', n.nationality = 'South Korean', n.age = '', n.aliases = ["김혜미"]
  ON MATCH  SET n.full_name = '김혜미', n.role = '기자', n.nationality = 'South Korean', n.age = '', n.aliases = ["김혜미"];

MERGE (n:EVENT {name: '인생 이모작 의향 조사'})
  ON CREATE SET n.date = '2023-10-14', n.type = 'Survey', n.description = 'Survey on the intention of career change after retirement.', n.location = 'South Korea', n.aliases = ["인생 이모작 의향 조사"]
  ON MATCH  SET n.date = '2023-10-14', n.type = 'Survey', n.description = 'Survey on the intention of career change after retirement.', n.location = 'South Korea', n.aliases = ["인생 이모작 의향 조사"];

MERGE (n:COMPANY {name: '신일전자'})
  ON CREATE SET n.industry = '전자', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["신일전자"]
  ON MATCH  SET n.industry = '전자', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["신일전자"];

MERGE (n:PRODUCT {name: 'BLDC 에어 서큘레이터 S10 SE'})
  ON CREATE SET n.category = '가전', n.description = '고성능·감성 디자인의 에어 서큘레이터', n.launch_date = '2023-04-14', n.company = '신일전자', n.aliases = ["BLDC 에어 서큘레이터 S10 SE"]
  ON MATCH  SET n.category = '가전', n.description = '고성능·감성 디자인의 에어 서큘레이터', n.launch_date = '2023-04-14', n.company = '신일전자', n.aliases = ["BLDC 에어 서큘레이터 S10 SE"];

MERGE (n:COMPANY {name: 'GS홈쇼핑'})
  ON CREATE SET n.industry = '커머스', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["GS홈쇼핑"]
  ON MATCH  SET n.industry = '커머스', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["GS홈쇼핑"];

MERGE (n:EVENT {name: '성유리 에디션 방송'})
  ON CREATE SET n.date = '2023-04-14', n.type = '홈쇼핑 방송', n.description = '신일전자 신제품 첫 선', n.location = '', n.aliases = ["성유리 에디션 방송"]
  ON MATCH  SET n.date = '2023-04-14', n.type = '홈쇼핑 방송', n.description = '신일전자 신제품 첫 선', n.location = '', n.aliases = ["성유리 에디션 방송"];

MERGE (n:COMPANY {name: 'BLDC'})
  ON CREATE SET n.aliases = ["BLDC"]
  ON MATCH  SET n.aliases = ["BLDC"];

MERGE (n:COMPANY {name: '센드버드'})
  ON CREATE SET n.industry = 'AI 에이전트 플랫폼', n.headquarters = '', n.founded = '', n.ceo = '김동신', n.aliases = ["센드버드"]
  ON MATCH  SET n.industry = 'AI 에이전트 플랫폼', n.headquarters = '', n.founded = '', n.ceo = '김동신', n.aliases = ["센드버드"];

MERGE (n:PERSON {name: '김동신'})
  ON CREATE SET n.full_name = '김동신', n.role = '대표', n.nationality = 'South Korean', n.age = '', n.aliases = ["김동신"]
  ON MATCH  SET n.full_name = '김동신', n.role = '대표', n.nationality = 'South Korean', n.age = '', n.aliases = ["김동신"];

MERGE (n:PRODUCT {name: '옴니프레젠트 AI 에이전트'})
  ON CREATE SET n.category = 'AI 에이전트', n.description = '프롬프트 없이 고객 행동을 예측해 응답하는 AI 에이전트', n.launch_date = '2023-10-14', n.company = '센드버드', n.aliases = ["옴니프레젠트 AI 에이전트"]
  ON MATCH  SET n.category = 'AI 에이전트', n.description = '프롬프트 없이 고객 행동을 예측해 응답하는 AI 에이전트', n.launch_date = '2023-10-14', n.company = '센드버드', n.aliases = ["옴니프레젠트 AI 에이전트"];

MERGE (n:INDUSTRY {name: '커머스'})
  ON CREATE SET n.aliases = ["커머스"]
  ON MATCH  SET n.aliases = ["커머스"];

MERGE (n:INDUSTRY {name: '핀테크'})
  ON CREATE SET n.aliases = ["핀테크"]
  ON MATCH  SET n.aliases = ["핀테크"];

MERGE (n:INDUSTRY {name: '리테일'})
  ON CREATE SET n.aliases = ["리테일"]
  ON MATCH  SET n.aliases = ["리테일"];

MERGE (n:PERSON {name: '버드'})
  ON CREATE SET n.role = '대표', n.aliases = ["버드"]
  ON MATCH  SET n.role = '대표', n.aliases = ["버드"];

MERGE (n:PERSON {name: '센드버드'})
  ON CREATE SET n.role = '대표', n.aliases = ["센드버드"]
  ON MATCH  SET n.role = '대표', n.aliases = ["센드버드"];

MERGE (n:COMPANY {name: 'FAQ'})
  ON CREATE SET n.aliases = ["FAQ"]
  ON MATCH  SET n.aliases = ["FAQ"];

MERGE (n:COMPANY {name: 'SNS'})
  ON CREATE SET n.aliases = ["SNS"]
  ON MATCH  SET n.aliases = ["SNS"];

MERGE (n:COMPANY {name: 'API'})
  ON CREATE SET n.aliases = ["API"]
  ON MATCH  SET n.aliases = ["API"];

MERGE (n:COMPANY {name: 'CRM'})
  ON CREATE SET n.aliases = ["CRM"]
  ON MATCH  SET n.aliases = ["CRM"];

MERGE (n:COMPANY {name: '가온아이'})
  ON CREATE SET n.full_name = '가온아이', n.industry = '소프트웨어', n.headquarters = '', n.founded = '', n.ceo = '조창제', n.aliases = ["가온아이"]
  ON MATCH  SET n.full_name = '가온아이', n.industry = '소프트웨어', n.headquarters = '', n.founded = '', n.ceo = '조창제', n.aliases = ["가온아이"];

MERGE (n:COMPANY {name: '아이서트'})
  ON CREATE SET n.full_name = '아이서트', n.industry = '소프트웨어', n.headquarters = '', n.founded = '', n.ceo = '현수환', n.aliases = ["아이서트"]
  ON MATCH  SET n.full_name = '아이서트', n.industry = '소프트웨어', n.headquarters = '', n.founded = '', n.ceo = '현수환', n.aliases = ["아이서트"];

MERGE (n:PRODUCT {name: '세이프아이서트'})
  ON CREATE SET n.category = '소프트웨어', n.description = '법인 공동인증서 관리 솔루션', n.launch_date = '', n.company = '아이서트', n.aliases = ["세이프아이서트"]
  ON MATCH  SET n.category = '소프트웨어', n.description = '법인 공동인증서 관리 솔루션', n.launch_date = '', n.company = '아이서트', n.aliases = ["세이프아이서트"];

MERGE (n:PERSON {name: '조창제'})
  ON CREATE SET n.full_name = '조창제', n.role = '대표', n.nationality = 'South Korean', n.age = '', n.aliases = ["조창제"]
  ON MATCH  SET n.full_name = '조창제', n.role = '대표', n.nationality = 'South Korean', n.age = '', n.aliases = ["조창제"];

MERGE (n:PERSON {name: '현수환'})
  ON CREATE SET n.full_name = '현수환', n.role = '대표', n.nationality = 'South Korean', n.age = '', n.aliases = ["현수환"]
  ON MATCH  SET n.full_name = '현수환', n.role = '대표', n.nationality = 'South Korean', n.age = '', n.aliases = ["현수환"];

MERGE (n:COMPANY {name: '한화오션디지털'})
  ON CREATE SET n.full_name = '한화오션디지털', n.industry = '디지털', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["한화오션디지털"]
  ON MATCH  SET n.full_name = '한화오션디지털', n.industry = '디지털', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["한화오션디지털"];

MERGE (n:COMPANY {name: 'Lg'})
  ON CREATE SET n.full_name = 'LG전자', n.industry = '전자', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["Lg"]
  ON MATCH  SET n.full_name = 'LG전자', n.industry = '전자', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["Lg"];

MERGE (n:PERSON {name: '조창'})
  ON CREATE SET n.role = '대표', n.aliases = ["조창"]
  ON MATCH  SET n.role = '대표', n.aliases = ["조창"];

MERGE (n:PERSON {name: '현수'})
  ON CREATE SET n.role = '대표', n.aliases = ["현수"]
  ON MATCH  SET n.role = '대표', n.aliases = ["현수"];

MERGE (n:PERSON {name: '아이'})
  ON CREATE SET n.role = '대표', n.aliases = ["아이"]
  ON MATCH  SET n.role = '대표', n.aliases = ["아이"];

MERGE (n:PERSON {name: '서트'})
  ON CREATE SET n.role = '대표', n.aliases = ["서트"]
  ON MATCH  SET n.role = '대표', n.aliases = ["서트"];

MERGE (n:PERSON {name: '가온아이'})
  ON CREATE SET n.role = '대표', n.aliases = ["가온아이"]
  ON MATCH  SET n.role = '대표', n.aliases = ["가온아이"];

MERGE (n:PERSON {name: '아이서트'})
  ON CREATE SET n.role = '대표', n.aliases = ["아이서트"]
  ON MATCH  SET n.role = '대표', n.aliases = ["아이서트"];

MERGE (n:COMPANY {name: 'SafeICert'})
  ON CREATE SET n.aliases = ["SafeICert"]
  ON MATCH  SET n.aliases = ["SafeICert"];

MERGE (n:COMPANY {name: 'SaaS'})
  ON CREATE SET n.aliases = ["SaaS"]
  ON MATCH  SET n.aliases = ["SaaS"];

MERGE (n:COMPANY {name: '엔씽'})
  ON CREATE SET n.full_name = '엔씽', n.industry = '스마트 수직농장', n.headquarters = '', n.founded = '2014', n.ceo = '김혜연', n.aliases = ["엔씽"]
  ON MATCH  SET n.full_name = '엔씽', n.industry = '스마트 수직농장', n.headquarters = '', n.founded = '2014', n.ceo = '김혜연', n.aliases = ["엔씽"];

MERGE (n:COMPANY {name: '이마트'})
  ON CREATE SET n.full_name = '이마트', n.industry = '유통', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["이마트"]
  ON MATCH  SET n.full_name = '이마트', n.industry = '유통', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["이마트"];

MERGE (n:COMPANY {name: '배달의민족'})
  ON CREATE SET n.full_name = '배달의민족', n.industry = '배달 서비스', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["배달의민족"]
  ON MATCH  SET n.full_name = '배달의민족', n.industry = '배달 서비스', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["배달의민족"];

MERGE (n:PROJECT {name: '물류센터형 수직농장 스마트팜 개발'})
  ON CREATE SET n.description = '1000억 규모 물류센터형 수직농장 스마트팜 개발', n.start_date = '2023', n.status = '진행 중', n.aliases = ["물류센터형 수직농장 스마트팜 개발"]
  ON MATCH  SET n.description = '1000억 규모 물류센터형 수직농장 스마트팜 개발', n.start_date = '2023', n.status = '진행 중', n.aliases = ["물류센터형 수직농장 스마트팜 개발"];

MERGE (n:LOCATION {name: '경기도 이천'})
  ON CREATE SET n.type = 'City', n.country = '대한민국', n.region = '경기도', n.aliases = ["경기도 이천"]
  ON MATCH  SET n.type = 'City', n.country = '대한민국', n.region = '경기도', n.aliases = ["경기도 이천"];

MERGE (n:PRODUCT {name: '큐브(CUBE)'})
  ON CREATE SET n.category = '스마트팜', n.description = '유기적 연결이 가능한 모듈형 스마트팜', n.launch_date = '2020', n.company = '엔씽', n.aliases = ["큐브(CUBE)"]
  ON MATCH  SET n.category = '스마트팜', n.description = '유기적 연결이 가능한 모듈형 스마트팜', n.launch_date = '2020', n.company = '엔씽', n.aliases = ["큐브(CUBE)"];

MERGE (n:AWARD {name: 'CES 최고혁신상'})
  ON CREATE SET n.date = '2020', n.type = '기술 혁신', n.description = 'CES에서 농업 분야 최초로 수상', n.aliases = ["CES 최고혁신상"]
  ON MATCH  SET n.date = '2020', n.type = '기술 혁신', n.description = 'CES에서 농업 분야 최초로 수상', n.aliases = ["CES 최고혁신상"];

MERGE (n:TECHNOLOGY {name: 'IoT 기반 환경 제어 기술'})
  ON CREATE SET n.category = '스마트팜', n.description = '온도, 습도, 광(LED), CO2, 수분, 양분 등 농장의 재배 환경을 실시간으로 확인·통제', n.field = '농업', n.aliases = ["IoT 기반 환경 제어 기술"]
  ON MATCH  SET n.category = '스마트팜', n.description = '온도, 습도, 광(LED), CO2, 수분, 양분 등 농장의 재배 환경을 실시간으로 확인·통제', n.field = '농업', n.aliases = ["IoT 기반 환경 제어 기술"];

MERGE (n:PERSON {name: '김혜연엔씽'})
  ON CREATE SET n.role = '대표', n.aliases = ["김혜연엔씽"]
  ON MATCH  SET n.role = '대표', n.aliases = ["김혜연엔씽"];

MERGE (n:PERSON {name: '엔씽'})
  ON CREATE SET n.role = '대표', n.aliases = ["엔씽"]
  ON MATCH  SET n.role = '대표', n.aliases = ["엔씽"];

MERGE (n:COMPANY {name: 'IPO'})
  ON CREATE SET n.aliases = ["IPO"]
  ON MATCH  SET n.aliases = ["IPO"];

MERGE (n:COMPANY {name: 'CUBE'})
  ON CREATE SET n.aliases = ["CUBE"]
  ON MATCH  SET n.aliases = ["CUBE"];

MERGE (n:COMPANY {name: 'TCB'})
  ON CREATE SET n.aliases = ["TCB"]
  ON MATCH  SET n.aliases = ["TCB"];

MERGE (n:COMPANY {name: 'Iot'})
  ON CREATE SET n.aliases = ["Iot"]
  ON MATCH  SET n.aliases = ["Iot"];

MERGE (n:COMPANY {name: 'LED'})
  ON CREATE SET n.aliases = ["LED"]
  ON MATCH  SET n.aliases = ["LED"];

MERGE (n:COMPANY {name: '엠투아이'})
  ON CREATE SET n.industry = '디지털전환 솔루션', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["엠투아이"]
  ON MATCH  SET n.industry = '디지털전환 솔루션', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["엠투아이"];

MERGE (n:COMPANY {name: '벰로보틱스'})
  ON CREATE SET n.industry = '산업용 물류로봇', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["벰로보틱스"]
  ON MATCH  SET n.industry = '산업용 물류로봇', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["벰로보틱스"];

MERGE (n:PRODUCT {name: '로봇 제어기'})
  ON CREATE SET n.category = '로봇', n.description = 'AMR/AGV의 두뇌 역할', n.launch_date = '', n.company = '', n.aliases = ["로봇 제어기"]
  ON MATCH  SET n.category = '로봇', n.description = 'AMR/AGV의 두뇌 역할', n.launch_date = '', n.company = '', n.aliases = ["로봇 제어기"];

MERGE (n:PROJECT {name: '물류로봇 프로젝트'})
  ON CREATE SET n.description = 'AMR/AGV 프로젝트 공동 수행', n.start_date = '', n.status = '진행 중', n.aliases = ["물류로봇 프로젝트"]
  ON MATCH  SET n.description = 'AMR/AGV 프로젝트 공동 수행', n.start_date = '', n.status = '진행 중', n.aliases = ["물류로봇 프로젝트"];

MERGE (n:AGREEMENT {name: '로봇 제어기 공동 개발 및 물류로봇 프로젝트 협약'})
  ON CREATE SET n.type = 'Business Agreement', n.date = '2023-10-14', n.description = '엠투아이와 벰로보틱스 간의 로봇 제어기 공동 개발 및 물류로봇 프로젝트 협약', n.aliases = ["로봇 제어기 공동 개발 및 물류로봇 프로젝트 협약"]
  ON MATCH  SET n.type = 'Business Agreement', n.date = '2023-10-14', n.description = '엠투아이와 벰로보틱스 간의 로봇 제어기 공동 개발 및 물류로봇 프로젝트 협약', n.aliases = ["로봇 제어기 공동 개발 및 물류로봇 프로젝트 협약"];

MERGE (n:INVESTMENT {name: '엠투아이의 벰로보틱스 지분투자'})
  ON CREATE SET n.amount = '12억원', n.date = '2023-10-14', n.type = '지분투자', n.aliases = ["엠투아이의 벰로보틱스 지분투자"]
  ON MATCH  SET n.amount = '12억원', n.date = '2023-10-14', n.type = '지분투자', n.aliases = ["엠투아이의 벰로보틱스 지분투자"];

MERGE (n:TECHNOLOGY {name: '디지털전환(DX) 솔루션'})
  ON CREATE SET n.category = '디지털전환', n.description = 'AI 자율 제조 시장을 선도하는 솔루션', n.field = '제조', n.aliases = ["디지털전환(DX) 솔루션"]
  ON MATCH  SET n.category = '디지털전환', n.description = 'AI 자율 제조 시장을 선도하는 솔루션', n.field = '제조', n.aliases = ["디지털전환(DX) 솔루션"];

MERGE (n:TECHNOLOGY {name: '위치측정 및 주행제어 기술'})
  ON CREATE SET n.category = '물류로봇', n.description = '물류로봇의 원천기술', n.field = '로봇', n.aliases = ["위치측정 및 주행제어 기술"]
  ON MATCH  SET n.category = '물류로봇', n.description = '물류로봇의 원천기술', n.field = '로봇', n.aliases = ["위치측정 및 주행제어 기술"];

MERGE (n:COMPANY {name: 'AMR'})
  ON CREATE SET n.aliases = ["AMR"]
  ON MATCH  SET n.aliases = ["AMR"];

MERGE (n:COMPANY {name: 'AGV'})
  ON CREATE SET n.aliases = ["AGV"]
  ON MATCH  SET n.aliases = ["AGV"];

MERGE (n:COMPANY {name: 'ACS'})
  ON CREATE SET n.aliases = ["ACS"]
  ON MATCH  SET n.aliases = ["ACS"];

MERGE (n:AGREEMENT {name: '업무 협약'})
  ON CREATE SET n.type = 'Business Agreement', n.date = '2023-03', n.description = 'Agreement between 소진공 and 롯데웰푸드 for 상생 프로젝트.', n.aliases = ["업무 협약"]
  ON MATCH  SET n.type = 'Business Agreement', n.date = '2023-03', n.description = 'Agreement between 소진공 and 롯데웰푸드 for 상생 프로젝트.', n.aliases = ["업무 협약"];

MERGE (n:PRODUCT {name: 'HMR'})
  ON CREATE SET n.category = '가정간편식', n.description = '소비자 대상 가구', n.launch_date = '', n.company = '롯데웰푸드', n.aliases = ["HMR"]
  ON MATCH  SET n.category = '가정간편식', n.description = '소비자 대상 가구', n.launch_date = '', n.company = '롯데웰푸드', n.aliases = ["HMR"];

MERGE (n:PRODUCT {name: '우수메뉴'})
  ON CREATE SET n.category = '음식', n.description = '백년가게의 우수 메뉴', n.launch_date = '', n.company = '롯데웰푸드', n.aliases = ["우수메뉴"]
  ON MATCH  SET n.category = '음식', n.description = '백년가게의 우수 메뉴', n.launch_date = '', n.company = '롯데웰푸드', n.aliases = ["우수메뉴"];

MERGE (n:COMPANY {name: '에이드로'})
  ON CREATE SET n.industry = '자동차', n.headquarters = '대한민국', n.founded = '', n.ceo = '윤승현', n.aliases = ["에이드로"]
  ON MATCH  SET n.industry = '자동차', n.headquarters = '대한민국', n.founded = '', n.ceo = '윤승현', n.aliases = ["에이드로"];

MERGE (n:PERSON {name: '윤승현'})
  ON CREATE SET n.full_name = '윤승현', n.role = '대표', n.nationality = 'South Korean', n.age = '', n.aliases = ["윤승현"]
  ON MATCH  SET n.full_name = '윤승현', n.role = '대표', n.nationality = 'South Korean', n.age = '', n.aliases = ["윤승현"];

MERGE (n:PERSON {name: '이용원'})
  ON CREATE SET n.full_name = '이용원', n.role = '최고디자인책임자', n.nationality = 'South Korean', n.age = '', n.aliases = ["이용원"]
  ON MATCH  SET n.full_name = '이용원', n.role = '최고디자인책임자', n.nationality = 'South Korean', n.age = '', n.aliases = ["이용원"];

MERGE (n:PERSON {name: '스콧비튼'})
  ON CREATE SET n.full_name = '스콧 비튼', n.role = '최고기술책임자', n.nationality = '', n.age = '', n.aliases = ["스콧비튼"]
  ON MATCH  SET n.full_name = '스콧 비튼', n.role = '최고기술책임자', n.nationality = '', n.age = '', n.aliases = ["스콧비튼"];

MERGE (n:PERSON {name: '유동완'})
  ON CREATE SET n.full_name = '유동완', n.role = '최고제품책임자', n.nationality = 'South Korean', n.age = '', n.aliases = ["유동완"]
  ON MATCH  SET n.full_name = '유동완', n.role = '최고제품책임자', n.nationality = 'South Korean', n.age = '', n.aliases = ["유동완"];

MERGE (n:PERSON {name: '윤반석'})
  ON CREATE SET n.full_name = '윤반석', n.role = '최고전략책임자', n.nationality = 'South Korean', n.age = '', n.aliases = ["윤반석"]
  ON MATCH  SET n.full_name = '윤반석', n.role = '최고전략책임자', n.nationality = 'South Korean', n.age = '', n.aliases = ["윤반석"];

MERGE (n:PRODUCT {name: '바디킷'})
  ON CREATE SET n.category = '자동차 부품', n.description = '공기역학 기반의 바디킷', n.launch_date = '', n.company = '에이드로', n.aliases = ["바디킷"]
  ON MATCH  SET n.category = '자동차 부품', n.description = '공기역학 기반의 바디킷', n.launch_date = '', n.company = '에이드로', n.aliases = ["바디킷"];

MERGE (n:PRODUCT {name: '에어로 옵티마이제이션 소프트웨어'})
  ON CREATE SET n.category = '소프트웨어', n.description = '공기역학 기반 차량 디자인·설계 프로세스 혁신', n.launch_date = '2023 Q3', n.company = '에이드로', n.aliases = ["에어로 옵티마이제이션 소프트웨어"]
  ON MATCH  SET n.category = '소프트웨어', n.description = '공기역학 기반 차량 디자인·설계 프로세스 혁신', n.launch_date = '2023 Q3', n.company = '에이드로', n.aliases = ["에어로 옵티마이제이션 소프트웨어"];

MERGE (n:COMPANY {name: 'Tesla'})
  ON CREATE SET n.industry = '자동차', n.headquarters = '미국', n.founded = '', n.ceo = '', n.aliases = ["Tesla"]
  ON MATCH  SET n.industry = '자동차', n.headquarters = '미국', n.founded = '', n.ceo = '', n.aliases = ["Tesla"];

MERGE (n:COMPANY {name: '현대'})
  ON CREATE SET n.industry = '자동차', n.headquarters = '대한민국', n.founded = '', n.ceo = '', n.aliases = ["현대"]
  ON MATCH  SET n.industry = '자동차', n.headquarters = '대한민국', n.founded = '', n.ceo = '', n.aliases = ["현대"];

MERGE (n:COMPANY {name: '기아'})
  ON CREATE SET n.industry = '자동차', n.headquarters = '대한민국', n.founded = '', n.ceo = '', n.aliases = ["기아"]
  ON MATCH  SET n.industry = '자동차', n.headquarters = '대한민국', n.founded = '', n.ceo = '', n.aliases = ["기아"];

MERGE (n:COMPANY {name: 'BMW'})
  ON CREATE SET n.industry = '자동차', n.headquarters = '독일', n.founded = '', n.ceo = '', n.aliases = ["BMW"]
  ON MATCH  SET n.industry = '자동차', n.headquarters = '독일', n.founded = '', n.ceo = '', n.aliases = ["BMW"];

MERGE (n:LOCATION {name: '독일'})
  ON CREATE SET n.type = 'Country', n.country = 'Germany', n.region = '', n.aliases = ["독일"]
  ON MATCH  SET n.type = 'Country', n.country = 'Germany', n.region = '', n.aliases = ["독일"];

MERGE (n:LOCATION {name: '말레이시아'})
  ON CREATE SET n.type = 'Country', n.country = 'Malaysia', n.region = '', n.aliases = ["말레이시아"]
  ON MATCH  SET n.type = 'Country', n.country = 'Malaysia', n.region = '', n.aliases = ["말레이시아"];

MERGE (n:LOCATION {name: '싱가포르'})
  ON CREATE SET n.type = 'Country', n.country = 'Singapore', n.region = '', n.aliases = ["싱가포르"]
  ON MATCH  SET n.type = 'Country', n.country = 'Singapore', n.region = '', n.aliases = ["싱가포르"];

MERGE (n:LOCATION {name: '영국'})
  ON CREATE SET n.type = 'Country', n.country = 'UK', n.region = '', n.aliases = ["영국"]
  ON MATCH  SET n.type = 'Country', n.country = 'UK', n.region = '', n.aliases = ["영국"];

MERGE (n:PERSON {name: '드로'})
  ON CREATE SET n.role = '대표', n.aliases = ["드로"]
  ON MATCH  SET n.role = '대표', n.aliases = ["드로"];

MERGE (n:PERSON {name: '는'})
  ON CREATE SET n.role = '대표', n.aliases = ["는"]
  ON MATCH  SET n.role = '대표', n.aliases = ["는"];

MERGE (n:PERSON {name: '는다른바디'})
  ON CREATE SET n.role = '대표', n.aliases = ["는다른바디"]
  ON MATCH  SET n.role = '대표', n.aliases = ["는다른바디"];

MERGE (n:PERSON {name: '에이드로'})
  ON CREATE SET n.role = '대표', n.aliases = ["에이드로"]
  ON MATCH  SET n.role = '대표', n.aliases = ["에이드로"];

MERGE (n:PERSON {name: '윤'})
  ON CREATE SET n.role = '대표', n.aliases = ["윤"]
  ON MATCH  SET n.role = '대표', n.aliases = ["윤"];

MERGE (n:COMPANY {name: 'Aerodynamics'})
  ON CREATE SET n.aliases = ["Aerodynamics"]
  ON MATCH  SET n.aliases = ["Aerodynamics"];

MERGE (n:COMPANY {name: 'ADRO'})
  ON CREATE SET n.aliases = ["ADRO"]
  ON MATCH  SET n.aliases = ["ADRO"];

MERGE (n:COMPANY {name: 'CFD'})
  ON CREATE SET n.aliases = ["CFD"]
  ON MATCH  SET n.aliases = ["CFD"];

MERGE (n:COMPANY {name: 'Computational Fluid Dynamics'})
  ON CREATE SET n.aliases = ["Computational Fluid Dynamics"]
  ON MATCH  SET n.aliases = ["Computational Fluid Dynamics"];

MERGE (n:COMPANY {name: 'BEV'})
  ON CREATE SET n.aliases = ["BEV"]
  ON MATCH  SET n.aliases = ["BEV"];

MERGE (n:COMPANY {name: 'ICE'})
  ON CREATE SET n.aliases = ["ICE"]
  ON MATCH  SET n.aliases = ["ICE"];

MERGE (n:COMPANY {name: 'HEV'})
  ON CREATE SET n.aliases = ["HEV"]
  ON MATCH  SET n.aliases = ["HEV"];

MERGE (n:COMPANY {name: 'CDO'})
  ON CREATE SET n.aliases = ["CDO"]
  ON MATCH  SET n.aliases = ["CDO"];

MERGE (n:COMPANY {name: 'CTO'})
  ON CREATE SET n.aliases = ["CTO"]
  ON MATCH  SET n.aliases = ["CTO"];

MERGE (n:COMPANY {name: 'CPO'})
  ON CREATE SET n.aliases = ["CPO"]
  ON MATCH  SET n.aliases = ["CPO"];

MERGE (n:COMPANY {name: 'CSO'})
  ON CREATE SET n.aliases = ["CSO"]
  ON MATCH  SET n.aliases = ["CSO"];

MERGE (n:COMPANY {name: 'TUV'})
  ON CREATE SET n.aliases = ["TUV"]
  ON MATCH  SET n.aliases = ["TUV"];

MERGE (n:COMPANY {name: 'AOS'})
  ON CREATE SET n.aliases = ["AOS"]
  ON MATCH  SET n.aliases = ["AOS"];

MERGE (n:COMPANY {name: '중소기업'})
  ON CREATE SET n.industry = '다양한', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["중소기업"]
  ON MATCH  SET n.industry = '다양한', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["중소기업"];

MERGE (n:EVENT {name: '미국의 철강·알루미늄 및 파생상품 관세부과'})
  ON CREATE SET n.date = '2023-03-12', n.type = 'Trade Policy', n.description = '미국의 25% 관세 부과', n.location = '미국', n.aliases = ["미국의 철강·알루미늄 및 파생상품 관세부과"]
  ON MATCH  SET n.date = '2023-03-12', n.type = 'Trade Policy', n.description = '미국의 25% 관세 부과', n.location = '미국', n.aliases = ["미국의 철강·알루미늄 및 파생상품 관세부과"];

MERGE (n:PRODUCT {name: '화장품'})
  ON CREATE SET n.category = '화장품', n.description = '소비자 대상 화장품', n.launch_date = '', n.company = '중소기업', n.aliases = ["화장품"]
  ON MATCH  SET n.category = '화장품', n.description = '소비자 대상 화장품', n.launch_date = '', n.company = '중소기업', n.aliases = ["화장품"];

MERGE (n:PRODUCT {name: '자동차'})
  ON CREATE SET n.category = '자동차', n.description = '소비자 대상 자동차', n.launch_date = '', n.company = '중소기업', n.aliases = ["자동차"]
  ON MATCH  SET n.category = '자동차', n.description = '소비자 대상 자동차', n.launch_date = '', n.company = '중소기업', n.aliases = ["자동차"];

MERGE (n:PRODUCT {name: '반도체 제조용 장비'})
  ON CREATE SET n.category = '장비', n.description = '반도체 제조에 필요한 장비', n.launch_date = '', n.company = '중소기업', n.aliases = ["반도체 제조용 장비"]
  ON MATCH  SET n.category = '장비', n.description = '반도체 제조에 필요한 장비', n.launch_date = '', n.company = '중소기업', n.aliases = ["반도체 제조용 장비"];

MERGE (n:PRODUCT {name: '철강 제품'})
  ON CREATE SET n.category = '철강', n.description = '철강 및 파생상품', n.launch_date = '', n.company = '중소기업', n.aliases = ["철강 제품"]
  ON MATCH  SET n.category = '철강', n.description = '철강 및 파생상품', n.launch_date = '', n.company = '중소기업', n.aliases = ["철강 제품"];

MERGE (n:PRODUCT {name: '알루미늄 제품'})
  ON CREATE SET n.category = '알루미늄', n.description = '알루미늄 및 파생상품', n.launch_date = '', n.company = '중소기업', n.aliases = ["알루미늄 제품"]
  ON MATCH  SET n.category = '알루미늄', n.description = '알루미늄 및 파생상품', n.launch_date = '', n.company = '중소기업', n.aliases = ["알루미늄 제품"];

MERGE (n:AGREEMENT {name: '협력사 ESG 지원사업 업무협약'})
  ON CREATE SET n.type = 'Business Agreement', n.date = '2023-09-14', n.description = 'Agreement to support ESG initiatives for partner companies.', n.aliases = ["협력사 ESG 지원사업 업무협약"]
  ON MATCH  SET n.type = 'Business Agreement', n.date = '2023-09-14', n.description = 'Agreement to support ESG initiatives for partner companies.', n.aliases = ["협력사 ESG 지원사업 업무협약"];

MERGE (n:PRODUCT {name: '핸드폰 카메라 모듈 생산 설비'})
  ON CREATE SET n.category = '제조설비', n.description = '설비 for producing mobile phone camera modules', n.company = '에이피텍', n.aliases = ["핸드폰 카메라 모듈 생산 설비"]
  ON MATCH  SET n.category = '제조설비', n.description = '설비 for producing mobile phone camera modules', n.company = '에이피텍', n.aliases = ["핸드폰 카메라 모듈 생산 설비"];

MERGE (n:AGREEMENT {name: '지식재산공제사업 활성화를 통한 공동발전 업무 협약'})
  ON CREATE SET n.type = 'Business Agreement', n.date = '2023-10-14', n.description = 'Agreement to enhance the intellectual property mutual aid project and support SMEs in Incheon.', n.aliases = ["지식재산공제사업 활성화를 통한 공동발전 업무 협약"]
  ON MATCH  SET n.type = 'Business Agreement', n.date = '2023-10-14', n.description = 'Agreement to enhance the intellectual property mutual aid project and support SMEs in Incheon.', n.aliases = ["지식재산공제사업 활성화를 통한 공동발전 업무 협약"];

MERGE (n:COMPANY {name: '와디즈'})
  ON CREATE SET n.industry = '펀딩 플랫폼', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["와디즈"]
  ON MATCH  SET n.industry = '펀딩 플랫폼', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["와디즈"];

MERGE (n:REPORT {name: '2025 글로벌 소비자 트렌드 리포트'})
  ON CREATE SET n.date = '', n.type = '소비자 트렌드', n.description = '다각형 소비를 정의', n.location = '', n.aliases = ["2025 글로벌 소비자 트렌드 리포트"]
  ON MATCH  SET n.date = '', n.type = '소비자 트렌드', n.description = '다각형 소비를 정의', n.location = '', n.aliases = ["2025 글로벌 소비자 트렌드 리포트"];

MERGE (n:PRODUCT {name: '뉴에어론 풀 체어'})
  ON CREATE SET n.category = '가구', n.description = '고급 오피스 체어', n.launch_date = '', n.company = '허먼밀러', n.aliases = ["뉴에어론 풀 체어"]
  ON MATCH  SET n.category = '가구', n.description = '고급 오피스 체어', n.launch_date = '', n.company = '허먼밀러', n.aliases = ["뉴에어론 풀 체어"];

MERGE (n:PRODUCT {name: '쿠자 멀티핸들 스텐팬'})
  ON CREATE SET n.category = '주방용품', n.description = '명품 스테인리스 사용', n.launch_date = '', n.company = '', n.aliases = ["쿠자 멀티핸들 스텐팬"]
  ON MATCH  SET n.category = '주방용품', n.description = '명품 스테인리스 사용', n.launch_date = '', n.company = '', n.aliases = ["쿠자 멀티핸들 스텐팬"];

MERGE (n:PRODUCT {name: '올리젯 청바지'})
  ON CREATE SET n.category = '패션', n.description = '이탈리아산 프리미엄 데님 원단 사용', n.launch_date = '', n.company = '', n.aliases = ["올리젯 청바지"]
  ON MATCH  SET n.category = '패션', n.description = '이탈리아산 프리미엄 데님 원단 사용', n.launch_date = '', n.company = '', n.aliases = ["올리젯 청바지"];

MERGE (n:PRODUCT {name: '고급 매트리스'})
  ON CREATE SET n.category = '가구', n.description = '숙면 연구 기반', n.launch_date = '', n.company = '', n.aliases = ["고급 매트리스"]
  ON MATCH  SET n.category = '가구', n.description = '숙면 연구 기반', n.launch_date = '', n.company = '', n.aliases = ["고급 매트리스"];

MERGE (n:PRODUCT {name: '호텔급 낮잠이불'})
  ON CREATE SET n.category = '가구', n.description = '호텔급 품질', n.launch_date = '', n.company = '', n.aliases = ["호텔급 낮잠이불"]
  ON MATCH  SET n.category = '가구', n.description = '호텔급 품질', n.launch_date = '', n.company = '', n.aliases = ["호텔급 낮잠이불"];

MERGE (n:PERSON {name: '황지현'})
  ON CREATE SET n.full_name = '황지현', n.role = '기자', n.nationality = 'South Korean', n.age = '', n.aliases = ["황지현"]
  ON MATCH  SET n.full_name = '황지현', n.role = '기자', n.nationality = 'South Korean', n.age = '', n.aliases = ["황지현"];

MERGE (n:COMPANY {name: '셀트리온'})
  ON CREATE SET n.industry = '제약', n.headquarters = '대한민국', n.founded = '', n.ceo = '', n.aliases = ["셀트리온"]
  ON MATCH  SET n.industry = '제약', n.headquarters = '대한민국', n.founded = '', n.ceo = '', n.aliases = ["셀트리온"];

MERGE (n:LOCATION {name: '스페인'})
  ON CREATE SET n.type = 'Country', n.country = '스페인', n.aliases = ["스페인"]
  ON MATCH  SET n.type = 'Country', n.country = '스페인', n.aliases = ["스페인"];

MERGE (n:LOCATION {name: '포르투갈'})
  ON CREATE SET n.type = 'Country', n.country = '포르투갈', n.aliases = ["포르투갈"]
  ON MATCH  SET n.type = 'Country', n.country = '포르투갈', n.aliases = ["포르투갈"];

MERGE (n:PRODUCT {name: '트룩시마'})
  ON CREATE SET n.category = '항암제', n.description = '성분명 리툭시맙', n.company = '셀트리온', n.launch_date = '2019', n.aliases = ["트룩시마"]
  ON MATCH  SET n.category = '항암제', n.description = '성분명 리툭시맙', n.company = '셀트리온', n.launch_date = '2019', n.aliases = ["트룩시마"];

MERGE (n:PRODUCT {name: '허쥬마'})
  ON CREATE SET n.category = '항암제', n.description = '성분명 트라스투주맙', n.company = '셀트리온', n.aliases = ["허쥬마"]
  ON MATCH  SET n.category = '항암제', n.description = '성분명 트라스투주맙', n.company = '셀트리온', n.aliases = ["허쥬마"];

MERGE (n:PRODUCT {name: '베그젤마'})
  ON CREATE SET n.category = '항암제', n.description = '성분명 베바시주맙', n.company = '셀트리온', n.aliases = ["베그젤마"], n.launch_date = ''
  ON MATCH  SET n.category = '항암제', n.description = '성분명 베바시주맙', n.company = '셀트리온', n.aliases = ["베그젤마"], n.launch_date = '';

MERGE (n:PRODUCT {name: '스테키마'})
  ON CREATE SET n.category = '자가면역질환 치료제', n.description = '성분명 우스테키누맙', n.company = '셀트리온', n.aliases = ["스테키마"]
  ON MATCH  SET n.category = '자가면역질환 치료제', n.description = '성분명 우스테키누맙', n.company = '셀트리온', n.aliases = ["스테키마"];

MERGE (n:PRODUCT {name: '앱토즈마'})
  ON CREATE SET n.category = '신규 항암제', n.description = '성분명 토실리주맙', n.company = '셀트리온', n.aliases = ["앱토즈마"]
  ON MATCH  SET n.category = '신규 항암제', n.description = '성분명 토실리주맙', n.company = '셀트리온', n.aliases = ["앱토즈마"];

MERGE (n:PERSON {name: '강석훈'})
  ON CREATE SET n.full_name = '강석훈', n.role = '법인장', n.nationality = 'South Korean', n.aliases = ["강석훈"]
  ON MATCH  SET n.full_name = '강석훈', n.role = '법인장', n.nationality = 'South Korean', n.aliases = ["강석훈"];

MERGE (n:PROJECT {name: '스페인 및 포르투갈 직판 전환'})
  ON CREATE SET n.description = '스페인 및 포르투갈에서의 직판 체제 구축', n.start_date = '2023', n.status = '진행 중', n.aliases = ["스페인 및 포르투갈 직판 전환"]
  ON MATCH  SET n.description = '스페인 및 포르투갈에서의 직판 체제 구축', n.start_date = '2023', n.status = '진행 중', n.aliases = ["스페인 및 포르투갈 직판 전환"];

MERGE (n:PERSON {name: '유럽내'})
  ON CREATE SET n.role = '대표', n.aliases = ["유럽내"]
  ON MATCH  SET n.role = '대표', n.aliases = ["유럽내"];

MERGE (n:PERSON {name: '내'})
  ON CREATE SET n.role = '대표', n.aliases = ["내"]
  ON MATCH  SET n.role = '대표', n.aliases = ["내"];

MERGE (n:COMPANY {name: 'CSC'})
  ON CREATE SET n.aliases = ["CSC"]
  ON MATCH  SET n.aliases = ["CSC"];

MERGE (n:COMPANY {name: 'IQVIA'})
  ON CREATE SET n.aliases = ["IQVIA"]
  ON MATCH  SET n.aliases = ["IQVIA"];

MERGE (n:COMPANY {name: '삼성바이오로직스'})
  ON CREATE SET n.industry = '바이오', n.headquarters = '대한민국', n.founded = '', n.ceo = '', n.aliases = ["삼성바이오로직스"]
  ON MATCH  SET n.industry = '바이오', n.headquarters = '대한민국', n.founded = '', n.ceo = '', n.aliases = ["삼성바이오로직스"];

MERGE (n:EVENT {name: '미국 의약품 관세 부과'})
  ON CREATE SET n.date = '2023', n.type = 'Trade Policy', n.description = '미국의 의약품에 대한 관세 부과 정책', n.location = '미국', n.aliases = ["미국 의약품 관세 부과"]
  ON MATCH  SET n.date = '2023', n.type = 'Trade Policy', n.description = '미국의 의약품에 대한 관세 부과 정책', n.location = '미국', n.aliases = ["미국 의약품 관세 부과"];

MERGE (n:PRODUCT {name: '램시마'})
  ON CREATE SET n.category = '바이오시밀러', n.description = '셀트리온의 바이오시밀러 제품', n.launch_date = '2019', n.company = '셀트리온', n.aliases = ["램시마"]
  ON MATCH  SET n.category = '바이오시밀러', n.description = '셀트리온의 바이오시밀러 제품', n.launch_date = '2019', n.company = '셀트리온', n.aliases = ["램시마"];

MERGE (n:PRODUCT {name: '옴리클로'})
  ON CREATE SET n.category = '바이오시밀러', n.description = '셀트리온의 신규 바이오시밀러 제품', n.launch_date = '2023 하반기', n.company = '셀트리온', n.aliases = ["옴리클로"]
  ON MATCH  SET n.category = '바이오시밀러', n.description = '셀트리온의 신규 바이오시밀러 제품', n.launch_date = '2023 하반기', n.company = '셀트리온', n.aliases = ["옴리클로"];

MERGE (n:PRODUCT {name: '아이덴젤트'})
  ON CREATE SET n.category = '바이오시밀러', n.description = '셀트리온의 신규 바이오시밀러 제품', n.launch_date = '2023 하반기', n.company = '셀트리온', n.aliases = ["아이덴젤트"]
  ON MATCH  SET n.category = '바이오시밀러', n.description = '셀트리온의 신규 바이오시밀러 제품', n.launch_date = '2023 하반기', n.company = '셀트리온', n.aliases = ["아이덴젤트"];

MERGE (n:EVENT {name: '약가인하 행정명령'})
  ON CREATE SET n.date = '2023-12-12', n.type = 'Policy', n.description = '트럼프 대통령이 서명한 약가인하 행정명령', n.location = '미국', n.aliases = ["약가인하 행정명령"]
  ON MATCH  SET n.date = '2023-12-12', n.type = 'Policy', n.description = '트럼프 대통령이 서명한 약가인하 행정명령', n.location = '미국', n.aliases = ["약가인하 행정명령"];

MERGE (n:COMPANY {name: 'CMO'})
  ON CREATE SET n.aliases = ["CMO"]
  ON MATCH  SET n.aliases = ["CMO"];

MERGE (n:COMPANY {name: '노루그룹'})
  ON CREATE SET n.industry = '화학', n.headquarters = '안양', n.founded = '', n.ceo = '', n.aliases = ["노루그룹"]
  ON MATCH  SET n.industry = '화학', n.headquarters = '안양', n.founded = '', n.ceo = '', n.aliases = ["노루그룹"];

MERGE (n:COMPANY {name: '노루페인트'})
  ON CREATE SET n.industry = '페인트', n.headquarters = '안양', n.founded = '', n.ceo = '', n.aliases = ["노루페인트"]
  ON MATCH  SET n.industry = '페인트', n.headquarters = '안양', n.founded = '', n.ceo = '', n.aliases = ["노루페인트"];

MERGE (n:EVENT {name: '2025 신기술·신제품 전시회'})
  ON CREATE SET n.date = '2023-09-14 to 2023-09-18', n.type = 'Exhibition', n.description = '노루그룹의 혁신 기술과 차세대 제품을 선보이는 전시회', n.location = '안양', n.aliases = ["2025 신기술·신제품 전시회"]
  ON MATCH  SET n.date = '2023-09-14 to 2023-09-18', n.type = 'Exhibition', n.description = '노루그룹의 혁신 기술과 차세대 제품을 선보이는 전시회', n.location = '안양', n.aliases = ["2025 신기술·신제품 전시회"];

MERGE (n:PERSON {name: '방양국'})
  ON CREATE SET n.full_name = '방양국', n.role = '연구소장', n.nationality = 'South Korean', n.age = '', n.aliases = ["방양국"]
  ON MATCH  SET n.full_name = '방양국', n.role = '연구소장', n.nationality = 'South Korean', n.age = '', n.aliases = ["방양국"];

MERGE (n:PRODUCT {name: '스텔스 도료'})
  ON CREATE SET n.category = '도료', n.description = '경량화를 극대화한 도료', n.launch_date = '', n.company = '노루그룹', n.aliases = ["스텔스 도료"]
  ON MATCH  SET n.category = '도료', n.description = '경량화를 극대화한 도료', n.launch_date = '', n.company = '노루그룹', n.aliases = ["스텔스 도료"];

MERGE (n:PRODUCT {name: '우레탄 난연 몰딩제'})
  ON CREATE SET n.category = '배터리', n.description = '친환경·고성능 배터리 시장을 겨냥한 몰딩제', n.launch_date = '', n.company = '노루그룹', n.aliases = ["우레탄 난연 몰딩제"]
  ON MATCH  SET n.category = '배터리', n.description = '친환경·고성능 배터리 시장을 겨냥한 몰딩제', n.launch_date = '', n.company = '노루그룹', n.aliases = ["우레탄 난연 몰딩제"];

MERGE (n:PRODUCT {name: '탄소 저감 건재용 도료'})
  ON CREATE SET n.category = '도료', n.description = '탄소 저감 건재용 도료', n.launch_date = '', n.company = '노루그룹', n.aliases = ["탄소 저감 건재용 도료"]
  ON MATCH  SET n.category = '도료', n.description = '탄소 저감 건재용 도료', n.launch_date = '', n.company = '노루그룹', n.aliases = ["탄소 저감 건재용 도료"];

MERGE (n:PRODUCT {name: 'VOC 저감형 아크릴 수지'})
  ON CREATE SET n.category = '수지', n.description = 'VOC 저감형 아크릴 수지', n.launch_date = '', n.company = '노루그룹', n.aliases = ["VOC 저감형 아크릴 수지"]
  ON MATCH  SET n.category = '수지', n.description = 'VOC 저감형 아크릴 수지', n.launch_date = '', n.company = '노루그룹', n.aliases = ["VOC 저감형 아크릴 수지"];

MERGE (n:LOCATION {name: '안양'})
  ON CREATE SET n.type = 'City', n.country = 'South Korea', n.region = 'Gyeonggi-do', n.aliases = ["안양"]
  ON MATCH  SET n.type = 'City', n.country = 'South Korea', n.region = 'Gyeonggi-do', n.aliases = ["안양"];

MERGE (n:PERSON {name: '섹션은제품'})
  ON CREATE SET n.role = '대표', n.aliases = ["섹션은제품"]
  ON MATCH  SET n.role = '대표', n.aliases = ["섹션은제품"];

MERGE (n:PERSON {name: '섹션은'})
  ON CREATE SET n.role = '대표', n.aliases = ["섹션은"]
  ON MATCH  SET n.role = '대표', n.aliases = ["섹션은"];

MERGE (n:COMPANY {name: 'VOC'})
  ON CREATE SET n.aliases = ["VOC"]
  ON MATCH  SET n.aliases = ["VOC"];

MERGE (n:ORGANIZATION {name: 'CSC'})
  ON CREATE SET n.type = '입찰 기관', n.description = '스페인 대형 입찰 기관 중 하나로 카탈루냐주에 위치한 25개 공립병원의 의약품 공급을 관할', n.aliases = ["CSC"]
  ON MATCH  SET n.type = '입찰 기관', n.description = '스페인 대형 입찰 기관 중 하나로 카탈루냐주에 위치한 25개 공립병원의 의약품 공급을 관할', n.aliases = ["CSC"];

MERGE (n:COMPANY {name: 'Kern Pharma'})
  ON CREATE SET n.aliases = ["Kern Pharma"]
  ON MATCH  SET n.aliases = ["Kern Pharma"];

MERGE (n:EVENT {name: '미국 관세 조치'})
  ON CREATE SET n.date = '2023-03', n.type = 'Trade Policy', n.description = '미국의 25% 관세 부과', n.location = '미국', n.aliases = ["미국 관세 조치"]
  ON MATCH  SET n.date = '2023-03', n.type = 'Trade Policy', n.description = '미국의 25% 관세 부과', n.location = '미국', n.aliases = ["미국 관세 조치"];

MERGE (n:PRODUCT {name: '반도체제조용장비'})
  ON CREATE SET n.category = '가구', n.description = '소비자 대상 가구', n.launch_date = '', n.company = '', n.aliases = ["반도체제조용장비"]
  ON MATCH  SET n.category = '가구', n.description = '소비자 대상 가구', n.launch_date = '', n.company = '', n.aliases = ["반도체제조용장비"];

MERGE (n:PRODUCT {name: '기타기계류'})
  ON CREATE SET n.category = '가구', n.description = '소비자 대상 가구', n.launch_date = '', n.company = '', n.aliases = ["기타기계류"]
  ON MATCH  SET n.category = '가구', n.description = '소비자 대상 가구', n.launch_date = '', n.company = '', n.aliases = ["기타기계류"];

MERGE (n:PRODUCT {name: '전자응용기기'})
  ON CREATE SET n.category = '가구', n.description = '소비자 대상 가구', n.launch_date = '', n.company = '', n.aliases = ["전자응용기기"]
  ON MATCH  SET n.category = '가구', n.description = '소비자 대상 가구', n.launch_date = '', n.company = '', n.aliases = ["전자응용기기"];

MERGE (n:EVENT {name: '미국 철강·알루미늄 및 파생상품 관세부과'})
  ON CREATE SET n.date = '2023-03-12', n.type = 'Trade Policy', n.description = '미국의 철강 및 알루미늄 제품에 대한 관세 부과', n.location = '미국', n.aliases = ["미국 철강·알루미늄 및 파생상품 관세부과"]
  ON MATCH  SET n.date = '2023-03-12', n.type = 'Trade Policy', n.description = '미국의 철강 및 알루미늄 제품에 대한 관세 부과', n.location = '미국', n.aliases = ["미국 철강·알루미늄 및 파생상품 관세부과"];

MERGE (n:COMPANY {name: '락앤락'})
  ON CREATE SET n.industry = '글로벌 생활용품', n.headquarters = '서울', n.founded = '', n.ceo = '', n.aliases = ["락앤락"]
  ON MATCH  SET n.industry = '글로벌 생활용품', n.headquarters = '서울', n.founded = '', n.ceo = '', n.aliases = ["락앤락"];

MERGE (n:PRODUCT {name: '풀히트 푸드워머'})
  ON CREATE SET n.category = '테이블웨어', n.description = '바닥 전체에 열선이 내장되어 10초 내 예열되는 푸드워머', n.launch_date = '2023-10-14', n.company = '락앤락', n.aliases = ["풀히트 푸드워머"]
  ON MATCH  SET n.category = '테이블웨어', n.description = '바닥 전체에 열선이 내장되어 10초 내 예열되는 푸드워머', n.launch_date = '2023-10-14', n.company = '락앤락', n.aliases = ["풀히트 푸드워머"];

MERGE (n:LOCATION {name: '서울'})
  ON CREATE SET n.type = 'City', n.country = '대한민국', n.region = '', n.aliases = ["서울"]
  ON MATCH  SET n.type = 'City', n.country = '대한민국', n.region = '', n.aliases = ["서울"];

MERGE (n:PERSON {name: '신송남'})
  ON CREATE SET n.role = '작업자', n.age = '61', n.aliases = ["신송남"]
  ON MATCH  SET n.role = '작업자', n.age = '61', n.aliases = ["신송남"];

MERGE (n:PERSON {name: '김대환'})
  ON CREATE SET n.role = '공장장', n.age = '66', n.aliases = ["김대환"]
  ON MATCH  SET n.role = '공장장', n.age = '66', n.aliases = ["김대환"];

MERGE (n:PERSON {name: '김두연'})
  ON CREATE SET n.role = '고무 프레스 담당', n.age = '71', n.aliases = ["김두연"]
  ON MATCH  SET n.role = '고무 프레스 담당', n.age = '71', n.aliases = ["김두연"];

MERGE (n:PERSON {name: '방광호'})
  ON CREATE SET n.role = '지게차 기사', n.age = '60', n.aliases = ["방광호"]
  ON MATCH  SET n.role = '지게차 기사', n.age = '60', n.aliases = ["방광호"];

MERGE (n:PERSON {name: '정광용'})
  ON CREATE SET n.role = '대표', n.aliases = ["정광용"]
  ON MATCH  SET n.role = '대표', n.aliases = ["정광용"];

MERGE (n:PERSON {name: '조주현'})
  ON CREATE SET n.role = '원장', n.aliases = ["조주현"]
  ON MATCH  SET n.role = '원장', n.aliases = ["조주현"];

MERGE (n:COMPANY {name: '정일산업'})
  ON CREATE SET n.full_name = '정일산업', n.industry = '승강기 제조업', n.headquarters = '경기도 시화공단', n.founded = '1987', n.ceo = '정광용', n.aliases = ["정일산업"]
  ON MATCH  SET n.full_name = '정일산업', n.industry = '승강기 제조업', n.headquarters = '경기도 시화공단', n.founded = '1987', n.ceo = '정광용', n.aliases = ["정일산업"];

MERGE (n:ORGANIZATION {name: '중소벤처기업연구원'})
  ON CREATE SET n.aliases = ["중소벤처기업연구원"]
  ON MATCH  SET n.aliases = ["중소벤처기업연구원"];

MERGE (n:LOCATION {name: '경기도 시화공단'})
  ON CREATE SET n.type = 'Industrial Complex', n.country = '대한민국', n.region = '경기도', n.aliases = ["경기도 시화공단"]
  ON MATCH  SET n.type = 'Industrial Complex', n.country = '대한민국', n.region = '경기도', n.aliases = ["경기도 시화공단"];

MERGE (n:LOCATION {name: '충북 충주'})
  ON CREATE SET n.type = 'City', n.country = '대한민국', n.region = '충청북도', n.aliases = ["충북 충주"]
  ON MATCH  SET n.type = 'City', n.country = '대한민국', n.region = '충청북도', n.aliases = ["충북 충주"];

MERGE (n:PERSON {name: '정일산업'})
  ON CREATE SET n.role = '대표', n.aliases = ["정일산업"]
  ON MATCH  SET n.role = '대표', n.aliases = ["정일산업"];

MERGE (n:PERSON {name: '의방침'})
  ON CREATE SET n.role = '대표', n.aliases = ["의방침"]
  ON MATCH  SET n.role = '대표', n.aliases = ["의방침"];

MERGE (n:PERSON {name: '다는게정'})
  ON CREATE SET n.role = '대표', n.aliases = ["다는게정"]
  ON MATCH  SET n.role = '대표', n.aliases = ["다는게정"];

MERGE (n:PERSON {name: '정'})
  ON CREATE SET n.role = '대표', n.aliases = ["정"]
  ON MATCH  SET n.role = '대표', n.aliases = ["정"];

MERGE (n:COMPANY {name: '패스트파이브'})
  ON CREATE SET n.industry = '클라우드 및 IT 솔루션', n.headquarters = '서울', n.founded = '', n.ceo = '김대일', n.aliases = ["패스트파이브"]
  ON MATCH  SET n.industry = '클라우드 및 IT 솔루션', n.headquarters = '서울', n.founded = '', n.ceo = '김대일', n.aliases = ["패스트파이브"];

MERGE (n:PRODUCT {name: '파이브클라우드'})
  ON CREATE SET n.category = '클라우드 및 IT 솔루션', n.description = '중소·중견기업 맞춤형 클라우드 및 IT 솔루션 통합 서비스', n.launch_date = '', n.company = '패스트파이브', n.aliases = ["파이브클라우드"]
  ON MATCH  SET n.category = '클라우드 및 IT 솔루션', n.description = '중소·중견기업 맞춤형 클라우드 및 IT 솔루션 통합 서비스', n.launch_date = '', n.company = '패스트파이브', n.aliases = ["파이브클라우드"];

MERGE (n:PRODUCT {name: '인테리어코드'})
  ON CREATE SET n.category = '인테리어 솔루션', n.description = '패스트파이브의 인테리어 전문 브랜드 \'하이픈디자인\'과 협력한 통합 서비스', n.launch_date = '', n.company = '패스트파이브', n.aliases = ["인테리어코드"]
  ON MATCH  SET n.category = '인테리어 솔루션', n.description = '패스트파이브의 인테리어 전문 브랜드 \'하이픈디자인\'과 협력한 통합 서비스', n.launch_date = '', n.company = '패스트파이브', n.aliases = ["인테리어코드"];

MERGE (n:AWARD {name: 'AWS 한국파트너리그 수상'})
  ON CREATE SET n.date = '', n.type = '기술 내재화 및 고객 맞춤 실행력', n.description = 'AWS 한국파트너리그에서 3회 연속 수상', n.aliases = ["AWS 한국파트너리그 수상"]
  ON MATCH  SET n.date = '', n.type = '기술 내재화 및 고객 맞춤 실행력', n.description = 'AWS 한국파트너리그에서 3회 연속 수상', n.aliases = ["AWS 한국파트너리그 수상"];

MERGE (n:COMPANY {name: '아마존웹서비스'})
  ON CREATE SET n.industry = '클라우드', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["아마존웹서비스"]
  ON MATCH  SET n.industry = '클라우드', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["아마존웹서비스"];

MERGE (n:COMPANY {name: 'Google'})
  ON CREATE SET n.industry = '클라우드', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["Google"]
  ON MATCH  SET n.industry = '클라우드', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["Google"];

MERGE (n:COMPANY {name: 'Microsoft'})
  ON CREATE SET n.industry = '클라우드', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["Microsoft"]
  ON MATCH  SET n.industry = '클라우드', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["Microsoft"];

MERGE (n:PERSON {name: '김대일'})
  ON CREATE SET n.full_name = '김대일', n.role = '대표', n.nationality = 'South Korean', n.age = '', n.aliases = ["김대일"]
  ON MATCH  SET n.full_name = '김대일', n.role = '대표', n.nationality = 'South Korean', n.age = '', n.aliases = ["김대일"];

MERGE (n:PERSON {name: '트파이브'})
  ON CREATE SET n.role = '대표', n.aliases = ["트파이브"]
  ON MATCH  SET n.role = '대표', n.aliases = ["트파이브"];

MERGE (n:PERSON {name: '패스트파이브'})
  ON CREATE SET n.role = '대표', n.aliases = ["패스트파이브"]
  ON MATCH  SET n.role = '대표', n.aliases = ["패스트파이브"];

MERGE (n:COMPANY {name: 'AWS'})
  ON CREATE SET n.aliases = ["AWS"]
  ON MATCH  SET n.aliases = ["AWS"];

MERGE (n:PERSON {name: '김동선'})
  ON CREATE SET n.full_name = '김동선', n.role = '부사장', n.nationality = 'South Korean', n.age = '', n.aliases = ["김동선"]
  ON MATCH  SET n.full_name = '김동선', n.role = '부사장', n.nationality = 'South Korean', n.age = '', n.aliases = ["김동선"];

MERGE (n:PERSON {name: '곽동신'})
  ON CREATE SET n.full_name = '곽동신', n.role = '회장', n.nationality = 'South Korean', n.age = '', n.aliases = ["곽동신"]
  ON MATCH  SET n.full_name = '곽동신', n.role = '회장', n.nationality = 'South Korean', n.age = '', n.aliases = ["곽동신"];

MERGE (n:COMPANY {name: '한화세미텍'})
  ON CREATE SET n.full_name = '한화세미텍', n.industry = '반도체 장비', n.headquarters = '', n.founded = '', n.ceo = '김동선', n.aliases = ["한화세미텍"]
  ON MATCH  SET n.full_name = '한화세미텍', n.industry = '반도체 장비', n.headquarters = '', n.founded = '', n.ceo = '김동선', n.aliases = ["한화세미텍"];

MERGE (n:COMPANY {name: '한미반도체'})
  ON CREATE SET n.full_name = '한미반도체', n.industry = '반도체 장비', n.headquarters = '', n.founded = '1980', n.ceo = '곽동신', n.aliases = ["한미반도체"]
  ON MATCH  SET n.full_name = '한미반도체', n.industry = '반도체 장비', n.headquarters = '', n.founded = '1980', n.ceo = '곽동신', n.aliases = ["한미반도체"];

MERGE (n:COMPANY {name: 'SK하이닉스'})
  ON CREATE SET n.full_name = 'SK하이닉스', n.industry = '반도체', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["SK하이닉스"]
  ON MATCH  SET n.full_name = 'SK하이닉스', n.industry = '반도체', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["SK하이닉스"];

MERGE (n:PRODUCT {name: 'TC 본더'})
  ON CREATE SET n.category = '반도체 장비', n.description = '고대역폭 메모리(HBM) 제조 핵심 장비', n.launch_date = '', n.company = '', n.aliases = ["TC 본더"]
  ON MATCH  SET n.category = '반도체 장비', n.description = '고대역폭 메모리(HBM) 제조 핵심 장비', n.launch_date = '', n.company = '', n.aliases = ["TC 본더"];

MERGE (n:EVENT {name: 'TC 본더 특허 침해 소송'})
  ON CREATE SET n.date = '2021', n.type = 'Legal', n.description = '한미반도체가 한화세미텍을 상대로 제기한 특허 침해 소송', n.location = '', n.aliases = ["TC 본더 특허 침해 소송"]
  ON MATCH  SET n.date = '2021', n.type = 'Legal', n.description = '한미반도체가 한화세미텍을 상대로 제기한 특허 침해 소송', n.location = '', n.aliases = ["TC 본더 특허 침해 소송"];

MERGE (n:INVESTMENT {name: 'R&D 투자'})
  ON CREATE SET n.amount = '677억원', n.date = '2022', n.type = 'R&D', n.aliases = ["R&D 투자"]
  ON MATCH  SET n.amount = '677억원', n.date = '2022', n.type = 'R&D', n.aliases = ["R&D 투자"];

MERGE (n:PERSON {name: '의삼남김동'})
  ON CREATE SET n.role = '회장', n.aliases = ["의삼남김동"]
  ON MATCH  SET n.role = '회장', n.aliases = ["의삼남김동"];

MERGE (n:PERSON {name: '부은지난'})
  ON CREATE SET n.role = '사장', n.aliases = ["부은지난"]
  ON MATCH  SET n.role = '사장', n.aliases = ["부은지난"];

MERGE (n:PERSON {name: '부은한화'})
  ON CREATE SET n.role = '사장', n.aliases = ["부은한화"]
  ON MATCH  SET n.role = '사장', n.aliases = ["부은한화"];

MERGE (n:PERSON {name: '출신'})
  ON CREATE SET n.role = '대표', n.aliases = ["출신"]
  ON MATCH  SET n.role = '대표', n.aliases = ["출신"];

MERGE (n:PERSON {name: '이이끌'})
  ON CREATE SET n.role = '회장', n.aliases = ["이이끌"]
  ON MATCH  SET n.role = '회장', n.aliases = ["이이끌"];

MERGE (n:PERSON {name: '오른곽'})
  ON CREATE SET n.role = '회장', n.aliases = ["오른곽"]
  ON MATCH  SET n.role = '회장', n.aliases = ["오른곽"];

MERGE (n:PERSON {name: '지난해말'})
  ON CREATE SET n.role = '회장', n.aliases = ["지난해말"]
  ON MATCH  SET n.role = '회장', n.aliases = ["지난해말"];

MERGE (n:PERSON {name: '현재곽'})
  ON CREATE SET n.role = '회장', n.aliases = ["현재곽"]
  ON MATCH  SET n.role = '회장', n.aliases = ["현재곽"];

MERGE (n:PERSON {name: '김동선부'})
  ON CREATE SET n.role = '사장', n.aliases = ["김동선부"]
  ON MATCH  SET n.role = '사장', n.aliases = ["김동선부"];

MERGE (n:PERSON {name: '김승연'})
  ON CREATE SET n.role = '회장', n.aliases = ["김승연"]
  ON MATCH  SET n.role = '회장', n.aliases = ["김승연"];

MERGE (n:PERSON {name: '한화갤러리아부'})
  ON CREATE SET n.role = '사장', n.aliases = ["한화갤러리아부"]
  ON MATCH  SET n.role = '사장', n.aliases = ["한화갤러리아부"];

MERGE (n:PERSON {name: '김부'})
  ON CREATE SET n.role = '사장', n.aliases = ["김부"]
  ON MATCH  SET n.role = '사장', n.aliases = ["김부"];

MERGE (n:PERSON {name: '국가'})
  ON CREATE SET n.role = '대표', n.aliases = ["국가"]
  ON MATCH  SET n.role = '대표', n.aliases = ["국가"];

MERGE (n:PERSON {name: '한미반도체'})
  ON CREATE SET n.role = '대표', n.aliases = ["한미반도체"]
  ON MATCH  SET n.role = '대표', n.aliases = ["한미반도체"];

MERGE (n:PERSON {name: '곽'})
  ON CREATE SET n.role = '회장', n.aliases = ["곽"]
  ON MATCH  SET n.role = '회장', n.aliases = ["곽"];

MERGE (n:PERSON {name: '말'})
  ON CREATE SET n.role = '회장', n.aliases = ["말"]
  ON MATCH  SET n.role = '회장', n.aliases = ["말"];

MERGE (n:COMPANY {name: 'HBM'})
  ON CREATE SET n.aliases = ["HBM"]
  ON MATCH  SET n.aliases = ["HBM"];

MERGE (n:PERSON {name: '박미경'})
  ON CREATE SET n.full_name = '박미경', n.role = '제7대 하이서울기업협회장', n.nationality = 'South Korean', n.age = '', n.aliases = ["박미경"]
  ON MATCH  SET n.full_name = '박미경', n.role = '제7대 하이서울기업협회장', n.nationality = 'South Korean', n.age = '', n.aliases = ["박미경"];

MERGE (n:ORGANIZATION {name: '하이서울기업협회'})
  ON CREATE SET n.type = 'Business Association', n.description = 'Network of excellent SMEs supported by Seoul City and SBA.', n.headquarters = '서울, South Korea', n.aliases = ["하이서울기업협회"]
  ON MATCH  SET n.type = 'Business Association', n.description = 'Network of excellent SMEs supported by Seoul City and SBA.', n.headquarters = '서울, South Korea', n.aliases = ["하이서울기업협회"];

MERGE (n:COMPANY {name: '포시에스'})
  ON CREATE SET n.full_name = '포시에스', n.industry = '전자문서', n.headquarters = '서울', n.founded = '1993', n.ceo = '박미경', n.aliases = ["포시에스"]
  ON MATCH  SET n.full_name = '포시에스', n.industry = '전자문서', n.headquarters = '서울', n.founded = '1993', n.ceo = '박미경', n.aliases = ["포시에스"];

MERGE (n:EVENT {name: '미국의 고관세 정책'})
  ON CREATE SET n.date = '', n.type = 'Trade Policy', n.description = '미국의 고관세 부과 정책', n.location = '미국', n.aliases = ["미국의 고관세 정책"]
  ON MATCH  SET n.date = '', n.type = 'Trade Policy', n.description = '미국의 고관세 부과 정책', n.location = '미국', n.aliases = ["미국의 고관세 정책"];

MERGE (n:PROJECT {name: 'AI 분과 신설'})
  ON CREATE SET n.description = 'AI 교육 및 활용 사례 공유', n.start_date = '2023', n.status = '진행 중', n.aliases = ["AI 분과 신설"]
  ON MATCH  SET n.description = 'AI 교육 및 활용 사례 공유', n.start_date = '2023', n.status = '진행 중', n.aliases = ["AI 분과 신설"];

MERGE (n:PERSON {name: '분과서'})
  ON CREATE SET n.role = '대표', n.aliases = ["분과서"]
  ON MATCH  SET n.role = '대표', n.aliases = ["분과서"];

MERGE (n:PERSON {name: '는최근서울강남'})
  ON CREATE SET n.role = '대표', n.aliases = ["는최근서울강남"]
  ON MATCH  SET n.role = '대표', n.aliases = ["는최근서울강남"];

MERGE (n:PERSON {name: '협이취임직후가장신경쓰는부분'})
  ON CREATE SET n.role = '회장', n.aliases = ["협이취임직후가장신경쓰는부분"]
  ON MATCH  SET n.role = '회장', n.aliases = ["협이취임직후가장신경쓰는부분"];

MERGE (n:PERSON {name: '협은'})
  ON CREATE SET n.role = '회장', n.aliases = ["협은"]
  ON MATCH  SET n.role = '회장', n.aliases = ["협은"];

MERGE (n:PERSON {name: '협은취임직후'})
  ON CREATE SET n.role = '회장', n.aliases = ["협은취임직후"]
  ON MATCH  SET n.role = '회장', n.aliases = ["협은취임직후"];

MERGE (n:PERSON {name: '공유해기업'})
  ON CREATE SET n.role = '대표', n.aliases = ["공유해기업"]
  ON MATCH  SET n.role = '대표', n.aliases = ["공유해기업"];

MERGE (n:PERSON {name: '국내전자'})
  ON CREATE SET n.role = '대표', n.aliases = ["국내전자"]
  ON MATCH  SET n.role = '대표', n.aliases = ["국내전자"];

MERGE (n:PERSON {name: '으로박'})
  ON CREATE SET n.role = '대표', n.aliases = ["으로박"]
  ON MATCH  SET n.role = '대표', n.aliases = ["으로박"];

MERGE (n:PERSON {name: '하이서울기업협'})
  ON CREATE SET n.role = '회장', n.aliases = ["하이서울기업협"]
  ON MATCH  SET n.role = '회장', n.aliases = ["하이서울기업협"];

MERGE (n:PERSON {name: '협'})
  ON CREATE SET n.role = '회장', n.aliases = ["협"]
  ON MATCH  SET n.role = '회장', n.aliases = ["협"];

MERGE (n:PERSON {name: '기업'})
  ON CREATE SET n.role = '대표', n.aliases = ["기업"]
  ON MATCH  SET n.role = '대표', n.aliases = ["기업"];

MERGE (n:PERSON {name: '국내'})
  ON CREATE SET n.role = '대표', n.aliases = ["국내"]
  ON MATCH  SET n.role = '대표', n.aliases = ["국내"];

MERGE (n:PERSON {name: '박'})
  ON CREATE SET n.role = '대표', n.aliases = ["박"]
  ON MATCH  SET n.role = '대표', n.aliases = ["박"];

MERGE (n:COMPANY {name: 'SBA'})
  ON CREATE SET n.aliases = ["SBA"]
  ON MATCH  SET n.aliases = ["SBA"];

MERGE (n:EVENT {name: '2025 경기도 동반성장 페어'})
  ON CREATE SET n.date = '2023-10-13', n.type = 'Trade Fair', n.description = '경기도와 동반성장위원회가 공동으로 개최한 상생협력 프로그램', n.location = '수원메쎄 1홀', n.aliases = ["2025 경기도 동반성장 페어"]
  ON MATCH  SET n.date = '2023-10-13', n.type = 'Trade Fair', n.description = '경기도와 동반성장위원회가 공동으로 개최한 상생협력 프로그램', n.location = '수원메쎄 1홀', n.aliases = ["2025 경기도 동반성장 페어"];

MERGE (n:ORGANIZATION {name: '경기도'})
  ON CREATE SET n.type = 'Local Government', n.description = '대한민국의 지방자치단체', n.headquarters = '경기도, 대한민국', n.aliases = ["경기도"]
  ON MATCH  SET n.type = 'Local Government', n.description = '대한민국의 지방자치단체', n.headquarters = '경기도, 대한민국', n.aliases = ["경기도"];

MERGE (n:COMPANY {name: 'Naver'})
  ON CREATE SET n.full_name = '네이버 주식회사', n.industry = '인터넷 서비스', n.headquarters = '성남, 대한민국', n.founded = '1999', n.ceo = '최수연', n.aliases = ["Naver"]
  ON MATCH  SET n.full_name = '네이버 주식회사', n.industry = '인터넷 서비스', n.headquarters = '성남, 대한민국', n.founded = '1999', n.ceo = '최수연', n.aliases = ["Naver"];

MERGE (n:COMPANY {name: '대상'})
  ON CREATE SET n.full_name = '대상 주식회사', n.industry = '식품', n.headquarters = '서울, 대한민국', n.founded = '1956', n.ceo = '임정배', n.aliases = ["대상"]
  ON MATCH  SET n.full_name = '대상 주식회사', n.industry = '식품', n.headquarters = '서울, 대한민국', n.founded = '1956', n.ceo = '임정배', n.aliases = ["대상"];

MERGE (n:COMPANY {name: '현대모비스'})
  ON CREATE SET n.full_name = '현대모비스 주식회사', n.industry = '자동차 부품', n.headquarters = '서울, 대한민국', n.founded = '1977', n.ceo = '조성환', n.aliases = ["현대모비스"]
  ON MATCH  SET n.full_name = '현대모비스 주식회사', n.industry = '자동차 부품', n.headquarters = '서울, 대한민국', n.founded = '1977', n.ceo = '조성환', n.aliases = ["현대모비스"];

MERGE (n:ORGANIZATION {name: '경기도경제과학진흥원'})
  ON CREATE SET n.type = 'Public Organization', n.description = '경기도의 경제 및 과학 진흥을 위한 기관', n.headquarters = '경기도, 대한민국', n.aliases = ["경기도경제과학진흥원"]
  ON MATCH  SET n.type = 'Public Organization', n.description = '경기도의 경제 및 과학 진흥을 위한 기관', n.headquarters = '경기도, 대한민국', n.aliases = ["경기도경제과학진흥원"];

MERGE (n:PERSON {name: '이달곤'})
  ON CREATE SET n.full_name = '이달곤', n.role = '위원장', n.nationality = 'South Korean', n.age = '', n.aliases = ["이달곤"]
  ON MATCH  SET n.full_name = '이달곤', n.role = '위원장', n.nationality = 'South Korean', n.age = '', n.aliases = ["이달곤"];

MERGE (n:PERSON {name: '프로'})
  ON CREATE SET n.role = '대표', n.aliases = ["프로"]
  ON MATCH  SET n.role = '대표', n.aliases = ["프로"];

MERGE (n:EVENT {name: '미국의 관세 부과'})
  ON CREATE SET n.date = '2023-03-12', n.type = 'Trade Policy', n.description = '미국의 철강·알루미늄 및 파생상품에 대한 관세 부과', n.location = '미국', n.aliases = ["미국의 관세 부과"]
  ON MATCH  SET n.date = '2023-03-12', n.type = 'Trade Policy', n.description = '미국의 철강·알루미늄 및 파생상품에 대한 관세 부과', n.location = '미국', n.aliases = ["미국의 관세 부과"];

MERGE (n:PRODUCT {name: '플라스틱 제품'})
  ON CREATE SET n.category = '플라스틱', n.description = '중소기업의 주요 수출 품목', n.launch_date = '', n.company = '', n.aliases = ["플라스틱 제품"]
  ON MATCH  SET n.category = '플라스틱', n.description = '중소기업의 주요 수출 품목', n.launch_date = '', n.company = '', n.aliases = ["플라스틱 제품"];

MERGE (n:PRODUCT {name: '자동차 부품'})
  ON CREATE SET n.category = '자동차 부품', n.description = '중소기업의 주요 수출 품목', n.launch_date = '', n.company = '', n.aliases = ["자동차 부품"]
  ON MATCH  SET n.category = '자동차 부품', n.description = '중소기업의 주요 수출 품목', n.launch_date = '', n.company = '', n.aliases = ["자동차 부품"];

MERGE (n:COMPANY {name: '유한양행'})
  ON CREATE SET n.industry = '제약', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["유한양행"]
  ON MATCH  SET n.industry = '제약', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["유한양행"];

MERGE (n:COMPANY {name: 'GC녹십자'})
  ON CREATE SET n.industry = '제약', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["GC녹십자"]
  ON MATCH  SET n.industry = '제약', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["GC녹십자"];

MERGE (n:COMPANY {name: '대웅제약'})
  ON CREATE SET n.industry = '제약', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["대웅제약"]
  ON MATCH  SET n.industry = '제약', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["대웅제약"];

MERGE (n:COMPANY {name: '한미약품'})
  ON CREATE SET n.industry = '제약', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["한미약품"]
  ON MATCH  SET n.industry = '제약', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["한미약품"];

MERGE (n:COMPANY {name: '종근당'})
  ON CREATE SET n.industry = '제약', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["종근당"]
  ON MATCH  SET n.industry = '제약', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["종근당"];

MERGE (n:COMPANY {name: '보령'})
  ON CREATE SET n.industry = '제약', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["보령"]
  ON MATCH  SET n.industry = '제약', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["보령"];

MERGE (n:COMPANY {name: 'LG화학'})
  ON CREATE SET n.industry = '화학', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["LG화학"]
  ON MATCH  SET n.industry = '화학', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["LG화학"];

MERGE (n:PRODUCT {name: '피즈치바'})
  ON CREATE SET n.category = '바이오시밀러', n.description = '스텔라라 시밀러', n.launch_date = '2023 Q1', n.company = '삼성바이오에피스', n.aliases = ["피즈치바"]
  ON MATCH  SET n.category = '바이오시밀러', n.description = '스텔라라 시밀러', n.launch_date = '2023 Q1', n.company = '삼성바이오에피스', n.aliases = ["피즈치바"];

MERGE (n:PRODUCT {name: '램시마SC'})
  ON CREATE SET n.category = '바이오시밀러', n.description = '자가면역질환 치료제', n.launch_date = '2022 Q1', n.company = '셀트리온', n.aliases = ["램시마SC"]
  ON MATCH  SET n.category = '바이오시밀러', n.description = '자가면역질환 치료제', n.launch_date = '2022 Q1', n.company = '셀트리온', n.aliases = ["램시마SC"];

MERGE (n:PRODUCT {name: '유플라이마'})
  ON CREATE SET n.category = '바이오시밀러', n.description = '', n.launch_date = '', n.company = '셀트리온', n.aliases = ["유플라이마"]
  ON MATCH  SET n.category = '바이오시밀러', n.description = '', n.launch_date = '', n.company = '셀트리온', n.aliases = ["유플라이마"];

MERGE (n:PRODUCT {name: '렉라자'})
  ON CREATE SET n.category = '신약', n.description = '폐암 치료제', n.launch_date = '', n.company = '유한양행', n.aliases = ["렉라자"]
  ON MATCH  SET n.category = '신약', n.description = '폐암 치료제', n.launch_date = '', n.company = '유한양행', n.aliases = ["렉라자"];

MERGE (n:PRODUCT {name: '알리글로'})
  ON CREATE SET n.category = '신약', n.description = '', n.launch_date = '', n.company = 'GC녹십자', n.aliases = ["알리글로"]
  ON MATCH  SET n.category = '신약', n.description = '', n.launch_date = '', n.company = 'GC녹십자', n.aliases = ["알리글로"];

MERGE (n:PRODUCT {name: '펙수클루'})
  ON CREATE SET n.category = '신약', n.description = '위식도역류질환 치료제', n.launch_date = '', n.company = '대웅제약', n.aliases = ["펙수클루"]
  ON MATCH  SET n.category = '신약', n.description = '위식도역류질환 치료제', n.launch_date = '', n.company = '대웅제약', n.aliases = ["펙수클루"];

MERGE (n:PRODUCT {name: '나보타'})
  ON CREATE SET n.category = '신약', n.description = '보툴리눔톡신', n.launch_date = '', n.company = '대웅제약', n.aliases = ["나보타"]
  ON MATCH  SET n.category = '신약', n.description = '보툴리눔톡신', n.launch_date = '', n.company = '대웅제약', n.aliases = ["나보타"];

MERGE (n:PRODUCT {name: '고덱스'})
  ON CREATE SET n.category = '간장약', n.description = '', n.launch_date = '', n.company = '셀트리온제약', n.aliases = ["고덱스"]
  ON MATCH  SET n.category = '간장약', n.description = '', n.launch_date = '', n.company = '셀트리온제약', n.aliases = ["고덱스"];

MERGE (n:PRODUCT {name: '케이캡'})
  ON CREATE SET n.category = '위식도역류질환 치료제', n.description = '', n.launch_date = '', n.company = 'HK이노엔', n.aliases = ["케이캡"]
  ON MATCH  SET n.category = '위식도역류질환 치료제', n.description = '', n.launch_date = '', n.company = 'HK이노엔', n.aliases = ["케이캡"];

MERGE (n:PRODUCT {name: '성장호르몬'})
  ON CREATE SET n.category = '치료제', n.description = '', n.launch_date = '', n.company = 'LG화학', n.aliases = ["성장호르몬"]
  ON MATCH  SET n.category = '치료제', n.description = '', n.launch_date = '', n.company = 'LG화학', n.aliases = ["성장호르몬"];

MERGE (n:PRODUCT {name: '당뇨병치료제'})
  ON CREATE SET n.category = '치료제', n.description = '', n.launch_date = '', n.company = 'LG화학', n.aliases = ["당뇨병치료제"]
  ON MATCH  SET n.category = '치료제', n.description = '', n.launch_date = '', n.company = 'LG화학', n.aliases = ["당뇨병치료제"];

MERGE (n:INDUSTRY {name: '제약바이오'})
  ON CREATE SET n.aliases = ["제약바이오"]
  ON MATCH  SET n.aliases = ["제약바이오"];

MERGE (n:PERSON {name: '바이'})
  ON CREATE SET n.role = '대표', n.aliases = ["바이"]
  ON MATCH  SET n.role = '대표', n.aliases = ["바이"];

MERGE (n:COMPANY {name: 'CDMO'})
  ON CREATE SET n.aliases = ["CDMO"]
  ON MATCH  SET n.aliases = ["CDMO"];

MERGE (n:COMPANY {name: '한국서부발전'})
  ON CREATE SET n.industry = '에너지', n.headquarters = '태안', n.founded = '', n.ceo = '', n.aliases = ["한국서부발전"]
  ON MATCH  SET n.industry = '에너지', n.headquarters = '태안', n.founded = '', n.ceo = '', n.aliases = ["한국서부발전"];

MERGE (n:EVENT {name: '발전정보 활용 창업·벤처기업 협업사업 공모'})
  ON CREATE SET n.date = '2023-10-14', n.type = '공모', n.description = '창업·벤처기업이 서부발전의 발전정보를 활용해 창의적인 기술을 개발하고 실증하는 사업화 연계 프로그램', n.location = '태안', n.aliases = ["발전정보 활용 창업·벤처기업 협업사업 공모"]
  ON MATCH  SET n.date = '2023-10-14', n.type = '공모', n.description = '창업·벤처기업이 서부발전의 발전정보를 활용해 창의적인 기술을 개발하고 실증하는 사업화 연계 프로그램', n.location = '태안', n.aliases = ["발전정보 활용 창업·벤처기업 협업사업 공모"];

MERGE (n:INVESTMENT {name: '창업·벤처기업 지원'})
  ON CREATE SET n.amount = '1000만~3000만원', n.date = '', n.type = '지원', n.aliases = ["창업·벤처기업 지원"]
  ON MATCH  SET n.amount = '1000만~3000만원', n.date = '', n.type = '지원', n.aliases = ["창업·벤처기업 지원"];

MERGE (n:COMPANY {name: '한샘'})
  ON CREATE SET n.full_name = '한샘', n.industry = '가구', n.headquarters = '서울', n.founded = '', n.ceo = '', n.aliases = ["한샘"]
  ON MATCH  SET n.full_name = '한샘', n.industry = '가구', n.headquarters = '서울', n.founded = '', n.ceo = '', n.aliases = ["한샘"];

MERGE (n:COMPANY {name: '현대리바트'})
  ON CREATE SET n.full_name = '현대리바트', n.industry = '가구', n.headquarters = '서울', n.founded = '', n.ceo = '', n.aliases = ["현대리바트"]
  ON MATCH  SET n.full_name = '현대리바트', n.industry = '가구', n.headquarters = '서울', n.founded = '', n.ceo = '', n.aliases = ["현대리바트"];

MERGE (n:PROJECT {name: '오피스 인테리어 사업 확장'})
  ON CREATE SET n.description = '오피스 기반의 B2B 인테리어 사업 확장', n.start_date = '2025', n.status = '진행 중', n.aliases = ["오피스 인테리어 사업 확장"]
  ON MATCH  SET n.description = '오피스 기반의 B2B 인테리어 사업 확장', n.start_date = '2025', n.status = '진행 중', n.aliases = ["오피스 인테리어 사업 확장"];

MERGE (n:INDUSTRY {name: 'B2B'})
  ON CREATE SET n.aliases = ["B2B"]
  ON MATCH  SET n.aliases = ["B2B"];

MERGE (n:INDUSTRY {name: 'B2C'})
  ON CREATE SET n.aliases = ["B2C"]
  ON MATCH  SET n.aliases = ["B2C"];

MERGE (n:COMPANY {name: '파세코'})
  ON CREATE SET n.industry = '가전', n.headquarters = '안산', n.founded = '', n.ceo = '', n.aliases = ["파세코"]
  ON MATCH  SET n.industry = '가전', n.headquarters = '안산', n.founded = '', n.ceo = '', n.aliases = ["파세코"];

MERGE (n:PERSON {name: '김상우'})
  ON CREATE SET n.full_name = '김상우', n.role = '리테일사업부 상무', n.nationality = 'South Korean', n.age = '', n.aliases = ["김상우"]
  ON MATCH  SET n.full_name = '김상우', n.role = '리테일사업부 상무', n.nationality = 'South Korean', n.age = '', n.aliases = ["김상우"];

MERGE (n:PERSON {name: '박치호'})
  ON CREATE SET n.full_name = '박치호', n.role = '기술연구소 팀장', n.nationality = 'South Korean', n.age = '', n.aliases = ["박치호"]
  ON MATCH  SET n.full_name = '박치호', n.role = '기술연구소 팀장', n.nationality = 'South Korean', n.age = '', n.aliases = ["박치호"];

MERGE (n:PRODUCT {name: '창문형 에어컨'})
  ON CREATE SET n.category = '가전', n.description = '소비자 대상 가전', n.launch_date = '2023-09', n.company = '파세코', n.aliases = ["창문형 에어컨"]
  ON MATCH  SET n.category = '가전', n.description = '소비자 대상 가전', n.launch_date = '2023-09', n.company = '파세코', n.aliases = ["창문형 에어컨"];

MERGE (n:PRODUCT {name: '서큘레이터'})
  ON CREATE SET n.category = '가전', n.description = '소비자 대상 가전', n.launch_date = '', n.company = '파세코', n.aliases = ["서큘레이터"]
  ON MATCH  SET n.category = '가전', n.description = '소비자 대상 가전', n.launch_date = '', n.company = '파세코', n.aliases = ["서큘레이터"];

MERGE (n:PRODUCT {name: '보디드라이어'})
  ON CREATE SET n.category = '가전', n.description = '소비자 대상 가전', n.launch_date = '', n.company = '파세코', n.aliases = ["보디드라이어"]
  ON MATCH  SET n.category = '가전', n.description = '소비자 대상 가전', n.launch_date = '', n.company = '파세코', n.aliases = ["보디드라이어"];

MERGE (n:TECHNOLOGY {name: 'AI 에너지 세이빙'})
  ON CREATE SET n.category = '에너지 절약', n.description = '전기요금을 절감할 수 있는 기술', n.field = '가전', n.aliases = ["AI 에너지 세이빙"]
  ON MATCH  SET n.category = '에너지 절약', n.description = '전기요금을 절감할 수 있는 기술', n.field = '가전', n.aliases = ["AI 에너지 세이빙"];

MERGE (n:TECHNOLOGY {name: 'AI 제어 모드'})
  ON CREATE SET n.category = '인공지능', n.description = '냉방효율을 높이는 인공지능 제어 모드', n.field = '가전', n.aliases = ["AI 제어 모드"]
  ON MATCH  SET n.category = '인공지능', n.description = '냉방효율을 높이는 인공지능 제어 모드', n.field = '가전', n.aliases = ["AI 제어 모드"];

MERGE (n:TECHNOLOGY {name: '환기 시스템'})
  ON CREATE SET n.category = '환기', n.description = '냉방모드를 일정 시간 가동하면 자동으로 환기가 시작되는 시스템', n.field = '가전', n.aliases = ["환기 시스템"]
  ON MATCH  SET n.category = '환기', n.description = '냉방모드를 일정 시간 가동하면 자동으로 환기가 시작되는 시스템', n.field = '가전', n.aliases = ["환기 시스템"];

MERGE (n:PRODUCT {name: '휴대전화 카메라 모듈 제조설비'})
  ON CREATE SET n.category = '제조설비', n.description = '휴대전화 카메라 모듈 생산에 필요한 설비', n.launch_date = '', n.company = 'LG이노텍', n.aliases = ["휴대전화 카메라 모듈 제조설비"]
  ON MATCH  SET n.category = '제조설비', n.description = '휴대전화 카메라 모듈 생산에 필요한 설비', n.launch_date = '', n.company = 'LG이노텍', n.aliases = ["휴대전화 카메라 모듈 제조설비"];

MERGE (n:EVENT {name: '미국의 25% 관세 부과'})
  ON CREATE SET n.date = '2023-03', n.type = 'Trade Policy', n.description = '미국의 25% 관세 부과', n.location = '미국', n.aliases = ["미국의 25% 관세 부과"]
  ON MATCH  SET n.date = '2023-03', n.type = 'Trade Policy', n.description = '미국의 25% 관세 부과', n.location = '미국', n.aliases = ["미국의 25% 관세 부과"];

MERGE (n:REPORT {name: '2025년도 1분기 중소기업 수출 동향'})
  ON CREATE SET n.date = '2023-04-14', n.type = 'Export Report', n.description = '2025년도 1분기 중소기업 수출 동향 발표', n.location = '', n.aliases = ["2025년도 1분기 중소기업 수출 동향"]
  ON MATCH  SET n.date = '2023-04-14', n.type = 'Export Report', n.description = '2025년도 1분기 중소기업 수출 동향 발표', n.location = '', n.aliases = ["2025년도 1분기 중소기업 수출 동향"];

MERGE (n:PRODUCT {name: '철강'})
  ON CREATE SET n.category = '철강', n.description = '소비자 대상 철강', n.launch_date = '', n.company = '', n.aliases = ["철강"]
  ON MATCH  SET n.category = '철강', n.description = '소비자 대상 철강', n.launch_date = '', n.company = '', n.aliases = ["철강"];

MERGE (n:PRODUCT {name: '알루미늄'})
  ON CREATE SET n.category = '알루미늄', n.description = '소비자 대상 알루미늄', n.launch_date = '', n.company = '', n.aliases = ["알루미늄"]
  ON MATCH  SET n.category = '알루미늄', n.description = '소비자 대상 알루미늄', n.launch_date = '', n.company = '', n.aliases = ["알루미늄"];

MERGE (n:LOCATION {name: '키르기스스탄'})
  ON CREATE SET n.type = 'Country', n.country = 'Kyrgyzstan', n.region = '', n.aliases = ["키르기스스탄"]
  ON MATCH  SET n.type = 'Country', n.country = 'Kyrgyzstan', n.region = '', n.aliases = ["키르기스스탄"];

MERGE (n:LOCATION {name: '독립국가연합'})
  ON CREATE SET n.type = 'Region', n.country = '', n.region = 'CIS', n.aliases = ["독립국가연합"]
  ON MATCH  SET n.type = 'Region', n.country = '', n.region = 'CIS', n.aliases = ["독립국가연합"];

MERGE (n:COMPANY {name: 'CIS'})
  ON CREATE SET n.aliases = ["CIS"]
  ON MATCH  SET n.aliases = ["CIS"];

MERGE (n:EVENT {name: '미국의 철강·알루미늄 관세 조치'})
  ON CREATE SET n.date = '2023 Q1', n.type = 'Trade Policy', n.description = '미국의 철강 및 알루미늄 제품에 대한 관세 부과', n.location = '미국', n.aliases = ["미국의 철강·알루미늄 관세 조치"]
  ON MATCH  SET n.date = '2023 Q1', n.type = 'Trade Policy', n.description = '미국의 철강 및 알루미늄 제품에 대한 관세 부과', n.location = '미국', n.aliases = ["미국의 철강·알루미늄 관세 조치"];

MERGE (n:PROJECT {name: '수출 중소벤처기업 글로벌 물류 지원'})
  ON CREATE SET n.description = '중소벤처기업의 글로벌 물류 지원을 위한 업무협약', n.start_date = '2023-10-14', n.status = '진행 중', n.aliases = ["수출 중소벤처기업 글로벌 물류 지원"]
  ON MATCH  SET n.description = '중소벤처기업의 글로벌 물류 지원을 위한 업무협약', n.start_date = '2023-10-14', n.status = '진행 중', n.aliases = ["수출 중소벤처기업 글로벌 물류 지원"];

MERGE (n:LOCATION {name: '여수'})
  ON CREATE SET n.type = 'City', n.country = 'South Korea', n.region = 'Jeollanam-do', n.aliases = ["여수"]
  ON MATCH  SET n.type = 'City', n.country = 'South Korea', n.region = 'Jeollanam-do', n.aliases = ["여수"];

MERGE (n:LOCATION {name: '광양'})
  ON CREATE SET n.type = 'City', n.country = 'South Korea', n.region = 'Jeollanam-do', n.aliases = ["광양"]
  ON MATCH  SET n.type = 'City', n.country = 'South Korea', n.region = 'Jeollanam-do', n.aliases = ["광양"];

MERGE (n:EVENT {name: '미국 관세 정책'})
  ON CREATE SET n.date = '2023', n.type = 'Trade Policy', n.description = '미국의 25% 관세 부과', n.location = '미국', n.aliases = ["미국 관세 정책"]
  ON MATCH  SET n.date = '2023', n.type = 'Trade Policy', n.description = '미국의 25% 관세 부과', n.location = '미국', n.aliases = ["미국 관세 정책"];

MERGE (n:ORGANIZATION {name: '스마트트레이드허브'})
  ON CREATE SET n.aliases = ["스마트트레이드허브"]
  ON MATCH  SET n.aliases = ["스마트트레이드허브"];

MERGE (n:ORGANIZATION {name: '인천국제공항공사'})
  ON CREATE SET n.aliases = ["인천국제공항공사"]
  ON MATCH  SET n.aliases = ["인천국제공항공사"];

MATCH (a:ORGANIZATION {name: '경기도'}),
      (b:EVENT   {name: '찾아가는 산업재해 예방 교육'})
MERGE (a)-[r:HOSTS]->(b);

MATCH (a:ORGANIZATION {name: '고용노동부'}),
      (b:_UNSPEC   {name: 'EVENT'})
MERGE (a)-[r:PROVIDES_STATISTICS]->(b)
  ON CREATE SET r.date = '2023', r.description = '산업재해 사고 사망자 통계'
  ON MATCH  SET r.date = '2023', r.description = '산업재해 사고 사망자 통계';

MATCH (a:ORGANIZATION {name: '직업건강간호협회 직업건강안전연구소'}),
      (b:EVENT   {name: '찾아가는 산업재해 예방 교육'})
MERGE (a)-[r:SUPPORTS]->(b)
  ON CREATE SET r.contact = '032-668-9030', r.email = 'hsl@kaohn.or.kr'
  ON MATCH  SET r.contact = '032-668-9030', r.email = 'hsl@kaohn.or.kr';

MATCH (a:PERSON {name: '임용규'}),
      (b:ORGANIZATION   {name: '경기도'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '노동안전과장'
  ON MATCH  SET r.position = '노동안전과장';

MATCH (a:COMPANY {name: '에이텀'}),
      (b:COMPANY   {name: 'DST'})
MERGE (a)-[r:ACQUIRED]->(b)
  ON CREATE SET r.date = '2023-02-02', r.amount = '145억 원'
  ON MATCH  SET r.date = '2023-02-02', r.amount = '145억 원';

MATCH (a:COMPANY {name: '에이텀'}),
      (b:_UNSPEC   {name: '삼성전자'})
MERGE (a)-[r:SUPPLIES]->(b)
  ON CREATE SET r.product = '45W 트랜스'
  ON MATCH  SET r.product = '45W 트랜스';

MATCH (a:COMPANY {name: 'DST'}),
      (b:COMPANY   {name: 'HD현대중공업'})
MERGE (a)-[r:SUPPLIES]->(b)
  ON CREATE SET r.product = '힘센엔진 실린더'
  ON MATCH  SET r.product = '힘센엔진 실린더';

MATCH (a:COMPANY {name: 'DST'}),
      (b:COMPANY   {name: 'HD현대마린솔루션'})
MERGE (a)-[r:SUPPLIES]->(b);

MATCH (a:COMPANY {name: 'DST'}),
      (b:COMPANY   {name: 'STX엔진'})
MERGE (a)-[r:SUPPLIES]->(b);

MATCH (a:COMPANY {name: '밸류파인더'}),
      (b:COMPANY   {name: '에이텀'})
MERGE (a)-[r:ANALYZED]->(b)
  ON CREATE SET r.date = '2023-02-14', r.report = '신성장동력 확보 평가'
  ON MATCH  SET r.date = '2023-02-14', r.report = '신성장동력 확보 평가';

MATCH (a:PERSON {name: '이충헌'}),
      (b:COMPANY   {name: '밸류파인더'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '연구원', r.since = ''
  ON MATCH  SET r.position = '연구원', r.since = '';

MATCH (a:COMPANY {name: '에이텀'}),
      (b:PRODUCT   {name: 'TA트랜스'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '에이텀'}),
      (b:PRODUCT   {name: 'TV트랜스'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '에이텀'}),
      (b:PRODUCT   {name: '전기차용 트랜스'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:ORGANIZATION {name: '동반성장위원회'}),
      (b:AGREEMENT   {name: '협력사 ESG 지원 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:AGREEMENT   {name: '협력사 ESG 지원 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:PERSON   {name: '에이피텍'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '핵심 협력사', r.date = '2023'
  ON MATCH  SET r.type = '핵심 협력사', r.date = '2023';

MATCH (a:PERSON {name: '에이피텍'}),
      (b:AWARD   {name: 'ESG 우수 중소기업 확인서'})
MERGE (a)-[r:RECEIVED]->(b);

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:PROJECT   {name: '대·중소 자율형 ESG 지원사업'})
MERGE (a)-[r:PARTICIPATED_IN]->(b);

MATCH (a:PERSON {name: '박치형'}),
      (b:ORGANIZATION   {name: '동반성장위원회'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '운영처장'
  ON MATCH  SET r.position = '운영처장';

MATCH (a:PERSON {name: '김준성'}),
      (b:COMPANY   {name: 'LG이노텍'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '상무'
  ON MATCH  SET r.position = '상무';

MATCH (a:PERSON {name: '주재철'}),
      (b:PERSON   {name: '에이피텍'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '대표'
  ON MATCH  SET r.position = '대표';

MATCH (a:AGREEMENT {name: '협력사 ESG 지원 업무협약'}),
      (b:LOCATION   {name: '인천 송도'})
MERGE (a)-[r:HELD_IN]->(b);

MATCH (a:ORGANIZATION {name: '기술보증기금'}),
      (b:AGREEMENT   {name: '지식재산공제사업 활성화 협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '인천지식재산센터'}),
      (b:AGREEMENT   {name: '지식재산공제사업 활성화 협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '기술보증기금'}),
      (b:PROJECT   {name: '지식재산공제사업'})
MERGE (a)-[r:LEADS]->(b);

MATCH (a:ORGANIZATION {name: '기술보증기금'}),
      (b:ORGANIZATION   {name: '인천지식재산센터'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = 'Business Cooperation', r.date = '2023-10-14'
  ON MATCH  SET r.type = 'Business Cooperation', r.date = '2023-10-14';

MATCH (a:ORGANIZATION {name: '기술보증기금'}),
      (b:ORGANIZATION   {name: '특허청'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = 'Business Cooperation', r.date = '2019'
  ON MATCH  SET r.type = 'Business Cooperation', r.date = '2019';

MATCH (a:ORGANIZATION {name: '중소벤처기업부'}),
      (b:REPORT   {name: '2025년도 1분기 중소기업 수출 동향'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:PERSON {name: '이순배'}),
      (b:ORGANIZATION   {name: '중소벤처기업부'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '글로벌성장정책관', r.since = ''
  ON MATCH  SET r.position = '글로벌성장정책관', r.since = '';

MATCH (a:EVENT {name: '미국의 철강·알루미늄 및 파생 상품 관세부과'}),
      (b:COMPANY   {name: '중소기업'})
MERGE (a)-[r:AFFECTS]->(b)
  ON CREATE SET r.impact = 'Negative'
  ON MATCH  SET r.impact = 'Negative';

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:AGREEMENT   {name: '글로벌 물류 지원 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:AGREEMENT   {name: '글로벌 물류 지원 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:ORGANIZATION   {name: '부산항만공사'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = 'Logistics Collaboration', r.date = '2023-10-14'
  ON MATCH  SET r.type = 'Logistics Collaboration', r.date = '2023-10-14';

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '부산'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '로스앤젤레스'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '롱비치'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:ORGANIZATION   {name: '스마트트레이드허브'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PERSON {name: '강석진'}),
      (b:ORGANIZATION   {name: '중소벤처기업진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장', r.since = ''
  ON MATCH  SET r.position = '이사장', r.since = '';

MATCH (a:EVENT {name: '미국의 관세 정책'}),
      (b:ORGANIZATION   {name: '중소벤처기업진흥공단'})
MERGE (a)-[r:AFFECTS]->(b)
  ON CREATE SET r.impact = 'Negative'
  ON MATCH  SET r.impact = 'Negative';

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:COMPANY   {name: '현대백화점그룹'})
MERGE (a)-[r:SUBSIDIARY_OF]->(b);

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:ORGANIZATION   {name: '한국중소벤처기업유통원'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '소상공인 온라인쇼핑몰 판매지원사업', r.date = '2023'
  ON MATCH  SET r.type = '소상공인 온라인쇼핑몰 판매지원사업', r.date = '2023';

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:AGREEMENT   {name: '다농마트 청년몰 이용 활성화를 위한 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:LOCATION   {name: '서울'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:ORGANIZATION   {name: '경기도'})
MERGE (a)-[r:EXPANDED_TO]->(b)
  ON CREATE SET r.date = '2021', r.description = 'Increased partnership with local SMEs.'
  ON MATCH  SET r.date = '2021', r.description = 'Increased partnership with local SMEs.';

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:LOCATION   {name: '안산'})
MERGE (a)-[r:EXPANDED_TO]->(b)
  ON CREATE SET r.date = '2023', r.description = 'Partnership with Danong Mart Youth Mall.'
  ON MATCH  SET r.date = '2023', r.description = 'Partnership with Danong Mart Youth Mall.';

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:AGREEMENT   {name: '글로벌 물류 지원 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:AGREEMENT   {name: '글로벌 물류 지원 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:ORGANIZATION   {name: '부산항만공사'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = 'Logistics Collaboration', r.date = '2023-10-14'
  ON MATCH  SET r.type = 'Logistics Collaboration', r.date = '2023-10-14';

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '로스앤젤레스'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '롱비치'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:PROJECT   {name: '중소기업 전용 항공·해운 통합물류 지원 플랫폼'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:_UNSPEC {name: 'EVENT'}),
      (b:ORGANIZATION   {name: '중소벤처기업진흥공단'})
MERGE (a)-[r:AFFECTS]->(b)
  ON CREATE SET r.impact = 'Negative'
  ON MATCH  SET r.impact = 'Negative';

MATCH (a:PERSON {name: '강석진'}),
      (b:ORGANIZATION   {name: '중소벤처기업진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장', r.since = ''
  ON MATCH  SET r.position = '이사장', r.since = '';

MATCH (a:PERSON {name: '엘리스그룹'}),
      (b:AGREEMENT   {name: '엘리스그룹-파인디 업무 협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:PERSON {name: '파인디'}),
      (b:AGREEMENT   {name: '엘리스그룹-파인디 업무 협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:PERSON {name: '김재원'}),
      (b:PERSON   {name: '엘리스그룹'})
MERGE (a)-[r:CEO_OF]->(b)
  ON CREATE SET r.since = ''
  ON MATCH  SET r.since = '';

MATCH (a:_UNSPEC {name: '야마다 유이치로'}),
      (b:PERSON   {name: '파인디'})
MERGE (a)-[r:CEO_OF]->(b)
  ON CREATE SET r.since = ''
  ON MATCH  SET r.since = '';

MATCH (a:PERSON {name: '파인디'}),
      (b:PRODUCT   {name: '파인디 팀플러스'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:ORGANIZATION   {name: '소상공인시장진흥공단'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = 'Business Cooperation', r.date = '2023-03'
  ON MATCH  SET r.type = 'Business Cooperation', r.date = '2023-03';

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:PROJECT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:PARTICIPATES_IN]->(b);

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PROJECT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:PARTICIPATES_IN]->(b);

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PRODUCT   {name: '밀키트'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PRODUCT   {name: '식사이론'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PERSON {name: '박성효'}),
      (b:ORGANIZATION   {name: '소상공인시장진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장', r.since = ''
  ON MATCH  SET r.position = '이사장', r.since = '';

MATCH (a:ORGANIZATION {name: '사람인'}),
      (b:EVENT   {name: '인생 이모작 의향 조사'})
MERGE (a)-[r:CONDUCTED]->(b);

MATCH (a:PERSON {name: '김혜미'}),
      (b:EVENT   {name: '인생 이모작 의향 조사'})
MERGE (a)-[r:PARTICIPATED_IN]->(b)
  ON CREATE SET r.role = '기자'
  ON MATCH  SET r.role = '기자';

MATCH (a:COMPANY {name: '엠투아이'}),
      (b:COMPANY   {name: '벰로보틱스'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '로봇 제어기 공동 개발 및 물류로봇 프로젝트 협약', r.date = '2023-10-14'
  ON MATCH  SET r.type = '로봇 제어기 공동 개발 및 물류로봇 프로젝트 협약', r.date = '2023-10-14';

MATCH (a:COMPANY {name: '엠투아이'}),
      (b:PRODUCT   {name: '로봇 제어기'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '벰로보틱스'}),
      (b:PRODUCT   {name: '로봇 제어기'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '엠투아이'}),
      (b:COMPANY   {name: '벰로보틱스'})
MERGE (a)-[r:INVESTED_IN]->(b)
  ON CREATE SET r.amount = '12억원', r.date = '2023-10-14'
  ON MATCH  SET r.amount = '12억원', r.date = '2023-10-14';

MATCH (a:COMPANY {name: '엠투아이'}),
      (b:TECHNOLOGY   {name: '디지털전환(DX) 솔루션'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '벰로보틱스'}),
      (b:TECHNOLOGY   {name: '위치측정 및 주행제어 기술'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '엠투아이'}),
      (b:PROJECT   {name: '물류로봇 프로젝트'})
MERGE (a)-[r:LEADS]->(b);

MATCH (a:COMPANY {name: '벰로보틱스'}),
      (b:PROJECT   {name: '물류로봇 프로젝트'})
MERGE (a)-[r:PARTICIPATES_IN]->(b);

MATCH (a:COMPANY {name: '에이스침대'}),
      (b:EVENT   {name: '1분기 실적 발표'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:COMPANY {name: '신일전자'}),
      (b:PRODUCT   {name: 'BLDC 에어 서큘레이터 S10 SE'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: 'GS홈쇼핑'}),
      (b:EVENT   {name: '성유리 에디션 방송'})
MERGE (a)-[r:PARTICIPATED_IN]->(b)
  ON CREATE SET r.role = '방송사', r.date = '2023-04-14'
  ON MATCH  SET r.role = '방송사', r.date = '2023-04-14';

MATCH (a:PRODUCT {name: 'BLDC 에어 서큘레이터 S10 SE'}),
      (b:EVENT   {name: '성유리 에디션 방송'})
MERGE (a)-[r:LAUNCHED_AT]->(b);

MATCH (a:PERSON {name: '윤승현'}),
      (b:PERSON   {name: '에이드로'})
MERGE (a)-[r:CEO_OF]->(b)
  ON CREATE SET r.since = ''
  ON MATCH  SET r.since = '';

MATCH (a:PERSON {name: '이용원'}),
      (b:PERSON   {name: '에이드로'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '최고디자인책임자', r.since = ''
  ON MATCH  SET r.position = '최고디자인책임자', r.since = '';

MATCH (a:_UNSPEC {name: '스콧 비튼'}),
      (b:PERSON   {name: '에이드로'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '최고기술책임자', r.since = ''
  ON MATCH  SET r.position = '최고기술책임자', r.since = '';

MATCH (a:PERSON {name: '유동완'}),
      (b:PERSON   {name: '에이드로'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '최고제품책임자', r.since = ''
  ON MATCH  SET r.position = '최고제품책임자', r.since = '';

MATCH (a:PERSON {name: '윤반석'}),
      (b:PERSON   {name: '에이드로'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '최고전략책임자', r.since = ''
  ON MATCH  SET r.position = '최고전략책임자', r.since = '';

MATCH (a:PERSON {name: '에이드로'}),
      (b:PRODUCT   {name: '바디킷'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PERSON {name: '에이드로'}),
      (b:PRODUCT   {name: '에어로 옵티마이제이션 소프트웨어'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PERSON {name: '에이드로'}),
      (b:_UNSPEC   {name: '테슬라'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '바디킷 공급', r.date = ''
  ON MATCH  SET r.type = '바디킷 공급', r.date = '';

MATCH (a:PERSON {name: '에이드로'}),
      (b:COMPANY   {name: '현대'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '바디킷 공급', r.date = ''
  ON MATCH  SET r.type = '바디킷 공급', r.date = '';

MATCH (a:PERSON {name: '에이드로'}),
      (b:COMPANY   {name: '기아'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '바디킷 공급', r.date = ''
  ON MATCH  SET r.type = '바디킷 공급', r.date = '';

MATCH (a:PERSON {name: '에이드로'}),
      (b:COMPANY   {name: 'BMW'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '바디킷 공급', r.date = ''
  ON MATCH  SET r.type = '바디킷 공급', r.date = '';

MATCH (a:PERSON {name: '에이드로'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPANDED_TO]->(b)
  ON CREATE SET r.date = '2023', r.description = '오프라인 쇼룸 개설'
  ON MATCH  SET r.date = '2023', r.description = '오프라인 쇼룸 개설';

MATCH (a:PERSON {name: '에이드로'}),
      (b:LOCATION   {name: '독일'})
MERGE (a)-[r:EXPANDED_TO]->(b)
  ON CREATE SET r.date = '2023', r.description = '법인 설립 및 TUV 인증'
  ON MATCH  SET r.date = '2023', r.description = '법인 설립 및 TUV 인증';

MATCH (a:PERSON {name: '에이드로'}),
      (b:LOCATION   {name: '일본'})
MERGE (a)-[r:EXPANDED_TO]->(b)
  ON CREATE SET r.date = '2023', r.description = '총판계약 체결'
  ON MATCH  SET r.date = '2023', r.description = '총판계약 체결';

MATCH (a:PERSON {name: '에이드로'}),
      (b:LOCATION   {name: '말레이시아'})
MERGE (a)-[r:EXPANDED_TO]->(b)
  ON CREATE SET r.date = '2023', r.description = '시장 확장'
  ON MATCH  SET r.date = '2023', r.description = '시장 확장';

MATCH (a:PERSON {name: '에이드로'}),
      (b:LOCATION   {name: '싱가포르'})
MERGE (a)-[r:EXPANDED_TO]->(b)
  ON CREATE SET r.date = '2023', r.description = '시장 확장'
  ON MATCH  SET r.date = '2023', r.description = '시장 확장';

MATCH (a:PERSON {name: '에이드로'}),
      (b:LOCATION   {name: '영국'})
MERGE (a)-[r:EXPANDED_TO]->(b)
  ON CREATE SET r.date = '2023', r.description = '시장 확장'
  ON MATCH  SET r.date = '2023', r.description = '시장 확장';

MATCH (a:PERSON {name: '에이드로'}),
      (b:LOCATION   {name: '태국'})
MERGE (a)-[r:EXPANDED_TO]->(b)
  ON CREATE SET r.date = '2023', r.description = '시장 확장'
  ON MATCH  SET r.date = '2023', r.description = '시장 확장';

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:COMPANY   {name: '롯데웰푸드'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = 'Business Cooperation', r.date = '2023-03'
  ON MATCH  SET r.type = 'Business Cooperation', r.date = '2023-03';

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:PROJECT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:LEADS]->(b);

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PROJECT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:PARTICIPATES_IN]->(b);

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PRODUCT   {name: 'HMR'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PRODUCT   {name: '밀키트'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PERSON {name: '박성효'}),
      (b:ORGANIZATION   {name: '소상공인시장진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장'
  ON MATCH  SET r.position = '이사장';

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PRODUCT   {name: '우수메뉴'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PRODUCT {name: '우수메뉴'}),
      (b:PRODUCT   {name: '식사이론'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '상품화 협력'
  ON MATCH  SET r.type = '상품화 협력';

MATCH (a:PERSON {name: '센드버드'}),
      (b:PRODUCT   {name: '옴니프레젠트 AI 에이전트'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PERSON {name: '김동신'}),
      (b:PERSON   {name: '센드버드'})
MERGE (a)-[r:CEO_OF]->(b)
  ON CREATE SET r.since = ''
  ON MATCH  SET r.since = '';

MATCH (a:PRODUCT {name: '옴니프레젠트 AI 에이전트'}),
      (b:INDUSTRY   {name: '커머스'})
MERGE (a)-[r:TARGETS]->(b)
  ON CREATE SET r.description = '커머스, 핀테크, 리테일 산업 중심으로 확장'
  ON MATCH  SET r.description = '커머스, 핀테크, 리테일 산업 중심으로 확장';

MATCH (a:PRODUCT {name: '옴니프레젠트 AI 에이전트'}),
      (b:INDUSTRY   {name: '핀테크'})
MERGE (a)-[r:TARGETS]->(b)
  ON CREATE SET r.description = '커머스, 핀테크, 리테일 산업 중심으로 확장'
  ON MATCH  SET r.description = '커머스, 핀테크, 리테일 산업 중심으로 확장';

MATCH (a:PRODUCT {name: '옴니프레젠트 AI 에이전트'}),
      (b:INDUSTRY   {name: '리테일'})
MERGE (a)-[r:TARGETS]->(b)
  ON CREATE SET r.description = '커머스, 핀테크, 리테일 산업 중심으로 확장'
  ON MATCH  SET r.description = '커머스, 핀테크, 리테일 산업 중심으로 확장';

MATCH (a:COMPANY {name: '중소기업'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTS_TO]->(b)
  ON CREATE SET r.product = '화장품', r.amount = '18억4000만 달러', r.date = '2023 Q1', r.growth_rate = '+19.6%'
  ON MATCH  SET r.product = '화장품', r.amount = '18억4000만 달러', r.date = '2023 Q1', r.growth_rate = '+19.6%';

MATCH (a:COMPANY {name: '중소기업'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTS_TO]->(b)
  ON CREATE SET r.product = '자동차', r.amount = '17억4000만 달러', r.date = '2023 Q1', r.growth_rate = '+67.4%'
  ON MATCH  SET r.product = '자동차', r.amount = '17억4000만 달러', r.date = '2023 Q1', r.growth_rate = '+67.4%';

MATCH (a:COMPANY {name: '중소기업'}),
      (b:EVENT   {name: '미국의 철강·알루미늄 및 파생상품 관세부과'})
MERGE (a)-[r:AFFECTED_BY]->(b);

MATCH (a:COMPANY {name: '중소기업'}),
      (b:LOCATION   {name: '중국'})
MERGE (a)-[r:EXPORTS_TO]->(b);

MATCH (a:COMPANY {name: '중소기업'}),
      (b:LOCATION   {name: '일본'})
MERGE (a)-[r:EXPORTS_TO]->(b);

MATCH (a:COMPANY {name: '중소기업'}),
      (b:LOCATION   {name: '홍콩'})
MERGE (a)-[r:EXPORTS_TO]->(b);

MATCH (a:COMPANY {name: '중소기업'}),
      (b:LOCATION   {name: '대만'})
MERGE (a)-[r:EXPORTS_TO]->(b);

MATCH (a:COMPANY {name: '중소기업'}),
      (b:LOCATION   {name: '태국'})
MERGE (a)-[r:EXPORTS_TO]->(b);

MATCH (a:COMPANY {name: '중소기업'}),
      (b:LOCATION   {name: '인도네시아'})
MERGE (a)-[r:EXPORTS_TO]->(b);

MATCH (a:COMPANY {name: '중소기업'}),
      (b:LOCATION   {name: '베트남'})
MERGE (a)-[r:EXPORTS_TO]->(b);

MATCH (a:COMPANY {name: '중소기업'}),
      (b:LOCATION   {name: '인도'})
MERGE (a)-[r:EXPORTS_TO]->(b);

MATCH (a:COMPANY {name: '중소기업'}),
      (b:LOCATION   {name: '멕시코'})
MERGE (a)-[r:EXPORTS_TO]->(b);

MATCH (a:PERSON {name: '이순배'}),
      (b:COMPANY   {name: '중소기업'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '글로벌성장정책관', r.since = ''
  ON MATCH  SET r.position = '글로벌성장정책관', r.since = '';

MATCH (a:PERSON {name: '엔씽'}),
      (b:PRODUCT   {name: '큐브(CUBE)'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PERSON {name: '엔씽'}),
      (b:COMPANY   {name: '이마트'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '공급', r.date = '2023'
  ON MATCH  SET r.type = '공급', r.date = '2023';

MATCH (a:PERSON {name: '엔씽'}),
      (b:COMPANY   {name: '배달의민족'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '공급', r.date = '2023'
  ON MATCH  SET r.type = '공급', r.date = '2023';

MATCH (a:PERSON {name: '엔씽'}),
      (b:PROJECT   {name: '물류센터형 수직농장 스마트팜 개발'})
MERGE (a)-[r:LEADS]->(b);

MATCH (a:PERSON {name: '엔씽'}),
      (b:LOCATION   {name: '경기도 이천'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:PERSON {name: '엔씽'}),
      (b:AWARD   {name: 'CES 최고혁신상'})
MERGE (a)-[r:RECEIVED]->(b);

MATCH (a:PRODUCT {name: '큐브(CUBE)'}),
      (b:TECHNOLOGY   {name: 'IoT 기반 환경 제어 기술'})
MERGE (a)-[r:USES]->(b);

MATCH (a:PERSON {name: '가온아이'}),
      (b:PRODUCT   {name: '세이프아이서트'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PERSON {name: '아이서트'}),
      (b:PRODUCT   {name: '세이프아이서트'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PERSON {name: '조창제'}),
      (b:PERSON   {name: '가온아이'})
MERGE (a)-[r:CEO_OF]->(b)
  ON CREATE SET r.since = ''
  ON MATCH  SET r.since = '';

MATCH (a:PERSON {name: '현수환'}),
      (b:PERSON   {name: '아이서트'})
MERGE (a)-[r:CEO_OF]->(b)
  ON CREATE SET r.since = ''
  ON MATCH  SET r.since = '';

MATCH (a:PRODUCT {name: '세이프아이서트'}),
      (b:PERSON   {name: '가온아이'})
MERGE (a)-[r:USES]->(b)
  ON CREATE SET r.type = 'SaaS'
  ON MATCH  SET r.type = 'SaaS';

MATCH (a:PRODUCT {name: '세이프아이서트'}),
      (b:PERSON   {name: '아이서트'})
MERGE (a)-[r:USES]->(b)
  ON CREATE SET r.type = 'SaaS'
  ON MATCH  SET r.type = 'SaaS';

MATCH (a:COMPANY {name: '한화오션디지털'}),
      (b:PRODUCT   {name: '세이프아이서트'})
MERGE (a)-[r:USES]->(b);

MATCH (a:_UNSPEC {name: 'LG전자'}),
      (b:PRODUCT   {name: '세이프아이서트'})
MERGE (a)-[r:USES]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업부'}),
      (b:EVENT   {name: '미국 관세 조치'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:PERSON {name: '이순배'}),
      (b:ORGANIZATION   {name: '중소벤처기업부'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '글로벌성장정책관', r.since = ''
  ON MATCH  SET r.position = '글로벌성장정책관', r.since = '';

MATCH (a:EVENT {name: '미국 관세 조치'}),
      (b:PRODUCT   {name: '철강 제품'})
MERGE (a)-[r:AFFECTS]->(b)
  ON CREATE SET r.impact = 'Negative'
  ON MATCH  SET r.impact = 'Negative';

MATCH (a:EVENT {name: '미국 관세 조치'}),
      (b:PRODUCT   {name: '알루미늄 제품'})
MERGE (a)-[r:AFFECTS]->(b)
  ON CREATE SET r.impact = 'Negative'
  ON MATCH  SET r.impact = 'Negative';

MATCH (a:EVENT {name: '미국 관세 조치'}),
      (b:PRODUCT   {name: '기타기계류'})
MERGE (a)-[r:AFFECTS]->(b)
  ON CREATE SET r.impact = 'Negative'
  ON MATCH  SET r.impact = 'Negative';

MATCH (a:EVENT {name: '미국 관세 조치'}),
      (b:PRODUCT   {name: '전자응용기기'})
MERGE (a)-[r:AFFECTS]->(b)
  ON CREATE SET r.impact = 'Negative'
  ON MATCH  SET r.impact = 'Negative';

MATCH (a:COMPANY {name: '삼성바이오로직스'}),
      (b:EVENT   {name: '미국 의약품 관세 부과'})
MERGE (a)-[r:AFFECTED_BY]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:EVENT   {name: '미국 의약품 관세 부과'})
MERGE (a)-[r:AFFECTED_BY]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:PRODUCT   {name: '램시마'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:PRODUCT   {name: '트룩시마'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:PRODUCT   {name: '옴리클로'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:PRODUCT   {name: '아이덴젤트'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '삼성바이오로직스'}),
      (b:EVENT   {name: '약가인하 행정명령'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = 'Potential increase in biosimilar demand'
  ON MATCH  SET r.impact = 'Potential increase in biosimilar demand';

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:EVENT   {name: '약가인하 행정명령'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = 'Potential increase in biosimilar demand'
  ON MATCH  SET r.impact = 'Potential increase in biosimilar demand';

MATCH (a:COMPANY {name: '와디즈'}),
      (b:REPORT   {name: '2025 글로벌 소비자 트렌드 리포트'})
MERGE (a)-[r:PUBLISHED]->(b);

MATCH (a:PRODUCT {name: '뉴에어론 풀 체어'}),
      (b:_UNSPEC   {name: '가구'})
MERGE (a)-[r:TARGETS]->(b);

MATCH (a:PRODUCT {name: '쿠자 멀티핸들 스텐팬'}),
      (b:_UNSPEC   {name: '주방용품'})
MERGE (a)-[r:TARGETS]->(b);

MATCH (a:PRODUCT {name: '올리젯 청바지'}),
      (b:_UNSPEC   {name: '패션'})
MERGE (a)-[r:TARGETS]->(b);

MATCH (a:PRODUCT {name: '고급 매트리스'}),
      (b:_UNSPEC   {name: '가구'})
MERGE (a)-[r:TARGETS]->(b);

MATCH (a:PRODUCT {name: '호텔급 낮잠이불'}),
      (b:_UNSPEC   {name: '가구'})
MERGE (a)-[r:TARGETS]->(b);

MATCH (a:PERSON {name: '황지현'}),
      (b:REPORT   {name: '2025 글로벌 소비자 트렌드 리포트'})
MERGE (a)-[r:PARTICIPATED_IN]->(b)
  ON CREATE SET r.role = '기자'
  ON MATCH  SET r.role = '기자';

MATCH (a:ORGANIZATION {name: '동반성장위원회'}),
      (b:AGREEMENT   {name: '협력사 ESG 지원사업 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:AGREEMENT   {name: '협력사 ESG 지원사업 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:PERSON   {name: '에이피텍'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '핸드폰 카메라 모듈 생산 설비 공급', r.date = '2023'
  ON MATCH  SET r.type = '핸드폰 카메라 모듈 생산 설비 공급', r.date = '2023';

MATCH (a:ORGANIZATION {name: '동반성장위원회'}),
      (b:AWARD   {name: 'ESG 우수 중소기업 확인서'})
MERGE (a)-[r:AWARDED]->(b)
  ON CREATE SET r.recipient = '에이피텍'
  ON MATCH  SET r.recipient = '에이피텍';

MATCH (a:PERSON {name: '에이피텍'}),
      (b:COMPANY   {name: 'LG이노텍'})
MERGE (a)-[r:SUPPLIES]->(b)
  ON CREATE SET r.product = '핸드폰 카메라 모듈 생산 설비'
  ON MATCH  SET r.product = '핸드폰 카메라 모듈 생산 설비';

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:COMPANY   {name: '롯데웰푸드'})
MERGE (a)-[r:PARTNERED_WITH]->(b);

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:PROJECT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:LEADS]->(b);

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PROJECT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:PARTICIPATES_IN]->(b);

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PRODUCT   {name: '밀키트'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PERSON {name: '박성효'}),
      (b:ORGANIZATION   {name: '소상공인시장진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장'
  ON MATCH  SET r.position = '이사장';

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:LOCATION   {name: '스페인'})
MERGE (a)-[r:EXPANDED_TO]->(b)
  ON CREATE SET r.date = '2023', r.strategy = '직판 체제 전환'
  ON MATCH  SET r.date = '2023', r.strategy = '직판 체제 전환';

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:LOCATION   {name: '포르투갈'})
MERGE (a)-[r:EXPANDED_TO]->(b)
  ON CREATE SET r.date = '2022-12', r.strategy = '직판 체제 전환'
  ON MATCH  SET r.date = '2022-12', r.strategy = '직판 체제 전환';

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:PRODUCT   {name: '트룩시마'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:PRODUCT   {name: '허쥬마'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:PRODUCT   {name: '베그젤마'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:PRODUCT   {name: '스테키마'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:ORGANIZATION   {name: 'CSC'})
MERGE (a)-[r:PARTICIPATED_IN]->(b)
  ON CREATE SET r.role = 'Supplier', r.date = '2023'
  ON MATCH  SET r.role = 'Supplier', r.date = '2023';

MATCH (a:PERSON {name: '강석훈'}),
      (b:COMPANY   {name: '셀트리온'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '스페인 및 포르투갈 법인장'
  ON MATCH  SET r.position = '스페인 및 포르투갈 법인장';

MATCH (a:ORGANIZATION {name: '중소벤처기업부'}),
      (b:EVENT   {name: '미국 철강·알루미늄 및 파생상품 관세부과'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-03-12'
  ON MATCH  SET r.date = '2023-03-12';

MATCH (a:PERSON {name: '이순배'}),
      (b:ORGANIZATION   {name: '중소벤처기업부'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '글로벌성장정책관', r.since = ''
  ON MATCH  SET r.position = '글로벌성장정책관', r.since = '';

MATCH (a:EVENT {name: '미국 철강·알루미늄 및 파생상품 관세부과'}),
      (b:PRODUCT   {name: '철강 제품'})
MERGE (a)-[r:AFFECTS]->(b)
  ON CREATE SET r.impact = 'Negative'
  ON MATCH  SET r.impact = 'Negative';

MATCH (a:EVENT {name: '미국 철강·알루미늄 및 파생상품 관세부과'}),
      (b:PRODUCT   {name: '알루미늄 제품'})
MERGE (a)-[r:AFFECTS]->(b)
  ON CREATE SET r.impact = 'Negative'
  ON MATCH  SET r.impact = 'Negative';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '18억 4000만달러', r.date = '2023 Q1'
  ON MATCH  SET r.amount = '18억 4000만달러', r.date = '2023 Q1';

MATCH (a:PRODUCT {name: '자동차'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '17억 4000만달러', r.date = '2023 Q1'
  ON MATCH  SET r.amount = '17억 4000만달러', r.date = '2023 Q1';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '중국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '2023 Q1'
  ON MATCH  SET r.amount = '', r.date = '2023 Q1';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '일본'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '2023 Q1'
  ON MATCH  SET r.amount = '', r.date = '2023 Q1';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '홍콩'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '2023 Q1'
  ON MATCH  SET r.amount = '', r.date = '2023 Q1';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '대만'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '2023 Q1'
  ON MATCH  SET r.amount = '', r.date = '2023 Q1';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '태국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '2023 Q1'
  ON MATCH  SET r.amount = '', r.date = '2023 Q1';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '인도네시아'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '2023 Q1'
  ON MATCH  SET r.amount = '', r.date = '2023 Q1';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '베트남'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '2023 Q1'
  ON MATCH  SET r.amount = '', r.date = '2023 Q1';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '인도'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '2023 Q1'
  ON MATCH  SET r.amount = '', r.date = '2023 Q1';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '멕시코'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '2023 Q1'
  ON MATCH  SET r.amount = '', r.date = '2023 Q1';

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:LOCATION   {name: '스페인'})
MERGE (a)-[r:EXPANDED_TO]->(b)
  ON CREATE SET r.date = '2023', r.strategy = '직판 체제 전환'
  ON MATCH  SET r.date = '2023', r.strategy = '직판 체제 전환';

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:LOCATION   {name: '포르투갈'})
MERGE (a)-[r:EXPANDED_TO]->(b)
  ON CREATE SET r.date = '2023', r.strategy = '직판 체제 전환'
  ON MATCH  SET r.date = '2023', r.strategy = '직판 체제 전환';

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:PRODUCT   {name: '트룩시마'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:PRODUCT   {name: '허쥬마'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:PRODUCT   {name: '베그젤마'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:PRODUCT   {name: '스테키마'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:PRODUCT   {name: '앱토즈마'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:PERSON {name: '강석훈'}),
      (b:COMPANY   {name: '셀트리온'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '법인장'
  ON MATCH  SET r.position = '법인장';

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:PROJECT   {name: '스페인 및 포르투갈 직판 전환'})
MERGE (a)-[r:LEADS]->(b);

MATCH (a:ORGANIZATION {name: '기술보증기금'}),
      (b:AGREEMENT   {name: '지식재산공제사업 활성화를 통한 공동발전 업무 협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '인천지식재산센터'}),
      (b:AGREEMENT   {name: '지식재산공제사업 활성화를 통한 공동발전 업무 협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '기술보증기금'}),
      (b:PROJECT   {name: '지식재산공제사업'})
MERGE (a)-[r:LEADS]->(b);

MATCH (a:ORGANIZATION {name: '인천지식재산센터'}),
      (b:ORGANIZATION   {name: '기술보증기금'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = 'Business Cooperation', r.date = '2023-10-14'
  ON MATCH  SET r.type = 'Business Cooperation', r.date = '2023-10-14';

MATCH (a:COMPANY {name: '노루그룹'}),
      (b:EVENT   {name: '2025 신기술·신제품 전시회'})
MERGE (a)-[r:HOSTED]->(b);

MATCH (a:COMPANY {name: '노루페인트'}),
      (b:LOCATION   {name: '안양'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:PERSON {name: '방양국'}),
      (b:COMPANY   {name: '노루페인트'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '연구소장'
  ON MATCH  SET r.position = '연구소장';

MATCH (a:COMPANY {name: '노루그룹'}),
      (b:PRODUCT   {name: '스텔스 도료'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '노루그룹'}),
      (b:PRODUCT   {name: '우레탄 난연 몰딩제'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '노루그룹'}),
      (b:PRODUCT   {name: '탄소 저감 건재용 도료'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '노루그룹'}),
      (b:PRODUCT   {name: 'VOC 저감형 아크릴 수지'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PERSON {name: '박미경'}),
      (b:ORGANIZATION   {name: '하이서울기업협회'})
MERGE (a)-[r:LEADS]->(b);

MATCH (a:PERSON {name: '박미경'}),
      (b:COMPANY   {name: '포시에스'})
MERGE (a)-[r:CEO_OF]->(b)
  ON CREATE SET r.since = '1993'
  ON MATCH  SET r.since = '1993';

MATCH (a:ORGANIZATION {name: '하이서울기업협회'}),
      (b:COMPANY   {name: '포시에스'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = 'Business Cooperation', r.date = '2023'
  ON MATCH  SET r.type = 'Business Cooperation', r.date = '2023';

MATCH (a:COMPANY {name: '포시에스'}),
      (b:LOCATION   {name: '일본'})
MERGE (a)-[r:EXPANDED_TO]->(b)
  ON CREATE SET r.date = '2023', r.description = '병원 전자동의서 공급 시작'
  ON MATCH  SET r.date = '2023', r.description = '병원 전자동의서 공급 시작';

MATCH (a:COMPANY {name: '포시에스'}),
      (b:LOCATION   {name: '베트남'})
MERGE (a)-[r:EXPANDED_TO]->(b)
  ON CREATE SET r.date = '2023', r.description = '파트너사를 통한 진출'
  ON MATCH  SET r.date = '2023', r.description = '파트너사를 통한 진출';

MATCH (a:COMPANY {name: '포시에스'}),
      (b:LOCATION   {name: '대만'})
MERGE (a)-[r:EXPANDED_TO]->(b)
  ON CREATE SET r.date = '2023', r.description = '파트너사를 통한 진출'
  ON MATCH  SET r.date = '2023', r.description = '파트너사를 통한 진출';

MATCH (a:COMPANY {name: '포시에스'}),
      (b:LOCATION   {name: '인도네시아'})
MERGE (a)-[r:EXPANDED_TO]->(b)
  ON CREATE SET r.date = '2023', r.description = '추가 진출 계획'
  ON MATCH  SET r.date = '2023', r.description = '추가 진출 계획';

MATCH (a:ORGANIZATION {name: '하이서울기업협회'}),
      (b:EVENT   {name: '미국의 고관세 정책'})
MERGE (a)-[r:AFFECTED_BY]->(b);

MATCH (a:ORGANIZATION {name: '하이서울기업협회'}),
      (b:PROJECT   {name: 'AI 분과 신설'})
MERGE (a)-[r:LEADS]->(b);

MATCH (a:PERSON {name: '패스트파이브'}),
      (b:PRODUCT   {name: '파이브클라우드'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:PERSON {name: '패스트파이브'}),
      (b:PRODUCT   {name: '인테리어코드'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:PERSON {name: '패스트파이브'}),
      (b:COMPANY   {name: '아마존웹서비스'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '클라우드 솔루션 제공', r.date = ''
  ON MATCH  SET r.type = '클라우드 솔루션 제공', r.date = '';

MATCH (a:PERSON {name: '패스트파이브'}),
      (b:_UNSPEC   {name: '구글'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '클라우드 솔루션 제공', r.date = ''
  ON MATCH  SET r.type = '클라우드 솔루션 제공', r.date = '';

MATCH (a:PERSON {name: '패스트파이브'}),
      (b:_UNSPEC   {name: '마이크로소프트'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '클라우드 솔루션 제공', r.date = ''
  ON MATCH  SET r.type = '클라우드 솔루션 제공', r.date = '';

MATCH (a:PERSON {name: '김대일'}),
      (b:PERSON   {name: '패스트파이브'})
MERGE (a)-[r:CEO_OF]->(b)
  ON CREATE SET r.since = ''
  ON MATCH  SET r.since = '';

MATCH (a:PRODUCT {name: '파이브클라우드'}),
      (b:AWARD   {name: 'AWS 한국파트너리그 수상'})
MERGE (a)-[r:RECEIVED]->(b);

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:COMPANY   {name: '롯데웰푸드'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = 'Business Cooperation', r.date = '2023-03'
  ON MATCH  SET r.type = 'Business Cooperation', r.date = '2023-03';

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:PROJECT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:LEADS]->(b);

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PROJECT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:PARTICIPATES_IN]->(b);

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PRODUCT   {name: '밀키트'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PERSON {name: '박성효'}),
      (b:ORGANIZATION   {name: '소상공인시장진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장', r.since = ''
  ON MATCH  SET r.position = '이사장', r.since = '';

MATCH (a:ORGANIZATION {name: '중소벤처기업부'}),
      (b:EVENT   {name: '미국의 관세 부과'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:PERSON {name: '이순배'}),
      (b:ORGANIZATION   {name: '중소벤처기업부'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '글로벌성장정책관', r.since = ''
  ON MATCH  SET r.position = '글로벌성장정책관', r.since = '';

MATCH (a:EVENT {name: '미국의 관세 부과'}),
      (b:PRODUCT   {name: '철강 제품'})
MERGE (a)-[r:AFFECTS]->(b)
  ON CREATE SET r.impact = 'Negative'
  ON MATCH  SET r.impact = 'Negative';

MATCH (a:EVENT {name: '미국의 관세 부과'}),
      (b:PRODUCT   {name: '알루미늄 제품'})
MERGE (a)-[r:AFFECTS]->(b)
  ON CREATE SET r.impact = 'Negative'
  ON MATCH  SET r.impact = 'Negative';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '18억4천만 달러', r.date = '1분기'
  ON MATCH  SET r.amount = '18억4천만 달러', r.date = '1분기';

MATCH (a:PRODUCT {name: '자동차'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '17억4천만 달러', r.date = '1분기'
  ON MATCH  SET r.amount = '17억4천만 달러', r.date = '1분기';

MATCH (a:PRODUCT {name: '플라스틱 제품'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '11억3천만 달러', r.date = '1분기'
  ON MATCH  SET r.amount = '11억3천만 달러', r.date = '1분기';

MATCH (a:PRODUCT {name: '자동차 부품'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '10억4천만 달러', r.date = '1분기'
  ON MATCH  SET r.amount = '10억4천만 달러', r.date = '1분기';

MATCH (a:PERSON {name: '신송남'}),
      (b:PERSON   {name: '정일산업'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '작업자'
  ON MATCH  SET r.position = '작업자';

MATCH (a:PERSON {name: '김대환'}),
      (b:PERSON   {name: '정일산업'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '공장장'
  ON MATCH  SET r.position = '공장장';

MATCH (a:PERSON {name: '김두연'}),
      (b:PERSON   {name: '정일산업'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '고무 프레스 담당'
  ON MATCH  SET r.position = '고무 프레스 담당';

MATCH (a:PERSON {name: '방광호'}),
      (b:PERSON   {name: '정일산업'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '지게차 기사'
  ON MATCH  SET r.position = '지게차 기사';

MATCH (a:PERSON {name: '정광용'}),
      (b:PERSON   {name: '정일산업'})
MERGE (a)-[r:CEO_OF]->(b);

MATCH (a:PERSON {name: '정일산업'}),
      (b:LOCATION   {name: '경기도 시화공단'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:PERSON {name: '정일산업'}),
      (b:LOCATION   {name: '충북 충주'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:PERSON {name: '조주현'}),
      (b:ORGANIZATION   {name: '중소벤처기업연구원'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '원장'
  ON MATCH  SET r.position = '원장';

MATCH (a:COMPANY {name: '삼성바이오로직스'}),
      (b:PRODUCT   {name: '피즈치바'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:PRODUCT   {name: '램시마SC'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:PRODUCT   {name: '유플라이마'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:PRODUCT   {name: '베그젤마'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '유한양행'}),
      (b:PRODUCT   {name: '렉라자'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: 'GC녹십자'}),
      (b:PRODUCT   {name: '알리글로'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '대웅제약'}),
      (b:PRODUCT   {name: '펙수클루'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '대웅제약'}),
      (b:PRODUCT   {name: '나보타'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '종근당'}),
      (b:_UNSPEC   {name: '고덱스 공동판매 계약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:COMPANY {name: '보령'}),
      (b:_UNSPEC   {name: '케이캡 공동판매 계약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:COMPANY {name: 'LG화학'}),
      (b:PRODUCT   {name: '성장호르몬'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: 'LG화학'}),
      (b:PRODUCT   {name: '당뇨병치료제'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '삼성바이오로직스'}),
      (b:INDUSTRY   {name: '제약바이오'})
MERGE (a)-[r:PART_OF]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:INDUSTRY   {name: '제약바이오'})
MERGE (a)-[r:PART_OF]->(b);

MATCH (a:COMPANY {name: '유한양행'}),
      (b:INDUSTRY   {name: '제약바이오'})
MERGE (a)-[r:PART_OF]->(b);

MATCH (a:COMPANY {name: 'GC녹십자'}),
      (b:INDUSTRY   {name: '제약바이오'})
MERGE (a)-[r:PART_OF]->(b);

MATCH (a:COMPANY {name: '대웅제약'}),
      (b:INDUSTRY   {name: '제약바이오'})
MERGE (a)-[r:PART_OF]->(b);

MATCH (a:COMPANY {name: '한미약품'}),
      (b:INDUSTRY   {name: '제약바이오'})
MERGE (a)-[r:PART_OF]->(b);

MATCH (a:COMPANY {name: '종근당'}),
      (b:INDUSTRY   {name: '제약바이오'})
MERGE (a)-[r:PART_OF]->(b);

MATCH (a:COMPANY {name: '보령'}),
      (b:INDUSTRY   {name: '제약바이오'})
MERGE (a)-[r:PART_OF]->(b);

MATCH (a:COMPANY {name: 'LG화학'}),
      (b:INDUSTRY   {name: '제약바이오'})
MERGE (a)-[r:PART_OF]->(b);

MATCH (a:PERSON {name: '김동선'}),
      (b:COMPANY   {name: '한화세미텍'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '부사장', r.since = '2023-02'
  ON MATCH  SET r.position = '부사장', r.since = '2023-02';

MATCH (a:PERSON {name: '곽동신'}),
      (b:PERSON   {name: '한미반도체'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '회장', r.since = '2022'
  ON MATCH  SET r.position = '회장', r.since = '2022';

MATCH (a:COMPANY {name: '한화세미텍'}),
      (b:PRODUCT   {name: 'TC 본더'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:PERSON {name: '한미반도체'}),
      (b:PRODUCT   {name: 'TC 본더'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '한화세미텍'}),
      (b:PERSON   {name: '한미반도체'})
MERGE (a)-[r:COMPETES_WITH]->(b)
  ON CREATE SET r.market = '반도체 장비'
  ON MATCH  SET r.market = '반도체 장비';

MATCH (a:COMPANY {name: '한화세미텍'}),
      (b:COMPANY   {name: 'SK하이닉스'})
MERGE (a)-[r:SIGNED]->(b)
  ON CREATE SET r.type = '공급 계약', r.date = '2023-03'
  ON MATCH  SET r.type = '공급 계약', r.date = '2023-03';

MATCH (a:PERSON {name: '한미반도체'}),
      (b:COMPANY   {name: 'SK하이닉스'})
MERGE (a)-[r:SIGNED]->(b)
  ON CREATE SET r.type = '공동 개발', r.date = '2017'
  ON MATCH  SET r.type = '공동 개발', r.date = '2017';

MATCH (a:COMPANY {name: '한화세미텍'}),
      (b:INVESTMENT   {name: 'R&D 투자'})
MERGE (a)-[r:MADE_INVESTMENT]->(b);

MATCH (a:PERSON {name: '한미반도체'}),
      (b:EVENT   {name: 'TC 본더 특허 침해 소송'})
MERGE (a)-[r:FILED]->(b);

MATCH (a:COMPANY {name: '락앤락'}),
      (b:PRODUCT   {name: '풀히트 푸드워머'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '락앤락'}),
      (b:LOCATION   {name: '서울'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:COMPANY   {name: '롯데웰푸드'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = 'Business Cooperation', r.date = '2023-03'
  ON MATCH  SET r.type = 'Business Cooperation', r.date = '2023-03';

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:PROJECT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:PARTNERED_WITH]->(b);

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PROJECT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:PARTNERED_WITH]->(b);

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PRODUCT   {name: '밀키트'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:PERSON {name: '박성효'}),
      (b:ORGANIZATION   {name: '소상공인시장진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장'
  ON MATCH  SET r.position = '이사장';

MATCH (a:ORGANIZATION {name: '동반성장위원회'}),
      (b:EVENT   {name: '2025 경기도 동반성장 페어'})
MERGE (a)-[r:ORGANIZED]->(b);

MATCH (a:ORGANIZATION {name: '경기도'}),
      (b:EVENT   {name: '2025 경기도 동반성장 페어'})
MERGE (a)-[r:ORGANIZED]->(b);

MATCH (a:_UNSPEC {name: '네이버'}),
      (b:EVENT   {name: '2025 경기도 동반성장 페어'})
MERGE (a)-[r:PARTICIPATED_IN]->(b)
  ON CREATE SET r.role = '구매방침 설명회 참여'
  ON MATCH  SET r.role = '구매방침 설명회 참여';

MATCH (a:COMPANY {name: '대상'}),
      (b:EVENT   {name: '2025 경기도 동반성장 페어'})
MERGE (a)-[r:PARTICIPATED_IN]->(b)
  ON CREATE SET r.role = '구매방침 설명회 참여'
  ON MATCH  SET r.role = '구매방침 설명회 참여';

MATCH (a:COMPANY {name: '현대모비스'}),
      (b:EVENT   {name: '2025 경기도 동반성장 페어'})
MERGE (a)-[r:PARTICIPATED_IN]->(b)
  ON CREATE SET r.role = '구매방침 설명회 참여'
  ON MATCH  SET r.role = '구매방침 설명회 참여';

MATCH (a:ORGANIZATION {name: '경기도경제과학진흥원'}),
      (b:EVENT   {name: '2025 경기도 동반성장 페어'})
MERGE (a)-[r:PARTICIPATED_IN]->(b)
  ON CREATE SET r.role = '중소기업 지원사업 컨설팅'
  ON MATCH  SET r.role = '중소기업 지원사업 컨설팅';

MATCH (a:PERSON {name: '이달곤'}),
      (b:EVENT   {name: '2025 경기도 동반성장 페어'})
MERGE (a)-[r:SPOKE_AT]->(b)
  ON CREATE SET r.topic = '중소기업의 지역 경제 성장 중요성'
  ON MATCH  SET r.topic = '중소기업의 지역 경제 성장 중요성';

MATCH (a:ORGANIZATION {name: '중소벤처기업부'}),
      (b:EVENT   {name: '미국의 철강·알루미늄 관세 조치'})
MERGE (a)-[r:AFFECTED_BY]->(b);

MATCH (a:PERSON {name: '이순배'}),
      (b:ORGANIZATION   {name: '중소벤처기업부'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '글로벌성장정책관', r.since = ''
  ON MATCH  SET r.position = '글로벌성장정책관', r.since = '';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '18억4천만 달러', r.date = '2023 Q1'
  ON MATCH  SET r.amount = '18억4천만 달러', r.date = '2023 Q1';

MATCH (a:PRODUCT {name: '자동차'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '17억4천만 달러', r.date = '2023 Q1'
  ON MATCH  SET r.amount = '17억4천만 달러', r.date = '2023 Q1';

MATCH (a:ORGANIZATION {name: '중소벤처기업부'}),
      (b:EVENT   {name: '미국의 철강·알루미늄 관세 조치'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:ORGANIZATION {name: '중소벤처기업부'}),
      (b:EVENT   {name: '미국의 철강·알루미늄 관세 조치'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:PERSON {name: '이순배'}),
      (b:ORGANIZATION   {name: '중소벤처기업부'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '글로벌성장정책관', r.since = ''
  ON MATCH  SET r.position = '글로벌성장정책관', r.since = '';

MATCH (a:EVENT {name: '미국의 철강·알루미늄 관세 조치'}),
      (b:PRODUCT   {name: '철강 제품'})
MERGE (a)-[r:AFFECTS]->(b)
  ON CREATE SET r.impact = 'Negative'
  ON MATCH  SET r.impact = 'Negative';

MATCH (a:EVENT {name: '미국의 철강·알루미늄 관세 조치'}),
      (b:PRODUCT   {name: '알루미늄 제품'})
MERGE (a)-[r:AFFECTS]->(b)
  ON CREATE SET r.impact = 'Negative'
  ON MATCH  SET r.impact = 'Negative';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '18억4000만달러', r.date = '1분기'
  ON MATCH  SET r.amount = '18억4000만달러', r.date = '1분기';

MATCH (a:PRODUCT {name: '자동차'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '17억4000만달러', r.date = '1분기'
  ON MATCH  SET r.amount = '17억4000만달러', r.date = '1분기';

MATCH (a:PRODUCT {name: '기타기계류'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1억6000만달러', r.date = '1분기'
  ON MATCH  SET r.amount = '1억6000만달러', r.date = '1분기';

MATCH (a:PRODUCT {name: '전자응용기기'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1억3000만달러', r.date = '1분기'
  ON MATCH  SET r.amount = '1억3000만달러', r.date = '1분기';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '중국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '1분기'
  ON MATCH  SET r.amount = '', r.date = '1분기';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '일본'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '1분기'
  ON MATCH  SET r.amount = '', r.date = '1분기';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '홍콩'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '1분기'
  ON MATCH  SET r.amount = '', r.date = '1분기';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '대만'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '1분기'
  ON MATCH  SET r.amount = '', r.date = '1분기';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '태국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '1분기'
  ON MATCH  SET r.amount = '', r.date = '1분기';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '인도네시아'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '1분기'
  ON MATCH  SET r.amount = '', r.date = '1분기';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '베트남'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '1분기'
  ON MATCH  SET r.amount = '', r.date = '1분기';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '인도'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '1분기'
  ON MATCH  SET r.amount = '', r.date = '1분기';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '멕시코'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '1분기'
  ON MATCH  SET r.amount = '', r.date = '1분기';

MATCH (a:PERSON {name: '김상우'}),
      (b:COMPANY   {name: '파세코'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '리테일사업부 상무', r.since = ''
  ON MATCH  SET r.position = '리테일사업부 상무', r.since = '';

MATCH (a:PERSON {name: '박치호'}),
      (b:COMPANY   {name: '파세코'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '기술연구소 팀장', r.since = ''
  ON MATCH  SET r.position = '기술연구소 팀장', r.since = '';

MATCH (a:COMPANY {name: '파세코'}),
      (b:PRODUCT   {name: '창문형 에어컨'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '파세코'}),
      (b:PRODUCT   {name: '서큘레이터'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '파세코'}),
      (b:PRODUCT   {name: '보디드라이어'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '파세코'}),
      (b:TECHNOLOGY   {name: 'AI 에너지 세이빙'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '파세코'}),
      (b:TECHNOLOGY   {name: 'AI 제어 모드'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '파세코'}),
      (b:TECHNOLOGY   {name: '환기 시스템'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '파세코'}),
      (b:LOCATION   {name: '안산'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:COMPANY   {name: '현대백화점그룹'})
MERGE (a)-[r:SUBSIDIARY_OF]->(b);

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:ORGANIZATION   {name: '한국중소벤처기업유통원'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '소상공인 온라인쇼핑몰 판매지원사업', r.date = '2023'
  ON MATCH  SET r.type = '소상공인 온라인쇼핑몰 판매지원사업', r.date = '2023';

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:PROJECT   {name: '소상공인 온라인쇼핑몰 판매지원사업'})
MERGE (a)-[r:PARTICIPATES_IN]->(b);

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:ORGANIZATION   {name: '경기도'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:COMPANY {name: '한국서부발전'}),
      (b:EVENT   {name: '발전정보 활용 창업·벤처기업 협업사업 공모'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-10-14'
  ON MATCH  SET r.date = '2023-10-14';

MATCH (a:COMPANY {name: '한국서부발전'}),
      (b:INVESTMENT   {name: '창업·벤처기업 지원'})
MERGE (a)-[r:MADE_INVESTMENT]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:AGREEMENT   {name: '글로벌 물류 지원 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:AGREEMENT   {name: '글로벌 물류 지원 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:ORGANIZATION   {name: '부산항만공사'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = 'Logistics Collaboration', r.date = '2023-10-14'
  ON MATCH  SET r.type = 'Logistics Collaboration', r.date = '2023-10-14';

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:ORGANIZATION   {name: '스마트트레이드허브'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:ORGANIZATION {name: '스마트트레이드허브'}),
      (b:LOCATION   {name: '인천'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '로스앤젤레스'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '롱비치'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '부산'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:PROJECT   {name: '수출 중소벤처기업 글로벌 물류 지원'})
MERGE (a)-[r:LEADS]->(b);

MATCH (a:PERSON {name: '강석진'}),
      (b:ORGANIZATION   {name: '중소벤처기업진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장', r.since = ''
  ON MATCH  SET r.position = '이사장', r.since = '';

MATCH (a:_UNSPEC {name: 'EVENT'}),
      (b:PROJECT   {name: '수출 중소벤처기업 글로벌 물류 지원'})
MERGE (a)-[r:AFFECTS]->(b)
  ON CREATE SET r.impact = 'Negative'
  ON MATCH  SET r.impact = 'Negative';

MATCH (a:ORGANIZATION {name: '중소벤처기업부'}),
      (b:REPORT   {name: '2025년도 1분기 중소기업 수출 동향'})
MERGE (a)-[r:PUBLISHED]->(b);

MATCH (a:PERSON {name: '이순배'}),
      (b:ORGANIZATION   {name: '중소벤처기업부'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '글로벌성장정책관', r.since = ''
  ON MATCH  SET r.position = '글로벌성장정책관', r.since = '';

MATCH (a:EVENT {name: '미국의 25% 관세 부과'}),
      (b:PRODUCT   {name: '철강'})
MERGE (a)-[r:AFFECTS]->(b)
  ON CREATE SET r.impact = 'Negative'
  ON MATCH  SET r.impact = 'Negative';

MATCH (a:EVENT {name: '미국의 25% 관세 부과'}),
      (b:PRODUCT   {name: '알루미늄'})
MERGE (a)-[r:AFFECTS]->(b)
  ON CREATE SET r.impact = 'Negative'
  ON MATCH  SET r.impact = 'Negative';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '18억4000만 달러', r.date = '1분기'
  ON MATCH  SET r.amount = '18억4000만 달러', r.date = '1분기';

MATCH (a:PRODUCT {name: '자동차'}),
      (b:LOCATION   {name: '키르기스스탄'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '17억4000만 달러', r.date = '1분기'
  ON MATCH  SET r.amount = '17억4000만 달러', r.date = '1분기';

MATCH (a:PRODUCT {name: '자동차'}),
      (b:LOCATION   {name: '독립국가연합'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '17억4000만 달러', r.date = '1분기'
  ON MATCH  SET r.amount = '17억4000만 달러', r.date = '1분기';

MATCH (a:ORGANIZATION {name: '동반성장위원회'}),
      (b:AGREEMENT   {name: '협력사 ESG 지원사업 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:AGREEMENT   {name: '협력사 ESG 지원사업 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:PERSON   {name: '에이피텍'})
MERGE (a)-[r:SUPPLIES]->(b)
  ON CREATE SET r.product = '휴대전화 카메라 모듈 제조설비', r.industry = '전자'
  ON MATCH  SET r.product = '휴대전화 카메라 모듈 제조설비', r.industry = '전자';

MATCH (a:PERSON {name: '에이피텍'}),
      (b:_UNSPEC   {name: 'AWARD'})
MERGE (a)-[r:RECEIVED]->(b);

MATCH (a:PERSON {name: '박치형'}),
      (b:ORGANIZATION   {name: '동반성장위원회'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '운영처장', r.since = ''
  ON MATCH  SET r.position = '운영처장', r.since = '';

MATCH (a:PERSON {name: '김준성'}),
      (b:COMPANY   {name: 'LG이노텍'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '상무', r.since = ''
  ON MATCH  SET r.position = '상무', r.since = '';

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:ORGANIZATION   {name: '동반성장위원회'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '협력사 ESG지원', r.date = '2023-10-14'
  ON MATCH  SET r.type = '협력사 ESG지원', r.date = '2023-10-14';

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:_UNSPEC   {name: 'PRODUCT'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:ORGANIZATION {name: '동반성장위원회'}),
      (b:LOCATION   {name: '인천'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:ORGANIZATION   {name: '부산항만공사'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = 'Logistics Collaboration', r.date = '2023-10-14'
  ON MATCH  SET r.type = 'Logistics Collaboration', r.date = '2023-10-14';

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:ORGANIZATION   {name: '스마트트레이드허브'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '로스앤젤레스'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '롱비치'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:AGREEMENT   {name: '글로벌 물류 지원 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:EVENT {name: '미국의 관세 정책'}),
      (b:ORGANIZATION   {name: '중소벤처기업진흥공단'})
MERGE (a)-[r:AFFECTS]->(b)
  ON CREATE SET r.impact = 'Negative'
  ON MATCH  SET r.impact = 'Negative';

MATCH (a:PERSON {name: '강석진'}),
      (b:ORGANIZATION   {name: '중소벤처기업진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장', r.since = ''
  ON MATCH  SET r.position = '이사장', r.since = '';

MATCH (a:COMPANY {name: '한샘'}),
      (b:COMPANY   {name: '현대리바트'})
MERGE (a)-[r:COMPETES_WITH]->(b)
  ON CREATE SET r.market = '가구'
  ON MATCH  SET r.market = '가구';

MATCH (a:COMPANY {name: '한샘'}),
      (b:PROJECT   {name: '오피스 인테리어 사업 확장'})
MERGE (a)-[r:PARTNERED_WITH]->(b);

MATCH (a:COMPANY {name: '현대리바트'}),
      (b:PROJECT   {name: '오피스 인테리어 사업 확장'})
MERGE (a)-[r:PARTNERED_WITH]->(b);

MATCH (a:COMPANY {name: '한샘'}),
      (b:INDUSTRY   {name: 'B2B'})
MERGE (a)-[r:AFFECTED_BY]->(b);

MATCH (a:COMPANY {name: '현대리바트'}),
      (b:INDUSTRY   {name: 'B2B'})
MERGE (a)-[r:AFFECTED_BY]->(b);

MATCH (a:COMPANY {name: '한샘'}),
      (b:INDUSTRY   {name: 'B2C'})
MERGE (a)-[r:AFFECTED_BY]->(b);

MATCH (a:COMPANY {name: '현대리바트'}),
      (b:INDUSTRY   {name: 'B2C'})
MERGE (a)-[r:AFFECTED_BY]->(b);