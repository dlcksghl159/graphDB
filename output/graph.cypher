CREATE CONSTRAINT IF NOT EXISTS FOR (n:AGREEMENT) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:COMPANY) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:CONCEPT) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:EVENT) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:FINANCIAL_METRIC) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:INDUSTRY) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:INVESTMENT) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:LEGAL) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:LOCATION) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:MARKET) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:ORGANIZATION) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:PERSON) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:PRODUCT) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:PROJECT) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:REPORT) REQUIRE n.name IS UNIQUE;

CREATE CONSTRAINT IF NOT EXISTS FOR (n:TECHNOLOGY) REQUIRE n.name IS UNIQUE;

MERGE (n:COMPANY {name: '에이스침대'})
  ON CREATE SET n.industry = '가구', n.headquarters = '', n.aliases = ["에이스침대"]
  ON MATCH  SET n.industry = '가구', n.headquarters = '', n.aliases = ["에이스침대"];

MERGE (n:FINANCIAL_METRIC {name: '매출'})
  ON CREATE SET n.amount = '814억원', n.change = '-2.8%', n.period = '1분기', n.aliases = ["매출"]
  ON MATCH  SET n.amount = '814억원', n.change = '-2.8%', n.period = '1분기', n.aliases = ["매출"];

MERGE (n:FINANCIAL_METRIC {name: '영업이익'})
  ON CREATE SET n.amount = '121억원', n.change = '-18.3%', n.period = '1분기', n.aliases = ["영업이익"]
  ON MATCH  SET n.amount = '121억원', n.change = '-18.3%', n.period = '1분기', n.aliases = ["영업이익"];

MERGE (n:FINANCIAL_METRIC {name: '분기순이익'})
  ON CREATE SET n.amount = '95억원', n.change = '-31.7%', n.period = '1분기', n.aliases = ["분기순이익"]
  ON MATCH  SET n.amount = '95억원', n.change = '-31.7%', n.period = '1분기', n.aliases = ["분기순이익"];

MERGE (n:CONCEPT {name: '경영환경 악화'})
  ON CREATE SET n.description = '세계 경제 악화와 내부경기 침체', n.aliases = ["경영환경 악화"]
  ON MATCH  SET n.description = '세계 경제 악화와 내부경기 침체', n.aliases = ["경영환경 악화"];

MERGE (n:CONCEPT {name: '경영 내실화'})
  ON CREATE SET n.description = '경영의 내실화를 위해 노력', n.aliases = ["경영 내실화"]
  ON MATCH  SET n.description = '경영의 내실화를 위해 노력', n.aliases = ["경영 내실화"];

MERGE (n:COMPANY {name: '에이텀'})
  ON CREATE SET n.full_name = '에이텀', n.industry = '전자', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["에이텀"]
  ON MATCH  SET n.full_name = '에이텀', n.industry = '전자', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["에이텀"];

MERGE (n:COMPANY {name: 'DST'})
  ON CREATE SET n.full_name = 'DST', n.industry = '조선 및 방산', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["DST"]
  ON MATCH  SET n.full_name = 'DST', n.industry = '조선 및 방산', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["DST"];

MERGE (n:COMPANY {name: '밸류파인더'})
  ON CREATE SET n.full_name = '밸류파인더', n.industry = '리서치', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["밸류파인더"]
  ON MATCH  SET n.full_name = '밸류파인더', n.industry = '리서치', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["밸류파인더"];

MERGE (n:PERSON {name: '이충헌'})
  ON CREATE SET n.full_name = '이충헌', n.role = '연구원', n.nationality = '', n.age = '', n.aliases = ["이충헌"]
  ON MATCH  SET n.full_name = '이충헌', n.role = '연구원', n.nationality = '', n.age = '', n.aliases = ["이충헌"];

MERGE (n:COMPANY {name: 'Samsung'})
  ON CREATE SET n.full_name = '삼성전자', n.industry = '전자', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["Samsung"]
  ON MATCH  SET n.full_name = '삼성전자', n.industry = '전자', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["Samsung"];

MERGE (n:COMPANY {name: 'HD현대중공업'})
  ON CREATE SET n.full_name = 'HD현대중공업', n.industry = '조선', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["HD현대중공업"]
  ON MATCH  SET n.full_name = 'HD현대중공업', n.industry = '조선', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["HD현대중공업"];

MERGE (n:COMPANY {name: 'HD현대마린솔루션'})
  ON CREATE SET n.full_name = 'HD현대마린솔루션', n.industry = '조선', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["HD현대마린솔루션"]
  ON MATCH  SET n.full_name = 'HD현대마린솔루션', n.industry = '조선', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["HD현대마린솔루션"];

MERGE (n:COMPANY {name: 'STX엔진'})
  ON CREATE SET n.full_name = 'STX엔진', n.industry = '조선', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["STX엔진"]
  ON MATCH  SET n.full_name = 'STX엔진', n.industry = '조선', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["STX엔진"];

MERGE (n:PRODUCT {name: 'TA트랜스'})
  ON CREATE SET n.category = '전자제품', n.description = '휴대용 충전기에 탑재되는 트랜스', n.launch_date = '', n.company = '에이텀', n.aliases = ["TA트랜스"]
  ON MATCH  SET n.category = '전자제품', n.description = '휴대용 충전기에 탑재되는 트랜스', n.launch_date = '', n.company = '에이텀', n.aliases = ["TA트랜스"];

MERGE (n:PRODUCT {name: 'TV트랜스'})
  ON CREATE SET n.category = '전자제품', n.description = 'TV에 탑재되는 트랜스', n.launch_date = '', n.company = '에이텀', n.aliases = ["TV트랜스"]
  ON MATCH  SET n.category = '전자제품', n.description = 'TV에 탑재되는 트랜스', n.launch_date = '', n.company = '에이텀', n.aliases = ["TV트랜스"];

MERGE (n:PRODUCT {name: '전기차용 트랜스'})
  ON CREATE SET n.category = '전자제품', n.description = '전기차에 사용되는 트랜스', n.launch_date = '', n.company = '에이텀', n.aliases = ["전기차용 트랜스"]
  ON MATCH  SET n.category = '전자제품', n.description = '전기차에 사용되는 트랜스', n.launch_date = '', n.company = '에이텀', n.aliases = ["전기차용 트랜스"];

MERGE (n:PRODUCT {name: '힘센엔진 실린더'})
  ON CREATE SET n.category = '조선 부품', n.description = 'HD현대중공업의 힘센엔진에 사용되는 실린더', n.launch_date = '', n.company = 'DST', n.aliases = ["힘센엔진 실린더"]
  ON MATCH  SET n.category = '조선 부품', n.description = 'HD현대중공업의 힘센엔진에 사용되는 실린더', n.launch_date = '', n.company = 'DST', n.aliases = ["힘센엔진 실린더"];

MERGE (n:EVENT {name: 'DST 인수'})
  ON CREATE SET n.date = '2023-02-02', n.type = '인수', n.description = '에이텀이 DST 지분 50%를 인수', n.aliases = ["DST 인수"]
  ON MATCH  SET n.date = '2023-02-02', n.type = '인수', n.description = '에이텀이 DST 지분 50%를 인수', n.aliases = ["DST 인수"];

MERGE (n:COMPANY {name: 'HiMSEN'})
  ON CREATE SET n.aliases = ["HiMSEN"]
  ON MATCH  SET n.aliases = ["HiMSEN"];

MERGE (n:ORGANIZATION {name: '중소벤처기업진흥공단'})
  ON CREATE SET n.type = '공공기관', n.description = '중소벤처기업의 지원을 담당하는 기관', n.headquarters = '', n.aliases = ["중소벤처기업진흥공단"]
  ON MATCH  SET n.type = '공공기관', n.description = '중소벤처기업의 지원을 담당하는 기관', n.headquarters = '', n.aliases = ["중소벤처기업진흥공단"];

MERGE (n:ORGANIZATION {name: '부산항만공사'})
  ON CREATE SET n.type = '공공기관', n.description = '부산항의 운영 및 관리를 담당하는 기관', n.headquarters = '부산', n.aliases = ["부산항만공사"]
  ON MATCH  SET n.type = '공공기관', n.description = '부산항의 운영 및 관리를 담당하는 기관', n.headquarters = '부산', n.aliases = ["부산항만공사"];

MERGE (n:LOCATION {name: '부산'})
  ON CREATE SET n.type = '지역', n.country = '대한민국', n.region = '경상남도', n.aliases = ["부산"]
  ON MATCH  SET n.type = '지역', n.country = '대한민국', n.region = '경상남도', n.aliases = ["부산"];

MERGE (n:LOCATION {name: '인천'})
  ON CREATE SET n.type = '지역', n.country = '대한민국', n.region = '인천광역시', n.aliases = ["인천"]
  ON MATCH  SET n.type = '지역', n.country = '대한민국', n.region = '인천광역시', n.aliases = ["인천"];

MERGE (n:LOCATION {name: '여수 광양'})
  ON CREATE SET n.type = '지역', n.country = '대한민국', n.region = '전라남도', n.aliases = ["여수 광양"]
  ON MATCH  SET n.type = '지역', n.country = '대한민국', n.region = '전라남도', n.aliases = ["여수 광양"];

MERGE (n:LOCATION {name: '로스앤젤레스'})
  ON CREATE SET n.type = '도시', n.country = '미국', n.region = '캘리포니아', n.aliases = ["로스앤젤레스"]
  ON MATCH  SET n.type = '도시', n.country = '미국', n.region = '캘리포니아', n.aliases = ["로스앤젤레스"];

MERGE (n:LOCATION {name: '롱비치'})
  ON CREATE SET n.type = '도시', n.country = '미국', n.region = '캘리포니아', n.aliases = ["롱비치"]
  ON MATCH  SET n.type = '도시', n.country = '미국', n.region = '캘리포니아', n.aliases = ["롱비치"];

MERGE (n:PROJECT {name: '통합물류 지원 플랫폼'})
  ON CREATE SET n.description = '중소기업 전용 항공·해운 통합물류 지원 플랫폼 구축', n.start_date = '', n.status = '계획 중', n.aliases = ["통합물류 지원 플랫폼"]
  ON MATCH  SET n.description = '중소기업 전용 항공·해운 통합물류 지원 플랫폼 구축', n.start_date = '', n.status = '계획 중', n.aliases = ["통합물류 지원 플랫폼"];

MERGE (n:AGREEMENT {name: '글로벌 물류 지원 업무협약'})
  ON CREATE SET n.type = '협력', n.date = '2023-04-14', n.description = '중소벤처기업진흥공단과 부산항만공사의 글로벌 물류 지원 협약', n.aliases = ["글로벌 물류 지원 업무협약"]
  ON MATCH  SET n.type = '협력', n.date = '2023-04-14', n.description = '중소벤처기업진흥공단과 부산항만공사의 글로벌 물류 지원 협약', n.aliases = ["글로벌 물류 지원 업무협약"];

MERGE (n:PERSON {name: '강석진'})
  ON CREATE SET n.full_name = '강석진', n.role = '이사장', n.nationality = '', n.age = '', n.aliases = ["강석진"]
  ON MATCH  SET n.full_name = '강석진', n.role = '이사장', n.nationality = '', n.age = '', n.aliases = ["강석진"];

MERGE (n:ORGANIZATION {name: '스마트트레이드허브'})
  ON CREATE SET n.type = '물류센터', n.description = '중소기업 전용 항공물류센터', n.headquarters = '', n.aliases = ["스마트트레이드허브"]
  ON MATCH  SET n.type = '물류센터', n.description = '중소기업 전용 항공물류센터', n.headquarters = '', n.aliases = ["스마트트레이드허브"];

MERGE (n:PERSON {name: '이은'})
  ON CREATE SET n.role = '사장', n.aliases = ["이은"]
  ON MATCH  SET n.role = '사장', n.aliases = ["이은"];

MERGE (n:PERSON {name: '중진공'})
  ON CREATE SET n.role = '이사', n.aliases = ["중진공"]
  ON MATCH  SET n.role = '이사', n.aliases = ["중진공"];

MERGE (n:COMPANY {name: 'BPA'})
  ON CREATE SET n.aliases = ["BPA"]
  ON MATCH  SET n.aliases = ["BPA"];

MERGE (n:PROJECT {name: '스마트트레이드허브'})
  ON CREATE SET n.description = '중소기업 전용 항공물류센터', n.start_date = '', n.status = '운영 중', n.aliases = ["스마트트레이드허브"]
  ON MATCH  SET n.description = '중소기업 전용 항공물류센터', n.start_date = '', n.status = '운영 중', n.aliases = ["스마트트레이드허브"];

MERGE (n:ORGANIZATION {name: '동반성장위원회'})
  ON CREATE SET n.type = '위원회', n.description = '대기업과 중소기업의 상생 협력을 지원하는 조직', n.aliases = ["동반성장위원회"], n.headquarters = ''
  ON MATCH  SET n.type = '위원회', n.description = '대기업과 중소기업의 상생 협력을 지원하는 조직', n.aliases = ["동반성장위원회"], n.headquarters = '';

MERGE (n:COMPANY {name: 'LG이노텍'})
  ON CREATE SET n.full_name = 'LG이노텍', n.industry = '전기전자', n.headquarters = '', n.founded = '', n.ceo = '김준성', n.aliases = ["LG이노텍"]
  ON MATCH  SET n.full_name = 'LG이노텍', n.industry = '전기전자', n.headquarters = '', n.founded = '', n.ceo = '김준성', n.aliases = ["LG이노텍"];

MERGE (n:COMPANY {name: '에이피텍'})
  ON CREATE SET n.full_name = '에이피텍', n.industry = '제조', n.headquarters = '인천 송도', n.founded = '', n.ceo = '', n.aliases = ["에이피텍"]
  ON MATCH  SET n.full_name = '에이피텍', n.industry = '제조', n.headquarters = '인천 송도', n.founded = '', n.ceo = '', n.aliases = ["에이피텍"];

MERGE (n:EVENT {name: '협력사 ESG 지원사업 업무협약'})
  ON CREATE SET n.date = '2023-04-14', n.type = '협약', n.description = '동반위와 LG이노텍의 협력사 ESG 지원사업 업무협약 체결', n.aliases = ["협력사 ESG 지원사업 업무협약"]
  ON MATCH  SET n.date = '2023-04-14', n.type = '협약', n.description = '동반위와 LG이노텍의 협력사 ESG 지원사업 업무협약 체결', n.aliases = ["협력사 ESG 지원사업 업무협약"];

MERGE (n:PROJECT {name: '대·중소 자율형 ESG 지원사업'})
  ON CREATE SET n.description = '대기업과 중소기업의 자율적인 ESG 지원사업', n.start_date = '2023', n.status = '진행 중', n.aliases = ["대·중소 자율형 ESG 지원사업"]
  ON MATCH  SET n.description = '대기업과 중소기업의 자율적인 ESG 지원사업', n.start_date = '2023', n.status = '진행 중', n.aliases = ["대·중소 자율형 ESG 지원사업"];

MERGE (n:PERSON {name: '박치형'})
  ON CREATE SET n.full_name = '박치형', n.role = '동반위 운영처장', n.nationality = '', n.age = '', n.aliases = ["박치형"]
  ON MATCH  SET n.full_name = '박치형', n.role = '동반위 운영처장', n.nationality = '', n.age = '', n.aliases = ["박치형"];

MERGE (n:PERSON {name: '김준성'})
  ON CREATE SET n.full_name = '김준성', n.role = 'LG이노텍 상무', n.nationality = '', n.age = '', n.aliases = ["김준성"]
  ON MATCH  SET n.full_name = '김준성', n.role = 'LG이노텍 상무', n.nationality = '', n.age = '', n.aliases = ["김준성"];

MERGE (n:CONCEPT {name: 'ESG'})
  ON CREATE SET n.type = '환경, 사회, 지배구조', n.description = '기업의 지속 가능성을 평가하는 기준', n.aliases = ["ESG"]
  ON MATCH  SET n.type = '환경, 사회, 지배구조', n.description = '기업의 지속 가능성을 평가하는 기준', n.aliases = ["ESG"];

MERGE (n:CONCEPT {name: '2040 탄소중립'})
  ON CREATE SET n.type = '환경 목표', n.description = '2040년까지 탄소 배출을 중립화하는 목표', n.aliases = ["2040 탄소중립"]
  ON MATCH  SET n.type = '환경 목표', n.description = '2040년까지 탄소 배출을 중립화하는 목표', n.aliases = ["2040 탄소중립"];

MERGE (n:CONCEPT {name: '2030년 RE100 달성'})
  ON CREATE SET n.type = '환경 목표', n.description = '2030년까지 재생에너지 100% 사용 목표', n.aliases = ["2030년 RE100 달성"]
  ON MATCH  SET n.type = '환경 목표', n.description = '2030년까지 재생에너지 100% 사용 목표', n.aliases = ["2030년 RE100 달성"];

MERGE (n:MARKET {name: '중소기업 수출 시장'})
  ON CREATE SET n.description = '중소기업의 수출 동향', n.aliases = ["중소기업 수출 시장"]
  ON MATCH  SET n.description = '중소기업의 수출 동향', n.aliases = ["중소기업 수출 시장"];

MERGE (n:PRODUCT {name: '화장품'})
  ON CREATE SET n.category = '소비재', n.description = 'K뷰티 인기 지속', n.launch_date = '', n.company = '', n.aliases = ["화장품"]
  ON MATCH  SET n.category = '소비재', n.description = 'K뷰티 인기 지속', n.launch_date = '', n.company = '', n.aliases = ["화장품"];

MERGE (n:PRODUCT {name: '자동차'})
  ON CREATE SET n.category = '운송수단', n.description = '한국산 중고차 인기', n.launch_date = '', n.company = '', n.aliases = ["자동차"]
  ON MATCH  SET n.category = '운송수단', n.description = '한국산 중고차 인기', n.launch_date = '', n.company = '', n.aliases = ["자동차"];

MERGE (n:PRODUCT {name: '플라스틱 제품'})
  ON CREATE SET n.category = '소재', n.description = '', n.launch_date = '', n.company = '', n.aliases = ["플라스틱 제품"]
  ON MATCH  SET n.category = '소재', n.description = '', n.launch_date = '', n.company = '', n.aliases = ["플라스틱 제품"];

MERGE (n:PRODUCT {name: '자동차부품'})
  ON CREATE SET n.category = '부품', n.description = '', n.launch_date = '', n.company = '', n.aliases = ["자동차부품"]
  ON MATCH  SET n.category = '부품', n.description = '', n.launch_date = '', n.company = '', n.aliases = ["자동차부품"];

MERGE (n:PRODUCT {name: '합성수지'})
  ON CREATE SET n.category = '소재', n.description = '', n.launch_date = '', n.company = '', n.aliases = ["합성수지"]
  ON MATCH  SET n.category = '소재', n.description = '', n.launch_date = '', n.company = '', n.aliases = ["합성수지"];

MERGE (n:PRODUCT {name: '반도체제조용장비'})
  ON CREATE SET n.category = '장비', n.description = '', n.launch_date = '', n.company = '', n.aliases = ["반도체제조용장비"]
  ON MATCH  SET n.category = '장비', n.description = '', n.launch_date = '', n.company = '', n.aliases = ["반도체제조용장비"];

MERGE (n:LOCATION {name: '미국'})
  ON CREATE SET n.type = '국가', n.country = '미국', n.region = '', n.aliases = ["미국"]
  ON MATCH  SET n.type = '국가', n.country = '미국', n.region = '', n.aliases = ["미국"];

MERGE (n:LOCATION {name: '중국'})
  ON CREATE SET n.type = '국가', n.country = '중국', n.region = '', n.aliases = ["중국"]
  ON MATCH  SET n.type = '국가', n.country = '중국', n.region = '', n.aliases = ["중국"];

MERGE (n:LOCATION {name: '일본'})
  ON CREATE SET n.type = '국가', n.country = '일본', n.region = '', n.aliases = ["일본"]
  ON MATCH  SET n.type = '국가', n.country = '일본', n.region = '', n.aliases = ["일본"];

MERGE (n:LOCATION {name: '홍콩'})
  ON CREATE SET n.type = '특별행정구', n.country = '중국', n.region = '', n.aliases = ["홍콩"]
  ON MATCH  SET n.type = '특별행정구', n.country = '중국', n.region = '', n.aliases = ["홍콩"];

MERGE (n:LOCATION {name: '대만'})
  ON CREATE SET n.type = '국가', n.country = '대만', n.region = '', n.aliases = ["대만"]
  ON MATCH  SET n.type = '국가', n.country = '대만', n.region = '', n.aliases = ["대만"];

MERGE (n:LOCATION {name: '태국'})
  ON CREATE SET n.type = '국가', n.country = '태국', n.region = '', n.aliases = ["태국"]
  ON MATCH  SET n.type = '국가', n.country = '태국', n.region = '', n.aliases = ["태국"];

MERGE (n:LOCATION {name: '인도네시아'})
  ON CREATE SET n.type = '국가', n.country = '인도네시아', n.region = '', n.aliases = ["인도네시아"]
  ON MATCH  SET n.type = '국가', n.country = '인도네시아', n.region = '', n.aliases = ["인도네시아"];

MERGE (n:LOCATION {name: '키르기스스탄'})
  ON CREATE SET n.type = '국가', n.country = '키르기스스탄', n.region = '', n.aliases = ["키르기스스탄"]
  ON MATCH  SET n.type = '국가', n.country = '키르기스스탄', n.region = '', n.aliases = ["키르기스스탄"];

MERGE (n:LOCATION {name: 'CIS'})
  ON CREATE SET n.type = '지역', n.country = '', n.region = '독립국가연합', n.aliases = ["CIS"]
  ON MATCH  SET n.type = '지역', n.country = '', n.region = '독립국가연합', n.aliases = ["CIS"];

MERGE (n:PRODUCT {name: '철강'})
  ON CREATE SET n.category = '소재', n.description = '', n.launch_date = '', n.company = '', n.aliases = ["철강"]
  ON MATCH  SET n.category = '소재', n.description = '', n.launch_date = '', n.company = '', n.aliases = ["철강"];

MERGE (n:PRODUCT {name: '알루미늄'})
  ON CREATE SET n.category = '소재', n.description = '', n.launch_date = '', n.company = '', n.aliases = ["알루미늄"]
  ON MATCH  SET n.category = '소재', n.description = '', n.launch_date = '', n.company = '', n.aliases = ["알루미늄"];

MERGE (n:EVENT {name: '미국 관세 정책'})
  ON CREATE SET n.date = '2023-03', n.type = '정책', n.description = '미국의 25% 관세 부과', n.aliases = ["미국 관세 정책"]
  ON MATCH  SET n.date = '2023-03', n.type = '정책', n.description = '미국의 25% 관세 부과', n.aliases = ["미국 관세 정책"];

MERGE (n:ORGANIZATION {name: '중소벤처기업부'})
  ON CREATE SET n.type = '정부기관', n.description = '중소기업 수출 동향 발표', n.headquarters = '대한민국', n.aliases = ["중소벤처기업부"]
  ON MATCH  SET n.type = '정부기관', n.description = '중소기업 수출 동향 발표', n.headquarters = '대한민국', n.aliases = ["중소벤처기업부"];

MERGE (n:PERSON {name: '이순배'})
  ON CREATE SET n.full_name = '이순배', n.role = '글로벌성장정책관', n.nationality = '대한민국', n.age = '', n.aliases = ["이순배"]
  ON MATCH  SET n.full_name = '이순배', n.role = '글로벌성장정책관', n.nationality = '대한민국', n.age = '', n.aliases = ["이순배"];

MERGE (n:ORGANIZATION {name: '기술보증기금 지식재산공제센터'})
  ON CREATE SET n.type = '기관', n.description = '지식재산공제사업 활성화를 위한 기관', n.aliases = ["기술보증기금 지식재산공제센터"]
  ON MATCH  SET n.type = '기관', n.description = '지식재산공제사업 활성화를 위한 기관', n.aliases = ["기술보증기금 지식재산공제센터"];

MERGE (n:ORGANIZATION {name: '인천지식재산센터'})
  ON CREATE SET n.type = '기관', n.description = '인천지역의 지식재산 관련 지원 기관', n.aliases = ["인천지식재산센터"]
  ON MATCH  SET n.type = '기관', n.description = '인천지역의 지식재산 관련 지원 기관', n.aliases = ["인천지식재산센터"];

MERGE (n:AGREEMENT {name: '지식재산공제사업 활성화를 통한 공동발전 업무 협약'})
  ON CREATE SET n.type = '협약', n.date = '2023-04-14', n.description = '지식재산공제사업 활성화를 위한 협력', n.aliases = ["지식재산공제사업 활성화를 통한 공동발전 업무 협약"]
  ON MATCH  SET n.type = '협약', n.date = '2023-04-14', n.description = '지식재산공제사업 활성화를 위한 협력', n.aliases = ["지식재산공제사업 활성화를 통한 공동발전 업무 협약"];

MERGE (n:PROJECT {name: '지식재산공제사업'})
  ON CREATE SET n.description = '중소·중견기업의 지식재산 비용 부담과 분쟁 리스크를 줄이고 해외 진출을 뒷받침하기 위한 금융제도', n.start_date = '2019', n.status = '활성화 중', n.aliases = ["지식재산공제사업"]
  ON MATCH  SET n.description = '중소·중견기업의 지식재산 비용 부담과 분쟁 리스크를 줄이고 해외 진출을 뒷받침하기 위한 금융제도', n.start_date = '2019', n.status = '활성화 중', n.aliases = ["지식재산공제사업"];

MERGE (n:ORGANIZATION {name: '특허청'})
  ON CREATE SET n.type = '정부 기관', n.description = '지식재산 관련 정책 및 지원', n.aliases = ["특허청"]
  ON MATCH  SET n.type = '정부 기관', n.description = '지식재산 관련 정책 및 지원', n.aliases = ["특허청"];

MERGE (n:COMPANY {name: '한샘'})
  ON CREATE SET n.industry = '가구', n.founded = '', n.ceo = '', n.aliases = ["한샘"]
  ON MATCH  SET n.industry = '가구', n.founded = '', n.ceo = '', n.aliases = ["한샘"];

MERGE (n:COMPANY {name: '현대리바트'})
  ON CREATE SET n.industry = '가구', n.founded = '', n.ceo = '', n.aliases = ["현대리바트"]
  ON MATCH  SET n.industry = '가구', n.founded = '', n.ceo = '', n.aliases = ["현대리바트"];

MERGE (n:MARKET {name: '건설경기'})
  ON CREATE SET n.description = '건설 산업의 경기 상황', n.aliases = ["건설경기"]
  ON MATCH  SET n.description = '건설 산업의 경기 상황', n.aliases = ["건설경기"];

MERGE (n:INDUSTRY {name: 'B2B'})
  ON CREATE SET n.description = '소매업 산업', n.aliases = ["B2B"]
  ON MATCH  SET n.description = '소매업 산업', n.aliases = ["B2B"];

MERGE (n:INDUSTRY {name: 'B2C'})
  ON CREATE SET n.description = '소비자 직접 판매 산업', n.aliases = ["B2C"]
  ON MATCH  SET n.description = '소비자 직접 판매 산업', n.aliases = ["B2C"];

MERGE (n:EVENT {name: '1분기 매출 감소'})
  ON CREATE SET n.date = '2025-01-01 to 2025-03-31', n.type = '재무 결과', n.description = '한샘과 현대리바트의 매출 감소', n.aliases = ["1분기 매출 감소"]
  ON MATCH  SET n.date = '2025-01-01 to 2025-03-31', n.type = '재무 결과', n.description = '한샘과 현대리바트의 매출 감소', n.aliases = ["1분기 매출 감소"];

MERGE (n:EVENT {name: '오피스 인테리어 사업 확장'})
  ON CREATE SET n.date = '2025', n.type = '사업 확장', n.description = '한샘과 현대리바트의 오피스 인테리어 시장 진출', n.aliases = ["오피스 인테리어 사업 확장"]
  ON MATCH  SET n.date = '2025', n.type = '사업 확장', n.description = '한샘과 현대리바트의 오피스 인테리어 시장 진출', n.aliases = ["오피스 인테리어 사업 확장"];

MERGE (n:EVENT {name: 'ESG 지원 업무협약 체결식'})
  ON CREATE SET n.date = '2023-04-14', n.type = '협약식', n.description = '동반성장위원회와 LG이노텍의 협력사 ESG 지원 업무협약 체결', n.location = '인천 송도 에이피텍 본사', n.aliases = ["ESG 지원 업무협약 체결식"]
  ON MATCH  SET n.date = '2023-04-14', n.type = '협약식', n.description = '동반성장위원회와 LG이노텍의 협력사 ESG 지원 업무협약 체결', n.location = '인천 송도 에이피텍 본사', n.aliases = ["ESG 지원 업무협약 체결식"];

MERGE (n:PERSON {name: '피텍등이참석'})
  ON CREATE SET n.role = '대표', n.aliases = ["피텍등이참석"]
  ON MATCH  SET n.role = '대표', n.aliases = ["피텍등이참석"];

MERGE (n:PERSON {name: '에이피텍'})
  ON CREATE SET n.role = '대표', n.aliases = ["에이피텍"]
  ON MATCH  SET n.role = '대표', n.aliases = ["에이피텍"];

MERGE (n:COMPANY {name: 'ESG'})
  ON CREATE SET n.aliases = ["ESG"]
  ON MATCH  SET n.aliases = ["ESG"];

MERGE (n:COMPANY {name: '현대이지웰'})
  ON CREATE SET n.full_name = '현대이지웰', n.industry = '복지솔루션', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["현대이지웰"]
  ON MATCH  SET n.full_name = '현대이지웰', n.industry = '복지솔루션', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["현대이지웰"];

MERGE (n:COMPANY {name: '현대백화점그룹'})
  ON CREATE SET n.full_name = '현대백화점그룹', n.industry = '유통', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["현대백화점그룹"]
  ON MATCH  SET n.full_name = '현대백화점그룹', n.industry = '유통', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["현대백화점그룹"];

MERGE (n:ORGANIZATION {name: '한국중소벤처기업유통원'})
  ON CREATE SET n.type = '정부기관', n.description = '중소벤처기업부 산하', n.headquarters = '', n.aliases = ["한국중소벤처기업유통원"]
  ON MATCH  SET n.type = '정부기관', n.description = '중소벤처기업부 산하', n.headquarters = '', n.aliases = ["한국중소벤처기업유통원"];

MERGE (n:AGREEMENT {name: '다농마트 청년몰 이용 활성화를 위한 업무협약'})
  ON CREATE SET n.type = '업무 협약', n.date = '2023', n.description = '다농마트 청년몰과의 협력', n.aliases = ["다농마트 청년몰 이용 활성화를 위한 업무협약"]
  ON MATCH  SET n.type = '업무 협약', n.date = '2023', n.description = '다농마트 청년몰과의 협력', n.aliases = ["다농마트 청년몰 이용 활성화를 위한 업무협약"];

MERGE (n:LOCATION {name: '경기도'})
  ON CREATE SET n.type = '지역', n.country = '대한민국', n.region = '경기', n.aliases = ["경기도"]
  ON MATCH  SET n.type = '지역', n.country = '대한민국', n.region = '경기', n.aliases = ["경기도"];

MERGE (n:EVENT {name: '소상공인 온라인쇼핑몰 판매지원사업'})
  ON CREATE SET n.date = '2023', n.type = '지원사업', n.description = '소상공인 제품의 온라인 판매 활성화', n.location = '', n.aliases = ["소상공인 온라인쇼핑몰 판매지원사업"]
  ON MATCH  SET n.date = '2023', n.type = '지원사업', n.description = '소상공인 제품의 온라인 판매 활성화', n.location = '', n.aliases = ["소상공인 온라인쇼핑몰 판매지원사업"];

MERGE (n:PROJECT {name: '항공·해운 통합물류 지원 플랫폼'})
  ON CREATE SET n.description = '중소기업 전용 물류 지원 플랫폼 구축', n.start_date = '2023-04-14', n.status = '계획 중', n.aliases = ["항공·해운 통합물류 지원 플랫폼"]
  ON MATCH  SET n.description = '중소기업 전용 물류 지원 플랫폼 구축', n.start_date = '2023-04-14', n.status = '계획 중', n.aliases = ["항공·해운 통합물류 지원 플랫폼"];

MERGE (n:EVENT {name: '글로벌 물류 지원 업무협약'})
  ON CREATE SET n.date = '2023-04-14', n.type = '협약', n.description = '중소벤처기업의 글로벌 물류 지원을 위한 협약', n.aliases = ["글로벌 물류 지원 업무협약"], n.location = ''
  ON MATCH  SET n.date = '2023-04-14', n.type = '협약', n.description = '중소벤처기업의 글로벌 물류 지원을 위한 협약', n.aliases = ["글로벌 물류 지원 업무협약"], n.location = '';

MERGE (n:PRODUCT {name: '반도체 제조용 장비'})
  ON CREATE SET n.category = '장비', n.description = '수출 호조', n.launch_date = '', n.company = '', n.aliases = ["반도체 제조용 장비"]
  ON MATCH  SET n.category = '장비', n.description = '수출 호조', n.launch_date = '', n.company = '', n.aliases = ["반도체 제조용 장비"];

MERGE (n:PRODUCT {name: '자동차 부품'})
  ON CREATE SET n.category = '부품', n.description = '수출 감소', n.launch_date = '', n.company = '', n.aliases = ["자동차 부품"]
  ON MATCH  SET n.category = '부품', n.description = '수출 감소', n.launch_date = '', n.company = '', n.aliases = ["자동차 부품"];

MERGE (n:PRODUCT {name: '반도체'})
  ON CREATE SET n.category = '반도체', n.description = '수출 감소', n.launch_date = '', n.company = '', n.aliases = ["반도체"]
  ON MATCH  SET n.category = '반도체', n.description = '수출 감소', n.launch_date = '', n.company = '', n.aliases = ["반도체"];

MERGE (n:PRODUCT {name: '전자응용기기'})
  ON CREATE SET n.category = '전자기기', n.description = '수출 감소', n.launch_date = '', n.company = '', n.aliases = ["전자응용기기"]
  ON MATCH  SET n.category = '전자기기', n.description = '수출 감소', n.launch_date = '', n.company = '', n.aliases = ["전자응용기기"];

MERGE (n:PRODUCT {name: '기계요소'})
  ON CREATE SET n.category = '기계', n.description = '수출 감소', n.launch_date = '', n.company = '', n.aliases = ["기계요소"]
  ON MATCH  SET n.category = '기계', n.description = '수출 감소', n.launch_date = '', n.company = '', n.aliases = ["기계요소"];

MERGE (n:PRODUCT {name: '기타기계류'})
  ON CREATE SET n.category = '기계', n.description = '수출 감소', n.launch_date = '', n.company = '', n.aliases = ["기타기계류"]
  ON MATCH  SET n.category = '기계', n.description = '수출 감소', n.launch_date = '', n.company = '', n.aliases = ["기타기계류"];

MERGE (n:PRODUCT {name: '철강 제품'})
  ON CREATE SET n.category = '철강', n.description = '수출 감소', n.launch_date = '', n.company = '', n.aliases = ["철강 제품"]
  ON MATCH  SET n.category = '철강', n.description = '수출 감소', n.launch_date = '', n.company = '', n.aliases = ["철강 제품"];

MERGE (n:PRODUCT {name: '알루미늄 제품'})
  ON CREATE SET n.category = '알루미늄', n.description = '수출 감소', n.launch_date = '', n.company = '', n.aliases = ["알루미늄 제품"]
  ON MATCH  SET n.category = '알루미늄', n.description = '수출 감소', n.launch_date = '', n.company = '', n.aliases = ["알루미늄 제품"];

MERGE (n:LOCATION {name: '베트남'})
  ON CREATE SET n.type = '국가', n.country = '베트남', n.region = '', n.aliases = ["베트남"]
  ON MATCH  SET n.type = '국가', n.country = '베트남', n.region = '', n.aliases = ["베트남"];

MERGE (n:LOCATION {name: '인도'})
  ON CREATE SET n.type = '국가', n.country = '인도', n.region = '', n.aliases = ["인도"]
  ON MATCH  SET n.type = '국가', n.country = '인도', n.region = '', n.aliases = ["인도"];

MERGE (n:LOCATION {name: '멕시코'})
  ON CREATE SET n.type = '국가', n.country = '멕시코', n.region = '', n.aliases = ["멕시코"]
  ON MATCH  SET n.type = '국가', n.country = '멕시코', n.region = '', n.aliases = ["멕시코"];

MERGE (n:COMPANY {name: '엘리스그룹'})
  ON CREATE SET n.industry = 'AI 교육', n.full_name = '엘리스그룹', n.headquarters = '', n.founded = '', n.ceo = '김재원', n.aliases = ["엘리스그룹"]
  ON MATCH  SET n.industry = 'AI 교육', n.full_name = '엘리스그룹', n.headquarters = '', n.founded = '', n.ceo = '김재원', n.aliases = ["엘리스그룹"];

MERGE (n:COMPANY {name: '파인디'})
  ON CREATE SET n.industry = 'IT 채용 플랫폼', n.full_name = '파인디', n.headquarters = '일본', n.founded = '2016', n.ceo = '야마다 유이치로', n.aliases = ["파인디"]
  ON MATCH  SET n.industry = 'IT 채용 플랫폼', n.full_name = '파인디', n.headquarters = '일본', n.founded = '2016', n.ceo = '야마다 유이치로', n.aliases = ["파인디"];

MERGE (n:PERSON {name: '김재원'})
  ON CREATE SET n.full_name = '김재원', n.role = '대표', n.nationality = '', n.age = '', n.aliases = ["김재원"]
  ON MATCH  SET n.full_name = '김재원', n.role = '대표', n.nationality = '', n.age = '', n.aliases = ["김재원"];

MERGE (n:PERSON {name: '야마다유이치로'})
  ON CREATE SET n.full_name = '야마다 유이치로', n.role = '대표', n.nationality = '', n.age = '', n.aliases = ["야마다유이치로"]
  ON MATCH  SET n.full_name = '야마다 유이치로', n.role = '대표', n.nationality = '', n.age = '', n.aliases = ["야마다유이치로"];

MERGE (n:AGREEMENT {name: '엘리스그룹-파인디 업무 협약'})
  ON CREATE SET n.type = '상호 협력', n.date = '2023-04-14', n.description = 'AI 플랫폼 시장 확장 및 서비스 개발 협력', n.aliases = ["엘리스그룹-파인디 업무 협약"]
  ON MATCH  SET n.type = '상호 협력', n.date = '2023-04-14', n.description = 'AI 플랫폼 시장 확장 및 서비스 개발 협력', n.aliases = ["엘리스그룹-파인디 업무 협약"];

MERGE (n:TECHNOLOGY {name: 'AI 플랫폼'})
  ON CREATE SET n.category = '인공지능', n.description = 'AI 플랫폼 시장 확장', n.field = 'AI', n.aliases = ["AI 플랫폼"]
  ON MATCH  SET n.category = '인공지능', n.description = 'AI 플랫폼 시장 확장', n.field = 'AI', n.aliases = ["AI 플랫폼"];

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

MERGE (n:AGREEMENT {name: '협력사 ESG 지원사업 업무협약'})
  ON CREATE SET n.type = 'ESG 지원', n.date = '2023-04-14', n.description = '동반성장위원회와 LG이노텍 간의 ESG 지원사업 협약', n.aliases = ["협력사 ESG 지원사업 업무협약"]
  ON MATCH  SET n.type = 'ESG 지원', n.date = '2023-04-14', n.description = '동반성장위원회와 LG이노텍 간의 ESG 지원사업 협약', n.aliases = ["협력사 ESG 지원사업 업무협약"];

MERGE (n:LOCATION {name: '인천 송도'})
  ON CREATE SET n.type = '지역', n.country = '대한민국', n.region = '인천', n.aliases = ["인천 송도"]
  ON MATCH  SET n.type = '지역', n.country = '대한민국', n.region = '인천', n.aliases = ["인천 송도"];

MERGE (n:EVENT {name: 'ESG 우수 중소기업 현판식'})
  ON CREATE SET n.date = '2023-04-14', n.type = '현판식', n.description = 'ESG 우수 중소기업으로 선정된 기업에 대한 현판식', n.aliases = ["ESG 우수 중소기업 현판식"]
  ON MATCH  SET n.date = '2023-04-14', n.type = '현판식', n.description = 'ESG 우수 중소기업으로 선정된 기업에 대한 현판식', n.aliases = ["ESG 우수 중소기업 현판식"];

MERGE (n:CONCEPT {name: '미국 관세 정책'})
  ON CREATE SET n.type = '정책', n.description = '미국의 관세 정책으로 인한 중소벤처기업의 어려움', n.aliases = ["미국 관세 정책"]
  ON MATCH  SET n.type = '정책', n.description = '미국의 관세 정책으로 인한 중소벤처기업의 어려움', n.aliases = ["미국 관세 정책"];

MERGE (n:COMPANY {name: 'MOU'})
  ON CREATE SET n.aliases = ["MOU"]
  ON MATCH  SET n.aliases = ["MOU"];

MERGE (n:ORGANIZATION {name: '사람인'})
  ON CREATE SET n.type = '기업', n.description = '직장인 대상 설문조사 실시', n.aliases = ["사람인"]
  ON MATCH  SET n.type = '기업', n.description = '직장인 대상 설문조사 실시', n.aliases = ["사람인"];

MERGE (n:PERSON {name: '김혜미'})
  ON CREATE SET n.full_name = '김혜미', n.role = '기자', n.aliases = ["김혜미"], n.nationality = '', n.age = ''
  ON MATCH  SET n.full_name = '김혜미', n.role = '기자', n.aliases = ["김혜미"], n.nationality = '', n.age = '';

MERGE (n:CONCEPT {name: '인생 이모작'})
  ON CREATE SET n.type = '직업 전환', n.description = '은퇴 후 새로운 직업 찾기', n.aliases = ["인생 이모작"]
  ON MATCH  SET n.type = '직업 전환', n.description = '은퇴 후 새로운 직업 찾기', n.aliases = ["인생 이모작"];

MERGE (n:CONCEPT {name: '창업 및 자영업'})
  ON CREATE SET n.type = '직업 분야', n.description = '인생 이모작에서 가장 선호되는 분야', n.aliases = ["창업 및 자영업"]
  ON MATCH  SET n.type = '직업 분야', n.description = '인생 이모작에서 가장 선호되는 분야', n.aliases = ["창업 및 자영업"];

MERGE (n:CONCEPT {name: '블루칼라 직무'})
  ON CREATE SET n.type = '직업 분야', n.description = '생산직, 용접, 목공, 운전 등', n.aliases = ["블루칼라 직무"]
  ON MATCH  SET n.type = '직업 분야', n.description = '생산직, 용접, 목공, 운전 등', n.aliases = ["블루칼라 직무"];

MERGE (n:CONCEPT {name: '화이트칼라 직무'})
  ON CREATE SET n.type = '직업 분야', n.description = '영업, 재무 등', n.aliases = ["화이트칼라 직무"]
  ON MATCH  SET n.type = '직업 분야', n.description = '영업, 재무 등', n.aliases = ["화이트칼라 직무"];

MERGE (n:CONCEPT {name: '전문직'})
  ON CREATE SET n.type = '직업 분야', n.description = '변호사, 노무사, 행정사 등', n.aliases = ["전문직"]
  ON MATCH  SET n.type = '직업 분야', n.description = '변호사, 노무사, 행정사 등', n.aliases = ["전문직"];

MERGE (n:CONCEPT {name: '관련 자격증 취득'})
  ON CREATE SET n.type = '준비 활동', n.description = '인생 이모작 준비를 위한 활동', n.aliases = ["관련 자격증 취득"]
  ON MATCH  SET n.type = '준비 활동', n.description = '인생 이모작 준비를 위한 활동', n.aliases = ["관련 자격증 취득"];

MERGE (n:CONCEPT {name: '관련 교육과정 수강'})
  ON CREATE SET n.type = '준비 활동', n.description = '인생 이모작 준비를 위한 활동', n.aliases = ["관련 교육과정 수강"]
  ON MATCH  SET n.type = '준비 활동', n.description = '인생 이모작 준비를 위한 활동', n.aliases = ["관련 교육과정 수강"];

MERGE (n:CONCEPT {name: '관심 직무 실무 경험'})
  ON CREATE SET n.type = '준비 활동', n.description = '인생 이모작 준비를 위한 활동', n.aliases = ["관심 직무 실무 경험"]
  ON MATCH  SET n.type = '준비 활동', n.description = '인생 이모작 준비를 위한 활동', n.aliases = ["관심 직무 실무 경험"];

MERGE (n:CONCEPT {name: '전문 기술 습득'})
  ON CREATE SET n.type = '준비 활동', n.description = '인생 이모작 준비를 위한 활동', n.aliases = ["전문 기술 습득"]
  ON MATCH  SET n.type = '준비 활동', n.description = '인생 이모작 준비를 위한 활동', n.aliases = ["전문 기술 습득"];

MERGE (n:CONCEPT {name: '종자돈 모으기'})
  ON CREATE SET n.type = '준비 활동', n.description = '인생 이모작 준비를 위한 활동', n.aliases = ["종자돈 모으기"]
  ON MATCH  SET n.type = '준비 활동', n.description = '인생 이모작 준비를 위한 활동', n.aliases = ["종자돈 모으기"];

MERGE (n:ORGANIZATION {name: '소상공인시장진흥공단'})
  ON CREATE SET n.type = '정부기관', n.description = '소상공인 및 소공인 지원을 위한 정부기관', n.headquarters = '', n.aliases = ["소상공인시장진흥공단"]
  ON MATCH  SET n.type = '정부기관', n.description = '소상공인 및 소공인 지원을 위한 정부기관', n.headquarters = '', n.aliases = ["소상공인시장진흥공단"];

MERGE (n:COMPANY {name: '롯데웰푸드'})
  ON CREATE SET n.full_name = '롯데웰푸드', n.industry = '식품 제조', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["롯데웰푸드"]
  ON MATCH  SET n.full_name = '롯데웰푸드', n.industry = '식품 제조', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["롯데웰푸드"];

MERGE (n:PROJECT {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
  ON CREATE SET n.description = '백년가게·소공인의 경험과 롯데웰푸드의 기술력을 접목한 공동 상표 및 상품 개발 프로젝트', n.start_date = '2023-03', n.status = '모집 중', n.aliases = ["2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트"]
  ON MATCH  SET n.description = '백년가게·소공인의 경험과 롯데웰푸드의 기술력을 접목한 공동 상표 및 상품 개발 프로젝트', n.start_date = '2023-03', n.status = '모집 중', n.aliases = ["2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트"];

MERGE (n:AGREEMENT {name: '백년가게·소공인과 롯데웰푸드의 협력'})
  ON CREATE SET n.type = '상생 협력', n.date = '2023-03', n.description = '백년가게·소공인과 롯데웰푸드의 협력', n.aliases = ["백년가게·소공인과 롯데웰푸드의 협력"]
  ON MATCH  SET n.type = '상생 협력', n.date = '2023-03', n.description = '백년가게·소공인과 롯데웰푸드의 협력', n.aliases = ["백년가게·소공인과 롯데웰푸드의 협력"];

MERGE (n:PRODUCT {name: '식사이론'})
  ON CREATE SET n.category = '식품', n.description = '백년가게의 우수메뉴와 롯데웰푸드의 브랜드 접목 상품', n.launch_date = '', n.company = '롯데웰푸드', n.aliases = ["식사이론"]
  ON MATCH  SET n.category = '식품', n.description = '백년가게의 우수메뉴와 롯데웰푸드의 브랜드 접목 상품', n.launch_date = '', n.company = '롯데웰푸드', n.aliases = ["식사이론"];

MERGE (n:PERSON {name: '박성효'})
  ON CREATE SET n.full_name = '박성효', n.role = '이사장', n.nationality = '', n.age = '', n.aliases = ["박성효"]
  ON MATCH  SET n.full_name = '박성효', n.role = '이사장', n.nationality = '', n.age = '', n.aliases = ["박성효"];

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

MERGE (n:COMPANY {name: '엠투아이'})
  ON CREATE SET n.industry = '디지털전환 솔루션', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["엠투아이"]
  ON MATCH  SET n.industry = '디지털전환 솔루션', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["엠투아이"];

MERGE (n:COMPANY {name: '벰로보틱스'})
  ON CREATE SET n.industry = '산업용 물류로봇', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["벰로보틱스"]
  ON MATCH  SET n.industry = '산업용 물류로봇', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["벰로보틱스"];

MERGE (n:AGREEMENT {name: '로봇 제어기 공동 개발 및 물류로봇 프로젝트 협약'})
  ON CREATE SET n.type = '업무 협약', n.date = '2023-04-14', n.description = '엠투아이와 벰로보틱스의 로봇 제어기 공동 개발 및 물류로봇 프로젝트 협약', n.aliases = ["로봇 제어기 공동 개발 및 물류로봇 프로젝트 협약"]
  ON MATCH  SET n.type = '업무 협약', n.date = '2023-04-14', n.description = '엠투아이와 벰로보틱스의 로봇 제어기 공동 개발 및 물류로봇 프로젝트 협약', n.aliases = ["로봇 제어기 공동 개발 및 물류로봇 프로젝트 협약"];

MERGE (n:PROJECT {name: '물류로봇(AMR/AGV) 프로젝트'})
  ON CREATE SET n.description = '엠투아이와 벰로보틱스의 물류로봇 프로젝트', n.start_date = '', n.status = '진행 중', n.aliases = ["물류로봇(AMR/AGV) 프로젝트"]
  ON MATCH  SET n.description = '엠투아이와 벰로보틱스의 물류로봇 프로젝트', n.start_date = '', n.status = '진행 중', n.aliases = ["물류로봇(AMR/AGV) 프로젝트"];

MERGE (n:INVESTMENT {name: '엠투아이의 벰로보틱스 지분 투자'})
  ON CREATE SET n.amount = '12억원', n.date = '2023-04-14', n.type = '지분 투자', n.aliases = ["엠투아이의 벰로보틱스 지분 투자"]
  ON MATCH  SET n.amount = '12억원', n.date = '2023-04-14', n.type = '지분 투자', n.aliases = ["엠투아이의 벰로보틱스 지분 투자"];

MERGE (n:TECHNOLOGY {name: '로봇 제어기'})
  ON CREATE SET n.category = '로봇 기술', n.description = 'AMR/AGV의 두뇌 역할을 하는 로봇 제어기', n.field = '로봇 제어', n.aliases = ["로봇 제어기"]
  ON MATCH  SET n.category = '로봇 기술', n.description = 'AMR/AGV의 두뇌 역할을 하는 로봇 제어기', n.field = '로봇 제어', n.aliases = ["로봇 제어기"];

MERGE (n:TECHNOLOGY {name: '디지털전환(DX) 솔루션'})
  ON CREATE SET n.category = '디지털 전환', n.description = '엠투아이의 자체 개발 솔루션', n.field = '디지털 전환', n.aliases = ["디지털전환(DX) 솔루션"]
  ON MATCH  SET n.category = '디지털 전환', n.description = '엠투아이의 자체 개발 솔루션', n.field = '디지털 전환', n.aliases = ["디지털전환(DX) 솔루션"];

MERGE (n:TECHNOLOGY {name: 'AI 자율 제조'})
  ON CREATE SET n.category = '인공지능', n.description = '엠투아이의 AI 자율 제조 시장 선도 기술', n.field = '제조', n.aliases = ["AI 자율 제조"]
  ON MATCH  SET n.category = '인공지능', n.description = '엠투아이의 AI 자율 제조 시장 선도 기술', n.field = '제조', n.aliases = ["AI 자율 제조"];

MERGE (n:COMPANY {name: 'AMR'})
  ON CREATE SET n.aliases = ["AMR"]
  ON MATCH  SET n.aliases = ["AMR"];

MERGE (n:COMPANY {name: 'AGV'})
  ON CREATE SET n.aliases = ["AGV"]
  ON MATCH  SET n.aliases = ["AGV"];

MERGE (n:COMPANY {name: 'ACS'})
  ON CREATE SET n.aliases = ["ACS"]
  ON MATCH  SET n.aliases = ["ACS"];

MERGE (n:COMPANY {name: '신일전자'})
  ON CREATE SET n.full_name = '신일전자', n.industry = '가전제품', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["신일전자"]
  ON MATCH  SET n.full_name = '신일전자', n.industry = '가전제품', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["신일전자"];

MERGE (n:PRODUCT {name: 'BLDC 에어 서큘레이터 S10 SE'})
  ON CREATE SET n.category = '가전제품', n.description = '고성능·감성 디자인, 마그네틱 리모컨, 무빙 디스플레이, 고효율 BLDC 모터, 3D 입체 회전 구조, 에코 모드', n.launch_date = '2023-04-14', n.company = '신일전자', n.aliases = ["BLDC 에어 서큘레이터 S10 SE"]
  ON MATCH  SET n.category = '가전제품', n.description = '고성능·감성 디자인, 마그네틱 리모컨, 무빙 디스플레이, 고효율 BLDC 모터, 3D 입체 회전 구조, 에코 모드', n.launch_date = '2023-04-14', n.company = '신일전자', n.aliases = ["BLDC 에어 서큘레이터 S10 SE"];

MERGE (n:EVENT {name: 'GS홈쇼핑 성유리 에디션 방송'})
  ON CREATE SET n.date = '2023-04-14', n.type = '방송', n.description = '신일전자 BLDC 에어 서큘레이터 S10 SE 첫 선', n.location = '', n.aliases = ["GS홈쇼핑 성유리 에디션 방송"]
  ON MATCH  SET n.date = '2023-04-14', n.type = '방송', n.description = '신일전자 BLDC 에어 서큘레이터 S10 SE 첫 선', n.location = '', n.aliases = ["GS홈쇼핑 성유리 에디션 방송"];

MERGE (n:COMPANY {name: 'GS홈쇼핑'})
  ON CREATE SET n.full_name = 'GS홈쇼핑', n.industry = '소매', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["GS홈쇼핑"]
  ON MATCH  SET n.full_name = 'GS홈쇼핑', n.industry = '소매', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["GS홈쇼핑"];

MERGE (n:COMPANY {name: 'BLDC'})
  ON CREATE SET n.aliases = ["BLDC"]
  ON MATCH  SET n.aliases = ["BLDC"];

MERGE (n:AGREEMENT {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
  ON CREATE SET n.type = '상생 협력', n.date = '2023-03', n.description = '백년가게·소공인과 롯데웰푸드의 협력', n.aliases = ["2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트"]
  ON MATCH  SET n.type = '상생 협력', n.date = '2023-03', n.description = '백년가게·소공인과 롯데웰푸드의 협력', n.aliases = ["2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트"];

MERGE (n:PROJECT {name: '백년가게·백년소공인 상생프로젝트'})
  ON CREATE SET n.description = '백년가게와 백년소공인의 경험과 롯데웰푸드의 기술력을 접목한 공동 상표 및 상품 개발', n.start_date = '2023-04-14', n.status = '모집 중', n.aliases = ["백년가게·백년소공인 상생프로젝트"]
  ON MATCH  SET n.description = '백년가게와 백년소공인의 경험과 롯데웰푸드의 기술력을 접목한 공동 상표 및 상품 개발', n.start_date = '2023-04-14', n.status = '모집 중', n.aliases = ["백년가게·백년소공인 상생프로젝트"];

MERGE (n:PRODUCT {name: 'HMR'})
  ON CREATE SET n.category = '가정간편식', n.description = '즉석섭취식품, 즉석조리식품(밀키트) 등의 공동 제품 개발', n.launch_date = '', n.company = '롯데웰푸드', n.aliases = ["HMR"]
  ON MATCH  SET n.category = '가정간편식', n.description = '즉석섭취식품, 즉석조리식품(밀키트) 등의 공동 제품 개발', n.launch_date = '', n.company = '롯데웰푸드', n.aliases = ["HMR"];

MERGE (n:PERSON {name: '윤승현'})
  ON CREATE SET n.role = '대표', n.company = '에이드로', n.aliases = ["윤승현"]
  ON MATCH  SET n.role = '대표', n.company = '에이드로', n.aliases = ["윤승현"];

MERGE (n:COMPANY {name: '에이드로'})
  ON CREATE SET n.industry = '자동차', n.headquarters = '대한민국', n.aliases = ["에이드로"]
  ON MATCH  SET n.industry = '자동차', n.headquarters = '대한민국', n.aliases = ["에이드로"];

MERGE (n:PRODUCT {name: '바디킷'})
  ON CREATE SET n.category = '자동차 부품', n.description = '공기역학 기반의 바디킷', n.company = '에이드로', n.aliases = ["바디킷"]
  ON MATCH  SET n.category = '자동차 부품', n.description = '공기역학 기반의 바디킷', n.company = '에이드로', n.aliases = ["바디킷"];

MERGE (n:TECHNOLOGY {name: '전산유체역학'})
  ON CREATE SET n.category = '시뮬레이션 기술', n.description = 'CFD 시뮬레이션을 통한 공기역학 최적화', n.field = '자동차', n.aliases = ["전산유체역학"]
  ON MATCH  SET n.category = '시뮬레이션 기술', n.description = 'CFD 시뮬레이션을 통한 공기역학 최적화', n.field = '자동차', n.aliases = ["전산유체역학"];

MERGE (n:COMPANY {name: 'Tesla'})
  ON CREATE SET n.industry = '자동차', n.headquarters = '미국', n.aliases = ["Tesla"]
  ON MATCH  SET n.industry = '자동차', n.headquarters = '미국', n.aliases = ["Tesla"];

MERGE (n:COMPANY {name: '현대'})
  ON CREATE SET n.industry = '자동차', n.headquarters = '대한민국', n.aliases = ["현대"]
  ON MATCH  SET n.industry = '자동차', n.headquarters = '대한민국', n.aliases = ["현대"];

MERGE (n:COMPANY {name: '기아'})
  ON CREATE SET n.industry = '자동차', n.headquarters = '대한민국', n.aliases = ["기아"]
  ON MATCH  SET n.industry = '자동차', n.headquarters = '대한민국', n.aliases = ["기아"];

MERGE (n:COMPANY {name: 'BMW'})
  ON CREATE SET n.industry = '자동차', n.headquarters = '독일', n.aliases = ["BMW"]
  ON MATCH  SET n.industry = '자동차', n.headquarters = '독일', n.aliases = ["BMW"];

MERGE (n:PRODUCT {name: 'AOS'})
  ON CREATE SET n.category = '소프트웨어', n.description = '에어로 옵티마이제이션 소프트웨어', n.company = '에이드로', n.aliases = ["AOS"]
  ON MATCH  SET n.category = '소프트웨어', n.description = '에어로 옵티마이제이션 소프트웨어', n.company = '에이드로', n.aliases = ["AOS"];

MERGE (n:LOCATION {name: '독일'})
  ON CREATE SET n.type = '국가', n.country = '독일', n.aliases = ["독일"]
  ON MATCH  SET n.type = '국가', n.country = '독일', n.aliases = ["독일"];

MERGE (n:LOCATION {name: '말레이시아'})
  ON CREATE SET n.type = '국가', n.country = '말레이시아', n.aliases = ["말레이시아"]
  ON MATCH  SET n.type = '국가', n.country = '말레이시아', n.aliases = ["말레이시아"];

MERGE (n:LOCATION {name: '싱가포르'})
  ON CREATE SET n.type = '국가', n.country = '싱가포르', n.aliases = ["싱가포르"]
  ON MATCH  SET n.type = '국가', n.country = '싱가포르', n.aliases = ["싱가포르"];

MERGE (n:LOCATION {name: '영국'})
  ON CREATE SET n.type = '국가', n.country = '영국', n.aliases = ["영국"]
  ON MATCH  SET n.type = '국가', n.country = '영국', n.aliases = ["영국"];

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

MERGE (n:COMPANY {name: '센드버드'})
  ON CREATE SET n.industry = 'AI 플랫폼', n.aliases = ["센드버드"]
  ON MATCH  SET n.industry = 'AI 플랫폼', n.aliases = ["센드버드"];

MERGE (n:PRODUCT {name: '옴니프레젠트 AI 에이전트'})
  ON CREATE SET n.category = 'AI 에이전트', n.description = '프롬프트 없이 고객 행동 예측 및 응답', n.aliases = ["옴니프레젠트 AI 에이전트"]
  ON MATCH  SET n.category = 'AI 에이전트', n.description = '프롬프트 없이 고객 행동 예측 및 응답', n.aliases = ["옴니프레젠트 AI 에이전트"];

MERGE (n:PERSON {name: '김동신'})
  ON CREATE SET n.role = '대표', n.aliases = ["김동신"]
  ON MATCH  SET n.role = '대표', n.aliases = ["김동신"];

MERGE (n:INDUSTRY {name: '커머스'})
  ON CREATE SET n.description = '전자 상거래 산업', n.aliases = ["커머스"]
  ON MATCH  SET n.description = '전자 상거래 산업', n.aliases = ["커머스"];

MERGE (n:INDUSTRY {name: '핀테크'})
  ON CREATE SET n.description = '금융 기술 산업', n.aliases = ["핀테크"]
  ON MATCH  SET n.description = '금융 기술 산업', n.aliases = ["핀테크"];

MERGE (n:INDUSTRY {name: '리테일'})
  ON CREATE SET n.description = '소매업 산업', n.aliases = ["리테일"]
  ON MATCH  SET n.description = '소매업 산업', n.aliases = ["리테일"];

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

MERGE (n:ORGANIZATION {name: '경기도'})
  ON CREATE SET n.type = '지방자치단체', n.description = '산업재해 예방 교육을 주관하는 지방자치단체', n.headquarters = '경기도', n.aliases = ["경기도"]
  ON MATCH  SET n.type = '지방자치단체', n.description = '산업재해 예방 교육을 주관하는 지방자치단체', n.headquarters = '경기도', n.aliases = ["경기도"];

MERGE (n:EVENT {name: '찾아가는 산업재해 예방 교육'})
  ON CREATE SET n.date = '2023', n.type = '교육', n.description = '50인 미만 소규모 사업장을 대상으로 한 산업재해 예방 교육', n.location = '경기도', n.aliases = ["찾아가는 산업재해 예방 교육"]
  ON MATCH  SET n.date = '2023', n.type = '교육', n.description = '50인 미만 소규모 사업장을 대상으로 한 산업재해 예방 교육', n.location = '경기도', n.aliases = ["찾아가는 산업재해 예방 교육"];

MERGE (n:ORGANIZATION {name: '고용노동부'})
  ON CREATE SET n.type = '정부기관', n.description = '노동 관련 정책을 담당하는 정부기관', n.headquarters = '세종특별자치시', n.aliases = ["고용노동부"]
  ON MATCH  SET n.type = '정부기관', n.description = '노동 관련 정책을 담당하는 정부기관', n.headquarters = '세종특별자치시', n.aliases = ["고용노동부"];

MERGE (n:ORGANIZATION {name: '직업건강간호협회 직업건강안전연구소'})
  ON CREATE SET n.type = '협회', n.description = '산업재해 예방 교육 신청 및 문의를 담당하는 기관', n.headquarters = '', n.aliases = ["직업건강간호협회 직업건강안전연구소"]
  ON MATCH  SET n.type = '협회', n.description = '산업재해 예방 교육 신청 및 문의를 담당하는 기관', n.headquarters = '', n.aliases = ["직업건강간호협회 직업건강안전연구소"];

MERGE (n:PERSON {name: '임용규'})
  ON CREATE SET n.full_name = '임용규', n.role = '노동안전과장', n.nationality = '대한민국', n.age = '', n.aliases = ["임용규"]
  ON MATCH  SET n.full_name = '임용규', n.role = '노동안전과장', n.nationality = '대한민국', n.age = '', n.aliases = ["임용규"];

MERGE (n:EVENT {name: '미국 관세 부과'})
  ON CREATE SET n.date = '2023-03-12', n.type = '정책', n.description = '미국의 철강·알루미늄 및 파생상품에 대한 관세 부과', n.aliases = ["미국 관세 부과"]
  ON MATCH  SET n.date = '2023-03-12', n.type = '정책', n.description = '미국의 철강·알루미늄 및 파생상품에 대한 관세 부과', n.aliases = ["미국 관세 부과"];

MERGE (n:COMPANY {name: '가온아이'})
  ON CREATE SET n.full_name = '가온아이', n.industry = '소프트웨어', n.headquarters = '', n.founded = '', n.ceo = '조창제', n.aliases = ["가온아이"]
  ON MATCH  SET n.full_name = '가온아이', n.industry = '소프트웨어', n.headquarters = '', n.founded = '', n.ceo = '조창제', n.aliases = ["가온아이"];

MERGE (n:COMPANY {name: '아이서트'})
  ON CREATE SET n.full_name = '아이서트', n.industry = '소프트웨어', n.headquarters = '', n.founded = '', n.ceo = '현수환', n.aliases = ["아이서트"]
  ON MATCH  SET n.full_name = '아이서트', n.industry = '소프트웨어', n.headquarters = '', n.founded = '', n.ceo = '현수환', n.aliases = ["아이서트"];

MERGE (n:PRODUCT {name: '세이프아이서트'})
  ON CREATE SET n.category = '법인 인증서 관리 솔루션', n.description = '실시간 모니터링, 불법 사용 방지, 사용자별 비밀번호 설정, 인증서 외부 유출 차단', n.launch_date = '', n.company = '아이서트', n.aliases = ["세이프아이서트"]
  ON MATCH  SET n.category = '법인 인증서 관리 솔루션', n.description = '실시간 모니터링, 불법 사용 방지, 사용자별 비밀번호 설정, 인증서 외부 유출 차단', n.launch_date = '', n.company = '아이서트', n.aliases = ["세이프아이서트"];

MERGE (n:TECHNOLOGY {name: 'SaaS'})
  ON CREATE SET n.category = '클라우드 서비스', n.description = '서비스형 소프트웨어', n.field = '소프트웨어', n.aliases = ["SaaS"]
  ON MATCH  SET n.category = '클라우드 서비스', n.description = '서비스형 소프트웨어', n.field = '소프트웨어', n.aliases = ["SaaS"];

MERGE (n:COMPANY {name: '한화오션디지털'})
  ON CREATE SET n.full_name = '한화오션디지털', n.industry = '디지털 솔루션', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["한화오션디지털"]
  ON MATCH  SET n.full_name = '한화오션디지털', n.industry = '디지털 솔루션', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["한화오션디지털"];

MERGE (n:COMPANY {name: 'Lg'})
  ON CREATE SET n.full_name = 'LG전자', n.industry = '전자', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["Lg"]
  ON MATCH  SET n.full_name = 'LG전자', n.industry = '전자', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["Lg"];

MERGE (n:PERSON {name: '조창제'})
  ON CREATE SET n.full_name = '조창제', n.role = '대표', n.nationality = '', n.age = '', n.aliases = ["조창제"]
  ON MATCH  SET n.full_name = '조창제', n.role = '대표', n.nationality = '', n.age = '', n.aliases = ["조창제"];

MERGE (n:PERSON {name: '현수환'})
  ON CREATE SET n.full_name = '현수환', n.role = '대표', n.nationality = '', n.age = '', n.aliases = ["현수환"]
  ON MATCH  SET n.full_name = '현수환', n.role = '대표', n.nationality = '', n.age = '', n.aliases = ["현수환"];

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

MERGE (n:COMPANY {name: '엔씽'})
  ON CREATE SET n.full_name = '엔씽', n.industry = '스마트 수직농장', n.headquarters = '', n.founded = '2014', n.ceo = '김혜연', n.aliases = ["엔씽"]
  ON MATCH  SET n.full_name = '엔씽', n.industry = '스마트 수직농장', n.headquarters = '', n.founded = '2014', n.ceo = '김혜연', n.aliases = ["엔씽"];

MERGE (n:PROJECT {name: '물류센터형 수직농장 스마트팜 개발'})
  ON CREATE SET n.description = '1000억원 규모 물류센터형 수직농장 스마트팜 개발 사업', n.start_date = '2023', n.status = '본격 추진', n.aliases = ["물류센터형 수직농장 스마트팜 개발"]
  ON MATCH  SET n.description = '1000억원 규모 물류센터형 수직농장 스마트팜 개발 사업', n.start_date = '2023', n.status = '본격 추진', n.aliases = ["물류센터형 수직농장 스마트팜 개발"];

MERGE (n:LOCATION {name: '경기도 이천'})
  ON CREATE SET n.type = '지역', n.country = '대한민국', n.region = '경기', n.aliases = ["경기도 이천"]
  ON MATCH  SET n.type = '지역', n.country = '대한민국', n.region = '경기', n.aliases = ["경기도 이천"];

MERGE (n:COMPANY {name: '이마트'})
  ON CREATE SET n.full_name = '이마트', n.industry = '유통', n.headquarters = '', n.aliases = ["이마트"]
  ON MATCH  SET n.full_name = '이마트', n.industry = '유통', n.headquarters = '', n.aliases = ["이마트"];

MERGE (n:COMPANY {name: '배달의민족'})
  ON CREATE SET n.full_name = '배달의민족', n.industry = '배달 서비스', n.headquarters = '', n.aliases = ["배달의민족"]
  ON MATCH  SET n.full_name = '배달의민족', n.industry = '배달 서비스', n.headquarters = '', n.aliases = ["배달의민족"];

MERGE (n:TECHNOLOGY {name: '큐브(CUBE)'})
  ON CREATE SET n.category = '모듈형 스마트팜', n.description = '유기적 연결이 가능한 모듈형 스마트팜', n.field = '스마트농업', n.aliases = ["큐브(CUBE)"]
  ON MATCH  SET n.category = '모듈형 스마트팜', n.description = '유기적 연결이 가능한 모듈형 스마트팜', n.field = '스마트농업', n.aliases = ["큐브(CUBE)"];

MERGE (n:EVENT {name: 'CES 2020'})
  ON CREATE SET n.date = '2020', n.type = '수상', n.description = '농업 분야 최초로 ‘최고혁신상’ 수상', n.location = '', n.aliases = ["CES 2020"]
  ON MATCH  SET n.date = '2020', n.type = '수상', n.description = '농업 분야 최초로 ‘최고혁신상’ 수상', n.location = '', n.aliases = ["CES 2020"];

MERGE (n:TECHNOLOGY {name: 'IoT 기반 환경 제어 기술'})
  ON CREATE SET n.category = '환경 제어 기술', n.description = '온도, 습도, 광(LED), CO2, 수분, 양분 등 농장의 재배 환경을 실시간으로 확인·통제', n.field = '사물인터넷(IoT)', n.aliases = ["IoT 기반 환경 제어 기술"]
  ON MATCH  SET n.category = '환경 제어 기술', n.description = '온도, 습도, 광(LED), CO2, 수분, 양분 등 농장의 재배 환경을 실시간으로 확인·통제', n.field = '사물인터넷(IoT)', n.aliases = ["IoT 기반 환경 제어 기술"];

MERGE (n:PRODUCT {name: '레터스류, 허브류, 어린잎 채소, 새싹채소'})
  ON CREATE SET n.category = '농산물', n.description = '다양한 작물을 연간 112만팩(약 120톤) 이상 생산', n.launch_date = '', n.company = '엔씽', n.aliases = ["레터스류, 허브류, 어린잎 채소, 새싹채소"]
  ON MATCH  SET n.category = '농산물', n.description = '다양한 작물을 연간 112만팩(약 120톤) 이상 생산', n.launch_date = '', n.company = '엔씽', n.aliases = ["레터스류, 허브류, 어린잎 채소, 새싹채소"];

MERGE (n:PERSON {name: '김혜연'})
  ON CREATE SET n.full_name = '김혜연', n.role = '대표', n.nationality = '', n.age = '', n.aliases = ["김혜연"]
  ON MATCH  SET n.full_name = '김혜연', n.role = '대표', n.nationality = '', n.age = '', n.aliases = ["김혜연"];

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

MERGE (n:MARKET {name: '중국 제조업 경기'})
  ON CREATE SET n.description = '중국의 제조업 경기 호황으로 인한 수요 증가', n.aliases = ["중국 제조업 경기"]
  ON MATCH  SET n.description = '중국의 제조업 경기 호황으로 인한 수요 증가', n.aliases = ["중국 제조업 경기"];

MERGE (n:EVENT {name: '미국 관세 조치'})
  ON CREATE SET n.date = '2023-03-12', n.type = '무역 정책', n.description = '미국 철강·알루미늄 및 파생상품 관세부과', n.aliases = ["미국 관세 조치"]
  ON MATCH  SET n.date = '2023-03-12', n.type = '무역 정책', n.description = '미국 철강·알루미늄 및 파생상품 관세부과', n.aliases = ["미국 관세 조치"];

MERGE (n:COMPANY {name: '와디즈'})
  ON CREATE SET n.industry = '펀딩 플랫폼', n.aliases = ["와디즈"]
  ON MATCH  SET n.industry = '펀딩 플랫폼', n.aliases = ["와디즈"];

MERGE (n:PRODUCT {name: '뉴에어론 풀 체어'})
  ON CREATE SET n.category = '고급 오피스 체어', n.description = '허먼밀러의 고급 오피스 체어', n.launch_date = '', n.company = '허먼밀러', n.aliases = ["뉴에어론 풀 체어"]
  ON MATCH  SET n.category = '고급 오피스 체어', n.description = '허먼밀러의 고급 오피스 체어', n.launch_date = '', n.company = '허먼밀러', n.aliases = ["뉴에어론 풀 체어"];

MERGE (n:PRODUCT {name: '쿠자 멀티핸들 스텐팬'})
  ON CREATE SET n.category = '주방용품', n.description = '명품 스테인리스를 사용한 스텐팬', n.launch_date = '', n.company = '', n.aliases = ["쿠자 멀티핸들 스텐팬"]
  ON MATCH  SET n.category = '주방용품', n.description = '명품 스테인리스를 사용한 스텐팬', n.launch_date = '', n.company = '', n.aliases = ["쿠자 멀티핸들 스텐팬"];

MERGE (n:PRODUCT {name: '올리젯 청바지'})
  ON CREATE SET n.category = '패션', n.description = '이탈리아산 프리미엄 데님 원단 사용', n.launch_date = '', n.company = '', n.aliases = ["올리젯 청바지"]
  ON MATCH  SET n.category = '패션', n.description = '이탈리아산 프리미엄 데님 원단 사용', n.launch_date = '', n.company = '', n.aliases = ["올리젯 청바지"];

MERGE (n:REPORT {name: '2025 글로벌 소비자 트렌드 리포트'})
  ON CREATE SET n.description = '글로벌 소비 트렌드 분석 보고서', n.date = '2025', n.aliases = ["2025 글로벌 소비자 트렌드 리포트"]
  ON MATCH  SET n.description = '글로벌 소비 트렌드 분석 보고서', n.date = '2025', n.aliases = ["2025 글로벌 소비자 트렌드 리포트"];

MERGE (n:ORGANIZATION {name: '유로모니터'})
  ON CREATE SET n.type = '시장조사기관', n.description = '글로벌 시장조사기관', n.headquarters = '', n.aliases = ["유로모니터"]
  ON MATCH  SET n.type = '시장조사기관', n.description = '글로벌 시장조사기관', n.headquarters = '', n.aliases = ["유로모니터"];

MERGE (n:PERSON {name: '황지현'})
  ON CREATE SET n.full_name = '황지현', n.role = '기자', n.nationality = '', n.age = '', n.aliases = ["황지현"]
  ON MATCH  SET n.full_name = '황지현', n.role = '기자', n.nationality = '', n.age = '', n.aliases = ["황지현"];

MERGE (n:COMPANY {name: '삼성바이오로직스'})
  ON CREATE SET n.industry = '바이오', n.headquarters = '대한민국', n.aliases = ["삼성바이오로직스"]
  ON MATCH  SET n.industry = '바이오', n.headquarters = '대한민국', n.aliases = ["삼성바이오로직스"];

MERGE (n:COMPANY {name: '셀트리온'})
  ON CREATE SET n.industry = '바이오', n.headquarters = '대한민국', n.aliases = ["셀트리온"], n.full_name = '셀트리온', n.founded = '', n.ceo = ''
  ON MATCH  SET n.industry = '바이오', n.headquarters = '대한민국', n.aliases = ["셀트리온"], n.full_name = '셀트리온', n.founded = '', n.ceo = '';

MERGE (n:PERSON {name: '도널드트럼프'})
  ON CREATE SET n.role = '전 미국 대통령', n.aliases = ["도널드트럼프"]
  ON MATCH  SET n.role = '전 미국 대통령', n.aliases = ["도널드트럼프"];

MERGE (n:PRODUCT {name: '램시마'})
  ON CREATE SET n.category = '바이오시밀러', n.description = '셀트리온의 바이오시밀러 제품', n.aliases = ["램시마"]
  ON MATCH  SET n.category = '바이오시밀러', n.description = '셀트리온의 바이오시밀러 제품', n.aliases = ["램시마"];

MERGE (n:PRODUCT {name: '트룩시마'})
  ON CREATE SET n.category = '바이오시밀러', n.description = '셀트리온의 바이오시밀러 제품', n.aliases = ["트룩시마"], n.launch_date = '', n.company = '셀트리온'
  ON MATCH  SET n.category = '바이오시밀러', n.description = '셀트리온의 바이오시밀러 제품', n.aliases = ["트룩시마"], n.launch_date = '', n.company = '셀트리온';

MERGE (n:PRODUCT {name: '옴리클로'})
  ON CREATE SET n.category = '바이오시밀러', n.description = '셀트리온의 신규 바이오시밀러 제품', n.aliases = ["옴리클로"]
  ON MATCH  SET n.category = '바이오시밀러', n.description = '셀트리온의 신규 바이오시밀러 제품', n.aliases = ["옴리클로"];

MERGE (n:PRODUCT {name: '아이덴젤트'})
  ON CREATE SET n.category = '바이오시밀러', n.description = '셀트리온의 신규 바이오시밀러 제품', n.aliases = ["아이덴젤트"]
  ON MATCH  SET n.category = '바이오시밀러', n.description = '셀트리온의 신규 바이오시밀러 제품', n.aliases = ["아이덴젤트"];

MERGE (n:EVENT {name: '의약품 관세 부과'})
  ON CREATE SET n.date = '2023-04', n.type = '정책 발표', n.description = '미국의 의약품 관세 부과 정책', n.aliases = ["의약품 관세 부과"]
  ON MATCH  SET n.date = '2023-04', n.type = '정책 발표', n.description = '미국의 의약품 관세 부과 정책', n.aliases = ["의약품 관세 부과"];

MERGE (n:EVENT {name: '약가인하 행정명령'})
  ON CREATE SET n.date = '2023-04-12', n.type = '정책 발표', n.description = '트럼프 대통령의 약가인하 행정명령', n.aliases = ["약가인하 행정명령"]
  ON MATCH  SET n.date = '2023-04-12', n.type = '정책 발표', n.description = '트럼프 대통령의 약가인하 행정명령', n.aliases = ["약가인하 행정명령"];

MERGE (n:MARKET {name: '바이오시밀러 시장'})
  ON CREATE SET n.description = '바이오시밀러 제품의 시장', n.aliases = ["바이오시밀러 시장"]
  ON MATCH  SET n.description = '바이오시밀러 제품의 시장', n.aliases = ["바이오시밀러 시장"];

MERGE (n:LOCATION {name: '유럽'})
  ON CREATE SET n.type = '지역', n.country = '유럽', n.aliases = ["유럽"]
  ON MATCH  SET n.type = '지역', n.country = '유럽', n.aliases = ["유럽"];

MERGE (n:COMPANY {name: 'CMO'})
  ON CREATE SET n.aliases = ["CMO"]
  ON MATCH  SET n.aliases = ["CMO"];

MERGE (n:LOCATION {name: '스페인'})
  ON CREATE SET n.type = '국가', n.country = '스페인', n.region = '', n.aliases = ["스페인"]
  ON MATCH  SET n.type = '국가', n.country = '스페인', n.region = '', n.aliases = ["스페인"];

MERGE (n:LOCATION {name: '포르투갈'})
  ON CREATE SET n.type = '국가', n.country = '포르투갈', n.region = '', n.aliases = ["포르투갈"]
  ON MATCH  SET n.type = '국가', n.country = '포르투갈', n.region = '', n.aliases = ["포르투갈"];

MERGE (n:PRODUCT {name: '허쥬마'})
  ON CREATE SET n.category = '항암제', n.description = '성분명 트라스투주맙', n.launch_date = '', n.company = '셀트리온', n.aliases = ["허쥬마"]
  ON MATCH  SET n.category = '항암제', n.description = '성분명 트라스투주맙', n.launch_date = '', n.company = '셀트리온', n.aliases = ["허쥬마"];

MERGE (n:PRODUCT {name: '베그젤마'})
  ON CREATE SET n.category = '항암제', n.description = '성분명 베바시주맙', n.launch_date = '', n.company = '셀트리온', n.aliases = ["베그젤마"]
  ON MATCH  SET n.category = '항암제', n.description = '성분명 베바시주맙', n.launch_date = '', n.company = '셀트리온', n.aliases = ["베그젤마"];

MERGE (n:PRODUCT {name: '스테키마'})
  ON CREATE SET n.category = '자가면역질환 치료제', n.description = '성분명 우스테키누맙', n.launch_date = '2022-12', n.company = '셀트리온', n.aliases = ["스테키마"]
  ON MATCH  SET n.category = '자가면역질환 치료제', n.description = '성분명 우스테키누맙', n.launch_date = '2022-12', n.company = '셀트리온', n.aliases = ["스테키마"];

MERGE (n:ORGANIZATION {name: 'CSC'})
  ON CREATE SET n.type = '입찰 기관', n.description = '스페인 대형 입찰 기관, 카탈루냐주에 위치한 25개 공립병원의 의약품 공급 관할', n.aliases = ["CSC"]
  ON MATCH  SET n.type = '입찰 기관', n.description = '스페인 대형 입찰 기관, 카탈루냐주에 위치한 25개 공립병원의 의약품 공급 관할', n.aliases = ["CSC"];

MERGE (n:PERSON {name: '강석훈'})
  ON CREATE SET n.full_name = '강석훈', n.role = '법인장', n.nationality = '', n.age = '', n.aliases = ["강석훈"]
  ON MATCH  SET n.full_name = '강석훈', n.role = '법인장', n.nationality = '', n.age = '', n.aliases = ["강석훈"];

MERGE (n:PERSON {name: '유럽내'})
  ON CREATE SET n.role = '대표', n.aliases = ["유럽내"]
  ON MATCH  SET n.role = '대표', n.aliases = ["유럽내"];

MERGE (n:PERSON {name: '내'})
  ON CREATE SET n.role = '대표', n.aliases = ["내"]
  ON MATCH  SET n.role = '대표', n.aliases = ["내"];

MERGE (n:COMPANY {name: 'Kern Pharma'})
  ON CREATE SET n.aliases = ["Kern Pharma"]
  ON MATCH  SET n.aliases = ["Kern Pharma"];

MERGE (n:COMPANY {name: 'IQVIA'})
  ON CREATE SET n.aliases = ["IQVIA"]
  ON MATCH  SET n.aliases = ["IQVIA"];

MERGE (n:PRODUCT {name: '앱토즈마'})
  ON CREATE SET n.category = '신규 제품', n.description = '성분명 토실리주맙', n.aliases = ["앱토즈마"]
  ON MATCH  SET n.category = '신규 제품', n.description = '성분명 토실리주맙', n.aliases = ["앱토즈마"];

MERGE (n:LOCATION {name: '카탈루냐주'})
  ON CREATE SET n.type = '지역', n.country = '스페인', n.aliases = ["카탈루냐주"]
  ON MATCH  SET n.type = '지역', n.country = '스페인', n.aliases = ["카탈루냐주"];

MERGE (n:MARKET {name: '글로벌 전기차 캐즘'})
  ON CREATE SET n.description = '이차전지 관련 장비 수요 둔화', n.aliases = ["글로벌 전기차 캐즘"]
  ON MATCH  SET n.description = '이차전지 관련 장비 수요 둔화', n.aliases = ["글로벌 전기차 캐즘"];

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
  ON CREATE SET n.industry = '승강기 제조업', n.founded = '1987', n.headquarters = '경기도 시화공단', n.aliases = ["정일산업"]
  ON MATCH  SET n.industry = '승강기 제조업', n.founded = '1987', n.headquarters = '경기도 시화공단', n.aliases = ["정일산업"];

MERGE (n:LOCATION {name: '경기도 시화공단'})
  ON CREATE SET n.type = '산업단지', n.country = '대한민국', n.region = '경기', n.aliases = ["경기도 시화공단"]
  ON MATCH  SET n.type = '산업단지', n.country = '대한민국', n.region = '경기', n.aliases = ["경기도 시화공단"];

MERGE (n:LOCATION {name: '충북 충주'})
  ON CREATE SET n.type = '지역', n.country = '대한민국', n.region = '충북', n.aliases = ["충북 충주"]
  ON MATCH  SET n.type = '지역', n.country = '대한민국', n.region = '충북', n.aliases = ["충북 충주"];

MERGE (n:ORGANIZATION {name: '중소벤처기업연구원'})
  ON CREATE SET n.type = '연구기관', n.aliases = ["중소벤처기업연구원"]
  ON MATCH  SET n.type = '연구기관', n.aliases = ["중소벤처기업연구원"];

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

MERGE (n:COMPANY {name: '노루그룹'})
  ON CREATE SET n.industry = '화학', n.headquarters = '안양', n.aliases = ["노루그룹"]
  ON MATCH  SET n.industry = '화학', n.headquarters = '안양', n.aliases = ["노루그룹"];

MERGE (n:EVENT {name: '2025 신기술·신제품 전시회'})
  ON CREATE SET n.date = '2023-03-14 to 2023-03-18', n.type = '전시회', n.description = '미래 산업을 선도할 13종의 혁신 기술과 차세대 제품을 선보이는 행사', n.location = '안양', n.aliases = ["2025 신기술·신제품 전시회"]
  ON MATCH  SET n.date = '2023-03-14 to 2023-03-18', n.type = '전시회', n.description = '미래 산업을 선도할 13종의 혁신 기술과 차세대 제품을 선보이는 행사', n.location = '안양', n.aliases = ["2025 신기술·신제품 전시회"];

MERGE (n:TECHNOLOGY {name: '스텔스 도료'})
  ON CREATE SET n.category = '경량화 기술', n.description = '경량화를 극대화한 도료', n.field = '화학', n.aliases = ["스텔스 도료"]
  ON MATCH  SET n.category = '경량화 기술', n.description = '경량화를 극대화한 도료', n.field = '화학', n.aliases = ["스텔스 도료"];

MERGE (n:TECHNOLOGY {name: '우레탄 난연 몰딩제'})
  ON CREATE SET n.category = '배터리 기술', n.description = '친환경·고성능 배터리 시장을 겨냥한 몰딩제', n.field = '화학', n.aliases = ["우레탄 난연 몰딩제"]
  ON MATCH  SET n.category = '배터리 기술', n.description = '친환경·고성능 배터리 시장을 겨냥한 몰딩제', n.field = '화학', n.aliases = ["우레탄 난연 몰딩제"];

MERGE (n:TECHNOLOGY {name: '탄소 저감 건재용 도료'})
  ON CREATE SET n.category = '환경 기술', n.description = '탄소 저감에 기여하는 건재용 도료', n.field = '화학', n.aliases = ["탄소 저감 건재용 도료"]
  ON MATCH  SET n.category = '환경 기술', n.description = '탄소 저감에 기여하는 건재용 도료', n.field = '화학', n.aliases = ["탄소 저감 건재용 도료"];

MERGE (n:TECHNOLOGY {name: 'VOC 저감형 아크릴 수지'})
  ON CREATE SET n.category = '환경 기술', n.description = 'VOC 저감형 아크릴 수지', n.field = '화학', n.aliases = ["VOC 저감형 아크릴 수지"]
  ON MATCH  SET n.category = '환경 기술', n.description = 'VOC 저감형 아크릴 수지', n.field = '화학', n.aliases = ["VOC 저감형 아크릴 수지"];

MERGE (n:PERSON {name: '방양국'})
  ON CREATE SET n.full_name = '방양국', n.role = '연구소장', n.nationality = '', n.age = '', n.aliases = ["방양국"]
  ON MATCH  SET n.full_name = '방양국', n.role = '연구소장', n.nationality = '', n.age = '', n.aliases = ["방양국"];

MERGE (n:LOCATION {name: '안양'})
  ON CREATE SET n.type = '도시', n.country = '대한민국', n.region = '경기', n.aliases = ["안양"]
  ON MATCH  SET n.type = '도시', n.country = '대한민국', n.region = '경기', n.aliases = ["안양"];

MERGE (n:PERSON {name: '섹션은제품'})
  ON CREATE SET n.role = '대표', n.aliases = ["섹션은제품"]
  ON MATCH  SET n.role = '대표', n.aliases = ["섹션은제품"];

MERGE (n:PERSON {name: '섹션은'})
  ON CREATE SET n.role = '대표', n.aliases = ["섹션은"]
  ON MATCH  SET n.role = '대표', n.aliases = ["섹션은"];

MERGE (n:COMPANY {name: 'VOC'})
  ON CREATE SET n.aliases = ["VOC"]
  ON MATCH  SET n.aliases = ["VOC"];

MERGE (n:COMPANY {name: '패스트파이브'})
  ON CREATE SET n.industry = '클라우드 및 IT 솔루션', n.ceo = '김대일', n.aliases = ["패스트파이브"]
  ON MATCH  SET n.industry = '클라우드 및 IT 솔루션', n.ceo = '김대일', n.aliases = ["패스트파이브"];

MERGE (n:PRODUCT {name: '파이브클라우드'})
  ON CREATE SET n.category = '클라우드 서비스', n.description = '중소·중견기업 맞춤형 클라우드 및 IT 솔루션 통합 서비스', n.launch_date = '', n.company = '패스트파이브', n.aliases = ["파이브클라우드"]
  ON MATCH  SET n.category = '클라우드 서비스', n.description = '중소·중견기업 맞춤형 클라우드 및 IT 솔루션 통합 서비스', n.launch_date = '', n.company = '패스트파이브', n.aliases = ["파이브클라우드"];

MERGE (n:PRODUCT {name: '인테리어코드'})
  ON CREATE SET n.category = '통합 서비스', n.description = '패스트파이브의 인테리어 전문 브랜드 하이픈디자인과 협력한 서비스', n.launch_date = '', n.company = '패스트파이브', n.aliases = ["인테리어코드"]
  ON MATCH  SET n.category = '통합 서비스', n.description = '패스트파이브의 인테리어 전문 브랜드 하이픈디자인과 협력한 서비스', n.launch_date = '', n.company = '패스트파이브', n.aliases = ["인테리어코드"];

MERGE (n:ORGANIZATION {name: '아마존웹서비스'})
  ON CREATE SET n.type = '클라우드 서비스 제공자', n.description = '', n.aliases = ["아마존웹서비스"]
  ON MATCH  SET n.type = '클라우드 서비스 제공자', n.description = '', n.aliases = ["아마존웹서비스"];

MERGE (n:ORGANIZATION {name: 'Google'})
  ON CREATE SET n.type = '클라우드 서비스 제공자', n.description = '', n.aliases = ["Google"]
  ON MATCH  SET n.type = '클라우드 서비스 제공자', n.description = '', n.aliases = ["Google"];

MERGE (n:ORGANIZATION {name: '마이크로소프트365'})
  ON CREATE SET n.type = '클라우드 서비스 제공자', n.description = '', n.aliases = ["마이크로소프트365"]
  ON MATCH  SET n.type = '클라우드 서비스 제공자', n.description = '', n.aliases = ["마이크로소프트365"];

MERGE (n:EVENT {name: 'AWS 어드밴스드 티어 파트너 자격 취득'})
  ON CREATE SET n.date = '2023', n.type = '인증', n.description = '파이브클라우드가 국내 최단기간으로 취득', n.aliases = ["AWS 어드밴스드 티어 파트너 자격 취득"]
  ON MATCH  SET n.date = '2023', n.type = '인증', n.description = '파이브클라우드가 국내 최단기간으로 취득', n.aliases = ["AWS 어드밴스드 티어 파트너 자격 취득"];

MERGE (n:EVENT {name: 'AWS 한국파트너리그 수상'})
  ON CREATE SET n.date = '', n.type = '수상', n.description = '파이브클라우드가 3회 연속 수상', n.aliases = ["AWS 한국파트너리그 수상"]
  ON MATCH  SET n.date = '', n.type = '수상', n.description = '파이브클라우드가 3회 연속 수상', n.aliases = ["AWS 한국파트너리그 수상"];

MERGE (n:PERSON {name: '김대일'})
  ON CREATE SET n.full_name = '김대일', n.role = '대표', n.nationality = '', n.age = '', n.aliases = ["김대일"]
  ON MATCH  SET n.full_name = '김대일', n.role = '대표', n.nationality = '', n.age = '', n.aliases = ["김대일"];

MERGE (n:PERSON {name: '트파이브'})
  ON CREATE SET n.role = '대표', n.aliases = ["트파이브"]
  ON MATCH  SET n.role = '대표', n.aliases = ["트파이브"];

MERGE (n:PERSON {name: '패스트파이브'})
  ON CREATE SET n.role = '대표', n.aliases = ["패스트파이브"]
  ON MATCH  SET n.role = '대표', n.aliases = ["패스트파이브"];

MERGE (n:COMPANY {name: 'AWS'})
  ON CREATE SET n.aliases = ["AWS"]
  ON MATCH  SET n.aliases = ["AWS"];

MERGE (n:COMPANY {name: 'SaaS'})
  ON CREATE SET n.aliases = ["SaaS"]
  ON MATCH  SET n.aliases = ["SaaS"];

MERGE (n:PERSON {name: '박미경'})
  ON CREATE SET n.role = '제7대 하이서울기업협회장', n.aliases = ["박미경"]
  ON MATCH  SET n.role = '제7대 하이서울기업협회장', n.aliases = ["박미경"];

MERGE (n:ORGANIZATION {name: '하이서울기업협회'})
  ON CREATE SET n.type = '우수 중소기업 네트워크', n.description = '서울시와 서울산업진흥원이 지원하는 네트워크', n.aliases = ["하이서울기업협회"]
  ON MATCH  SET n.type = '우수 중소기업 네트워크', n.description = '서울시와 서울산업진흥원이 지원하는 네트워크', n.aliases = ["하이서울기업협회"];

MERGE (n:COMPANY {name: '포시에스'})
  ON CREATE SET n.full_name = '포시에스', n.industry = '전자문서', n.headquarters = '서울', n.founded = '', n.ceo = '박미경', n.aliases = ["포시에스"]
  ON MATCH  SET n.full_name = '포시에스', n.industry = '전자문서', n.headquarters = '서울', n.founded = '', n.ceo = '박미경', n.aliases = ["포시에스"];

MERGE (n:LOCATION {name: '서울'})
  ON CREATE SET n.type = '도시', n.country = '대한민국', n.region = '서울특별시', n.aliases = ["서울"]
  ON MATCH  SET n.type = '도시', n.country = '대한민국', n.region = '서울특별시', n.aliases = ["서울"];

MERGE (n:CONCEPT {name: 'AI'})
  ON CREATE SET n.type = '기술', n.description = '인공지능', n.aliases = ["AI"]
  ON MATCH  SET n.type = '기술', n.description = '인공지능', n.aliases = ["AI"];

MERGE (n:CONCEPT {name: '하이서울 프렌즈'})
  ON CREATE SET n.type = '인증', n.description = '해외 우수거래처에 부여하는 인증', n.aliases = ["하이서울 프렌즈"]
  ON MATCH  SET n.type = '인증', n.description = '해외 우수거래처에 부여하는 인증', n.aliases = ["하이서울 프렌즈"];

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

MERGE (n:PERSON {name: '김동선'})
  ON CREATE SET n.role = '부사장', n.full_name = '김동선', n.aliases = ["김동선"]
  ON MATCH  SET n.role = '부사장', n.full_name = '김동선', n.aliases = ["김동선"];

MERGE (n:PERSON {name: '곽동신'})
  ON CREATE SET n.role = '회장', n.full_name = '곽동신', n.aliases = ["곽동신"]
  ON MATCH  SET n.role = '회장', n.full_name = '곽동신', n.aliases = ["곽동신"];

MERGE (n:COMPANY {name: '한화세미텍'})
  ON CREATE SET n.full_name = '한화세미텍', n.industry = '반도체 장비', n.headquarters = '', n.founded = '2020', n.ceo = '김동선', n.aliases = ["한화세미텍"]
  ON MATCH  SET n.full_name = '한화세미텍', n.industry = '반도체 장비', n.headquarters = '', n.founded = '2020', n.ceo = '김동선', n.aliases = ["한화세미텍"];

MERGE (n:COMPANY {name: '한미반도체'})
  ON CREATE SET n.full_name = '한미반도체', n.industry = '반도체 장비', n.headquarters = '', n.founded = '1980', n.ceo = '곽동신', n.aliases = ["한미반도체"]
  ON MATCH  SET n.full_name = '한미반도체', n.industry = '반도체 장비', n.headquarters = '', n.founded = '1980', n.ceo = '곽동신', n.aliases = ["한미반도체"];

MERGE (n:COMPANY {name: 'SK하이닉스'})
  ON CREATE SET n.full_name = 'SK하이닉스', n.industry = '반도체', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["SK하이닉스"]
  ON MATCH  SET n.full_name = 'SK하이닉스', n.industry = '반도체', n.headquarters = '', n.founded = '', n.ceo = '', n.aliases = ["SK하이닉스"];

MERGE (n:PRODUCT {name: 'TC 본더'})
  ON CREATE SET n.category = '반도체 장비', n.description = '고대역폭 메모리(HBM) 제조 핵심 장비', n.aliases = ["TC 본더"]
  ON MATCH  SET n.category = '반도체 장비', n.description = '고대역폭 메모리(HBM) 제조 핵심 장비', n.aliases = ["TC 본더"];

MERGE (n:PROJECT {name: 'TC 본더 공동 개발'})
  ON CREATE SET n.description = 'SK하이닉스와 한미반도체의 TC 본더 공동 개발 프로젝트', n.start_date = '2017', n.status = '진행 중', n.aliases = ["TC 본더 공동 개발"]
  ON MATCH  SET n.description = 'SK하이닉스와 한미반도체의 TC 본더 공동 개발 프로젝트', n.start_date = '2017', n.status = '진행 중', n.aliases = ["TC 본더 공동 개발"];

MERGE (n:EVENT {name: 'TC 본더 공급 계약'})
  ON CREATE SET n.date = '2023-03', n.type = '계약', n.description = '한화세미텍과 SK하이닉스 간의 TC 본더 공급 계약', n.location = '', n.aliases = ["TC 본더 공급 계약"]
  ON MATCH  SET n.date = '2023-03', n.type = '계약', n.description = '한화세미텍과 SK하이닉스 간의 TC 본더 공급 계약', n.location = '', n.aliases = ["TC 본더 공급 계약"];

MERGE (n:INVESTMENT {name: 'R&D 투자'})
  ON CREATE SET n.amount = '677억원', n.date = '2022', n.type = '연구개발', n.aliases = ["R&D 투자"]
  ON MATCH  SET n.amount = '677억원', n.date = '2022', n.type = '연구개발', n.aliases = ["R&D 투자"];

MERGE (n:LEGAL {name: '특허 침해 소송'})
  ON CREATE SET n.type = '소송', n.date = '2022-12', n.description = '한미반도체가 한화세미텍을 상대로 제기한 TC 본더 관련 특허 침해 소송', n.aliases = ["특허 침해 소송"]
  ON MATCH  SET n.type = '소송', n.date = '2022-12', n.description = '한미반도체가 한화세미텍을 상대로 제기한 TC 본더 관련 특허 침해 소송', n.aliases = ["특허 침해 소송"];

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

MERGE (n:COMPANY {name: '유한양행'})
  ON CREATE SET n.industry = '제약바이오', n.aliases = ["유한양행"]
  ON MATCH  SET n.industry = '제약바이오', n.aliases = ["유한양행"];

MERGE (n:COMPANY {name: 'GC녹십자'})
  ON CREATE SET n.industry = '제약바이오', n.aliases = ["GC녹십자"]
  ON MATCH  SET n.industry = '제약바이오', n.aliases = ["GC녹십자"];

MERGE (n:COMPANY {name: '대웅제약'})
  ON CREATE SET n.industry = '제약바이오', n.aliases = ["대웅제약"]
  ON MATCH  SET n.industry = '제약바이오', n.aliases = ["대웅제약"];

MERGE (n:PRODUCT {name: '피즈치바'})
  ON CREATE SET n.category = '바이오시밀러', n.description = '스텔라라 시밀러', n.launch_date = '2023-01', n.company = '삼성바이오에피스', n.aliases = ["피즈치바"]
  ON MATCH  SET n.category = '바이오시밀러', n.description = '스텔라라 시밀러', n.launch_date = '2023-01', n.company = '삼성바이오에피스', n.aliases = ["피즈치바"];

MERGE (n:PRODUCT {name: '램시마SC'})
  ON CREATE SET n.category = '바이오시밀러', n.description = '자가면역질환 치료제', n.launch_date = '2022-01', n.company = '셀트리온', n.aliases = ["램시마SC"]
  ON MATCH  SET n.category = '바이오시밀러', n.description = '자가면역질환 치료제', n.launch_date = '2022-01', n.company = '셀트리온', n.aliases = ["램시마SC"];

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
  ON CREATE SET n.category = '보툴리눔톡신', n.description = '', n.launch_date = '', n.company = '대웅제약', n.aliases = ["나보타"]
  ON MATCH  SET n.category = '보툴리눔톡신', n.description = '', n.launch_date = '', n.company = '대웅제약', n.aliases = ["나보타"];

MERGE (n:COMPANY {name: '한미약품'})
  ON CREATE SET n.industry = '제약바이오', n.aliases = ["한미약품"]
  ON MATCH  SET n.industry = '제약바이오', n.aliases = ["한미약품"];

MERGE (n:COMPANY {name: '종근당'})
  ON CREATE SET n.industry = '제약바이오', n.aliases = ["종근당"]
  ON MATCH  SET n.industry = '제약바이오', n.aliases = ["종근당"];

MERGE (n:COMPANY {name: '보령'})
  ON CREATE SET n.industry = '제약바이오', n.aliases = ["보령"]
  ON MATCH  SET n.industry = '제약바이오', n.aliases = ["보령"];

MERGE (n:COMPANY {name: 'LG화학'})
  ON CREATE SET n.industry = '제약바이오', n.aliases = ["LG화학"]
  ON MATCH  SET n.industry = '제약바이오', n.aliases = ["LG화학"];

MERGE (n:COMPANY {name: '셀트리온제약'})
  ON CREATE SET n.industry = '제약바이오', n.aliases = ["셀트리온제약"]
  ON MATCH  SET n.industry = '제약바이오', n.aliases = ["셀트리온제약"];

MERGE (n:PRODUCT {name: '고덱스'})
  ON CREATE SET n.category = '간장약', n.description = '', n.launch_date = '', n.company = '셀트리온제약', n.aliases = ["고덱스"]
  ON MATCH  SET n.category = '간장약', n.description = '', n.launch_date = '', n.company = '셀트리온제약', n.aliases = ["고덱스"];

MERGE (n:PRODUCT {name: '케이캡'})
  ON CREATE SET n.category = '위식도역류질환 치료제', n.description = '', n.launch_date = '', n.company = 'HK이노엔', n.aliases = ["케이캡"]
  ON MATCH  SET n.category = '위식도역류질환 치료제', n.description = '', n.launch_date = '', n.company = 'HK이노엔', n.aliases = ["케이캡"];

MERGE (n:COMPANY {name: 'HK이노엔'})
  ON CREATE SET n.industry = '제약바이오', n.aliases = ["HK이노엔"]
  ON MATCH  SET n.industry = '제약바이오', n.aliases = ["HK이노엔"];

MERGE (n:INDUSTRY {name: '제약바이오'})
  ON CREATE SET n.description = '바이오의약품과 신약 개발', n.aliases = ["제약바이오"]
  ON MATCH  SET n.description = '바이오의약품과 신약 개발', n.aliases = ["제약바이오"];

MERGE (n:PERSON {name: '바이'})
  ON CREATE SET n.role = '대표', n.aliases = ["바이"]
  ON MATCH  SET n.role = '대표', n.aliases = ["바이"];

MERGE (n:COMPANY {name: 'CDMO'})
  ON CREATE SET n.aliases = ["CDMO"]
  ON MATCH  SET n.aliases = ["CDMO"];

MERGE (n:EVENT {name: '1분기 중소기업 수출 동향 발표'})
  ON CREATE SET n.date = '2023-04-14', n.type = '발표', n.description = '중소기업 수출 동향 발표', n.aliases = ["1분기 중소기업 수출 동향 발표"]
  ON MATCH  SET n.date = '2023-04-14', n.type = '발표', n.description = '중소기업 수출 동향 발표', n.aliases = ["1분기 중소기업 수출 동향 발표"];

MERGE (n:COMPANY {name: '락앤락'})
  ON CREATE SET n.industry = '생활용품', n.headquarters = '서울', n.aliases = ["락앤락"]
  ON MATCH  SET n.industry = '생활용품', n.headquarters = '서울', n.aliases = ["락앤락"];

MERGE (n:PRODUCT {name: '풀히트 푸드워머'})
  ON CREATE SET n.category = '테이블웨어', n.description = '바닥 전체에 열선이 내장되어 10초 내 예열, 실리콘 소재 롤러블 디자인, 온도 조절 가능', n.launch_date = '2023-04-14', n.company = '락앤락', n.aliases = ["풀히트 푸드워머"]
  ON MATCH  SET n.category = '테이블웨어', n.description = '바닥 전체에 열선이 내장되어 10초 내 예열, 실리콘 소재 롤러블 디자인, 온도 조절 가능', n.launch_date = '2023-04-14', n.company = '락앤락', n.aliases = ["풀히트 푸드워머"];

MERGE (n:PERSON {name: '류난영'})
  ON CREATE SET n.role = '기자', n.nationality = '', n.age = '', n.aliases = ["류난영"]
  ON MATCH  SET n.role = '기자', n.nationality = '', n.age = '', n.aliases = ["류난영"];

MERGE (n:EVENT {name: '제품 출시 기념 프로모션'})
  ON CREATE SET n.date = '2023-04-14 to 2023-04-21', n.type = '프로모션', n.description = '락앤락몰에서 진행', n.aliases = ["제품 출시 기념 프로모션"]
  ON MATCH  SET n.date = '2023-04-14 to 2023-04-21', n.type = '프로모션', n.description = '락앤락몰에서 진행', n.aliases = ["제품 출시 기념 프로모션"];

MERGE (n:EVENT {name: '2025 경기도 동반성장 페어'})
  ON CREATE SET n.date = '2023-04-13', n.type = '상생협력 행사', n.description = '경기도와 동반성장위원회가 공동으로 개최한 행사', n.aliases = ["2025 경기도 동반성장 페어"]
  ON MATCH  SET n.date = '2023-04-13', n.type = '상생협력 행사', n.description = '경기도와 동반성장위원회가 공동으로 개최한 행사', n.aliases = ["2025 경기도 동반성장 페어"];

MERGE (n:LOCATION {name: '수원메쎄 1홀'})
  ON CREATE SET n.type = '행사 장소', n.country = '대한민국', n.region = '경기', n.aliases = ["수원메쎄 1홀"]
  ON MATCH  SET n.type = '행사 장소', n.country = '대한민국', n.region = '경기', n.aliases = ["수원메쎄 1홀"];

MERGE (n:ORGANIZATION {name: 'Naver'})
  ON CREATE SET n.type = '기업', n.description = '인터넷 서비스 기업', n.headquarters = '', n.aliases = ["Naver"]
  ON MATCH  SET n.type = '기업', n.description = '인터넷 서비스 기업', n.headquarters = '', n.aliases = ["Naver"];

MERGE (n:ORGANIZATION {name: '현대모비스'})
  ON CREATE SET n.type = '기업', n.description = '자동차 부품 제조 기업', n.headquarters = '', n.aliases = ["현대모비스"]
  ON MATCH  SET n.type = '기업', n.description = '자동차 부품 제조 기업', n.headquarters = '', n.aliases = ["현대모비스"];

MERGE (n:ORGANIZATION {name: '대상'})
  ON CREATE SET n.type = '기업', n.description = '식품 제조 기업', n.headquarters = '', n.aliases = ["대상"]
  ON MATCH  SET n.type = '기업', n.description = '식품 제조 기업', n.headquarters = '', n.aliases = ["대상"];

MERGE (n:PERSON {name: '이달곤'})
  ON CREATE SET n.full_name = '이달곤', n.role = '동반성장위원장', n.nationality = '', n.age = '', n.aliases = ["이달곤"]
  ON MATCH  SET n.full_name = '이달곤', n.role = '동반성장위원장', n.nationality = '', n.age = '', n.aliases = ["이달곤"];

MERGE (n:PROJECT {name: '제2차 경기도 공정경제 5개년 기본계획'})
  ON CREATE SET n.description = '경기도의 공정경제 추진 계획', n.start_date = '2025', n.status = '수립 중', n.aliases = ["제2차 경기도 공정경제 5개년 기본계획"]
  ON MATCH  SET n.description = '경기도의 공정경제 추진 계획', n.start_date = '2025', n.status = '수립 중', n.aliases = ["제2차 경기도 공정경제 5개년 기본계획"];

MERGE (n:PERSON {name: '프로'})
  ON CREATE SET n.role = '대표', n.aliases = ["프로"]
  ON MATCH  SET n.role = '대표', n.aliases = ["프로"];

MERGE (n:COMPANY {name: '파세코'})
  ON CREATE SET n.full_name = '파세코', n.industry = '가전제품', n.headquarters = '안산', n.founded = '', n.ceo = '', n.aliases = ["파세코"]
  ON MATCH  SET n.full_name = '파세코', n.industry = '가전제품', n.headquarters = '안산', n.founded = '', n.ceo = '', n.aliases = ["파세코"];

MERGE (n:LOCATION {name: '안산'})
  ON CREATE SET n.type = '지역', n.country = '대한민국', n.region = '경기', n.aliases = ["안산"]
  ON MATCH  SET n.type = '지역', n.country = '대한민국', n.region = '경기', n.aliases = ["안산"];

MERGE (n:PRODUCT {name: '창문형 에어컨'})
  ON CREATE SET n.category = '가전제품', n.description = '창문형 에어컨, AI 모드, 환기 시스템', n.launch_date = '2023-09', n.company = '파세코', n.aliases = ["창문형 에어컨"]
  ON MATCH  SET n.category = '가전제품', n.description = '창문형 에어컨, AI 모드, 환기 시스템', n.launch_date = '2023-09', n.company = '파세코', n.aliases = ["창문형 에어컨"];

MERGE (n:PERSON {name: '김상우'})
  ON CREATE SET n.full_name = '김상우', n.role = '리테일사업부 상무', n.nationality = '', n.age = '', n.aliases = ["김상우"]
  ON MATCH  SET n.full_name = '김상우', n.role = '리테일사업부 상무', n.nationality = '', n.age = '', n.aliases = ["김상우"];

MERGE (n:PERSON {name: '박치호'})
  ON CREATE SET n.full_name = '박치호', n.role = '기술연구소 팀장', n.nationality = '', n.age = '', n.aliases = ["박치호"]
  ON MATCH  SET n.full_name = '박치호', n.role = '기술연구소 팀장', n.nationality = '', n.age = '', n.aliases = ["박치호"];

MERGE (n:TECHNOLOGY {name: 'AI 에너지 세이빙'})
  ON CREATE SET n.category = '에너지 절약 기술', n.description = '주위 온도 감지 및 자동 조절', n.field = '사물인터넷(IoT)', n.aliases = ["AI 에너지 세이빙"]
  ON MATCH  SET n.category = '에너지 절약 기술', n.description = '주위 온도 감지 및 자동 조절', n.field = '사물인터넷(IoT)', n.aliases = ["AI 에너지 세이빙"];

MERGE (n:EVENT {name: '미국의 철강·알루미늄 관세 조치'})
  ON CREATE SET n.date = '2023-01-01 to 2023-03-31', n.type = '정책', n.description = '미국의 철강 및 알루미늄 제품에 대한 관세 부과', n.aliases = ["미국의 철강·알루미늄 관세 조치"]
  ON MATCH  SET n.date = '2023-01-01 to 2023-03-31', n.type = '정책', n.description = '미국의 철강 및 알루미늄 제품에 대한 관세 부과', n.aliases = ["미국의 철강·알루미늄 관세 조치"];

MERGE (n:EVENT {name: '2025년도 1분기 중소기업 수출 동향 발표'})
  ON CREATE SET n.date = '2023-04-14', n.type = '발표', n.description = '중소기업 수출 증가 발표', n.aliases = ["2025년도 1분기 중소기업 수출 동향 발표"]
  ON MATCH  SET n.date = '2023-04-14', n.type = '발표', n.description = '중소기업 수출 증가 발표', n.aliases = ["2025년도 1분기 중소기업 수출 동향 발표"];

MERGE (n:COMPANY {name: '한국서부발전'})
  ON CREATE SET n.full_name = '한국서부발전', n.industry = '발전', n.headquarters = '태안', n.founded = '', n.ceo = '', n.aliases = ["한국서부발전"]
  ON MATCH  SET n.full_name = '한국서부발전', n.industry = '발전', n.headquarters = '태안', n.founded = '', n.ceo = '', n.aliases = ["한국서부발전"];

MERGE (n:PROJECT {name: '발전정보 활용 창업·벤처기업 협업사업'})
  ON CREATE SET n.description = '발전정보를 활용한 창의적인 기술 개발 및 실증 사업화 연계 프로그램', n.start_date = '', n.status = '공모 중', n.aliases = ["발전정보 활용 창업·벤처기업 협업사업"]
  ON MATCH  SET n.description = '발전정보를 활용한 창의적인 기술 개발 및 실증 사업화 연계 프로그램', n.start_date = '', n.status = '공모 중', n.aliases = ["발전정보 활용 창업·벤처기업 협업사업"];

MERGE (n:ORGANIZATION {name: '창업·벤처기업'})
  ON CREATE SET n.type = '기업', n.description = '창업 7년 이내 중소기업 또는 창업·벤처기업', n.headquarters = '', n.aliases = ["창업·벤처기업"]
  ON MATCH  SET n.type = '기업', n.description = '창업 7년 이내 중소기업 또는 창업·벤처기업', n.headquarters = '', n.aliases = ["창업·벤처기업"];

MERGE (n:EVENT {name: '해외 실증 지원사업'})
  ON CREATE SET n.date = '', n.type = '지원사업', n.description = '협업 우수기업에 해외 실증 기회 제공', n.location = '해외', n.aliases = ["해외 실증 지원사업"]
  ON MATCH  SET n.date = '', n.type = '지원사업', n.description = '협업 우수기업에 해외 실증 기회 제공', n.location = '해외', n.aliases = ["해외 실증 지원사업"];

MERGE (n:INVESTMENT {name: '지원금'})
  ON CREATE SET n.amount = '1000만~3000만원', n.date = '', n.type = '지원', n.aliases = ["지원금"]
  ON MATCH  SET n.amount = '1000만~3000만원', n.date = '', n.type = '지원', n.aliases = ["지원금"];

MERGE (n:MARKET {name: '복지몰'})
  ON CREATE SET n.description = '현대이지웰의 복지몰', n.aliases = ["복지몰"]
  ON MATCH  SET n.description = '현대이지웰의 복지몰', n.aliases = ["복지몰"];

MATCH (a:COMPANY {name: '에이텀'}),
      (b:COMPANY   {name: 'DST'})
MERGE (a)-[r:ACQUIRED]->(b)
  ON CREATE SET r.date = '2023-02-02', r.amount = '145억 원'
  ON MATCH  SET r.date = '2023-02-02', r.amount = '145억 원';

MATCH (a:PERSON {name: '이충헌'}),
      (b:COMPANY   {name: '밸류파인더'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '연구원'
  ON MATCH  SET r.position = '연구원';

MATCH (a:COMPANY {name: '에이텀'}),
      (b:PRODUCT   {name: 'TA트랜스'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '에이텀'}),
      (b:PRODUCT   {name: 'TV트랜스'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '에이텀'}),
      (b:PRODUCT   {name: '전기차용 트랜스'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: 'DST'}),
      (b:PRODUCT   {name: '힘센엔진 실린더'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: 'DST'}),
      (b:COMPANY   {name: 'HD현대중공업'})
MERGE (a)-[r:SUPPLIES]->(b)
  ON CREATE SET r.product = '힘센엔진 실린더'
  ON MATCH  SET r.product = '힘센엔진 실린더';

MATCH (a:COMPANY {name: '에이텀'}),
      (b:_UNSPEC   {name: '삼성전자'})
MERGE (a)-[r:SUPPLIES]->(b)
  ON CREATE SET r.product = '45W 트랜스'
  ON MATCH  SET r.product = '45W 트랜스';

MATCH (a:COMPANY {name: '에이스침대'}),
      (b:FINANCIAL_METRIC   {name: '매출'})
MERGE (a)-[r:REPORTED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:COMPANY {name: '에이스침대'}),
      (b:FINANCIAL_METRIC   {name: '영업이익'})
MERGE (a)-[r:REPORTED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:COMPANY {name: '에이스침대'}),
      (b:FINANCIAL_METRIC   {name: '분기순이익'})
MERGE (a)-[r:REPORTED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:CONCEPT {name: '경영환경 악화'}),
      (b:COMPANY   {name: '에이스침대'})
MERGE (a)-[r:AFFECTS]->(b);

MATCH (a:COMPANY {name: '에이스침대'}),
      (b:CONCEPT   {name: '경영 내실화'})
MERGE (a)-[r:FOCUSES_ON]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:EVENT   {name: '글로벌 물류 지원 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:EVENT   {name: '글로벌 물류 지원 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:ORGANIZATION   {name: '부산항만공사'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '글로벌 물류 지원', r.date = '2023-04-14'
  ON MATCH  SET r.type = '글로벌 물류 지원', r.date = '2023-04-14';

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:_UNSPEC   {name: 'LOCATION'})
MERGE (a)-[r:PLANS_TO_EXPAND]->(b)
  ON CREATE SET r.locations = ["부산", "인천", "여수 광양"]
  ON MATCH  SET r.locations = ["부산", "인천", "여수 광양"];

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
      (b:PROJECT   {name: '스마트트레이드허브'})
MERGE (a)-[r:PARTNERED_WITH]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:PROJECT   {name: '통합물류 지원 플랫폼'})
MERGE (a)-[r:LEADS]->(b);

MATCH (a:PERSON {name: '강석진'}),
      (b:ORGANIZATION   {name: '중소벤처기업진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장', r.since = ''
  ON MATCH  SET r.position = '이사장', r.since = '';

MATCH (a:MARKET {name: '중소기업 수출 시장'}),
      (b:CONCEPT   {name: '미국 관세 정책'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '수출 감소'
  ON MATCH  SET r.impact = '수출 감소';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1840000000 달러', r.growth_rate = '+19.6%'
  ON MATCH  SET r.amount = '1840000000 달러', r.growth_rate = '+19.6%';

MATCH (a:PRODUCT {name: '자동차'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1740000000 달러', r.growth_rate = '+67.4%'
  ON MATCH  SET r.amount = '1740000000 달러', r.growth_rate = '+67.4%';

MATCH (a:PRODUCT {name: '철강'}),
      (b:CONCEPT   {name: '미국 관세 정책'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '수출 감소', r.percentage = '-17.8%'
  ON MATCH  SET r.impact = '수출 감소', r.percentage = '-17.8%';

MATCH (a:PRODUCT {name: '알루미늄'}),
      (b:CONCEPT   {name: '미국 관세 정책'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '수출 감소', r.percentage = '-7.6%'
  ON MATCH  SET r.impact = '수출 감소', r.percentage = '-7.6%';

MATCH (a:ORGANIZATION {name: '중소벤처기업부'}),
      (b:MARKET   {name: '중소기업 수출 시장'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14', r.description = '중소기업 수출 증가 발표'
  ON MATCH  SET r.date = '2023-04-14', r.description = '중소기업 수출 증가 발표';

MATCH (a:PERSON {name: '이순배'}),
      (b:ORGANIZATION   {name: '중소벤처기업부'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '글로벌성장정책관', r.since = ''
  ON MATCH  SET r.position = '글로벌성장정책관', r.since = '';

MATCH (a:ORGANIZATION {name: '동반성장위원회'}),
      (b:COMPANY   {name: 'LG이노텍'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '협력사 ESG 지원사업', r.date = '2023-04-14'
  ON MATCH  SET r.type = '협력사 ESG 지원사업', r.date = '2023-04-14';

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:PERSON   {name: '에이피텍'})
MERGE (a)-[r:SUPPLIES]->(b)
  ON CREATE SET r.product = '제조설비'
  ON MATCH  SET r.product = '제조설비';

MATCH (a:ORGANIZATION {name: '동반성장위원회'}),
      (b:AGREEMENT   {name: '협력사 ESG 지원사업 업무협약'})
MERGE (a)-[r:HELD]->(b);

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:PROJECT   {name: '대·중소 자율형 ESG 지원사업'})
MERGE (a)-[r:PARTICIPATED_IN]->(b);

MATCH (a:PERSON {name: '박치형'}),
      (b:AGREEMENT   {name: '협력사 ESG 지원사업 업무협약'})
MERGE (a)-[r:SPOKE_AT]->(b)
  ON CREATE SET r.topic = 'ESG 협력모델 확대'
  ON MATCH  SET r.topic = 'ESG 협력모델 확대';

MATCH (a:PERSON {name: '김준성'}),
      (b:AGREEMENT   {name: '협력사 ESG 지원사업 업무협약'})
MERGE (a)-[r:SPOKE_AT]->(b)
  ON CREATE SET r.topic = '상생 협력과 고객가치 창출'
  ON MATCH  SET r.topic = '상생 협력과 고객가치 창출';

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:CONCEPT   {name: '2040 탄소중립'})
MERGE (a)-[r:ANNOUNCED]->(b);

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:CONCEPT   {name: '2030년 RE100 달성'})
MERGE (a)-[r:ANNOUNCED]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:ORGANIZATION   {name: '부산항만공사'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '글로벌 물류 지원', r.date = '2023-04-14'
  ON MATCH  SET r.type = '글로벌 물류 지원', r.date = '2023-04-14';

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:EVENT   {name: '글로벌 물류 지원 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:EVENT   {name: '글로벌 물류 지원 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:LOCATION   {name: '부산'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '부산'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '로스앤젤레스'})
MERGE (a)-[r:OPERATES]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '롱비치'})
MERGE (a)-[r:OPERATES]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:PROJECT   {name: '스마트트레이드허브'})
MERGE (a)-[r:PARTNERED_WITH]->(b);

MATCH (a:PERSON {name: '강석진'}),
      (b:ORGANIZATION   {name: '중소벤처기업진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장', r.since = ''
  ON MATCH  SET r.position = '이사장', r.since = '';

MATCH (a:COMPANY {name: '한샘'}),
      (b:MARKET   {name: '건설경기'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '매출 감소'
  ON MATCH  SET r.impact = '매출 감소';

MATCH (a:COMPANY {name: '현대리바트'}),
      (b:MARKET   {name: '건설경기'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '매출 감소'
  ON MATCH  SET r.impact = '매출 감소';

MATCH (a:COMPANY {name: '한샘'}),
      (b:EVENT   {name: '1분기 매출 감소'})
MERGE (a)-[r:PARTICIPATED_IN]->(b);

MATCH (a:COMPANY {name: '현대리바트'}),
      (b:EVENT   {name: '1분기 매출 감소'})
MERGE (a)-[r:PARTICIPATED_IN]->(b);

MATCH (a:COMPANY {name: '한샘'}),
      (b:EVENT   {name: '오피스 인테리어 사업 확장'})
MERGE (a)-[r:EXPANDS_INTO]->(b);

MATCH (a:COMPANY {name: '현대리바트'}),
      (b:EVENT   {name: '오피스 인테리어 사업 확장'})
MERGE (a)-[r:EXPANDS_INTO]->(b);

MATCH (a:COMPANY {name: '한샘'}),
      (b:INDUSTRY   {name: 'B2C'})
MERGE (a)-[r:FOCUSES_ON]->(b)
  ON CREATE SET r.strategy = '수익성 중심 경영'
  ON MATCH  SET r.strategy = '수익성 중심 경영';

MATCH (a:COMPANY {name: '현대리바트'}),
      (b:INDUSTRY   {name: 'B2B'})
MERGE (a)-[r:FOCUSES_ON]->(b)
  ON CREATE SET r.strategy = '수익성 중심 경영'
  ON MATCH  SET r.strategy = '수익성 중심 경영';

MATCH (a:ORGANIZATION {name: '동반성장위원회'}),
      (b:EVENT   {name: 'ESG 지원 업무협약 체결식'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:EVENT   {name: 'ESG 지원 업무협약 체결식'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:PERSON {name: '에이피텍'}),
      (b:EVENT   {name: 'ESG 지원 업무협약 체결식'})
MERGE (a)-[r:PARTICIPATED_IN]->(b);

MATCH (a:PERSON {name: '박치형'}),
      (b:EVENT   {name: 'ESG 지원 업무협약 체결식'})
MERGE (a)-[r:ATTENDED]->(b);

MATCH (a:PERSON {name: '김준성'}),
      (b:EVENT   {name: 'ESG 지원 업무협약 체결식'})
MERGE (a)-[r:ATTENDED]->(b);

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:ORGANIZATION   {name: '동반성장위원회'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = 'ESG 지원사업', r.date = '2023'
  ON MATCH  SET r.type = 'ESG 지원사업', r.date = '2023';

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:PROJECT   {name: '대·중소 자율형 ESG 지원사업'})
MERGE (a)-[r:PARTICIPATED_IN]->(b);

MATCH (a:PERSON {name: '에이피텍'}),
      (b:_UNSPEC   {name: '제조설비'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:ORGANIZATION {name: '기술보증기금 지식재산공제센터'}),
      (b:AGREEMENT   {name: '지식재산공제사업 활성화를 통한 공동발전 업무 협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '인천지식재산센터'}),
      (b:AGREEMENT   {name: '지식재산공제사업 활성화를 통한 공동발전 업무 협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '기술보증기금 지식재산공제센터'}),
      (b:ORGANIZATION   {name: '인천지식재산센터'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '지식재산공제사업 활성화', r.date = '2023-04-14'
  ON MATCH  SET r.type = '지식재산공제사업 활성화', r.date = '2023-04-14';

MATCH (a:ORGANIZATION {name: '기술보증기금 지식재산공제센터'}),
      (b:PROJECT   {name: '지식재산공제사업'})
MERGE (a)-[r:LEADS]->(b);

MATCH (a:ORGANIZATION {name: '특허청'}),
      (b:ORGANIZATION   {name: '기술보증기금 지식재산공제센터'})
MERGE (a)-[r:PARTNERED_WITH]->(b);

MATCH (a:ORGANIZATION {name: '인천지식재산센터'}),
      (b:LOCATION   {name: '인천'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1840000000 달러', r.growth_rate = '+19.6%', r.increase_rate = '19.6%'
  ON MATCH  SET r.amount = '1840000000 달러', r.growth_rate = '+19.6%', r.increase_rate = '19.6%';

MATCH (a:PRODUCT {name: '자동차'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1740000000 달러', r.growth_rate = '+67.4%', r.increase_rate = '67.4%'
  ON MATCH  SET r.amount = '1740000000 달러', r.growth_rate = '+67.4%', r.increase_rate = '67.4%';

MATCH (a:PRODUCT {name: '반도체 제조용 장비'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.growth_rate = '-47.4%'
  ON MATCH  SET r.amount = '', r.growth_rate = '-47.4%';

MATCH (a:PRODUCT {name: '전자응용기기'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '130000000 달러', r.growth_rate = '-25.6%'
  ON MATCH  SET r.amount = '130000000 달러', r.growth_rate = '-25.6%';

MATCH (a:PRODUCT {name: '철강 제품'}),
      (b:CONCEPT   {name: '미국 관세 정책'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '수출 감소', r.percentage = '-17.8%'
  ON MATCH  SET r.impact = '수출 감소', r.percentage = '-17.8%';

MATCH (a:PRODUCT {name: '알루미늄 제품'}),
      (b:CONCEPT   {name: '미국 관세 정책'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '수출 감소', r.percentage = '-7.6%'
  ON MATCH  SET r.impact = '수출 감소', r.percentage = '-7.6%';

MATCH (a:ORGANIZATION {name: '중소벤처기업부'}),
      (b:_UNSPEC   {name: 'EVENT'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14', r.description = '중소기업 수출 증가 발표'
  ON MATCH  SET r.date = '2023-04-14', r.description = '중소기업 수출 증가 발표';

MATCH (a:PERSON {name: '이순배'}),
      (b:ORGANIZATION   {name: '중소벤처기업부'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '글로벌성장정책관', r.since = ''
  ON MATCH  SET r.position = '글로벌성장정책관', r.since = '';

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:EVENT   {name: '글로벌 물류 지원 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:EVENT   {name: '글로벌 물류 지원 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:ORGANIZATION   {name: '부산항만공사'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '물류 협력', r.date = '2023-04-14'
  ON MATCH  SET r.type = '물류 협력', r.date = '2023-04-14';

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:_UNSPEC   {name: 'LOCATION'})
MERGE (a)-[r:PLANS_TO_EXPAND]->(b)
  ON CREATE SET r.locations = ["부산", "인천", "여수 광양"]
  ON MATCH  SET r.locations = ["부산", "인천", "여수 광양"];

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '부산'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '로스앤젤레스'})
MERGE (a)-[r:OPERATES]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '롱비치'})
MERGE (a)-[r:OPERATES]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:PROJECT   {name: '스마트트레이드허브'})
MERGE (a)-[r:PARTNERED_WITH]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:PROJECT   {name: '항공·해운 통합물류 지원 플랫폼'})
MERGE (a)-[r:LEADS]->(b);

MATCH (a:PERSON {name: '강석진'}),
      (b:ORGANIZATION   {name: '중소벤처기업진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장', r.since = ''
  ON MATCH  SET r.position = '이사장', r.since = '';

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:COMPANY   {name: '현대백화점그룹'})
MERGE (a)-[r:SUBSIDIARY_OF]->(b);

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:ORGANIZATION   {name: '한국중소벤처기업유통원'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '지원사업', r.date = '2023'
  ON MATCH  SET r.type = '지원사업', r.date = '2023';

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:AGREEMENT   {name: '다농마트 청년몰 이용 활성화를 위한 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:EVENT   {name: '소상공인 온라인쇼핑몰 판매지원사업'})
MERGE (a)-[r:CONDUCTED]->(b);

MATCH (a:ORGANIZATION {name: '경기도'}),
      (b:COMPANY   {name: '현대이지웰'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '동반성장위원회'}),
      (b:AGREEMENT   {name: '협력사 ESG 지원사업 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:AGREEMENT   {name: '협력사 ESG 지원사업 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:ORGANIZATION   {name: '동반성장위원회'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = 'ESG 지원사업', r.date = '2023-04-14'
  ON MATCH  SET r.type = 'ESG 지원사업', r.date = '2023-04-14';

MATCH (a:AGREEMENT {name: '협력사 ESG 지원사업 업무협약'}),
      (b:LOCATION   {name: '인천 송도'})
MERGE (a)-[r:HELD_IN]->(b);

MATCH (a:PERSON {name: '에이피텍'}),
      (b:EVENT   {name: 'ESG 우수 중소기업 현판식'})
MERGE (a)-[r:PARTICIPATED_IN]->(b);

MATCH (a:COMPANY {name: 'LG이노텍'}),
      (b:PERSON   {name: '에이피텍'})
MERGE (a)-[r:SUPPLIES]->(b)
  ON CREATE SET r.product = '핸드폰 카메라 모듈 생산 설비'
  ON MATCH  SET r.product = '핸드폰 카메라 모듈 생산 설비';

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:EVENT   {name: '글로벌 물류 지원 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:EVENT   {name: '글로벌 물류 지원 업무협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:ORGANIZATION   {name: '부산항만공사'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '물류 지원 협력', r.date = '2023-04-14'
  ON MATCH  SET r.type = '물류 지원 협력', r.date = '2023-04-14';

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '부산'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '로스앤젤레스'})
MERGE (a)-[r:OPERATES]->(b);

MATCH (a:ORGANIZATION {name: '부산항만공사'}),
      (b:LOCATION   {name: '롱비치'})
MERGE (a)-[r:OPERATES]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업진흥공단'}),
      (b:_UNSPEC   {name: 'LOCATION'})
MERGE (a)-[r:PLANS_TO_EXPAND]->(b)
  ON CREATE SET r.locations = ["부산", "인천", "여수 광양"]
  ON MATCH  SET r.locations = ["부산", "인천", "여수 광양"];

MATCH (a:PERSON {name: '강석진'}),
      (b:ORGANIZATION   {name: '중소벤처기업진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장', r.since = ''
  ON MATCH  SET r.position = '이사장', r.since = '';

MATCH (a:EVENT {name: '글로벌 물류 지원 업무협약'}),
      (b:_UNSPEC   {name: 'PROJECT'})
MERGE (a)-[r:AFFECTS]->(b);

MATCH (a:EVENT {name: '글로벌 물류 지원 업무협약'}),
      (b:_UNSPEC   {name: 'CONCEPT'})
MERGE (a)-[r:AFFECTS]->(b);

MATCH (a:PERSON {name: '엘리스그룹'}),
      (b:AGREEMENT   {name: '엘리스그룹-파인디 업무 협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:PERSON {name: '파인디'}),
      (b:AGREEMENT   {name: '엘리스그룹-파인디 업무 협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:PERSON {name: '김재원'}),
      (b:PERSON   {name: '엘리스그룹'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '대표'
  ON MATCH  SET r.position = '대표';

MATCH (a:_UNSPEC {name: '야마다 유이치로'}),
      (b:PERSON   {name: '파인디'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '대표'
  ON MATCH  SET r.position = '대표';

MATCH (a:PERSON {name: '엘리스그룹'}),
      (b:PERSON   {name: '파인디'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '상호 협력', r.date = '2023-04-14'
  ON MATCH  SET r.type = '상호 협력', r.date = '2023-04-14';

MATCH (a:PERSON {name: '엘리스그룹'}),
      (b:_UNSPEC   {name: 'INDUSTRY'})
MERGE (a)-[r:EXPANDS_INTO]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:PERSON {name: '엘리스그룹'}),
      (b:_UNSPEC   {name: 'TECHNOLOGY'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:COMPANY   {name: '롯데웰푸드'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '상생 협력', r.date = '2023-03'
  ON MATCH  SET r.type = '상생 협력', r.date = '2023-03';

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:AGREEMENT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:AGREEMENT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:PARTICIPATED_IN]->(b);

MATCH (a:PERSON {name: '박성효'}),
      (b:ORGANIZATION   {name: '소상공인시장진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장'
  ON MATCH  SET r.position = '이사장';

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PRODUCT   {name: '식사이론'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:AGREEMENT {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'}),
      (b:AGREEMENT   {name: '백년가게·소공인과 롯데웰푸드의 협력'})
MERGE (a)-[r:FOLLOW_UP_OF]->(b);

MATCH (a:ORGANIZATION {name: '사람인'}),
      (b:CONCEPT   {name: '인생 이모작'})
MERGE (a)-[r:CONDUCTED]->(b);

MATCH (a:PERSON {name: '김혜미'}),
      (b:CONCEPT   {name: '인생 이모작'})
MERGE (a)-[r:REPORTED]->(b);

MATCH (a:COMPANY {name: '엠투아이'}),
      (b:COMPANY   {name: '벰로보틱스'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '공동 개발', r.date = '2023-04-14'
  ON MATCH  SET r.type = '공동 개발', r.date = '2023-04-14';

MATCH (a:COMPANY {name: '엠투아이'}),
      (b:AGREEMENT   {name: '로봇 제어기 공동 개발 및 물류로봇 프로젝트 협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:COMPANY {name: '벰로보틱스'}),
      (b:AGREEMENT   {name: '로봇 제어기 공동 개발 및 물류로봇 프로젝트 협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:COMPANY {name: '엠투아이'}),
      (b:INVESTMENT   {name: '엠투아이의 벰로보틱스 지분 투자'})
MERGE (a)-[r:MADE_INVESTMENT]->(b);

MATCH (a:COMPANY {name: '엠투아이'}),
      (b:TECHNOLOGY   {name: '디지털전환(DX) 솔루션'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '엠투아이'}),
      (b:TECHNOLOGY   {name: 'AI 자율 제조'})
MERGE (a)-[r:FOCUSES_ON]->(b);

MATCH (a:COMPANY {name: '엠투아이'}),
      (b:PROJECT   {name: '물류로봇(AMR/AGV) 프로젝트'})
MERGE (a)-[r:PARTICIPATED_IN]->(b);

MATCH (a:COMPANY {name: '벰로보틱스'}),
      (b:PROJECT   {name: '물류로봇(AMR/AGV) 프로젝트'})
MERGE (a)-[r:PARTICIPATED_IN]->(b);

MATCH (a:COMPANY {name: '엠투아이'}),
      (b:TECHNOLOGY   {name: '로봇 제어기'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '벰로보틱스'}),
      (b:TECHNOLOGY   {name: '로봇 제어기'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '신일전자'}),
      (b:PRODUCT   {name: 'BLDC 에어 서큘레이터 S10 SE'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: 'GS홈쇼핑'}),
      (b:EVENT   {name: 'GS홈쇼핑 성유리 에디션 방송'})
MERGE (a)-[r:HELD]->(b);

MATCH (a:PERSON {name: '김혜미'}),
      (b:EVENT   {name: 'GS홈쇼핑 성유리 에디션 방송'})
MERGE (a)-[r:REPORTED]->(b);

MATCH (a:PERSON {name: '윤승현'}),
      (b:PERSON   {name: '에이드로'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '대표'
  ON MATCH  SET r.position = '대표';

MATCH (a:PERSON {name: '에이드로'}),
      (b:PRODUCT   {name: '바디킷'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:PERSON {name: '에이드로'}),
      (b:TECHNOLOGY   {name: '전산유체역학'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PERSON {name: '에이드로'}),
      (b:_UNSPEC   {name: '테슬라'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '바디킷 판매'
  ON MATCH  SET r.type = '바디킷 판매';

MATCH (a:PERSON {name: '에이드로'}),
      (b:COMPANY   {name: '현대'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '바디킷 판매'
  ON MATCH  SET r.type = '바디킷 판매';

MATCH (a:PERSON {name: '에이드로'}),
      (b:COMPANY   {name: '기아'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '바디킷 판매'
  ON MATCH  SET r.type = '바디킷 판매';

MATCH (a:PERSON {name: '에이드로'}),
      (b:COMPANY   {name: 'BMW'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '바디킷 판매'
  ON MATCH  SET r.type = '바디킷 판매';

MATCH (a:PERSON {name: '에이드로'}),
      (b:PRODUCT   {name: 'AOS'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PERSON {name: '에이드로'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPANDS_TO]->(b)
  ON CREATE SET r.purpose = '시장 확장'
  ON MATCH  SET r.purpose = '시장 확장';

MATCH (a:PERSON {name: '에이드로'}),
      (b:LOCATION   {name: '독일'})
MERGE (a)-[r:EXPANDS_TO]->(b)
  ON CREATE SET r.purpose = '시장 확장'
  ON MATCH  SET r.purpose = '시장 확장';

MATCH (a:PERSON {name: '에이드로'}),
      (b:LOCATION   {name: '일본'})
MERGE (a)-[r:EXPANDS_TO]->(b)
  ON CREATE SET r.purpose = '시장 확장'
  ON MATCH  SET r.purpose = '시장 확장';

MATCH (a:PERSON {name: '에이드로'}),
      (b:LOCATION   {name: '말레이시아'})
MERGE (a)-[r:EXPANDS_TO]->(b)
  ON CREATE SET r.purpose = '시장 확장'
  ON MATCH  SET r.purpose = '시장 확장';

MATCH (a:PERSON {name: '에이드로'}),
      (b:LOCATION   {name: '싱가포르'})
MERGE (a)-[r:EXPANDS_TO]->(b)
  ON CREATE SET r.purpose = '시장 확장'
  ON MATCH  SET r.purpose = '시장 확장';

MATCH (a:PERSON {name: '에이드로'}),
      (b:LOCATION   {name: '영국'})
MERGE (a)-[r:EXPANDS_TO]->(b)
  ON CREATE SET r.purpose = '시장 확장'
  ON MATCH  SET r.purpose = '시장 확장';

MATCH (a:PERSON {name: '에이드로'}),
      (b:LOCATION   {name: '태국'})
MERGE (a)-[r:EXPANDS_TO]->(b)
  ON CREATE SET r.purpose = '시장 확장'
  ON MATCH  SET r.purpose = '시장 확장';

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:COMPANY   {name: '롯데웰푸드'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '상생 협력', r.date = '2023-03'
  ON MATCH  SET r.type = '상생 협력', r.date = '2023-03';

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:PROJECT   {name: '백년가게·백년소공인 상생프로젝트'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PROJECT   {name: '백년가게·백년소공인 상생프로젝트'})
MERGE (a)-[r:PARTICIPATED_IN]->(b);

MATCH (a:PERSON {name: '박성효'}),
      (b:ORGANIZATION   {name: '소상공인시장진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장'
  ON MATCH  SET r.position = '이사장';

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PRODUCT   {name: 'HMR'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PERSON {name: '센드버드'}),
      (b:PRODUCT   {name: '옴니프레젠트 AI 에이전트'})
MERGE (a)-[r:LAUNCHED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:PERSON {name: '센드버드'}),
      (b:INDUSTRY   {name: '커머스'})
MERGE (a)-[r:EXPANDS_INTO]->(b);

MATCH (a:PERSON {name: '센드버드'}),
      (b:INDUSTRY   {name: '핀테크'})
MERGE (a)-[r:EXPANDS_INTO]->(b);

MATCH (a:PERSON {name: '센드버드'}),
      (b:INDUSTRY   {name: '리테일'})
MERGE (a)-[r:EXPANDS_INTO]->(b);

MATCH (a:PERSON {name: '김동신'}),
      (b:PERSON   {name: '센드버드'})
MERGE (a)-[r:CEO_OF]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업부'}),
      (b:MARKET   {name: '중소기업 수출 시장'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14', r.description = '2025년도 1분기 중소기업 수출 동향 발표'
  ON MATCH  SET r.date = '2023-04-14', r.description = '2025년도 1분기 중소기업 수출 동향 발표';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1840000000 달러', r.growth_rate = '+19.6%', r.increase_rate = '19.6%'
  ON MATCH  SET r.amount = '1840000000 달러', r.growth_rate = '+19.6%', r.increase_rate = '19.6%';

MATCH (a:PRODUCT {name: '자동차'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1740000000 달러', r.growth_rate = '+67.4%', r.increase_rate = '67.4%'
  ON MATCH  SET r.amount = '1740000000 달러', r.growth_rate = '+67.4%', r.increase_rate = '67.4%';

MATCH (a:PRODUCT {name: '철강 제품'}),
      (b:EVENT   {name: '미국 관세 부과'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '수출 감소', r.percentage = '-17.8%'
  ON MATCH  SET r.impact = '수출 감소', r.percentage = '-17.8%';

MATCH (a:PRODUCT {name: '알루미늄 제품'}),
      (b:EVENT   {name: '미국 관세 부과'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '수출 감소', r.percentage = '-7.6%'
  ON MATCH  SET r.impact = '수출 감소', r.percentage = '-7.6%';

MATCH (a:PERSON {name: '이순배'}),
      (b:ORGANIZATION   {name: '중소벤처기업부'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '글로벌성장정책관', r.since = ''
  ON MATCH  SET r.position = '글로벌성장정책관', r.since = '';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '중국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '일본'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '홍콩'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '대만'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '태국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '인도네시아'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '베트남'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '감소세'
  ON MATCH  SET r.growth_rate = '감소세';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '인도'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '감소세'
  ON MATCH  SET r.growth_rate = '감소세';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '멕시코'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '감소세'
  ON MATCH  SET r.growth_rate = '감소세';

MATCH (a:ORGANIZATION {name: '경기도'}),
      (b:EVENT   {name: '찾아가는 산업재해 예방 교육'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:ORGANIZATION {name: '고용노동부'}),
      (b:EVENT   {name: '찾아가는 산업재해 예방 교육'})
MERGE (a)-[r:PROVIDED_STATISTICS]->(b)
  ON CREATE SET r.date = '2023'
  ON MATCH  SET r.date = '2023';

MATCH (a:ORGANIZATION {name: '직업건강간호협회 직업건강안전연구소'}),
      (b:EVENT   {name: '찾아가는 산업재해 예방 교육'})
MERGE (a)-[r:MANAGES]->(b);

MATCH (a:PERSON {name: '임용규'}),
      (b:ORGANIZATION   {name: '경기도'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '노동안전과장'
  ON MATCH  SET r.position = '노동안전과장';

MATCH (a:PERSON {name: '엔씽'}),
      (b:PROJECT   {name: '물류센터형 수직농장 스마트팜 개발'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PROJECT {name: '물류센터형 수직농장 스마트팜 개발'}),
      (b:LOCATION   {name: '경기도 이천'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:PERSON {name: '엔씽'}),
      (b:COMPANY   {name: '이마트'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '협업', r.date = '2023'
  ON MATCH  SET r.type = '협업', r.date = '2023';

MATCH (a:PERSON {name: '엔씽'}),
      (b:COMPANY   {name: '배달의민족'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '협업', r.date = '2023'
  ON MATCH  SET r.type = '협업', r.date = '2023';

MATCH (a:PERSON {name: '엔씽'}),
      (b:TECHNOLOGY   {name: '큐브(CUBE)'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:TECHNOLOGY {name: '큐브(CUBE)'}),
      (b:EVENT   {name: 'CES 2020'})
MERGE (a)-[r:AWARDED_AT]->(b)
  ON CREATE SET r.award = '최고혁신상'
  ON MATCH  SET r.award = '최고혁신상';

MATCH (a:PERSON {name: '엔씽'}),
      (b:TECHNOLOGY   {name: 'IoT 기반 환경 제어 기술'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PERSON {name: '엔씽'}),
      (b:PRODUCT   {name: '레터스류, 허브류, 어린잎 채소, 새싹채소'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:PERSON {name: '김혜연'}),
      (b:PERSON   {name: '엔씽'})
MERGE (a)-[r:CEO_OF]->(b)
  ON CREATE SET r.since = ''
  ON MATCH  SET r.since = '';

MATCH (a:PERSON {name: '가온아이'}),
      (b:PERSON   {name: '아이서트'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = 'SaaS 개발', r.date = '2023-04-14'
  ON MATCH  SET r.type = 'SaaS 개발', r.date = '2023-04-14';

MATCH (a:PERSON {name: '아이서트'}),
      (b:PRODUCT   {name: '세이프아이서트'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PRODUCT {name: '세이프아이서트'}),
      (b:COMPANY   {name: 'SaaS'})
MERGE (a)-[r:USES]->(b);

MATCH (a:PRODUCT {name: '세이프아이서트'}),
      (b:COMPANY   {name: '한화오션디지털'})
MERGE (a)-[r:IMPLEMENTED_BY]->(b);

MATCH (a:PRODUCT {name: '세이프아이서트'}),
      (b:_UNSPEC   {name: 'LG전자'})
MERGE (a)-[r:IMPLEMENTED_BY]->(b);

MATCH (a:PERSON {name: '조창제'}),
      (b:PERSON   {name: '가온아이'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '대표'
  ON MATCH  SET r.position = '대표';

MATCH (a:PERSON {name: '현수환'}),
      (b:PERSON   {name: '아이서트'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '대표'
  ON MATCH  SET r.position = '대표';

MATCH (a:ORGANIZATION {name: '중소벤처기업부'}),
      (b:EVENT   {name: '미국 관세 조치'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14', r.description = '중소기업 수출 증가 발표'
  ON MATCH  SET r.date = '2023-04-14', r.description = '중소기업 수출 증가 발표';

MATCH (a:PERSON {name: '이순배'}),
      (b:ORGANIZATION   {name: '중소벤처기업부'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '글로벌성장정책관', r.since = ''
  ON MATCH  SET r.position = '글로벌성장정책관', r.since = '';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1840000000 달러', r.growth_rate = '+19.6%', r.increase_rate = '19.6%'
  ON MATCH  SET r.amount = '1840000000 달러', r.growth_rate = '+19.6%', r.increase_rate = '19.6%';

MATCH (a:PRODUCT {name: '자동차'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1740000000 달러', r.growth_rate = '+67.4%', r.increase_rate = '67.4%'
  ON MATCH  SET r.amount = '1740000000 달러', r.growth_rate = '+67.4%', r.increase_rate = '67.4%';

MATCH (a:PRODUCT {name: '반도체 제조용 장비'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.growth_rate = '', r.increase_rate = ''
  ON MATCH  SET r.amount = '', r.growth_rate = '', r.increase_rate = '';

MATCH (a:PRODUCT {name: '철강 제품'}),
      (b:EVENT   {name: '미국 관세 조치'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '수출 감소', r.percentage = '-17.8%'
  ON MATCH  SET r.impact = '수출 감소', r.percentage = '-17.8%';

MATCH (a:PRODUCT {name: '알루미늄 제품'}),
      (b:EVENT   {name: '미국 관세 조치'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '수출 감소', r.percentage = '-7.6%'
  ON MATCH  SET r.impact = '수출 감소', r.percentage = '-7.6%';

MATCH (a:MARKET {name: '중국 제조업 경기'}),
      (b:PRODUCT   {name: '화장품'})
MERGE (a)-[r:AFFECTS]->(b);

MATCH (a:MARKET {name: '중국 제조업 경기'}),
      (b:PRODUCT   {name: '자동차'})
MERGE (a)-[r:AFFECTS]->(b);

MATCH (a:MARKET {name: '중국 제조업 경기'}),
      (b:PRODUCT   {name: '반도체 제조용 장비'})
MERGE (a)-[r:AFFECTS]->(b);

MATCH (a:COMPANY {name: '삼성바이오로직스'}),
      (b:_UNSPEC   {name: '5조원 매출'})
MERGE (a)-[r:TARGETS]->(b)
  ON CREATE SET r.year = '2023'
  ON MATCH  SET r.year = '2023';

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:_UNSPEC   {name: '5조원 매출'})
MERGE (a)-[r:TARGETS]->(b)
  ON CREATE SET r.year = '2023'
  ON MATCH  SET r.year = '2023';

MATCH (a:COMPANY {name: '삼성바이오로직스'}),
      (b:EVENT   {name: '의약품 관세 부과'})
MERGE (a)-[r:AFFECTED_BY]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:EVENT   {name: '의약품 관세 부과'})
MERGE (a)-[r:AFFECTED_BY]->(b);

MATCH (a:COMPANY {name: '삼성바이오로직스'}),
      (b:EVENT   {name: '약가인하 행정명령'})
MERGE (a)-[r:AFFECTED_BY]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:EVENT   {name: '약가인하 행정명령'})
MERGE (a)-[r:AFFECTED_BY]->(b);

MATCH (a:_UNSPEC {name: '도널드 트럼프'}),
      (b:EVENT   {name: '약가인하 행정명령'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-12'
  ON MATCH  SET r.date = '2023-04-12';

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
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTS_TO]->(b)
  ON CREATE SET r.percentage = '91%'
  ON MATCH  SET r.percentage = '91%';

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTS_TO]->(b)
  ON CREATE SET r.percentage = '98.8%'
  ON MATCH  SET r.percentage = '98.8%';

MATCH (a:COMPANY {name: '삼성바이오로직스'}),
      (b:LOCATION   {name: '유럽'})
MERGE (a)-[r:EXPORTS_TO]->(b)
  ON CREATE SET r.percentage = '91%'
  ON MATCH  SET r.percentage = '91%';

MATCH (a:COMPANY {name: '와디즈'}),
      (b:_UNSPEC   {name: '프리미엄 제품 펀딩 증가'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:ORGANIZATION {name: '유로모니터'}),
      (b:REPORT   {name: '2025 글로벌 소비자 트렌드 리포트'})
MERGE (a)-[r:PUBLISHED]->(b);

MATCH (a:PRODUCT {name: '뉴에어론 풀 체어'}),
      (b:COMPANY   {name: '와디즈'})
MERGE (a)-[r:FUNDED_BY]->(b)
  ON CREATE SET r.amount = '540000000 원'
  ON MATCH  SET r.amount = '540000000 원';

MATCH (a:PRODUCT {name: '쿠자 멀티핸들 스텐팬'}),
      (b:COMPANY   {name: '와디즈'})
MERGE (a)-[r:FUNDED_BY]->(b)
  ON CREATE SET r.amount = '210000000 원'
  ON MATCH  SET r.amount = '210000000 원';

MATCH (a:PRODUCT {name: '올리젯 청바지'}),
      (b:COMPANY   {name: '와디즈'})
MERGE (a)-[r:FUNDED_BY]->(b)
  ON CREATE SET r.amount = '93000000 원'
  ON MATCH  SET r.amount = '93000000 원';

MATCH (a:PERSON {name: '황지현'}),
      (b:_UNSPEC   {name: '프리미엄 제품 펀딩 증가'})
MERGE (a)-[r:REPORTED]->(b);

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:COMPANY   {name: '롯데웰푸드'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '상생 프로젝트', r.date = '2023-03'
  ON MATCH  SET r.type = '상생 프로젝트', r.date = '2023-03';

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:AGREEMENT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:AGREEMENT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:PARTICIPATED_IN]->(b);

MATCH (a:PERSON {name: '박성효'}),
      (b:ORGANIZATION   {name: '소상공인시장진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장'
  ON MATCH  SET r.position = '이사장';

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PRODUCT   {name: '식사이론'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:AGREEMENT   {name: '백년가게·소공인과 롯데웰푸드의 협력'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:LOCATION   {name: '스페인'})
MERGE (a)-[r:EXPANDS_TO]->(b)
  ON CREATE SET r.date = '2023-04', r.purpose = '직판 체제 전환'
  ON MATCH  SET r.date = '2023-04', r.purpose = '직판 체제 전환';

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:LOCATION   {name: '포르투갈'})
MERGE (a)-[r:EXPANDS_TO]->(b)
  ON CREATE SET r.date = '2023-04', r.purpose = '직판 체제 전환'
  ON MATCH  SET r.date = '2023-04', r.purpose = '직판 체제 전환';

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
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '입찰', r.date = '2023'
  ON MATCH  SET r.type = '입찰', r.date = '2023';

MATCH (a:PERSON {name: '강석훈'}),
      (b:COMPANY   {name: '셀트리온'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '법인장', r.since = ''
  ON MATCH  SET r.position = '법인장', r.since = '';

MATCH (a:ORGANIZATION {name: '중소벤처기업부'}),
      (b:EVENT   {name: '미국 관세 조치'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14', r.description = '중소기업 수출 증가 발표'
  ON MATCH  SET r.date = '2023-04-14', r.description = '중소기업 수출 증가 발표';

MATCH (a:PERSON {name: '이순배'}),
      (b:ORGANIZATION   {name: '중소벤처기업부'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '글로벌성장정책관', r.since = ''
  ON MATCH  SET r.position = '글로벌성장정책관', r.since = '';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1840000000 달러', r.growth_rate = '+19.6%', r.increase_rate = '19.6%'
  ON MATCH  SET r.amount = '1840000000 달러', r.growth_rate = '+19.6%', r.increase_rate = '19.6%';

MATCH (a:PRODUCT {name: '자동차'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1740000000 달러', r.growth_rate = '+67.4%', r.increase_rate = '67.4%'
  ON MATCH  SET r.amount = '1740000000 달러', r.growth_rate = '+67.4%', r.increase_rate = '67.4%';

MATCH (a:PRODUCT {name: '반도체 제조용 장비'}),
      (b:LOCATION   {name: '중국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.growth_rate = '', r.increase_rate = ''
  ON MATCH  SET r.amount = '', r.growth_rate = '', r.increase_rate = '';

MATCH (a:PRODUCT {name: '철강 제품'}),
      (b:EVENT   {name: '미국 관세 조치'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '수출 감소', r.percentage = '-17.8%'
  ON MATCH  SET r.impact = '수출 감소', r.percentage = '-17.8%';

MATCH (a:PRODUCT {name: '알루미늄 제품'}),
      (b:EVENT   {name: '미국 관세 조치'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '수출 감소', r.percentage = '-7.6%'
  ON MATCH  SET r.impact = '수출 감소', r.percentage = '-7.6%';

MATCH (a:PRODUCT {name: '기타기계류'}),
      (b:MARKET   {name: '글로벌 전기차 캐즘'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '수출 감소', r.percentage = '-47.4%'
  ON MATCH  SET r.impact = '수출 감소', r.percentage = '-47.4%';

MATCH (a:PRODUCT {name: '전자응용기기'}),
      (b:MARKET   {name: '글로벌 전기차 캐즘'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '수출 감소', r.percentage = '-25.6%'
  ON MATCH  SET r.impact = '수출 감소', r.percentage = '-25.6%';

MATCH (a:MARKET {name: '중국 제조업 경기'}),
      (b:PRODUCT   {name: '반도체 제조용 장비'})
MERGE (a)-[r:AFFECTS]->(b);

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:LOCATION   {name: '스페인'})
MERGE (a)-[r:OPERATES_IN]->(b)
  ON CREATE SET r.type = '직판 체제'
  ON MATCH  SET r.type = '직판 체제';

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:LOCATION   {name: '포르투갈'})
MERGE (a)-[r:OPERATES_IN]->(b)
  ON CREATE SET r.type = '직판 체제'
  ON MATCH  SET r.type = '직판 체제';

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:ORGANIZATION   {name: 'CSC'})
MERGE (a)-[r:SUPPLIES]->(b)
  ON CREATE SET r.products = ["트룩시마", "허쥬마"], r.duration = '2023-2029'
  ON MATCH  SET r.products = ["트룩시마", "허쥬마"], r.duration = '2023-2029';

MATCH (a:ORGANIZATION {name: 'CSC'}),
      (b:LOCATION   {name: '카탈루냐주'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:PERSON {name: '강석훈'}),
      (b:COMPANY   {name: '셀트리온'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '법인장'
  ON MATCH  SET r.position = '법인장';

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
MERGE (a)-[r:PLANS_TO_PRODUCE]->(b);

MATCH (a:ORGANIZATION {name: '기술보증기금 지식재산공제센터'}),
      (b:AGREEMENT   {name: '지식재산공제사업 활성화를 통한 공동발전 업무 협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '인천지식재산센터'}),
      (b:AGREEMENT   {name: '지식재산공제사업 활성화를 통한 공동발전 업무 협약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '기술보증기금 지식재산공제센터'}),
      (b:ORGANIZATION   {name: '인천지식재산센터'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '공동발전', r.date = '2023-04-14'
  ON MATCH  SET r.type = '공동발전', r.date = '2023-04-14';

MATCH (a:ORGANIZATION {name: '기술보증기금 지식재산공제센터'}),
      (b:PROJECT   {name: '지식재산공제사업'})
MERGE (a)-[r:LEADS]->(b);

MATCH (a:ORGANIZATION {name: '특허청'}),
      (b:ORGANIZATION   {name: '기술보증기금 지식재산공제센터'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '지식재산 금융제도 도입', r.date = '2019'
  ON MATCH  SET r.type = '지식재산 금융제도 도입', r.date = '2019';

MATCH (a:ORGANIZATION {name: '인천지식재산센터'}),
      (b:LOCATION   {name: '인천'})
MERGE (a)-[r:LOCATED_IN]->(b);

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

MATCH (a:PERSON {name: '정일산업'}),
      (b:MARKET   {name: '건설경기'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '매출 감소'
  ON MATCH  SET r.impact = '매출 감소';

MATCH (a:PERSON {name: '조주현'}),
      (b:ORGANIZATION   {name: '중소벤처기업연구원'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '원장'
  ON MATCH  SET r.position = '원장';

MATCH (a:COMPANY {name: '노루그룹'}),
      (b:EVENT   {name: '2025 신기술·신제품 전시회'})
MERGE (a)-[r:HELD]->(b);

MATCH (a:PERSON {name: '방양국'}),
      (b:COMPANY   {name: '노루그룹'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '연구소장'
  ON MATCH  SET r.position = '연구소장';

MATCH (a:EVENT {name: '2025 신기술·신제품 전시회'}),
      (b:LOCATION   {name: '안양'})
MERGE (a)-[r:HELD_IN]->(b);

MATCH (a:COMPANY {name: '노루그룹'}),
      (b:TECHNOLOGY   {name: '스텔스 도료'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '노루그룹'}),
      (b:TECHNOLOGY   {name: '우레탄 난연 몰딩제'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '노루그룹'}),
      (b:TECHNOLOGY   {name: '탄소 저감 건재용 도료'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '노루그룹'}),
      (b:TECHNOLOGY   {name: 'VOC 저감형 아크릴 수지'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:PERSON {name: '박미경'}),
      (b:ORGANIZATION   {name: '하이서울기업협회'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '제7대 협회장'
  ON MATCH  SET r.position = '제7대 협회장';

MATCH (a:PERSON {name: '박미경'}),
      (b:COMPANY   {name: '포시에스'})
MERGE (a)-[r:CEO_OF]->(b);

MATCH (a:ORGANIZATION {name: '하이서울기업협회'}),
      (b:LOCATION   {name: '서울'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:COMPANY {name: '포시에스'}),
      (b:LOCATION   {name: '서울'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:COMPANY {name: '포시에스'}),
      (b:LOCATION   {name: '일본'})
MERGE (a)-[r:EXPANDS_TO]->(b);

MATCH (a:COMPANY {name: '포시에스'}),
      (b:LOCATION   {name: '베트남'})
MERGE (a)-[r:EXPANDS_TO]->(b);

MATCH (a:COMPANY {name: '포시에스'}),
      (b:LOCATION   {name: '대만'})
MERGE (a)-[r:EXPANDS_TO]->(b);

MATCH (a:COMPANY {name: '포시에스'}),
      (b:LOCATION   {name: '인도네시아'})
MERGE (a)-[r:EXPANDS_TO]->(b);

MATCH (a:ORGANIZATION {name: '하이서울기업협회'}),
      (b:CONCEPT   {name: 'AI'})
MERGE (a)-[r:FOCUSES_ON]->(b);

MATCH (a:ORGANIZATION {name: '하이서울기업협회'}),
      (b:CONCEPT   {name: '하이서울 프렌즈'})
MERGE (a)-[r:USES]->(b)
  ON CREATE SET r.purpose = '수출 확대'
  ON MATCH  SET r.purpose = '수출 확대';

MATCH (a:PERSON {name: '패스트파이브'}),
      (b:PRODUCT   {name: '파이브클라우드'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:PERSON {name: '패스트파이브'}),
      (b:PRODUCT   {name: '인테리어코드'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:PRODUCT {name: '파이브클라우드'}),
      (b:ORGANIZATION   {name: '아마존웹서비스'})
MERGE (a)-[r:PARTNERED_WITH]->(b);

MATCH (a:PRODUCT {name: '파이브클라우드'}),
      (b:_UNSPEC   {name: '구글'})
MERGE (a)-[r:PARTNERED_WITH]->(b);

MATCH (a:PRODUCT {name: '파이브클라우드'}),
      (b:ORGANIZATION   {name: '마이크로소프트365'})
MERGE (a)-[r:PARTNERED_WITH]->(b);

MATCH (a:PRODUCT {name: '파이브클라우드'}),
      (b:EVENT   {name: 'AWS 어드밴스드 티어 파트너 자격 취득'})
MERGE (a)-[r:AWARDED_AT]->(b);

MATCH (a:PRODUCT {name: '파이브클라우드'}),
      (b:EVENT   {name: 'AWS 한국파트너리그 수상'})
MERGE (a)-[r:AWARDED_AT]->(b);

MATCH (a:PERSON {name: '김대일'}),
      (b:PERSON   {name: '패스트파이브'})
MERGE (a)-[r:CEO_OF]->(b);

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:COMPANY   {name: '롯데웰푸드'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '상생 협력', r.date = '2023-03'
  ON MATCH  SET r.type = '상생 협력', r.date = '2023-03';

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:AGREEMENT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:AGREEMENT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:PARTICIPATED_IN]->(b);

MATCH (a:PERSON {name: '박성효'}),
      (b:ORGANIZATION   {name: '소상공인시장진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장'
  ON MATCH  SET r.position = '이사장';

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PRODUCT   {name: '식사이론'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:AGREEMENT {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'}),
      (b:AGREEMENT   {name: '백년가게·소공인과 롯데웰푸드의 협력'})
MERGE (a)-[r:FOLLOW_UP_OF]->(b);

MATCH (a:ORGANIZATION {name: '중소벤처기업부'}),
      (b:EVENT   {name: '1분기 중소기업 수출 동향 발표'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1840000000 달러', r.growth_rate = '+19.6%', r.increase_rate = '19.6%'
  ON MATCH  SET r.amount = '1840000000 달러', r.growth_rate = '+19.6%', r.increase_rate = '19.6%';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '중국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '일본'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '홍콩'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '대만'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '태국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '인도네시아'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '자동차'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1740000000 달러', r.growth_rate = '+67.4%', r.increase_rate = '67.4%'
  ON MATCH  SET r.amount = '1740000000 달러', r.growth_rate = '+67.4%', r.increase_rate = '67.4%';

MATCH (a:PRODUCT {name: '철강 제품'}),
      (b:EVENT   {name: '1분기 중소기업 수출 동향 발표'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '수출 감소', r.percentage = '-17.8%'
  ON MATCH  SET r.impact = '수출 감소', r.percentage = '-17.8%';

MATCH (a:PRODUCT {name: '알루미늄 제품'}),
      (b:EVENT   {name: '1분기 중소기업 수출 동향 발표'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '수출 감소', r.percentage = '-7.6%'
  ON MATCH  SET r.impact = '수출 감소', r.percentage = '-7.6%';

MATCH (a:PERSON {name: '이순배'}),
      (b:ORGANIZATION   {name: '중소벤처기업부'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '글로벌성장정책관', r.since = ''
  ON MATCH  SET r.position = '글로벌성장정책관', r.since = '';

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
      (b:COMPANY   {name: '셀트리온제약'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = 'Product Distribution', r.date = '2022'
  ON MATCH  SET r.type = 'Product Distribution', r.date = '2022';

MATCH (a:COMPANY {name: '보령'}),
      (b:_UNSPEC   {name: '케이캡 공동판매 계약'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:COMPANY {name: '삼성바이오로직스'}),
      (b:_UNSPEC   {name: 'INDUSTRY'})
MERGE (a)-[r:EXPANDS_INTO]->(b)
  ON CREATE SET r.date = '2023-10-14'
  ON MATCH  SET r.date = '2023-10-14';

MATCH (a:COMPANY {name: '셀트리온'}),
      (b:_UNSPEC   {name: 'INDUSTRY'})
MERGE (a)-[r:EXPANDS_INTO]->(b)
  ON CREATE SET r.date = '2023-10-14'
  ON MATCH  SET r.date = '2023-10-14';

MATCH (a:COMPANY {name: '유한양행'}),
      (b:_UNSPEC   {name: 'INDUSTRY'})
MERGE (a)-[r:EXPANDS_INTO]->(b)
  ON CREATE SET r.date = '2023-10-14'
  ON MATCH  SET r.date = '2023-10-14';

MATCH (a:COMPANY {name: 'GC녹십자'}),
      (b:_UNSPEC   {name: 'INDUSTRY'})
MERGE (a)-[r:EXPANDS_INTO]->(b)
  ON CREATE SET r.date = '2023-10-14'
  ON MATCH  SET r.date = '2023-10-14';

MATCH (a:COMPANY {name: '대웅제약'}),
      (b:_UNSPEC   {name: 'INDUSTRY'})
MERGE (a)-[r:EXPANDS_INTO]->(b)
  ON CREATE SET r.date = '2023-10-14'
  ON MATCH  SET r.date = '2023-10-14';

MATCH (a:PERSON {name: '김동선'}),
      (b:COMPANY   {name: '한화세미텍'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '부사장'
  ON MATCH  SET r.position = '부사장';

MATCH (a:PERSON {name: '곽동신'}),
      (b:PERSON   {name: '한미반도체'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '회장'
  ON MATCH  SET r.position = '회장';

MATCH (a:COMPANY {name: '한화세미텍'}),
      (b:PERSON   {name: '한미반도체'})
MERGE (a)-[r:COMPETES_WITH]->(b)
  ON CREATE SET r.market = 'TC 본더'
  ON MATCH  SET r.market = 'TC 본더';

MATCH (a:COMPANY {name: '한화세미텍'}),
      (b:COMPANY   {name: 'SK하이닉스'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '공급 계약', r.date = '2023-03'
  ON MATCH  SET r.type = '공급 계약', r.date = '2023-03';

MATCH (a:PERSON {name: '한미반도체'}),
      (b:COMPANY   {name: 'SK하이닉스'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '공동 개발', r.date = '2017'
  ON MATCH  SET r.type = '공동 개발', r.date = '2017';

MATCH (a:COMPANY {name: '한화세미텍'}),
      (b:INVESTMENT   {name: 'R&D 투자'})
MERGE (a)-[r:INVESTED_IN]->(b);

MATCH (a:PERSON {name: '한미반도체'}),
      (b:LEGAL   {name: '특허 침해 소송'})
MERGE (a)-[r:FILED]->(b);

MATCH (a:COMPANY {name: '한화세미텍'}),
      (b:PRODUCT   {name: 'TC 본더'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:PERSON {name: '한미반도체'}),
      (b:PRODUCT   {name: 'TC 본더'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '락앤락'}),
      (b:PRODUCT   {name: '풀히트 푸드워머'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:PERSON {name: '류난영'}),
      (b:PRODUCT   {name: '풀히트 푸드워머'})
MERGE (a)-[r:REPORTED]->(b);

MATCH (a:COMPANY {name: '락앤락'}),
      (b:EVENT   {name: '제품 출시 기념 프로모션'})
MERGE (a)-[r:HELD]->(b);

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:COMPANY   {name: '롯데웰푸드'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '상생 협력', r.date = '2023-03'
  ON MATCH  SET r.type = '상생 협력', r.date = '2023-03';

MATCH (a:ORGANIZATION {name: '소상공인시장진흥공단'}),
      (b:AGREEMENT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:AGREEMENT   {name: '2025 백년가게·백년소공인X롯데웰푸드 상생 프로젝트'})
MERGE (a)-[r:PARTICIPATED_IN]->(b);

MATCH (a:PERSON {name: '박성효'}),
      (b:ORGANIZATION   {name: '소상공인시장진흥공단'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '이사장'
  ON MATCH  SET r.position = '이사장';

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:PRODUCT   {name: '식사이론'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '롯데웰푸드'}),
      (b:AGREEMENT   {name: '백년가게·소공인과 롯데웰푸드의 협력'})
MERGE (a)-[r:SIGNED]->(b);

MATCH (a:ORGANIZATION {name: '동반성장위원회'}),
      (b:EVENT   {name: '2025 경기도 동반성장 페어'})
MERGE (a)-[r:HELD]->(b);

MATCH (a:ORGANIZATION {name: '경기도'}),
      (b:ORGANIZATION   {name: '동반성장위원회'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '상생협력', r.date = '2023-04-13'
  ON MATCH  SET r.type = '상생협력', r.date = '2023-04-13';

MATCH (a:EVENT {name: '2025 경기도 동반성장 페어'}),
      (b:LOCATION   {name: '수원메쎄 1홀'})
MERGE (a)-[r:HELD_IN]->(b);

MATCH (a:_UNSPEC {name: '네이버'}),
      (b:EVENT   {name: '2025 경기도 동반성장 페어'})
MERGE (a)-[r:PARTICIPATED_IN]->(b)
  ON CREATE SET r.role = '구매방침 설명회'
  ON MATCH  SET r.role = '구매방침 설명회';

MATCH (a:ORGANIZATION {name: '현대모비스'}),
      (b:EVENT   {name: '2025 경기도 동반성장 페어'})
MERGE (a)-[r:PARTICIPATED_IN]->(b)
  ON CREATE SET r.role = '구매방침 설명회'
  ON MATCH  SET r.role = '구매방침 설명회';

MATCH (a:ORGANIZATION {name: '대상'}),
      (b:EVENT   {name: '2025 경기도 동반성장 페어'})
MERGE (a)-[r:PARTICIPATED_IN]->(b)
  ON CREATE SET r.role = '구매방침 설명회'
  ON MATCH  SET r.role = '구매방침 설명회';

MATCH (a:PERSON {name: '이달곤'}),
      (b:EVENT   {name: '2025 경기도 동반성장 페어'})
MERGE (a)-[r:SPOKE_AT]->(b)
  ON CREATE SET r.topic = '중소기업 지원과 지역 경제 성장'
  ON MATCH  SET r.topic = '중소기업 지원과 지역 경제 성장';

MATCH (a:ORGANIZATION {name: '경기도'}),
      (b:PROJECT   {name: '제2차 경기도 공정경제 5개년 기본계획'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04'
  ON MATCH  SET r.date = '2023-04';

MATCH (a:ORGANIZATION {name: '중소벤처기업부'}),
      (b:_UNSPEC   {name: '중소기업 수출 5개 분기째 증가'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14', r.description = '중소기업 수출 증가 발표'
  ON MATCH  SET r.date = '2023-04-14', r.description = '중소기업 수출 증가 발표';

MATCH (a:PERSON {name: '이순배'}),
      (b:ORGANIZATION   {name: '중소벤처기업부'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '글로벌성장정책관', r.since = ''
  ON MATCH  SET r.position = '글로벌성장정책관', r.since = '';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1840000000 달러', r.growth_rate = '+19.6%', r.increase_rate = '19.6%'
  ON MATCH  SET r.amount = '1840000000 달러', r.growth_rate = '+19.6%', r.increase_rate = '19.6%';

MATCH (a:PRODUCT {name: '자동차'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1740000000 달러', r.growth_rate = '+67.4%', r.increase_rate = '67.4%'
  ON MATCH  SET r.amount = '1740000000 달러', r.growth_rate = '+67.4%', r.increase_rate = '67.4%';

MATCH (a:PRODUCT {name: '반도체 제조용 장비'}),
      (b:LOCATION   {name: '중국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '', r.date = '2023-01-01 to 2023-03-31'
  ON MATCH  SET r.amount = '', r.date = '2023-01-01 to 2023-03-31';

MATCH (a:PRODUCT {name: '철강 제품'}),
      (b:EVENT   {name: '미국의 철강·알루미늄 관세 조치'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '수출 감소', r.percentage = '-17.8%'
  ON MATCH  SET r.impact = '수출 감소', r.percentage = '-17.8%';

MATCH (a:PRODUCT {name: '알루미늄 제품'}),
      (b:EVENT   {name: '미국의 철강·알루미늄 관세 조치'})
MERGE (a)-[r:AFFECTED_BY]->(b)
  ON CREATE SET r.impact = '수출 감소', r.percentage = '-7.6%'
  ON MATCH  SET r.impact = '수출 감소', r.percentage = '-7.6%';

MATCH (a:ORGANIZATION {name: '중소벤처기업부'}),
      (b:EVENT   {name: '2025년도 1분기 중소기업 수출 동향 발표'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1840000000 달러', r.growth_rate = '+19.6%', r.increase_rate = '19.6%'
  ON MATCH  SET r.amount = '1840000000 달러', r.growth_rate = '+19.6%', r.increase_rate = '19.6%';

MATCH (a:PRODUCT {name: '자동차'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '1740000000 달러', r.growth_rate = '+67.4%', r.increase_rate = '67.4%'
  ON MATCH  SET r.amount = '1740000000 달러', r.growth_rate = '+67.4%', r.increase_rate = '67.4%';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '중국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '일본'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '홍콩'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '대만'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '태국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '인도네시아'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '두 자릿수 증가율'
  ON MATCH  SET r.growth_rate = '두 자릿수 증가율';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '베트남'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '감소세'
  ON MATCH  SET r.growth_rate = '감소세';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '인도'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '감소세'
  ON MATCH  SET r.growth_rate = '감소세';

MATCH (a:PRODUCT {name: '화장품'}),
      (b:LOCATION   {name: '멕시코'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '감소세'
  ON MATCH  SET r.growth_rate = '감소세';

MATCH (a:PERSON {name: '이순배'}),
      (b:ORGANIZATION   {name: '중소벤처기업부'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '글로벌성장정책관'
  ON MATCH  SET r.position = '글로벌성장정책관';

MATCH (a:PRODUCT {name: '기타기계류'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '16000000 달러', r.growth_rate = '-47.4%'
  ON MATCH  SET r.amount = '16000000 달러', r.growth_rate = '-47.4%';

MATCH (a:PRODUCT {name: '전자응용기기'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.amount = '13000000 달러', r.growth_rate = '-25.6%'
  ON MATCH  SET r.amount = '13000000 달러', r.growth_rate = '-25.6%';

MATCH (a:PRODUCT {name: '철강 제품'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '-17.8%'
  ON MATCH  SET r.growth_rate = '-17.8%';

MATCH (a:PRODUCT {name: '알루미늄 제품'}),
      (b:LOCATION   {name: '미국'})
MERGE (a)-[r:EXPORTED_TO]->(b)
  ON CREATE SET r.growth_rate = '-7.6%'
  ON MATCH  SET r.growth_rate = '-7.6%';

MATCH (a:COMPANY {name: '파세코'}),
      (b:LOCATION   {name: '안산'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:PERSON {name: '김상우'}),
      (b:COMPANY   {name: '파세코'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '리테일사업부 상무'
  ON MATCH  SET r.position = '리테일사업부 상무';

MATCH (a:PERSON {name: '박치호'}),
      (b:COMPANY   {name: '파세코'})
MERGE (a)-[r:WORKS_FOR]->(b)
  ON CREATE SET r.position = '기술연구소 팀장'
  ON MATCH  SET r.position = '기술연구소 팀장';

MATCH (a:COMPANY {name: '파세코'}),
      (b:PRODUCT   {name: '창문형 에어컨'})
MERGE (a)-[r:PRODUCES]->(b);

MATCH (a:COMPANY {name: '파세코'}),
      (b:TECHNOLOGY   {name: 'AI 에너지 세이빙'})
MERGE (a)-[r:DEVELOPS]->(b);

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:COMPANY   {name: '현대백화점그룹'})
MERGE (a)-[r:PART_OF]->(b)
  ON CREATE SET r.date = '2021'
  ON MATCH  SET r.date = '2021';

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:ORGANIZATION   {name: '한국중소벤처기업유통원'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '지원사업', r.date = '2023'
  ON MATCH  SET r.type = '지원사업', r.date = '2023';

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:EVENT   {name: '소상공인 온라인쇼핑몰 판매지원사업'})
MERGE (a)-[r:CONDUCTED]->(b);

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:ORGANIZATION   {name: '경기도'})
MERGE (a)-[r:LOCATED_IN]->(b);

MATCH (a:COMPANY {name: '현대이지웰'}),
      (b:_UNSPEC   {name: 'MARKET'})
MERGE (a)-[r:EXPANDS_INTO]->(b)
  ON CREATE SET r.date = '2021'
  ON MATCH  SET r.date = '2021';

MATCH (a:COMPANY {name: '한국서부발전'}),
      (b:PROJECT   {name: '발전정보 활용 창업·벤처기업 협업사업'})
MERGE (a)-[r:ANNOUNCED]->(b)
  ON CREATE SET r.date = '2023-04-14'
  ON MATCH  SET r.date = '2023-04-14';

MATCH (a:COMPANY {name: '한국서부발전'}),
      (b:ORGANIZATION   {name: '창업·벤처기업'})
MERGE (a)-[r:PARTNERED_WITH]->(b)
  ON CREATE SET r.type = '지원사업', r.date = '2023'
  ON MATCH  SET r.type = '지원사업', r.date = '2023';

MATCH (a:COMPANY {name: '한국서부발전'}),
      (b:INVESTMENT   {name: '지원금'})
MERGE (a)-[r:MADE_INVESTMENT]->(b);

MATCH (a:COMPANY {name: '한국서부발전'}),
      (b:EVENT   {name: '해외 실증 지원사업'})
MERGE (a)-[r:HELD]->(b);