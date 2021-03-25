package reply;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;



@Controller
public class ReplyController {

	@Autowired
	private ReplyService rService;
	
	
	
	@RequestMapping("/portfolio/reply/index.do")
	public String index(HttpServletRequest req, ReplyVo vo) {
		// 서비스(로직) 처리(호출)
		int[] rowPageCount = rService.getRowPageCount(vo);
		List<ReplyVo> list = rService.getList(vo);
		
		// 값 저장
		// totalPage, list, reqPage
		req.setAttribute("totCount", rowPageCount[0]);
		req.setAttribute("totalPage", rowPageCount[1]);
		req.setAttribute("startPage", rowPageCount[2]); // 시작페이지
		req.setAttribute("endPage", rowPageCount[3]); // 마지막페이지
		req.setAttribute("list", list);
		// /board/index.do?reqPage=2 -> BoardVo에 reqPage 필드에 바인딩 (커맨드객체)
		// /board/index.do
		req.setAttribute("reqPage", vo.getReqPage());
		req.setAttribute("vo", vo);
		
		// jsp 포워딩
		return "portfolio/reply/index";
	}
	
	@RequestMapping("/portfolio/reply/myPost.do")
	public String myPost(HttpServletRequest req, ReplyVo vo) {
		// 서비스(로직) 처리(호출)
		int[] rowPageCount = rService.getRowPageCount(vo);
		List<ReplyVo> list = rService.getList(vo);
		
		// 값 저장
		// totalPage, list, reqPage
		req.setAttribute("totCount", rowPageCount[0]);
		req.setAttribute("totalPage", rowPageCount[1]);
		req.setAttribute("startPage", rowPageCount[2]); // 시작페이지
		req.setAttribute("endPage", rowPageCount[3]); // 마지막페이지
		req.setAttribute("list", list);
		// /board/index.do?reqPage=2 -> BoardVo에 reqPage 필드에 바인딩 (커맨드객체)
		// /board/index.do
		req.setAttribute("reqPage", vo.getReqPage());
		req.setAttribute("vo", vo);
		
		// jsp 포워딩
		return "portfolio/reply/myPost";
	}
	
	
	
	@RequestMapping("/portfolio/reply/detail.do")
	public String detail(HttpServletRequest req, ReplyVo vo) {
		
		ReplyVo uv = rService.selectOne(vo);		
		
		req.setAttribute("vo", uv);		
		// jsp 포워딩
		return "portfolio/reply/detail";
	}
	
	@RequestMapping("/portfolio/reply/reply.do")
	public String reply(HttpServletRequest req, ReplyVo vo) {
		
		ReplyVo uv = rService.selectOne(vo);
		
		req.setAttribute("vo", uv);		
		
		// jsp 포워딩
		return "portfolio/reply/reply";
	}
	
	@GetMapping("/portfolio/reply/write.do")
	public String write() {
		return "portfolio/reply/write";
	}
	
	@RequestMapping("/portfolio/reply/insert.do")
	public void insert(ReplyVo vo, HttpServletRequest req, HttpServletResponse res, MultipartFile file) throws Exception {
		
		
		res.setContentType("text/html;charset=utf-8");
		PrintWriter out = res.getWriter();
		out.print("<script>");
		if (rService.insert(vo)) {
			out.print("alert('정상적으로 등록되었습니다.');");
			out.print("location.href='/pp/portfolio/reply/index.do';");
		} else {
			out.print("alert('등록실패.');");
			out.print("history.back();");
		}
		out.print("</script>");
		out.flush();
	}
	
	@RequestMapping("/portfolio/reply/insertReply.do")
	public void insertReply(ReplyVo vo, HttpServletRequest req, HttpServletResponse res, MultipartFile file) throws Exception {
		
		
		res.setContentType("text/html;charset=utf-8");
		PrintWriter out = res.getWriter();
		out.print("<script>");
		if (rService.insertReply(vo)) {
			out.print("alert('정상적으로 답변이 등록되었습니다.');");
			out.print("location.href='/pp/portfolio/reply/index.do';");
		} else {
			out.print("alert('등록실패.');");
			out.print("history.back();");
		}
		out.print("</script>");
		out.flush();
	}
	
	@RequestMapping("/portfolio/reply/edit.do")
	public String edit(HttpServletRequest req, ReplyVo vo) {
		
		ReplyVo uv = rService.selectOne(vo);
		
		req.setAttribute("vo", uv);
		
		// jsp 포워딩
		return "portfolio/reply/edit";
	}
	
	@PostMapping("/portfolio/reply/update.do")
	public void update(ReplyVo vo, HttpServletResponse res, HttpServletRequest req, MultipartFile file) throws IOException {
		
		
		res.setContentType("text/html;charset=utf-8");
		PrintWriter out = res.getWriter();
		out.print("<script>");
		if (rService.update(vo)) {
			out.print("alert('정상적으로 수정되었습니다.');");
			out.print("location.href='/pp/portfolio/reply/detail.do?rep_no="+vo.getRep_no()+"';");
		} else {
			out.print("alert('수정실패.');");
			out.print("history.back();");
		}
		out.print("</script>");
		out.flush();
	}
	
	@GetMapping("/portfolio/reply/delete.do")
	public void delete(ReplyVo vo, HttpServletResponse res) throws IOException {
		res.getWriter().print(rService.delete(vo));
	}
	
	
	
	
	
	
}
