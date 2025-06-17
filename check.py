#!/usr/bin/env python3
"""
Neo4j 데이터베이스 진단 및 복구 스크립트
"""

import os
import json
from pathlib import Path
from neo4j import GraphDatabase
from dotenv import load_dotenv

load_dotenv()

# Neo4j 연결 설정
NEO4J_URI = os.getenv("NEO4J_URI", "bolt://localhost:7687")
NEO4J_USERNAME = os.getenv("NEO4J_USERNAME", "neo4j")
NEO4J_PASSWORD = os.getenv("NEO4J_PASSWORD", "password")

def connect_neo4j():
    """Neo4j 연결"""
    try:
        driver = GraphDatabase.driver(NEO4J_URI, auth=(NEO4J_USERNAME, NEO4J_PASSWORD))
        return driver
    except Exception as e:
        print(f"❌ Neo4j 연결 실패: {e}")
        return None

def diagnose_database(driver):
    """데이터베이스 상태 진단"""
    print("🔍 Neo4j 데이터베이스 진단 시작\n")
    
    with driver.session() as session:
        try:
            # 1. 전체 노드 수 확인
            result = session.run("MATCH (n) RETURN count(n) as total_nodes")
            total_nodes = result.single()["total_nodes"]
            print(f"📊 총 노드 수: {total_nodes}")
            
            if total_nodes == 0:
                print("⚠️ 데이터베이스가 비어있습니다!")
                return False
            
            # 2. 노드 레이블 분포 확인
            result = session.run("MATCH (n) RETURN DISTINCT labels(n) as labels, count(n) as count ORDER BY count DESC")
            print("\n📋 노드 레이블 분포:")
            for record in result:
                labels = record["labels"]
                count = record["count"]
                print(f"   {labels}: {count}개")
            
            # 3. 속성 확인
            result = session.run("MATCH (n) RETURN DISTINCT keys(n) as properties LIMIT 10")
            all_properties = set()
            for record in result:
                all_properties.update(record["properties"])
            
            print(f"\n🔑 발견된 속성들: {list(all_properties)}")
            
            # 4. name 속성을 가진 노드 확인
            result = session.run("MATCH (n) WHERE n.name IS NOT NULL RETURN count(n) as nodes_with_name")
            nodes_with_name = result.single()["nodes_with_name"]
            print(f"📝 'name' 속성을 가진 노드: {nodes_with_name}개")
            
            if nodes_with_name == 0:
                print("⚠️ 'name' 속성을 가진 노드가 없습니다!")
                
                # 샘플 노드 확인
                result = session.run("MATCH (n) RETURN n LIMIT 3")
                print("\n🔍 샘플 노드들:")
                for i, record in enumerate(result, 1):
                    node = record["n"]
                    print(f"   노드 {i}: {dict(node)}")
                
                return False
            
            # 5. 관계 확인
            result = session.run("MATCH ()-[r]->() RETURN count(r) as total_relations")
            total_relations = result.single()["total_relations"]
            print(f"🔗 총 관계 수: {total_relations}")
            
            # 6. 관계 타입 분포
            result = session.run("MATCH ()-[r]->() RETURN type(r) as rel_type, count(r) as count ORDER BY count DESC LIMIT 10")
            print("\n🔗 관계 타입 분포 (상위 10개):")
            for record in result:
                rel_type = record["rel_type"]
                count = record["count"]
                print(f"   {rel_type}: {count}개")
            
            # 7. 특정 이름 검색
            test_names = ["김상우", "삼성", "구글", "네이버"]
            print(f"\n🔍 테스트 이름 검색:")
            for name in test_names:
                result = session.run("MATCH (n) WHERE n.name CONTAINS $name RETURN count(n) as count", name=name)
                count = result.single()["count"]
                if count > 0:
                    print(f"   '{name}' 포함: {count}개")
                    # 실제 노드 확인
                    result = session.run("MATCH (n) WHERE n.name CONTAINS $name RETURN n.name as name LIMIT 3", name=name)
                    for record in result:
                        print(f"     - {record['name']}")
            
            return True
            
        except Exception as e:
            print(f"❌ 진단 중 오류: {e}")
            return False

def check_data_files():
    """데이터 파일 존재 확인"""
    print("\n📁 데이터 파일 확인:")
    
    output_root = Path(os.getenv("OUTPUT_ROOT", "output"))
    
    # 1. Cypher 파일 확인
    cypher_file = output_root / "graph.cypher"
    if cypher_file.exists():
        size_kb = cypher_file.stat().st_size / 1024
        print(f"   ✅ graph.cypher: {size_kb:.1f}KB")
        
        # Cypher 파일 내용 샘플 확인
        content = cypher_file.read_text(encoding="utf-8")
        lines = content.split('\n')
        merge_lines = [line for line in lines if 'MERGE' in line.upper()]
        print(f"   📄 MERGE 구문: {len(merge_lines)}개")
        
        if merge_lines:
            print("   📋 샘플 MERGE 구문:")
            for i, line in enumerate(merge_lines[:3], 1):
                print(f"      {i}. {line.strip()[:80]}...")
    else:
        print("   ❌ graph.cypher 파일이 없습니다!")
    
    # 2. 결과 JSON 파일 확인
    result_file = output_root / "result" / "result.json"
    if result_file.exists():
        size_kb = result_file.stat().st_size / 1024
        print(f"   ✅ result.json: {size_kb:.1f}KB")
        
        with open(result_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
            nodes = data.get('nodes', [])
            relations = data.get('relations', [])
            print(f"   📊 JSON 노드: {len(nodes)}개")
            print(f"   📊 JSON 관계: {len(relations)}개")
            
            if nodes:
                print("   📋 샘플 노드:")
                for i, node in enumerate(nodes[:3], 1):
                    print(f"      {i}. {node.get('label', 'NO_LABEL')}: {node.get('name', 'NO_NAME')}")
    else:
        print("   ❌ result.json 파일이 없습니다!")

def reload_data_to_neo4j(driver):
    """데이터를 Neo4j에 다시 로드"""
    print("\n🔄 데이터 다시 로드 시작...")
    
    output_root = Path(os.getenv("OUTPUT_ROOT", "output"))
    cypher_file = output_root / "graph.cypher"
    
    if not cypher_file.exists():
        print("❌ Cypher 파일이 없어서 로드할 수 없습니다.")
        print("   먼저 파이프라인을 실행하여 데이터를 생성하세요:")
        print("   python main.py --purpose '기업판매'")
        return False
    
    try:
        # 기존 데이터 삭제 (선택사항)
        response = input("기존 데이터를 삭제하고 새로 로드하시겠습니까? (y/N): ")
        if response.lower() == 'y':
            with driver.session() as session:
                session.run("MATCH (n) DETACH DELETE n")
                print("✅ 기존 데이터 삭제 완료")
        
        # Cypher 파일 실행
        content = cypher_file.read_text(encoding="utf-8")
        statements = [stmt.strip() for stmt in content.split('\n\n') if stmt.strip()]
        
        print(f"📄 {len(statements)}개 구문 실행 중...")
        
        with driver.session() as session:
            success_count = 0
            for i, statement in enumerate(statements):
                try:
                    if statement.strip():
                        session.run(statement)
                        success_count += 1
                        if (i + 1) % 50 == 0:
                            print(f"   진행률: {i + 1}/{len(statements)}")
                except Exception as e:
                    print(f"   ⚠️ 구문 실행 실패 ({i+1}): {str(e)[:100]}...")
            
            print(f"✅ 데이터 로드 완료: {success_count}/{len(statements)} 성공")
            return True
            
    except Exception as e:
        print(f"❌ 데이터 로드 실패: {e}")
        return False

def create_sample_data(driver):
    """샘플 데이터 생성 (테스트용)"""
    print("\n🧪 샘플 데이터 생성...")
    
    sample_statements = [
        "CREATE CONSTRAINT IF NOT EXISTS FOR (n:PERSON) REQUIRE n.name IS UNIQUE;",
        "CREATE CONSTRAINT IF NOT EXISTS FOR (n:COMPANY) REQUIRE n.name IS UNIQUE;",
        "MERGE (p:PERSON {name: '김상우'}) SET p.role = '개발자';",
        "MERGE (c:COMPANY {name: '삼성전자'}) SET c.industry = '전자';",
        "MERGE (c2:COMPANY {name: '구글'}) SET c2.industry = '기술';",
        "MATCH (p:PERSON {name: '김상우'}), (c:COMPANY {name: '삼성전자'}) MERGE (p)-[:WORKS_FOR]->(c);",
        "MATCH (c1:COMPANY {name: '삼성전자'}), (c2:COMPANY {name: '구글'}) MERGE (c1)-[:PARTNERED_WITH]->(c2);"
    ]
    
    try:
        with driver.session() as session:
            for statement in sample_statements:
                session.run(statement)
        
        print("✅ 샘플 데이터 생성 완료")
        
        # 생성된 데이터 확인
        with driver.session() as session:
            result = session.run("MATCH (n) RETURN count(n) as count")
            count = result.single()["count"]
            print(f"📊 생성된 노드 수: {count}")
            
        return True
        
    except Exception as e:
        print(f"❌ 샘플 데이터 생성 실패: {e}")
        return False

def main():
    """메인 실행 함수"""
    print("🔧 Neo4j 데이터베이스 진단 및 복구 도구\n")
    
    # 1. Neo4j 연결
    driver = connect_neo4j()
    if not driver:
        return
    
    try:
        # 2. 데이터 파일 확인
        check_data_files()
        
        # 3. 데이터베이스 진단
        db_ok = diagnose_database(driver)
        
        if not db_ok:
            print("\n🚨 데이터베이스에 문제가 있습니다!")
            
            # 옵션 제공
            print("\n해결 옵션:")
            print("1. 기존 Cypher 파일로 데이터 다시 로드")
            print("2. 테스트용 샘플 데이터 생성")
            print("3. 파이프라인 다시 실행 (권장)")
            
            choice = input("\n선택하세요 (1/2/3): ")
            
            if choice == "1":
                reload_data_to_neo4j(driver)
            elif choice == "2":
                create_sample_data(driver)
            elif choice == "3":
                print("\n다음 명령어를 실행하세요:")
                print("python main.py --purpose '기업판매'")
            
            # 재진단
            print("\n🔍 재진단 중...")
            diagnose_database(driver)
        else:
            print("\n✅ 데이터베이스가 정상 상태입니다!")
    
    finally:
        driver.close()

if __name__ == "__main__":
    main()