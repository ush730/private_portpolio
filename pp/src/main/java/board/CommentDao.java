package board;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommentDao {

	@Autowired
	private SqlSessionTemplate sqlSession;	
	
	public List<CommentVo> selectList(int board_no) {
		List<CommentVo> list = sqlSession.selectList("comment.selectList", board_no);
		return list;
	}
	
	public int insert(CommentVo vo) {
		return sqlSession.insert("comment.insert",vo);
	}
	
	public int delete(int no) {
		return sqlSession.delete("comment.delete", no);
	}	
	
}
