package user;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mail.SendMail;
import util.Function;

@Service
public class UserService {

	@Autowired
	private UserDao uDao;
	
	// 총갯수와 총페이지수를 구하는 메서드
	public int[] getRowPageCount(UserVo vo) {
		int totCount = uDao.count(vo); // 총갯수
		// 총페이지 수 = 총갯수/페이지당갯수, 만약 총갯수에서 페이지당갯수로 나눈 나머지가 있으면 +1
		int totPage = totCount / vo.getPageRow();
		if (totCount % vo.getPageRow() > 0) totPage++;
		
		// 목록하단에 노출되는 페이지 범위 구하기
		// 시작페이지값 = (사용자가요청한페이지-1)/페이지당갯수*페이지당갯수+1
		int startpage = (vo.getReqPage()-1)/vo.getPageRow()*vo.getPageRow()+1;
		// 마지막페이지값 = 시작페이지-1+페이지당갯수
		int endpage = startpage-1+vo.getPageRow();
		if (endpage > totPage) endpage = totPage;
		
		int[] rowPageCount = new int[4];
		rowPageCount[0] = totCount;
		rowPageCount[1] = totPage;
		rowPageCount[2] = startpage;
		rowPageCount[3] = endpage;
		return rowPageCount;
	}
	
	// 목록을 구하는 메서드
	public List<UserVo> getList(UserVo vo) {
		// limit 시작값 = (사용자가 요청한 페이지번호 - 1) * 페이지당갯수
		//int startIdx = (vo.getReqPage() - 1) * vo.getPageRow();
		vo.setStartIdx((vo.getReqPage() - 1) * vo.getPageRow());
		return uDao.selectList(vo);
	}
	
	public UserVo selectOne(UserVo uv) {
		return uDao.selectOne(uv);
	}
	
	public boolean isDuplicateId(String id) {
		int cnt = uDao.isDuplicateId(id);
		if (cnt == 0) {
			return false;
		} else {
			return true;
		}
	}
	
	public boolean insert(UserVo vo) {
		int r = uDao.insert(vo);
		if (r > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean update(UserVo vo) {
		int r = uDao.update(vo);
		if (r > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean delete(UserVo vo) {
		int r = uDao.delete(vo);
		if (r > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public UserVo login(UserVo vo) {
		return uDao.login(vo);
	}
	
	public int idcheck(UserVo param) throws SQLException {
		return uDao.idcheck(param);
	}
	
	public UserVo searchId(UserVo vo) throws SQLException {
		return uDao.searchId(vo);
	}
	
	public int tempPwd(UserVo vo) throws SQLException {
		int cnt = uDao.update(vo);
		return cnt;
	}
	
	public boolean searchPwd(UserVo param) throws Exception {
		boolean success = false;
		UserVo vo = uDao.searchpwd(param);
		if (vo == null) {
			success = false;
		} else {
			success = true;
			String tmpPwd = Function.randomNumber("");
			param.setUser_pwd(tmpPwd);
			uDao.updatePwd(param);
			SendMail.sendEmail("humans13@naver.com", vo.getUser_email(), "비밀번호 찾기 서비스입니다.", "회원님의 임시 비밀번호는  "+tmpPwd+"입니다.");
		}
		return success;
	}

	
	
	
}
