package test;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TestDAO {

	@Autowired 
	private SqlSessionTemplate sqlSession;
	
	public List<TestVO> select(TestVO vo) {
		return sqlSession.selectList("test.select.selectMember", vo);
	}
	
	public int insert(TestVO vo) {
		return sqlSession.insert("test.select.insertMember", vo);
	}

}
