CREATE (:Product {description: 'recommends products to customers', technology: 'AI algorithm, deep learning', productType: 'recommendation model', features: 'customer interaction, preference calculation', capabilities: 'similarity-based, preference-based recommendations', name: 'AI 상품추천모델'});

CREATE (:Partner {partnerType: 'System Integration', areaOfCollaboration: 'Joint Sales in AI Marketing', name: 'Large System Integrator'});

CREATE (:Product {description: 'Pre-defined, standardized marketing solution development', features: 'Based on standard data models, industry-specific standardized features and content', productType: 'Software', capabilities: 'Solutions for medium-sized enterprises, minimizes data work', name: 'Obzen Daisy Suite'});

CREATE (:Product {description: '데이터, 분석, 마케팅, AI 통합 플랫폼', features: '데이터 수집, 통합, 분석, AI 적용, 마케팅 자동화', productType: 'Platform', capabilities: '데이터 흐름 최적화, 다양한 데이터 작업 구성', name: 'End-to-End 고객 데이터 및 경험 관리 플랫폼 CDXP+'});

CREATE (:ResearchLab {focusArea: 'marketing, sales management, CRM and data-related product development', name: 'Digital LAB'});

CREATE (:Partner {partnerType: 'Consulting', areaOfCollaboration: 'Joint sales, new product development, and consulting projects', name: 'Global Consulting Firm'});

CREATE (:SoftwareSolution {solution_type: 'Customer Data Integration and Behavior Data Visualization', features: 'real-time behavior data collection, App/Web log integration, offline data mash-up, ML-based customer conversion and churn prediction', name: 'Obzen Analytics'});

CREATE (:Partner {partnerType: 'Big Tech', areaOfCollaboration: 'Collaboration for expanding Total Addressable Market and overseas expansion.', name: 'Domestic Big Tech Companies'});

CREATE (:Product {description: '모델 배포 기술 개발', technology: 'Kubernetes, REST API', features: 'REST API 기반 container wrapping, AutoScaling, 자원 사용량 모니터링', productType: 'Software', capabilities: '실시간 모델 예측, 트래픽 대응', name: 'Kubernetes 기반 실시간 Model Serving 기술'});

CREATE (:Platform {type: 'Cloud', description: 'Cloud 버전 개발의 PoC 단계, NaverCloudPlatform 환경에서 laaS 기반 개발 환경 구축', name: 'SmartAl Cloud'});

CREATE (:Module {description: 'onCMS 용 추천 모델 관리 기능 개발, Auto 타겟팅 모듈 적용, AI 기반 AB 테스트 모듈 개발', name: '마케팅 AI 모듈'});

CREATE (:Company {industry: 'Technology', businessScope: 'Marketing, AI, Financial Solutions', companyName: 'Our Company', name: 'Our Company'});

CREATE (:ResearchLab {focusArea: 'AI-related product development', name: 'AI LAB'});

CREATE (:Company {companyName: 'Obzen', description: 'specializes in digital and AI-related product development', business_domain: 'technology', industry: 'technology', name: 'Obzen'});

CREATE (:Product {description: '마케팅 자동화 및 실시간 마케팅 솔루션', technology: 'AI, 빅데이터, 클라우드', capabilities: '고객 맞춤형 마케팅 및 업무 효율성 향상', productType: 'CRM 소프트웨어', name: 'AI 기반 CRM 소프트웨어'});

CREATE (:Technology {description: 'Big Data and AI technology for data-driven customer experiences.', category: 'Data Technology', name: 'Big Data and AI'});

CREATE (:SalesChannel {channel_description: 'IT 계열사가 계약의 주체.', name: '고객사 IT 계열사와 계약'});

CREATE (:SoftwareSolution {solution_type: 'data collection tool', features: 'customer behavior tracking', name: 'TagManager'});

CREATE (:ProductCategory {sales_2021: 1246, share_2021: '6.20%', sales_2022: 1485, share_2022: '5.73%', sales_2023: 1563, share_2023: '9.20%', name: '기술비'});

CREATE (:Product {version: '1.1', technology: 'Kerberos, Keycloak, oAuth, Ansible, Kubernetes, Impala', features: '보안 강화, 관리/운영 기능 강화, 신규 기능 추가', description: '제품 개발', productType: 'Software', capabilities: 'Single Sign On, laC 도구, 시스템 이벤트 알림, GPU 모니터링', name: 'SmartAI v1.1'});

CREATE (:ResearchActivity {topic: 'Sales SaaS development', details: 'development of a B2B sales supporting system in SaaS form, customer and information management', name: 'Development of OSC'});

CREATE (:Industry {characteristics: 'Leading companies as clients, market-leading requirements.', sector: 'Finance', name: 'Finance and Distribution'});

CREATE (:SalesStrategy {strategy_description: 'Explaining new features and technologies of the company\'s new marketing product to induce upgrade repurchase; introducing data and AI products if issues are related to data processing and AI analysis', name: 'Upgrade Sales Strategy'});

CREATE (:SoftwareSolution {solution_type: 'BI platform', features: 'automatic report generation, conversation interaction', name: 'Data Intelligence'});

CREATE (:SoftwareSolution {solution_type: 'On-Premise and SaaS', features: 'Data refinement technology, personalized recommendation, customer behavior prediction, synthetic data algorithm.', name: 'CRM Solutions'});

CREATE (:SalesChannel {channel_description: '고객사와 직접 계약 진행.', name: '고객사와 직접 계약'});

CREATE (:Dataset {description: 'synthetic dataset for financial AI learning', source: 'internal data from financial institutions', name: '금융 합성 데이터셋'});

MATCH (a), (b)
WHERE a.name = 'CRM Solutions' AND b.name = 'Big Data and AI'
CREATE (a)-[:USES_TECHNOLOGY {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'Our Company' AND b.name = 'Domestic Big Tech Companies'
CREATE (a)-[:COLLABORATES_WITH {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'Obzen' AND b.name = 'Obzen Analytics'
CREATE (a)-[:DEVELOPS {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'AI LAB' AND b.name = 'AI 기반 CRM 소프트웨어'
CREATE (a)-[:DEVELOPS {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'Our Company' AND b.name = 'Large System Integrator'
CREATE (a)-[:PARTNERS_WITH {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'Our Company' AND b.name = 'AI 기반 CRM 소프트웨어'
CREATE (a)-[:PROVIDES {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'Kubernetes 기반 실시간 Model Serving 기술' AND b.name = 'Big Data and AI'
CREATE (a)-[:USES_TECHNOLOGY {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'AI LAB' AND b.name = 'SmartAI v1.1'
CREATE (a)-[:RESEARCHES {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'Obzen Analytics' AND b.name = 'TagManager'
CREATE (a)-[:INTEGRATES_WITH {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'AI 상품추천모델' AND b.name = 'Big Data and AI'
CREATE (a)-[:UTILIZES_TECHNOLOGY_FROM {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'Our Company' AND b.name = 'Global Consulting Firm'
CREATE (a)-[:PARTNERS_WITH {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'Our Company' AND b.name = 'AI LAB'
CREATE (a)-[:HAS_RESEARCH_LAB {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'End-to-End 고객 데이터 및 경험 관리 플랫폼 CDXP+' AND b.name = 'Obzen Analytics'
CREATE (a)-[:USES_SOLUTIONS {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'TagManager' AND b.name = 'AI 상품추천모델'
CREATE (a)-[:COLLECTS_DATA_FOR {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'Our Company' AND b.name = '고객사 IT 계열사와 계약'
CREATE (a)-[:USES_SALES_CHANNEL {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'SmartAI v1.1' AND b.name = 'Kubernetes 기반 실시간 Model Serving 기술'
CREATE (a)-[:INTEGRATES_WITH {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'AI LAB' AND b.name = 'Development of OSC'
CREATE (a)-[:ENGAGES_IN {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'Digital LAB' AND b.name = 'End-to-End 고객 데이터 및 경험 관리 플랫폼 CDXP+'
CREATE (a)-[:DEVELOPS {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'Obzen Daisy Suite' AND b.name = 'Obzen'
CREATE (a)-[:IS_PART_OF {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'Our Company' AND b.name = 'Digital LAB'
CREATE (a)-[:HAS_RESEARCH_LAB {name: a.name + '<->' + b.name}]->(b);