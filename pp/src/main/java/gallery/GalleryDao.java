package gallery;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository
public class GalleryDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int count(GalleryVo vo) {
		return sqlSession.selectOne("gallery.count", vo);
	}
	
	public List<GalleryVo> selectList(GalleryVo vo) {
		return sqlSession.selectList("gallery.selectList", vo);
	}
	
	public GalleryVo selectOne(GalleryVo vo) {
		return sqlSession.selectOne("gallery.selectOne", vo);
	}
	
	public int insert(GalleryVo vo) {
		return sqlSession.insert("gallery.insert",vo);
	}
	
	public int update(GalleryVo vo) {
		return sqlSession.update("gallery.update", vo);
	}
	
	public int delete(GalleryVo vo) {
		return sqlSession.delete("gallery.delete", vo);
	}
	
	public void updateReadcnt(int no) {
		sqlSession.update("gallery.updateReadcnt", no);
	}
}
