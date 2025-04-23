CREATE (:Dataset {description: 'synthetic dataset for financial AI learning', source: 'internal data from financial institutions', name: '금융 합성 데이터셋'});

CREATE (:Partner {partnerType: 'System Integration', areaOfCollaboration: 'Joint Sales in AI Marketing', name: 'Large System Integrator'});

CREATE (:SalesChannel {channel_description: 'IT 계열사가 계약의 주체.', name: '고객사 IT 계열사와 계약'});

CREATE (:Product {description: '제품 개발', version: '1.1', technology: 'Kerberos, Keycloak, oAuth, Ansible, Kubernetes, Impala', productType: 'Software', capabilities: 'Single Sign On, laC 도구, 시스템 이벤트 알림, GPU 모니터링', features: '보안 강화, 관리/운영 기능 강화, 신규 기능 추가', name: 'SmartAI v1.1'});

CREATE (:Module {description: 'onCMS 용 추천 모델 관리 기능 개발, Auto 타겟팅 모듈 적용, AI 기반 AB 테스트 모듈 개발', name: '마케팅 AI 모듈'});

CREATE (:Product {description: '마케팅 자동화 및 실시간 마케팅 솔루션', technology: 'AI, 빅데이터, 클라우드', productType: 'CRM 소프트웨어', capabilities: '고객 맞춤형 마케팅 및 업무 효율성 향상', name: 'AI 기반 CRM 소프트웨어'});

CREATE (:SalesChannel {channel_description: '고객사와 직접 계약 진행.', name: '고객사와 직접 계약'});

CREATE (:SoftwareSolution {solution_type: 'BI platform', features: 'automatic report generation, conversation interaction', name: 'Data Intelligence'});

CREATE (:Product {description: '데이터, 분석, 마케팅, AI 통합 플랫폼', features: '데이터 수집, 통합, 분석, AI 적용, 마케팅 자동화', productType: 'Platform', capabilities: '데이터 흐름 최적화, 다양한 데이터 작업 구성', name: 'End-to-End 고객 데이터 및 경험 관리 플랫폼 CDXP+'});

CREATE (:Product {description: '모델 배포 기술 개발', features: 'REST API 기반 container wrapping, AutoScaling, 자원 사용량 모니터링', technology: 'Kubernetes, REST API', productType: 'Software', capabilities: '실시간 모델 예측, 트래픽 대응', name: 'Kubernetes 기반 실시간 Model Serving 기술'});

CREATE (:SalesStrategy {strategy_description: 'Explaining new features and technologies of the company\'s new marketing product to induce upgrade repurchase; introducing data and AI products if issues are related to data processing and AI analysis', name: 'Upgrade Sales Strategy'});

CREATE (:SoftwareSolution {solution_type: 'Customer Data Integration and Behavior Data Visualization', features: 'real-time behavior data collection, App/Web log integration, offline data mash-up, ML-based customer conversion and churn prediction', name: 'Obzen Analytics'});

CREATE (:SoftwareSolution {solution_type: 'data collection tool', features: 'customer behavior tracking', name: 'TagManager'});

CREATE (:Partner {partnerType: 'Consulting', areaOfCollaboration: 'Joint sales, new product development, and consulting projects', name: 'Global Consulting Firm'});

CREATE (:Industry {characteristics: 'Leading companies as clients, market-leading requirements.', sector: 'Finance', name: 'Finance and Distribution'});

CREATE (:Technology {description: 'Big Data and AI technology for data-driven customer experiences.', category: 'Data Technology', name: 'Big Data and AI'});

CREATE (:ProductCategory {sales_2021: 1246, share_2021: '6.20%', sales_2022: 1485, share_2022: '5.73%', sales_2023: 1563, share_2023: '9.20%', name: '기술비'});

CREATE (:SoftwareSolution {solution_type: 'On-Premise and SaaS', features: 'Data refinement technology, personalized recommendation, customer behavior prediction, synthetic data algorithm.', name: 'CRM Solutions'});

CREATE (:ResearchLab {focusArea: 'marketing, sales management, CRM and data-related product development', name: 'Digital LAB'});

CREATE (:Product {description: 'Pre-defined 표준화 마케팅 솔루션 개발', features: '표준 데이터 모델 기반, 산업별 표준화된 기능과 컨텐츠', productType: 'Software', capabilities: '중견기업 대상 솔루션, 데이터 작업 최소화', name: 'obzen Daisy Suite'});

CREATE (:ResearchLab {focusArea: 'AI-related product development', name: 'AI LAB'});

CREATE (:Company {companyName: 'Our Company', industry: 'Technology', businessScope: 'Marketing, AI, Financial Solutions', name: 'Our Company'});

CREATE (:Product {description: 'recommends products to customers', features: 'customer interaction, preference calculation', technology: 'AI algorithm, deep learning', productType: 'recommendation model', capabilities: 'similarity-based, preference-based recommendations', name: 'AI 상품추천모델'});

CREATE (:ResearchActivity {topic: 'Sales SaaS development', details: 'development of a B2B sales supporting system in SaaS form, customer and information management', name: 'Development of OSC'});

CREATE (:Platform {type: 'Cloud', description: 'Cloud 버전 개발의 PoC 단계, NaverCloudPlatform 환경에서 laaS 기반 개발 환경 구축', name: 'SmartAl Cloud'});

CREATE (:Partner {partnerType: 'Big Tech', areaOfCollaboration: 'Collaboration for expanding Total Addressable Market and overseas expansion.', name: 'Domestic Big Tech Companies'});

CREATE (:Company {companyName: 'Obzen', description: 'specializes in digital and AI-related product development', business_domain: 'technology', industry: 'technology', name: 'Obzen'});

MATCH (a), (b)
WHERE a.name = 'Global Consulting Firm' AND b.name = 'Upgrade Sales Strategy'
CREATE (a)-[:JOINT_PROJECT {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'SmartAI v1.1' AND b.name = 'Kubernetes'
CREATE (a)-[:LEVERAGES {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'Our Company' AND b.name = 'Large System Integrator'
CREATE (a)-[:HAS_PARTNER {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'Digital LAB' AND b.name = 'CDXP+'
CREATE (a)-[:DEVELOPS_PRODUCT {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'CRM 전문 기업' AND b.name = 'Domestic Big Tech Companies'
CREATE (a)-[:HAS_PARTNER {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'SmartAI v1.1' AND b.name = 'SmartAl Cloud'
CREATE (a)-[:DEPLOYED_ON {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'CRM 전문 기업' AND b.name = 'Finance and Distribution'
CREATE (a)-[:TARGETS_MARKET {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'TagManager' AND b.name = 'AI 상품추천모델'
CREATE (a)-[:HAS_FEATURE {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'Our Company' AND b.name = 'Global Consulting Firm'
CREATE (a)-[:HAS_PARTNER {name: a.name + '<->' + b.name}]->(b);

MATCH (a), (b)
WHERE a.name = 'Digital LAB' AND b.name = 'Development of OSC'
CREATE (a)-[:CONDUCTS {name: a.name + '<->' + b.name}]->(b);