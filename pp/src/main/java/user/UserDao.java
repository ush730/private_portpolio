package user;

import java.sql.SQLException;
import java.util.List;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int count(UserVo vo) {
		return sqlSession.selectOne("user.count", vo);
	}
	
	public List<UserVo> selectList(UserVo vo) {
		return sqlSession.selectList("user.selectList", vo);
	}
	
	public UserVo selectOne(UserVo vo) {
		return sqlSession.selectOne("user.selectOne", vo);
	}
	
	public int isDuplicateId(String user_id) {
		return sqlSession.selectOne("user.isDuplicateId", user_id);
	}
	
	public int insert(UserVo vo) {
		return sqlSession.insert("user.insertUser",vo);
	}
	
	public int update(UserVo vo) {
		return sqlSession.update("user.updateUser", vo);
	}
	
	public int delete(UserVo vo) {
		return sqlSession.delete("user.deleteUser", vo);
	}
	
	public UserVo login(UserVo vo) {
		return sqlSession.selectOne("user.login", vo);
	}
	
	public UserVo kakaologin(UserVo vo) {
		return sqlSession.selectOne("user.login", vo);
	}
	
	public UserVo searchId(UserVo vo) throws SQLException {
		return sqlSession.selectOne("user.searchId", vo);
	}
	
	public UserVo searchpwd(UserVo vo) throws SQLException {
		return sqlSession.selectOne("user.searchPwd", vo);
	}
	
	public int idcheck(UserVo param) throws SQLException {
		return sqlSession.selectOne("user.idcheck", param);
	}
	
	public int updatePwd(UserVo vo) throws SQLException {
		return sqlSession.update("user.updatePwd", vo);
	}
	
	
	
}
