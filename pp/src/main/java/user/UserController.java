package user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


public class UserController {
	

		@Autowired
		private UserService uService;
		
		
		@GetMapping("/")
		public String index(HttpSession sess) {
			UserVo uv = new UserVo();
			uv.setUser_no(104);
			uv.setUser_name("test30");
			uv.setUser_id("test30");
			sess.setAttribute("authUser", uv);
			return "redirect:portfolio/user/index.do";
		}
		
		
		
		@RequestMapping("/portfolio/user/index.do")
		public String index(HttpServletRequest req, UserVo vo) {
			// 서비스(로직) 처리(호출)
			int[] rowPageCount = uService.getRowPageCount(vo);
			List<UserVo> list = uService.getList(vo);
			
			// 값 저장
			// totalPage, list, reqPage
			req.setAttribute("totalPage", rowPageCount[1]);
			req.setAttribute("startPage", rowPageCount[2]); // 시작페이지
			req.setAttribute("endPage", rowPageCount[3]); // 마지막페이지
			req.setAttribute("list", list);
			// /user/index.do?reqPage=2 -> UserVo에 reqPage 필드에 바인딩 (커맨드객체)
			// /user/index.do
			req.setAttribute("reqPage", vo.getReqPage());
			req.setAttribute("vo", vo);
			
			// jsp 포워딩
			return "portpolio/user/index";
		}
		
		@RequestMapping("/portfolio/user/detail.do")
		public String detail(HttpServletRequest req, UserVo vo) {
			
			UserVo uv = uService.selectOne(vo);
			
			req.setAttribute("vo", uv);
			
			// jsp 포워딩
			return "user/detail";
		}
		
		@RequestMapping("/portfolio/user/mypage.do")
		public String mypage(HttpServletRequest req, UserVo vo) {
			
			UserVo uv = uService.selectOne(vo);
			
			req.setAttribute("vo", uv);
			
			// jsp 포워딩
			return "portfolio/user/mypage";
		}
		
		@GetMapping("/portfolio/user/write.do")
		public String write(HttpServletRequest req, HttpServletResponse res) {
			
			return "user/write";

		}
		@PostMapping("/portfolio/user/write.do")
		public String write(UserVo vo, HttpServletRequest req, HttpServletResponse res) throws IOException {
			UserVo uv = uService.login(vo);
			// 결과 확인
			if (uv != null) { 
				HttpSession sess = req.getSession();
				// 세션객체에 로그인정보 저장
				sess.setAttribute("authUser", uv);
			}
			return "portfoliouser/index";
			
		}

		@RequestMapping("/portfolio/user/insert.do")
		public void insert(UserVo vo, HttpServletResponse res) throws Exception {
			// 등록처리
			res.getWriter().print(uService.insert(vo));
		}
		
		@RequestMapping(value="/portfolio/user/isDuplicateId.do", method=RequestMethod.GET)
		public void isDuplicateId(HttpServletRequest req, HttpServletResponse res, @RequestParam("id") String userid) throws IOException{
			boolean r = uService.isDuplicateId(userid);
			res.getWriter().print(r);
		}
		
		@RequestMapping("/portfolio/user/edit.do")
		public String edit(HttpServletRequest req, UserVo vo) {
			
			UserVo uv = uService.selectOne(vo);
			
			req.setAttribute("vo", uv);
			
			// jsp 포워딩
			return "portfolio/user/edit";
		}
		
		@PostMapping("/portfolio/user/update.do")
		public void update(UserVo vo, HttpServletResponse res) throws IOException {
			res.getWriter().print(uService.update(vo));
		}
		
		@GetMapping("/portfolio/user/delete.do")
		public void delete(UserVo vo, HttpServletResponse res, HttpSession sess) throws IOException {
			sess.invalidate();
			res.getWriter().print(uService.delete(vo));
		}
		
		// 로그인폼
		@GetMapping("/portfolio/user/login.do")
		public String login() {
			return "user/login";
		}
		
		// 로그인처리
		@PostMapping("/portfolio/user/login.do")
		public String loginProcess(UserVo vo, HttpServletRequest req, HttpServletResponse res) throws IOException {
			/*
			 세션(session) : 브라우저 단위로 저장되는 저장소		 
			 
			 DB에서 아이디 비밀번호로 조회한 결과를 가져오고
			 결과가 있으면(로그인 성공)
			 - 세션에 결과객체를 저장
			 - 목록페이지로 이동
			 결과값 없으면(로그인 실패)
			 - 메시지 처리
			 - 로그인폼으로 이동
			 */
			// 사용자가 입력한 아이디와 비밀번호로 DB에서 조회한 결과
			UserVo uv = uService.login(vo);
			// 결과 확인
			if (uv != null) { 
				// 로그인 성공

				// 세션객체 가져오기
				HttpSession sess = req.getSession();
				// 세션객체에 로그인정보 저장
				sess.setAttribute("authUser", uv);
				req.setAttribute("msg", "로그인 되었습니다.");
				
				// 위 코드와 동일하게
				//req.getSession().setAttribute("authUser", uv);
				String url = "/pp/index.do";
				System.out.println(req.getParameter("url"));
				if (req.getParameter("url") != null && !"".equals(req.getParameter("url"))) {
					url = req.getParameter("url");
					if (req.getParameter("param") != null && !"".equals(req.getParameter("param"))) {
						url += "?"+req.getParameter("param");
					}
				}
				return "redirect: "+url; 
				
			} else { // 로그인 실패
			
				res.setContentType("text/html; charset=utf-8"); // 한글처리
				PrintWriter out = res.getWriter();
				out.print("<script>");
				out.print("alert('아이디와 비밀번호가 올바르지 않습니다.');");
				String url = "/pp/portfolio/user/login.do";
				if (req.getParameter("url") != null && !"".equals(req.getParameter("url"))) {
					url = req.getParameter("url");
					if (req.getParameter("param") != null && !"".equals(req.getParameter("param"))) {
						url += "?"+req.getParameter("param");
					}
				}
				out.print("location.href='"+url+"';");
				out.print("</script>");
				out.flush();
				return null; 
			}
		}
		
		@RequestMapping("/portfolio/user/logout.do")
		public void logout(HttpServletResponse res, HttpSession sess, HttpServletRequest req) throws IOException {
			
			sess.invalidate(); // 세션초기화(모든 세션)
			
			//sess.removeAttribute("authUser"); (authUser만 세션 제거)
			
			res.setContentType("text/html; charset=utf-8"); // 한글처리
			PrintWriter out = res.getWriter();
			out.print("<script>");
			out.print("alert('로그아웃되었습니다.');");
			String url = "/pp/index.do";
			if (req.getParameter("url") != null && !"".equals(req.getParameter("url"))) {
				url = req.getParameter("url"); 
				if (req.getParameter("param") != null && !"".equals(req.getParameter("param"))) {
					url += "?"+req.getParameter("param");
				}
			}
			out.print("location.href='"+url+"';");
			out.print("</script>");
			out.flush();
		}
		
		@RequestMapping("/portfolio/user/idsearch.do")
		public String idsearch(Model model, UserVo param) throws Exception {
			model.addAttribute("vo", param);
			
			return "portfolio/user/idsearch";
		}
		
		@RequestMapping("/portfolio/user/pwdsearch.do")
		public String pwdsearch(Model model, UserVo param) throws Exception {
			model.addAttribute("vo", param);
			
			return "portfolio/user/pwdsearch";
		}
			
		@RequestMapping("/portfolio/user/searchid.do")
		public String searchid (Model model, UserVo param) throws Exception {
			UserVo data = uService.searchId(param);
			String user_id = "";
			if (data != null) {user_id = data.getUser_id();}
			model.addAttribute("value", user_id);
			
			return "include/return";
		}
		
		@RequestMapping("/portfolio/user/searchpwd.do")
		public String searchpwd(Model model, UserVo param) throws Exception {
			boolean success = uService.searchPwd(param);
			
			if (success) {
				model.addAttribute("code", "alertMessageUrl");
				model.addAttribute("message", "임시 비밀번호가 메일로 전달되었습니다.");
				model.addAttribute("url", "pwdsearch.do");
			} else {
				model.addAttribute("code", "alertMessageUrl");
				model.addAttribute("message", "임시 비밀번호 발급에 실패하였습니다.");
				model.addAttribute("url", "pwdsearch.do");
			}
			
			return "include/alert";
		}
		
		@RequestMapping("/portfolio/user/pwdcheck.do")
		public String pwcheck(Model model, UserVo param) throws Exception {
			model.addAttribute("vo", param);
			int value = uService.idcheck(param);
			
			model.addAttribute("value", value);
			
			return "include/return";
		}
		

	}

